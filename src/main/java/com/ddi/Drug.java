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
public class Drug {
    private ArrayList<String> drugNames;
    HashMap<String, ArrayList<String>> sourceSet = new HashMap<String, ArrayList<String>>();
    private HashMap<String, String> sourceNum;
    private HashMap<String, String> sourceExp;

    /**
     * @return the drugNames
     */
    public ArrayList<String> getDrugNames() {
        return drugNames;
    }

    /**
     * @param drugNames the drugNames to set
     */
    public void setDrugNames(ArrayList<String> drugNames) {
        this.drugNames = drugNames;
    }
    
    
    /**
     * @return the sourceSet
     */
    public HashMap<String, ArrayList<String>> getSourceSet() {
        return sourceSet;
    }

    /**
     * @param sourceSet the sourceSet to set
     */
    public void setSourceSet(HashMap<String, ArrayList<String>> sourceSet) {
        this.sourceSet = sourceSet;
    }
    
    /**
     * @param sourceNum the sourceNum to set
     */
    public void setSourceNum(HashMap<String,String> sourceNum) {
        this.sourceNum = sourceNum;
    }
    
    /**
     * @return the sourceNum
     */
    public HashMap<String,String> getSourceNum() {
        return sourceNum;
    }
    
    /**
     * @param sourceExp the sourceExp to set
     */
    public void setSourceExp(HashMap<String,String> sourceExp) {
        this.sourceExp = sourceExp;
    }
    
    /**
     * @return the sourceNum
     */
    public HashMap<String,String> getSourceExp() {
        return sourceExp;
    }
    
}
