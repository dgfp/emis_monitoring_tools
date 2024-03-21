<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<!--<link href="resources/bootstrap-multiselect/bootstrap-multiselect.css" rel="stylesheet" type="text/css"/>
<script src="resources/bootstrap-multiselect/bootstrap-multiselect.js" type="text/javascript"></script>-->
<link href="resources/jsTree/themes/default/style.min.css" rel="stylesheet" type="text/css"/>
<script src="resources/jsTree/jstree.min.js" type="text/javascript"></script>
<script src="resources/js/userManagementArea.js" type="text/javascript"></script>
<script src="resources/js/area_dropdown_control_add_monitoringtools_user.js" type="text/javascript"></script>
<script src="resources/js/AssetManagement.js" type="text/javascript"></script>
<style>
    /*.add-dialog {
      width: 50%;
      height: 100%;
      margin: 4%;
      padding: 0;
    }*/

    /*    .add-content {
            height: auto;
            min-height: 50%;
            border-radius: 0;
        }*/
    /*    #tableContent { display: none; }*/

    /*    tr {
            max-height: 15px !important;
            height: 15px !important;
        }*/
    /*#data-table{
        font-size: 15px;
    }*/
    /*    select.multiselect,
        select.multiselect + div.btn-group,
        select.multiselect + div.btn-group button.multiselect,
        select.multiselect + div.btn-group.open .multiselect-container{
            width:100% !important;
        }*/
    .label {
        border-radius: 11px!important;
    }
    .multiselect-container.dropdown-menu{
        width: 100% !important;
    }

    [class*="col"] { margin-bottom: 10px; }
    .multiselect-container.dropdown-menu{
        z-index: 49;
    }
