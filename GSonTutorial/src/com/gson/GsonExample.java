package com.gson;

import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;

import com.google.gson.Gson;

public class GsonExample {
    public static void main(String[] args) {
    HashMap oHasMap = new HashMap();
    oHasMap.put("A", new DataObject());
    oHasMap.put("B", new DataObject());
    
	DataObjectMap obj = new DataObjectMap();
	obj.setAge(1);
	obj.setName("Yuji");
	obj.setSeat("7A");
	obj.setoHashMap(oHasMap);
	
	
	Gson gson = new Gson();

	// convert java object to JSON format,
	// and returned as JSON formatted string
	String json = gson.toJson(obj);

	try {
		//write converted json data to a file named "file.json"
		FileWriter writer = new FileWriter("C:\\Users\\Yuji\\workspace\\GSonTutorial\\file.json");
		writer.write(json);
		writer.close();

	} catch (IOException e) {
		e.printStackTrace();
	}

	System.out.println(json);

    }
}