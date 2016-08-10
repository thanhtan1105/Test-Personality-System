/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package project.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBException;
import project.tbl_Question.tbl_QuestionDAO;
import project.tbl_Question.tbl_QuestionDTO;
import project.tbl_user.tbl_UserDAO;

/**
 *
 * @author lethanhtan
 */
public class QuestionFeedServlet extends HttpServlet {

    private final String questionFeed = "/QuestionFeed.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String username = request.getParameter("username");
            tbl_UserDAO userDAO = new tbl_UserDAO();
            String personality = userDAO.getPersonality(username);
            List<tbl_QuestionDTO> questionList = tbl_QuestionDAO.getQuestionByPersonality(personality);
            if (questionList != null) {
                tbl_QuestionDAO questionDAO = new tbl_QuestionDAO();
                String questionListMarshall = questionDAO.marshallListToString(questionList);

                String result = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
                result += "<Questions>";
                result += questionListMarshall;
                result += "</Questions>";

                request.setAttribute("result", result);
            }
            RequestDispatcher rd = request.getRequestDispatcher(questionFeed);
            rd.forward(request, response);
            
            
        } catch (NamingException ex) {
            Logger.getLogger(QuestionFeedServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(QuestionFeedServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JAXBException ex) {
            Logger.getLogger(QuestionFeedServlet.class.getName()).log(Level.SEVERE, null, ex);
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
