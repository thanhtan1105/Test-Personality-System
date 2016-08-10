/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package project.api;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServlet;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Produces;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

/**
 * REST Web Service
 *
 * @author lethanhtan
 */
@Path("/api/getTemplateQuestion")
public class TemplateQuestionAPIServlet extends HttpServlet {

    private final String xmlFile = "/WEB-INF/MBTIsQuestion.xml";

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of TemplateQuestionAPIServlet
     */
    public TemplateQuestionAPIServlet() {
    }

    /**
     * Retrieves representation of an instance of
     * project.api.TemplateQuestionAPIServlet
     *
     * @return an instance of java.lang.String
     */
    @GET
    @Produces("text/plain")
    public String templateQuestionServlet() {
        FileInputStream fis = null;
        try {
            File f = new File(TemplateQuestionAPIServlet.class.getProtectionDomain().getCodeSource().getLocation().getPath());
            File webINFFile = f.getParentFile().getParentFile().getParentFile().getParentFile().getParentFile();
            String realPath = webINFFile.toPath().toAbsolutePath().toString();
            File file = new File(realPath + xmlFile);
            fis = new FileInputStream(file);
            byte[] data = new byte[(int) file.length()];
            fis.read(data);
            fis.close();
            String str = new String(data, "UTF-8");
            return str;
        } catch (FileNotFoundException ex) {
            Logger.getLogger(TemplateQuestionAPIServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(TemplateQuestionAPIServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                fis.close();
            } catch (IOException ex) {
                Logger.getLogger(TemplateQuestionAPIServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    static String readFile(String path, Charset encoding)
            throws IOException {
        byte[] encoded = Files.readAllBytes(Paths.get(path));
        return new String(encoded, encoding);
    }
}
