package com.gson;

import java.util.Random;

public class RandomNumber {
	
	  public static void main(String args[]){
	      String Str = new String("12AD^1^1^11A");

	      System.out.print("Return Value :" );
	      System.out.println(Str.matches("(.*)12|1|1(.*)"));

	      System.out.print("Return Value :" );
	      System.out.println(Str.matches("Tutorials"));

	      System.out.print("Return Value :" );
	      System.out.println(Str.matches("12|1|1(.*)"));
	   }

}
