package model;

import java.util.ArrayList;
import java.util.List;

public class WishListDetail {

    private List<Movie> wishList;

    private double totalPrice;

    public WishListDetail() {
        wishList = new ArrayList<>();
    }



    public List<Movie> getWishList() {
        return wishList;
    }

    public void addMoive(Movie movie) {
        if (!wishList.contains(movie)) {
            wishList.add(movie);
        }
    }

    public void setWishList(List<Movie> wishList) {
        this.wishList = wishList;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Override
    public String toString() {
        return "WishListDetail{" +
                "wishList=" + wishList +
                ", totalPrice=" + totalPrice +
                '}';
    }
}
