package controller;

import database.DAOBlog;
import database.DaoCommentBlog;
import model.Blog;
import model.CommentBlog;
import org.apache.poi.xwpf.usermodel.IRunElement;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet("/anime-main/DetailBlog")
public class DetailBlog extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String idBlog = request.getParameter("idBlog");
        DAOBlog daoBlog = new DAOBlog();

        Blog blog = daoBlog.findBlogById(Integer.parseInt(idBlog));


        if (blog != null) {
            String appPath = request.getServletContext().getRealPath("");
            System.out.println(appPath);

            appPath = appPath.replace("\\", "/");

            String savePath = appPath + blog.getFolder();
            File folder = new File(savePath); // Thay đổi đường dẫn đến thư mục của bạn

            System.out.println(savePath);

            File[] files = folder.listFiles();

            String contentBlog = "", fileCurrent = "";
            File file1 = null;
            for (File file : files) {
                if (file.isFile() && file.getName().endsWith(".docx") || file.getName().endsWith(".doc")) {
                    String htmlfile = savePath + "/htmlfile.html";
                    file1 = new File(htmlfile);
                    XWPFDocument document = new XWPFDocument(new FileInputStream(file.getAbsolutePath()));

// Tạo đối tượng StringBuilder để xây dựng HTML từ tài liệu Word
                    StringBuilder htmlBuilder = new StringBuilder();

// Lặp qua tất cả các đối tượng văn bản trong tài liệu Word
                    for (XWPFParagraph paragraph : document.getParagraphs()) {
                        // Thêm thẻ <p> cho mỗi đoạn văn bản
                        htmlBuilder.append("<p>");

//                        // Lặp qua tất cả các đối tượng văn bản con trong đoạn văn bản
                        for (IRunElement element : paragraph.getIRuns()) {
                            // Thêm đối tượng văn bản con vào đoạn văn bản
                            htmlBuilder.append(element.toString());
                        }

                        // Đóng thẻ <p> cho mỗi đoạn văn bản
                        htmlBuilder.append("</p>");
                    }

// Tạo đối tượng JSoup Document từ HTML
                    Document htmlDocument = Jsoup.parse(htmlBuilder.toString());

// Lặp qua tất cả các thẻ <p> trong tài liệu HTML và thêm dấu xuống dòng
                    for (Element element : htmlDocument.select("p")) {
                        element.append("<br>");
                    }

// Lưu nội dung HTML ra file

                    try (OutputStreamWriter writer = new OutputStreamWriter(new FileOutputStream(file1), StandardCharsets.UTF_8)) {
                        writer.write(htmlDocument.outerHtml());

                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                }

            }
            Document doc = Jsoup.parse(file1, "UTF-8", "");
            Element body = doc.body();
            contentBlog = body.html();

            DaoCommentBlog daoCommentBlog = new DaoCommentBlog();
            int limit = 5;
            List<CommentBlog> listComment = daoCommentBlog.getCommentBlog(Integer.parseInt(idBlog),0,limit,false,0);
            blog.setListComment(listComment);
            int rendered = listComment.size();
            int availableToRender = daoCommentBlog.availableCommentToRender(Integer.parseInt(idBlog),limit,false,0);
//            request.setAttribute("blog",blog);
            request.setAttribute("idBlog",idBlog);
            request.setAttribute("rendered",rendered);
            request.setAttribute("availableToRender",availableToRender);


            System.out.println(blog.getListComment().toString());
            request.setAttribute("contentBlog", contentBlog);
            request.setAttribute("currentBlog", blog);


            request.getRequestDispatcher("/anime-main/blog-details.jsp").forward(request, response);

        } else {
            response.getWriter().println("<img class=\"rsImg\" src=\"/AnimeWeb/error.png" + "\">");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
