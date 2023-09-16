package model;

import java.time.LocalDateTime;
import java.util.List;

public class Bonus {
    private int id;
    private String description;
    private LocalDateTime dayBegin;
    private LocalDateTime dayEnd;
    private double percent;
    private LocalDateTime createAt;
    private LocalDateTime deleteAt;
    private LocalDateTime updateAt;
    private int status;
    private String statusString;
    private List<Movie> bonusMovie;

    public Bonus() {
    }

    public List<Movie> getBonusMovie() {
        return bonusMovie;
    }

    public void setBonusMovie(List<Movie> bonusMovie) {
        this.bonusMovie = bonusMovie;
    }

    public String getStatusString() {
        return statusString;
    }

    public void setStatusString(String statusString) {
        this.statusString = statusString;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getDayBegin() {
        return dayBegin;
    }

    public void setDayBegin(LocalDateTime dayBegin) {
        this.dayBegin = dayBegin;
    }

    public LocalDateTime getDayEnd() {
        return dayEnd;
    }

    public void setDayEnd(LocalDateTime dayEnd) {
        this.dayEnd = dayEnd;
    }

    public double getPercent() {
        return percent;
    }

    public void setPercent(double percent) {
        this.percent = percent;
    }

    public LocalDateTime getCreateAt() {
        return createAt;
    }

    public void setCreateAt(LocalDateTime createAt) {
        this.createAt = createAt;
    }

    public LocalDateTime getDeleteAt() {
        return deleteAt;
    }

    public void setDeleteAt(LocalDateTime deleteAt) {
        this.deleteAt = deleteAt;
    }

    public LocalDateTime getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(LocalDateTime updateAt) {
        this.updateAt = updateAt;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
        this.statusString = Status.statusMapping.get(status);
    }

    @Override
    public String toString() {
        return "Bonus{" +
                "id=" + id +
                ", description='" + description + '\'' +
                ", dayBegin=" + dayBegin +
                ", dayEnd=" + dayEnd +
                ", percent=" + percent +
                ", createAt=" + createAt +
                ", deleteAt=" + deleteAt +
                ", updateAt=" + updateAt +
                ", status=" + status +
                '}';
    }


}
