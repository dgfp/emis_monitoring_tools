<%-- 
    Document   : userRole
    Created on : Feb 18, 2017, 12:21:30 PM
    Author     : Helal
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<style>
    .form-group {
        margin-bottom: 0px!important;
    }
    .select2-container--default .select2-selection--single .select2-selection__rendered {
        line-height: 22px;
    }
    .select2-container--default .select2-selection--single {
        border-radius: 0px;
    }
    .slno{
        width: 20px;
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

//------------------------------------------------------------------------Read Data (User)-------------------------------------------------------------------------------------
        function  getUserRoleData(tableRowSize) {
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

//                    var tableBody = $('#tableBody');
//                    tableBody.empty();

                    console.log(json);

                    var exportTitle = "", i = 10;
                    var columns = [
                        {data: "name", title: 'SLNo', class: "slno"},
                        {data: "name", title: 'Name of the user&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'},
                        {data: "rolename", title: 'Role&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'},
//                        {data: function (d) {
//                                return "0" + d.sim_number
//                            }, title: 'Sim'},
//                        {data: function (d) {
//                                //return d.name + " - " + d.userid;
//                                return  "<b>" + d.name + "</b><span style='color: #575a5e;'> - " + d.userid + " - " + d.designation + "</span>";
//                            }, title: "Asset user&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"},
//                        {data: "specification", title: 'Specification'},
//                        {data: function (d) {
//                                return "<b>" + d.duration.replace(/-/g, " ") + "</b>";
//                            }, title: 'Used duration'},
//                        {data: function (d) {
//                                return $.Asset.getStatus(d.status);
//                            }, title: "Status"},
                        { data: function (row, type, val, meta) {
                                //var json = JSON.stringify({"imei1": d.imei1, "sim_number": d.sim_number, "name_of_user": d.name_of_user, "providerid": d.providerid, "mobileno": d.mobileno});
                                //return  "<a class='btn btn-flat btn-primary btn-xs asset-view' id='" + d.imei1 + "-" + d.userid + "_" + d.sim_number + "_" + d.mobileno + "' data-info='" + json + "' data-prov='" + JSON.stringify({"provname": d.name, "providerid": d.userid}) + "'><b>Details</b></a>";
                                console.log(row, type, val, meta);
                                return '<a class="btn btn-flat btn-warning btn-xs bold" onclick="editUserRoleHandler(\'' + meta.row + '\')"><i class="fa fa-pencil" aria-hidden="true"></i> Update</a>          <a class="btn btn-flat btn-danger btn-xs bold" onclick="deleteUserRoleHandler(\'' + i + '\')"><i class="fa fa-trash" aria-hidden="true"></i> Delete</a>';
                            }, title: "Actions" }
                    ]
                    var options = {
                        data: json,
                        columns: columns,
                        fnRowCallback: function (nRow, aData, iDisplayIndex) {
                            $("td:first", nRow).html(iDisplayIndex + 1);
                            return nRow;
                        }
                    };
                    $('#table').dt(options);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                }
            }); //Ajax End

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
        $('#updateUser').html(jsonUserRole[index].name);
        $('#editUser').modal('show');
        $('#editUserId').val(jsonUserRole[index].userid);
        //$('#editUserRoleUser').val(jsonUserRole[index].name);

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
        var html = '<b><i class="fa fa-question-circle" aria-hidden="true"></i>&nbsp; Are you sure you want to delete ?</b><br/><br/>';
        html += "\"User: " + r.name + " &nbsp;-&nbsp; Role: " + r.rolename + "\"";
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
    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary full-screen">
                <div class="alertMsg" id="alertMain">
                </div>
                <div class="box-header with-border">
                    <div class="form-group form-group-sm">
                        <div class="col-md-2 col-xs-4 col_">
                            <button type="button" id=""  class="btn btn-flat btn-success btn-sm"  data-toggle="modal" data-target="#myModal">
                                <i class="fa fa-user-circle-o" aria-hidden="true"></i> <b>&nbsp;Add role to user</b>
                            </button>
                        </div>
                    </div>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <table id="table" class="table table-hover table-striped">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!--DELETE-->    
<div class="modal fade" id="deleteUser" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold">Confirm deletion</h4>
            </div>
            <div class="modal-body">
                <h4 class="center" id="deleteUserName"></h4>
                <input type="hidden" id="deleteUserId">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal">Cancel</button>
                <button type="button" id="btnConfirmToDelete" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger bold">Delete</button>&nbsp;&nbsp;
            </div>
        </div>
    </div>
</div>

<!---INSERT--> 
<div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold">Add role to user</h4>
            </div>  
            <div class="modal-body">
                <div class="form-group">
                    <label id='userWithoutRoleLb'>User without role</label><br/>
                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%; margin-right: 30px!important;" tabindex="-1" aria-hidden="true" name="userWithoutRole" id="userWithoutRole">
                        <option selected="selected">- Select user Without Role -</option>
                    </select>&nbsp;&nbsp;
                </div><br/>
                <div class="form-group">
                    <label id='roleLb'>Role</label><br/>
                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%; margin-right: 30px!important;" tabindex="-1" aria-hidden="true" name="role" id="role">
                        <option selected="selected">- Select User Without Role -</option>
                    </select>&nbsp;&nbsp;
                </div>
                <h4 class="bold" id="msg" style="color:red;"></h4>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-flat btn-success bold" id="create" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing">Submit</button>
            </div>
        </div>
    </div>
</div>

<!--UPDATE-->
<div id="editUser" class="modal fade" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold">Update role</h4>
            </div>
            <div class="modal-body">
                <!--                <div class="form-group">
                                    <label>User</label><br/>
                                    <input class="form-control" type="text" placeholder="" id='editUserRoleUser' style="background-color: rgb(255, 255, 255);" disabled="true">
                                </div><br/>-->
                <h4 class="bold center" id="updateUser"></h4>
                <div class="form-group">
                    <label>&nbsp;</label>
                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%; margin-right: 30px!important;" tabindex="-1" aria-hidden="true" name="editUserRole" id="editUserRole">
                        <option selected="selected">- Select User Without Role -</option>
                    </select>&nbsp;&nbsp;
                    </select>
                </div>
                <input class="form-control" type="hidden" placeholder="" id='editUserId' disabled="true">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-flat btn-warning bold" id="btnConfirmToEdit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Updating">Update</button>
            </div>
        </div>
    </div>
</div>
</div>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>