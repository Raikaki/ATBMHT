package adminBlog;

import Log.Log;
import database.DAOBlog;
import database.JDBiConnector;
import model.Account;
import model.Blog;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.nio.file.Paths;

@WebServlet("/admin/BlogEdit")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // giới hạn kích thước file
        maxFileSize = 1024 * 1024 * 100, // giới hạn kích thước tối đa của mỗi file
        maxRequestSize = 1024 * 1024 * 500) // giới hạn kích thước tối đa của mỗi yêu cầu
public class BlogEdit extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int id = Integer.parseInt(request.getParameter("idBlog"));
        Account user = (Account) request.getSession().getAttribute("user");
        String ipClient = request.getRemoteAddr();
        Log log = new Log(Log.ALERT, user.getId(), ipClient, "edit blog", null, 1);
        Blog blog1 = new DAOBlog().adminFindBlogById(id);
        if (user == null || !user.isAdmin()) {
            response.sendRedirect("/anime-main/Index");
        } else {


            if (action != null && action.equalsIgnoreCase("edit")) {

                String title = request.getParameter("title");
                Part filePart = request.getPart("avatar");
                int status = Integer.parseInt(request.getParameter("status"));

                String date = request.getParameter("datetime");
                if (title.isEmpty() ||
                        filePart==null ||
                        date.isEmpty()) {

                    // nếu có trường dữ liệu nào chưa nhập hoặc không có ảnh, file word thì gửi thông báo lỗi
                    request.setAttribute("Blog",blog1);
                    request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin");
                    request.getRequestDispatcher("/admin/Blog-Edit.jsp").forward(request, response);

                } else {

                    InputStream fileContent = filePart.getInputStream();
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // lấy tên file
                    File file = new File(getServletContext().getRealPath("/" + blog1.getFolder()) + "/" + fileName); // đường dẫn tới thư mục đã được chỉ định và tên file
                    File folder = new File(getServletContext().getRealPath("/" + blog1.getFolder()));
                    if (!folder.exists()) {
                        folder.mkdirs();
                    }// tạo thư mục nếu nó không tồn tại
                    if (!file.exists()) {

                        OutputStream outputStream = new FileOutputStream(file);
                        BufferedInputStream bufferedInputStream = new BufferedInputStream(fileContent);
                        byte[] buffer = new byte[1024];
                        int bytesRead = -1;
                        while ((bytesRead = bufferedInputStream.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, bytesRead);
                        }

                        bufferedInputStream.close();
                        outputStream.close();
                        File newFile = new File(file.getParent(), "image_blog" + file.getName().substring(file.getName().indexOf(".")));
                        file.renameTo(newFile);
                        boolean check = new DAOBlog().editBlog(id, title, blog1.getFolder() + "/" + newFile.getName(), blog1.getFolder(), date, status);
                        if (check) {
                            log.setContent("user " + user.getId() + " đã edit blog thành công");
                            JDBiConnector.insert(log);

                            response.sendRedirect("/admin/BlogList");


                        } else {
                            log.setContent("user " + user.getId() + " đã edit blog thất bại");
                            JDBiConnector.insert(log);

                            response.sendRedirect("/admin/BlogList");

                        }

                    } else {
                        boolean check = new DAOBlog().editBlog(id, title, blog1.getAvatar(), blog1.getFolder(), date, status);
                        if (check) {
                            log.setContent("user " + user.getId() + " đã edit blog thành công");
                            JDBiConnector.insert(log);

                            response.sendRedirect("/admin/BlogList");


                        } else {
                            log.setContent("user " + user.getId() + " đã edit blog thất bại");
                            JDBiConnector.insert(log);

                            response.sendRedirect("/admin/BlogList");

                        }
                    }
                }
            } else {
                Blog blog = new DAOBlog().adminFindBlogById(id);
                request.setAttribute("Blog", blog);
                request.getRequestDispatcher("/admin/Blog-Edit.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
