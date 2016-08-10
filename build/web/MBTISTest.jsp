<%-- 
    Document   : MBTISTest
    Created on : Aug 1, 2016, 2:17:08 PM
    Author     : lethanhtan
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MBTIs Test</title>
        <link href="css/myStyle.css" rel="stylesheet"/>
        
        <style>
            .guidleQuestion {    
                margin: auto;
                text-align: left;
                width: 50%;
            }
            .guidleQuestion h3 {
                text-align: center;
            }
            
            .guidleQuestion p {
                text-align: center;
            }
            
            .subGuidleQuestion{
                margin: auto;
                width: 20%;
            }
            
            .header{
                height: 50px;
                background-color: #562b36;
            }            
            .table {
                margin: auto;
                width: 60%;
            }
            
            #resourceString {
                color: red;
            }
            
            body{
                text-align: center;
            }
            
            #btnSubmit {
                margin-top: 10px;
            }
            .image {
                float:left;margin-left:20px;margin-top:5px
            }            
            .welcome{
                color:#fff;
                margin-right: 20px;
                font-weight:bold;
                margin-top:10px;
            }
            
        </style>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            if (session.getAttribute("USERNAME") == null) {
                response.sendRedirect("login.html");
            }
        %>         

        <div class="header">
            <img src="/XMLProject/image/logo.png" height="80%" class="image"/>
            <div style="text-align:right;">
                <span class="welcome" style="margin-top:4px">Welcome, ${sessionScope.USERNAME}</span>  
                <br/>
                <a href="ProcessServlet?btAction=Logout" class="link-logout" style="margin-right:20px; color: #FFF"> 
                    <small>Log out </small></a>
            </div>
        </div>        
                    
        <c:import var="xmlDoc" url="WEB-INF/MBTIsQuestion.xml" />        
        <x:parse var="doc" doc="${xmlDoc}" />
        <div class="guidleQuestion">
            <h1 style="text-align: center">Personality Test</h1>
            <p>A shot yet quiz test will be conducted to obtain your personality profile</p>
            
            <div class="subGuidleQuestion">
                1 - Least Similar<br/>
                3 - Neutral<br/>
                5 - Most Similar <br/>                
            </div>
        </div>
        <table border="1" class="table">
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Content</th>
                    <th>Choice</th>
                </tr>
            </thead>
            <tbody>            
                <x:forEach var="question" select="$doc//PersonalityQuestionViewModel" varStatus="counter" >                    
                    <tr>
                        <td>${counter.count}</td>
                        <td>
                            <x:out select="$question/Content"/>                            
                        </td>                        
                        <td>                            
                            <input type="radio" name="<x:out select='$question/Id'/>" value="1-<x:out select='$question/Category'/>">1</input>
                            <input type="radio" name="<x:out select='$question/Id'/>" value="2-<x:out select='$question/Category'/>">2</input>
                            <input type="radio" name="<x:out select='$question/Id'/>" value="3-<x:out select='$question/Category'/>">3</input>
                            <input type="radio" name="<x:out select='$question/Id'/>" value="4-<x:out select='$question/Category'/>">4</input>
                            <input type="radio" name="<x:out select='$question/Id'/>" value="5-<x:out select='$question/Category'/>">5</input>
                        </td>
                    </tr>
                </x:forEach>                              
            
            </tbody>
        </table>        
         
        <h4 id="resourceString"></h4>
        <form action="ProcessServlet" method="POST" onsubmit="return onClickButtonSubmit(this)">
            <input type="hidden" name="username" value=" ${sessionScope.USERNAME}" />
            <input id="result" type="hidden" name="result" value="" />
            <input id="btnSubmit" type="submit" value="Submit MBTIs" name="btAction" />            
        </form>
        
                                    
        
        <script>            
            function onBackTapped() {
                window.location = "home.jsp";
            }
            
            function onClickButtonSubmit() {
                var resource = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
                resource += "<Questions>";
                var transfer = transferDataToXML();  
                
                var subStringFail = "Missing answer";                
                if (transfer.indexOf(subStringFail) == -1) {                    
                    document.getElementById("resourceString").innerHTML = ""; // remove error
                    
                    resource += transfer;
                    resource += "</Questions>";
                    
                    document.getElementById("result").value = resource;                    

                    
                    return true;
                } else {
                    document.getElementById("resourceString").innerHTML = transfer;
                }
                
                return false;
            }
            
            function transferDataToXML() {
                var result = "";
                var i;
                for (i = 1; i <= 51; i++) {
                    var x = document.getElementsByName(i + ""); 
                    var j;
                    var lc = false;
                    for (j = 0; j < x.length; j++) {
                        if (x[j].checked === true) {
                            lc = true;
                            var value = x[j].value;
                            var temple = value.split("-");
                            result += "<Question>";
                            result += "<ID>"+ i +"</ID>";
                            result += "<Answer>"+ temple[0] +"</Answer>";
                            result += "<Category>"+ temple[1] + "</Category>";                            
                            result += "</Question>" 
                            break;
                        }
                    }
                    
                    if (lc === false) {
                        return "Missing answer on question " + i;
                    }
                }                
                return result;                
            }             
        </script>
    </body>
    
    
</html>

                    
