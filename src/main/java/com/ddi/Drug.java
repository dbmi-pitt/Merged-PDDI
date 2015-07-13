/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package main.java.com.ddi;

import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author cwm24
 */
public class Drug {
    private ArrayList<String> drugNames;
    HashMap<String, ArrayList<String>> sourceSet = new HashMap<String, ArrayList<String>>();

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
    
}
