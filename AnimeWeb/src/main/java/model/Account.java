package model;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.Principal;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.google.common.collect.HashMultiset;
import com.google.common.collect.Multiset;
import database.DAOAccounts;
import security.PermissionValidate;
import security.PrivateResource;

import javax.crypto.spec.PSource;
import javax.security.auth.Subject;


public class Account {
	private int id;
	private String userName;
	private String password;
	private String email;
	private String avatar;
	private AccountType type;
	private int isActive;
	private List<Role> roles;
	private List<Movie> moviesFollow;
	private List<Movie> moviesPurchased;
	private List<Bill> listBill;
	private LocalDateTime joinDate;

	public List<Bill> getListBill() {
		return listBill;
	}

	public void setListBill(List<Bill> listBill) {
		this.listBill = listBill;
	}

	private String fullName;
	private String phone;
	private double balance;
	private int status;
	private String externalId;
	private boolean isManagement;
	private boolean isAdmin;

	static Map<Integer, String> isActiveMapping = new HashMap<>();
	static {
		isActiveMapping.put(0, "Bị khóa");
		isActiveMapping.put(1, "Đang hoạt động");
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public void setAdmin(boolean admin) {
		isAdmin = admin;
	}

	public boolean isManagement() {
		return isManagement;
	}

	public void setManagement(boolean management) {
		isManagement = management;
	}

	public static int LOCK = 0;
	public static int ACTIVED = 1;
	public Account() {
	}
	public Account(int id) {
		this.id = id;
	}
	public static String getIsActiveDescription(int idIsActive) {
		return isActiveMapping.get(idIsActive);
	}

	public String getFullJoinDate() {
		return joinDate.getDayOfMonth()+"/"+joinDate.getMonthValue()+"/"+joinDate.getYear();
	}


	public String getTypeAccount(){
		return type.getDescription();
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public List<Movie> getMoviesPurchased() {
		return moviesPurchased;
	}

	public void setMoviesPurchased(List<Movie> moviesPurchased) {
		this.moviesPurchased = moviesPurchased;
	}

	public Account(LocalDateTime date) {
		this.joinDate = date;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String passWord) {
		this.password = passWord;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}



	public int getIsActive() {
		return isActive;
	}
	public String getIsActiveDescription() {
		return isActiveMapping.get(isActive);
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
		for(Role role : roles){
			if(role.getId()==6){
				this.isAdmin=true;
				this.isManagement=true;
				return;
			}
		}
		if(!isAdmin){
			this.isManagement =PermissionValidate.userHasPermission(this, PrivateResource.PRIVATE_RESOURCE.get("dashBoard"));
		}
	}

	public List<Movie> getMoviesFollow() {
		return moviesFollow;
	}

	public void setMoviesFollow(List<Movie> moviesFollow) {
		this.moviesFollow = moviesFollow;
	}

	public LocalDateTime getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(LocalDateTime joinDate) {
		this.joinDate = joinDate;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phoneNumber) {
		this.phone = phoneNumber;
	}

	public AccountType getType() {
		return type;
	}

	public void setType(AccountType type) {
		this.type = type;
	}

	public double getBalance() {
		return balance;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}

	public String getExternalId() {
		return externalId;
	}

	public void setExternalId(String externalId) {
		this.externalId = externalId;
	}
	public String getBalanceFluctuations(double balanceFluctuations){
		String formattedNumber = String.format("%,.0f", balanceFluctuations);
		String rs ="";
		rs = "-"+ formattedNumber ;
		return rs;
	}
	public static String fluctuationsIncreaseBalance(double balanceFluctuations){
		String rs ="";
		String formattedNumber = String.format("%,.0f", balanceFluctuations);
		rs = "+"+ formattedNumber;
		return rs;
	}


	@Override
	public String toString() {
		return "Account{" +
				"id=" + id +
				", userName='" + userName + '\'' +
				", password='" + password + '\'' +
				", email='" + email + '\'' +
				", avatar='" + avatar + '\'' +
				", type=" + type +
				", isActive=" + isActive +
				", roles=" + roles +
				", moviesFollow=" + moviesFollow +
				", moviesPurchased=" + moviesPurchased +
				", joinDate=" + joinDate +
				", fullName='" + fullName + '\'' +
				", phone='" + phone + '\'' +
				", balance=" + balance +
				", status=" + status +
				", externalId='" + externalId + '\'' +
				'}';
	}



}