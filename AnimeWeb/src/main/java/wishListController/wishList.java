package wishListController;

import model.Account;

import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "wishList", value = "/anime-main/wishList")
public class wishList extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

            HttpSession session = request.getSession();
            session.removeAttribute("fail");
            Account user = (Account) session.getAttribute("user");
            if (user == null) {
                request.getRequestDispatcher("/anime-main/login.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/anime-main/wish-list.jsp").forward(request, response);
            }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
