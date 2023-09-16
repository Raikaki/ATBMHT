package adminBonus;

import database.DAOBonus;
import model.Bonus;
import model.Movie;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
@WebServlet(name = "SettingBonusMovie", value = "/admin/SettingBonusMovie")
public class SettingBonusMovie extends HttpServlet {
    String idBonus;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            idBonus = request.getParameter("idBonus");
            List<Movie> bonusMovie = DAOBonus.getBonusMovie(idBonus);
            Bonus bonus = DAOBonus.findBonusById(idBonus);
            bonus.setBonusMovie(bonusMovie);
            List<Movie> enableAddMovie = DAOBonus.getEnableMovie(idBonus);
            request.setAttribute("bonus",bonus);
            request.setAttribute("enableAddMovie",enableAddMovie);
            request.getRequestDispatcher("/admin/SettingBonusMovie.jsp").forward(request,response);
    }
}
