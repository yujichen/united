package com.gson;

import javax.annotation.Generated;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Generated("org.jsonschema2pojo")
public class DataObjectAuto {

@SerializedName("name")
@Expose
private String name;
@SerializedName("age")
@Expose
private Integer age;
@SerializedName("seat")
@Expose
private String seat;
@SerializedName("oHashMap")
@Expose
private OHashMap oHashMap;

/**
* No args constructor for use in serialization
* 
*/
public DataObjectAuto() {
}

/**
* 
* @param seat
* @param age
* @param name
* @param oHashMap
*/
public DataObjectAuto(String name, Integer age, String seat, OHashMap oHashMap) {
this.name = name;
this.age = age;
this.seat = seat;
this.oHashMap = oHashMap;
}

/**
* 
* @return
* The name
*/
public String getName() {
return name;
}

/**
* 
* @param name
* The name
*/
public void setName(String name) {
this.name = name;
}

public DataObjectAuto withName(String name) {
this.name = name;
return this;
}

/**
* 
* @return
* The age
*/
public Integer getAge() {
return age;
}

/**
* 
* @param age
* The age
*/
public void setAge(Integer age) {
this.age = age;
}

public DataObjectAuto withAge(Integer age) {
this.age = age;
return this;
}

/**
* 
* @return
* The seat
*/
public String getSeat() {
return seat;
}

/**
* 
* @param seat
* The seat
*/
public void setSeat(String seat) {
this.seat = seat;
}

public DataObjectAuto withSeat(String seat) {
this.seat = seat;
return this;
}

/**
* 
* @return
* The oHashMap
*/
public OHashMap getOHashMap() {
return oHashMap;
}

/**
* 
* @param oHashMap
* The oHashMap
*/
public void setOHashMap(OHashMap oHashMap) {
this.oHashMap = oHashMap;
}

public DataObjectAuto withOHashMap(OHashMap oHashMap) {
this.oHashMap = oHashMap;
return this;
}

@Override
public String toString() {
return ToStringBuilder.reflectionToString(this);
}

}