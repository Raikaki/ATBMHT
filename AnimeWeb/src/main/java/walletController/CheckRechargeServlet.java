package walletController;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Log.Log;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.paypal.core.PayPalEnvironment;
import com.paypal.core.PayPalHttpClient;
import com.paypal.http.HttpResponse;
import com.paypal.orders.Order;
import com.paypal.orders.OrdersCaptureRequest;

import database.DAOBills;
import database.DAOMovie;
import database.DAORecharge;
import database.JDBiConnector;
import model.*;

@WebServlet(name = "checkRecharge", value = "/anime-main/checkRecharge")
public class CheckRechargeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
        BufferedReader reader = new BufferedReader(new InputStreamReader(request.getInputStream()));
        StringBuilder jsonBuilder = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonBuilder.append(line);
        }
        reader.close();
        model.Bill bill = (Bill) request.getSession().getAttribute("bill");
        String jsonString = jsonBuilder.toString();
        Gson gson = new Gson();
        JsonObject data = gson.fromJson(jsonString, JsonObject.class);
        String orderID = data.get("orderID").getAsString();
        PayPalEnvironment environment = new PayPalEnvironment.Sandbox(
                "AbenXsywXYlbMw4GpzHDSdiXPx7hKY7adwNFIjsSlY7HfsmSRD6DOzeswhhcBtKiqC46A2kiwzyk_Wf7",
                "ELW5ilC1gq8J-C_joXPn9KY6M4nVRclHzFXoR2YQQ0WMe03JldFq0znjtrhbayq6Bn0_1V_IRiUVJHNb");
        PayPalHttpClient client = new PayPalHttpClient(environment);
        OrdersCaptureRequest request1 = new OrdersCaptureRequest(orderID);

        try {
            HttpResponse<Order> response1 = client.execute(request1);
            if (response1.statusCode() == 201) {
                System.out.println(response1.statusCode());
                Order capturedOrder = response1.result();
                HttpSession session = request.getSession();
                Account user = (Account) session.getAttribute("user");
                model.Order order = (model.Order) session.getAttribute("order");
                HashMap<String, WishListDetail> wishlist = (HashMap<String, WishListDetail>) session.getAttribute("wishlist");
                DAOMovie daoMovie = new DAOMovie();
                String captureId = capturedOrder.purchaseUnits().get(0).payments().captures().get(0).id();
                DAOBills.saveCaptureId(bill,captureId);
                for (Movie m : order.getSelectedMovies()) {
                    daoMovie.insertPurchasedMovie(user.getId(), m.getId(), m.getCalPrice(),bill.getId());
                    wishlist.remove(String.valueOf(m.getId()));
                    session.setAttribute("wishlist", wishlist);
                    DAOBills.updateIsPurchased(bill.getId());
                }
                session.removeAttribute("bill");
                session.removeAttribute("order");
                session.setAttribute("success", true);
                session.removeAttribute("done");
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(new Gson().toJson(capturedOrder));
            }
        } catch (IOException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }}catch (Exception ex){
            ex.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
