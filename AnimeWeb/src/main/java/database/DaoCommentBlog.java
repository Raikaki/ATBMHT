package database;

import model.Account;
import model.CommentBlog;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class DaoCommentBlog {
    public DaoCommentBlog() {
    }

    public static void setAccountToComment(List<CommentBlog> commentList, boolean isReply) {
        for (CommentBlog cmt : commentList) {
            cmt.setAccountComment(DAOAccounts.getUserComment(cmt.getUserComment()));
            if (isReply) {
                cmt.setAccountReply(DAOAccounts.getUserComment(cmt.getUserReply()));
            }
        }
    }

    public static int availableCommentToRender(int idBlog, int limit, boolean isReply, int parentId) {
        String query;
        Jdbi me = JDBiConnector.me();
        if (!isReply) {
            query = "SELECT COUNT(*) FROM blog_comments mc1\n" +
                    "LEFT JOIN (\n" +
                    "  SELECT id FROM blog_comments\n" +
                    "  WHERE parentId IS NULL AND idBlog=:idBlog AND status = 1\n" +
                    "  ORDER BY commentAt DESC\n" +
                    "  LIMIT :limit offset 0 \n" +
                    ") mc2 ON mc1.id = mc2.id\n" +
                    "WHERE mc1.idBlog = :idBlog AND mc1.parentId IS NULL AND mc2.id IS NULL and mc1.status=1; ";

            return me.withHandle(handle -> {
                return handle.createQuery(query).bind("idBlog", idBlog).bind("limit", limit).mapTo(Integer.class).one();
            });
        } else {
            query = "SELECT COUNT(*) FROM blog_comments mc1\n" +
                    "LEFT JOIN (\n" +
                    "  SELECT id FROM blog_comments\n" +
                    "  WHERE parentId =:parentId AND idBlog = :idBlog AND status = 1\n" +
                    "  ORDER BY commentAt asc\n" +
                    "  limit :limit offset 0\n" +
                    ") mc2 ON mc1.id = mc2.id\n" +
                    "WHERE mc1.idBlog = :idBlog AND mc1.parentId =:parentId AND mc2.id IS NULL and mc1.status=1;";
            return me.withHandle(handle -> {
                return handle.createQuery(query).bind("limit", limit).bind("parentId", parentId).bind("idBlog", idBlog).mapTo(Integer.class).one();
            });
        }
    }

    public static List<CommentBlog> getCommentBlog(int idBlog, int offset, int limit, boolean isReply, int parentId) {
        String query;
        Jdbi me = JDBiConnector.me();
        List<CommentBlog> result;
        if (!isReply) {
            query = "select id,idBlog,content,userComment,commentAt,status,updateAt from blog_comments where parentId is null and status =1 and idBlog=:idBlog order by commentAt desc limit :limit offset :offset ";

            result = me.withHandle(handle -> {
                return handle.createQuery(query).bind("idBlog", idBlog).bind("limit", limit).bind("offset", offset).mapToBean(CommentBlog.class).list();
            });
        } else {
            query = "select id,idBlog,parentId,content,userComment,commentAt,userReply,status,updateAt from blog_comments where parentId is not null and status =1 and parentId=:parentId and idBlog=:idBlog order by commentAt asc limit :limit offset :offset ";
            result = me.withHandle(handle -> {
                return handle.createQuery(query).bind("parentId", parentId).bind("idBlog", idBlog).bind("limit", limit).bind("offset", offset).mapToBean(CommentBlog.class).list();
            });
        }
        setAccountToComment(result, isReply);
        return result;
    }

    public static boolean Comment(Account userComment, String parentId, int idBlog, String content, String idUserReply) {

        String query;
        Jdbi me = JDBiConnector.me();

        if (parentId == null) {
            query = "insert into animeweb.blog_comments (idBlog,content,userComment) values(:idBlog,:content,:userComment);";
            return me.withHandle(handle -> {
                return handle.createUpdate(query).bind("idBlog", idBlog).bind("content", content).bind("userComment", userComment.getId()).execute() == 1;
            });
        } else {
            query = "insert into animeweb.blog_comments (idBlog,parentId,content,userComment,userReply) values(:idBlog,:parentId,:content,:userComment,:userReply);";
//                    int idUserReply = getIdUserByIdComment(Integer.parseInt(parentId));
            return me.withHandle(handle -> {
                return handle.createUpdate(query).bind("idBlog", idBlog).bind("parentId", parentId).bind("content", content).bind("userComment", userComment.getId()).bind("userReply", idUserReply).execute() == 1;
            });
        }


    }

    public static int getIdUserByIdComment(int idComment) {
        String query = "select userComment from animeweb.blog_comments where id =:idComment and status=1 ;";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("idComment", idComment).mapTo(Integer.class).one();
        });
    }

    public static void main(String[] args) {
        //System.out.println(new DaoCommentBlog().getCommentBlog(3, 0, 5, false, 0));
        System.out.printf(DAOAccounts.getUserComment(2).toString());
    }
}
