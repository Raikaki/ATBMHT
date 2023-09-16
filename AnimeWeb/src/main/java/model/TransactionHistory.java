package model;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class TransactionHistory {
    private int id;
    private String residualRange;
    private String userName;
    private String description;
    private LocalDateTime createAt;

    public TransactionHistory(String residualRange, String description, LocalDateTime createAt) {
        this.residualRange = residualRange;
        this.description = description;
        this.createAt = createAt;
    }

    public TransactionHistory(int id,String userName , String residualRange, String description, LocalDateTime createAt) {
        this.id = id;
        this.residualRange = residualRange;
        this.userName = userName;
        this.description = description;
        this.createAt = createAt;
    }

    @Override
    public String toString() {
        return "TransactionHistory{" +
                "id=" + id +
                ", residualRange='" + residualRange + '\'' +
                ", userName='" + userName + '\'' +
                ", description='" + description + '\'' +
                ", createAt=" + createAt +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public TransactionHistory(String  userName, String residualRange, String description, LocalDateTime createAt) {
        this.residualRange = residualRange;
        this.userName = userName;
        this.description = description;
        this.createAt = createAt;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getResidualRange() {
        return residualRange;
    }

    public void setResidualRange(String residualRange) {
        this.residualRange = residualRange;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

}