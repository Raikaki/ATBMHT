package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ImportCoupon {
    private String movieName;
    private String supplierName;
    private double price;
    private LocalDateTime createAt;
private int id;
    public ImportCoupon(int id,String movieName, String supplierName, double price, LocalDateTime createAt) {
        this.id = id;
        this.movieName = movieName;
        this.supplierName = supplierName;
        this.price = price;
        this.createAt = createAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public LocalDateTime getCreateAt() {
        return createAt;
    }

    public void setCreateAt(LocalDateTime createAt) {
        this.createAt = createAt;
    }
    public String changeFormat(){
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy   HH:mm:ss");
        String formattedDateTime = createAt.format(formatter);
        return  formattedDateTime;
    }


    @Override
    public String toString() {
        return "ImportCoupon{" +
                "movieName='" + movieName + '\'' +
                ", supplierName='" + supplierName + '\'' +
                ", price=" + price +
                ", createAt=" + createAt +
                '}';
    }
}
