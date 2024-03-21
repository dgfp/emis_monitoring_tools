<%-- 
    Document   : EmailChangeUserPassword
    Created on : Oct 18, 2021, 9:14:00 PM
    Author     : nar_r
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/jspf/templateHeaderGeneral.jspf" %>
<style>
    #viewStatus, #viewUpdateStatus{
        display: none;
    }
</style>
<script>
    $(document).ready(function () {
//Change password
        $(document).off('submit', '#change-password-form').on('submit', '#change-password-form', function (e) {
            e.preventDefault();
            var data = $.app.pairs('form');
            var lowerCaseLetters = /[a-z]/g;
            var upperCaseLetters = /[A-Z]/g;
            var numbers = /[0-9]/g;
            var validation = true;
            //Reset validation message
            $("#viewStatus").css("display", "none");
            formItem.forEach(function (item) {
                $("." + item).text("");
                $("#" + item).css("border-color", "#d2d6de");
            });
            //Validation
            if (data.oldPassword == "") {
                validationError(".oldPassword", "Old password required.");
                validation = false;
            }
            if (data.newPassword == "") {
                validationError(".newPassword", "New password required.");
                validation = false;
            } else if (data.newPassword.length < 8) {
                validationError(".newPassword", "Password is too short, must be at least 8 characters.");
                validation = false;
            } else if (!data.newPassword.match(lowerCaseLetters)) {
                validationError(".newPassword", "Password must contain at least one small letter (lowercase).");
                validation = false;
            } else if (!data.newPassword.match(upperCaseLetters)) {
                validationError(".newPassword", "Password must contain at least one capital letter (uppercase).");
                validation = false;
            } else if (!data.newPassword.match(numbers)) {
                validationError(".newPassword", "Password must contain at least one numeric character.");
                validation = false;
            } else if (!/[*@!#$%&()^~{}]+/.test(data.newPassword)) {
                validationError(".newPassword", "Password must contain at least one special character character.");
                validation = false;
            } else if (!new RegExp('^[^\\s]+$').test(data.newPassword)) {
                validationError(".newPassword", "Password cannot contain white spaces.");
                validation = false;
            }
            if (data.confirmPassword == "") {
                validationError(".confirmPassword", "Confirm password required.");
                validation = false;
            }
            if (data.newPassword != data.confirmPassword) {
                $(".confirmPassword").text("Confirm password mismatch.");
                validation = false;
            }
            if (validation) {
                checkOldPassword(data);
            } else {
                return;
            }
        });

        var formItem = ["oldPassword", "newPassword", "confirmPassword"]
        function validationError(selector, message) {
            $(selector).text(message);
            $(selector).prev().css("border-color", "red");
        }
        function checkOldPassword(data) {
            $.ajax({
                url: "profile-online-change-password?action=checkOldPassword",
                data: {
                    username: $('#uName').val(),
                    oldPassword: data.oldPassword
                },
                type: 'POST',
                success: function (response) {
                    response = JSON.parse(response);
                    console.log(response);
                    if (!response.exist) {
                        validationError(".oldPassword", "Old password is not correct.");
                        return;
                    }
                    //change password here
                    $.ajax({
                        url: "profile-online-change-password?action=changePassword",
                        data: {
                            username: $('#uName').val(),
                            newPassword: data.newPassword
                        },
                        type: 'POST',
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response);
                            if (response.success == true) {
                                $("#viewStatus").css("display", "block");
                                formItem.forEach(function (item) {
                                    $("#" + item).val("");
                                });
                            } else {
                                toastr["error"]("<b>Somthing went wrong</b>");
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    });
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    btn.button('reset');
                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                }
            });
        }
    });
</script>

<section class="content-header">
    <h1>
        User:- ${uName}, change your password
    </h1>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <!--        <div class="col-md-3">
                    <div class="box box-primary" id="profileBox">
                        <div class="box-body box-profile">
                            <img class="profile-user-img img-responsive img-circle" src="resources/images/photo.png" alt="Photo">
        
                            <h3 class="profile-username text-center"><span id="nameAtProfile">${sessionScope.name}</span></h3>
        
                            <ul class="list-group list-group-unbordered">
                                <li class="list-group-item">
                                    <b>Role</b> <a class="pull-right">${sessionScope.role}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>Status</b> <a class="pull-right">Active</a>
                                </li>
                                <li class="list-group-item">
                                    <b>Joined on </b> <a class="pull-right" id="createDate"></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>-->
        <div class="col-md-9">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#changePassword" data-toggle="tab" class="bold">Change password</a></li>
                    <!--                    <li><a href="#activity"  class="bold" data-toggle="tab">Profile</a></li>
                                        <li><a href="#settings" data-toggle="tab" class="bold">Update</a></li>-->
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="changePassword">
                        <div class="row">
                            <div class="col-md-8 col-md-offset-2">
                                <div class="table-responsive">
                                    <div id="viewStatus"><div class="callout callout-success" style="margin-bottom: 0!important;"><h4 class="center bold" id="viewStatusText">Your password has been changed.</h4></div></div>

                                    <form id="change-password-form">
                                        <br>
                                        <div class="form-group">
                                            <input name="uName" id="uName" type="uName" class="form-control hidden" value="${uName}">
                                        </div>
                                        <br>
                                        <div class="form-group">
                                            <label for="oldPassword">Old password</label>
                                            <input name="oldPassword" id="oldPassword" type="password" class="form-control">
                                            <b class="oldPassword error"></b>
                                        </div>
                                        <div class="form-group">
                                            <label for="newPassword">New password</label>
                                            <input name="newPassword" id="newPassword" type="password" class="form-control">
                                            <b class="newPassword error"></b>
                                        </div>
                                        <div class="form-group">
                                            <label for="confirmPassword">Confirm new password</label>
                                            <input name="confirmPassword" id="confirmPassword" type="password" class="form-control">
                                            <b class="confirmPassword error"></b>
                                        </div>
                                        <br><input type="submit" class="btn btn-warning btn-flat btn-block mt-5 bold" value="Submit change">
                                    </form>
                                    <br/>
                                    <h4 class="callout callout-info">* Password must be 8 characters long and contain
                                        one uppercase, one lowercase, one special character and one digit minimum.</h4>
                                    <br />
                                    <h4 class="callout callout-info">* You have been redirect to this page because your password is too weak.</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@include file="/WEB-INF/jspf/templateFooterGeneral.jspf" %>
