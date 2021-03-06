package com.yc.entity.user;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

//部门
@Entity
@DiscriminatorValue("department")
@JsonIgnoreProperties(value = { "departAndPositions","children" })
public class Department {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer departmentID;// 部门ID

	@Column(length = 32)
	private String departmentName;// 部门名称

	@Column
	private String describes; // 描述
	
	@Column
	private Integer level = 1;
	
	@ManyToOne(cascade = {CascadeType.MERGE,CascadeType.DETACH,CascadeType.PERSIST,CascadeType.REFRESH}, fetch = FetchType.EAGER)
	@JoinColumn(name = "parentLevel")
	private Department parentLevel;//父节点；
	
	@OneToMany(mappedBy = "parentLevel",cascade = CascadeType.ALL,fetch = FetchType.EAGER)
	private Set<Department> children = new HashSet<Department>();
	
	@OneToMany(mappedBy = "department")
	private List<Personnel> personnels;

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public Department getParentLevel() {
		return parentLevel;
	}

	public void setParentLevel(Department parentLevel) {
		this.parentLevel = parentLevel;
	}

	public Set<Department> getChildren() {
		return children;
	}

	public void setChildren(Set<Department> children) {
		this.children = children;
	}

	public Integer getDepartmentID() {
		return departmentID;
	}

	public void setDepartmentID(Integer departmentID) {
		this.departmentID = departmentID;
	}

	public String getDescribes() {
		return describes;
	}

	public void setDescribes(String describes) {
		this.describes = describes;
	}

	public List<Personnel> getPersonnels() {
		return personnels;
	}

	public void setPersonnels(List<Personnel> personnels) {
		this.personnels = personnels;
	}

}
