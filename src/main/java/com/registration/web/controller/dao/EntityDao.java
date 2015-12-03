package com.registration.web.controller.dao;

import java.util.List;

import com.registration.web.bean.jpa.TeamBo;
import com.registration.web.bean.jpa.UserBo;
import com.registration.web.bean.jpa.UserRatingBo;
import com.registration.web.model.User;

public interface EntityDao {
	
	List<UserBo> getAllFoosballusers();
	UserBo findById(Integer id);
	UserBo save(UserBo userEntity);
	UserBo update(User entity);
	UserBo create(User entity);
	void delete( Integer id );
	UserBo getUser(String userName);
	void save(UserRatingBo userRatings);
	
	int resetPassword(String username, String password);
	
	List<TeamBo> getAllTeams();
	UserBo getUser(Integer id);
	List<UserBo> otherUsers(String username);
	String getLatestJsonResultSet();
	
	String getJsonResultSet();
	String updateJsonResultSet(String json);
	
	String getFlagToAllowRatingUpdate();
	String getFlagToAllowTeamNameUpdate();
	String getFlagToAllowCreateUser();
	int updateFlag(String flag, String value);
	UserRatingBo getUserRating(int ratedUserId, int ratingUserId);
	List<UserRatingBo> getUserRatings(String username);
	
	String getRsvpStatus(String username);
	String getNinjaStatus(String username);
	boolean updateRsvpStatus(String username, boolean flag);
	boolean updateNinjaStatus(String username, boolean flag);
	List<String> getTeamMasterdata();
	Integer getTeamMasterDataId(String department);
	String getTeamMasterDataName(Integer teammasterdata_id);
	
}
