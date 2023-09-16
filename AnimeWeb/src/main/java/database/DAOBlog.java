package database;

import model.*;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

public class DAOBlog {
    public DAOBlog() {
    }

    public Blog findBlogById(int id) {
        Blog result;
        String query = "select b.id,b.title,b.folder,b.avatar,b.releaseAt,b.createAt,b.updateAt,b.deleteAt FROM animeweb.blogs b where b.id=:id and b.status=1;";
        Jdbi me = JDBiConnector.me();
        result = me.withHandle(handle -> {
            return handle.createQuery(query).bind("id", id).mapToBean(Blog.class).findFirst().orElse(new Blog());
        });
        result.setListComment(getListComment(result.getId()));

        return result;
    }
    public Blog adminFindBlogById(int id) {
        Blog result;
        String query = "select b.id,b.title,b.folder,b.avatar,b.releaseAt,b.createAt,b.updateAt,b.deleteAt,b.status FROM animeweb.blogs b where b.id=:id ;";
        Jdbi me = JDBiConnector.me();
        result = me.withHandle(handle -> {
            return handle.createQuery(query).bind("id", id).mapToBean(Blog.class).findFirst().orElse(new Blog());
        });
        result.setListComment(getListComment(result.getId()));

        return result;
    }

    public List<Blog> getListBlog() {
        List<Blog> result;
        String query = "SELECT id, title, avatar,folder, releaseAt, createAt, updateAt, deleteAt,status FROM animeweb.blogs WHERE status = 1;";
        Jdbi me = JDBiConnector.me();
        result = me.withHandle(handle -> {
            return handle.createQuery(query).mapToBean(Blog.class).list();
        });
        for (Blog blog:result){
            blog.setListComment(getListComment(blog.getId()));
        }
        return result;
    }
    public List<Blog> getListBlogAdmin() {
        List<Blog> result;
        String query = "SELECT id, title, avatar,folder, releaseAt, createAt, updateAt, deleteAt,status FROM animeweb.blogs ;";
        Jdbi me = JDBiConnector.me();
        result = me.withHandle(handle -> {
            return handle.createQuery(query).mapToBean(Blog.class).list();
        });
        for (Blog blog:result){
            blog.setListComment(getListComment(blog.getId()));
        }
        return result;
    }
    public List<CommentBlog>getListComment(int idBlog){
        String query = "SELECT id,idBlog,parentId,content,userComment,commentAt,status,updateAt,userReply FROM animeweb.blog_comments where idBlog=:idBlog and status=1;";
        List<CommentBlog> result;
        Jdbi me = JDBiConnector.me();
        result = me.withHandle(handle -> {
            return handle.createQuery(query).bind("idBlog",idBlog).mapToBean(CommentBlog.class).list();
        });
//        for (CommentBlog cm : result) {
//            cm.setAccountComment();
//
//        }
        return result;
    }
    public boolean updateStatusBlog(int id){
        String query ="update animeweb.blogs SET status=0, deleteAt= NOW() where id=:id";
        Jdbi me = JDBiConnector.me();
        return  me.withHandle(handle->{
            return handle.createUpdate(query).bind("id",id).execute();
        })==1;
    }

    public boolean editBlog(int idBlog, String title, String avatar, String folder,String releaseAt,int status){
        String query ="update animeweb.blogs SET title=:title,folder=:folder,avatar=:avatar ,updateAt= NOW(), releaseAt=:releaseAt , status=:status where id=:id";
        Jdbi me = JDBiConnector.me();
        return  me.withHandle(handle->{
            return handle.createUpdate(query).bind("title",title).bind("avatar",avatar).bind("folder",folder).bind("releaseAt",releaseAt).bind("status",status).bind("id",idBlog).execute();
        })==1;
    }
    public Blog addBlog(int id, String title, String folder, String avatar, LocalDateTime releaseAt){
        String query="INSERT INTO `animeweb`.`blogs` (`id`,`title`, `folder`, `avatar`, `releaseAt`, `status`) VALUES (:id,:title, :folder, :avatar, :releaseAt, 1);";
        Jdbi me = JDBiConnector.me();

        int idBlog = me.withHandle(handle -> {
            return handle.createUpdate(query).bind("id", id).bind("title", title).bind("folder", folder).bind("avatar", avatar).bind("releaseAt", releaseAt).executeAndReturnGeneratedKeys("id").mapTo(Integer.class).one();
        });
        return findBlogById(idBlog);
    }

    public int createIdBlog(){
        String query="SELECT id FROM animeweb.blogs ORDER BY id DESC LIMIT 1;";
        Jdbi me = JDBiConnector.me();
        int idBlog = me.withHandle(handle -> {
            return handle.createQuery(query).mapTo(Integer.class).findOne().orElse(0);
        });
        return idBlog;
    }
    public static void main(String[] args) {

        System.out.println(new DAOBlog().findBlogById(3));

    }

}
