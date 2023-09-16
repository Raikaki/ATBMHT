package database;

import java.io.FileNotFoundException;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.List;

import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

import model.*;
import org.jdbi.v3.core.Jdbi;

import static database.DAOPermission.getRolePermission;

public class DAOAccounts {


	public static void updateAvatarAccount(int idUser, String avatar) {
		String query = "UPDATE `accounts` SET `avatar` =:avatar WHERE (`id` = :idUser);";
		Jdbi me = JDBiConnector.me();
		me.withHandle(handle -> {
			return handle.createUpdate(query).bind("idUser", idUser).bind("avatar", avatar).execute();
		});
	}


	public static Account getUserComment(int idUser){
		String query="select id,avatar,fullName from accounts where id=:idUser";
		Jdbi me = JDBiConnector.me();
		return me.withHandle(handle -> {
			return handle.createQuery(query).bind("idUser",idUser).mapToBean(Account.class).findFirst().orElse(new Account());

		});
	}

	public static Account Login(String userName, String passWord) {
		Encode encode = new Encode();

		Account account = null;
		String query = "SELECT id,userName,password,email,avatar,isActive,fullName,phone,balance,status,externalId,typeId FROM animeweb.accounts where userName= :UserName and password = :Password  and status=1 and typeId=1";

		Jdbi me = JDBiConnector.me();
		account = me.withHandle(handle -> {
			return handle.createQuery(query).bind("UserName", userName).bind("Password", passWord)
					.mapToBean(Account.class).findFirst().orElse(null);

		});
		if (account != null) {
			account.setRoles(getRoleUser(account.getId()));
			account.setType(getTypeAccount(account.getId()));


		}
		return account;
	}



	public static List<Role> getRoleUser(int idUser) {
		String query = "select distinct a.idRole as id,description from account_roles a join roles r on a.idRole = r.id where a.idAccount=:idAccount";
		Jdbi me = JDBiConnector.me();
		List<Role> result;
		result = me.withHandle(handle -> {
			return handle.createQuery(query)
					.bind("idAccount", idUser).mapToBean(Role.class).list();
		});
		for(Role r : result){
			r.setPermissions(DAOPermission.getRolePermission(String.valueOf(idUser),String.valueOf(r.getId())));
		}
		return result;
	}

	public static List<Permission> getRolePermission(int idUser, int idRole) {
		String query = "select p.id,p.description,p.resource,p.action,p.externalResource,p.idSupplier,p.idGenre from account_roles ar join permissions p on ar.idPermission = p.id where ar.idAccount =:idAccount and ar.idRole =:idRole";
		Jdbi me = JDBiConnector.me();
		return me.withHandle(handle -> {
			return handle.createQuery(query).bind("idAccount", idUser).bind("idRole", idRole).mapToBean(Permission.class).list();
		});
	}



	public static boolean editPassword(int idUser, String encryptPassword) {
		Jdbi me = JDBiConnector.me();
		String query = "UPDATE `accounts` SET `Password` =:Password WHERE (`id` =:idUser);";
		return me.withHandle(handle -> {
			return handle.createUpdate(query).bind("Password", encryptPassword).bind("idUser", idUser).execute();
		}) == 1;

	}

	public static boolean unlockUser(int idUser) {
		Jdbi me = JDBiConnector.me();
		String query = "UPDATE `accounts` SET `isActive` = '1' WHERE (`id` =:idUser);";
		return me.withHandle(handle -> {
			return handle.createUpdate(query).bind("idUser", idUser).execute();
		}) == 1;

	}

	public static boolean blockAccount(int idUser) {
		Jdbi me = JDBiConnector.me();
		String query = "UPDATE `accounts` SET `isActive` = '0' WHERE (`id` =:idUser);";
		return me.withHandle(handle -> {
			return handle.createUpdate(query).bind("idUser", idUser).execute();
		}) == 1;
	}

	public static boolean checkExistEmail(String email, int typeID) {
		Jdbi me = JDBiConnector.me();
		String query = "select exists (select 1 from accounts where typeid=:typeid and Email=:Email and status=1)";

		return me.withHandle(handle -> {
			return handle.createQuery(query).bind("typeid", typeID).bind("Email", email).mapTo(Integer.class).one();
		}) == 1;
	}

