package com.registration.web.model;

import java.io.Serializable;

public class Rating implements Serializable{

	private static final long serialVersionUID = -5514575205551255674L;

	private Integer userId;
	
	private String foosballPlayerName;
	
	private int rating;

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getFoosballPlayerName() {
		return foosballPlayerName;
	}

	public void setFoosballPlayerName(String foosballPlayerName) {
		this.foosballPlayerName = foosballPlayerName;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}
	
	

}
