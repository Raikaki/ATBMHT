package model;

import java.security.MessageDigest;
import java.util.Random;


import org.apache.commons.codec.binary.Base64;


public class Encode {
 public String toSHA1(String st) {
	 String result = null;
	 String begin = "hhtqiDkue;]asdwqvbt[dawe,.123";
	 String end = "dasrfwetyqwertyuivbnm@!$^^";
	 st = begin + st + end;
	 try {
		byte[] dataBytes =st.getBytes("UTF-8");
		MessageDigest md = MessageDigest.getInstance("SHA-1");
		result = Base64.encodeBase64String(md.digest(dataBytes));
		
	} catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	return result;
 }
 public static String generateNumber() {
	 Random random = new Random();
     int randomNumber = random.nextInt(100000000); 
     String formattedRandomNumber = String.format("%08d", randomNumber);
     return formattedRandomNumber;
 }
 public static void main(String[] args) {

}
}
