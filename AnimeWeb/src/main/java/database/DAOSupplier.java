package database;

import model.Supplier;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class DAOSupplier {
    public static List<Supplier> listSupplier(){
        String query ="select id,name,description,phone,address,createAt,status from suppliers";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
           return handle.createQuery(query).mapToBean(Supplier.class).list();
        });
    }
    public static List<Supplier> suppliersToAddMovie() {
        String query ="select id,name from suppliers where status=1";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).mapToBean(Supplier.class).list();
        });
    }
    public static boolean hideSupplier(String idSupplier){
        String query="UPDATE `suppliers` SET `status` = '0' WHERE (`id` =:id);";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle->{
            return handle.createUpdate(query).bind("id",idSupplier).execute();
        })==1;
    }

    public static boolean displaySupplier(String idSupplier) {
        String query="UPDATE `suppliers` SET `status` = '1' WHERE (`id` =:id);";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle->{
            return handle.createUpdate(query).bind("id",idSupplier).execute();
        })==1;
    }

    public static boolean removeSupplier(String idSupplier) {
        String query="DELETE FROM `suppliers` WHERE (`id` =:id);";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle->{
            return handle.createUpdate(query).bind("id",idSupplier).execute();
        })==1;
    }

    public static Supplier editSupplier(String idSupplier, String name, String description, String phone, String address) {
        String query="UPDATE `suppliers` SET name=:name,description=:description,phone=:phone,address=:address,updateAt=now() where id=:id;";
        Jdbi me = JDBiConnector.me();

        me.useHandle(handle -> {
            handle.createUpdate(query).bind("id",idSupplier).bind("name",name).bind("description",description).bind("phone",phone).bind("address",address).execute();
        });
        return findSupplierById(idSupplier);
    }
    public static Supplier findSupplierById(String idSupplier){
        String query="select id,name,description,phone,address,createAt,status from suppliers where id=:id";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
           return handle.createQuery(query).bind("id",idSupplier).mapToBean(Supplier.class).findFirst().orElse(null);
        });
    }

    public static Supplier addSupplier(String addName, String addDescription, String addPhone, String addAddress) {
        String query="INSERT INTO `suppliers` (`name`, `description`, `phone`, `address`) VALUES (:addName,:addDescription,:addPhone,:addAddress);";
        Jdbi me = JDBiConnector.me();
        final int[] idMovieFinal = {-1};
         me.useHandle(handle->{
             idMovieFinal[0] = handle.createUpdate(query).bind("addName",addName).bind("addDescription",addDescription).bind("addPhone",addPhone)
                    .bind("addAddress",addAddress).executeAndReturnGeneratedKeys("id").mapTo(Integer.class).one();
        });
         return findSupplierById(String.valueOf(idMovieFinal[0]));
    }


}
