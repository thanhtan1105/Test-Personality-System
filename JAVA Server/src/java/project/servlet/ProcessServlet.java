/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package project.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author lethanhtan
 */
public class ProcessServlet extends HttpServlet {

    private final String loginPage = "login.html";
    private final String loginServlet = "LoginServlet";
    private final String questionServlet = "QuestionServlet";
    private final String mypersonality = "MyPersonality";
    private final String questionFeedServlet = "QuestionFeedServlet";
    private final String createNewAccount = "CreateNewAccountServlet";
    private final String postQuestionServlet = "PostQuestionServlet";
    private final String answerServlet = "AnswerQuestionServlet";
    private final String postAnswerServlet = "PostAnswerServlet";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
           String button = request.getParameter("btAction");
           String url = "";                      
           
            HttpSession session = request.getSession(true);
           if (session == null) {
               url = loginPage;
           } else if (button == null) {
               url = loginPage;
           } else if (button.equals("Login")) {
               url = loginServlet;
           } else if (button.equals("Submit MBTIs")) {
               url = questionServlet;
           } else if (button.equals("MyPersonality")) {
               url = mypersonality;
           } else if (button.equals("Question")) {
               url = questionFeedServlet;
           } else if (button.equals("Create New Account")) {
               url = createNewAccount;
           } else if (button.equals("POST")) {
               url = postQuestionServlet;
           } else if (button.equals("Answer")) {
               url = answerServlet;
           } else if (button.equals("POST ANSWER")) {
               url = postAnswerServlet;
           } else if (button.equals("Logout")) {
               url = loginPage;
               request.getSession().invalidate();   
               response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
               response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
               response.setDateHeader("Expires", 0); // Proxies.
           }
           
           RequestDispatcher rd = request.getRequestDispatcher(url);
           rd.forward(request, response);
           
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
