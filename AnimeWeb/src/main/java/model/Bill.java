package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class Bill {
    private int id;
    private String fullName;
    private int idAccount;
    private int bill_num;
    private LocalDateTime createAt;
    private String hash;
    private List<Bill_detail> billDetail;
    private double totalPrice;
    private int isPurchased;
    private int isDelete;
    private String publicKey;

    public String getPublicKey() {
        return publicKey;
    }

    public void setPublicKey(String publicKey) {
        this.publicKey = publicKey;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Bill() {

    }

    @Override
    public String toString() {
        return "Bill{" +
                "idAccount=" + idAccount +
                ", bill_num=" + bill_num +
                ", billDetail=" + billDetail +
                ", totalPrice=" + totalPrice +
                ", publicKey='" + publicKey + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIsPurchased() {
        return isPurchased;
    }

    public void setIsPurchased(int isPurchased) {
        this.isPurchased = isPurchased;
    }

    public int getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(int isDelete) {
        this.isDelete = isDelete;
    }


    public LocalDateTime getCreateAt() {
        return createAt;
    }

    public String getFormattedCreateAt() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return createAt.format(formatter);
    }

    public void setCreateAt(LocalDateTime createAt) {
        this.createAt = createAt;
    }

    public Bill(int idAccount, int bill_num, LocalDateTime createAt, String hash) {
        this.idAccount = idAccount;
        this.bill_num = bill_num;
        this.createAt = createAt;
        this.hash = hash;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getIdAccount() {
        return idAccount;
    }

    public List<Bill_detail> getBillDetail() {
        return billDetail;
    }

    public void setBillDetail(List<Bill_detail> billDetail) {
        this.billDetail = billDetail;
    }

    public void setIdAccount(int idAccount) {
        this.idAccount = idAccount;
    }

    public int getBill_num() {
        return bill_num;
    }

    public void setBill_num(int bill_num) {
        this.bill_num = bill_num;
    }


    public String getHash() {
        return hash;
    }

    public void setHash(String hash) {
        this.hash = hash;
    }
}
