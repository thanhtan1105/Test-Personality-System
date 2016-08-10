/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package project.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
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
import project.tbl_Answer.tbl_AnswerDAO;
import project.tbl_Answer.tbl_AnswerDTO;
import project.tbl_Question.tbl_QuestionDAO;
import project.tbl_Question.tbl_QuestionDTO;

/**
 *
 * @author lethanhtan
 */
public class AnswerQuestionServlet extends HttpServlet {

    private final String answerFeed = "/AnswerFeed.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            
            String questionID = request.getParameter("questionId");
            tbl_AnswerDAO answerDAO = new tbl_AnswerDAO();
            List<tbl_AnswerDTO> answerList = answerDAO.getAnswerByQuestion(questionID);            
            
            
            if (answerList != null) {                
                String answerListMarshall = answerDAO.marshallListToString(answerList);

                String result = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
                result += "<Answers>";
                result += answerListMarshall;
                result += "</Answers>";
                request.setAttribute("answerList", result);
            }     
            
            tbl_QuestionDTO dto = tbl_QuestionDAO.getQuestionById(questionID);
            tbl_QuestionDAO questionDAO = new tbl_QuestionDAO();
            String questionMarshall = questionDAO.marshallToString(dto);
            request.setAttribute("questionID", questionID);
            request.setAttribute("question", questionMarshall);                       
            RequestDispatcher rd = request.getRequestDispatcher(answerFeed);
            rd.forward(request, response);                        
            
        } catch (NamingException ex) {
            Logger.getLogger(AnswerQuestionServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AnswerQuestionServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JAXBException ex) {
            Logger.getLogger(AnswerQuestionServlet.class.getName()).log(Level.SEVERE, null, ex);
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
