/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package project.api;

import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.QueryParam;
import javax.xml.bind.JAXBException;
import project.tbl_user.tbl_UserDAO;
import project.tbl_user.tbl_UserDTO;

/**
 * REST Web Service
 *
 * @author lethanhtan
 */
@Path("/api/login")
public class LoginAPIServlet1 {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of LoginAPIServlet1
     */
    public LoginAPIServlet1() {
    }

    /**
     * Retrieves representation of an instance of project.api.LoginAPIServlet1
     * @param username
     * @param password
     * @return an instance of java.lang.String
     */
        @POST
        @Produces("text/plain")
    public String login(
        @FormParam("username") String username,
        @FormParam("password") String password) {
        
        String result = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
        Boolean lc = false;
        try {            
            tbl_UserDAO dao = new tbl_UserDAO();
            tbl_UserDTO dto = null;
            dto = dao.checkLogin(username, password);
            if (dto != null) {
                lc = true;
                result += "<login>";
                result += "<isSuccess>1</isSuccess>";
                result += dao.marshallToString(dto);
                result += "</login>";
                return result;  
            }                                                                              
        } catch (SQLException ex) {
            Logger.getLogger(LoginAPIServlet1.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(LoginAPIServlet1.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JAXBException ex) {
            Logger.getLogger(LoginAPIServlet1.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (!lc) {
                result += "<login>";
                result += "<isSuccess>0</isSuccess>";
                result += "</login>";
                return result;
            }

        }        
        return null;
    }
}
