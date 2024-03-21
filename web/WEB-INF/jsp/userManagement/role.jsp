<%-- 
    Document   : newjsprole
    Created on : Feb 18, 2017, 12:21:09 PM
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
</style>
<script>
    
    var jsonRole=null;
                
    $(document).ready(function () {
        var validationMsg=$('#msg');
        var json;
        
        //View role table initially - 0 mean all record
        getRoleData(0);
        
        //Search Role ===========================
        $('#search').keyup(function(){
            var searchField = $('#search').val();
            var regex = new RegExp(searchField, "i");
            var tableBody = $('#tableBody');
            tableBody.empty();
            //reset dropdown
            $('#tableEntrySize').get(0).selectedIndex = 0;
            for (var i = 0; i < jsonRole.length; i++) {
                      if ((jsonRole[i].rolename.search(regex) !== -1)) {
                            var parsedData = '<tr ><td>' + (i + 1) + '</td>'
                            + '<td >'  + json[i].rolename +  '</td>'
                            + '<td >'  + json[i].a +  '</td>'
                            + '<td >'  + json[i].b +  '</td>'
                            + '<td style="text-align:center">    <a class="btn btn-flat btn-warning btn-xs" onclick="editRoleHandler(\''+i +'\')"><i class="fa fa-pencil" aria-hidden="true"></i></a>          <a class="btn btn-flat btn-danger btn-xs" onclick="deleteRoleHandler(\''+i +'\')"><i class="fa fa-trash" aria-hidden="true"></i></a></td>'
                            + '</tr>';
                        tableBody.append(parsedData);
                      }
             }
        });
        
        //Show no. of entries===========================
        $('#tableEntrySize').change(function (event) {
             getRoleData($('#tableEntrySize').val());
        });
   
//------------------------------------------------------------------------Read Data (User)-------------------------------------------------------------------------------------
        function  getRoleData(tableRowSize){
            
            Pace.track(function(){
                $.ajax({
                    url: "role?action=viewRole",
                    type: 'POST',
                    success: function (result) {
                        $('#tableContent').slideDown("slow");
                        var ajaxLoading = $('#ajaxLoading');
                        ajaxLoading.empty();

                         //View All user information
                         json = JSON.parse(result);
                         jsonRole = JSON.parse(result);
                        //Get Table
                        var tableBody = $('#tableBody');
                        tableBody.empty();

                        var loopSize= json.length;
                        if(tableRowSize>0){
                            loopSize=tableRowSize;
                        }
                        
                        for (var i = 0; i < loopSize; i++) {

                                var parsedData = '<tr ><td>' + (i + 1) + '</td>'
                                + '<td >'  + json[i].rolename +  '</td>'
                                + '<td >'  + json[i].a +  '</td>'
                                + '<td >'  + json[i].b +  '</td>'
                                + '<td style="text-align:center">    <a class="btn btn-flat btn-warning btn-xs" onclick="editRoleHandler(\''+i +'\')"><i class="fa fa-pencil" aria-hidden="true"></i></a>          <a class="btn btn-flat btn-danger btn-xs" onclick="deleteRoleHandler(\''+i +'\')"><i class="fa fa-trash" aria-hidden="true"></i></a></td>'
                                + '</tr>';
                                tableBody.append(parsedData);
                                // <button type="button" id=read"  class="btn btn-primary btn-xs"  data-toggle="modal" data-target="#viewUser"><i class="fa fa-file-text-o" aria-hidden="true"></i></button>                             <button type="button"  class="btn btn-warning btn-xs"  data-toggle="modal" data-target="#editUser"><i class="fa fa-pencil" aria-hidden="true"></i></button>               <button type="button"  class="btn btn-danger btn-xs" onclick="deleteUserHandler(\''+json[i].uname +'\')" ><i class="fa fa-trash" aria-hidden="true"></i></button> 
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        btn.button('reset');
                        toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                    }
                }); //end ajax
            });

        }    
                
                
                
//-----------------------------------------------------------------------------------Create User--------------------------------------------------------------------------------- 
        $('#createRole').click(function () {

            var roleName = $("#roleName").val();

            //validation
            if(roleName===""){
                validationMsg.html("Role Name required");

            }else{
                var btn = $(this).button('loading');
                $.ajax({
                    url: "role?action=addRole",
                    data: {
                        roleName: roleName
                    },
                    type: 'POST',
                    success: function (result) {
                        btn.button('reset');
                        $('#addRole').modal('hide');

                            getRoleData();
                            toastr["success"]("<h4><b>Role Added Successfully</b></h4>");
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        btn.button('reset');
                        toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                    }
                });
            }

        }); //End Create user part
                
                
                
//-----------------------------------------------------------------------------------edit User--------------------------------------------------------------------------------- 
        $('#btnConfirmToEdit').click(function () {

            var  editRoleName = $("#editRoleName").val();


            if(editRoleName===""){
                validationMsg.html("Role Name required");

            }else{
                var btn = $(this).button('loading');
                $.ajax({
                    url: "role?action=editRole",
                    data: {
                        editRoleName: editRoleName,
                        editRoleId: $("#editRoleId").val()
                    },
                    type: 'POST',
                    success: function (result) {
                        btn.button('reset');
                        $('#editRole').modal('hide');

                        getRoleData();
                        toastr["success"]("<h4><b>Role Update Successfully</b></h4>");

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        btn.button('reset');
                        toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                    }
                });

            }

        }); //End Create user part
                

//---------------------------------------------------------------------------------------Delete ROLE ------------------------------------------------------------------------              
        $('#btnConfirmToDelete').click(function () {
            var btn = $(this).button('loading');

            $.ajax({
                url: "role?action=deleteRole",
                data: {
                    deleteRoleId: $('#deleteRoleId').val()
                },
                type: 'POST',
                success: function (result) {
                    btn.button('reset');

                    $('#deleteRole').modal('hide');
                    getRoleData();
                    toastr["success"]("<h4><b>Role Remove Successfully!</b></h4>");

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    btn.button('reset');
                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                }
            });

        });//End Delete user part
           
    });
               
                      
//---------------------------------------------------------------------------------------Edit role ------------------------------------------------------------------------
    function  editRoleHandler(index){
            $('#editRole').modal('show');

            $('#editRoleName').val(jsonRole[index].rolename);
            $('#editRoleId').val(jsonRole[index].roleid);
    }

//---------------------------------------------------------------------------------------Delete role ------------------------------------------------------------------------
    function  deleteRoleHandler(index){
            $('#deleteRole').modal('show');
            $('#deleteRoleName').html("To delete role  <b>"+jsonRole[index].rolename+"</b>");
            console.log(jsonRole[index]);
            $('#deleteRoleId').val(jsonRole[index].roleid);
    }
</script>

<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Web access control
    <small>Role</small>
  </h1>
  <ol class="breadcrumb">
      <a class="btn btn-flat btn-primary btn-sm" href="loginUser"><b>User</b></a>
      <a class="btn btn-flat btn-primary btn-sm" href="menu"><b>Menu</b></a>
        <a class="btn btn-flat btn-primary btn-sm" href="subMenu"><b>Sub-Menu</b></a>
        <a class="btn btn-flat btn-info btn-sm" href="role"><b>Role</b></a>
        <a class="btn btn-flat btn-primary btn-sm" href="userRole"><b>User Role</b></a> 
        <a class="btn btn-flat btn-primary btn-sm" href="roleAccess"><b>Role Access</b></a>
  </ol>
</section>
    
<!-- Main content -->
<section class="content">
  <div class="row" id="tableContent">
    <div class="col-xs-12">
        <div class="box box-primary">
            
            <!-- alert view -->
            <div class="alertMsg" id="alertMain">
            </div>
            
            <!--  Table top -->
            <div class="box-header">
                <h3 class="box-title"> 
                    <button type="button" id=""  class="btn btn-flat btn-primary"  data-toggle="modal" data-target="#addRole">
                        <i class="fa fa-plus-circle" aria-hidden="true"></i> <b>&nbsp;Add Role</b>
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
            
        <!-- table -->
        <div class="box-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped" id="data-table">
                    <thead class="data-table">
                        <tr>
                            <th>#</th>
                            <th onclick="short(1);">Role <span class="pull-right"><i class="fa fa-long-arrow-down" aria-hidden="true"></i></span></th>
                            <th>No. of User</th>
                            <th>No. of Access</th>
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
                <!--  <li class="active"><a href="#">2</a></li>-->
                <li><a href="#">Next</a></li>
                </ul>
            </div>
        </div>
        
      </div>
    </div>
  </div>
</section>

<!-------------------------------------------------------------------------------- Delete Role Modal -------------------------------------------------------------------------------->        
<div class="modal fade" id="deleteRole" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header label-danger">
          <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
        <h4 class="modal-title"><b><i class="fa fa-trash" aria-hidden="true"></i><span>    &nbsp; Are you sure ?</span></b></h4>
      </div>
      <div class="modal-body">
          <h4 id="deleteRoleName"></h4>
          <input type="hidden" id="deleteRoleId">
        <button type="button" id="btnConfirmToDelete" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger">Confirm</button>&nbsp;&nbsp;
        <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div>
</div>
             
          
<!-------------------------------------------------------------------------------- Add Role Modal -------------------------------------------------------------------------------->  
    <div id="addRole" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
        <div class="modal-header label-primary">
            <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
            <h4 class="modal-title"><b><i class="fa fa-plus-circle" aria-hidden="true"></i><span>    &nbsp; Add Role</span></b></h4>
        </div>    

          <div class="modal-body">
                <div class="form-group">
                    <label>Role Name</label>
                    <input class="form-control" placeholder="Role Name" id='roleName'>
                </div>
              
                <h4><b id="msg" style="color:red;"></b></h4>
                
                <div class="form-group">
                    <button type="button" class="btn btn-flat btn-primary " id="createRole" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing">Submit</button>
                </div>
          </div>

          <div class="modal-footer">
            <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>

      </div>
</div>


<!-------------------------------------------------------------------------------- edit User Modal -------------------------------------------------------------------------------->  
    <div id="editRole" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header label-warning">
              <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
            <h4 class="modal-title"><b><i class="fa fa-pencil-square-o" aria-hidden="true"></i><span>    &nbsp; Update Role</span></b></h4>
          </div>

          <div class="modal-body">
              
                <div class="form-group">
                    <label>Role Name</label>
                    <input class="form-control" placeholder="Role Name" id='editRoleName'>
                </div>
                <input type="hidden" id="editRoleId">
                
              
                <div class="alertMsg" id="alert">
                </div>
                
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


<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
