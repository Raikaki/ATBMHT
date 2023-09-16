package adminMovie;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import database.DAOMovie;
import model.ChapterMovie;
import services.VideoUpload;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Date;
import java.util.List;
@MultipartConfig(
        fileSizeThreshold = 102, // Giới hạn tối thiểu là 10kb
        maxFileSize = 1024 * 1024 * 2000, // Giới hạn kích thước mỗi file là 2GB
        maxRequestSize = 1024 * 1024 * 2300 // Giới hạn kích thước request là 2.3GB
)

@WebServlet(name = "ChapterSetting", value = "/admin/ChapterSetting")
public class ChapterSetting extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idMovie = (String)request.getParameter("idMovie");
        List<ChapterMovie> chapterMovies = DAOMovie.getListChapter(idMovie);
        request.setAttribute("idMovie",idMovie);
        request.setAttribute("listChapter",chapterMovies);
        request.getRequestDispatcher("/admin/ChapterSetting.jsp").forward(request,response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String index = request.getParameter("index");
        String opening = request.getParameter("opening");
        Part file = request.getPart("video-upload");
        String idMovie = request.getParameter("idMovie");
        String type = request.getParameter("type");
        String idChapter ;
        Gson gson = new Gson();
        JsonObject object  = new JsonObject();
        try {
            if (file != null && file.getContentType() != null) {
                if (file.getContentType().startsWith("video/")) {
                    if (!index.trim().equalsIgnoreCase("") && !opening.trim().equalsIgnoreCase("")) {

                        boolean checkValidChapter = !type.equalsIgnoreCase("edit") && DAOMovie.isValidChapter(idMovie, index);

                        if (checkValidChapter) {
                            response.sendError(500, "Tập phim đã tồn tại, vui lòng sử dụng chức năng chỉnh sửa để thay đổi video");
                            return;
                        } else {

                            String realPath = request.getServletContext().getRealPath("/");
                            Date date = new Date();
                            String addExtension = String.valueOf(date.getTime());
                            VideoUpload videoUpload = new VideoUpload();

                            String chapterFullPath = videoUpload.fullPathChapter(file, idMovie, index, realPath, addExtension);


                            file.write(chapterFullPath);
                            ChapterMovie updateChapter = null;
                            String chapterSaveData = videoUpload.createSaveChapterMovieData(file, idMovie, index, addExtension);
                            if (type.equalsIgnoreCase("insert")) {
                                updateChapter = DAOMovie.addChapter(idMovie, index, opening, chapterSaveData);
                            }
                            if (type.equalsIgnoreCase("edit")) {
                                idChapter = request.getParameter("idChapter");
                                updateChapter = DAOMovie.updateChapter(idChapter, index, opening, chapterSaveData);

                            }
                            assert updateChapter != null;

                            object.addProperty("chapter", gson.toJson(updateChapter));
                            response.getWriter().print(gson.toJson(object));


                        }
                    } else {
                        response.sendError(500, "Dữ liệu tập phim và opening không được để trống");

                        return;
                    }
                } else {
                    response.sendError(500, "file phải là video");

                    return;
                }
            } else {
                if (type.equalsIgnoreCase("edit")) {
                    idChapter = request.getParameter("idChapter");
                    ChapterMovie updateChapter = DAOMovie.updateChapter(idChapter, index, opening);

                    if (updateChapter != null) {
                        object.addProperty("chapter", gson.toJson(updateChapter));
                        response.getWriter().print(gson.toJson(object));
                        return;
                    }
                }
                response.sendError(500, "sửa thất bại");
                return;
            }
        }catch (Exception e){
            System.out.println("cc");
            response.sendError(500, "sửa thất bại");
        }
    }
}
