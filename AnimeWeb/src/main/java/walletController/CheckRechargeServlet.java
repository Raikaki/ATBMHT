package walletController;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.paypal.core.PayPalEnvironment;
import com.paypal.core.PayPalHttpClient;
import com.paypal.http.HttpResponse;
import com.paypal.orders.Order;
import com.paypal.orders.OrdersCaptureRequest;

import database.DAORecharge;
import model.Account;

@WebServlet(name = "checkRecharge", value = "/anime-main/checkRecharge")
public class CheckRechargeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(request.getInputStream()));
        StringBuilder jsonBuilder = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonBuilder.append(line);
        }
        reader.close();

        String jsonString = jsonBuilder.toString();
        Gson gson = new Gson();
        JsonObject data = gson.fromJson(jsonString, JsonObject.class);
        double selectedValue = data.get("balance").getAsDouble();
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
                DAORecharge daoRecharge = new DAORecharge();
                double balance = user.getBalance();
                String fomat = String.valueOf(selectedValue);
                user.setBalance(balance + (selectedValue * 1));
                daoRecharge.updateBalance(user.getId(), user.getBalance());
                String balanceFluctuations = user.fluctuationsIncreaseBalance(selectedValue);
                daoRecharge.insertBalanceFluctuations(user.getId(), balanceFluctuations, "Nạp tiền từ PayPal",
                        selectedValue * 1);
//                System.out.println();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(new Gson().toJson(capturedOrder));
            }
        } catch (IOException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       doPost(request,response);
    }
}
