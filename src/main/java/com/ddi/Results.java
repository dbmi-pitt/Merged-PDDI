/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ddi;

import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author cwm24
 */
public class Results {
    private HashMap<String, ArrayList<String>> results;
    private ArrayList<String> sourceCSS;
    private String drug1;
    private String drug2;
    private String drug1ID;
    private String drug2ID;
    private String sources;
    private String[] sourcesList;
    private String[] attributes;
    private String[] attributesUpper;
    private String drugClass1;
    private String drugClass2;

    /**
     * @return the results
     */
    public HashMap<String, ArrayList<String>> getResults() {
        return results;
    }

    /**
     * @param results the results to set
     */
    public void setResults(HashMap<String, ArrayList<String>> results) {
        this.results = results;
    }

    /**
     * @return the drug1
     */
    public String getDrug1() {
        return drug1;
    }

    /**
     * @param drug1 the drug1 to set
     */
    public void setDrug1(String drug1) {
        this.drug1 = drug1;
    }

    /**
     * @return the drug2
     */
    public String getDrug2() {
        return drug2;
    }

    /**
     * @param drug2 the drug2 to set
     */
    public void setDrug2(String drug2) {
        this.drug2 = drug2;
    }

    /**
     * @return the drugClass1
     */
    public String getDrugClass1() {
        return drugClass1;
    }

    /**
     * @param drugClass1 the drugClass1 to set
     */
    public void setDrugClass1(String drugClass1) {
        this.drugClass1 = drugClass1;
    }
    
    /**
     * @return the drugClass2
     */
    public String getDrugClass2() {
        return drugClass2;
    }

    /**
     * @param drugClass2 the drugClass2 to set
     */
    public void setDrugClass2(String drugClass2) {
        this.drugClass2 = drugClass2;
    }
    
    /**
     * @return the drug1ID
     */
    public String getDrug1ID() {
        return drug1ID;
    }

    /**
     * @param drug1ID the drug1ID to set
     */
    public void setDrug1ID(String drug1ID) {
        this.drug1ID = drug1ID;
    }

    /**
     * @return the drug2ID
     */
    public String getDrug2ID() {
        return drug2ID;
    }

    /**
     * @param drug2ID the drug2ID to set
     */
    public void setDrug2ID(String drug2ID) {
        this.drug2ID = drug2ID;
    }

    /**
     * @return the sourceCSS
     */
    public ArrayList<String> getSourceCSS() {
        return sourceCSS;
    }

    /**
     * @param sourceCSS the sourceCSS to set
     */
    public void setSourceCSS(ArrayList<String> sourceCSS) {
        this.sourceCSS = sourceCSS;
    }

    /**
     * @return the sources
     */
    public String getSources() {
        return sources;
    }

    /**
     * @param sources the sources to set
     */
    public void setSources(String sources) {
        this.sources = sources;
    }

    /**
     * @return the sourcesList
     */
    public String[] getSourcesList() {
        return sourcesList;
    }

    /**
     * @param sourcesList the sourcesList to set
     */
    public void setSourcesList(String[] sourcesList) {
        this.sourcesList = sourcesList;
    }
    
    /**
     * @param attributeList the attributeList to set
     */
    public void setAttributes(String[] attributes) {
        this.attributes = attributes;
    }
    
    /**
     * @return the attributeList
     */
    public String[] getAttributes() {
        return attributes;
    }
    
    /**
     * @param attributeUpperList the attributeUpperList to set
     */
    public void setAttributesUpper(String[] attributesUpper) {
        this.attributesUpper = attributesUpper;
    }
    
    /**
     * @return the attributeUpperList
     */
    public String[] getAttributesUpper() {
        return attributesUpper;
    }


}