</style>
<script>
    var jsonUser = null;
    var jsonUserLevel = null;

    $(document).ready(function () {
        var validationMsg = $('#msg');
        var json;
        //View user table initially - 0 mean all record
        getUserData();
//------------------------------------------------------------------------Read Data (User)-------------------------------------------------------------------------------------
        function  getUserData() {
            $.ajax({
                url: "loginUser?action=viewLoginUser",
                type: 'POST',
                success: function (result) {


                    //Load user level drop down initially 
                    var returnedData = JSON.parse(result).userType;
                    jsonUserLevel = JSON.parse(result).userType;
                    var userRole = JSON.parse(result).userRole;

                    var selectTag = $('select#userLevel');
                    selectTag.find('option').remove();
                    $('<option>').val("0").text('- Select User Level -').appendTo(selectTag);

                    for (var i = 0; i < returnedData.length; i++) {
                        console.log(returnedData[i].cname);
                        var id = returnedData[i].code;
                        var name = returnedData[i].cname;
                        $('<option>').val(id).text(name).appendTo(selectTag);
                    }
                    //Set role
                    var roleid = $('select#roleid');
                    roleid.find('option').remove();
                    $('<option>').val("0").text('All').appendTo(roleid);

                    for (var i = 0; i < userRole.length; i++) {
                        var id = userRole[i].roleid;
                        var name = userRole[i].rolename;
                        $('<option>').val(id).text(name).appendTo(roleid);
                    }



                    //View All user information
                    json = JSON.parse(result).loginUser;
                    jsonUser = JSON.parse(result).loginUser;

                    //Get Table
                    renderData(json);
                    // ADD USER FORM - GENERATE DIVISION



                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                }
            });//Ajax end
        }

//-----------------------------------------------------------------------------------Create User---------------------------------------------------------------------------------

        $('#createUser').click(function () {
            //reset user area fields
            $("#name").val("");
            $("#username").val("");
            $("#password").val("");
            $("#email").val("");
            //reset user level drop downs
            $('#userLevel').val(0);
            validationMsg.html("");
            //reset areas
            $("#division").hide();
            $("#divisionLbl").hide();
            $("#district").hide();
            $("#districtLbl").hide();
            $("#upazila").hide();
            $("#upazilaLbl").hide();
            $("#union").hide();
            $("#unionLbl").hide();
            $("#village").hide();
            $("#villageLbl").hide();
            $('#myModal').modal('show');
        });
        $('#create').click(function () {

            var name = $("#name").val();
            var username = $("#username").val();
            var password = $("#password").val();
            var email = $("#email").val();
            var designation = $("#designation").val(); //hhh
            var isActive = $("select#isActive").val();
            var userLevel = $("select#userLevel").val();
            var divisionId = $("select#division").val();
            var districtId = $("select#district").val();
            var upazilaId = $("select#upazila").val();
            var unionId = $("select#union").val();
            var villageId = $("select#village").val();
            //validation
            if (name === "") {
                validationMsg.html("Name required");

            } else if (username === "") {
                validationMsg.html("Username required");

            } else if (password === "") {
                validationMsg.html("Password required");

            } else if (designation === "") {
                validationMsg.html("Select designation");

            } else if (userLevel === "0") {
                validationMsg.html("Select user level");

            } else if (divisionId === "0" && $('#division').is(':visible')) {
                validationMsg.html("Select Division!");

            } else if (districtId === "0" && $('#district').is(':visible')) {
                validationMsg.html("Select District");

            } else if (upazilaId === "0" && $('#upazila').is(':visible')) {
                validationMsg.html("Select Upazila");

            } else if (unionId === "0" && $('#union').is(':visible')) {
                validationMsg.html("Select Union");

            } else if (villageId === "0" && $('#village').is(':visible')) {
                validationMsg.html("Select Village");

            } else {
                if (email != "") {
                    var atpos = email.indexOf("@");
                    var dotpos = email.lastIndexOf(".");
                    if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
                        validationMsg.html("Please write valid email address");
                        return;
                    }
                }


                var btn = $(this).button('loading');

                $.ajax({
                    url: "loginUser?action=checkUsername",
                    data: {
                        username: username
                    },
                    type: 'POST',
                    success: function (result) {
                        // btn.button('reset');
                        json = JSON.parse(result);
                        if (json[0].count > 0) {
                            btn.button('reset');
                            $("#username").focus();
                            validationMsg.html("Username Already Exist");
                        } else {
                            $.ajax({
                                url: "loginUser?action=addLoginUser",
                                data: {
                                    name: name,
                                    username: username,
                                    password: password,
                                    email: email,
                                    designation: designation,
                                    isActive: isActive,
                                    userLevel: userLevel,
                                    division: divisionId,
                                    district: districtId,
                                    upazila: upazilaId,
                                    union: unionId,
                                    village: villageId
                                },
                                type: 'POST',
                                success: function (result) {
                                    btn.button('reset');
                                    $('#myModal').modal('hide');

                                    getUserData();
                                    toastr["success"]("<h4><b>User Successfully Added!</b></h4>");

                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    btn.button('reset');
                                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                                }
                            });

                        }

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        btn.button('reset');
                        toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                    }
                });
            }
        }); //End Create user part


//-----------------------------------------------------------------------------------Edit User--------------------------------------------------------------------------------- 
        $('#btnConfirmToEdit').click(function () {

//                    var isActive = $("select#editIsActive").val();
//                    var userLevel = $("select#editUserLevel").val();

            var btn = $(this).button('loading');
            $.ajax({
                url: "loginUser?action=editLoginUser",
                data: {
                    isActive: $("select#editIsActive").val(),
                    userLevel: $("select#editUserLevel").val(),
                    userId: $("#editUserId").val()
                },
                type: 'POST',
                success: function (result) {
                    btn.button('reset');
                    $('#editUser').modal('hide');

                    getUserData();
                    toastr["success"]("<h4><b>User Update Successfully!</b></h4>");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    btn.button('reset');
                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                }
            });

        }); //End Create user part


//---------------------------------------------------------------------------------------Delete User ------------------------------------------------------------------------              
        $('#btnConfirm').click(function () {
            var deleteUserName = $('#deleteUserName').val();

            var btn = $(this).button('loading');

            $.ajax({
                url: "loginUser?action=deleteLoginUser",
                data: {
                    userId: $('#deleteUserId').val(),
                    userName: $('#deleteUserName').val()
                },
                type: 'POST',
                success: function (result) {
                    btn.button('reset');

                    $('#deleteUser').modal('hide');
                    getUserData();
                    toastr["success"]("<h4><b>User Successfully Removed!</b></h4>");

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    btn.button('reset');
                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");

                }
            });

        });//End Delete user parts





        $(document).off('submit', '#showData').on('submit', '#showData', function (e) {
            e.preventDefault();
            var area = $.app.pairs('#showData');
            console.log(area);
            var filteredJson = jsonUser;

            if (area.divid != 0) {
                filteredJson = jsonUser.filter(obj => obj.divid == area.divid);
            }
            if (area.zillaid != 0) {
                filteredJson = jsonUser.filter(obj => obj.zillaid == area.zillaid);
            }
            if (area.upazilaid != 0) {
                filteredJson = jsonUser.filter(obj => obj.upazilaid == area.upazilaid);
            }
            if (area.unionid != 0) {
                filteredJson = jsonUser.filter(obj => obj.unionid == area.unionid);
            }
            if (area.roleid != 0) {
                filteredJson = jsonUser.filter(obj => obj.roleid == area.roleid);
            }
            console.log(filteredJson);
            renderData(filteredJson);
        });

        function renderData(json) {
            var table = $('#data-table').DataTable();
            $('#tableContent').slideDown("slow");

            var tableBody = $('#tableBody');
            var table = $('#data-table').DataTable();
            table.destroy();
            tableBody.empty();

            console.log(json);

            for (var i = 0; i < json.length; i++) {
                var status;
                var user = json[i].uname;
                if (json[i].active === 1) {
                    status = "<span class='label label-flat label-success label-xs'>Active</span>";
                } else {
                    status = "<span class='label label-flat label-danger label-xs'>In Active</span>";
                }
                var name = json[i].name.length > 50 ? json[i].name.substring(0, 50) + " ..." : json[i].name;
                var parsedData = '<tr><td>' + (i + 1) + '</td>'
                        + '<td>' + name + '</td>'
                        + '<td>' + json[i].rolename + '</td>'
                        + '<td>' + json[i].cname + '</td>'
//                                + '<td>' + json[i].email + '</td>'
                        + '<td>' + json[i].designame + '</td>'
                        + '<td style="text-align:center">' + status + '</td>'
                        + '<td style="text-align:center"><a class="btn btn-flat btn-primary btn-xs" onclick="readUserHandler(\'' + i + '\')"><i class="fa fa-clone" aria-hidden="true"></i></a>       <a class="btn btn-flat btn-warning btn-xs" onclick="editUserHandler(\'' + i + '\')"><i class="fa fa-pencil" aria-hidden="true"></i></a>          <a class="btn btn-flat btn-danger btn-xs" onclick="deleteUserHandler(\'' + i + '\')"><i class="fa fa-trash" aria-hidden="true"></i></a></td>'
                        + '</tr>';

                tableBody.append(parsedData);
                // <button type="button" id=read"  class="btn btn-primary btn-xs"  data-toggle="modal" data-target="#viewUser"><i class="fa fa-file-text-o" aria-hidden="true"></i></button>                             <button type="button"  class="btn btn-warning btn-xs"  data-toggle="modal" data-target="#editUser"><i class="fa fa-pencil" aria-hidden="true"></i></button>               <button type="button"  class="btn btn-danger btn-xs" onclick="deleteUserHandler(\''+json[i].uname +'\')" ><i class="fa fa-trash" aria-hidden="true"></i></button> 
            }
            var table = $('#data-table').DataTable();
            table.draw();

        }

    }); //Jquery End



