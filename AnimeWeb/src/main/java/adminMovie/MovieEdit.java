package adminMovie;

import Log.Log;
import com.mysql.cj.jdbc.JdbcConnection;
import database.DAOMovie;
import database.JDBiConnector;
import model.Account;
import model.AvartarMovie;
import model.Movie;
import services.ImageUpload;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

@MultipartConfig(
        fileSizeThreshold = 102, // Giới hạn tối thiểu là 10kb
        maxFileSize = 1024 * 1024 * 20, // Giới hạn kích thước mỗi file là 10MB
        maxRequestSize = 1024 * 1024 * 100 // Giới hạn kích thước request là 50MB
)
@WebServlet(name = "MovieEdit", value = "/admin/MovieEdit")
public class MovieEdit extends HttpServlet {
    int idMovie;
    HttpSession session;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        idMovie = Integer.parseInt(request.getParameter("idMovie"));
        Movie movieTarget = DAOMovie.getMovieEditById(idMovie);
        request.setAttribute("movieTarget",movieTarget);
        request.setAttribute("genreNotHave",DAOMovie.getMovieGenreNotHave(movieTarget.getGenres()));
        request.setAttribute("listType",DAOMovie.getListTypeMovie());
        request.setAttribute("listProducer",movieTarget.getListProducer());
        request.setAttribute("producerNotHave",DAOMovie.getMovieProducerNotHave(movieTarget.getListProducer()));
        request.getRequestDispatcher("/admin/MovieEdit.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            idMovie  = Integer.parseInt(request.getParameter("idMovie"));
            session = request.getSession();
            HttpSession session = request.getSession();
            Account user = (Account) session.getAttribute("user");
            String ipClient =request.getRemoteAddr();
            Log log = new Log(Log.INFO, user.getId(), ipClient, "MovieEdit", "Chỉnh sửa thông tin phim có id "+idMovie, 1);
            Collection<Part> parts = request.getParts();
            List<Part> listImage = new ArrayList<>();
            List<AvartarMovie> listOldImage = DAOMovie.getAvatarMovie(idMovie);
            for(Part p : parts){
                if(p.getContentType()!=null && p.getContentType().startsWith("image/")){
                    listImage.add(p);
                }
            }
            if(listImage.size()!=5){
                request.setAttribute("error","Phải đủ 5 hình ảnh");
                log.setContent(log.getContent()+" thất bại");
                JDBiConnector.insert(log);
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
                ImageUpload imageUpload = new ImageUpload();
                String[] producersValue = request.getParameterValues("producerPicker")==null?new String[0]:request.getParameterValues("producerPicker");

                DAOMovie.editMovie(idMovie,name,totalEpisode,descriptionVN,descriptionEN,typePicker,price,genresValue,producersValue);
                List<String> savedAvatar = imageUpload.saveEditAvatarMovie(listOldImage,listImage,idMovie,realPath,addExtension);
                DAOMovie.updateAvatarMovie(savedAvatar,idMovie);
                log.setContent(log.getContent()+" thành công");
                JDBiConnector.insert(log);
                response.sendRedirect(getServletContext().getContextPath()+"/admin/MovieList");
            }
        }catch (Exception  e){

        }
    }
}
