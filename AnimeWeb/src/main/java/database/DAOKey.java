package database;

import model.Key;
import org.jdbi.v3.core.Jdbi;
import security.DSA;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.List;

public class DAOKey {
    public static List<Key> keyList(){
        String query="select id,idAccount,userName,`key`,dayReceive,dayExpired,dayCanceled,status from user_keys";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
          return  handle.createQuery(query).mapToBean(Key.class).stream().toList();
        });
    }
    public static List<Key> accountKeyList(int idAccount){
        String query="select id,`key`,dayReceive,dayExpired,dayCanceled,status from user_keys where idAccount =:idAccount order by status desc,dayReceive desc";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return  handle.createQuery(query).bind("idAccount",idAccount).mapToBean(Key.class).stream().toList();
        });
    }
    public static Key addKey(String idAccount,String userName,String publicKey,String dayExpired) throws NoSuchAlgorithmException, InvalidKeySpecException {
        DSA.verifyPublicKey(publicKey);
        boolean isEnable;
        Jdbi me = JDBiConnector.me();
        String query;
            isEnable = DAOKey.isExistPublicKey(publicKey);
           if(isEnable){
               disableAllOldKey(idAccount);
               query = "INSERT INTO `user_keys` (`idAccount`, `userName`, `key`, `dayExpired`) VALUES (:idAccount,:userName,:key, :dayExpired)";
               String insertedKey = me.withHandle(handle -> handle.createUpdate(query).bind("idAccount",idAccount).bind("userName",userName).bind("key",publicKey)
                       .bind("dayExpired",dayExpired).executeAndReturnGeneratedKeys("id").mapTo(String.class).one());
               return findKeyById(insertedKey);
           }else{
               return null;
           }

    }
    public static Key findKeyById(String keyId){
        Jdbi me = JDBiConnector.me();
        String query = "select id,`key`,dayReceive,dayExpired,dayCanceled,status from user_keys where id = :id";
        return me.withHandle(handle -> handle.createQuery(query).bind("id",keyId).mapToBean(Key.class).findFirst().orElse(null));
    }
    public static boolean isExistPublicKey(String publicKey) {
        Jdbi me = JDBiConnector.me();
        String query="SELECT EXISTS(\n" +
                "select id\n" +
                "from user_keys\n" +
                "where `key` = :publicKey\n" +
                ")";
        return me.withHandle(handle -> handle.createQuery(query).bind("publicKey",publicKey).mapTo(Integer.class).first()==0);
    }

    public static void disableAllOldKey(String idAccount){
        Jdbi me = JDBiConnector.me();
        String query="UPDATE `user_keys` SET `status` =0 WHERE (`idAccount` = :idAccount);";
        me.withHandle(handle -> handle.createUpdate(query).bind("idAccount",idAccount).execute());
    }

}
