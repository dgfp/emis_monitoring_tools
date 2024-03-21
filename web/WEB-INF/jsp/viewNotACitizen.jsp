<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/functions.js" type="text/javascript"></script>
<style>
            #loading {
        position: absolute;
        top: 0;
        left: 0;
        width: 90%;
        height: 465%;
        margin-left: 251px;
        margin-top: 50px;
        z-index: 1000;
        background-color: #FFFFFF;
        opacity: .8;
    }

    .ajax-loader {
        position: absolute;
        left: 50%;
        top: 46%;
        margin-left: -110px; 
        margin-top: -1200px; 
        display: block;
    }

</style>
<script>
    
                
    $(document).ready(function () {
        setTimeout(callMissing, 500);
    });
        
    //Alert Auto close function
    var callMissing = function(){
        
        Pace.track(function(){
            $.ajax({
                url: "viewNidMissing",
                type: 'POST',
                success: function (result) {

                    var json = JSON.parse(result);

                    //Get Table
                    var tableBody = $('#tableBody');
                    tableBody.empty();

                    for (var i = 0; i < json.length; i++) {

                        if(json[i].father==='null'){
                            json[i].father="";
                        }

                        var parsedData = "<tr><td>" + (i + 1) + "</td>"
                        + "<td style='text-align:right;'>" + json[i].hhno + "</td>"
                        + "<td>" + json[i].nameeng + "</td>"
                        + "<td>" + json[i].father + "</td>"
                        + "<td>" + json[i].dob + "</td>"
                        + "<td>" + json[i].sex + "</td>"
                        + "<td>" + json[i].maritalstatus + "</td>"
                        + "</tr>";
                        tableBody.append(parsedData);
                    }

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    btn.button('reset');
                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                }
            });//End Ajax request
        }); //end Pace loading
        
   };
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>Possession of National Identity Card - Not a Citizen<small></small></h1>
</section>

<!-- Main content -->
<section class="content">
    <!--NID Data Table-->
    <div class="box box-primary">
            <div class="box-header with-border">
                <h3 class="box-title"><b><span id="prsTypeTitleForTable"></span></b></h3>
                <div class="box-tools pull-right" style="margin-top: 0px;">
                    <button type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print</button>
                    <button type="button" class="btn btn-box-tool"><i class="fa fa-file-pdf-o" aria-hidden="true"></i>&nbsp;PDF</button>
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                </div>
            </div>
        <div class="box-body">
                <!--Data Table-->               
                <div class="col-ld-12" id="">
                    <div class="table-responsive" >
                        <table class="table table-bordered table-striped" id="data-table">
                        <thead id="tableHeader" class="data-table">
                            <tr>
                                <th>#</th>
                                <th style="text-align: right">Household No</th>
                                <th>Name</th>
                                <th>Father</th>
                                <th>Date of Birth</th>
                                <th>Sex</th>
                                <th>Marital Status</th>
                            </tr>
                        </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter" class="data-table">
                            </tfoot>
                        </table>
                        
                    </div>
                </div>
        </div>
    </div>
</section>

<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
