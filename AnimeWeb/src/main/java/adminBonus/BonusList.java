package adminBonus;

import database.DAOBonus;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "BonusList", value = "/admin/BonusList")
public class BonusList extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            request.setAttribute("listBonus", DAOBonus.getListBonus());
            request.getRequestDispatcher("/admin/BonusList.jsp").forward(request,response);
    }

}
