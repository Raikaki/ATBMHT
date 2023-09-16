package adminMovie;

import Log.Log;
import database.DAOMovie;
import database.DAOProducer;
import database.DAOSupplier;
import database.JDBiConnector;
import model.Account;
import services.ImageUpload;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "MovieAdd", value = "/admin/MovieAdd")
@MultipartConfig(
        fileSizeThreshold = 102, // Giới hạn tối thiểu là 10kb
        maxFileSize = 1024 * 1024 * 20, // Giới hạn kích thước mỗi file là 10MB
        maxRequestSize = 1024 * 1024 * 100 // Giới hạn kích thước request là 50MB
)
public class MovieAdd extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("listType",DAOMovie.getListTypeMovie());
        request.setAttribute("listGenre", DAOMovie.listGenreHeader());
        request.setAttribute("listProducer", DAOProducer.producersToAddMovie());
        request.setAttribute("listSupplier", DAOSupplier.suppliersToAddMovie());
        request.getRequestDispatcher("/admin/MovieAdd.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            HttpSession session = request.getSession();
            Account user = (Account) session.getAttribute("user");
            String ipClient =request.getRemoteAddr();
            Log log = new Log(Log.INFO, user.getId(), ipClient, "MovieAdd", "Nhập phim mới", 1);
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            Collection<Part> parts = request.getParts();
            List<Part> listImage = new ArrayList<>();
            for(Part p : parts){
                if(p.getContentType()!=null && p.getContentType().startsWith("image/")){
                    listImage.add(p);
                }
            }
            if(listImage.size()!=5){
                request.setAttribute("error","Phải đủ 5 hình ảnh");
                request.getRequestDispatcher("/admin/MovieAdd").forward(request,response);
                return;
            }else{
                String realPath =request.getServletContext().getRealPath("/");
                Date date = new Date();
                String addExtension = String.valueOf(date.getTime());
                String name = request.getParameter("name");
                String totalEpisode = request.getParameter("totalEpisode");
                String descriptionVN = request.getParameter("descriptionVN");
                String descriptionEN = request.getParameter("descriptionEN");
                String price = request.getParameter("price");
                if(price.trim().equalsIgnoreCase("")) price="0";
                String[] genresValue = request.getParameterValues("genreValue")==null?new String[0]:request.getParameterValues("genreValue");
                String typePicker = request.getParameter("typePicker");
                System.out.println(typePicker);
                String[] producersValue = request.getParameterValues("producerPicker")==null?new String[0]:request.getParameterValues("producerPicker");
                String supplier = request.getParameter("supplierPicker");
                String priceImport = request.getParameter("priceImport");
                if(priceImport.trim().equalsIgnoreCase("")) priceImport="0";
                ImageUpload imageUpload = new ImageUpload();
                int savedMovieId= DAOMovie.addMovie(name,totalEpisode,descriptionVN,descriptionEN,typePicker,price,genresValue,producersValue,supplier,priceImport);
                List<String> savedAvatar = imageUpload.saveAvatarMovie(listImage,savedMovieId,realPath,addExtension);
                DAOMovie.updateAvatarMovie(savedAvatar,savedMovieId);
                JDBiConnector.insert(log);
                response.sendRedirect(getServletContext().getContextPath()+"/admin/MovieList");
            }
        }catch (FileNotFoundException e){
            e.printStackTrace();;
        }

    }


    }

