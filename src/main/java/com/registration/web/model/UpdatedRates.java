package com.registration.web.model;

import java.io.Serializable;
import java.util.List;

public class UpdatedRates implements Serializable {

	private static final long serialVersionUID = 2727908963468534747L;
	
	private List<Rating> ratings;
	
	private String username;

	public List<Rating> getRatings() {
		return ratings;
	}

	public void setRatings(List<Rating> ratings) {
		this.ratings = ratings;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

}
