package database;

import java.util.List;
import java.util.stream.Collectors;

import model.Permission;
import org.jdbi.v3.core.Jdbi;

import model.Account;
import model.Role;

public class DAORoleAccount {
	public DAORoleAccount() {

	}

	public static boolean updateRolePermission(String idRole, String[] idPermissions) {
		Jdbi me = JDBiConnector.me();
		return me.withHandle(handle -> {
			handle.begin();
			try{
				String query;
				query = "delete from roles_permissions where idRole=:idRole";
				handle.createUpdate(query).bind("idRole",idRole).execute();
				query="insert into roles_permissions (`idRole`,`idPermission`) values (:idRole,:idPermission)";
				for (String idPermission : idPermissions){
					handle.createUpdate(query).bind("idRole",idRole).bind("idPermission",idPermission).execute();
				}
				query="delete from account_roles " +
						"where idRole=:idRole and idPermission not in" +
						"(select idPermission from roles_permissions where idRole=:idRole) and idPermission is not null";
				handle.createUpdate(query).bind("idRole",idRole).execute();
				handle.commit();
				return true;
			}catch (Exception e){
				handle.rollback();
				e.printStackTrace();
				return false;
			}
		});
	}
	public static boolean deleteRole(String idRole) {
		Jdbi me = JDBiConnector.me();
		return me.withHandle(handle -> {
			handle.begin();
			try{
				String query;
				query="delete from account_roles where  idRole =:roleId ;";
				handle.createUpdate(query).bind("roleId",idRole).execute();

				query = "delete from roles_permissions where idRole =:roleId";
				handle.createUpdate(query).bind("roleId",idRole).execute();
				query="delete from roles where id=:roleId";
				handle.createUpdate(query).bind("roleId",idRole).execute();
				handle.commit();
				return true;
			}catch (Exception e){
				handle.rollback();
				e.printStackTrace();
				return false;
			}
		});
	}
	public static Role getRoleById(String idRole) {
		String query="select id,description from roles where id =:idRole";
		Jdbi me = JDBiConnector.me();
		Role result = me.withHandle(handle -> {
			return handle.createQuery(query).bind("idRole",idRole).mapToBean(Role.class).findFirst().orElse(new Role());
		});
		result.setPermissions(DAOPermission.getRoleFullPermission(idRole));
		return  result;
	}
	public static boolean isValidRoleName(String nameRole){
		String query="select not exists(select id from roles where description =:description)";
		Jdbi me = JDBiConnector.me();
		return me.withHandle(handle -> {
			return handle.createQuery(query).bind("description",nameRole).mapTo(Boolean.class).one();
		});
	}
	public static boolean addNewRole(String nameRole, String[] idPermissions) {

		Jdbi me = JDBiConnector.me();
		return me.withHandle(handle -> {
			handle.begin();
			try{
				String query;
				if(isValidRoleName(nameRole)){
					query="INSERT INTO `roles` (`description`) VALUES (:description);";
					String idRole= handle.createUpdate(query).bind("description",nameRole).executeAndReturnGeneratedKeys("id").mapTo(String.class).one();
					query="INSERT INTO `roles_permissions` (`idRole`, `idPermission`) VALUES (:idRole, :idPermission);\n";
					for(String idPermission : idPermissions){

						handle.createUpdate(query).bind("idRole",idRole).bind("idPermission",idPermission).execute();
					}
				}else{
					handle.commit();
					return false;
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
	public static List<String> getUserAffectUpdateRole(String idRole){
		String query="select distinct ac.id from account_roles acr join accounts ac on acr.idAccount = ac.id where acr.idRole = :idRole";
		Jdbi me = JDBiConnector.me();
		return me.withHandle(handle -> {
			return handle.createQuery(query).bind("idRole",idRole).mapTo(String.class).list();
		});
	}
	public static List<Account> getUserHasRole(String idRole){
		String query="select distinct ac.id,ac.userName from account_roles acr join accounts ac on acr.idAccount = ac.id where acr.idRole = :idRole";
		Jdbi me = JDBiConnector.me();
		return me.withHandle(handle -> {
			return handle.createQuery(query).bind("idRole",idRole).mapToBean(Account.class).list();
		});
	}
	public static List<Role> getListRole(){
		String query="select id,description from roles where id <>6";
		Jdbi me = JDBiConnector.me();
		return me.withHandle(handle -> {
			return handle.createQuery(query).mapToBean(Role.class).list();
		});
	}
	public static boolean isAdmin(int idUser){
		String query="SELECT EXISTS(SELECT 1 FROM account_roles where idAccount=:idUser and idRole=:admin);";
		Jdbi me = JDBiConnector.me();
		return me.withHandle(handle->{
			return handle.createQuery(query).bind("idUser",idUser).bind("admin",Role.Administrator).mapTo(Integer.class).one();
		})==1;
	}
	public static List<Role> getUnableAddRoles(String idUser) {
		Jdbi me;
		me = JDBiConnector.me();
		String query= "select distinct id,description from roles where id not in(select idRole from account_roles where idAccount=:idUser) and id not in(6,1)  and status=1";
		return me.withHandle(handle -> {
			return handle.createQuery(query).bind("idUser", idUser).mapToBean(Role.class).stream()
					.collect(Collectors.toList());
		});
	}

	public static boolean addRoleUser(String idUser, String idRole) {
		Jdbi me = JDBiConnector.me();
		return  me.withHandle(handle -> {
			handle.begin();
			try{
				String query;
				query= "INSERT INTO account_roles (idAccount, idRole) VALUES (:idUser, :idRole);";
				handle.createUpdate(query).bind("idUser",idUser).bind("idRole",idRole).execute();
				List<Permission> listIdPermission = DAOPermission.getRoleFullPermission(idRole);
				query= "INSERT INTO account_roles (idAccount, idRole,idPermission) VALUES (:idUser, :idRole,:idPermission);";
				for(Permission permission : listIdPermission){
				handle.createUpdate(query).bind("idUser",idUser).bind("idRole",idRole).bind("idPermission",permission.getId()).execute();
				}
				handle.commit();
				return true;
			}catch (Exception e){
				handle.rollback();
				return false;
			}
		});
	}


	public static boolean removeRoleUser(String idUser, String idRole) {
		Jdbi me = JDBiConnector.me();
		String query = "delete account_roles from account_roles where idAccount=:idUser and idRole=:idRole";
			return me.withHandle(handle -> {
				return handle.createUpdate(query).bind("idUser", idUser).bind("idRole", idRole).execute()>0;
		});
	}



}
