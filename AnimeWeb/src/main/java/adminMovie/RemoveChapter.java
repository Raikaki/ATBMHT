package adminMovie;

import Log.Log;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import database.DAOMovie;
import database.JDBiConnector;
import model.Account;
import model.ChapterMovie;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.IOException;

@WebServlet(name = "RemoveChapter", value = "/admin/RemoveChapter")
public class RemoveChapter extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{

            String idChapter = request.getParameter("idChapter");
            String realPath = request.getServletContext().getRealPath("/");
            String idMovie = request.getParameter("idMovie");
            System.out.println("idChapter "+idChapter);
            System.out.println("idMovie" +idMovie);
            ChapterMovie chapter = DAOMovie.findChapter(Integer.parseInt(idChapter));
            File chapterFile = new File(realPath+File.separator+chapter.getName());

            chapterFile.delete();


            boolean isSuccess=DAOMovie.removeChapter(idMovie,idChapter);
            System.out.println(isSuccess);
            Gson gson = new Gson();
            HttpSession session = request.getSession();
            Account user = (Account) session.getAttribute("user");
            String ipClient =request.getRemoteAddr();
            Log log = new Log(Log.DANGER, user.getId(), ipClient, "RemoveChapter", "Xóa tập phim có id =" +idChapter, 1);
            if(isSuccess){
                log.setContent(log.getContent()+" thành công");
            }else{
                log.setContent(log.getContent()+" thất bại");
            }
            JDBiConnector.insert(log);
            JsonObject object = new JsonObject();
            object.addProperty("isSuccess",isSuccess);
            response.getWriter().print(gson.toJson(object));
        }catch (Exception e){
            e.printStackTrace();
        }
    }

}
