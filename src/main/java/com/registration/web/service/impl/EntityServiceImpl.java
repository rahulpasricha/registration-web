package com.registration.web.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.TreeMap;

import javax.annotation.Resource;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.registration.web.bean.jpa.TeamBo;
import com.registration.web.bean.jpa.UserBo;
import com.registration.web.bean.jpa.UserRatingBo;
import com.registration.web.controller.dao.EntityDao;
import com.registration.web.exception.FoosballException;
import com.registration.web.model.Rating;
import com.registration.web.model.Team;
import com.registration.web.model.User;
import com.registration.web.service.EntityService;
import com.registration.web.util.EncryptionUtil;

@Service("entityService")
@Transactional
public class EntityServiceImpl implements EntityService {

    private static Random random = new Random();

	@Resource
	EntityDao entityDao;

	@Override
	public List<User> getAllFoosballusers() {
		List<User> users = new ArrayList<User>();

		List<UserBo> entities = entityDao.getAllFoosballusers();
		for (UserBo entity : entities) {
			User user = new User();

			user.setFirstName(entity.getFirstName());
			user.setLastName(entity.getLastName());
			user.setDepartment(entityDao.getTeamMasterDataName(entity.getTeammasterdata_id()));
			user.setRsvp(entity.isRsvp() ? "YES" : "NO");
			user.setNinja(entity.isNinja() ? "YES" : "NO");
			users.add(user);
		}

		return users;
	}

	@Override
	public User getUser(String userName) {
		UserBo userEntity = entityDao.getUser(userName);

		if (userEntity == null) {
			return null;
		}

		User user = new User();
		user.setUsername(userEntity.getUsername());
		user.setFirstName(userEntity.getFirstName());
		user.setLastName(userEntity.getLastName());
		user.setPassword(userEntity.getPassword());
		user.setAuthorities(AuthorityUtils.createAuthorityList(userEntity.getRole()));

		return user;
	}

	@Override
	public User create(User user) throws FoosballException {
		UserBo userEntity = entityDao.getUser(user.getUsername());

		if (userEntity != null) {
			throw new FoosballException("User already present in the system");
		}

		userEntity = new UserBo();
		userEntity.setUsername(user.getUsername());

		String encryptedPassword = null;
		try {
			encryptedPassword = EncryptionUtil.encrypt(user.getPassword());
		} catch (Exception e) {
			e.printStackTrace();
		}
		userEntity.setPassword(encryptedPassword);
		userEntity.setFirstName(user.getFirstName());
		userEntity.setLastName(user.getLastName());
		userEntity.setRole("ROLE_USER");
		userEntity.setLevel(0);
		userEntity.setTeammasterdata_id(entityDao.getTeamMasterDataId(user.getDepartment()));
		
		userEntity.setNinja(false);
		userEntity.setRsvp(true);

		entityDao.save(userEntity);

		return user;
	}

	@Override
	public List<Team> getAllTeams() {
		List<TeamBo> teams = entityDao.getAllTeams();

		List<Team> allTeams = new ArrayList<Team>();
		for (TeamBo eachTeam : teams) {
			Team team = new Team(eachTeam.getName());
			for (UserBo userBo : eachTeam.getUsers()) {
				team.getTeamMembers().add(userBo.getFirstName() + " " + userBo.getLastName());
			}
			allTeams.add(team);
		}

		return allTeams;
	}

	@Override
	public List<Rating> getUsersToRate(String username) {
		UserBo ratingUser = entityDao.getUser(username);
		if (ratingUser == null) {
			return null;
		}

		List<Rating> ratings = new ArrayList();
		for (UserBo foosballUser : entityDao.otherUsers(username)) {
			Rating rating;
			UserRatingBo ratedUser = entityDao.getUserRating(foosballUser.getId(), ratingUser.getId());
			if (ratedUser == null) {
				rating = convertToRating(foosballUser.getId(), foosballUser.getFirstName(), foosballUser.getLastName(), 0);
			} else {
				rating = convertToRating(ratedUser.getRatedUser().getId(), ratedUser.getRatedUser().getFirstName(), ratedUser.getRatedUser().getLastName(), ratedUser.getRating());
			}
			ratings.add(rating);
		}
		return ratings;

	}

