/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package project.api;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Produces;
import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.xml.bind.JAXBException;
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
 * REST Web Service
 *
 * @author lethanhtan
 */
@Path("/api/question/ProcessPersonality")
public class QuestionAPIServlet1 {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of QuestionAPIServlet1
     */
    public QuestionAPIServlet1() {
    }

    /**
     * Retrieves representation of an instance of
     * project.api.QuestionAPIServlet1
     *
     * @param username
     * @param result
     * @return an instance of java.lang.String
     */
    @POST
    @Produces("text/plain")
    public String questionServlet(
            @FormParam("username") String username,
            @FormParam("result") String result) {
        try {
            
            String returnResult = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
            Document doc = XMLUtils.parserFromString(result);
            List<QuestionAnswer> questionAnswersList = answerParserDOM(doc);
            String personality = QuestionAnswerDAO.calculateMBTIs(questionAnswersList);

            tbl_UserDAO userDAO = new tbl_UserDAO();
            userDAO.updatePersonalityToUser(username, personality);

            // query
            tbl_GroupDAO dao = new tbl_GroupDAO();
            tbl_GroupDTO dto = dao.searchPersonality(personality);
            returnResult += dao.marshallToString(dto);
            returnResult += "<isSucess>1</isSucess>";

            return returnResult;
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(QuestionAPIServlet1.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SAXException ex) {
            Logger.getLogger(QuestionAPIServlet1.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(QuestionAPIServlet1.class.getName()).log(Level.SEVERE, null, ex);
        } catch (XPathExpressionException ex) {
            Logger.getLogger(QuestionAPIServlet1.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(QuestionAPIServlet1.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(QuestionAPIServlet1.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JAXBException ex) {
            Logger.getLogger(QuestionAPIServlet1.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;

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
}
