/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package project.api;

import java.util.Set;

/**
 *
 * @author lethanhtan
 */
@javax.ws.rs.ApplicationPath("webresources")
public class ApplicationConfig extends javax.ws.rs.core.Application {

    @Override
    public Set<Class<?>> getClasses() {
        Set<Class<?>> resources = new java.util.HashSet<Class<?>>();
        addRestResourceClasses(resources);
        return resources;
    }

    /**
     * Do not modify addRestResourceClasses() method.
     * It is automatically populated with
     * all resources defined in the project.
     * If required, comment out calling this method in getClasses().
     */
    private void addRestResourceClasses(Set<Class<?>> resources) {
        resources.add(project.api.LoginAPIServlet1.class);
        resources.add(project.api.PersonalityAPI.class);
        resources.add(project.api.QuestionAPIServlet1.class);
        resources.add(project.api.TemplateQuestionAPIServlet.class);
        resources.add(project.api.UserPersonality.class);
    }
    
}
