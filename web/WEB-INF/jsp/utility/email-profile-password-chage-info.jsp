<%-- 
    Document   : profile
    Created on : May 15, 2017, 3:12:16 PM
    Author     : Nibras Ar Rakib
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeaderWOSidebar.jspf" %>
<style>
    .content { display: none; }
    #profileBox{
        height: 290px;
    }
    .error{
        color: red;
    }
    #viewStatus, #viewUpdateStatus{
        display: none;
    }
    .callout.callout-success, .callout.callout-danger, .callout.callout-warning {
        background-color: #fff !important;
        border-radius: 10px!important;
    }
    .callout.callout-success {
        border: 2px solid #00A65A!important;
        color: #00A65A!important;
        box-shadow: inset 0 0 5px #00A65A!important;
    }
    .callout.callout-danger {
        border: 3px solid #DD4B39!important;
        color: #DD4B39!important;
        box-shadow: inset 0 0 6px #DD4B39!important;
    }
    .callout.callout-warning {
        border: 3px solid #F39C12!important;
        color: #F39C12!important;
        box-shadow: inset 0 0 6px #F39C12!important;
    }
    .callout h4 {
        margin-top: 5px;
        font-weight: 600;
        margin-bottom: 7px;
    }
</style>
<script>
    $(document).ready(function () {
        getUser();
        function  getUser() {
            $.ajax({
                url: "profile?action=viewProfile",
                type: 'POST',
                success: function (result) {
                    $('.content').slideDown("slow");
                    var json = JSON.parse(result);
                    console.log(json);
                    //create Date
                    $('#createDate').html($.app.date(json[0].systementrydate).datetimeHuman);
                    $('#name').html(json[0].name);
                    $('#editName').val(json[0].name);
                    $('#email').html(json[0].email);
                    $('#editEmail').val(json[0].email);
                    $('#username').html(json[0].uname);
                    $('#level').html(json[0].userlevel);
                    $('#editPassword').val(json[0].pass);
                    if (json[0].active == '1') {
                        $('#active').html("<span style='color:green'>Active</span>");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                }
            }); //Ajax end
        } //End View users



        /*
         $('#btnConfirmUpdate').click(function () {
         var btn = $(this).button('loading');
         $.ajax({
         url: "profile?action=updateProfile",
         data: {
         name: $("#editName").val(),
         email: $("#editEmail").val()
         },
         type: 'POST',
         success: function (result) {
         btn.button('reset');
         $('#updateUserModal').modal('hide');
         getUser();
         $('#nameAtLogout').empty();
         $('#nameAtLogout').html($("#editName").val());
         $('#nameAtMenu').empty();
         $('#nameAtMenu').html($("#editName").val());
         $('#nameAtProfile').empty();
         $('#nameAtProfile').html($("#editName").val());
         toastr["success"]("<h4><b>Update Successfully!</b></h4>");
         },
         error: function (jqXHR, textStatus, errorThrown) {
         btn.button('reset');
         toastr["error"]("<h4><b>Request can't be processed</b></h4>");
         }
         });
         });
         */

//Update profile
        $(document).off('submit', '#update-profile-form').on('submit', '#update-profile-form', function (e) {
            e.preventDefault();
            var data = $.app.pairs('#update-profile-form');
            var validation = true;
            console.log(data);
            //Reset validation message
            $("#viewUpdateStatus").css("display", "none");
            updateProfileItem.forEach(function (item) {
                $("." + item).text("");
                $("#" + item).css("border-color", "#d2d6de");
            });
            if (data.editName == "") {
                validationError(".editName", "Name should not be blank");
                validation = false;
            }
            if (data.editEmail == "") {
                validationError(".editEmail", "Email should not be blank");
                validation = false;
            } else if (!/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(data.editEmail)) {
                validationError(".editEmail", "Email is not correct");
                validation = false;
            }
            if (validation) {
                updateProfile(data);
            } else {
                return;
            }
        });
        var updateProfileItem = ["editName", "editEmail"];
        function updateProfile(data) {
            $.ajax({
                url: "profile?action=updateProfile",
                data: {
                    name: data.editName,
                    email: data.editEmail
                },
                type: 'POST',
                success: function (result) {
                    getUser();
                    $('#nameAtLogout').empty();
                    $('#nameAtLogout').html($("#editName").val());
                    $('#nameAtMenu').empty();
                    $('#nameAtMenu').html($("#editName").val());
                    $('#nameAtProfile').empty();
                    $('#nameAtProfile').html($("#editName").val());
                    $("#viewUpdateStatus").css("display", "block");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                }
            });
        }



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
                url: "profile?action=checkOldPassword",
                data: {
                    username: $.app.user.username,
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
                        url: "profile?action=changePassword",
                        data: {
                            username: $.app.user.username,
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
        Change your password
    </h1>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-md-3">
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
        </div>
        <div class="col-md-9">
            <h4 class="alert alert-danger">${remoteResponse}</h4>
            <br />
            <h4 class="alert alert-danger">${remoteResponseSuggest}</h4>
        </div>
    </div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
