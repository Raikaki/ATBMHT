package controller;

import database.DaoCommentBlog;
import model.Account;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "commentBlog", value = "/anime-main/commentBlog")
public class commentBlog extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        if (user == null) {
            request.getRequestDispatcher("/anime-main/login.jsp").forward(request, response);
        }
        try {
            String content = request.getParameter("message");
            String idParent = request.getParameter("idParent");
            String idUserReply = request.getParameter("idUserReply");
            DaoCommentBlog daoCommentBlog = new DaoCommentBlog();
            int idBlog = Integer.parseInt(request.getParameter("idBlog"));
            boolean check = daoCommentBlog.Comment(user, idParent, idBlog, content, idUserReply);
            response.sendRedirect(getServletContext().getContextPath() + ("/anime-main/DetailBlog?idBlog=" + idBlog));
        } catch (Exception e) {
            response.getWriter().println(e.getMessage());
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
