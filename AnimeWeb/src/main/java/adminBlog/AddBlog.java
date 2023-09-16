package adminBlog;

import Log.Log;
import database.DAOBlog;
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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/admin/AddBlog")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // giới hạn kích thước file
        maxFileSize = 1024 * 1024 * 100, // giới hạn kích thước tối đa của mỗi file
        maxRequestSize = 1024 * 1024 * 500) // giới hạn kích thước tối đa của mỗi yêu cầu
public class AddBlog extends HttpServlet {
    private File file2;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        Account user = (Account) request.getSession().getAttribute("user");
        String ipClient = request.getRemoteAddr();
        if (user == null||!user.isAdmin()) {
            response.sendRedirect("/anime-main/Index");
        } else {

            if (action != null && action.equalsIgnoreCase("addblog")) {
                String title = request.getParameter("title");
                // Lấy giá trị từ trường input và chuyển đổi thành đối tượng LocalDateTime
                String datetimeString = request.getParameter("datetime");

                //up load image
                int id = new DAOBlog().createIdBlog() + 1;
                Part imagePart = request.getPart("avatar1");
                Part filePart = request.getPart("file-upload");
                System.out.println(imagePart);

                if (title.isEmpty() ||
                        filePart==null ||
                        imagePart==null ||
                        datetimeString.isEmpty()) {

                    // nếu có trường dữ liệu nào chưa nhập hoặc không có ảnh, file word thì gửi thông báo lỗi
                    request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin và chọn ảnh, file Word");
                    request.getRequestDispatcher("/admin/Blog-Add.jsp").forward(request, response);

                } else {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
                    LocalDateTime datetime = LocalDateTime.parse(datetimeString, formatter);

                    InputStream filecontent = imagePart.getInputStream();
                    String imageName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString(); // lấy tên file
                    File file1 = new File(getServletContext().getRealPath("/anime-main/storage/blog/blog" + id)); // đường dẫn tới thư mục đã được chỉ định và tên file
                    if (!file1.exists()) {
                        file1.mkdirs(); // tạo thư mục nếu nó không tồn tại
                    }
                    String name = Paths.get(imagePart.getSubmittedFileName()).toString();
                    File file2 = new File(file1.getAbsolutePath() + "/" + "image_blog" + name.substring(name.indexOf(".")));

                    OutputStream ops = new FileOutputStream(file2);
                    BufferedInputStream bfipStream = new BufferedInputStream(filecontent);
                    byte[] buffer1 = new byte[1024];
                    int bytesRead1 = -1;
                    while ((bytesRead1 = bfipStream.read(buffer1)) != -1) {
                        ops.write(buffer1, 0, bytesRead1);
                    }
                    bfipStream.close();
                    ops.close();

                    // upload file word

                    InputStream fileContent = filePart.getInputStream();
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // lấy tên file
                    File file = new File(getServletContext().getRealPath("/anime-main/storage/blog/blog" + id + "/" + fileName)); // đường dẫn tới thư mục đã được chỉ định và tên file

                    OutputStream outputStream = new FileOutputStream(file);
                    BufferedInputStream bufferedInputStream = new BufferedInputStream(fileContent);
                    byte[] buffer = new byte[1024];
                    int bytesRead = -1;
                    while ((bytesRead = bufferedInputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }
                    bufferedInputStream.close();
                    outputStream.close();
                    String path = file1.getAbsolutePath().replaceAll("\\\\", "/");
                    String path_image = file2.getAbsolutePath().replaceAll("\\\\", "/");


                    Log log = new Log(Log.ALERT, user.getId(), ipClient, "add blog", null, 0);
                    Blog newBlog = new DAOBlog().addBlog(id, title, path.substring(path.indexOf("anime-main")), path_image.substring(path_image.indexOf("anime-main")), datetime);
                    if (newBlog != null) {
                        log.setContent("user " + user.getId() + " đã thêm blog thành công");
                        response.sendRedirect("/admin/BlogList");
                    } else {
                        log.setContent("user " + user.getId() + " đã thêm blog thất bại");
                        response.sendRedirect("/admin/BlogList");

                    }
                }

            } else {
                request.getRequestDispatcher("/admin/Blog-Add.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        doGet(request, response);
    }
}
