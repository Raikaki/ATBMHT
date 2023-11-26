package adminSignature;

import database.DAOKey;
import model.Key;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ViewListKey", value = "/admin/ViewListKey")
public class ViewListKey extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Key> keyList = DAOKey.keyList();
        request.setAttribute("keyList",keyList);
        request.getRequestDispatcher("/admin/KeyManagement.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
