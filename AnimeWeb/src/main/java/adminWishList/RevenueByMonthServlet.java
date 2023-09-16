package adminWishList;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import database.DAORecharge;

import org.json.JSONObject;

@WebServlet("/api/revenue-by-month")
public class RevenueByMonthServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy năm hiện tại
        int year = Calendar.getInstance().get(Calendar.YEAR);

        // Truy vấn cơ sở dữ liệu để tính tổng doanh thu của mỗi tháng trong năm
        List<Double> revenues = new ArrayList<>();
        List<Double> costs = new ArrayList<>();
        for (int month = 1; month <=
                12; month++) {
            double revenue = DAORecharge.calculateRevenue(year, month);
            double cost = DAORecharge.calculateImportCost(year,month);
            costs.add(cost);
            revenues.add(revenue);
        } // Tạo đối tượng JSON chứa dữ liệu thống kê và gửi về cho client
        JSONObject json = new JSONObject();
        json.put("labels", new String[]{"Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"});
        json.put("cost",costs);
        json.put("values", revenues);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json.toString());
    }

}

