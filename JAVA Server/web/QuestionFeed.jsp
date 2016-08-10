<%-- 
    Document   : QuestionFeed
    Created on : Aug 5, 2016, 9:44:54 AM
    Author     : lethanhtan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Question Feed</title>
        <link href="css/myStyle.css" rel="stylesheet"/>
        <style>
            .error {
                color: red;
            }
            body {
                background-color: #DFDCE0;
            }
            .header{
                height: 50px;
                background-color: #562b36;
            }
            .link-logout:link{
                color: #1CDBE8;
            }
            .welcome{
                color:#fff;margin-right:20px;font-weight:bold;
                margin-top:10px;
            }
            .image
            {
                float:left;margin-left:20px;margin-top:5px
            }
            .content{
                margin-top: 10px;
                padding-top: 20px;
                width: 50%;
                background-color: #fff;
            }
            .block{
                float: left;
                background-color:beige;
                width: 30%;
                margin:1.5%;
                text-align: center;
            }
            .block-link:link{
                color: #562b36;
                text-decoration: none;
                font-weight: bold;
                font-size: 200%;
            }
            .your-status{
                background-color: transparent;
                border: 0;
                box-sizing: border-box;
                display: block;
                font-family: helvetica, arial, sans-serif;
                font-size: 14px;
                height: 100%;
                line-height: 18px;
                min-height: 69px;
                outline: 0;
                padding: 23px 12px 14px;
                resize:none;
                width: 100%;
                max-width: 100%;
                overflow: hidden;
            }
            .div-button{
                align-items: flex-end;
                float: right;
                text-align:right;position: relative;
            }
            .btnPost{
                background-color: #562b36;
                border-color: #562b36;
                font-size: 16px;
                color: #fff;
                align-content: flex-end;
                margin-right: 20px;
            }
            .div-post{
                margin-top: 10px;
                padding-top: 10px;
                width: 50%;
                background-color: #fff;
                text-align:left;
                padding-bottom: 20px;
            }
            .owner{
                margin-left:20px;
                font-weight: bold;
                font-size: 18px;
            }
            .time{
                margin-left:20px;
                font-size: 12px;
                font-weight:lighter;
            }
            .tilte{
                margin-left: 10px;
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
            <div style="text-align:right; float:right; margin-top:5px">
                <span class="welcome" style="margin-top:4px">Welcome, ${sessionScope.USERNAME}</span>  
                <br/>
                <a href="ProcessServlet?btAction=Logout" class="link-logout" style="margin-right:20px; color: #FFF"> 
                    <small>Log out </small>
                </a>
            </div>
        </div>

    <center>
        
        <c:if test="${not empty sessionScope.PERSONALITY}">
            <h1>${sessionScope.PERSONALITY} Feed</h1>                     
            
            <div class="content">
            <form action="ProcessServlet">
                <hr style="margin-left:20px;margin-right:20px"/>
                <textarea type="text" class="your-status" style="font-size:14px;width:95%" placeholder="Your question" id="txtStatus" name="txtStatus" value=""></textarea>
                <br/>
                <hr style="margin-left:20px;margin-right:20px"/>
                <div class="div-button" >
                    <input type="hidden"  value="${sessionScope.USERNAME}" name="username">
                    <input type="submit" class="btnPost" value="POST" name="btAction">
                </div>
                <br/>
                <br/>
            </form>
            
        </div>
            <h4 id="error">${requestScope.error}</h4>        

            <div>
                <c:if test="${not empty requestScope.result}">
                    <c:set var="xml" value="${requestScope.result}" />
                    <c:import var="xsl" url="WEB-INF/QuestionFeed.xsl" />              
                    <x:transform doc="${xml}" xslt="${xsl}" />
                </c:if>
            </div>
        </c:if>  

        <c:if test="${empty sessionScope.PERSONALITY}" >
            <h1 style="text-align: center">Question Feed</h1>
            <div style="text-align: center">
                You did not have personality. Please make <a href="MBTISTest.jsp">test </a> first
            </div>
        </c:if>
    </center>               
        <script>
            function onBackTapped() {
                window.location = "home.jsp";                
            }
            
            function onPOSTTapped() {                
                var resource;
                
                // send data
                xmlHttp = GetXMLHttpObject();
                if (xmlHttp === null) {
                    alert("Your browser does not support AJAX!");
                    return false;
                }

                xmlHttp.onreadystatechange = function() {
                    if (xmlHttp.readyState === 4 && xmlHttp.status === 200) {
                        xmlPersonality = xmlHttp.responseText;
                        // TO-DO
                        console.log(xmlPersonality);
                    }
                }
                xmlHttp.open("POST", "ProcessServlet", true);
                xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                var txtStatus = document.getElementById("txtStatus").value;
                var url = "btAction=PostQuestion&username=" + ${sessionScope.USERNAME} + "&txtStatus=";
                url += txtStatus;
                xmlHttp.send(url);
            }

            function GetXMLHttpObject() {
                var xmlHttp = null;
                try {
                    xmlHttp = new XMLHttpRequest();
                } catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Msxm12.XMLHTTP");
                    } catch (e) {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                }

                return xmlHttp;
            }
        </script>
    </body>
</html>
