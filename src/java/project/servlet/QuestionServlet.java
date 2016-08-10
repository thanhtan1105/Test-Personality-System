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
import javax.servlet.http.HttpSession;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import project.tbl_Group.QuestionAnswer;
import project.tbl_Group.tbl_GroupDAO;
import project.tbl_Group.tbl_GroupDTO;
import project.tbl_Question.QuestionAnswerDAO;
import project.tbl_user.tbl_UserDAO;
import project.utils.XMLUtils;

/**
 *
 * @author lethanhtan
 */
public class QuestionServlet extends HttpServlet {
    
    private static final String mypersonality = "/MyPersonality.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String username = request.getParameter("username");
            String result = request.getParameter("result");
            
            Document doc = XMLUtils.parserFromString(result);
            List<QuestionAnswer> questionAnswersList = answerParserDOM(doc);
            String personality = QuestionAnswerDAO.calculateMBTIs(questionAnswersList);
            
            tbl_UserDAO userDAO = new tbl_UserDAO();
            userDAO.updatePersonalityToUser(username, personality);
            
            HttpSession session = request.getSession();
            session.setAttribute("PERSONALITY", personality);
            
            // query 
            tbl_GroupDAO dao = new tbl_GroupDAO();
            tbl_GroupDTO dto = dao.searchPersonality(personality);       
            
            request.setAttribute("Group", dto);
            String imagePath = "/XMLProject/image/" + dto.getName().toLowerCase() + ".png";
            request.setAttribute("ImageName", imagePath);                
                       
            RequestDispatcher rd = request.getRequestDispatcher(mypersonality);
            rd.forward(request, response);            
            
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(QuestionServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SAXException ex) {
            Logger.getLogger(QuestionServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (XPathExpressionException ex) {
            Logger.getLogger(QuestionServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(QuestionServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(QuestionServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            out.close();
        }
    }

    private List<QuestionAnswer> answerParserDOM(Document doc) throws XPathExpressionException {
        List<QuestionAnswer> questionAnswerList = null;
        if (doc != null) {
            XPath xpath = XMLUtils.createXPath();
            String exp = "//Question";
            NodeList nodeList = (NodeList) xpath.evaluate(exp, doc, XPathConstants.NODESET);
            if (nodeList != null) {
                
                for (int i = 0; i < nodeList.getLength(); i++) {
                    Node child = nodeList.item(i);
                    String id = "", category = "";
                    int answer = 0;

                    NodeList childrenOfStudent = child.getChildNodes();
                    for (int j = 0; j < childrenOfStudent.getLength(); j++) {
                        Node tmp = childrenOfStudent.item(j);
                        if (tmp.getNodeName().equals("ID")) {
                            id = tmp.getTextContent().trim();
                        } else if (tmp.getNodeName().equals("Answer")) {
                            String s = tmp.getTextContent().trim();
                            answer = Integer.parseInt(s);
                        } else if (tmp.getNodeName().equals("Category")) {
                            category = tmp.getTextContent().trim();
                        }
                    }

                    QuestionAnswer questionAnswer = new QuestionAnswer(id, answer, category);
                    if (questionAnswerList == null) {
                        questionAnswerList = new ArrayList<QuestionAnswer>();
                    }
                    questionAnswerList.add(questionAnswer);
                } // end for                                                                        
            } // end if
        }
        return questionAnswerList;
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
