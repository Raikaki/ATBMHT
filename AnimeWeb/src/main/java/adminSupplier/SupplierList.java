package adminSupplier;

import database.DAOSupplier;
import model.Supplier;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
@WebServlet(name = "SupplierList", value = "/admin/SupplierList")
public class SupplierList extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Supplier> listSupplier = DAOSupplier.listSupplier();
        request.setAttribute("listSupplier",listSupplier);
        request.getRequestDispatcher("/admin/SupplierList.jsp").forward(request,response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