	@Override
	public boolean updateUserRatings(String username, List<Rating> ratings) {
		UserBo ratingUserBo = entityDao.getUser(username);
		if (ratingUserBo == null) {
			return false;
		}
		for (Rating rating : ratings) {
			UserBo ratedUserBo = entityDao.getUser(rating.getUserId());
			UserRatingBo userRating = entityDao.getUserRating(ratedUserBo.getId(), ratingUserBo.getId());
			if (userRating == null) {
				userRating = new UserRatingBo();
				userRating.setRatedUser(ratedUserBo);
				userRating.setRatingUser(ratingUserBo);
			}
			userRating.setRating(rating.getRating());
			entityDao.save(userRating);
		}

		return true;
	}

	private Rating convertToRating(Integer userId, String firstname, String lastname, int rating) {
		Rating userRating = new Rating();
		userRating.setUserId(userId);
		userRating.setFoosballPlayerName(String.format("%s %s", firstname, lastname));
		userRating.setRating(rating);
		return userRating;
	}

	private List<Rating> convertRatingBoToVo(List<UserRatingBo> ratedUsers) {
		List<Rating> ratings = new ArrayList();
		for (UserRatingBo userRating : ratedUsers) {
			Rating rating = new Rating();
			rating.setUserId(userRating.getRatedUser().getId());
			rating.setFoosballPlayerName(String.format("%s %s", userRating.getRatedUser().getFirstName(), userRating.getRatedUser().getLastName()));
			rating.setRating(userRating.getRating());
			ratings.add(rating);
		}
		return ratings;
	}

	private List<Rating> createDefaultRatings(List<UserBo> otherUsers) {
		List<Rating> ratings = new ArrayList();
		for (UserBo user : otherUsers) {
			Rating userRating = new Rating();
			userRating.setUserId(user.getId());
			userRating.setFoosballPlayerName(String.format("%s %s", user.getFirstName(), user.getLastName()));
			ratings.add(userRating);
		}
		return ratings;
	}

