package com.gson;

import javax.annotation.Generated;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Generated("org.jsonschema2pojo")
public class OHashMap {

@SerializedName("A")
@Expose
private com.gson.A A;
@SerializedName("B")
@Expose
private com.gson.B B;

/**
* No args constructor for use in serialization
* 
*/
public OHashMap() {
}

/**
* 
* @param A
* @param B
*/
public OHashMap(com.gson.A A, com.gson.B B) {
this.A = A;
this.B = B;
}

/**
* 
* @return
* The A
*/
public com.gson.A getA() {
return A;
}

/**
* 
* @param A
* The A
*/
public void setA(com.gson.A A) {
this.A = A;
}

public OHashMap withA(com.gson.A A) {
this.A = A;
return this;
}

/**
* 
* @return
* The B
*/
public com.gson.B getB() {
return B;
}

/**
* 
* @param B
* The B
*/
public void setB(com.gson.B B) {
this.B = B;
}

public OHashMap withB(com.gson.B B) {
this.B = B;
return this;
}

@Override
public String toString() {
return ToStringBuilder.reflectionToString(this);
}

}