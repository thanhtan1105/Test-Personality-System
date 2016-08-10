/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package project.tbl_Group;

/**
 *
 * @author lethanhtan
 */
public class QuestionAnswer {
    String id;
    int answer;
    String category;

    public QuestionAnswer(String id, int answer, String category) {
        this.id = id;
        this.answer = answer;
        this.category = category;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }       

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getAnswer() {
        return answer;
    }

    public void setAnswer(int answer) {
        this.answer = answer;
    }
    

    
    
}
