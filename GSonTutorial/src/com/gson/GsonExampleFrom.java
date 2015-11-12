package com.gson;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import com.google.gson.Gson;

public class GsonExampleFrom {
    public static void main(String[] args) {

	Gson gson = new Gson();

	try {

		BufferedReader br = new BufferedReader(
			new FileReader("C:\\Users\\Yuji\\workspace\\GSonTutorial\\file.json"));

		//convert the json string back to object
		DataObjectAuto obj = gson.fromJson(br, DataObjectAuto.class);

		System.out.println(obj);
		System.out.println(obj.getName());
		
		String jsonString = "{\"name\":\"Yuji\",\"age\":1,\"seat\":\"7A\",\"oHashMap\":{\"A\":{\"data1\":100,\"data2\":\"hello\",\"list\":[\"String 1\",\"String 2\",\"String 3\"]},\"B\":{\"data1\":100,\"data2\":\"hello\",\"list\":[\"String 1\",\"String 2\",\"String 3\"]}}}";
		
		DataObjectMap obj2 = gson.fromJson(jsonString, DataObjectMap.class);

		System.out.println(obj2);
		System.out.println(obj2.getName());

	} catch (IOException e) {
		e.printStackTrace();
	}

    }
}