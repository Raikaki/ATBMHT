package database;

import model.Account;
import model.CommentMovie;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class DAOCommentMovie {

    public DAOCommentMovie() {

    }
    public static boolean removeComment(String idComment) {
        String query="UPDATE `movie_comments` SET `status` = '0' WHERE (`id` = :idComment);\n";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createUpdate(query).bind("idComment",idComment).execute();
        })==1;
    }
    public static void setAccountToComment(List<CommentMovie> commentList,boolean isReply){
        for(CommentMovie cmt : commentList){
            cmt.setAccountComment(DAOAccounts.getUserComment(cmt.getUserComment()));
            if(isReply){
                cmt.setAccountReply(DAOAccounts.getUserComment(cmt.getUserReply()));
            }
        }
    }
    public static int availableCommentToRender(int idMovie,int limit,boolean isReply,int parentId){
        String query;
        Jdbi me = JDBiConnector.me();
        if(!isReply){
            query = "SELECT COUNT(*) FROM movie_comments mc1\n" +
                    "LEFT JOIN (\n" +
                    "  SELECT id FROM movie_comments\n" +
                    "  WHERE parentId IS NULL AND idMovie=:idMovie AND status = 1\n" +
                    "  ORDER BY commentAt DESC\n" +
                    "  LIMIT :limit offset 0 \n" +
                    ") mc2 ON mc1.id = mc2.id\n" +
                    "WHERE mc1.idMovie = :idMovie AND mc1.parentId IS NULL AND mc2.id IS NULL and mc1.status=1; ";

           return me.withHandle(handle -> {
                return handle.createQuery(query).bind("idMovie",idMovie).bind("limit",limit).mapTo(Integer.class).one();
            });
        }else{
            query = "SELECT COUNT(*) FROM movie_comments mc1\n" +
                    "LEFT JOIN (\n" +
                    "  SELECT id FROM movie_comments\n" +
                    "  WHERE parentId =:parentId AND idMovie = :idMovie AND status = 1\n" +
                    "  ORDER BY commentAt asc\n" +
                    "  limit :limit offset 0\n" +
                    ") mc2 ON mc1.id = mc2.id\n" +
                    "WHERE mc1.idMovie = :idMovie AND mc1.parentId =:parentId AND mc2.id IS NULL and mc1.status=1;";
        return me.withHandle(handle -> {
                return handle.createQuery(query).bind("limit",limit).bind("parentId",parentId).bind("idMovie",idMovie).mapTo(Integer.class).one();
            });
        }
    }
    public static List<CommentMovie> getCommentMovie(int idMovie,int offset,int limit,boolean isReply,int parentId){
        String query;
        Jdbi me = JDBiConnector.me();
        List<CommentMovie> result;
        if(!isReply){
            query = "select id,idMovie,content,userComment,commentAt,status,updateAt from movie_comments where parentId is null and status =1 and idMovie=:idMovie order by commentAt desc limit :limit offset :offset ";

            result= me.withHandle(handle -> {
                return handle.createQuery(query).bind("idMovie",idMovie).bind("limit",limit).bind("offset",offset).bind("idMovie",idMovie).mapToBean(CommentMovie.class).list();
            });
        }else{
            query = "select id,idMovie,parentId,content,userComment,commentAt,userReply,status,updateAt from movie_comments where parentId is not null and status =1 and parentId=:parentId and idMovie=:idMovie order by commentAt asc limit :limit offset :offset ";
            result= me.withHandle(handle -> {
                return handle.createQuery(query).bind("idMovie",idMovie).bind("limit",limit).bind("offset",offset).bind("parentId",parentId).mapToBean(CommentMovie.class).list();
            });
        }
        setAccountToComment(result,isReply);
        return result;
    }
    public static boolean Comment(Account userComment,String parentId,int idMovie,String content,String idUserReply){

        String query;
        Jdbi me = JDBiConnector.me();

        if(parentId==null){
            query ="insert into movie_comments (idMovie,content,userComment) values(:idMovie,:content,:userComment);";
            return me.withHandle(handle -> {
                return handle.createUpdate(query).bind("userComment",userComment.getId()).bind("content",content).bind("idMovie",idMovie).execute()==1;
            });
        }else{
           query= "insert into movie_comments (idMovie,parentId,content,userComment,userReply) values(:idMovie,:parentId,:content,:userComment,:userReply);";
            return me.withHandle(handle -> {
                return handle.createUpdate(query).bind("userComment",userComment.getId()).bind("parentId",parentId).bind("content",content).bind("idMovie",idMovie).bind("userReply",idUserReply).execute()==1;
            });
        }



    }
    public static int getIdUserByIdComment(int idComment){
        String query="select userComment from movie_comments where id =:idComment and status=1 ;";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle->{
           return handle.createQuery(query).bind("idComment",idComment).mapTo(Integer.class).one();
        });
    }

    public static void main(String[] args) {
//        System.out.println(new DaoCommentMovie().getIdUserByIdComment(1));
//        Account account = new Account(1);
//        System.out.println(new DaoCommentMovie().Comment(account,"1",10,"aduu"));
        System.out.println(new DAOCommentMovie().getCommentMovie(10,0,5,true,15));
//        System.out.println(new DaoCommentMovie().availableCommentToRender(10,10,false,0));
//        System.out.println(new DaoCommentMovie().availableCommentToRender(10,0,true,1));
//        System.out.println(new DaoCommentMovie().getCommentMovie(10,0,5,false,0));

    }


}
