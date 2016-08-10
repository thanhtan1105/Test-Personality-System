/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package project.servlet;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import project.tbl_Group.tbl_GroupDAO;
import project.tbl_Group.tbl_GroupDTO;
import project.utils.HttpClientUtils;

/**
 * Web application lifecycle listener.
 *
 * @author lethanhtan
 */
public class AppContextListener implements ServletContextListener {

    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Hello World");
        try {
            getMBTIsQuestion(sce);
            getPersonality();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    public void contextDestroyed(ServletContextEvent sce) {  
        System.out.println("Bye bye");
    }
    
    private void getMBTIsQuestion(ServletContextEvent sce) throws Exception {
        String realPath = sce.getServletContext().getRealPath("/");
        String xmlFile = "WEB-INF/MBTIsQuestion.xml";
        System.out.println("Address: " + xmlFile + realPath);
        File f = new File(realPath + xmlFile);
        if (f.exists()) {
            return;
        }

        String content = HttpClientUtils.getMBTIsQuestion();
                
        // write to file
        BufferedWriter bwr = new BufferedWriter(new FileWriter(new File(realPath + xmlFile)));
        // write content to file
        bwr.write(content);
        //flush the stream
        bwr.flush();
        //close the stream
        bwr.close();                        
    }
    
    private void getPersonality() throws SQLException, NamingException, Exception {        
        tbl_GroupDAO dao = new tbl_GroupDAO();
        if (dao.getCount() > 0) {
            return;
        }

        String content = HttpClientUtils.getMBTIs();
        List<tbl_GroupDTO> groupList = dao.parseToObject(content);
        for (tbl_GroupDTO group : groupList) {
            System.out.println(dao.insertNewGroup(group));
        }
    }

}
