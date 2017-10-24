package com.dao;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class SourceAttribute {
	
	static Properties prop = new Properties();
	private static String[] sources;
	private static String[] sourceExp;
	private static String[] defaultAttributes;
	private static String[] nodistinction;
	
	public SourceAttribute() throws IOException {
		
		InputStream resourceStream = Thread.currentThread().getContextClassLoader().getResourceAsStream("source-attribute.properties");
		prop.load(resourceStream);
	}
	
	public static String[] getSources() throws IOException {
		
		String tempsource = prop.getProperty("sources");
		sources = tempsource.split(",");
		//System.out.println(sources);
		return sources;
	}
	
	public static String[] getExamples() throws IOException {
		
		String tempsourceExp = prop.getProperty("sourceExp");
		//System.out.println("sourceExp:" + tempsourceExp);
		sourceExp = tempsourceExp.split(",");
		return sourceExp;
	}
	
	public static String[] getDefaultAttribute() {
		
		String tempattribute = prop.getProperty("defaultAttribute");
		defaultAttributes = tempattribute.split(",");
		//System.out.println(defaultAttributes);
		return defaultAttributes;
	}
	
	public static String[] getNodistinction() {
		
		String tempattribute = prop.getProperty("nodistinction");
		System.out.println(tempattribute);
		
		nodistinction = tempattribute.split(",");
		//System.out.println(defaultAttributes);
		return nodistinction;
	}
	
	
	
}

