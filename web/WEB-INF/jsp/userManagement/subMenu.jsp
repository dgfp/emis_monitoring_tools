<%-- 
    Document   : menu
    Created on : Feb 26, 2017, 2:23:05 PM
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
<script>

    var jsonSubMmenu=null;
    var isVisible="1";
    var menu=null;
    
    $(document).ready(function () {
        var validationMsg=$('#msg');
        var validationMsgForEdit=$('#msgEdit');
        //View sub menu table initially - 0 mean all record
        getSubMenu(0);
            
        //Search Sub menu===========================
        $('#search').keyup(function(){
            var searchField = $('#search').val();
            var regex = new RegExp(searchField, "i");
            var tableBody = $('#tableBody');
            tableBody.empty();
            //reset dropdown
            $('#tableEntrySize').get(0).selectedIndex = 0;
            for (var i = 0; i < jsonSubMmenu.length; i++) {
                if ((jsonSubMmenu[i].modreptitle.search(regex) !== -1)) {
                    //Make visibility
                    var visible="<span class='label label-flat label-success label-xs'><i class='fa fa-eye' aria-hidden='true'></i></span>";
                    if(jsonSubMmenu[i].visible===0){
                        visible="<span class='label label-flat label-danger label-xs'><i class='fa fa-eye-slash' aria-hidden='true'></i></span>";
                    }
                    var parsedData = '<tr><td>' + (i + 1) + '</td>'
                    + '<td>' + jsonSubMmenu[i].modrep + '</td>'
                    + '<td>' + jsonSubMmenu[i].modreptitle + '</td>'
                    + '<td>' + jsonSubMmenu[i].modname + '</td>'
                    + '<td>' + jsonSubMmenu[i].servlet_url + '</td>'
                    + '<td style="text-align:center;">' + visible + '</td>'
                    + '<td style="text-align:center;"><a class="btn btn-flat btn-warning btn-xs" onclick="editSubMenuHandler(\''+i +'\')"><i class="fa fa-pencil" aria-hidden="true"></i></a> </td>'
                    + '</tr>';
                    tableBody.append(parsedData);
                }
             }
        });
        
        //Show no. of entries===========================
        $('#tableEntrySize').change(function (event) {
             getSubMenu($('#tableEntrySize').val());
        });
        

        //For view Sub Menu===========================
        function  getSubMenu(tableRowSize){
            
            Pace.track(function(){
                $.ajax({
                    url: "subMenu?action=viewSubMenu",
                    type: 'POST',
                    success: function (result) {
                        $('#tableContent').slideDown("slow");
                        //Load  menu drop down initially 
                        var returnedData=JSON.parse(result).menu;
                        menu=JSON.parse(result).menu;
                         var selectTag = $('#menu');
                         selectTag.find('option').remove();
                         $('<option>').val("").text('- Select Menu -').appendTo(selectTag);

                         for (var i = 0; i < returnedData.length; i++) {
                             var id = returnedData[i].modcode;
                             var name = returnedData[i].modname;
                             $('<option>').val(id).text(name).appendTo(selectTag);
                         }

                         var json = JSON.parse(result).subMenu;
                         jsonSubMmenu = JSON.parse(result).subMenu;

                        var tableBody = $('#tableBody');
                        tableBody.empty();
                        
                        var loopSize= json.length;
                        if(tableRowSize>0){
                            loopSize=tableRowSize;
                        }
                        
                        

                        for (var i = 0; i < loopSize; i++) {
                            //Make visibility
                            var visible="<span class='label label-flat label-success label-xs'><i class='fa fa-eye' aria-hidden='true'></i></span>";
                            if(json[i].visible===0){
                                visible="<span class='label label-flat label-danger label-xs'><i class='fa fa-eye-slash' aria-hidden='true'></i></span>";
                            }

                            var parsedData = '<tr><td>' + (i + 1) + '</td>'
                            + '<td>' + json[i].modrep + '</td>'
                            + '<td>' + json[i].modreptitle + '</td>'
                            + '<td>' + json[i].modname + '</td>'
                            + '<td style="text-align:left;">/' + json[i].servlet_url + '</td>'
                            + '<td style="text-align:center;">' + visible + '</td>'
                            + '<td style="text-align:center;"><a class="btn btn-flat btn-warning btn-xs" onclick="editSubMenuHandler(\''+i +'\')"><i class="fa fa-pencil" aria-hidden="true"></i></a> </td>'
                            + '</tr>';
                            tableBody.append(parsedData);
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                    }
                }); //End Ajax
            }); //pace loading end
        } // end getSubMenu end
        
        //Add Sub Menu===============================
        $('#create').click(function () {
           validationMsg.html(""); 
            var menu = $("select#menu").val();
            var subMenu = $("#subMenu").val();
            var url = $("#servlet_url").val();
            var visible = isVisible;



            //validation
            if(menu===""){
                validationMsg.html("Select menu");
                
            }else if(subMenu===""){
                validationMsg.html("Title required");
                
            }else if(url===""){
                validationMsg.html("Url required");
                
            }else{

                var btn = $(this).button('loading');
                
                //Existance checking
                $.ajax({
                    url: "subMenu?action=checkSubMenu",
                    data: {
                        subMenu: subMenu
                    },
                    type: 'POST',
                    success: function (result) {
                       json = JSON.parse(result);
                       
                       if(json[0].count>0){
                           
                           btn.button('reset');
                           $("#subMenu").focus();
                           validationMsg.html("Sub-Menu title Already Exist");      
                       }else{
                           
                           //Data insert part
                            $.ajax({
                                url: "subMenu?action=addSubMenu",
                                data: {
                                    menu: menu,
                                    subMenu: subMenu,
                                    url: url,
                                    visible: visible
                                    
                                },
                                type: 'POST',
                                success: function (result) {
                                    btn.button('reset');
                                    $('#addSubMenu').modal('hide');

                                        getSubMenu(0);
                                        toastr["success"]("<h4><b>Sub-Menu Successfully Added!</b></h4>");
                                        $("select#menu").prop("selectedIndex", 0);
                                        $("#subMenu").val("");
                                        $("#servlet_url").val("");
                                        validationMsg.html("");

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
        }); //End Add sub Menu part
        
        //-----------------------------------------------------------------------------------Edit User--------------------------------------------------------------------------------- 
        $('#btnConfirmToEdit').click(function () {
            var id = $("#editSubMenuId").val();
            var menu = $("select#editMenu").val();
            var subMenu = $("#editSubMenuTitle").val();
            var url = $("#editServlet_url").val();
            //kkkkk
            
            if(subMenu===""){
                validationMsgForEdit.html("Sub-Menu title Required"); 
            }else if(url===""){
                validationMsgForEdit.html("Url Required");
            }else{
                var btn = $(this).button('loading');
                
                $.ajax({
                    url: "subMenu?action=editSubMenu",
                    data: {
                        id: id,
                        menu: menu,
                        subMenu: subMenu,
                        url: url,
                        visible: isVisible
                    },
                    type: 'POST',
                    success: function (result) {
                        btn.button('reset');
                        $('#editSubMenu').modal('hide');

                        getSubMenu(0);
                        toastr["success"]("<h4><b>Sub-Menu Update Successfully!</b></h4>");
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        btn.button('reset');
                        toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                    }
                });
                
            }


        }); //End Create user part
        
    });
    
    //---------------------------------------------------------------------------------------Edit Sub Menu------------------------------------------------------------------------
    function  editSubMenuHandler(index){
        $('#editSubMenu').modal('show');
        
        $('#editSubMenuTitle').val(jsonSubMmenu[index].modreptitle);
        $('#editServlet_url').val(jsonSubMmenu[index].servlet_url);
        $('#editSubMenuId').val(jsonSubMmenu[index].modrep);
        
        //load Menu
        var selectTagMenu = $('#editMenu');
        selectTagMenu.find('option').remove();
        for (var i = 0; i < menu.length; i++) {
            var id = menu[i].modcode;
            var name = menu[i].modname;

            if(menu[i].modname===jsonSubMmenu[index].modname){
                 $('<option selected>').val(id).text(name).appendTo(selectTagMenu);
            }else{
                 $('<option>').val(id).text(name).appendTo(selectTagMenu);
            }
        }
        
        if(jsonSubMmenu[index].visible===1){
            $("#editVisible").prop( "checked", true );
        }else if(jsonSubMmenu[index].visible===0){
           $("#editVisible").prop( "checked", false );
        }
    }

        
    function setVisibility(checkbox){
        if(checkbox.checked){
            isVisible="1";
        }else{
            isVisible="0";
        }
    }
    
</script>


<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Web access control
    <small>Sub Menu</small>
  </h1>
  <ol class="breadcrumb">
    <a class="btn btn-flat btn-primary btn-sm" href="loginUser"><b>User</b></a>
    <a class="btn btn-flat btn-primary btn-sm" href="menu"><b>Menu</b></a>
    <a class="btn btn-flat btn-info btn-sm" href="subMenu"><b>Sub-Menu</b></a>
    <a class="btn btn-flat btn-primary btn-sm" href="role"><b>Role</b></a>
    <a class="btn btn-flat btn-primary btn-sm" href="userRole"><b>User Role</b></a> 
    <a class="btn btn-flat btn-primary btn-sm" href="roleAccess"><b>Role Access</b></a>
  </ol>
</section>
    
<!-- Main content -->
<section class="content">
  <div class="row" id="tableContent">
    <div class="col-xs-12">
        <div class="box box-primary">

            <!--  Table top -->
            <div class="box-header">
                <h3 class="box-title"> 
                    <button type="button" id=""  class="btn btn-flat btn-primary"  data-toggle="modal" data-target="#addSubMenu">
                        <i class="fa fa-th" aria-hidden="true"></i> <b>&nbsp;Add Sub-Menu</b>
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
                </select> entries 
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
                            <th>Code</th>
                            <th onclick="short(2);">Name <span class="pull-right"><i class="fa fa-long-arrow-down" aria-hidden="true"></i></span></th>
                            <th>Menu</th>
                            <th>URL</th>
                            <th>Visibility</th>
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
     
          
<!-------------------------------------------------------------------------------- Add sub menu Modal -------------------------------------------------------------------------------->  
    <div id="addSubMenu" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header label-primary">
              <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
            <h4 class="modal-title"><b><i class="fa fa-th" aria-hidden="true"></i><span>    &nbsp; Add Sub-Menu</span></b></h4>
          </div>

          <div class="modal-body">
              
                <div class="form-group">
                    <label id='menuLb'>Menu <span class="star">*</span></label>
                    <select class="form-control input-sm" name="menu" id="menu">
                        <option value="0">- Select Menu -</option>
                    </select>
                </div>
              
                <div class="form-group">
                    <label>Title <span class="star">*</span></label>
                    <input class="form-control" placeholder="Title" id='subMenu'>
                </div>
              
                <div class="form-group">
                    <label>Url <span class="star">*</span></label>
                    <input class="form-control" placeholder="Url" id='servlet_url'>
                </div>
              
                <div class="material-switch pull-left">
                    <b>Visibility &nbsp;&nbsp;</b><input id="someSwitchOptionPrimary" onchange="setVisibility(this)" name="someSwitchOption001" type="checkbox" checked=""/>
                    <label for="someSwitchOptionPrimary" class="label-primary"></label>
                </div><br>
              
<!--                <div class="checkbox">
                  <label><input type="checkbox" value="">Option 1</label>
                </div>-->
              
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


<!-------------------------------------------------------------------------------- edit sub menu Modal -------------------------------------------------------------------------------->  
    <div id="editSubMenu" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header label-warning">
              <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
            <h4 class="modal-title"><b><i class="fa fa-pencil-square-o" aria-hidden="true"></i><span>&nbsp; Update Sub-Menu</span></b></h4>
          </div>

          <div class="modal-body">
                <div class="form-group">
                    <label id='menuLb'>Menu</label>
                    <select class="form-control input-sm" name="menu" id="editMenu">
                        <option value="0">- Select Menu -</option>
                    </select>
                </div>
              
                <div class="form-group">
                    <label>Title</label>
                    <input class="form-control" placeholder="Title" id="editSubMenuTitle">
                </div>
              
                <div class="form-group">
                    <label>Url</label>
                    <input class="form-control" placeholder="Url" id='editServlet_url'>
                </div>
              
                <div class="material-switch pull-left">
                    <b>Visibility &nbsp;&nbsp;</b><input id="editVisible" onchange="setVisibility(this)" name="editVisible" type="checkbox" />
                    <label for="editVisible" class="label-warning"></label>
                </div><br><br>
                
                <h4><b id="msgEdit" style="color:red;"></b></h4>
                
                <input type="hidden" id="editSubMenuId">
                <div class="form-group">
                    <button type="button" id="btnConfirmToEdit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Updating" class="btn btn-flat btn-warning">Update</button>
                </div>
          </div>

          <div class="modal-footer">
            <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>

      </div>
</div>


<!-------------------------------------------------------------------------------- View sub menu Modal -------------------------------------------------------------------------------->  
    <div id="viewUser" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h2 class="modal-title"><label>Update User</label></h2>
          </div>

          <div class="modal-body">
                <div class="form-group">
                    <label>Name: </label><b id="viewName"></b>
                </div>
                <div class="form-group">
                    <label>Status: </label><b id="viewStatus"></b>
                </div>
                <div class="form-group">
                    <label>Level: </label><b id="viewLevel"></b>
                </div>
          </div>

          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>

      </div>
</div>

<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
