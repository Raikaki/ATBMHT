package walletController;

import com.google.gson.Gson;
import com.paypal.core.PayPalEnvironment;
import com.paypal.core.PayPalHttpClient;
import com.paypal.http.HttpResponse;
import com.paypal.orders.*;
import javax.json.Json;
import javax.json.JsonObject;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
@WebServlet(name = "PayPalCheckOut", value = "/anime-main/PayPalCheckOut")
public class PayPalCheckOut extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        BufferedReader reader = request.getReader();
        Gson gson = new Gson();
        JsonObject choose = Json.createReader(reader).readObject();
        String denominations = choose.getString("denominations");
        PayPalEnvironment environment = new PayPalEnvironment.Sandbox("AbenXsywXYlbMw4GpzHDSdiXPx7hKY7adwNFIjsSlY7HfsmSRD6DOzeswhhcBtKiqC46A2kiwzyk_Wf7", "ELW5ilC1gq8J-C_joXPn9KY6M4nVRclHzFXoR2YQQ0WMe03JldFq0znjtrhbayq6Bn0_1V_IRiUVJHNb");
        PayPalHttpClient client = new PayPalHttpClient(environment);
        double rs = Double.parseDouble(denominations);
        System.out.println(rs);
        Order order = new Order();
        order.checkoutPaymentIntent("CAPTURE");
        PurchaseUnit unit = new PurchaseUnit();
        unit.amountWithBreakdown(new AmountWithBreakdown()
                .currencyCode("USD")
                .value(String.valueOf(rs)));
        List<PurchaseUnit> purchaseUnits = new ArrayList<>();
        purchaseUnits.add(unit);
        order.purchaseUnits(purchaseUnits);
        OrdersCreateRequest request1 = new OrdersCreateRequest();
        request1.header("prefer", "return=representation");
        request1.requestBody(order);
        try {
            HttpResponse<Order> response1 = client.execute(request1);
            if (response1.statusCode() == 201) {
                Order createdOrder = response1.result();
                response.getWriter().println(new Gson().toJson(createdOrder));

            } else {
                System.out.println("error");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}