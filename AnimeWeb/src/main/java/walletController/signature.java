package walletController;

import Log.Log;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import database.DAOBills;
import database.DAOKey;
import database.DAOMovie;
import database.DAORecharge;
import model.*;
import security.DSA;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;

@WebServlet(name = "signature", value = "/anime-main/signature")
public class signature extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       try {
           HttpSession session = request.getSession();
           Account user = (Account) session.getAttribute("user");
           String ipClient = request.getRemoteAddr();
           String action = request.getParameter("action");
           Order order = (Order) session.getAttribute("order");
           DAORecharge daoRecharge = new DAORecharge();
           Log log = new Log(Log.INFO, -1, ipClient, "checkout", null, 1);
           HashMap<String, WishListDetail> wishlist = (HashMap<String, WishListDetail>) session.getAttribute("wishlist");
           DAOMovie daoMovie = new DAOMovie();
           LocalDateTime now = LocalDateTime.now();
           Gson gson = new GsonBuilder()
                   .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                   .create();

           String privateKey = request.getParameter("fileContent");
           int billNum = (int) session.getAttribute("number");
           List<Movie> movieList = order.getSelectedMovies();
          Key publicKey = DAOKey.accountKeyNow(user.getId());


           int id_bill = DAOBills.createBill(user.getId(), billNum, order.getTotalPrice(), movieList,publicKey.getKey());
           Bill bill =  DAOBills.getBillById(id_bill);
           boolean isSign;
           try {
               isSign = DAOBills.saveSignatureToBill(bill, privateKey);

           } catch (Exception e) {
               throw new RuntimeException(e);
           }
           if (isSign) {
               session.setAttribute("bill",bill);
               response.setContentType("application/json");
               PrintWriter out = response.getWriter();
               out.print(gson.toJson(wishlist));
               out.flush();
           }

       }catch (Exception e){
           e.printStackTrace();
       }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
