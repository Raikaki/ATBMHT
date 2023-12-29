package walletController;

import Log.Log;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
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
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;

@WebServlet(name = "signature", value = "/anime-main/signature")
public class signature extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       try {
           response.setCharacterEncoding(String.valueOf(StandardCharsets.UTF_8));
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
           PrintWriter out = response.getWriter();

           JsonObject object = new JsonObject();
           Key publicKey = DAOKey.accountKeyNow(user.getId());
           if(publicKey==null){
               object.addProperty("isSuccess",false);
               object.addProperty("message","Người dùng hiện chưa có Key nào đang được áp dụng");
               out.print(object);
               return;
           }
           int id_bill = DAOBills.createBill(user.getId(), billNum, order.getTotalPrice(), movieList,publicKey.getKey());
           Bill bill =  DAOBills.getBillById(id_bill);
           boolean isSign = false;
           try {
               byte[] signData = DSA.signBill(bill.toString(),DSA.verifyPrivateKey(privateKey),DSA.verifyPublicKey(publicKey.getKey()));
               if(!(signData.length>0)){
                   object.addProperty("isSuccess",false);
                   object.addProperty("message","PrivateKey không hợp lệ với PublicKey hiện tại");
                   out.print(object);
                   return;

               }
               isSign = DAOBills.saveSignatureToBill(bill, DSA.toBase64(signData));
           } catch (Exception e) {
               throw new RuntimeException(e);
           }

           if (isSign) {
                session.setAttribute("bill",bill);
                object.addProperty("isSuccess",true);
                out.print(object);
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
