package com.registration.web.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class Team implements Serializable {

	private static final long serialVersionUID = 1L;
	@NotNull
	private Integer id;
	@Size(max = 40)
	private String name;
	@Size(max = 40)
	private List<String> teamMembers = new ArrayList<String>();
	
	public Team(String name) {
		this.name = name;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return this.id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<String> getTeamMembers() {
		return teamMembers;
	}

	public void setTeamMembers(List<String> teamMembers) {
		this.teamMembers = teamMembers;
	}
}
