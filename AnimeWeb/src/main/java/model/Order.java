package model;

import java.util.ArrayList;
import java.util.List;

public class Order {
    private List<Movie> selectedMovies;
    private double totalPrice;

    public Order() {
        selectedMovies = new ArrayList<>();
        totalPrice = 0;
    }


    public void addMovie(Movie movie) {
        selectedMovies.add(movie);
        totalPrice += movie.getCalPrice();
    }

    public void removeMovie(Movie movie) {
        selectedMovies.remove(movie);

    }

    public List<Movie> getSelectedMovies() {
        return selectedMovies;
    }

    public void setSelectedMovies(List<Movie> selectedMovies) {
        this.selectedMovies = selectedMovies;
    }

    public double getTotalPrice() {
        return totalPrice;
    }
    public void clearSelectedMovies() {
        selectedMovies.clear();
    }
    public List<String> getSelectedMovieNames() {
        List<String> movieNames = new ArrayList<>();
        for (Movie movie : selectedMovies) {
            movieNames.add(movie.getName());
        }
        return movieNames;
    }
    public void removeName(String name){

        for (Movie m : selectedMovies) {
            if(m.getName().equals(name)){
                this.getSelectedMovieNames().remove(m.getName());
            }
        }

    }



    @Override
    public String toString() {
        return "Order{" +
                "selectedMovies=" + selectedMovies +
                ", totalPrice=" + totalPrice +
                '}';
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
}
