package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class PurchasedDetail {
    private int id;
    private String userName;
    private String moviePurchased;
    private LocalDateTime purchaseAt;
    private double price;

    public PurchasedDetail(int id, String userName, String moviePurchased, LocalDateTime purchaseAt, double price) {
        this.id = id;
        this.userName = userName;
        this.moviePurchased = moviePurchased;
        this.purchaseAt = purchaseAt;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public PurchasedDetail() {
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getMoviePurchased() {
        return moviePurchased;
    }

    public void setMoviePurchased(String moviePurchased) {
        this.moviePurchased = moviePurchased;
    }

    public LocalDateTime getPurchaseAt() {
        return purchaseAt;
    }

    public void setPurchaseAt(LocalDateTime purchaseAt) {
        this.purchaseAt = purchaseAt;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String changeFormat(){
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy   HH:mm:ss");
        String formattedDateTime = purchaseAt.format(formatter);
        return  formattedDateTime;
    }

    @Override
    public String toString() {
        return "PurchasedDetail{" +
                "id=" + id +
                ", userName='" + userName + '\'' +
                ", moviePurchased='" + moviePurchased + '\'' +
                ", purchaseAt=" + purchaseAt +
                ", price=" + price +
                '}';
    }
}
