package model;

import java.time.LocalDateTime;

public class Bill {
    private int idAccount;
    private int bill_num;
    private LocalDateTime creatAt;
    private String hash;
    private Bill_detail billDetail ;

    @Override
    public String toString() {
        return "Bill{" +
                "idAccount=" + idAccount +
                ", bill_num=" + bill_num +
                ", creatAt=" + creatAt +
                ", hash='" + hash + '\'' +
                '}';
    }

    public Bill(int idAccount, int bill_num, LocalDateTime creatAt, String hash) {
        this.idAccount = idAccount;
        this.bill_num = bill_num;
        this.creatAt = creatAt;
        this.hash = hash;
    }

    public int getIdAccount() {
        return idAccount;
    }

    public Bill_detail getBillDetail() {
        return billDetail;
    }

    public void setBillDetail(Bill_detail billDetail) {
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
