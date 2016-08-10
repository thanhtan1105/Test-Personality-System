<%-- 
    Document   : AnswerFeed
    Created on : Aug 7, 2016, 11:13:13 AM
    Author     : lethanhtan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Answer Feed</title>
        <link href="css/myStyle.css" rel="stylesheet"/>
        <style>
            .error {
                color: red;
            }
            .header{
                height: 50px;
                background-color: #562b36;
            }

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
                color:#fff;margin-right:20px;font-weight:bold;
                margin-top:10px;
            }
            .image {
                float:left;
                margin-left:20px;
                margin-top:5px
            }
            .content{
                margin-top: 10px;
                padding-top: 20px;
                width: 50%;                
            }
            .owner{
                margin-left:20px;
                font-weight: bold;
                font-size: 18px;
            }
            .question{
                padding-top: 10px;
                text-align: left;
                padding-bottom: 10px;
                background-color: #fff;
            }
            .time{
                margin-left:20px;
                font-size: 12px;
                font-weight:lighter;
            }
            .tilte{
                margin-left: 10px;
            }
            .write-answer{
                margin-top: 10px;
                padding-top: 20px;
                width: 100%;
                background-color: #fff;
                padding-bottom: 10px;
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
                padding-bottom: 30px;
            }
            .answer{
                margin-top: 10px;
                background-color: #fff;
                padding-top: 10px;
                float:left;width:100%;
                padding-bottom: 10px;
            }
            .user-answer{
                text-align: left;
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
        <div class="content">
            <div class="question">
                <c:if test="${not empty requestScope.question}">
                    <c:set var="xmlQuestion" value="${requestScope.question}" />
                    <c:import var="xsl" url="WEB-INF/AnswerFeed.xsl" />              
                    <x:transform doc="${xmlQuestion}" xslt="${xsl}" />
                </c:if>
            </div>        

            <div class="write-answer">
                <form action="ProcessServlet" >
                    <hr style="margin-left:20px; margin-right:20px"/>
                    <textarea type="text" class="your-status" style="font-size:14px; width:95%" 
                              placeholder="Your answer" id="txtAnswer" name="txtAnswer" value="${param.txtAnswer}"></textarea>
                    <br/>
                    <hr style="margin-left:20px; margin-right:20px"/>
                    <div class="div-button" >
                        <input type="hidden" value="${sessionScope.USERNAME}" name="username" />
                        <input type="hidden" value="${requestScope.questionID}" name="questionId" />                
                        <input type="submit" class="btnPost" value="POST ANSWER" name="btAction"/>
                    </div> 
                    <br/>    
                    <br/>
                </form>
            </div>

            <div>
                <c:if test="${not empty requestScope.answerList}">
                    <c:set var="xmlAnswer" value="${requestScope.answerList}" />
                    <c:import var="xsl" url="WEB-INF/AnswerFeed.xsl" />              
                    <x:transform doc="${xmlAnswer}" xslt="${xsl}" />
                </c:if>
            </div>                    
        </div>
    </center>        
</body>
</html>
