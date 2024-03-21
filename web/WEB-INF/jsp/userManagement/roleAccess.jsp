<%-- 
    Document   : roleAccess
    Created on : Feb 18, 2017, 12:20:59 PM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<style>
    #data-table{
    font-size: 15px;
}
    .material-switch > input[type="checkbox"] {
        display: none;   
    }

    .material-switch > label {
        cursor: pointer;
        height: 0px;
        position: relative; 
        width: 40px;  
    }

    .material-switch > label::before {
        background: rgb(0, 0, 0);
        box-shadow: inset 0px 0px 10px rgba(0, 0, 0, 0.5);
        border-radius: 8px;
        content: '';
        height: 16px;
        margin-top: -8px;
        position:absolute;
        opacity: 0.3;
        transition: all 0.4s ease-in-out;
        width: 40px;
    }
    .material-switch > label::after {
        background: rgb(255, 255, 255);
        border-radius: 16px;
        box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.3);
        content: '';
        height: 24px;
        left: -4px;
        margin-top: -8px;
        position: absolute;
        top: -4px;
        transition: all 0.3s ease-in-out;
        width: 24px;
    }
    .material-switch > input[type="checkbox"]:checked + label::before {
        background: inherit;
        opacity: 0.5;
    }
    .material-switch > input[type="checkbox"]:checked + label::after {
        background: inherit;
        left: 20px;
    }
    #tableContent { display: none; }
</style>


<style>
.switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 34px;
}

.switch input {display:none;}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}
</style>

<script>
    
    var json=null;
    var RoleAccess=null;
     
    $(document).ready(function () {
            

            //View role access table initially - 1 mean super admin & 0 mean all record
            getRoleAccess(1,0);
            
            //Show no. of entries===========================
            $('#tableEntrySize').change(function (event) {
                 getRoleAccess($('#role').val(),$('#tableEntrySize').val());
            });
            
            //Search Role ===========================
            $('#search').keyup(function(){
                var searchField = $('#search').val();
                var regex = new RegExp(searchField, "i");
                var tableBody = $('#tableBody');
                tableBody.empty();
                //reset entry dropdown
                $('#tableEntrySize').get(0).selectedIndex = 0;
                for (var i = 0; i < json.length; i++) {
                    if ((json[i].modreptitle.search(regex) !== -1)) {
                        var isAccessed='<span class="material-switch">'
                            +'<input id="someSwitchOptionPrimary'+i+'" onchange="setRoleAccess(this, \''+ json[i].modrep +'\')"  type="checkbox" />'
                            +'<label for="someSwitchOptionPrimary'+i+'" class="label-primary"></label>'
                        +'</span>';

                        for (var j = 0; j < RoleAccess.length; j++) {

                            if(json[i].modrep===RoleAccess[j].modrep){
                                isAccessed='<span class="material-switch">'
                                    +'<input id="someSwitchOptionPrimary'+i+'" checked onchange="setRoleAccess(this, \''+ json[i].modrep +'\')"  type="checkbox" />'
                                    +'<label for="someSwitchOptionPrimary'+i+'" class="label-primary"></label>'
                                +'</span>';
                                break;
                            }

                        }

                        var parsedData = '<tr><td style="text-align:center;">' + (i + 1) + '</td>'
                        + '<td>'+isAccessed+'</td>'
                        + '<td>' + json[i].modreptitle + '</td>'
                        + '<td>' + ((json[i].servlet_url === "null") ? "" : json[i].servlet_url)+ '</td>'
                        + '<td>' + json[i].modname + '</td>'
                        + '</tr>';
                        tableBody.append(parsedData);
                    }
                 }
            });
            
            //Change role event to see role access=============
            $('#role').change(function (event) {
                var roleId=$('#role').val();
                getRoleAccess(roleId,$('#tableEntrySize').val());
            });
        });
               
//---------------------------------------------------------------------------------set  role access-------------------------------------------------------------
    function  setRoleAccess(checkbox, subMenu){
       
        
        var role = $('select#role').val();
        var tableEntrySize = $('select#tableEntrySize').val();
        //Set Access
        if (checkbox.checked) {
                
            $.ajax({
                url: "roleAccess?action=addRoleAccess",
                data: {
                    roleId: role,
                    subMenu: subMenu
                },
                type: 'POST',
                success: function (result) {
                    getRoleAccess(role,tableEntrySize);
                    toastr["success"]("<h4><b>Access Update Successfully</b></h4>");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                }
            });

        }// Remove access
        else {

            $.ajax({
                url: "roleAccess?action=removeRoleAccess",
                data: {
                    roleId: role,
                    subMenu: subMenu
                },
                type: 'POST',
                success: function (result) {
                    getRoleAccess(role,tableEntrySize);
                    toastr["success"]("<h4><b>Access Update Successfully</b></h4>");

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                }
            });

        } 
    }


