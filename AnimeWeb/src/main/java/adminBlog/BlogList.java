package adminBlog;

import database.DAOBlog;
import model.Account;
import model.Blog;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/BlogList")
public class BlogList extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account user = (Account) request.getSession().getAttribute("user");
        if (user == null || !user.isAdmin()) {
            response.sendRedirect("/anime-main/Index");
        } else {
            List<Blog> listBlog = new DAOBlog().getListBlogAdmin();

            request.setAttribute("listBlog", listBlog);

            request.getRequestDispatcher("/admin/Blog-List.jsp").forward(request, response);

        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);

    }
}
