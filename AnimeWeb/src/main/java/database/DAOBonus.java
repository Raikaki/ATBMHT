package database;

import model.Bonus;
import model.Movie;
import org.jdbi.v3.core.Jdbi;
import java.util.List;

public class DAOBonus {
    public static boolean checkEnableBonusAdd(String dayBegin,String dayEnd){
        String query="SELECT EXISTS(\n" +
                "select id\n" +
                "from bonus\n" +
                "where dayBegin <= :dayEnd AND dayEnd >= :dayBegin\n" +
                ")";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("dayBegin",dayBegin).bind("dayEnd",dayEnd).mapTo(Integer.class).first()==0;
        });
    }
    public static Bonus addBonus(String addDescription, String addDayBegin, String addDayEnd, String addPercent) {
        String query="INSERT INTO `bonus` (`description`, `dayBegin`, `dayEnd`, `percent`) VALUES (:addDescription,:addDayBegin,:addDayEnd,:addPercent);\n";
        Jdbi me = JDBiConnector.me();
        boolean isEnable = checkEnableBonusAdd(addDayBegin,addDayEnd);

        if(isEnable){
         String insertedBonus = me.withHandle(handle -> {
                return handle.createUpdate(query).bind("addDescription",addDescription).bind("addDayBegin",addDayBegin).bind("addDayEnd",addDayEnd).bind("addPercent",addPercent).executeAndReturnGeneratedKeys("id").mapTo(String.class).one();
            });

         return findBonusById(insertedBonus);
        }
        return null;
    }
    public static boolean removeBonus(String idBonus) {
        String query="delete from movies_bonus where idBonus=:idBonus";
        Jdbi me = JDBiConnector.me();
            return me.withHandle(handle -> {
            handle.begin();
            try {
                handle.createUpdate(query).bind("idBonus", idBonus).execute();
                int row =handle.createUpdate("DELETE FROM `bonus` WHERE (`id` = :idBonus);\n").bind("idBonus", idBonus).execute();
                handle.commit();
                return row==1;
            } catch (Exception e) {
                handle.rollback();
                return false;
            }
        });
    }

    public static List<Movie> getEnableMovie(String idBonus) {

        String query="SELECT distinct m.id, m.name\n" +
                "FROM movies m\n" +
                "LEFT JOIN movies_bonus mb ON m.id = mb.idMovie\n" +
                "LEFT JOIN bonus b ON mb.idBonus = b.id\n" +
                "WHERE m.status = 1 and m.typeId=2\n" +
                "  AND (mb.idMovie IS NULL OR m.id NOT IN (\n" +
                "      SELECT mb2.idMovie\n" +
                "      FROM movies_bonus mb2\n" +
                "      JOIN bonus b2 ON mb2.idBonus = b2.id\n" +
                "      WHERE b2.id =:idBonus\n" +
                "        AND (b2.dayBegin <= b.dayEnd AND b2.dayEnd >= b.dayBegin)\n" +
                "    ) AND NOT EXISTS (\n" +
                "      SELECT mb3.idMovie\n" +
                "      FROM movies_bonus mb3\n" +
                "      JOIN bonus b3 ON mb3.idBonus = b3.id\n" +
                "      WHERE b3.id =:idBonus\n" +
                "        AND mb3.idMovie = m.id\n" +
                "    ));";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("idBonus",idBonus).mapToBean(Movie.class).list();
        });
    }

    public static List<Movie> getBonusMovie(String idBonus) {
            String query="select mv.id,mv.name from movies_bonus mb join movies mv on mb.idMovie = mv.id where mb.idBonus =:idBonus and mv.status=1;";
            Jdbi me = JDBiConnector.me();
            return me.withHandle(handle -> {
               return handle.createQuery(query).bind("idBonus",idBonus).mapToBean(Movie.class).list();
            });
    }

    public static Bonus availableBonus(){
        String query="select id,description from bonus where (now() between dayBegin and dayEnd) and status=1";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).mapToBean(Bonus.class).findFirst().orElse(null);
        });

    }
    public static List<Bonus> getListBonus() {
        String query ="SELECT id,description,dayBegin,dayEnd,percent,createAt,status FROM bonus";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
           return handle.createQuery(query).mapToBean(Bonus.class).list();
        });
    }
    public static Bonus findBonusById(String idBonus){
        String query="SELECT id,description,dayBegin,dayEnd,percent,createAt,status FROM bonus where id=:id;";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
           return handle.createQuery(query).bind("id",idBonus).mapToBean(Bonus.class).findFirst().orElse(null);
        });
    }
    public static boolean checkEnableBonusEdit(String idBonus,String dayBegin,String dayEnd){
        String query="SELECT EXISTS(\n" +
                "select id\n" +
                "from bonus\n" +
                "where dayBegin <= :dayEnd AND dayEnd >= :dayBegin and id<>:idBonus\n" +
                ")";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
           return handle.createQuery(query).bind("idBonus",idBonus).bind("dayBegin",dayBegin).bind("dayEnd",dayEnd).mapTo(Integer.class).first()==0;
        });
    }
    public static boolean editBonus(String idBonus, String description, String dayBegin, String dayEnd, String percent) {
        String query="UPDATE `bonus` SET `description` =:description, `dayBegin` = :dayBegin, `dayEnd` = :dayEnd, `percent` = :percent WHERE (`id` = :id);";
        Jdbi me = JDBiConnector.me();
        boolean isEnable = checkEnableBonusEdit(idBonus,dayBegin,dayEnd);
        if(isEnable){
            me.useHandle(handle -> {
                handle.createUpdate(query).bind("description",description).bind("dayBegin",dayBegin).bind("dayEnd",dayEnd).bind("percent",percent).bind("id",idBonus).execute();
            });
        }
        return isEnable;
    }

    public static boolean displayBonus(String idBonus) {
        String query="UPDATE `bonus` SET `status` = '1' WHERE (`id` =:id);";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle->{
            return handle.createUpdate(query).bind("id",idBonus).execute();
        })==1;
    }

    public static boolean hideBonus(String idBonus) {
        String query="UPDATE `bonus` SET `status` = '0' WHERE (`id` =:id);";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle->{
            return handle.createUpdate(query).bind("id",idBonus).execute();
        })==1;
    }

    public static boolean removeBonusMovie(String idBonus, String idMovieBonus) {
        String query="DELETE FROM `movies_bonus` WHERE (`idBonus` = :idBonus) and (`idMovie` = :idMovieBonus);";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createUpdate(query).bind("idBonus",idBonus).bind("idMovieBonus",idMovieBonus).execute();
        })==1;
    }
    public static boolean checkEnableBonusMovie(String idBonus,String idMovieBonus){
        String query="SELECT EXISTS(SELECT distinct m.id\n" +
                "FROM movies m\n" +
                "LEFT JOIN movies_bonus mb ON m.id = mb.idMovie\n" +
                "LEFT JOIN bonus b ON mb.idBonus = b.id\n" +
                "WHERE m.status = 1 and m.id=:idMovieBonus\n" +
                "  AND (mb.idMovie IS NULL OR m.id NOT IN (\n" +
                "      SELECT mb2.idMovie\n" +
                "      FROM movies_bonus mb2\n" +
                "      JOIN bonus b2 ON mb2.idBonus = b2.id\n" +
                "      WHERE b2.id = :idBonus\n" +
                "        AND (b2.dayBegin <= b.dayEnd AND b2.dayEnd >= b.dayBegin)\n" +
                "    ) AND NOT EXISTS (\n" +
                "      SELECT mb3.idMovie\n" +
                "      FROM movies_bonus mb3\n" +
                "      JOIN bonus b3 ON mb3.idBonus = b3.id\n" +
                "      WHERE b3.id = :idBonus\n" +
                "        AND mb3.idMovie = m.id\n" +
                "    )));";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
           return  handle.createQuery(query).bind("idBonus",idBonus).bind("idMovieBonus",idMovieBonus).mapTo(Integer.class).first()==1;
        });
    }
    public static boolean addBonusMovie(String idBonus, String idMovieBonus) {
        String query="INSERT INTO `movies_bonus` (`idBonus`, `idMovie`) VALUES (:idBonus, :idMovieBonus);\n";
        Jdbi me = JDBiConnector.me();
        boolean isSuccess = checkEnableBonusMovie(idBonus,idMovieBonus);
            if(isSuccess){
               return me.withHandle(handle -> {
                  return handle.createUpdate(query).bind("idBonus",idBonus).bind("idMovieBonus",idMovieBonus).execute();
               })==1;
            }
        return false;
    }

    public static void main(String[] args) {
        System.out.println(availableBonus());;

    }



}


