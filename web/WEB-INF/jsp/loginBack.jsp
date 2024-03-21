<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>eMIS | Log in</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <link rel="icon" href="resources/logo/rhis_favicon.png">
        <link href="resources/TemplateCSS/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
        <link href="resources/css/AdminLTE.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/style.css" rel="stylesheet">
        <script src="resources/TemplateJs/jquery-2.2.3.min.js" type="text/javascript"></script>
        <script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

        <style>
            .form-control{
                border-radius: 0 !important;
            }
            .login-box-body{
                border:.5px solid #6baee0;
                /*            border:.5px solid #286090;*/
                /*            box-shadow: 10px 10px 5px #888888;*/
                    box-shadow: 5px 5px 20px #888888;
            }
            #validMsgUsername, #validMsgPassword{
                color:red;
            }
        </style>
        <style>
           html,body{ width:100%;height:100%; overflow: hidden}
            #bg{ 
                     -moz-animation: bg 45s linear infinite;
                  -webkit-animation: bg 45s linear infinite;
                  -ms-animation: bg 45s linear infinite;
                  animation: bg 45s linear infinite;
                  opacity: 1;
                  visibility: visible;
                  position: fixed;
                  z-index: -1;
                  left:0;
                  right:0;
                  top:0;
                  bottom:0;
                  
            }
            #bg>div{
               
                 background-image: url('http://www.rhis.net.bd/wp-content/uploads/2016/09/PRS.jpg') ;
                  background-size: cover;
                  height: 100%;
                   width:150%;
            }

            @-moz-keyframes bg {
                0% {
                    -moz-transform: translateX(0);
                    -webkit-transform: translateX(0);
                    -ms-transform: translateX(0);
                    transform: translateX(0);
                }

                100% {
                    -moz-transform: translateX(-25%);
                    -webkit-transform: translateX(-25%);
                    -ms-transform: translateX(-25%);
                    transform: translateX(-25%);
                }
            }

            @-webkit-keyframes bg {
                0% {
                    -moz-transform: translateX(0);
                    -webkit-transform: translateX(0);
                    -ms-transform: translateX(0);
                    transform: translateX(0);
                }

                100% {
                    -moz-transform: translateX(-25%);
                    -webkit-transform: translateX(-25%);
                    -ms-transform: translateX(-25%);
                    transform: translateX(-25%);
                }
            }

            @-ms-keyframes bg {
                0% {
                    -moz-transform: translateX(0);
                    -webkit-transform: translateX(0);
                    -ms-transform: translateX(0);
                    transform: translateX(0);
                }

                100% {
                    -moz-transform: translateX(-25%);
                    -webkit-transform: translateX(-25%);
                    -ms-transform: translateX(-25%);
                    transform: translateX(-25%);
                }
            }

            @keyframes bg {
                0% {
                    -moz-transform: translateX(0);
                    -webkit-transform: translateX(0);
                    -ms-transform: translateX(0);
                    transform: translateX(0);
                }

                100% {
                    -moz-transform: translateX(-25%);
                    -webkit-transform: translateX(-25%);
                    -ms-transform: translateX(-25%);
                    transform: translateX(-25%);
                }
            }
        </style>
        <script>
            function validateLoginForm() {
                var username = document.forms["loginForm"]["username"].value;
                var password = document.forms["loginForm"]["password"].value;
                if (username == "") {
                    document.getElementById('validMsgUsername').innerHTML = "Username required";
                    return false;
                }

                if (password == "") {
                    document.getElementById('validMsgPassword').innerHTML = "Password required";
                    return false;
                }

                Pageloaded();

            }

            //Check inter connection when submit login
            function CheckOnlineStatus(msg) {
                //var status = document.getElementById("status");
                var condition = navigator.onLine ? "ONLINE" : "OFFLINE";
                if (condition == 'OFFLINE') {
                    alert("No internet connection");
                    return true;
                }
                return false;
            }
            function Pageloaded() {
                CheckOnlineStatus("load");
                document.body.addEventListener("offline", function () {
                    CheckOnlineStatus("offline")
                }, false);
                document.body.addEventListener("online", function () {
                    CheckOnlineStatus("online")
                }, false);
            }

        </script>
    </head>

    <body class="hold-transition login-page">
        <div id='bg'><div></div>
            <img src="resources/images/0.png" style="
                background: transparent;
                line-height: 0;
                position: absolute;
                top: 20px;
                right: -25%;
                height: 80%;
            ">
            
        </div>
        <div class="login-box">

            <div class="center-block"><br><br><br><br>
            </div>

            <div class="login-box-body">
                <!--Logo-->
                <div class="row">
                    <div class="center-block">
                        <!--                     <img class="profile-img" src="resources/logo/rhislogo.png" alt="Man"/>-->
                        <h1 style="text-align: center;margin-top: -2px;margin-bottom: 15px;font-size: 58px;text-shadow: 4px 4px 3px #e2e2e2;"><b><span style="color:#ffc716">e</span><span style="color:#2276b7">MIS</span></b></h1>
                    </div>
                </div>

                <form role="form" method="POST" action="login" name="loginForm" onsubmit="return validateLoginForm()">

                    <!--Username FIeld-->
                    <div class="form-group">
                        <!--                    <div class="form-group has-feedback">
                                                <input type="text" class="form-control" placeholder="Username" name="username" style="" autofocus required>
                                                <span class="glyphicon glyphicon-user form-control-feedback"></span>
                                            </div>-->

                        <!--                <div class="form-group">
                                            <label id='divisionLbl'>Division</label>
                                            <select class="form-control input-sm" name="division" id="division">
                                                <option value="0">- Select Division -</option>
                                            </select>
                                        </div>-->

                        <div class="input-group">
                            <span class="input-group-addon">
                                <i class="fa fa-user" aria-hidden="true"></i>
                            </span> 
                            <input class="form-control" placeholder="Username" name="username" type="text"autofocus >                
                        </div>
                        <b id="validMsgUsername"></b>
                    </div>

                    <!--Password Field-->
                    <div class="form-group">
                        <!--                    <div class="form-group has-feedback">
                                                <input type="password" class="form-control" placeholder="Password" name="password" required>
                                                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                                            </div>-->
                        <div class="input-group">
                            <span class="input-group-addon">
                                <i class="fa fa-lock" aria-hidden="true"></i>
                            </span>
                            <input class="form-control" placeholder="Password" name="password" type="password" value="" >
                        </div>
                        <b id="validMsgPassword"></b>
                    </div>

                    <!--Error Message-->
                    <% if (request.getParameter("error") != null) { %>
                    <div class='alert alert-danger'>
                        <strong><center>Username or password mismatch !</center></strong> 
                    </div>
                    <% }%>
                    <!--Submit Button-->
                    <!--                <div class="row">
                                      <div class="col-xs-12">
                                        <button type="submit" class="btn btn-flat btn-primary  ">Sign In</button>
                                      </div>
                                    </div>-->
                    <div class="row">
                        <!--                    <div class="col-xs-8">
                                              <div class="checkbox icheck">
                                                <label>
                                                    <a href="#" onclick="alert('Forgot password under development !');">I forgot my password</a>
                                                </label>
                                              </div>
                                            </div>-->
                        <div class="col-xs-12">
                            <button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </body>
</html>

