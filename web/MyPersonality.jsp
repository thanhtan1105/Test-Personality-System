<%-- 
    Document   : MyPersonality
    Created on : Aug 4, 2016, 5:12:57 PM
    Author     : lethanhtan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Personality</title>
        <link href="css/myStyle.css" rel="stylesheet"/>
    </head>
    <style>
        body{
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
            color:#fff;
            margin-right: 20px;
            font-weight:bold;
            margin-top:10px;
        }
        .image
        {
            float:left;margin-left:20px;margin-top:5px
        }
        .content{
            padding-top: 20px;
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
        .content{
            width: 80%;
            background-color: white;
            margin: auto;
            margin-top: 20px;
        }
        .PersonalityName{
            color:#000;font-size:100px;
            text-align:center;
        }
        .PersonalityAbbreviation{
            color:#000;font-size:50px;
            text-align:center;
        }
        .div-left{
            text-align: left;
            background-color: beige;
            padding: 10px;
            margin-left: 6%;
            margin-right: 30%;
            margin-top: 3%;
        }
        .div-right{
            text-align: right;
            background-color: beige;
            padding: 10px;
            margin-right: 6%;
            margin-left: 30%;
            margin-top: 3%;
        }
    </style>    
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
            <a href="home.jsp"> 
                <img src="/XMLProject/image/logo.png" height="80%" class="image"/>            
            </a>
            
            <div style="text-align:right; float:right; margin-top:5px">
                <span class="welcome" style="margin-top:4px">Welcome, ${sessionScope.USERNAME}</span>  
                <br/>
                <a href="ProcessServlet?btAction=Logout" class="link-logout" style="margin-right:20px; color: #FFF"> 
                    <small>Log out </small>
                </a>
            </div>
        </div>

    <center>        

        <c:set var="group" value="${requestScope.Group}" />     
        <c:if test="${not empty group}">
            <c:set var="imageURL" value="${requestScope.ImageName}" />            
            <img src="${imageURL}" height="400px" alt="${group.name}"/><br/>
            <span class="PersonalityName" >${group.name}</span><br/>
            <span class="PersonalityAbbreviation">${group.abbreviation}</span>

            <div class="div-left">
                <h3>Description</h3>
                ${group.description}
            </div>

            <div class="div-right">
                <h3>At work</h3>
                ${group.atWork}
            </div>
            <div class="div-left">
                <h3>Strength</h3>
                ${group.strength}
            </div>

            <div class="div-right">
                <h3>Weakness</h3>           
                ${group.weakness}
            </div>            
        </c:if>
        <c:if test="${empty group}">
            <div style="text-align: center">
                <br/>
                You did not have personality. 
                <h3>Please make <a href="MBTISTest.jsp">test </a> first</h3>
            </div>
        </c:if>             
    </center>

    <script>
        function onBackTapped() {
            window.location = "home.jsp";
        }

    </script>
</html>