	public static boolean editUser(String fullName, String email, String phoneNumber, String avatar, int idUser) {
		Jdbi me = JDBiConnector.me();

		String query = "UPDATE `accounts` SET `Email` = :Email, `avatar` = :avatar, `fullName` = :FullName, `phone` = :PhoneNumber WHERE (`id` = :idUser);";
		
		return me.withHandle(handle->{
			return handle.createUpdate(query).bind("Email", email).bind("avatar", avatar).bind("FullName",fullName).bind("PhoneNumber", phoneNumber).bind("idUser", idUser).execute();
		})==1;

	}


	public static List<AccountType> getlistType() {
		Jdbi me = JDBiConnector.me();
		String query = "SELECT id,description FROM account_types";
		return me.withHandle(handle -> {
			return handle.createQuery(query).mapToBean(AccountType.class).list();
		});
	}

	public static AccountType getTypeAccount(int id) {
		Jdbi me = JDBiConnector.me();
		String query = "SELECT act.id,description FROM accounts ac join account_types act on ac.typeId=act.id where ac.id=:id";
		return me.withHandle(handle -> {
			return handle.createQuery(query).bind("id", id).mapToBean(AccountType.class).one();
		});
	}

	public static boolean removeUserbyId(int idUser) {
		Jdbi me = JDBiConnector.me();
		String query = "UPDATE `accounts` SET `status` = '0' WHERE (id=:idUser);";
		return me.withHandle(handle -> {
			return handle.createUpdate(query).bind("idUser", idUser).execute();
		}) == 1;
	}

	public static int getSizeListAccountNormal() {
		Jdbi me = JDBiConnector.me();
		String query = "select distinct ac.id from accounts ac join account_roles acr on ac.id = acr.idAccount where 6 not in"
				+ " (select idRole from account_roles where idAccount = ac.id)and ac.status=1";
		List<Account> result = me.withHandle(handle -> {
			return handle.createQuery(query).mapToBean(Account.class).list();
		});
		return result.size();
	}

	public static List<Account> getListAccount() {

		Jdbi me = JDBiConnector.me();
		String query = "select distinct ac.id,userName,password,email,avatar,typeId,isActive,joinDate,fullName,phone from accounts ac join account_roles acr on ac.id = acr.idAccount where 6 not in"
				+ " (select idRole from account_roles where idAccount = ac.id) and ac.status=1 ";
		List<Account> result = me.withHandle(handle -> {
			return handle.createQuery(query).mapToBean(Account.class).list();
		});
		for (Account ac : result) {
			ac.setRoles(getRoleUser(ac.getId()));
			ac.setType(getTypeAccount(ac.getId()));
		}

		return result;
	}

	
	public static int findIdByUserName(String userName){
		String query ="SELECT id FROM accounts where UserName=:userName and typeId=1 and status=1";
		Jdbi me = JDBiConnector.me();
		return me.withHandle(handle -> {
			return handle.createQuery(query).bind("userName",userName).mapTo(Integer.class).findFirst().orElse(-1);
		});


	}

	public static Account findAccountById(int idUser) {
		Jdbi me = JDBiConnector.me();
		String query = "SELECT id,UserName,Password,Email,avatar,typeId,isActive,fullName,phone FROM accounts where id=:idUser and status=1";
		Account account;
		account = me.withHandle(handle -> {
			return handle.createQuery(query).bind("idUser", idUser).mapToBean(Account.class).findFirst().orElse(null);
		});
		if (account != null) {
			account.setRoles(getRoleUser(account.getId()));
			account.setType(getTypeAccount(account.getId()));
		}
		return account;

	}

	public static Account findUserByUserNameandEmail(String userName, String Email) {
		Jdbi me = JDBiConnector.me();
		String query = "SELECT id,UserName,Email,typeId FROM accounts where (UserName= :UserName or Email= :Email) and typeId=1 and status=1";

		Account account;
		account = me.withHandle(handle -> {
			return handle.createQuery(query).bind("UserName", userName).bind("Email", Email).mapToBean(Account.class)
					.findFirst().orElse(null);

		});
		return account;
	}

	public static Account findUserByEmail(String Email) {
		Jdbi me = JDBiConnector.me();
		String query = "SELECT id,UserName,Email,typeId FROM accounts where  Email= :Email  and status=1";

		Account account;
		account = me.withHandle(handle -> {
			return handle.createQuery(query).bind("Email", Email).mapToBean(Account.class)
					.findFirst().orElse(null);

		});
		return account;
	}