//---------------------------------------------------------------------------------------Check User existance  ------------------------------------------------------------------------
    function  checkUsername(username) {

        var isExist;

        var btn = $(this).button('loading');
        $.ajax({
            url: "loginUser?action=checkUsername",
            data: {
                username: username
            },
            type: 'POST',
            success: function (result) {
                // btn.button('reset');
                json = JSON.parse(result);
                isExist = json[0].count;
                if (isExist > 0) {
                    return true;
                } else {
                    return false;
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                btn.button('reset');
                toastr["error"]("<h4><b>Request can't be processed</b></h4>");
            }
        });

    }

//---------------------------------------------------------------------------------------Edit User ------------------------------------------------------------------------
    function  editUserHandler(index) {
        $('#editUser').modal('show');

        //load User status
        var selectTag = $('#editIsActive');
        selectTag.find('option').remove();
        console.log(jsonUser[index].active);
        if (jsonUser[index].active == 1) {
            $('<option selected>').val("1").text('Yes').appendTo(selectTag);
            $('<option>').val("2").text('No').appendTo(selectTag);
        } else {
            $('<option>').val("1").text('Yes').appendTo(selectTag);
            $('<option selected>').val("2").text('No').appendTo(selectTag);

        }

        //load user level
        var selectTagUserLevel = $('#editUserLevel');
        selectTagUserLevel.find('option').remove();
        for (var i = 0; i < jsonUserLevel.length; i++) {
            var id = jsonUserLevel[i].code;
            var name = jsonUserLevel[i].cname;

            if (jsonUserLevel[i].cname === jsonUser[index].cname) {
                $('<option selected>').val(id).text(name).appendTo(selectTagUserLevel);
            } else {
                $('<option>').val(id).text(name).appendTo(selectTagUserLevel);
            }
        }

        $('#editUserId').val(jsonUser[index].uname);
    }

//---------------------------------------------------------------------------------------Delete User ------------------------------------------------------------------------
    function  deleteUserHandler(index) {
        $('#deleteUser').modal('show');
        $('#deleteUserId').val(jsonUser[index].uname);
        $('#deleteUserName').val(jsonUser[index].userid);
        $('#deleteName').val(jsonUser[index].name);
    }

//---------------------------------------------------------------------------------------View User ------------------------------------------------------------------------
    function  readUserHandler(index) {
        $('#viewUser').modal('show');

        var status;
        if (jsonUser[index].active === 1) {
            status = "<span class='label label-flat label-success'>Active</span>";
        } else {
            status = "<span class='label label-flat label-danger'>InActive</span>";
        }

        var isExist = jsonUser[index].name;
        if (jsonUser[index].name === 'null') {
            isExist = " - ";
        }

        var dateTime = jsonUser[index].credate.split(" ");
        var date = dateTime[0].split("-");
        //var my= date[2]+"/"+date[1]+"/"+date[0]+" "+dateTime[1];
        $('#viewName').html(isExist);
        $('#viewEmail').html(jsonUser[index].email);
        $('#viewUsername').html(jsonUser[index].userid);
        if ($('#userRole').val() == 'Super admin') {
            $('#viewPassword').html(jsonUser[index].pass);
        } else {
            $('#viewPassword').html("********");
        }
        $('#viewStatus').html(status);
        $('#viewLevel').html(jsonUser[index].cname);
        $('#viewCreateDate').html(date[2] + "/" + date[1] + "/" + date[0]);
    }
</script>
<style>

</style>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        Web access control
        <small>User</small>
    </h1>
    <ol class="breadcrumb">
        <!--        <a class="btn btn-flat btn-success btn-sm" id="createUser"><i class="fa fa-user-plus" aria-hidden="true"></i> <b>&nbsp;Add User</b></a>-->
        <a class="btn btn-flat btn-info btn-sm" href="loginUser"><b>User</b></a>
        <a class="btn btn-flat btn-primary btn-sm" href="menu"><b>Menu</b></a>
        <a class="btn btn-flat btn-primary btn-sm" href="subMenu"><b>Sub-Menu</b></a>
        <a class="btn btn-flat btn-primary btn-sm" href="role"><b>Role</b></a>
        <a class="btn btn-flat btn-primary btn-sm" href="userRole"><b>User Role</b></a> 
        <a class="btn btn-flat btn-primary btn-sm" href="roleAccess"><b>Role Access</b></a>
    </ol>
</section>


<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary full-screen">
                <div class="box-header with-border">
                    <div class="form-group form-group-sm">
                        <div class="col-md-2 col-xs-4 col_">
                            <a class="btn btn-flat btn-success btn-sm" id="createUser"><i class="fa fa-user-plus" aria-hidden="true"></i> <b>&nbsp;Add User</b></a>
                            <!--                            
                                                        <button type="button" id="createUser"  class="btn btn-flat btn-success btn-sm">
                                                            <i class="fa fa-user-plus" aria-hidden="true"></i> <b>&nbsp;Add User
                                                        </button>-->
                        </div>
                    </div>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>

                <!--  Table top -->
                <!--            <div class="box-header">
                                <h3 class="box-title"> 
                                    <button type="button" id="" onclick="clear(1);"  class="btn btn-flat btn-primary"  data-toggle="modal" data-target="#myModal">
                                            <i class="fa fa-user-plus" aria-hidden="true"></i> <b>&nbsp;Add User</b>
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
                        </div>-->

                <!-- table -->
                <div class="box-body">


                    <form action="asset" method="post" id="showData">
                        <div class="row">
                            <div class="col-md-1 col-xs-2">
                                <label for="division">Division</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="divid" id="divid"> </select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="zilla">District</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="zillaid" id="zillaid"> 
                                    <option value="0">All</option>
                                </select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="upazilaid">Upazila</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="upazilaid" id="upazilaid">
                                    <option value="0">All</option>
                                </select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="unionid">Union</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="unionid" id="unionid">
                                    <option value="0">All</option>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-1  col-xs-0 col-md-offset-5">
                            </div>
                            <div class="col-md-1 col-xs-2">
                                <label for="">User Role</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="roleid" id="roleid">
                                    <option value="0">All</option>
                                </select>
                            </div>

                            <div class="col-md-1  col-xs-2">
                            </div>
                            <div class="col-md-2  col-xs-4">
                                <button type="submit" class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                    <i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; Show data
                                </button>
                            </div>
                        </div>
                    </form><br/>
                    <div class="table-responsive">
                        <table class="table table-hover table-striped" id="data-table">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                    <th>Role&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                    <th>Level</th>
                                    <th>Designation</th>
                                    <th style="text-align: center">Status</th>
                                    <th style="text-align: center">Actions</th>
                                </tr>
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

<!-------------------------------------------------------------------------------- Delete User Modal -------------------------------------------------------------------------------->        
<div class="modal fade" id="deleteUser" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header label-danger">
                <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                <h4 class="modal-title"><b><i class="fa fa-trash" aria-hidden="true"></i><span>    &nbsp; Are you sure ?</span></b></h4>
            </div>
            <div class="modal-body">
                <input type="hidden" id="deleteUserId">
                <input type="hidden" id="deleteUserName">
                <input type="hidden" id="deleteName">
                <button type="button" id="btnConfirm" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger">Confirm</button>&nbsp;&nbsp;
                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>



<!-------------------------------------------------------------------------------- Add User Modal -------------------------------------------------------------------------------->  
<div id="myModal" class="modal fade" role="dialog">
    <div class="row">
        <div class="col-xs-12">
            <div class="modal-dialog add-dialog">
                <!-- Modal content-->
                <div class="modal-content add-content">
                    <div class="box">
                        <div class="box-header modal-header label-primary">
                            <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                            <h4 class="modal-title"><b><i class="fa fa-user-plus" aria-hidden="true"></i><span>    &nbsp; Add New User</span></b></h4>
                        </div>
                        <div class="modal-body box-body">
                            <div class="form-group">
                                <label>Name <span class="star">*</span></label>
                                <input class="form-control" placeholder="Name" id='name'>
                            </div>
                            <div class="form-group">
                                <label>Username <span class="star">*</span></label>
                                <input class="form-control" placeholder="Username" id='username'>
                            </div>

                            <div class="form-group">
                                <label>Password <span class="star">*</span></label>
                                <input type="password" class="form-control" placeholder="Password" id='password'>
                            </div>

                            <div class="form-group">
                                <label>Email</label>
                                <input class="form-control" placeholder="Email" id='email'>
                            </div>

                            <div class="form-group">
                                <label>Designation <span class="star">*</span></label>
                                <select class="form-control" id='designation'>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Is Active</label>
                                <select class="form-control" id='isActive'>
                                    <option value="1">Yes</option>
                                    <option value="2">No</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>User Level <span class="star">*</span></label>
                                <select class="form-control userLevel" id='userLevel'>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Provider Management Access <span class="star">*</span></label>
                                <select class="form-control userProviderManagementAccess" id='userProviderManagementAccess'>
                                    <option value="0">- Please Select -</option>
                                    <option value="1">Yes</option>
                                    <option value="2">No</option>
                                </select>
                            </div>

                            <div class="row">
                                <div class="col-md-6 section-geo-report hide">

                                    <!--MULTIPLE SELECT FOR GEO (REPORT)-->
                                    <div id="multiSelDivisionContainer" class="form-group hide">
                                        <label>Division <span class="star">*</span></label>
                                        <div>
                                            <select class="form-control input-sm" name="multiSelDivision" id="multiSelDivision" multiple="multiple">
                                            </select>
                                        </div>
                                    </div>

                                    <div id="multiSelDistrictContainer" class="form-group hide">
                                        <label>District <span class="star">*</span></label>
                                        <div>
                                            <select class="form-control input-sm" name="multiSelDistrict" id="multiSelDistrict" multiple="multiple">
                                            </select>
                                            <div id="multiSelDistrictTree"></div>
                                        </div>
                                    </div>

                                    <div id="multiSelUpazilaContainer" class="form-group hide">
                                        <label>Upazila <span class="star">*</span></label>
                                        <div>
                                            <select class="form-control input-sm " name="multiSelReportingUpazila" id="multiSelReportingUpazila" multiple="multiple">
                                            </select>
                                        </div>
                                    </div>
                                    <div id="multiSelUnionContainer" class="form-group hide">
                                        <label>Union <span class="star">*</span></label>
                                        <div>
                                            <select class="form-control input-sm " name="multiSelReportingUnion" id="multiSelReportingUnion" multiple="multiple">
                                            </select>
                                        </div>
                                    </div>

                                    <!--                            <div class="form-group">
                                                                    <label id='divisionLbl'>Division <span class="star">*</span></label>
                                                                    <select class="form-control input-sm" name="division" id="division">
                                                                        <option value="0">- Select Division -</option>
                                                                    </select>
                                                                </div>
                                    
                                                                <div class="form-group">
                                                                    <label id='districtLbl'>District <span class="star">*</span></label>
                                                                    <select class="form-control input-sm" name="district" id="district">
                                                                        <option value="0">- Select District -</option>
                                                                    </select>
                                                                </div>
                                    
                                                                <div class="form-group">
                                                                    <label id='upazilaLbl'>Upazila <span class="star">*</span></label>
                                                                    <select class="form-control input-sm" name="upazila" id="upazila">
                                                                        <option value="0">- Select Upazila -</option>
                                                                    </select>
                                                                </div>
                                    
                                                                <div class="form-group">
                                                                    <label id='unionLbl'>Union <span class="star">*</span></label>
                                                                    <select class="form-control input-sm" name="union" id="union">
                                                                        <option value="0">- Select Union -</option>
                                                                    </select>
                                                                </div>
                                    
                                                                <div class="form-group">
                                                                    <label id='villageLbl'>Village <span class="star">*</span></label>
                                                                    <select class="form-control input-sm" name="village" id="village">
                                                                        <option value="0">- Select Village -</option>
                                                                    </select>
                                                                </div>-->
                                </div>
                                <!--MULTIPLE SELECT FOR GEO (PROVIDER MANAGEMENT ACCESS)-->
                                <div class="col-md-6 section-geo-provider-management hide">
                                    <div class="form-group">
                                        <label>Division <span class="star">*</span></label>
                                        <div>
                                            <select class="form-control input-sm hide" name="multiSelDivisionPa" id="multiSelDivisionPa" multiple="multiple">
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label>District <span class="star">*</span></label>
                                        <div>
                                            <select class="form-control input-sm hide" name="multiSelDistrictPa" id="multiSelDistrictPa" multiple="multiple">
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label>Upazila <span class="star">*</span></label>
                                        <div>
                                            <select class="form-control input-sm hide" name="multiSelUpazilaPa" id="multiSelUpazilaPa" multiple="multiple">
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <h4><b id="msg" style="color:red;"></b></h4>

                            <div class="form-group">
                                <button type="button" class="btn btn-flat btn-primary " id="create" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing">Submit</button>&nbsp;&nbsp;
                                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>


<!-------------------------------------------------------------------------------- edit User Modal -------------------------------------------------------------------------------->  
<div id="editUser" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header label-warning">
                <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                <h4 class="modal-title"><b><i class="fa fa-pencil-square-o" aria-hidden="true"></i><span>    &nbsp; Update User</span></b></h4>
            </div>

            <div class="modal-body">
                <div class="form-group">
                    <label>Is Active</label>
                    <select class="form-control" id='editIsActive'>
                        <option value="1">Yes</option>
                        <option value="2">No</option>
                    </select>
                </div>
                <div class="form-group" style="display: none" >
                    <label>User Level</label>
                    <select class="form-control" id='editUserLevel'>
                        <option value="0">All</option>
                    </select>
                </div>
                <input type="hidden" id="editUserId">
                <!--                <div class="form-group">
                                    <label>Name</label>
                                    <input class="form-control" placeholder="Enter Name" value="">
                                </div>-->
                <!--                <div class="form-group">
                                    <label>Username</label>
                                    <input class="form-control" placeholder="Enter Username" value="m.helal.k">
                                </div>
                                <div class="form-group">
                                    <label>Password</label>
                                    <input class="form-control" placeholder="Enter Password" value="123">
                                </div>-->
                <div class="form-group">
                    <button type="button"  id="btnConfirmToEdit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Updating" class="btn btn-flat btn-warning">Update</button>&nbsp;&nbsp;
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>


<!-------------------------------------------------------------------------------- View User Modal -------------------------------------------------------------------------------->  
<div id="viewUser" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header label-primary">
                <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                <h4 class="modal-title"><b><i class="fa fa-address-card-o" aria-hidden="true"></i><span>    &nbsp; User Details</span></b></h4>
            </div>

            <div class="modal-body">
                <table class="table table-striped table-hover" id="data-table">
                    <tbody id="tableBody">
                        <tr>
                            <td class="pull-right">Name</td>
                            <td><b id="viewName"></b></td>
                        </tr>               
                        <tr>
                            <td class="pull-right">Email</td>
                            <td><b id="viewEmail"></b></td>
                        </tr>                        
                        <tr>
                            <td class="pull-right">Username</td>
                            <td><b id="viewUsername"></b></td>
                        </tr>
                        <tr>
                            <td class="pull-right">Password</td>
                            <td><b id="viewPassword"></b></td>
                        </tr>                          
                        <tr>
                            <td class="pull-right">Status</td>
                            <td><b id="viewStatus"></b></td>
                        </tr>                        
                        <tr>
                            <td class="pull-right">Level</td>
                            <td><b id="viewLevel"></b></td>
                        </tr>
                        <tr>
                            <td class="pull-right">Created Date</td>
                            <td><b id="viewCreateDate"></b></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
