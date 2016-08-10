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
import javax.ws.rs.Consumes;
import javax.ws.rs.Produces;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.QueryParam;
import project.tbl_Group.tbl_GroupDAO;
import project.tbl_Group.tbl_GroupDTO;
import project.tbl_user.tbl_UserDAO;

/**
 * REST Web Service
 *
 * @author lethanhtan
 */
@Path("/api/getCurrentPersonality")
public class UserPersonality {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of UserPersonality
     */
    public UserPersonality() {
    }

    /**
     * Retrieves representation of an instance of project.api.UserPersonality
     * @return an instance of java.lang.String
     */
    @GET
    @Produces("application/xml")
    public tbl_GroupDTO getXml(
            @QueryParam("username") String username
    ) {
        try {
            tbl_GroupDAO dao = new tbl_GroupDAO();                        
            return dao.searchPersonalityByUser(username);
        } catch (NamingException ex) {
            Logger.getLogger(UserPersonality.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserPersonality.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * PUT method for updating or creating an instance of UserPersonality
     * @param content representation for the resource
     * @return an HTTP response with content of the updated or created resource.
     */
    @PUT
    @Consumes("application/xml")
    public void putXml(String content) {
    }
}