	public static void deleteResetToken(String email) {
		Jdbi me = JDBiConnector.me();
		me.withHandle(handle -> {
			return   handle.createUpdate("UPDATE accounts SET currentPassword = NULL WHERE email = :email")
					.bind("email", email)
					.execute();
		});
	}

	public static void updateResetToken(String email, String resetToken) {
		Jdbi me = JDBiConnector.me();

		me.withHandle(handle -> {
			return handle.createUpdate("UPDATE accounts SET currentPassword = :resetToken WHERE email = :email")
					.bind("resetToken", resetToken)
					.bind("email", email)
					.execute();
		});

	}

	public static boolean isValidEmailWithToken(String email, String token) {
		Jdbi me = JDBiConnector.me();
		return me.withHandle(handle -> {
			// Kiểm tra email và token trong cơ sở dữ liệu
			return handle.createQuery("SELECT COUNT(*) FROM accounts WHERE email = :email AND currentPassword = :token")
					.bind("email", email)
					.bind("token", token)
					.mapTo(Integer.class)
					.findOne()
					.orElse(0) > 0;
		});
	}

	public static void updatePassword(String email, String newPassword) {
		Jdbi me = JDBiConnector.me();
		me.withHandle(handle -> {
			return handle.createUpdate("UPDATE accounts SET password = :newPassword WHERE email = :email")
					.bind("newPassword", newPassword)
					.bind("email", email)
					.execute();
		});
	}


	public static int findIdSocialUser(String externalId, String email) throws SQLException {
		int id;
		Jdbi me = JDBiConnector.me();

		String query = "SELECT id from accounts where externalId =:externalId and EMAIL=:Email and status = 1 ";
		id = me.withHandle(handle -> {
			return handle.createQuery(query).bind("externalId", externalId).bind("Email", email).mapToBean(Account.class)
					.findFirst().orElse(new Account()).getId();
		});
		return id;
	}

	public static Account loginAccountSocialId(int idUser, int type) throws SQLException, FileNotFoundException {
		Account account = null;

		Jdbi me = JDBiConnector.me();
		String query = "SELECT id,UserName,Password,fullName,balance,Email,avatar,typeId,isActive FROM accounts where id=:idUser and typeId=:typeId and status=1";
		account = me.withHandle(handle -> {
			return handle.createQuery(query).bind("idUser", idUser).bind("typeId", type).mapToBean(Account.class)
					.findFirst().orElse(null);
		});
		if (account != null) {
			account.setRoles(getRoleUser(idUser));
		}

		return account;
	}

	public static int findIdUserAccount(String externalId, int type) throws SQLException {
		int id;

		Jdbi me = JDBiConnector.me();
		String query = "SELECT id from accounts where  externalId=:externalId and typeId =:typeId and status=1";
		id = me.withHandle(handle -> {
			return handle.createQuery(query).bind("externalId", externalId).bind("typeId", type).mapToBean(Account.class)
					.findFirst().orElse(new Account()).getId();
		});
		return id;
	}

	public static int addBaseUser(String userName, String password, String email, String fullName, String phoneNumber) {
		Encode encrypt = new Encode();
		String encryptPassword = encrypt.toSHA1(password);
		Jdbi me = JDBiConnector.me();
		String avatarPath = "/anime-main/storage/avatarUser/";

		final int[] idUserFinal = {-1};
		me.useHandle(handle -> {
			handle.begin();
			try {
				String query = "INSERT INTO accounts (userName, password,email,avatar,typeId,isActive,fullName,phone) VALUES (:Username,:Password,:Email,:avatar,1,1,:FullName,:PhoneNumber) ";
				int idUser = handle.createUpdate(query).bind("Username", userName).bind("Password", encryptPassword)
						.bind("Email", email).bind("avatar", avatarPath + "defaultavatar.jpg")
						.bind("FullName", fullName).bind("PhoneNumber", phoneNumber).executeAndReturnGeneratedKeys()
						.mapTo(Integer.class).findFirst().orElse(-1);

				String query1 = "INSERT INTO  account_roles (idAccount, idRole) VALUES (:idUser,:idrole) ";
				handle.createUpdate(query1).bind("idUser", idUser).bind("idrole", Role.Base_User).execute();
				handle.commit();
				idUserFinal[0] = idUser;
			} catch (Exception e) {
				e.printStackTrace();
				handle.rollback();

			}
		});
		return idUserFinal[0];

	}