	@Override
	public boolean resetPassword(User user) throws FoosballException {
		int count = 0;
		try {
			count = entityDao.resetPassword(user.getUsername(), EncryptionUtil.encrypt(user.getPassword()));
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (count == 0) {
			throw new FoosballException("Reset password failed. Entered username doesn't exists.");
		}
		return true;
	}

	@Override
	public String getFoosballScores() {
		StringBuilder strBuilder = new StringBuilder();
		strBuilder.append(createTeamJsonObject(entityDao.getAllTeams()));
		strBuilder.append("\"results\":");
		strBuilder.append(entityDao.getLatestJsonResultSet());
		return strBuilder.toString();
	}

	protected String createTeamJsonObject(List<TeamBo> teams) {
		StringBuilder strBuilder = new StringBuilder();
		int index = 1;
		strBuilder.append("{\"teams\":[");
		for (TeamBo team : teams) {
			if (index % 2 == 1) {
				strBuilder.append("[\"");
				strBuilder.append(team.getName());
				strBuilder.append("\",\"");
			} else {
				strBuilder.append(team.getName());
				strBuilder.append("\"]");
				if (index != teams.size()) {
					strBuilder.append(",");
				}
			}

			index++;
		}
		strBuilder.append("],");
		return strBuilder.toString();
	}

	@Override
	public String getJsonResultSet() {
		return entityDao.getJsonResultSet();
	}

	@Override
	public String updateJsonResultSet(String json) {
		return entityDao.updateJsonResultSet(json);
	}

	@Override
	public String getFlagToAllowRatingUpdate() {
		return entityDao.getFlagToAllowRatingUpdate();
	}

	@Override
	public String getFlagToAllowTeamNameUpdate() {
		return entityDao.getFlagToAllowTeamNameUpdate();
	}

	@Override
	public String getFlagToAllowCreateUser() {
		return entityDao.getFlagToAllowCreateUser();
	}

	@Override
	public int updateFlag(String flag, String value) {
		return entityDao.updateFlag(flag, value);

	}
	
	@Override
	public String getRsvpStatus(String username) {
		return entityDao.getRsvpStatus(username);
	}
	
	@Override
	public String getNinjaStatus(String username) {
		return entityDao.getNinjaStatus(username);
	}

	@Override
	public boolean updateRsvpStatus(String username, boolean flag) {
		return entityDao.updateRsvpStatus(username, flag);
	}
	
	@Override
	public boolean updateNinjaStatus(String username, boolean flag) {
		return entityDao.updateNinjaStatus(username, flag);
	}

	@Override
	public User findById(Integer id) {
		return null;
	}

	@Override
	public User save(User entity) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User update(User entity) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void delete(Integer id) {
		// TODO Auto-generated method stub

	}

	@Override
    public Integer buildTeam() {
        List< UserBo > users = entityDao.getAllFoosballusers();
        calculateAverageRating(users);
        UserBo[] shuffledUsers = shuffle(users);
        groupUsersInTeams(shuffledUsers);
        return shuffledUsers.length;
    }

    private void groupUsersInTeams(UserBo[] shuffledUsers) {
        List< Integer > blacklistTeamIds = Arrays.asList(1, 5, 9); // this is index, corresponding team id is index + 1
        List< TeamBo > teams = entityDao.getAllTeams();
        int teamIndex = 0;
        int start = 0;
        int end = shuffledUsers.length - 1;
        while (end > start) {

            if (blacklistTeamIds.contains(teamIndex)) {
                teamIndex++;
            }

            shuffledUsers[start].setTeam(teams.get(teamIndex));
            shuffledUsers[end].setTeam(teams.get(teamIndex));
            teamIndex++;
            start++;
            end--;
        }
    }

    private void calculateAverageRating(List< UserBo > users) {
        for (UserBo user : users) {
            List< UserRatingBo > ratings = user.getRatedUsers();
            int rateSum = 0;
            for (UserRatingBo rating : ratings) {
                rateSum += rating.getRating();
            }

            if (ratings.size() != 0) {
                double rate = (double) rateSum / ratings.size();
                user.setLevel((int) Math.round(rate));
            } else {
                user.setLevel(3);
            }
        }
    }

    private UserBo[] shuffle(List< UserBo > users) {
        TreeMap< Integer , ArrayList< UserBo > > map = new TreeMap<>();
        for (UserBo i : users) {
            if (!map.containsKey(i.getLevel())) { // key as median rating
                map.put(i.getLevel(), new ArrayList< UserBo >());
            }
            ArrayList< UserBo > existing = map.get(i.getLevel());
            existing.add(i);
            map.put(i.getLevel(), existing); // put value as FOOSBALL user
        }

        UserBo[] arr = new UserBo[users.size()];
        int start = -1;
        int end = -1;
        for (Map.Entry< Integer , ArrayList< UserBo > > entry : map.entrySet()) {
            start = end + 1;
            for (int i = 0; i < entry.getValue().size(); i++) {
                end++;
                arr[end] = entry.getValue().get(i);
            }

            int size = end - start + 1;
            for (int i = start; i <= end; i++) {
                int index = i + random.nextInt(size);
                size--;
                UserBo tmp = arr[i];
                arr[i] = arr[index];
                arr[index] = tmp;
            }
        }
        return arr;
    }

	@Override
	public List<String> getTeamMasterdata() {
		return entityDao.getTeamMasterdata();
	}

}
