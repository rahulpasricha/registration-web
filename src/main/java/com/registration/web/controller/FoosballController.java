/* Project Connect
 * Copyright (c) 2011 Deutsche Post DHL
 * All rights reserved.
 */

package com.registration.web.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.registration.web.service.EntityService;

/**
 * Returns JSON for foosball tournament bracket.
 *
 * @author rpasricha
 */
@Controller
public class FoosballController {
	
	@Resource
	private EntityService entityService;

    @RequestMapping(value = "/getfoosball.html", method = RequestMethod.GET)
    @ResponseBody
    public String getFoosball() {
    	return entityService.getJsonResultSet();
    }

    @RequestMapping(value = "/postfoosball.html", method = RequestMethod.POST)
    public @ResponseBody String postFoosball(@RequestBody String json) {
    	String updatedJson = entityService.updateJsonResultSet(json);
    	return updatedJson;
    }

}