	public static void addGoogle(String externalId, String email, String userName, String avatar, String fullName, String phone)
			throws SQLException {

		Encode encrypt = new Encode();
		String pass = encrypt.toSHA1(externalId);

		Jdbi me = JDBiConnector.me();
		me.useHandle(handle -> {
			handle.begin();
			try {
				String query = "INSERT INTO accounts (Username, Password,Email,avatar,typeId,isActive,FullName,phone,externalId) VALUES (:Username,:Password,:Email,:avatar,2,1,:FullName,:PhoneNumber,:externalId) ";
				int idUser = handle.createUpdate(query).bind("Username", userName).bind("Password", pass)
						.bind("Email", email).bind("avatar", avatar).bind("FullName", fullName)
						.bind("PhoneNumber", phone).bind("externalId", externalId).executeAndReturnGeneratedKeys().mapTo(Integer.class).findFirst()
						.orElse(-1);
				String query3 = "INSERT INTO  account_roles (idAccount, idrole) VALUES (:idUser,:idrole) ";
				handle.createUpdate(query3).bind("idUser", idUser).bind("idrole", Role.Base_User).execute();
				handle.commit();
			} catch (Exception e) {
				e.printStackTrace();
				handle.rollback();

			}
		});

	}

    public static boolean settingUser(String userName, String passWord, String email)
            throws ClassNotFoundException, SQLException {
        Connection conn = null;
        conn = DataSource.getConnection();
        PreparedStatement ps = conn.prepareStatement("update account set PassW=?,Email=? where UserName=?");
        ps.setString(1, passWord);
        ps.setString(2, email);
        ps.setString(3, userName);
        int check = ps.executeUpdate();

        boolean result = check == 1 ? true : false;
        return result;
    }

    // log in withfb
//    public static Account checkAcountFacebook(String email, String idfb) throws SQLException, FileNotFoundException {
//
//        Account account = null;
//        String query = "SELECT a.idUser,a.UserName,a.Password,a.Email,a.avatar,a.typeId,a.isActive,fb.idFacebook FROM animeweb.accounts a join animeweb.accounts_facebook fb on a.idUser=fb.idUser where a.Email= ? and fb.idFacebook=? and a.typeId=3 and status=1;";
//
//        Jdbi me = JDBiConnector.me();
//        account = me.withHandle(handle -> {
//            return handle.createQuery(query).bind(0, email).bind(1, idfb).mapToBean(Account.class).findFirst()
//                    .orElse(null);
//
//        });
//        if (account != null) {
//            account.setRoles(getRoleUser(account.getId()));
//        }
//        return account;
//
//    }

    // add account fb if not exist on database
    public static void createAccountByFB(String externalId, String email, String userName, String avatar, String fullName) throws SQLException {

        Encode encrypt = new Encode();
        String pass = encrypt.toSHA1(externalId);

        Jdbi me = JDBiConnector.me();
        me.useHandle(handle -> {
            handle.begin();
            try {

				String query = "INSERT INTO accounts (Username, Password,Email,avatar,typeId,isActive,FullName,phone,externalId) VALUES (:Username,:Password,:Email,:avatar,3,1,:FullName,null,:externalId) ";
                int idUser = handle.createUpdate(query).bind("Username", userName).bind("Password", pass)
                        .bind("Email", email).bind("avatar", avatar).bind("FullName", fullName)
                        .bind("externalId", externalId).executeAndReturnGeneratedKeys().mapTo(Integer.class).findFirst()
                        .orElse(-1);
                String query3 = "INSERT INTO  account_roles (idAccount, idrole) VALUES (:idUser,:idrole) ";
                handle.createUpdate(query3).bind("idUser", idUser).bind("idrole", Role.Base_User).execute();
                handle.commit();
            } catch (Exception e) {
                e.printStackTrace();
                handle.rollback();

            }
        });

    }
    public void changePassword(String email, int id , String password) {
        Jdbi me = JDBiConnector.me();
        me.useHandle(handle -> {
            handle.begin();
            try {
                String updateQuery = "UPDATE animeweb.accounts SET password = :password WHERE id = :id AND email = :email";
                handle.createUpdate(updateQuery).bind("password", password).bind("id", id).bind("email", email).execute();
                handle.commit();
            } catch (Exception e) {
                e.printStackTrace();
                handle.rollback();
            }
        });

	}


	public static void main(String[] args) throws ClassNotFoundException, SQLException, FileNotFoundException {

	}

}