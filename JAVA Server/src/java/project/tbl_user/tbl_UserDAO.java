/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package project.tbl_user;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.StringWriter;
import java.io.Writer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.stream.XMLStreamWriter;
import project.tbl_Group.tbl_GroupDTO;
import project.utils.DBUtils;


public class tbl_UserDAO {
     public tbl_UserDTO checkLogin(String username, String password) 
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "Select * from tblUsers where username = ? and password = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, password);
                rs = stm.executeQuery();
                if (rs.next()) {                    
                    String usernameString = rs.getString(1);
                    String passwordString = rs.getString(2);
                    String personalityType = rs.getString(3);

                    tbl_UserDTO dto = new tbl_UserDTO(usernameString, passwordString, personalityType);
                    return dto;
                }
            }
        } finally {
            if (rs != null)  
                rs.close();
            if (stm != null)
                stm.close();
            if (con != null) 
                con.close();
        }
        return null;
    }
     
    public Boolean createNewAccount(String username, String password) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;        
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO tblUsers (username, [password]) VALUES (?, ?);";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, password);
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
    
    public Boolean isUserExisted(String username) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "Select * from tblUsers where username = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);                
                rs = stm.executeQuery();
                if (rs.next()) {                    
                    return true;                    
                }
            }
        } finally {
            if (rs != null)  
                rs.close();
            if (stm != null)
                stm.close();
            if (con != null) 
                con.close();
        }
        return false;
        
    }

    public void updatePersonalityToUser(String username, String personality) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        

        
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "UPDATE tblUsers SET groupName = ? WHERE username = ?";                                                
                stm = con.prepareStatement(sql);
                stm.setString(1, personality.trim());
                stm.setString(2, username.trim());
                int result = stm.executeUpdate();
                System.out.println(result);
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }        
    }
     
     public String marshallToString(tbl_UserDTO dto) throws JAXBException {
         JAXBContext ctx = JAXBContext.newInstance(tbl_UserDTO.class);
         Marshaller mar = ctx.createMarshaller();
         mar.setProperty("com.sun.xml.bind.xmlDeclaration", Boolean.FALSE);
         
         StringWriter writer = new StringWriter();
         mar.marshal(dto, writer);
         System.out.println(writer.toString());
         return writer.toString();
                          
     }
     
     public String getPersonality(String username) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "Select groupName from tblUsers where username = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);                
                rs = stm.executeQuery();
                if (rs.next()) {                    
                    String groupName = rs.getString(1);
                    return groupName;
                }
            }
        } finally {
            if (rs != null)  
                rs.close();
            if (stm != null)
                stm.close();
            if (con != null) 
                con.close();
        }     
        return null;         
     }
     
     
     

}
