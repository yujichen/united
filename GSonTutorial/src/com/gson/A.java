package com.gson;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Generated;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import org.apache.commons.lang.builder.ToStringBuilder;

@Generated("org.jsonschema2pojo")
public class A {

@SerializedName("data1")
@Expose
private Integer data1;
@SerializedName("data2")
@Expose
private String data2;
@SerializedName("list")
@Expose
private List<String> list = new ArrayList<String>();

/**
* No args constructor for use in serialization 2
* 
*/
public A() {
}

/**
* 
* @param data1
* @param list
* @param data2
*/
public A(Integer data1, String data2, List<String> list) {
this.data1 = data1;
this.data2 = data2;
this.list = list;
}

/**
* 
* @return
* The data1
*/
public Integer getData1() {
return data1;
}

/**
* 
* @param data1
* The data1
*/
public void setData1(Integer data1) {
this.data1 = data1;
}

public A withData1(Integer data1) {
this.data1 = data1;
return this;
}

/**
* 
* @return
* The data2
*/
public String getData2() {
return data2;
}

/**
* 
* @param data2
* The data2
*/
public void setData2(String data2) {
this.data2 = data2;
}

public A withData2(String data2) {
this.data2 = data2;
return this;
}

/**
* 
* @return
* The list
*/
public List<String> getList() {
return list;
}

/**
* 
* @param list
* The list
*/
public void setList(List<String> list) {
this.list = list;
}

public A withList(List<String> list) {
this.list = list;
return this;
}

@Override
public String toString() {
return ToStringBuilder.reflectionToString(this);
}

}