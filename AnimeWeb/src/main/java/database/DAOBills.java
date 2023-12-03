package database;


import model.Bill;
import model.Bill_detail;
import model.Movie;
import org.jdbi.v3.core.Jdbi;
import security.DSA;

import java.util.List;

public class DAOBills {
    public static int createBill(int idAccount, int billNum, double totalPrice, List<Movie> billMovies){
        Jdbi me = JDBiConnector.me();
        final int[] idBill = {-1};
        me.useHandle(handle -> {
            handle.begin();
            try {
                String query;
                query="INSERT INTO `bills`(`idAccount`,`bill_num`,`totalPrice`) VALUES (:idAccount,:bill_num,:totalPrice);";
                idBill[0]= handle.createUpdate(query).bind("idAccount",idAccount).bind("bill_num",billNum).bind("totalPrice",totalPrice).executeAndReturnGeneratedKeys("id").mapTo(Integer.class).one();
                query ="INSERT INTO `bills_detail` (`idMovie`, `idBill`, `price`) VALUES (:idMovie, :idBill,:price);";
                for(Movie mv : billMovies){
                    handle.createUpdate(query).bind("idMovie",mv.getId()).bind("idBill",idBill[0]).bind("price",mv.getRenderPrice()).execute();
                }
                handle.commit();
            } catch (Exception e) {
                e.printStackTrace();
                handle.rollback();
            }
        });
        return idBill[0];
    }
    public boolean saveSignatureToBill(Bill bill,String privateKey)throws Exception {
        String signature = DSA.toBase64(DSA.signBill(bill.toString(), DSA.verifyPrivateKey(privateKey)));
        Jdbi me = JDBiConnector.me();
        String query="UPDATE `bills` SET `hash` = :hash WHERE (`id` = :idBill);";
        return me.withHandle(handle -> handle.createUpdate(query).bind("idBill",bill.getId()).bind("hash",signature).execute())==1;
    }
    public boolean verifySignatureBill(Bill bill,String publicKey) throws Exception {
        return DSA.verifyBill(bill.toString(),DSA.verifyPublicKey(publicKey),getBillSignature(bill.getId()));
    }
    public String getBillSignature(int idBill){
        Jdbi me = JDBiConnector.me();
        String query ="select hash from bills where idBill=:idBill";
        return me.withHandle(handle -> handle.createQuery(query).bind("idBill",idBill).mapTo(String.class).one());
    }
    public static List<Bill> getAccountBills(int idAccount){
        Jdbi me = JDBiConnector.me();
        String query="select id,bill_num,create_At,isPurchased from bills where isDelete=0";
        List<Bill> bills = me.withHandle(handle -> handle.createQuery(query).bind("idAccount",idAccount).mapToBean(Bill.class).list());
        for(Bill bill : bills){
            bill.setBillDetail(getBillDetail(bill.getId()));
        }
        return bills;
    }
    public static List<Bill_detail> getBillDetail(int idBill){
        Jdbi me = JDBiConnector.me();
        String query="select id,idMovie,idBill,price,status from bills_detail where idBill=:idBill";
        return me.withHandle(handle -> handle.createQuery(query).bind("idBill",idBill).mapToBean(Bill_detail.class).list());
    }

}