/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package project.api;

import java.sql.SQLException;
import java.util.Collection;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Produces;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import project.tbl_Group.tbl_GroupDAO;
import project.tbl_Group.tbl_GroupDTO;

/**
 * REST Web Service
 *
 * @author lethanhtan
 */
@Path("/api/getperonality")
public class PersonalityAPI {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of PersonalityAPI
     */
    public PersonalityAPI() {
    }

    /**
     * Retrieves representation of an instance of project.api.PersonalityAPI
     * @return an instance of java.lang.String
     */
    @GET
    @Produces(MediaType.APPLICATION_XML)
    public Collection<tbl_GroupDTO> getShortPersonality() {
        try {
            tbl_GroupDAO dao = new tbl_GroupDAO();
            List<tbl_GroupDTO> personalityList = dao.getInfoOfPersonality();                                        
            return personalityList;
            
        } catch (NamingException ex) {
            Logger.getLogger(PersonalityAPI.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(PersonalityAPI.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
