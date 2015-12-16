package com.registration.web.service;

import java.util.List;

import com.registration.web.exception.FoosballException;
import com.registration.web.model.Rating;
import com.registration.web.model.Team;
import com.registration.web.model.User;

public interface EntityService { 
	
	List<User> getAllFoosballusers();
	User findById(Integer id);
	User save(User entity);
	User update(User entity);
	User create(User entity) throws FoosballException;
	void delete( Integer id );
	User getUser(String userName);
	
	boolean resetPassword(User user) throws FoosballException;
	
	List<Team> getAllTeams();
	
	List<Rating> getUsersToRate(String username);
	boolean updateUserRatings(String username, List<Rating> ratings);
	String getFoosballScores();
	
	String getJsonResultSet();
	String updateJsonResultSet(String json);
	
	String getFlagToAllowRatingUpdate();
	String getFlagToAllowTeamNameUpdate();
	String getFlagToAllowCreateUser();
	int updateFlag(String flag, String value);
	
	Integer buildTeam();
	
	String getRsvpStatus(String username);
	boolean updateRsvpStatus(String username, boolean flag);
	String getNinjaStatus(String username);
	boolean updateNinjaStatus(String username, boolean flag);
	String getPresentExchangeStatus(String username);
	boolean updatePresentExchangeStatus(String username, boolean flag);
	
	List<String> getTeamMasterdata();
	
	List<User> getAllPresentExchangeUsers();
	String getHolidayJingle(String username);
	boolean updateHolidayJingle(String username, String jingle);
	List<User> getAllHolidayJingleUsers();
	
}
