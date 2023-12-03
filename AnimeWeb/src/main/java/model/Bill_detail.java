package model;


import database.DAOMovie;

import java.util.List;

public class Bill_detail {
    private int idBill;
    private Movie movie;
    private double price;
    private int status;
    private int idMovie;

    public Bill_detail() {
    }

    public int getIdBill() {
        return idBill;
    }

    public void setIdBill(int idBill) {
        this.idBill = idBill;
    }

    public int getIdMovie() {
        return idMovie;
    }

    public void setIdMovie(int idMovie) {
        this.idMovie = idMovie;
        this.movie = DAOMovie.getMoviebyId(idMovie);
    }

    public Movie getMovie() {
        return movie;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Bill_detail{" +
                "idBill=" + idBill +
                ", movie=" + movie +
                ", price=" + price +
                ", status=" + status +
                '}';
    }
}