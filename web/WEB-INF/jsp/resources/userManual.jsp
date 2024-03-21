<%-- 
    Document   : userManual
    Created on : May 9, 2017, 1:56:47 PM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<style>
    #tableContent { display: none; }
    .label {
        border-radius: 11px!important;
    }
</style>
<script>
    $(document).ready(function () {
        var user = $('#userCategory').val();
        var tableBody = $('#tableBody');
        $.ajax({
            url: "userManual?action=viewUserManual",
            type: 'POST',
            success: function (result) {
                var json = JSON.parse(result);
                if (json.length === 0) {
                    $('#noFile').html("No file");
                } else {
                    $('#tableContent').slideDown("slow");
                    var sl = 0, index = 0;

                    console.log(json);
                    for (var i = 0; i < json.length; i++) {

                        if (user === '1' && json[i].manualtype != '2') {
                            index = (i + 1);
                            console.log("Index: " + index);
                            var parsedData = '<tr><td>' + (sl + 1) + '</td>'
                                    + '<td>' + json[i].title + '</td>'
                                    + '<td><span class="label label-flat label-sm label-danger">&nbsp;<i class="fa fa-file-pdf-o" aria-hidden="true"></i>&nbsp;&nbsp; ' + json[i].fileextention.toUpperCase() + '&nbsp;</span></td>'
                                    + '<td><a href="' + json[i].link + '"  class="btn btn-flat btn-primary btn-xs"><b><i class="fa fa-download" aria-hidden="true"></i> Download</b></a></td>'
                                    + '</tr>';
                            tableBody.append(parsedData);
                            sl++;

                        } else if (user === '2' && json[i].manualtype != '1') {
                            index = (i + 1);
                            console.log("Index: " + index);
                            var parsedData = '<tr><td>' + (sl + 1) + '</td>'
                                    + '<td>' + json[i].title + '</td>'
                                    + '<td><span class="label label-flat label-sm label-danger">&nbsp;<i class="fa fa-file-pdf-o" aria-hidden="true"></i>&nbsp;&nbsp; ' + json[i].fileextention.toUpperCase() + '&nbsp;</span></td>'
                                    + '<td><a href="' + json[i].link + '"  class="btn btn-flat btn-primary btn-xs"><b><i class="fa fa-download" aria-hidden="true"></i> Download</b></a></td>'
                                    + '</tr>';
                            tableBody.append(parsedData);
                            sl++;

                        } else if (user === '3') {
                            var parsedData = '<tr><td>' + (i + 1) + '</td>'
                                    + '<td>' + json[i].title + '</td>'
                                    + '<td class="center"><span class="label label-flat label-sm label-danger">&nbsp;<i class="fa fa-file-pdf-o" aria-hidden="true"></i>&nbsp;&nbsp; ' + json[i].fileextention.toUpperCase() + '&nbsp;</span></td>'
                                    + '<td class="center"><a href="' + json[i].link + '"  class="btn btn-flat btn-primary btn-xs"><b><i class="fa fa-download" aria-hidden="true"></i> Download</b></a></td>'
                                    + '</tr>';
                            tableBody.append(parsedData);
                        }
                        tableBody.fadeIn();
                    }

                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                toastr["error"]("<h4><b>Request can't be processed</b></h4>");
            }
        });//Ajax end
    });
</script>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>User Manual<small></small></h1>
    ${sessionScope.role=='Super Admin' ? 
      "<ol class='breadcrumb'>
      <a class='btn btn-flat btn-primary btn-sm' href='#'><b><i class='fa fa-puzzle-piece' aria-hidden='true'></i> Manage User Manual</b></a>
      </ol>" : ""}
</section>

<!-- Main content -->
<section class="content">
    <div class="row" id="tableContent">
        <div class="col-xs-12">
            <div class="box box-primary full-screen">
                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover dataTable no-footer" id="data-table">
                            <thead>
                                <tr>
                                    <th>SLNo</th>
                                    <th>Title<span class="pull-right"></span></th>
                                    <th class="center">File Type</th>
                                    <th class="center">Action</th>
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
    <h1 style="color:#c9c9c9;font-size: 130px;margin-top: 6%;"><center id="noFile"></center></h1>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>