package wishListController;

import database.DAOMovie;
import model.*;

import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "wishListAction", value = "/anime-main/wishListAction")
public class wishListAction extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        Order order = (Order) session.getAttribute("order");
        double totalPrice = (double) session.getAttribute("totalPrice");
            String id = request.getParameter("movieId");

            if (id != null) {

                order.getSelectedMovies().removeIf(movie -> movie.getId() == Integer.parseInt(id));
                totalPrice -=  DAOMovie.getMoviebyId(Integer.parseInt(id)).getCalPrice();
                session.setAttribute("order",order);
                session.setAttribute("totalPrice",totalPrice);
                request.getRequestDispatcher("/anime-main/checkout.jsp").forward(request,response);
                }
            }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request,response);
    }
}
