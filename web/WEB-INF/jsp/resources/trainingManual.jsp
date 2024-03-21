<%-- 
    Document   : trainingManual
    Created on : May 11, 2017, 9:23:33 AM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<style>
    #tableContent { display: none; }
</style>
<script>
    $(document).ready(function () {
        
        var tableBody = $('#tableBody');
        Pace.track(function(){
            $.ajax({
                url: "trainingManual",
                type: 'POST',
                success: function (result) {
                    var json = JSON.parse(result);
                    if (json.length === 0) {
                        $('#noFile').html("No file");
                    }else{
                        $('#tableContent').slideDown("slow");
                        for (var i = 0; i < json.length; i++) {
                            var parsedData = '<tr><td>' + (i + 1) + '</td>'
                                + '<td>' +json[i].title+ '</td>'
                                + '<td style="text-align:center">' +json[i].fileextention.toUpperCase()+ '</td>'
                                + '<td style="text-align:center"><a href="'+json[i].link+'" target="_blank" class="btn btn-flat btn-primary btn-xs"><i class="fa fa-download" aria-hidden="true"></i> Download</a></td>'
                                + '</tr>';
                            tableBody.append(parsedData);
                        }

                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                   toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                }
            });//Ajax end
        }); //Pace Loading end
    });
</script>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>Training Manual<small></small></h1>
    ${sessionScope.role=='Super Admin' ? 
    "<ol class='breadcrumb'>
        <a class='btn btn-flat btn-primary btn-sm' href='#'><b><i class='fa fa-puzzle-piece' aria-hidden='true'></i> Manage Training Manual</b></a>
    </ol>" : ""}
</section>
<!-- Main content -->
<section class="content">
    <div class="row" id="tableContent">
    <div class="col-xs-12">
        <div class="box box-primary">
        <!-- table -->
        <div class="box-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped" id="data-table">
                    <thead class="data-table">
                        <tr>
                            <th>#</th>
                            <th onclick="short(1);" class="clickable">Title<span class="pull-right"><i class="fa fa-long-arrow-down" aria-hidden="true"></i></span></th>
                            <th style="text-align: center">File Type</th>
                            <th style="text-align: center">Action</th>
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
    <h1 style="color:#e4e8ed;font-size: 130px;margin-top: 6%;"><center id="noFile"></center></h1>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>