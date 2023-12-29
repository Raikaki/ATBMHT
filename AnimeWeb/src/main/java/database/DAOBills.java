package database;


import model.Bill;
import model.Bill_detail;
import model.Movie;
import org.jdbi.v3.core.Jdbi;
import security.DSA;

import java.util.List;

public class DAOBills {
    public static int createBill(int idAccount, int billNum, double totalPrice, List<Movie> billMovies, String publicKey) {
        Jdbi me = JDBiConnector.me();
        final int[] idBill = {-1};
        me.useHandle(handle -> {
            handle.begin();
            try {
                String query;
                query = "INSERT INTO `bills`(`idAccount`,`bill_num`,`totalPrice`,`public_key`) VALUES (:idAccount,:bill_num,:totalPrice,:public_key);";
                idBill[0] = handle.createUpdate(query).bind("idAccount", idAccount).bind("bill_num", billNum).bind("totalPrice", totalPrice).bind("public_key", publicKey).executeAndReturnGeneratedKeys("id").mapTo(Integer.class).one();
                query = "INSERT INTO `bills_detail` (`idMovie`, `idBill`, `price`) VALUES (:idMovie, :idBill,:price);";
                for (Movie mv : billMovies) {
                    handle.createUpdate(query).bind("idMovie", mv.getId()).bind("idBill", idBill[0]).bind("price", mv.getRenderPrice()).execute();
                }
                handle.commit();
            } catch (Exception e) {
                e.printStackTrace();
                handle.rollback();
            }
        });
        return idBill[0];
    }

    public static Bill getBillById(int id) {
        Jdbi jdbi = JDBiConnector.me();
        String query = "SELECT b.id, b.bill_num, b.create_At, b.isPurchased, b.totalPrice,b.hash,b.public_key, a.fullName FROM bills b JOIN accounts a ON b.idAccount = a.id WHERE b.id = :id and isDelete=0 ";
        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .bind("id", id)
                        .mapToBean(Bill.class)
                        .one()
        );
    }
    public static int getAccountIdByBillId(int idBill) {
        Jdbi jdbi = JDBiConnector.me();
        String query = "SELECT idAccount FROM bills WHERE id = :id and isDelete=0 ";

        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .bind("id", idBill)
                        .mapTo(Integer.class)
                        .one()
        );
    }
    public static String getCaptureId(int idBill) {
        Jdbi jdbi = JDBiConnector.me();
        String query = "SELECT captureId FROM bills WHERE id = :id and isDelete=0 ";

        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .bind("id", idBill)
                        .mapTo(String.class)
                        .one()
        );
    }


    public static boolean getIsRefund(int idBill) {
        Jdbi jdbi = JDBiConnector.me();
        String query = "SELECT isRefund FROM bills WHERE id = :id AND isDelete = 0";

        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .bind("id", idBill)
                        .mapTo(Boolean.class) // Map to boolean directly
                        .one()
        );
    }

    public static boolean saveSignatureToBill(Bill bill, String signature) throws Exception {
        Jdbi me = JDBiConnector.me();
        String query = "UPDATE `bills` SET `hash` = :hash WHERE (`id` = :idBill);";
        return me.withHandle(handle -> handle.createUpdate(query).bind("idBill", bill.getId()).bind("hash", signature).execute()) == 1;
    }
    public static Integer saveCaptureId(Bill bill, String captureId)  {
        Jdbi me = JDBiConnector.me();
        String query = "UPDATE `bills` SET `captureId` = :captureId WHERE (`id` = :idBill);";
        return me.withHandle(handle -> handle.createUpdate(query).bind("idBill", bill.getId()).bind("captureId", captureId).execute());
    }

    public static boolean verifySignatureBill(Bill bill, String publicKey) throws Exception {
        String bills_detail = getBillDetail(bill.getId()).toString();
        return DSA.verifyBill(bill.toString()+bills_detail, DSA.verifyPublicKey(publicKey), getBillSignature(bill.getId()));
    }

    public static String getBillSignature(int id) {
        Jdbi me = JDBiConnector.me();
        String query = "select hash from bills where id=:id";
        return me.withHandle(handle -> handle.createQuery(query).bind("id", id).mapTo(String.class).one());
    }

    public static List<Bill> getAccountBills(int idAccount) {
        Jdbi me = JDBiConnector.me();
        String query = "SELECT b.id, b.bill_num, b.create_At, b.isPurchased, b.hash, a.fullName FROM bills b JOIN accounts a ON b.idAccount = a.id WHERE isDelete = 0 AND idAccount = :idAccount and isPurchased = 1";

        List<Bill> bills = me.withHandle(handle ->
                handle.createQuery(query)
                        .bind("idAccount", idAccount)
                        .mapToBean(Bill.class)
                        .list()
        );
        for (Bill bill : bills) {

            bill.setBillDetail(getBillDetail(bill.getId()));
        }
        System.out.println(bills);
        return bills;
    }

    public static List<Bill_detail> getBillDetail(int idBill) {
        Jdbi me = JDBiConnector.me();
        String query = "select id,idMovie,idBill,price,status from bills_detail where idBill=:idBill";
        return me.withHandle(handle -> handle.createQuery(query).bind("idBill", idBill).mapToBean(Bill_detail.class).list());
    }
    public static void updateIsPurchased(int billId) {
        Jdbi me = JDBiConnector.me();
        String updateQuery = "UPDATE bills SET isPurchased = 1 WHERE id = :billId";

        me.useHandle(handle -> handle.createUpdate(updateQuery)
                .bind("billId", billId)
                .execute());
    }
    public static List<Bill_detail> getBillDetailsByBillId(int idBill) {
        Jdbi jdbi = JDBiConnector.me();
        String query = "SELECT id, idMovie, idBill, price, status FROM bills_detail WHERE idBill = :idBill";

        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .bind("idBill", idBill)
                        .mapToBean(Bill_detail.class)
                        .list()
        );
    }

    public static void main(String[] args) {
        System.out.println(getIsRefund(41));
    }


}