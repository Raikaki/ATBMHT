package database;

import org.jdbi.v3.core.Jdbi;
import model.*;
import org.jdbi.v3.core.Jdbi;

import java.util.*;


public class DAORecharge {
    public DAORecharge() {
    }

    public static double calculateRevenue(int year, int month) {
        double revenue = 0;
        Jdbi me = JDBiConnector.me();
        // Truy vấn cơ sở dữ liệu để tính tổng doanh thu của tháng đó trong năm
        return me.withHandle(handle -> {
            return handle.createQuery("SELECT SUM(money_Increase) FROM transaction_history WHERE YEAR(createAt) = :year AND MONTH(createAt) = :month")
                    .bind("year", year)
                    .bind("month", month)
                    .mapTo(Double.class)
                    .findFirst()
                    .orElse(0.0);
        });


    }
    public static double calculateImportCost(int year, int month) {
        double revenue = 0;
        Jdbi me = JDBiConnector.me();
        // Truy vấn cơ sở dữ liệu để tính tổng doanh thu của tháng đó trong năm
        return me.withHandle(handle -> {
            return handle.createQuery("SELECT SUM(price) FROM import_coupons WHERE YEAR(createAt) = :year AND MONTH(createAt) = :month")
                    .bind("year", year)
                    .bind("month", month)
                    .mapTo(Double.class)
                    .findFirst()
                    .orElse(0.0);
        });


    }
    public static double calculateTotalImportCost() {
        double revenue = 0;
        Jdbi me = JDBiConnector.me();
        // Truy vấn cơ sở dữ liệu để tính tổng doanh thu của tháng đó trong năm
        return me.withHandle(handle -> {
            return handle.createQuery("SELECT SUM(price) FROM import_coupons ")
                    .mapTo(Double.class)
                    .findFirst()
                    .orElse(0.0);
        });


    }
    public static double calculateTotalRevenue() {
        double revenue = 0;
        Jdbi me = JDBiConnector.me();
        // Truy vấn cơ sở dữ liệu để tính tổng doanh thu của tháng đó trong năm
        return me.withHandle(handle -> {
            return handle.createQuery("SELECT SUM(money_Increase) FROM transaction_history ")
                    .mapTo(Double.class)
                    .findFirst()
                    .orElse(0.0);
        });


    }


    public void updateBalance(int idUser, double balance) {
        String query = "UPDATE accounts SET balance = :balance WHERE id = :idUser";
        Jdbi me = JDBiConnector.me();
        me.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind("balance", balance)
                    .bind("idUser", idUser)
                    .execute();
        });
    }

    public void insertBalanceFluctuations(int idUser, String balanceFluctuations, String description, double money) {
        String query = "INSERT INTO transaction_history (idAccount, residualRange,description,money_Increase) VALUES (:idUser,  :residualRange,:description,:money_Increase)";
        Jdbi me = JDBiConnector.me();
        me.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind("idUser", idUser)
                    .bind("residualRange", balanceFluctuations)
                    .bind("description", description)
                    .bind("money_Increase", money)
                    .execute();
        });
    }

    public List<TransactionHistory> getBalanceFluctuations(int idUser) {

        String query = "SELECT residualRange, description, createAt FROM transaction_history WHERE idAccount = :idUser";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> handle.createQuery(query)
                .bind("idUser", idUser)
                .map((rs, ctx) -> new TransactionHistory(
                        rs.getString("residualRange"),
                        rs.getString("description"),
                        rs.getTimestamp("createAt").toLocalDateTime()))
                .list());

    }

    public List<PurchasedDetail> getPurchases() {
        List<PurchasedDetail> purchases = new ArrayList<>();
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> handle.createQuery("SELECT p.id, a.userName, m.name as movieName, p.purchaseAt, p.purchasePrice " +
                        "FROM accounts a JOIN movies_purchased p ON a.id = p.idAccount " +
                        "JOIN movies m ON m.id = p.idMovie Where p.status = 1")
                .map((rs, ctx) -> new PurchasedDetail(
                        rs.getInt("id"),
                        rs.getString("userName"),
                        rs.getString("movieName"),
                        rs.getTimestamp("purchaseAt").toLocalDateTime(),
                        rs.getDouble("purchasePrice")))
                .list());

    }

    public static int getUserPurchased(int id) {
        String query = "SELECT idAccount FROM movies_purchased WHERE id =:id";

        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query)
                    .bind("id", id)
                    .mapTo(Integer.class)
                    .findOnly();

        });
    }

    public static boolean deletePurchasedHistory(int purchased) {
        Jdbi me = JDBiConnector.me();
        String query = "UPDATE `movies_purchased` SET `status` = '0' WHERE (id=:purchased);";
        return me.withHandle(handle -> {
            return handle.createUpdate(query).bind("purchased", purchased).execute();
        }) == 1;
    }

    public static boolean deleteTransactionHistory(int purchased) {
        Jdbi me = JDBiConnector.me();
        String query = "UPDATE `transaction_history` SET `status` = '0' WHERE (id=:purchased);";
        return me.withHandle(handle -> {
            return handle.createUpdate(query).bind("purchased", purchased).execute();
        }) == 1;
    }
    public static boolean deleteImportsHistory(int id) {
        Jdbi me = JDBiConnector.me();
        String query = "UPDATE `import_coupons` SET `status` = '0' WHERE (id=:id);";
        return me.withHandle(handle -> {
            return handle.createUpdate(query).bind("id", id).execute();
        }) == 1;
    }


    public static List<TransactionHistory> getAllBalanceFluctuations() {

        String query = "SELECT t.id, t.residualRange,a.userName, t.description, t.createAt FROM transaction_history t JOIN accounts a ON t.idAccount = a.id where t.status=1";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> handle.createQuery(query)
                .map((rs, ctx) -> new TransactionHistory(
                        rs.getInt("id"),
                        rs.getString("userName"),
                        rs.getString("residualRange"),
                        rs.getString("description"),
                        rs.getTimestamp("createAt").toLocalDateTime()))
                .list());

    }

    public static void main(String[] args) {

    }
}
