package walletController;

import com.paypal.api.payments.*;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import database.DAOMovie;
import model.Account;
import model.Movie;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.List;

@WebServlet("/anime-main/refund")
public class RefundServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Thông tin xác thực PayPal
        String clientId = "AbenXsywXYlbMw4GpzHDSdiXPx7hKY7adwNFIjsSlY7HfsmSRD6DOzeswhhcBtKiqC46A2kiwzyk_Wf7";
        String clientSecret = "ELW5ilC1gq8J-C_joXPn9KY6M4nVRclHzFXoR2YQQ0WMe03JldFq0znjtrhbayq6Bn0_1V_IRiUVJHNb";
        String mode = "sandbox";  // Đổi thành "live" khi triển khai sản phẩm thực
        HttpSession session = request.getSession();
        // API Context
        String id = request.getParameter("billId");
        APIContext apiContext = new APIContext(clientId, clientSecret, mode);
        Account user = (Account) session.getAttribute("user");
        List<Movie> movieList = (List<Movie>) session.getAttribute("bill_movies");
        System.out.println(movieList);
        String captureId = request.getParameter("captureId");
        String refundValue = request.getParameter("refundValue");
        System.out.println(refundValue);
        try {
            // Lấy thông tin capture từ PayPal
            Capture capture = Capture.get(apiContext, captureId);
            for (Movie m : movieList
            ) {
                DAOMovie.updateMoviePurchasedStatus(user.getId(),m.getId(), Integer.parseInt(id));
            }

            // Tạo đối tượng Refund
            RefundRequest refundRequest = new RefundRequest();
            Amount amount = new Amount();
            amount.setCurrency("USD").setTotal(capture.getAmount().getTotal());  // Số tiền bạn muốn hoàn tiền
            refundRequest.setAmount(amount);

            // Thực hiện hoàn tiền
            Refund refund = capture.refund(apiContext, refundRequest);

            // Xử lý kết quả hoàn tiền
            if (refund.getState().equals("completed")) {
                response.getWriter().println("Refund successful");
                session.removeAttribute("bill_movies");
            } else {
                response.getWriter().println("Refund failed");
            }
        } catch (PayPalRESTException e) {
            // Xử lý lỗi nếu có
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            response.getWriter().println("Error in refund process: " + sw.toString());
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }
}
