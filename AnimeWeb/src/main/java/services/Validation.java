package services;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validation {
	public Validation() {
		
	}
	public boolean validatePassword(String password) {
		String passwordPattern = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#&()–[{}]:;',?/*~$^+=<>]).{8,20}$";
		Pattern pattern;
		Matcher matcher;
		pattern = Pattern.compile(passwordPattern);
		matcher = pattern.matcher(password);
		return matcher.matches();
	}
}
