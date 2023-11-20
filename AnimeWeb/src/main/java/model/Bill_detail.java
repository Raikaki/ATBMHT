package model;


import java.util.List;

public class Bill_detail {

    private List<Movie> movie_list;
    private double totalPrice;

    public Bill_detail(List<Movie> movie_list, double totalPrice) {
        this.movie_list = movie_list;
        this.totalPrice = totalPrice;
    }

    public List<Movie> getMovie_list() {
        return movie_list;
    }

    public void setMovie_list(List<Movie> movie_list) {
        this.movie_list = movie_list;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
}