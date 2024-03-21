<%-- 
    Document   : userRole
    Created on : Feb 18, 2017, 12:21:30 PM
    Author     : Helal
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<style>
    #tableContent { display: none; }
    #data-table{
        font-size: 15px;
    }
    .form-group {
        margin-bottom: 0px!important;
    }
</style>
<script>
    var jsonUserRole = null;
    var jsonRole = null;
    var json = null;
    var user = null;

    $(document).ready(function () {

        var validationMsg = $('#msg');

        getUserRoleData(0);

        //Search Role ===========================
        $('#search').keyup(function () {
            var searchField = $('#search').val();
            var regex = new RegExp(searchField, "i");
            var tableBody = $('#tableBody');
            tableBody.empty();
            //reset dropdown
            $('#tableEntrySize').get(0).selectedIndex = 0;
            for (var i = 0; i < jsonUserRole.length; i++) {
                if ((jsonUserRole[i].name.search(regex) !== -1)) {
                    var parsedData = '<tr><td>' + (i + 1) + '</td>'
                            + '<td>' + jsonUserRole[i].name + '</td>'
                            + '<td>' + jsonUserRole[i].rolename + '</td>'
                            //                                    + '<td>' + json[i].name + '</td>'
                            + '<td style="text-align:center"> <a class="btn btn-flat btn-warning btn-xs" onclick="editUserRoleHandler(\'' + i + '\')"><i class="fa fa-pencil" aria-hidden="true"></i></a>          <a class="btn btn-flat btn-danger btn-xs" onclick="deleteUserRoleHandler(\'' + i + '\')"><i class="fa fa-trash" aria-hidden="true"></i></a></td>'
                            + '</tr>';
                    tableBody.append(parsedData);
                }
            }
        });

        //Show no. of entries===========================
        $('#tableEntrySize').change(function (event) {
            getUserRoleData($('#tableEntrySize').val());
        });

//------------------------------------------------------------------------Read Data (User)-------------------------------------------------------------------------------------
        function  getUserRoleData(tableRowSize) {

            Pace.track(function () {
                $.ajax({
                    url: "userRole?action=viewUserRole",
                    type: 'POST',
                    success: function (result) {
                        $('#tableContent').slideDown("slow");
                        //Load UserWithoutRole and ROle drop down initially--------------------------------------------------------------------------------------------------

                        //Login User
                        result = JSON.parse(result);
                        console.log(result);
                        var returnedData = result.user;
                        user = returnedData;
                        //user role
                        var userRole = result.userRole;
                        jsonUserRole = userRole;

                        // var returnedData.filter()

                        var selectTag = $('select#userWithoutRole').Select(result.user, {placeholder: '- Select User Without Role -', id: function () {
                                return this.uname
                            }, text: function () {
                                return this.name + ' - (' + this.userid + ')';
                            }});

                        var jsonRoleData = result.role;
                        jsonRole = jsonRoleData;


                        $('select#role').Select(result.role, {placeholder: '- Select Role -', id: function () {
                                return this.roleid
                            }, text: function () {
                                return this.rolename
                            }});

                        json = jsonUserRole;

                        var tableBody = $('#tableBody');
                        tableBody.empty();

                        var loopSize = json.length;
                        if (tableRowSize > 0) {
                            loopSize = tableRowSize;
                        }

                        for (var i = 0; i < loopSize; i++) {

                            var parsedData = '<tr><td>' + (i + 1) + '</td>'
                                    + '<td>' + json[i].name + '</td>'
                                    + '<td>' + json[i].rolename + '</td>'
                                    //                                    + '<td>' + json[i].name + '</td>'
                                    + '<td style="text-align:center"> <a class="btn btn-flat btn-warning btn-xs" onclick="editUserRoleHandler(\'' + i + '\')"><i class="fa fa-pencil" aria-hidden="true"></i></a>          <a class="btn btn-flat btn-danger btn-xs" onclick="deleteUserRoleHandler(\'' + i + '\')"><i class="fa fa-trash" aria-hidden="true"></i></a></td>'
                                    + '</tr>';
                            tableBody.append(parsedData);
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                    }
                }); //Ajax End
            }); //End Pace

        }// End  getUserRoleData



//-----------------------------------------------------------------------------------Create User--------------------------------------------------------------------------------- 
        $('#create').click(function () {

            var role = $("select#role").val();
            var userWithoutRole = $("select#userWithoutRole").val();

            //validation
            if (userWithoutRole === "0" || userWithoutRole === "") {
                validationMsg.html("Select user");

            } else if (role === "0" || role === "") {
                validationMsg.html("Select Role");

            } else {
                var btn = $(this).button('loading');
                $.ajax({
                    url: "userRole?action=addUserToRole",
                    data: {
                        roleId: role,
                        userId: userWithoutRole
                    },
                    type: 'POST',
                    success: function (result) {
                        btn.button('reset');
                        $('#myModal').modal('hide');

                        getUserRoleData();
                        toastr["success"]("<h4><b>User  Added to Role Successfully</b></h4>");

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        btn.button('reset');
                        toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                    }
                });
            }

        }); //End Create user part

//-----------------------------------------------------------------------------------edit User role--------------------------------------------------------------------------------- 
        $('#btnConfirmToEdit').click(function () {
            var btn = $(this).button('loading');
            $.ajax({
                url: "userRole?action=editUserRole",
                data: {
                    editUserId: $("#editUserId").val(),
                    editUserRole: $("select#editUserRole").val()
                },
                type: 'POST',
                success: function (result) {
                    btn.button('reset');
                    $('#editUser').modal('hide');

                    getUserRoleData();
                    toastr["success"]("<h4><b> User Role Update Successfully</b></h4>");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    btn.button('reset');
                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                }
            });
        }); //End Create user part

//---------------------------------------------------------------------------------------Delete User role------------------------------------------------------------------------              
        $('#btnConfirmToDelete').click(function () {

            var btn = $(this).button('loading');
            $.ajax({
                url: "userRole?action=deleteUserRole",
                data: {
                    username: $('#deleteUserId').val()
                },
                type: 'POST',
                success: function (result) {
                    btn.button('reset');

                    $('#deleteUser').modal('hide');
                    getUserRoleData();
                    toastr["success"]("<h4><b>Remove User From Role Successfully</b></h4>");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    btn.button('reset');
                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                }
            });

        });//End Delete user part

    }); //End Jquery 

//---------------------------------------------------------------------------------------Edit User Role------------------------------------------------------------------------
    function  editUserRoleHandler(index) {
        $('#editUser').modal('show');
        $('#editUserId').val(jsonUserRole[index].userid);
        $('#editUserRoleUser').val(jsonUserRole[index].name);

        //load user level
        var selectTagUserRolel = $('#editUserRole');
        selectTagUserRolel.find('option').remove();

        for (var i = 0; i < jsonRole.length; i++) {
            var id = jsonRole[i].roleid;
            var name = jsonRole[i].rolename;

            if (jsonRole[i].rolename === jsonUserRole[index].rolename) {
                $('<option selected>').val(id).text(name).appendTo(selectTagUserRolel);
            } else {
                $('<option>').val(id).text(name).appendTo(selectTagUserRolel);
            }
        }
    }

//---------------------------------------------------------------------------------------Delete User Role------------------------------------------------------------------------
    function  deleteUserRoleHandler(index) {
        $('#deleteUser').modal('show');
        var r = jsonUserRole[index];
        console.log(jsonUserRole[index]);
        var html = "<b>Role:</b> " + r.rolename + " for <br><b>User:</b> " + r.name;
        $('#deleteUserName').html(html);
        $('#deleteUserId').val(jsonUserRole[index].userid);
    }
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        Web access control
        <small>User Role</small>
    </h1>
    <ol class="breadcrumb">
        <a class="btn btn-flat btn-primary btn-sm" href="loginUser"><b>User</b></a>
        <a class="btn btn-flat btn-primary btn-sm" href="menu"><b>Menu</b></a>
        <a class="btn btn-flat btn-primary btn-sm" href="subMenu"><b>Sub-Menu</b></a>
        <a class="btn btn-flat btn-primary btn-sm" href="role"><b>Role</b></a>
        <a class="btn btn-flat btn-info btn-sm" href="userRole"><b>User Role</b></a> 
        <a class="btn btn-flat btn-primary btn-sm" href="roleAccess"><b>Role Access</b></a>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row" id="tableContent">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="alertMsg" id="alertMain">
                </div>
                <div class="box-header">
                    <h3 class="box-title"> 
                        <button type="button" id=""  class="btn btn-flat btn-primary"  data-toggle="modal" data-target="#myModal">
                            <i class="fa fa-user-circle-o" aria-hidden="true"></i> <b>&nbsp;Add User to Role</b>
                        </button>
                    </h3>
                    <h3 class="box-title pull-center">  <span id="result">Show</span>
                        <select id="tableEntrySize">
                            <option value="0">All</option>
                            <option value="10">10</option>
                            <option value="15">15</option>
                            <option value="20">20</option>
                            <option value="25">25</option>
                            <option value="30">30</option>
                        </select>entries 
                    </h3>
                    <h3 class="box-title pull-right">   
                        <input type="text" class="form-control" placeholder="Search ...." id="search">
                    </h3>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped" id="data-table">
                            <thead class="data-table">
                                <tr>
                                    <th>#</th>
                                    <th onclick="short(1);">User <span class="pull-right"><i class="fa fa-long-arrow-down" aria-hidden="true"></i></span></th>
                                    <th>Role</th>
                                    <th style="text-align: center">Actions</th>
                                </tr>
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                        <ul class="pager pull-right">
                            <li><a href="#">Previous</a></li>
                            <li><a href="#">1</a></li>
                            <li><a href="#">Next</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!--DELETE-->    
<div class="modal fade" id="deleteUser" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header label-danger">
                <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                <h4 class="modal-title"><b><i class="fa fa-trash" aria-hidden="true"></i><span> Are you sure to delete?</span></b></h4>
            </div>
            <div class="modal-body">
                <p id="deleteUserName"></p>
                <input type="hidden" id="deleteUserId">
                <button type="button" id="btnConfirmToDelete" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger">Confirm</button>&nbsp;&nbsp;
                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>

<!---INSERT-->
<div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header label-primary">
                <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                <h4 class="modal-title"><b><i class="fa fa-user-circle-o" aria-hidden="true"></i><span>    &nbsp; Add User to Role</span></b></h4>
            </div>  
            <div class="modal-body">
                <div class="form-group">
                    <label id='userWithoutRoleLb'>User Without Role</label><br/>
                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%; margin-right: 30px!important;" tabindex="-1" aria-hidden="true" name="userWithoutRole" id="userWithoutRole">
                        <option selected="selected">- Select User Without Role -</option>
                    </select>&nbsp;&nbsp;
                </div>
                <div class="form-group">
                    <label id='roleLb'>Role</label><br/>
                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%; margin-right: 30px!important;" tabindex="-1" aria-hidden="true" name="role" id="role">
                        <option selected="selected">- Select User Without Role -</option>
                    </select>&nbsp;&nbsp;
                </div>
                <h4><b id="msg" style="color:red;"></b></h4>
                <div class="form-group">
                    <button type="button" class="btn btn-flat btn-primary " id="create" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing">Submit</button>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!--UPDATE-->
<div id="editUser" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header label-warning">
                <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                <h4 class="modal-title"><b><i class="fa fa-pencil-square-o" aria-hidden="true"></i><span>    &nbsp; Update User Role</span></b></h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label>User</label>
                    <input class="form-control" type="text" placeholder="" id='editUserRoleUser' disabled="true">
                </div>
                <div class="form-group">
                    <label>Role</label>
                    <select class="form-control" id='editUserRole'>
                    </select>
                </div>
                <input class="form-control" type="hidden" placeholder="" id='editUserId' disabled="true">
                <div class="form-group">
                    <button type="button" id="btnConfirmToEdit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Updating" class="btn btn-flat btn-warning btn-sm">Update</button>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
</div>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
