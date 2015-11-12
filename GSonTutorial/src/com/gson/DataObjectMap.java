package com.gson;

import java.util.HashMap;

public class DataObjectMap {
	
	private String name;
	private Integer age;
	private String seat;
	private HashMap oHashMap;
	
	@Override
	public String toString() {
		return "DataObjectMap [name=" + name + ", age=" + age + ", seat=" + seat + ", oHashMap=" + oHashMap + "]";
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public String getSeat() {
		return seat;
	}
	public void setSeat(String seat) {
		this.seat = seat;
	}
	public HashMap getoHashMap() {
		return oHashMap;
	}
	public void setoHashMap(HashMap oHashMap) {
		this.oHashMap = oHashMap;
	}
}
