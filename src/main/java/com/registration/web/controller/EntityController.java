package com.registration.web.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.registration.web.exception.FoosballException;
import com.registration.web.model.Rating;
import com.registration.web.model.Team;
import com.registration.web.model.UpdatedRates;
import com.registration.web.model.User;
import com.registration.web.service.EntityService;

@Controller
public class EntityController {

	@Resource
	private EntityService entityService;

	@RequestMapping(value = "/getAllFoosballUsers.fd", method = RequestMethod.GET)
	public @ResponseBody List<User> getAllFoosballusers() {
		return entityService.getAllFoosballusers();
	}

	@RequestMapping(value = "/createFoosballUser.fd", method = RequestMethod.POST)
	public @ResponseBody User create(@RequestBody User user, HttpServletResponse response) throws FoosballException {
		User userObject = null;
		try {
			userObject = entityService.create(user);
		} catch (FoosballException e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			try {
				response.getWriter().write(((FoosballException) e).getErrorMessage());
				response.flushBuffer();
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		return userObject;
	}
	
	@RequestMapping(value = "/getTeamMasterdata", method = RequestMethod.GET)
	public @ResponseBody List<String> getTeamMasterdata() {
		return entityService.getTeamMasterdata();
	}
	
	@RequestMapping(value = "/getAllTeams.fd", method = RequestMethod.GET)
	public @ResponseBody List<Team> getAllTeams() {
		return entityService.getAllTeams();
	}
	
	@RequestMapping(value = "/getRatings/{username}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody List<Rating> getUserRatings(@PathVariable("username") String username) {
		return entityService.getUsersToRate(username);
	}
	
	@RequestMapping(value = "/updateRatings", method = RequestMethod.POST)
	public @ResponseBody boolean updateUserRatings(@RequestBody UpdatedRates updatedRates, HttpServletResponse response) {
		return entityService.updateUserRatings(updatedRates.getUsername(), updatedRates.getRatings());
	}
	
	@RequestMapping(value = "/resetPassword.fd", method = RequestMethod.POST)
	public @ResponseBody boolean resetPassword(@RequestBody User user, HttpServletResponse response) throws FoosballException {
		try {
			entityService.resetPassword(user);
		} catch (FoosballException e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			try {
				response.getWriter().write(((FoosballException) e).getErrorMessage());
				response.flushBuffer();
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		return true;
	}
	
	@RequestMapping(value = "/getFlagToAllowRatingUpdate", method = RequestMethod.GET)
	public @ResponseBody String getFlagToAllowRatingUpdate() {
		return entityService.getFlagToAllowRatingUpdate();
	}
	
	@RequestMapping(value = "/getFlagToAllowTeamNameUpdate", method = RequestMethod.GET)
	public @ResponseBody String getFlagToAllowTeamNameUpdate() {
		return entityService.getFlagToAllowTeamNameUpdate();
	}
	
	@RequestMapping(value = "/getFlagToAllowCreateUser", method=RequestMethod.GET)
	public @ResponseBody String getFlagToAllowCreateUser() {
		return entityService.getFlagToAllowCreateUser();
	}
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/updateflag/{flag}/{value}", method = RequestMethod.POST)
	public @ResponseBody String updateFlag(@PathVariable("flag") String flag, @PathVariable("value") String value) {
		Integer count = entityService.updateFlag(flag, value);
		return count.toString();
	}
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/buildteam", method = RequestMethod.POST)
	public @ResponseBody String buildTeam() {
		Integer count = entityService.buildTeam();
		return count.toString();
	}
	
	@RequestMapping(value = "/getRsvpStatus/{username}", method = RequestMethod.GET)
	public @ResponseBody String getRsvpStatus(@PathVariable("username") String username) {
		return entityService.getRsvpStatus(username);
	}
	
	@RequestMapping(value = "/getNinjaStatus/{username}", method = RequestMethod.GET)
	public @ResponseBody String getNinjaStatus(@PathVariable("username") String username) {
		return entityService.getNinjaStatus(username);
	}
	
	@RequestMapping(value = "/updateRsvpStatus/{username}/{flag}", method = RequestMethod.POST)
	public @ResponseBody boolean updateRsvpStatus(@PathVariable("username") String username, @PathVariable("flag") String flag) {
		return entityService.updateRsvpStatus(username, flag.equals("true") ? true : false);
	}
	
	@RequestMapping(value = "/updateNinjaStatus/{username}/{flag}", method = RequestMethod.POST)
	public @ResponseBody boolean updateNinjaStatus(@PathVariable("username") String username, @PathVariable("flag") String flag) {
		return entityService.updateNinjaStatus(username, flag.equals("true") ? true : false);
	}
	
	@RequestMapping(value = "/foosballuser/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public User findOne(@PathVariable("id") Integer id) {
		return entityService.findById(id);
	}

	@RequestMapping(value = "/foosballuser/{id}", method = RequestMethod.PUT, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public User update(@PathVariable("id") Integer id, @RequestBody User user) {
		return entityService.update(user);
	}

	@RequestMapping(value = "/foosballuser/{id}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public void delete(@PathVariable("id") Integer id) {
		entityService.delete(id);
	}

}