//---------------------------------------------------------------------------------Get role access data by role -------------------------------------------------------------
    function  getRoleAccess(roleId,tableRowSize){

        Pace.track(function(){
            $.ajax({
                url: "roleAccess?action=viewRoleAccess",
                data: {
                    roleId: roleId
                },
                type: 'POST',
                success: function (result) {
                    $('#tableContent').slideDown("slow");
                   //Load user level drop down initially 
                   var returnedData=JSON.parse(result).role;
                    var selectTag = $('#role');
                    selectTag.find('option').remove();

                    //load Dropdown role
                    for (var i = 0; i < returnedData.length; i++) {

                        var n = Number(roleId);

                        var id = returnedData[i].roleid;
                        var name = returnedData[i].rolename;

                        if( id===n){
                            $('<option selected>').val(id).text(name).appendTo(selectTag);

                        }else{
                            $('<option>').val(id).text(name).appendTo(selectTag);
                        }
                    }
                    
                    //View All user information
                    json = JSON.parse(result).moduleReport;
                    RoleAccess = JSON.parse(result).roleAccess;
                    
                   //Get Table
                   var tableBody = $('#tableBody');
                   tableBody.empty();
                   
                    var loopSize= json.length;
                    if(tableRowSize>0){
                        loopSize=tableRowSize;
                    }
                    
                    for (var i = 0; i < loopSize; i++) {
                        
                        var isAccessed='<span class="material-switch">'
                            +'<input id="someSwitchOptionPrimary'+i+'" onchange="setRoleAccess(this, \''+ json[i].modrep +'\')"  type="checkbox" />'
                            +'<label for="someSwitchOptionPrimary'+i+'" class="label-primary"></label>'
                        +'</span>';
                        
                        
                        //var isAccessed='<input  type="checkbox"   id="switch" class="minimal"  onchange="setRoleAccess(this, \''+ json[i].modrep +'\')">';

                        for (var j = 0; j < RoleAccess.length; j++) {

                            if(json[i].modrep===RoleAccess[j].modrep){
                                
                                isAccessed='<span class="material-switch">'
                                    +'<input id="someSwitchOptionPrimary'+i+'" checked onchange="setRoleAccess(this, \''+ json[i].modrep +'\')"  type="checkbox" />'
                                    +'<label for="someSwitchOptionPrimary'+i+'" class="label-primary"></label>'
                                +'</span>';

                                //isAccessed='<input type="checkbox" id="switch" checked class="minimal" onchange="setRoleAccess(this,\''+ json[i].modrep +'\')" >';
                                break;
                            }

                        }

                        var parsedData = '<tr><td style="text-align:center;">' + (i + 1) + '</td>'
                        + '<td>'+isAccessed+'</td>'
                        + '<td>' + json[i].modreptitle + '</td>'
                        + '<td>' + ((json[i].servlet_url === "null") ? "" : json[i].servlet_url)+ '</td>'
                        + '<td>' + json[i].modname + '</td>'
                        + '</tr>';
                        tableBody.append(parsedData);
                   }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                }
            }); //Ajax End
        }); //Pace End

    } // End getRoleAccess
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Web access control
    <small>Role Access</small>
  </h1>
  <ol class="breadcrumb">
      <a class="btn btn-flat btn-primary btn-sm" href="loginUser"><b>User</b></a>
      <a class="btn btn-flat btn-primary btn-sm" href="menu"><b>Menu</b></a>
        <a class="btn btn-flat btn-primary btn-sm" href="subMenu"><b>Sub-Menu</b></a>
        <a class="btn btn-flat btn-primary btn-sm" href="role"><b>Role</b></a>
        <a class="btn btn-flat btn-primary btn-sm" href="userRole"><b>User Role</b></a> 
        <a class="btn btn-flat btn-info btn-sm" href="roleAccess"><b>Role Access</b></a>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="row" id="tableContent">
    <div class="col-xs-12">
        <div class="box box-primary">
            
            <!--  Table top -->
            <div class="box-header">
            <b>Select Role: </b>
            <h3 class="box-title" >
                <select class="form-control"  name="role" id="role" style="width: 200px;">
                </select>
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
                            <th style="text-align: center">Access</th>
                            <th onclick="short(2);">Sub Menu <span class="pull-right"><i class="fa fa-long-arrow-down" aria-hidden="true"></i></span></th>
                            <th>URL</th>
                            <th>Menu</th>
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
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>