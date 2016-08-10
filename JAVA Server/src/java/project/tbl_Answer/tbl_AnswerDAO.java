/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package project.tbl_Answer;

import java.io.StringWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import project.tbl_Question.tbl_QuestionDTO;
import project.utils.DBUtils;

/**
 *
 * @author lethanhtan
 */
public class tbl_AnswerDAO {
    
    public List<tbl_AnswerDTO> getAnswerByQuestion(String questionId) throws NamingException, SQLException {
        List<tbl_AnswerDTO> answerList = null;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "SELECT * FROM tblAnswers a WHERE a.questionId= ? "
                        + " Order By  a.date DESC";
                stm = con.prepareStatement(sql);
                stm.setString(1, questionId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt(1);
                    String content = rs.getString(2);
                    Date date = rs.getDate(3);
                    int questionID = rs.getInt(4);
                    String answerer = rs.getString(5);
                    tbl_AnswerDTO dto = new tbl_AnswerDTO(id, content, date, questionId, answerer);

                    if (answerList == null) {
                        answerList = new ArrayList<tbl_AnswerDTO>();
                    }

                    answerList.add(dto);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return answerList;
    }
    
    public Boolean insertNewAnswer(String content, String questionID, String answerer) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;        
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO tblAnswers (contents, [date], questionId, username) VALUES(?, ?, ?, ?)";                
                stm = con.prepareStatement(sql);
                stm.setString(1, content);
                java.util.Date myDate = new java.util.Date();
                java.sql.Date sqlDate = new java.sql.Date(myDate.getTime());
                stm.setDate(2, sqlDate);
                stm.setString(3, questionID);
                stm.setString(4, answerer);
                int result = stm.executeUpdate();
                if (result > 0) {
                    return true;
                }
            }
        } finally {
            if (stm != null)
                stm.close();
            if (con != null) 
                con.close();
        }                        
        return false;                
    }
    

    public String marshallToString(tbl_AnswerDTO dto) throws JAXBException {
        JAXBContext ctx = JAXBContext.newInstance(tbl_AnswerDTO.class);
        Marshaller mar = ctx.createMarshaller();
        mar.setProperty("com.sun.xml.bind.xmlDeclaration", Boolean.FALSE);

        StringWriter writer = new StringWriter();
        mar.marshal(dto, writer);
        System.out.println(writer.toString());
        return writer.toString();
    }

    public String marshallListToString(List<tbl_AnswerDTO> answerList) throws JAXBException {
        String result = "";
        for (tbl_AnswerDTO dto : answerList) {
            String marshaellDTO = marshallToString(dto);
            result += marshaellDTO;
        }

        return result.length() > 0 ? result : null;
    }
}
