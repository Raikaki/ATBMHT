package model;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

public class AccountFaceBook {
	private String idFB;
	private String userNameFB;
	private String userID;
	private String gmailFB;

	public String getIdFB() {
		return idFB;
	}

	
	public void setIdFB(String idFB) {
		this.idFB = idFB;
	}

	public String getUserNameFB() {
		return userNameFB;
	}

	public void setUserNameFB(String userNameFB) {
		this.userNameFB = userNameFB;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getGmailFB() {
		return gmailFB;
	}

	public void setGmailFB(String gmailFB) {
		this.gmailFB = gmailFB;
	}


}
