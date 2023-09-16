package database;

import model.*;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.RowMapper;
import java.util.*;
public class DAODashBoard {
    public DAODashBoard() {
    }
    public static List<ImportCoupon> getListImportCoupons(){
        Jdbi me = JDBiConnector.me();
        String query ="SELECT m.name AS movieName, s.name AS supplierName, ic.price, ic.createAt ,ic.id " +
                "FROM movies m " +
                "JOIN import_coupons ic ON m.id = ic.idMovie " +
                "JOIN suppliers s ON s.id = ic.idSupplier where ic.status = 1";
        List<ImportCoupon> result = me.withHandle(handle -> {
            return handle.createQuery(query).map((rs, ctx) -> new ImportCoupon(rs.getInt("id"),
                    rs.getString("movieName"),
                    rs.getString("supplierName"),
                    rs.getDouble("price"),
                    rs.getTimestamp("createAt").toLocalDateTime()
            )).list();

        });
        return result;
    }
    public static int calculateTotalActiveUsers() {
        Jdbi me = JDBiConnector.me();
        String query = "SELECT COUNT(*) FROM accounts WHERE status = 1";
        return me.withHandle(handle -> handle.createQuery(query)
                .mapTo(Integer.class)
                .one());
    }
    public static int totalMovie(){
     String query=   "SELECT COUNT(*) AS total_movies FROM movies WHERE status = 1";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> handle.createQuery(query)
                .mapTo(Integer.class)
                .one());
    }
    public static int blockAccount(){
        Jdbi me = JDBiConnector.me();
        String query = "SELECT COUNT(*) FROM accounts WHERE isActive = 0";
        return me.withHandle(handle -> handle.createQuery(query)
                .mapTo(Integer.class)
                .one());
    }
public static int totalMoviePurchase(){
        String query = "SELECT COUNT(*) AS totalMoviesSold\n" +
                "FROM movies_purchased\n" +
                "WHERE status = 1";
    Jdbi me = JDBiConnector.me();
    return me.withHandle(handle -> handle.createQuery(query)
            .mapTo(Integer.class)
            .one());
}
    public static List<Movie> getTopPurchasedMovies() {
        Jdbi me = JDBiConnector.me();
        String query = "SELECT m.id AS id, m.name AS name, m.price AS price, COUNT(*) AS totalPurchases \n" +
                "FROM movies m \n" +
                "JOIN movies_purchased p ON m.id = p.idMovie \n" +
                "WHERE p.status = 1 AND m.status = 1 \n" +
                "AND MONTH(p.purchaseAt) = MONTH(CURRENT_DATE()) \n" +
                "GROUP BY m.id, m.name, m.price \n" +
                "ORDER BY COUNT(*) DESC \n" +
                "LIMIT 10";

        List<Movie> result = me.withHandle(handle -> {
            return handle.createQuery(query).map((rs, ctx) -> {
                Movie movie = new Movie();
                movie.setId(rs.getInt("id"));
                movie.setName(rs.getString("name"));
                movie.setPrice(rs.getDouble("price"));
                movie.setTotalPurchased(rs.getDouble("totalPurchases"));
                return movie;
            }).list();
        });

        for (Movie m : result) {
            m.setAvatars(DAOMovie.getAvatarMovie(m.getId()));
            m.setGenres(DAOMovie.getListGenre(m.getId()));
            m.setType(DAOMovie.getTypeMovie(m.getId()));
            m.setViews(DAOMovie.getViewsMovie(m.getId()));
        }

        return result;
    }
    public static List<Movie> getTopPurchasedMoviesYear() {
        Jdbi me = JDBiConnector.me();
        String query = "SELECT m.id AS id, m.name AS name, m.price AS price, COUNT(*) AS totalPurchases \n" +
                "FROM movies m \n" +
                "JOIN movies_purchased p ON m.id = p.idMovie \n" +
                "WHERE p.status = 1 AND m.status = 1 \n" +
                "AND YEAR(p.purchaseAt) = YEAR(CURRENT_DATE()) \n" +
                "GROUP BY m.id, m.name, m.price \n" +
                "ORDER BY COUNT(*) DESC \n" +
                "LIMIT 10";

        List<Movie> result = me.withHandle(handle -> {
            return handle.createQuery(query).map((rs, ctx) -> {
                Movie movie = new Movie();
                movie.setId(rs.getInt("id"));
                movie.setName(rs.getString("name"));
                movie.setPrice(rs.getDouble("price"));
                movie.setTotalPurchased(rs.getDouble("totalPurchases"));
                return movie;
            }).list();
        });

        for (Movie m : result) {
            m.setAvatars(DAOMovie.getAvatarMovie(m.getId()));
            m.setGenres(DAOMovie.getListGenre(m.getId()));
            m.setType(DAOMovie.getTypeMovie(m.getId()));
            m.setViews(DAOMovie.getViewsMovie(m.getId()));
        }

        return result;
    }
    public static List<Movie> getTopNotPurchasedMovies() {
        Jdbi me = JDBiConnector.me();
        String query = "SELECT m.id AS id, m.name AS name, m.price AS price, COUNT(p.id) AS totalPurchases \n" +
                "FROM movies m \n" +
                "LEFT JOIN movies_purchased p ON m.id = p.idMovie AND p.status = 1 \n" +
                "WHERE m.status = 1 and m.typeID = 2 \n" +
                "GROUP BY m.id, m.name, m.price \n" +
                "HAVING COUNT(p.id) <= 1 \n" +
                "LIMIT 10";

        List<Movie> result = me.withHandle(handle -> {
            return handle.createQuery(query).map((rs, ctx) -> {
                Movie movie = new Movie();
                movie.setId(rs.getInt("id"));
                movie.setName(rs.getString("name"));
                movie.setPrice(rs.getDouble("price"));
                movie.setTotalPurchased(rs.getInt("totalPurchases"));
                return movie;
            }).list();
        });

        for (Movie m : result) {
            m.setAvatars(DAOMovie.getAvatarMovie(m.getId()));
            m.setGenres(DAOMovie.getListGenre(m.getId()));
            m.setType(DAOMovie.getTypeMovie(m.getId()));
            m.setViews(DAOMovie.getViewsMovie(m.getId()));
        }

        return result;
    }
    public static void main(String[] args) {
        System.out.println(getListImportCoupons());
    }
}
