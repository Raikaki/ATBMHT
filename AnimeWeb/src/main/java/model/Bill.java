package model;

import java.time.LocalDateTime;
import java.util.List;

public class Bill {
    private int id;
    private int idAccount;
    private int bill_num;
    private LocalDateTime creatAt;
    private String hash;
    private List<Bill_detail> billDetail ;
    private double totalPrice;
    private int isPurchased;
    private int isDelete;

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

    @Override
    public String toString() {
        return "Bill{" +
                "id=" + id +
                ", idAccount=" + idAccount +
                ", bill_num=" + bill_num +
                ", creatAt=" + creatAt +
                ", hash='" + hash + '\'' +
                ", billDetail=" + billDetail +
                ", totalPrice=" + totalPrice +
                ", isPurchased=" + isPurchased +
                ", isDelete=" + isDelete +
                '}';
    }

    public Bill(int idAccount, int bill_num, LocalDateTime creatAt, String hash) {
        this.idAccount = idAccount;
        this.bill_num = bill_num;
        this.creatAt = creatAt;
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

    public LocalDateTime getCreatAt() {
        return creatAt;
    }

    public void setCreatAt(LocalDateTime creatAt) {
        this.creatAt = creatAt;
    }

    public String getHash() {
        return hash;
    }

    public void setHash(String hash) {
        this.hash = hash;
    }
}
