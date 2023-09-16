package database;

import model.Permission;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class DAOPermission {
    public static List<Permission> getUnablePermission() {
        String query="select id,name from permissions";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
           return handle.createQuery(query).mapToBean(Permission.class).list();
        });
    }
    public static List<Permission> getUnablePermissionToEdit(String idRole) {
        String query="select id,name from permissions where id not in (select idPermission from roles_permissions where idPermission<>null and idRole=:idRole)";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("idRole",idRole).mapToBean(Permission.class).list();
        });
    }
    public static boolean settingUserPermission(String userId, String roleId, String[] selectedPermissionIds) {

        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            handle.begin();
            try{
                String query;
                query="delete from account_roles where idAccount=:userId and idRole =:roleId and idPermission is not null;";
                handle.createUpdate(query).bind("userId",userId).bind("roleId",roleId).execute();
                for(String idPermission : selectedPermissionIds){
                    query="insert into account_roles (idAccount,idRole,idPermission) values(:userId,:roleId,:idPermission);";
                    handle.createUpdate(query).bind("userId",userId).bind("roleId",roleId).bind("idPermission",idPermission).execute();
                }
                handle.commit();
                return true;
            }catch (Exception e){
                handle.rollback();
                e.printStackTrace();
                return false;
            }
        });
    }
    public static List<Permission> getRolePermission(String idUser,String idRole){
        String query ="select distinct p.id,p.name,p.action,p.resource from account_roles acr join permissions p on acr.idPermission = p.id where idRole = :idRole and idAccount=:idUser";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("idUser",idUser).bind("idRole",idRole).mapToBean(Permission.class).list();
        });
    }
    public static List<Permission> getRolePermissionNotHave(String idUser,String idRole){
       String query="select distinct p.id,p.name,p.action,p.resource \n" +
               "from roles_permissions rps\n" +
               "join permissions p on rps.idPermission = p.id \n" +
               "where rps.idRole =:idRole and rps.idPermission not in(select idPermission from account_roles where idAccount=:idUser and idPermission is not null);";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("idUser",idUser).bind("idRole",idRole).mapToBean(Permission.class).list();
        });
    }
    public static List<Permission> getRoleFullPermission(String idRole){
        String query="select distinct idPermission as id,p.name from roles_permissions rp join permissions p on rp.idPermission = p.id where idRole = :idRole";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
           return handle.createQuery(query).bind("idRole",idRole).mapToBean(Permission.class).list();
        });
    }



}
