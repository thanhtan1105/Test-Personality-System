/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package project.tbl_Question;

import java.util.ArrayList;
import java.util.List;
import project.tbl_Group.QuestionAnswer;

/**
 *
 * @author lethanhtan
 */
public class QuestionAnswerDAO {
    
    public static String calculateMBTIs(List<QuestionAnswer> questionAnswerList) {
        int typeA = 0, typeB = 0, typeC = 0, typeD = 0;
        int sumA = 0, sumB = 0, sumC = 0, sumD = 0;
        for (QuestionAnswer questionAnswer : questionAnswerList) {
            if (questionAnswer.getCategory().equals("1")) {
                sumA += questionAnswer.getAnswer();
                typeA++;
                
            } else if (questionAnswer.getCategory().equals("2")) {
                sumB += questionAnswer.getAnswer();
                typeB++;
                
            } else if (questionAnswer.getCategory().equals("3")) {
                sumC += questionAnswer.getAnswer();
                typeC++;
                
            } else if (questionAnswer.getCategory().equals("4")) {
                sumD += questionAnswer.getAnswer();
                typeD++;                
            }            
        }
        
        String result = "";
        result += (sumA / typeA) > 3 ? "E" : "I";
        result += (sumB / typeB) > 3 ? "S" : "N";
        result += (sumC / typeC) > 3 ? "T" : "F";
        result += (sumD / typeD) > 3 ? "J" : "P";                                
        return result;
        
    }
}
