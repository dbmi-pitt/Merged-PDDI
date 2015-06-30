package com.dao;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class SourceAttribute {
	
	static Properties prop = new Properties();
	private static String[] sources;
	private static String[] defaultAttributes;
	
	public SourceAttribute() throws IOException {
		
		InputStream resourceStream = Thread.currentThread().getContextClassLoader().getResourceAsStream("source-attribute.properties");
		prop.load(resourceStream);
	}
	
	public static String[] getSources() throws IOException {
		
		String tempsource = prop.getProperty("sources");
		sources = tempsource.split(",");
		System.out.println(sources);
		return sources;
	}
	
	public static String[] getDefaultAttribute() {
		
		String tempattribute = prop.getProperty("defaultAttribute");
		defaultAttributes = tempattribute.split(",");
		System.out.println(defaultAttributes);
		return defaultAttributes;
	}
}
