package security;

import database.DAORoleAccount;
import model.Account;
import model.Permission;
import model.Role;


public class PermissionValidate {


    public static boolean userHasPermission(Account account,String resource) {
        if (account.isAdmin()) return true;
        for(Role role : account.getRoles()){
            for(Permission permission : role.getPermissions()){
                if(permission.getResource().equalsIgnoreCase(resource)){
                    return true;
                }
            }
        }

    return false;
    }




}


