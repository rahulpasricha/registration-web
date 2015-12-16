package com.registration.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MvcController {

	@RequestMapping(value = { "/", "/home**" }, method = RequestMethod.GET)
	public ModelAndView homePage() {
		return new ModelAndView("home");
	}
	
	@RequestMapping(value = { "/gallery**" }, method = RequestMethod.GET)
	public ModelAndView galleryPage() {
		return new ModelAndView("gallery");
	}

	@RequestMapping(value = "/admin**", method = RequestMethod.GET)
	public ModelAndView adminPage() {
		return new ModelAndView("admin");
	}
	
	@RequestMapping(value = "/resetpassword**", method = RequestMethod.GET)
	public ModelAndView resetPasswordPage() {
		return new ModelAndView("resetpassword");
	}
	
	@RequestMapping(value = "/user**", method = RequestMethod.GET)
	public ModelAndView userPage() {
		return new ModelAndView("user");
	}

	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public ModelAndView login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout) {

		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error", "Invalid username and password!");
		}

		if (logout != null) {
			model.addObject("logout", "You've been logged out successfully.");
		}
		model.setViewName("signup");

		return model;

	}

}