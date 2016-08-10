/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package project.tbl_Question;

import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import project.utils.DBUtils;

/**
 *
 * @author lethanhtan
 */
public class tbl_QuestionDAO {
    
    public static List<tbl_QuestionDTO> getQuestionByPersonality(String personality) throws NamingException, SQLException {
        List<tbl_QuestionDTO> questionList = null;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "SELECT q.id, q.title, q.date, q.username "
                        + "FROM tblQuestion q, tblUsers u "
                        + "WHERE q.username = u.username and u.groupName = ? "
                        + "Order By  q.date DESC ";                
                stm = con.prepareStatement(sql);
                stm.setString(1, personality);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt(1);
                    String title = rs.getString(2);
                    Date date = new Date( rs.getTimestamp(3).getTime());
                    String username = rs.getString(4);
                    tbl_QuestionDTO dto = new tbl_QuestionDTO(id, title, date, username);
                    if (questionList == null) {
                        questionList = new ArrayList<tbl_QuestionDTO>();
                    }
                    
                    questionList.add(dto);                    
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
        return questionList;
    }

    public static tbl_QuestionDTO getQuestionById(String questionId) throws NamingException, SQLException {        
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "SELECT q.id, q.title, q.date, q.username "
                        + "FROM tblQuestion q "
                        + "WHERE q.id = ? ";
                                        
                stm = con.prepareStatement(sql);
                stm.setString(1, questionId);
                rs = stm.executeQuery();
                if (rs.next()) {
                    int id = rs.getInt(1);
                    String title = rs.getString(2);
                    Date date = rs.getDate(3);
                    String username = rs.getString(4);
                    tbl_QuestionDTO dto = new tbl_QuestionDTO(id, title, date, username);
                    return dto;
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
        return null;
        
    }
    
    public String marshallToString(tbl_QuestionDTO dto) throws JAXBException {
        JAXBContext ctx = JAXBContext.newInstance(tbl_QuestionDTO.class);
        Marshaller mar = ctx.createMarshaller();
        mar.setProperty("com.sun.xml.bind.xmlDeclaration", Boolean.FALSE);

        StringWriter writer = new StringWriter();
        mar.marshal(dto, writer);
        System.out.println(writer.toString());
        return writer.toString();
    }
    
    public Boolean insertNewQuestion(String title, String owner) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;        
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO tblQuestion (title, [date], username) VALUES(?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, title);                
                stm.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
                stm.setString(3, owner);
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
    
    public String marshallListToString(List<tbl_QuestionDTO> questionList) throws JAXBException {
        String result = "";
        for (tbl_QuestionDTO dto: questionList) {
            String marshaellDTO = marshallToString(dto);
            result += marshaellDTO;
        }
        
        return result.length() > 0 ? result : null;
    }
    
}
