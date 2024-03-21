<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>eMIS | Login</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <link rel="icon" href="resources/logo/rhis_favicon.png">
        <link href="resources/TemplateCSS/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/AdminLTE.min.css" rel="stylesheet" type="text/css"/>
        <script src="resources/TemplateJs/jquery-2.2.3.min.js" type="text/javascript"></script>
        <script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <style>
            html,body{ width:100%;height:100%; overflow: hidden}
            .login-box-body{
                border: 5px solid #ECF0F5;
                border-radius: 10px;
                box-shadow: 5px 5px 20px #888888;
            }
            #validMsgUsername, #validMsgPassword{
                color:red;
            }
            .boxH
            {
                width: 100%;
                height: 100%;
                position: absolute;
                top: 0;
                left: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            .boxV
            {
                /*                background-color: blue;*/
                height: 100%;
                display: flex;
                flex-direction: row;
                align-items: center;
            }
            .boxM
            {
                /*                background-color: yellow;*/
                padding: 3em;
            }
            .logo{
                text-align: center;
                margin-top: -4px;
                margin-bottom: 18px;
                font-size: 58px;
                text-shadow: 4px 4px 3px #e2e2e2;
                font-weight: bold;
            }
        </style>
        <style>
            .check-container {
                display: relative;
                position: relative;
                padding-left: 25px;
                margin-bottom: 12px;
                cursor: pointer;
                font-weight: normal;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
            }
            /* Hide the browser's default checkbox */
            .check-container input {
                display: relative;
                opacity: 0;
                cursor: pointer;
                height: 0;
                width: 0;
            }
            /* Create a custom checkbox */
            .checkmark {
                position: absolute;
                top: 0;
                left: 0;
                height: 20px;
                width: 20px;
                background-color: #eee;
            }
            /* On mouse-over, add a grey background color */
            .check-container:hover input ~ .checkmark {
                background-color: #ccc;
            }
            /* When the checkbox is checked, add a blue background */
            .check-container input:checked ~ .checkmark {
                background-color: #2489C5;
            }
            /* Create the checkmark/indicator (hidden when not checked) */
            .checkmark:after {
                content: "";
                position: absolute;
                display: none;
            }
            /* Show the checkmark when checked */
            .check-container input:checked ~ .checkmark:after {
                display: block;
            }
            /* Style the checkmark/indicator */
            .check-container .checkmark:after {
                left: 8px;
                top: 4px;
                width: 5px;
                height: 10px;
                border: solid white;
                border-width: 0 3px 3px 0;
                -webkit-transform: rotate(45deg);
                -ms-transform: rotate(45deg);
                transform: rotate(45deg);
            }
        </style>
        <script>
            function validateLoginForm() {
                var username = document.forms["loginForm"]["username"].value;
                var password = document.forms["loginForm"]["password"].value;
                if (username == "") {
                    document.getElementById('validMsgUsername').innerHTML = "Username required";
                    return false;
                } else {
                    document.getElementById('validMsgUsername').innerHTML = "";
                }
                if (password == "") {
                    document.getElementById('validMsgPassword').innerHTML = "Password required";
                    return false;
                } else {
                    document.getElementById('validMsgPassword').innerHTML = "";
                    s
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
        <div class="boxH">
            <div class="boxV">
                <div class="boxM">
                    <div class="login-box">
                        <div class="login-box-body">
                            <!--Logo-->
                            <div class="row">
                                <div class="center-block">
                                    <h1 class="logo"><span style="color:#ffc716">e</span><span style="color:#2276b7">MIS</span></h1>
                                </div>
                            </div>

                            <form role="form" method="POST" action="login" name="loginForm" onsubmit="return validateLoginForm()">
                                <!--Username FIeld-->
                                <div class="form-group has-feedback">
                                    <input type="text" class="form-control" placeholder="Username" name="username">
                                    <i class="fa fa-user form-control-feedback" aria-hidden="true"></i>
                                    <b id="validMsgUsername"></b>
                                </div>
                                <!--                    <div class="form-group">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">
                                                                <i class="fa fa-user" aria-hidden="true"></i>
                                                            </span> 
                                                            <input class="form-control" placeholder="Username" name="username" type="text"autofocus >                
                                                        </div>
                                                        <b id="validMsgUsername"></b>
                                                    </div>-->

                                <!--Password Field-->
                                <div class="form-group has-feedback">
                                    <input type="password" class="form-control" placeholder="Password" name="password">
                                    <i class="fa fa-lock form-control-feedback" aria-hidden="true"></i>
                                    <b id="validMsgPassword"></b>
                                </div>
                                <!--                    <div class="form-group">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">
                                                                <i class="fa fa-lock" aria-hidden="true"></i>
                                                            </span>
                                                            <input class="form-control" placeholder="Password" name="password" type="password" value="" >
                                                        </div>
                                                        <b id="validMsgPassword"></b>
                                                    </div>-->

                                <div class="row">
                                    <div class="col-md-6 col-xs-12">
                                        <label class="check-container" data-toggle="tooltip" data-placement="top" title="Under development !">Remember me
                                            <input type="checkbox">
                                            <span class="checkmark"></span>
                                        </label>
                                        <!--                                        <div class="checkbox icheck">
                                                                                    <label>
                                                                                        <input type="checkbox"> Remember Me
                                                                                    </label>
                                                                                </div>-->
                                    </div>
                                    <div class="col-md-6 col-xs-12" style="text-align: right;">
                                        <label>
                                            <a href="#" style="font-weight: normal;" data-toggle="tooltip" data-placement="top" title="Under development !">Forgot password ?</a>
                                        </label>
                                    </div>
                                </div>
                                <!--Error Message-->
                                <% if (request.getParameter("error") != null) { %>
                                <div class='alert alert-danger'>
                                    <strong><center>Username or password mismatch !</center></strong> 
                                </div>
                                <% }%>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <button type="submit" class="btn btn-primary btn-block btn-flat" style="font-weight: bold;">Login</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
<script>
    $(document).ready(function () {
        $('[data-toggle="tooltip"]').tooltip();
    });
</script>