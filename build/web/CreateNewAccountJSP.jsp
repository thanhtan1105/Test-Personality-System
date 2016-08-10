<%-- 
    Document   : CreateNewAccountJSP
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
        <title>New Account</title>
        <meta name="viewport" content="width=device-width">
        <style>
            #error {
                color: red;
            }

            .error {
                color: red;
            }

            .form-group{
                padding: 6px;
            }

            .beautifyInput{
                display: block;
                width: 100%;
                height: 20px;
                padding: 6px 12px;
                font-size: 14px;
                line-height: 1.42857143;
                color: #555;
                background-color: #fff;
                background-image: none;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .button{
                display: inline-block;
                padding: 6px 12px;
                margin-bottom: 0;
                font-size: 14px;
                font-weight: normal;
                line-height: 1.42857143;
                text-align: center;
                white-space: nowrap;
                vertical-align: middle;
                cursor: pointer;
                background-image: none;
                border: 1px solid transparent;
                border-radius: 4px;

            }
            .div-content{
                margin-top: 30px;
                padding-top: 2%;
                padding-bottom:  1%;
                width: 30%;
                background-color:#fff;
            }
            body{
                background-color: #DFDCE0;
            }
            a:link {
                color:#1C95E8;
                text-decoration: none;
            }

            /* visited link */
            a:visited {
                color: blue;
            }

            /* mouse over link */
            a:hover {
                color: #1CBAE8;
            }

            /* selected link */
            a:active {
                color: blue;
            }
        </style>
    </head>
    <body>
    <center>
        <img src="/XMLProject/image/logo.png" width="20%" style="margin-top:5%"/>
        <div class="div-content">   

            <form action="http://localhost:8080/XMLProject/ProcessServlet" method="POST" onsubmit="return onClickButtonSubmit(this)">
                <input id="txtUsername" type="text" placeholder="Username" name="txtUsername" value="" class="beautifyInput" style="width: 80%;"> <br>
                <input id="txtPassword" type="password" placeholder="Password" name="txtPassword" value="" class="beautifyInput" style="width: 80%;"> <br>
                <input id="txtConfirmPassword" type="password" placeholder="Confirm Password" name="txtConfirmPassword" value="" class="beautifyInput" style="width: 80%;"> <br>
                <input type="submit" value="Create New Account" name="btAction" class="button" style="background-color: #562b36;color:#fff;width:80%"> <br>
                <br>
                <div style="width:80%;text-align:right">
                    <a href="login.html" class="create">
                        I have already account
                    </a> 
                </div>
            </form>                        
            <h4 id="error"></h4> 
        </div>
    </center>


    <script>
        function onClickButtonSubmit() {
            var result;
            var txtPassword = document.getElementById("txtPassword").value;
            var txtConfirm = document.getElementById("txtConfirmPassword").value;
            var txtUsername = document.getElementById("txtUsername").value;

            if (txtUsername.length < 4) {
                result = "Username must be larger than 4 character";
                document.getElementById("error").innerHTML = result;
                return false;
            }

            if (txtPassword.length < 6) {
                result = "Password must be larger than 6 character";
                document.getElementById("error").innerHTML = result;
                return false;
            }

            if (txtPassword !== txtConfirm) {
                result = "Password and Password confirm must be match";
                document.getElementById("error").innerHTML = result;
                return false;
            }
            return true;
        }
    </script>




</body>
</html>

