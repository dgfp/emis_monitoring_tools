<%-- 
    Document   : menu
    Created on : Feb 26, 2017, 2:23:05 PM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<!--<script src="resources/js/userManagementArea.js" type="text/javascript"></script>-->
<style>
    #tableContent { display: none; }
    #data-table{
    font-size: 15px;
}
</style>
<script>
    
    var jsonMenu=null;
    $(document).ready(function () {
        var validationMsg=$('#msg');
        //View menu table initially - 0 mean all record
        getMenu(0);
        
        //Search User===========================
        $('#search').keyup(function(){
            var searchField = $('#search').val();
            var regex = new RegExp(searchField, "i");
            var tableBody = $('#tableBody');
            tableBody.empty();
            //reset dropdown
            $('#tableEntrySize').get(0).selectedIndex = 0;
            for (var i = 0; i < jsonMenu.length; i++) {
                      if ((jsonMenu[i].modname.search(regex) !== -1)) {
                        var parsedData = '<tr><td>' + (i + 1) + '</td>'
                        + '<td>' + jsonMenu[i].modname + '</td>'
//                        + '<td>' + jsonMenu[i].subMenuCount + '</td>'
                        + '<td style="text-align:center;"><i class="' + jsonMenu[i].icon + '" aria-hidden="true"></i></td>'
                        + '<td style="text-align:center;"><a class="btn btn-flat btn-warning btn-xs" onclick="editMenuHandler(\''+i +'\')"><i class="fa fa-pencil" aria-hidden="true"></i></a> </td>'
                        + '</tr>';
                        tableBody.append(parsedData);
                      }
             }
        });
        
        //Show no. of entries===========================
        $('#tableEntrySize').change(function (event) {
             getMenu($('#tableEntrySize').val());
        });
        
        
        //For view Menu===========================
        function  getMenu(tableRowSize){
            
            Pace.track(function(){
                $.ajax({
                    url: "menu?action=viewMenu",
                    type: 'POST',
                    success: function (result) {
                        $('#tableContent').slideDown("slow");
                         //View All user information
                         //json = JSON.parse(result);
                        var json = JSON.parse(result);
                        jsonMenu=JSON.parse(result);
                        var tableBody = $('#tableBody');
                        tableBody.empty();
                        
                        var loopSize= json.length;
                        if(tableRowSize>0){
                            loopSize=tableRowSize;
                        }
                        
                        for (var i = 0; i < loopSize; i++) {

                                var parsedData = '<tr><td>' + (i + 1) + '</td>'
                                + '<td>' + json[i].modname + '</td>'
//                                + '<td>' + json[i].subMenuCount + '</td>'
                                + '<td style="text-align:center;"><i class="' + json[i].icon + '" aria-hidden="true"></i></td>'
                                + '<td style="text-align:center;"><a class="btn btn-flat btn-warning btn-xs" onclick="editMenuHandler(\''+i +'\')"><i class="fa fa-pencil" aria-hidden="true"></i></a></td>'
                                + '</tr>';
                                tableBody.append(parsedData);
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                    }
                }); //Ajax end
            }); // Pace End
        } //End View menus
        
        
        //For Add Menu===============================
        $('#create').click(function () {

            var modName = $("#modName").val();
            var icon = $("#icon").val();


            //validation
            if(modName===""){
                validationMsg.html("Menu title required");
                
            }else if(icon===""){
                validationMsg.html("Icon required");
                
            }else{

                var btn = $(this).button('loading');

                //Existance checking part
                $.ajax({
                    url: "menu?action=checkModName",
                    data: {
                        modName: modName
                    },
                    type: 'POST',
                    success: function (result) {
                       json = JSON.parse(result);
                       
                       if(json[0].count>0){
                           
                           btn.button('reset');
                           $("#modName").focus();
                           validationMsg.html("Menu title already exist");      
                       }else{
                           
                           //Data insert part
                            $.ajax({
                                url: "menu?action=addMenu",
                                data: {
                                    modName: modName,
                                    icon: icon
                                },
                                type: 'POST',
                                success: function (result) {
                                    btn.button('reset');
                                    $('#addMenu').modal('hide');

                                        getMenu(0);
                                        toastr["success"]("<h4><b>Menu Successfully Added!</b></h4>");
                                        $('#modName').val("");
                                        $('#icon').val("");
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
        }); //End Add Menu part
        
        //For Edit Menu===========================
        $('#btnConfirmToEdit').click(function () {

            var btn = $(this).button('loading');
            $.ajax({
                url: "menu?action=editMenu",
                data: {
                    editMenuTitle: $("#editMenuTitle").val(),
                    editMenuIcon: $("#editMenuIcon").val(),
                    editMenuId: $("#editMenuId").val()
                },
                type: 'POST',
                success: function (result) {
                    btn.button('reset');
                    $('#editMenu').modal('hide');

                    getMenu(0);
                    toastr["success"]("<h4><b>Menu Update Successfully!</b></h4>");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    btn.button('reset');
                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                }
            });

        }); //End Create user part
        
    });
    
    //---------------------------------------------------------------------------------------Edit Emnu ------------------------------------------------------------------------
    function  editMenuHandler(index){
        $('#editMenu').modal('show');
        $('#editMenuTitle').val(jsonMenu[index].modname);
        $('#editMenuIcon').val(jsonMenu[index].icon);
        $('#editMenuId').val(jsonMenu[index].modcode);
    }
</script>

<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Web access control
    <small>Menu</small>
  </h1>
  <ol class="breadcrumb">
    <a class="btn btn-flat btn-primary btn-sm" href="loginUser"><b>User</b></a>
    <a class="btn btn-flat btn-info btn-sm" href="menu"><b>Menu</b></a>
    <a class="btn btn-flat btn-primary btn-sm" href="subMenu"><b>Sub-Menu</b></a>
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
                    <button type="button" id=""  class="btn btn-flat  btn-primary"  data-toggle="modal" data-target="#addMenu">
                        <i class="fa fa-th-large" aria-hidden="true"></i> <b>&nbsp;Add Menu</b>
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
                            <th onclick="short(1);">Menu <span class="pull-right"><i class="fa fa-long-arrow-down" aria-hidden="true"></i></span></th>
<!--                            <th>No of Sub-Menu</th>-->
                            <th style="text-align:center;">Icon</th>
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

          
<!-------------------------------------------------------------------------------- Add Menu Modal -------------------------------------------------------------------------------->  
    <div id="addMenu" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header label-primary">
              <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
            <h4 class="modal-title"><b><i class="fa fa-th-large" aria-hidden="true"></i><span>    &nbsp; Add Menu</span></b></h4>
          </div>

          <div class="modal-body">
                <div class="form-group">
                    <label>Title <span class="star">*</span></label>
                    <input class="form-control" placeholder="Title" id='modName'>
                </div>
              
                <div class="form-group">
                    <label>Icon <span class="star">*</span></label>
                    <input class="form-control" placeholder="Example: fa fa-user-circle-o" id='icon'>
                    <label><b>Icon link: </b><small><i>&nbsp;http://fontawesome.io/icons</i></small>&nbsp;&nbsp;<a href="http://fontawesome.io/icons/" target="_blank">Go</a></label>
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


<!-------------------------------------------------------------------------------- edit Menu Modal -------------------------------------------------------------------------------->  
    <div id="editMenu" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header label-warning">
              <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
            <h4 class="modal-title"><b><i class="fa fa-pencil-square-o" aria-hidden="true"></i><span>    &nbsp; Update Menu</span></b></h4>
          </div>

          <div class="modal-body">
                <div class="form-group">
                    <label>Menu Title</label>
                    <input class="form-control" id='editMenuTitle'>
                </div>
                <div class="form-group">
                    <label>Icon</label>
                    <input class="form-control" id='editMenuIcon'>
                </div>
              <input type="hidden" id="editMenuId">

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
 

<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>