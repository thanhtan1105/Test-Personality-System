/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package project.tbl_Question;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class tbl_QuestionDTO implements Serializable {
    
    private int id;
    private String title;
    private Date date;
    private String username;

    public tbl_QuestionDTO() {
        
    }

    public tbl_QuestionDTO(int id, String title, Date date, String username) {
        this.id = id;
        this.title = title;
        this.date = date;
        this.username = username;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
    
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    
}
