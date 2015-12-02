package com.registration.web.bean.jpa;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "USER_RATINGS", schema = "REGISTRATION")
public class UserRatingBo {
	
	@Id 
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "ID", nullable = false)
	private Integer id;
	
	@ManyToOne
	@JoinColumn(name = "RATING_USER_ID")
	private UserBo ratingUser;
	
	@ManyToOne
	@JoinColumn(name = "RATED_USER_ID")
	private UserBo ratedUser;
	
	@Column(name = "RATING")
	private Integer rating;

	public UserBo getRatingUser() {
		return ratingUser;
	}

	public void setRatingUser(UserBo ratingUser) {
		this.ratingUser = ratingUser;
	}

	public UserBo getRatedUser() {
		return ratedUser;
	}

	public void setRatedUser(UserBo ratedUser) {
		this.ratedUser = ratedUser;
	}

	public Integer getRating() {
		return rating;
	}

	public void setRating(Integer rating) {
		this.rating = rating;
	}

	@Override
	public String toString() {
		return "UserRatingBo [id=" + id + ", ratingUser=" + ratingUser + ", ratedUser=" + ratedUser + ", rating="
				+ rating + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((ratedUser == null) ? 0 : ratedUser.hashCode());
		result = prime * result + ((ratingUser == null) ? 0 : ratingUser.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserRatingBo other = (UserRatingBo) obj;
		if (ratedUser == null) {
			if (other.ratedUser != null)
				return false;
		} else if (!ratedUser.equals(other.ratedUser))
			return false;
		if (ratingUser == null) {
			if (other.ratingUser != null)
				return false;
		} else if (!ratingUser.equals(other.ratingUser))
			return false;
		return true;
	}

		

}
