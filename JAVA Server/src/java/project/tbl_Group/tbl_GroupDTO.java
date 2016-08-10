/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package project.tbl_Group;

import java.io.Serializable;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

@XmlType(name="", propOrder = {
    "name",
    "abbreviation",
    "description",
    "active",
    "atWork",
    "strength",
    "weakness",
})

@XmlRootElement
public class tbl_GroupDTO implements Serializable {    
    private String name;
    private String abbreviation;
    private String description;
    private Boolean active;
    private String atWork;
    private String strength;
    private String weakness;

    
    public tbl_GroupDTO() {
        
    }
    
    public tbl_GroupDTO(String name, String abbreviation, String description, Boolean active, String atWork, String strength, String weakness) {
        this.name = name;
        this.abbreviation = abbreviation;
        this.description = description;
        this.active = active;
        this.atWork = atWork;
        this.strength = strength;
        this.weakness = weakness;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAbbreviation() {
        return abbreviation;
    }

    public void setAbbreviation(String abbreviation) {
        this.abbreviation = abbreviation;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean isActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public String getAtWork() {
        return atWork;
    }

    public void setAtWork(String atWork) {
        this.atWork = atWork;
    }

    public String getStrength() {
        return strength;
    }

    public void setStrength(String strength) {
        this.strength = strength;
    }

    public String getWeakness() {
        return weakness;
    }

    public void setWeakness(String weakness) {
        this.weakness = weakness;
    }
    
    
}
