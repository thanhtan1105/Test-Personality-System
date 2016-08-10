/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package project.tbl_user;

import java.io.Serializable;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


@XmlRootElement
public class tbl_UserDTO implements Serializable {
    private String username, password, personalityType;

    public tbl_UserDTO(String username, String password, String personalityType) {
        this.username = username;
        this.password = password;
        this.personalityType = personalityType;
    }
        
    public tbl_UserDTO () {
        
    }

    public String getPersonalityType() {
        return personalityType;
    }

    public void setPersonalityType(String personalityType) {
        this.personalityType = personalityType;
    }
        
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }    
    
    
}
