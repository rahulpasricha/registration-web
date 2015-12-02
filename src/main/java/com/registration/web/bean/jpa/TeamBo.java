package com.registration.web.bean.jpa;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "TEAM", schema = "REGISTRATION")
public class TeamBo implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id 
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "ID", nullable = false)
	private Integer id;
	
	@Column(name = "TEAMNAME", length = 40)
	private String name;
	
	@OneToMany(mappedBy="team")
	private List<UserBo> users;
	
	public TeamBo() {
		super();
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

	public List<UserBo> getUsers() {
		return users;
	}

	public void setUsers(List<UserBo> users) {
		this.users = users;
	}
	
}
