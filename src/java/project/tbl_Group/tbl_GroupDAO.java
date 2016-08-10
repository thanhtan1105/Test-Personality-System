/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package project.tbl_Group;

import java.io.IOException;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import project.utils.DBUtils;
import project.utils.XMLUtils;

/**
 *
 * @author lethanhtan
 */
public class tbl_GroupDAO {
    
    public tbl_GroupDTO searchPersonality(String name) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "Select * from tblGroup where abbreviation = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, name);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String nameString = rs.getString(1);
                    String abbreviation = rs.getString(2);
                    String description = rs.getString(3);
                    Boolean active = rs.getBoolean(4);
                    String atWork = rs.getString(5);
                    String strength = rs.getString(6);
                    String weakness = rs.getString(7);
                    tbl_GroupDTO dto = new tbl_GroupDTO(nameString, abbreviation, description, active, atWork, strength, weakness);
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
    
    public tbl_GroupDTO searchPersonalityByUser(String username) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "SELECT a.* FROM tblGroup a, tblUsers b " 
                        + "WHERE b.groupName = a.abbreviation and b.username = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String nameString = rs.getString(1);
                    String abbreviation = rs.getString(2);
                    String description = rs.getString(3);
                    Boolean active = rs.getBoolean(4);
                    String atWork = rs.getString(5);
                    String strength = rs.getString(6);
                    String weakness = rs.getString(7);
                    tbl_GroupDTO dto = new tbl_GroupDTO(nameString, abbreviation, description, active, atWork, strength, weakness);
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
    
    public List<tbl_GroupDTO> getInfoOfPersonality() throws NamingException, SQLException {
        List<tbl_GroupDTO> personalityList = null;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "SELECT * FROM tblGroup a";
                stm = con.prepareStatement(sql);                
                rs = stm.executeQuery();
                while (rs.next()) {
                    String nameString = rs.getString(1);
                    String abbreviation = rs.getString(2);
                    String description = rs.getString(3);
                    String atWork = rs.getString(5);
                    String strength = rs.getString(6);
                    String weakness = rs.getString(7);
                    tbl_GroupDTO dto = new tbl_GroupDTO(nameString, abbreviation, description, true, atWork, strength, weakness);
                    
                    if (personalityList == null) {
                        personalityList = new ArrayList<tbl_GroupDTO>();
                    }                    
                    personalityList.add(dto);
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
        
        return personalityList;
        
    }
    
    public boolean insertNewGroup(tbl_GroupDTO dto) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBUtils.makeConnection();
            if (con != null) {                
                String sql = "Insert into tblGroup (name, abbreviation, description, active, atWork, strength, weakness)"
                        + " Values (?, ?, ?, ?, ?, ?, ?)";
                stm = con.prepareStatement(sql);                
                stm.setString(1, dto.getName());
                stm.setString(2, dto.getAbbreviation());
                stm.setString(3, dto.getDescription());
                stm.setBoolean(4, dto.isActive());
                stm.setString(5, dto.getAtWork());
                stm.setString(6, dto.getStrength());
                stm.setString(7, dto.getWeakness());

                int result = stm.executeUpdate();
                if (result > 0) {
                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public int getCount() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "SELECT COUNT(name) FROM tblGroup";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1);
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
        return 0;
    }
   
    public List<tbl_GroupDTO> parseToObject(String dataSource) throws ParserConfigurationException, SAXException, IOException, XPathExpressionException {
        List<tbl_GroupDTO> result = null;
        
        Document doc = XMLUtils.parserFromString(dataSource);
        if (doc != null) {
            XPath xpath = XMLUtils.createXPath();
            String exp = "//MBTIViewModel";
            NodeList nodeList = (NodeList) xpath.evaluate(exp, doc, XPathConstants.NODESET);
            if (nodeList != null) {
                for (int i = 0; i < nodeList.getLength(); i++) {
                    Node child = nodeList.item(i);
                    String id = "", name = "", abbreviation = "", description = "", atWork = "", strength = "", weakness = "";
                    Boolean active = false;
                    
                    // child node 
                    NodeList childrenOfStudent = child.getChildNodes();
                    for (int j = 0; j < childrenOfStudent.getLength(); j++) {
                        Node tmp = childrenOfStudent.item(j);
                        if (tmp.getNodeName().equals("Id")) {
                            id = tmp.getTextContent().trim();
                        } else if (tmp.getNodeName().equals("Name")) {                            
                            name = tmp.getTextContent().trim();
                        } else if (tmp.getNodeName().equals("Abbreviation")) {
                            abbreviation = tmp.getTextContent().trim();
                        } else if (tmp.getNodeName().equals("Description")) {
                            description = tmp.getTextContent().trim();
                        } else if (tmp.getNodeName().equals("Active")) {
                            String s = tmp.getTextContent().trim();
                            if (s.equals("1")) {
                                active = true;
                            }                            
                        } else if (tmp.getNodeName().equals("AtWork")) {
                            atWork = tmp.getTextContent().trim();
                        } else if (tmp.getNodeName().equals("Strength")) {
                            strength = tmp.getTextContent().trim();
                        } else if (tmp.getNodeName().equals("Weakness")) {
                            weakness = tmp.getTextContent().trim();
                        } 
                    }
                    
                    tbl_GroupDTO dto = new tbl_GroupDTO(name, abbreviation, description, active, atWork, strength, weakness);
                    if (result == null) {
                        result = new ArrayList<tbl_GroupDTO>();
                    }
                    result.add(dto);
                }
            }
        }        
        return result;
    }
        
    public String marshallToString(tbl_GroupDTO dto) throws JAXBException {
        JAXBContext ctx = JAXBContext.newInstance(tbl_GroupDTO.class);
        Marshaller mar = ctx.createMarshaller();
        mar.setProperty("com.sun.xml.bind.xmlDeclaration", Boolean.FALSE);

        StringWriter writer = new StringWriter();
        mar.marshal(dto, writer);
        System.out.println(writer.toString());
        return writer.toString();

    }
    
    
}
