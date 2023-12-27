package model;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import database.DAOKey;

import java.time.LocalDateTime;

public class Key {
    private int id;
    private int idAccount;
    private String userName;
    private String key;
    private LocalDateTime dayReceive;
    private LocalDateTime dayExpired;
    private LocalDateTime dayCanceled;
    private int status;
    private String statusDescription;

    public Key() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdAccount() {
        return idAccount;
    }

    public void setIdAccount(int idAccount) {
        this.idAccount = idAccount;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public LocalDateTime getDayReceive() {
        return dayReceive;
    }

    public void setDayReceive(LocalDateTime dayReceive) {
//        dayReceiveString =  formatLocalDateTime(dayReceive,formatter);
        this.dayReceive = dayReceive;
    }

    public LocalDateTime getDayExpired() {
        return dayExpired;
    }

    public void setDayExpired(LocalDateTime dayExpired) {
//        dayExpiredString =  formatLocalDateTime(dayExpired,formatter);
        this.dayExpired = dayExpired;
    }

    public LocalDateTime getDayCanceled() {
        return dayCanceled;
    }

    public void setDayCanceled(LocalDateTime dayCanceled) {
//        dayCanceledString =  dayCanceled!=null?formatLocalDateTime(dayCanceled,formatter):"";
        this.dayCanceled = dayCanceled;
    }



    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
        if(status==1){
            statusDescription = "Đang được sử dụng";
        }else{
            statusDescription = "Đã hết hạn";
        }
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getStatusDescription() {
        return statusDescription;
    }

    public void setStatusDescription(String statusDescription) {
        this.statusDescription = statusDescription;
    }

    @Override
    public String toString() {
        return "Key{" +
                "id=" + id +
                ", idAccount=" + idAccount +
                ", userName='" + userName + '\'' +
                ", key='" + key + '\'' +
                ", dayReceive=" + dayReceive +
                ", dayExpired=" + dayExpired +
                ", dayCanceled=" + dayCanceled +
                ", status=" + status +
                ", statusDescription='" + statusDescription + '\'' +
                '}';
    }

    public static void main(String[] args) {
        Key key = DAOKey.accountKeyNow(1);
        Gson gson = new GsonBuilder().registerTypeAdapter(LocalDateTime.class,new LocalDateTimeAdapter()).create();
       System.out.println(gson.toJson(key));
    }
}
