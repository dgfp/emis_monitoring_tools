<%-- 
    Document   : PregnantWoman
    Created on : Dec 2, 2018, 3:27:18 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/area_dropdown_control_by_user.js"></script>
<style>
</style>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>Pregnant woman</h1>
    <ol class="breadcrumb" id="communityStatisticsAccessHF">
        <a class="btn btn-flat btn-info btn-sm" href="pregnant"><i class="fa fa-users" aria-hidden="true"></i> <b>&nbsp;Family Planning</b></a>
        <a class="btn btn-flat btn-primary btn-sm" href="pregnantHA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-heartbeat" aria-hidden="true"></i> <b>&nbsp;Health&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></a>
    </ol>
</section>
<!-- Main content -->
<section class="content">
    <%@include file="/WEB-INF/jsp/layouts/communityArea.jsp" %>
    <!--Pregnant Data Table-->
    <div class="box box-primary"  id="tableView">
        <div class="box-header with-border" style="margin-top: -8px;margin-bottom: -5px!important;">
            <div class="box-tools pull-right" style="margin-top: 0px;">
                <button id="printTableBtn" type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <a href="#" id ="exportCSV" role='button' class="btn btn-box-tool"><i class="fa fa-file-excel-o" aria-hidden="true"></i>&nbsp;CSV</a>
                <a href="#" id ="exportText" role='button' class="btn btn-box-tool"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Text</a>
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
            </div>
        </div>

        <div class="box-body">
            <div class="table-responsive" >
                <table id="data-table" class="table table-bordered table-striped table-hover">
                    <thead id="tableHeader" class="data-table">
                    </thead>
                    <tbody id="tableBody">
                    </tbody>
                    <tfoot id="tableFooter">
                    </tfoot>
                </table>
            </div>
        </div>
        <!--For Print -->
        <div class="box-body"  id="printTable">
            <div id="dvData">
                <table class="table table-bordered table-striped table-hover" align="center">
                    <thead id="tableHeaderP">
                    </thead>
                    <tbody id="tableBodyP">
                    </tbody>
                    <tfoot id="tableFooterP">
                    </tfoot>
                </table>
            </div>
        </div>          
    </div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script>
    $(function () {
        $.pregnantWoman = $.pregnantWoman || {
            sampleVariable: null,
            init: function () {
                if($('#userCategory').val()=='1' || $('#userCategory').val()=='2')
                    $("#communityStatisticsAccessHF").css("display", "none");
                $( "#areaDropDownPanel" ).after($.app.getWatermark());
                $.app.areaSlideDown();
                $.pregnantWoman.events.bindEvent();
            },
            clear:function (){
//                $('#data-table').DataTable().destroy();
//                $('#tableBody').empty();
//                $("#reloadData").show();
//                $("#viewUserDetails").show();
//                $.app.removeWatermark();
            },
            events: {
                bindEvent: function () {
                    $.pregnantWoman.events.viewData();
                },
                viewData: function () {
                    $(document).off('click', '#showdataButton').on('click', '#showdataButton', function (e) {
                        toastr['warning']("Under development");
                        $.pregnantWoman.clear();
                        $.pregnantWoman.ajax.userLogLoaderByUser();
                    });
                }
            },
            ajax: {
                userLogLoaderByUser: function () {
                    $.ajax({
                        url: "pregnantWoman?action=getUserLogByUser&userId=",
                        type: "POST",
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response);
                            if (response.success === true) {
//                                $('#data-table').dataTable({
//                                    processing: true,
//                                    data: response.data,
//                                    columns: [
//                                        {data: "user_ip"},
//                                        {data: function (d){
//                                         return $.app.date(d.session_start).datetime;       
//                                        }},
//                                        {data: function (d){
//                                         return $.app.date(d.session_end).datetime;       
//                                        }},
//                                        {data: 'session_duration'},
//                                        {data: function () {
//                                                return '<a class="btn btn-flat btn-primary btn-xs action-view" id="viewDetails"><b> Details</b></a>';
//                                        }}
//                                    ]
//                                });
                            } else {
                                toastr['error']("Error occured while login status load");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                }
            }//ajax end
        };
        $.pregnantWoman.init();
    });
</script>