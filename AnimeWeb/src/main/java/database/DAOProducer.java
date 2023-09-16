package database;

import model.Producer;

import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class DAOProducer {

    public static List<Producer> listProducer(){
        String query ="select id,name,description,createAt,status from producers ";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).mapToBean(Producer.class).list();
        });
    }
    public static List<Producer> producersToAddMovie(){
        String query ="select id,name from producers where status=1";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).mapToBean(Producer.class).list();
        });
    }
    public static boolean hideProducer(String idProducer){
        String query="UPDATE `producers` SET `status` = '0' WHERE (`id` =:id);";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle->{
            return handle.createUpdate(query).bind("id",idProducer).execute();
        })==1;
    }

    public static boolean displayProducer(String idProducer) {
        String query="UPDATE `producers` SET `status` = '1' WHERE (`id` =:id);";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle->{
            return handle.createUpdate(query).bind("id",idProducer).execute();
        })==1;
    }

    public static boolean removeProducer(String idProducer) {
        String query="DELETE FROM `producers` WHERE (`id` =:id);";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle->{
            return handle.createUpdate(query).bind("id",idProducer).execute();
        })==1;
    }

    public static Producer editProducer(String idProducer, String name, String description) {
        String query="UPDATE `producers` SET name=:name,description=:description,updateAt=now() where id=:id;";
        Jdbi me = JDBiConnector.me();

        me.useHandle(handle -> {
            handle.createUpdate(query).bind("id",idProducer).bind("name",name).bind("description",description).execute();
        });
        return findProducerById(idProducer);
    }
    public static Producer findProducerById(String idProducer){
        String query="select id,name,description,createAt,status from producers where id=:id ";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("id",idProducer).mapToBean(Producer.class).findFirst().orElse(null);
        });
    }

    public static Producer addProducer(String addName, String addDescription) {
        String query="INSERT INTO `producers` (`name`, `description`) VALUES (:addName,:addDescription);";
        Jdbi me = JDBiConnector.me();
        final int[] idMovieFinal = {-1};
        me.useHandle(handle->{
            idMovieFinal[0] = handle.createUpdate(query).bind("addName",addName).bind("addDescription",addDescription).executeAndReturnGeneratedKeys("id").mapTo(Integer.class).one();
        });
        return findProducerById(String.valueOf(idMovieFinal[0]));
    }

    public static void main(String[] args) {
        System.out.println(listProducer());
    }


}
