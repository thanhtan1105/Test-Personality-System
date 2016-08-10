/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package project.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import project.tbl_Group.tbl_GroupDAO;
import project.tbl_Group.tbl_GroupDTO;
import project.tbl_user.tbl_UserDAO;

/**
 *
 * @author lethanhtan
 */
public class MyPersonality extends HttpServlet {

    private static final String mypersonality = "/MyPersonality.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();        
        try {
            String username = request.getParameter("username");
            tbl_UserDAO userDAO = new tbl_UserDAO();
            String personality = userDAO.getPersonality(username);
            tbl_GroupDAO groupDAO = new tbl_GroupDAO();
            tbl_GroupDTO dto = groupDAO.searchPersonality(personality);      
            request.setAttribute("Group", dto);
            
            if (dto != null) {
                // set image                      
                String imagePath = "/XMLProject/image/" + dto.getName().toLowerCase() + ".png";
                request.setAttribute("ImageName", imagePath);                
            }   
            RequestDispatcher rd = request.getRequestDispatcher(mypersonality);
            rd.forward(request, response);
            
        } catch (NamingException ex) {
            Logger.getLogger(MyPersonality.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(MyPersonality.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
