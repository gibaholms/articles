package com.wordpress.gibaholms;

import java.util.Date;

public class SiebelToken {

	private String token;
	private Date creationDate;

	public SiebelToken(String token, Date creationDate) {
		this.token = token;
		this.creationDate = creationDate;
	}
	
	public SiebelToken(String token) {
		this(token, new Date());
	}
	
	@Override
	public String toString() {
		return "SiebelToken [token=" + token + ", creationDate=" + creationDate + "]";
	}

	public String getToken() {
		return token;
	}

	public Date getCreationDate() {
		return creationDate;
	}

}
