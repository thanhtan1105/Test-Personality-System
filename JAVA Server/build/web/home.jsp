<%-- 
    Document   : index
    Created on : Jul 28, 2016, 7:20:25 PM
    Author     : lethanhtan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <link href="css/myStyle.css" rel="stylesheet"/>
        <style>
            body{
                background-color: #DFDCE0;
            }
            .header{
                height: 50px;
                background-color: #562b36;
            }
            .link-logout:link{
                color: #FFF;
            }
            .welcome{
                color:#fff;margin-right:20px;font-weight:bold;
                margin-top:10px;
            }
            .image {
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
        </style>
    </head>
    <body>
                  
        <c:url var="MyPersonality" value="ProcessServlet">
            <c:param name="btAction" value="MyPersonality" />
            <c:param name="username" value="${sessionScope.USERNAME}" />            
        </c:url>        

        <c:url var="Question" value="ProcessServlet">
            <c:param name="btAction" value="Question" />
            <c:param name="username" value="${sessionScope.USERNAME}" />
        </c:url>

        <div class="header">
            <img src="/XMLProject/image/logo.png" height="80%" class="image"/>
            <div style="text-align:right;">
                <span class="welcome" style="margin-top:4px">Welcome, ${sessionScope.USERNAME}</span>  
                <br/>
                <a href="ProcessServlet?btAction=Logout" class="link-logout" style="margin-right:20px; color: #FFF"> 
                    <small>Log out </small></a>
            </div>
        </div>

        <div class="content">
            <a href="http://localhost:8080/XMLProject/ProcessServlet?btAction=MyPersonality&amp;username=${sessionScope.USERNAME}" class="block block-link">
                <img src="/XMLProject/image/ponymbti.png" width="100%"/>
                My Personality
            </a>

            <a href="http://localhost:8080/XMLProject/MBTISTest.jsp" class="block block-link">
                <img src="/XMLProject/image/test.png" width="100%"/>
                MBTI Test
            </a>

            <a href="http://localhost:8080/XMLProject/ProcessServlet?btAction=Question&amp;username=${sessionScope.USERNAME}" class="block block-link">
                <img src="/XMLProject/image/question.png" width="100%"/>
                Question
            </a>

        </div>


    </body>
</html>
