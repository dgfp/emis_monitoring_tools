<%-- 
    Document   : AssetReports
    Created on : Sep 28, 2020, 1:17:05 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/AssetManagement.js" type="text/javascript"></script>
<link href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css"/>
<style>
    .box-header>.fa, .box-header>.glyphicon, .box-header>.ion, .box-header .box-title {
        font-size: 13px;
    }
    ol, ul {
        margin-left: -22px;
        margin-top: -4px;
    }
    .status-row > .col-md-2{
        padding-left: 3px;
        padding-right: 1px;
    }
    li a {
        position: relative;
        left: -5px;
    }
    .box{
        margin-bottom: 10px;
    }
</style>
<style>
    .status-box {
        position: relative;
        border-radius: 3px;
        background: #ffffff;
        border-top: 3px solid #d2d6de;
        margin-bottom: 15px;
        width: 100%;
        box-shadow: 0 1px 1px rgba(0,0,0,0.1);
    }
    .status-box-body {
        border-top-left-radius: 0;
        border-top-right-radius: 0;
        border-bottom-right-radius: 3px;
        border-bottom-left-radius: 3px;
        /*        padding: 10px;*/
        padding-top: 10px;
        padding-right: 10px;
        padding-bottom: 2px!important;
        padding-left: 10px;
    }
    .status-box.box-success {
        border-top-color: #00a65a;
    }
    .status-box.box-primary {
        border-top-color: #3c8dbc;
    }
    .status-box.box-info {
        border-top-color: #00c0ef;
    }
    .status-box.box-warning {
        border-top-color: #f39c12;
    }
    .status-box.box-danger {
        border-top-color: #dd4b39;
    }
    .status-box-body> .box-title{
        font-size: 15px;
    }
    .box-title{
        padding: 2px 0px;
        border-radius: 5px;
        text-align: center;
        margin-top: -4px;
        color: #000;
    }
    .box-title-success{
        background-color: #6df9b3;
    }
    .box-title-primary{
        background-color: #93d9ff;
    }
    .box-title-info{
        background-color: #aff0ff;
    }
    .box-title-warning{
        background-color: #ffd9a5;
    }
    .box-title-danger{
        background-color: #ffa59b;
    }
</style>

<style>
    .mis-template .table-responsive {
        border: 1px solid #6aa9f2;
    }
    .mis-template table.table-bordered{
        border:1px solid #000!important;
    }
    .mis-template table.table-bordered > thead > tr > th{
        border:1px solid #000!important;
    }
    .mis-template table.table-bordered > tbody > tr > td{
        border:1px solid #000!important;
    }
    table.table-bordered.dataTable {
        border-collapse: collapse !important; 
    }

    .small-box h3 {
        font-size: 32px;
        margin: 0 0 -2px 0;
    }
    .small-box p {
        font-size: 15px;
        margin: 0px 0 -9px;
    }

    .small-box .breakdown h3 {
        font-size: 22px;
        margin: 0 0 2px 0;
    }
    .small-box .breakdown p {
        font-size: 13px;
        margin: 0px 0 -2px;
    }
    .inner .row .col-md-6 {
        padding-right: 10px!important;
        padding-left: 10px!important;
    }
    .mb-0{
        margin-bottom: 0px!important;
    }
    .pt-0{
        padding-top: 0px!important;
    }
    .small-box>.inner {
        padding-bottom: 4px!important;
    }
    .breakdown{
        border-radius: 7px;
    }
    .status-title{
        font-size: 18px;
        margin-bottom: 3px;
        font-weight: bold;
    }
    #status-row{
        display: none;
    }
    .input-date, #tableView, .input-year, #chartView{
        display: none;
    }
</style>
<script>
</script>
<section class="content-header">
    <h1 id="pageTitle">Asset Details</h1>
    <ol class="breadcrumb">
        <a class="btn btn-flat btn-default btn-sm" href="asset-dashboard"><b>Dashboard</b></a>
        <a class="btn btn-flat btn-primary btn-sm" href="asset-reports"><b>Details</b></a>
        <a class="btn btn-flat btn-default btn-sm" href="asset-management"><b>Manage</b></a>
    </ol>
</section>
<section class="content">

    <div class="row" id="areaPanel">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-body">
                    <div class="row">

                        <div class="col-md-4 col-xs-8">
                            <div class="form-group">
                                <label for="sel1">Report:</label>
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="report_type" id="report_type">
                                    <option value="1" selected="">Number of tablet by status</option>
                                    <option value="2">Number of tablet by date of purchase</option>
                                    <option value="3">Number of tablet currently more than...</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-2 col-xs-4 input-year">
                            <div class="form-group">
                                <label for="year">Years old:</label>
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="r_year" id="r_year">
                                    <option value="1">1</option>
                                    <option value="2" selected>2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-2 col-xs-4 input-area">
                            <div class="form-group">
                                <label for="sel1">Division:</label>
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="divid" id="divid"> 
                                    <option value="0">All</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-2 col-xs-4 input-area">
                            <div class="form-group">
                                <label for="sel1">District:</label>
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="zillaid" id="zillaid"> 
                                    <option value="0">All</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-2 col-xs-4 input-date">
                            <div class="form-group">
                                <label for="usr">From:</label>
                                <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="startDate" id="startDate" readonly="readonly" style="background-color: rgb(255, 255, 255);">
                            </div>
                        </div>

                        <div class="col-md-2 col-xs-4 input-date">
                            <div class="form-group">
                                <label for="usr">To:</label>
                                <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="endDate" id="endDate" readonly="readonly" style="background-color: rgb(255, 255, 255);">
                            </div>
                        </div>

                        <div class="col-md-2 col-xs-4 btn-chart">
                            <div class="form-group">
                                <label for="usr">&nbsp;</label>
                                <button id="report_chart_view" type="button" id="btn-data" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-success btn-sm btn-block bold" autocomplete="off" >
                                    <i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; Show chart
                                </button>
                            </div>
                        </div>



                        <div class="col-md-2 col-xs-4">
                            <div class="form-group">
                                <label for="usr">&nbsp;</label>
                                <button id="report_view" type="button" id="btn-data" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                    <i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; Show data
                                </button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <center class="status-title" id="title"></center>
    <div class="row status-row" id="status-row">
        <div class="col-md-2 col-md-offset-1 col-xs-12">
            <div class="status-box box-success">
                <div class="status-box-body emis-doc">
                    <a href="#" class="status-details box-title" id="1"><p class="box-title box-title-success">Functional: <b id="functional">0</b></p></a>
                    <ul>
                        <li><a href="#" class="status-details" id="11">User: <b id="functional_user">0</b></a></li>
                        <li><a href="#" class="status-details" id="12">Central store: <b id="functional_central_store">0</b></a></li>
                        <li><a href="#" class="status-details" id="13">Local store: <b id="functional_local_store">0</b></a></li>
                        <li style="color: #fff;"></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-2 col-xs-6">
            <div class="box box-primary">
                <div class="status-box-body emis-doc">
                    <a href="#" class="status-details box-title" id="2"><p class="box-title box-title-primary">Repaired Functional: <b id="repaired_functional">0</b></p></a>
                    <ul>
                        <li><a href="#" class="status-details" id="21">User: <b id="repaired_functional_user">0</b></a></li>
                        <li><a href="#" class="status-details" id="22">Central store: <b id="repaired_functional_central_store">0</b></a></li>
                        <li><a href="#" class="status-details" id="23">Local store: <b id="repaired_functional_local_store">0</b></a></li>
                        <li style="color: #fff;"></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-2 col-xs-6">
            <div class="status-box box-info">
                <div class="status-box-body emis-doc">
                    <a href="#" class="status-details box-title" id="3"><p class="box-title box-title-info">Non-functional: <b id="non_functional">0</b></p></a>
                    <ul>
                        <li><a href="#" class="status-details" id="31">User: <b id="non_functional_user">0</b></a></li>
                        <li><a href="#" class="status-details" id="32">Central store: <b id="non_functional_central_store">0</b></a></li>
                        <li><a href="#" class="status-details" id="33">Local store: <b id="non_functional_local_store">0</b></a></li>
                        <li><a href="#" class="status-details" id="34">Vendor: <b id="non_functional_vendor">0</b></a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-2 col-xs-6">
            <div class="status-box box-warning">
                <div class="status-box-body emis-doc">
                    <a href="#" class="status-details box-title" id="4"><p class="box-title box-title-warning">Damaged: <b id="damaged">0</b></p></a>
                    <ul>
                        <li><a href="#" class="status-details" id="41">User: <b id="damaged_user">0</b></a></li>
                        <li><a href="#" class="status-details" id="42">Central store: <b id="damaged_central_store">0</b></a></li>
                        <li><a href="#" class="status-details" id="43">Local store: <b id="damaged_local_store">0</b></a></li>
                        <li style="color: #fff;"></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-2 col-xs-6">
            <div class="status-box box-danger">
                <div class="status-box-body emis-doc">
                    <a href="#" class="status-details box-title" id="5"><p class="box-title box-title-danger">Lost: <b id="lost">0</b></p></a>
                    <ul>
                        <li><a href="#" class="status-details" id="51">From User: <b id="lost_from_user">0</b></a></li>
                        <li><a href="#" class="status-details" id="52">From Central store: <b id="lost_from_central_store">0</b></a></li>
                        <li><a href="#" class="status-details" id="53">From Local store: <b id="lost_from_local_store">0</b></a></li>
                        <li style="color: #fff;"></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>



    <div class="box box-primary full-screen" id="tableView">
        <div class="box-header with-border" style="padding: 0px;">
            <p class="box-title bold" style="font-size: 15px;padding: 2px;padding-left: 5px;"></p>
            <div class="box-tools pull-right" style="margin-top: -10px;">
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body">
            <center class="status-title" id="table-title"></center>
            <div class="col-md-12 data-view">
                <div class="table-responsive fixed">
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
    <div class="row">
        <div class="col-md-10 col-md-offset-1" id="chartCanvas">
        <div class="box box-primary full-screen" id="chartView">
            <div class="box-header with-border" style="padding: 0px;">
                <p class="box-title bold" style="font-size: 15px;padding: 2px;padding-left: 5px;"></p>
                <div class="box-tools pull-right" style="margin-top: -10px;">
                    <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                </div>
            </div>
            <div class="box-body">
                <!--            <center class="status-title" id="chart-title"></center>-->
                <div class="row">
                    <div class="col-md-10 col-md-offset-1" id="chartCanvas">
                        <div id="chart"></div>
                    </div>
                </div>
            </div> 
        </div>
    </div>
</div>
</section>
<%@include file="/WEB-INF/jspf/asset-details-modal.jspf" %>
<%@include file="/WEB-INF/jspf/asset-history-modal.jspf" %>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script>
    $(function () {
        $.Asset = {
            baseURL: "asset-reports",
            where: "",
            chartId: "chart",
            chartData: [],
            data: null,
            init: function () {
                $.Asset.events.bindEvent();
                $('#report_view').click();
            },
            events: {
                bindEvent: function () {
                    $.Asset.events.showData();
                    $.Asset.events.changeReportType();
                    $.Asset.events.viewStatusDetails();

                    $.Asset.events.viewHistory();
                    $.Asset.events.viewDetails();
                    $.Asset.events.viewChart();
                },
                showData: function () {
                    $(document).off('click', '#report_view').on('click', '#report_view', function (e) {
                        //Reset view
                        $("#status-row, #tableView, #chartView").fadeOut(100);
                        $("#title").html("");
                        $("#table-title").html("");
                        if ($("#report_type").val() == 1) {
                            $.Asset.where = "";
                            $("#divid").val() != 0 ? $.Asset.where += " and divid=" + $("#divid").val() : "";
                            $("#zillaid").val() != 0 ? $.Asset.where += " and zillaid=" + $("#zillaid").val() : "";
                            $.Asset.ajax.showStatus();
                        } else if ($("#report_type").val() == 2) {
                            $("#table-title").html("Number of tablet by date of purchase");
                            var startDate = $("#startDate").val() != "" ? $("#startDate").val() : "01/01/2015";
                            var endDate = $("#endDate").val() != "" ? $("#endDate").val() : $.app.date().date;
                            $.Asset.where = "and m.purchaseddate BETWEEN '" + startDate + "'::date AND '" + endDate + "'::date";
                            $.Asset.ajax.showData('');

                        } else if ($("#report_type").val() == 3) {
                            $("#table-title").html("Number of tablet currently more than " + $('#r_year').val() + " years old");
                            $.Asset.where = "  and (select (date_part('year',age(now()::date, receiveddate::date))::int) duration from web_asset_distribution_history where imei1=m.imei1 order by receiveddate limit 1) = " + $("#r_year").val();
                            $("#divid").val() != 0 ? $.Asset.where += " and divid=" + $("#divid").val() : "";
                            $("#zillaid").val() != 0 ? $.Asset.where += " and zillaid=" + $("#zillaid").val() : "";
                            $.Asset.ajax.showData('');
                        }
                    });
                },
                changeReportType: function () {
                    $(document).off('change', '#report_type').on('change', '#report_type', function (e) {
                        if (this.value == 1) {
                            $(".input-area, .btn-chart").css('display', 'block');
                            $(".input-date, .input-year").css('display', 'none');
                        } else if (this.value == 2) {
                            $(".input-date").css('display', 'block');
                            $(".input-area, .input-year, .btn-chart").css('display', 'none');
                        } else if (this.value == 3) {
                            $(".input-area, .input-year").css('display', 'block');
                            $(".input-date, .btn-chart").css('display', 'none');
                        }
                    });
                },
                viewStatusDetails: function () {
                    $(document).off('click', '.status-details').on('click', '.status-details', function (e) {
                        $.Asset.ajax.showData($.Asset.statusDetailsQuery[$(this).attr('id')][0]);

                        $("#table-title").html($.Asset.statusDetailsQuery[$(this).attr('id')][1]);
                        console.log($.Asset.statusDetailsQuery[$(this).attr('id')]);
                    });
                },
                viewChart: function () {
                    $(document).off('click', '#report_chart_view').on('click', '#report_chart_view', function (e) {
                        console.log($.Asset.data);
                        $("#tableView").fadeOut('100');
                        var d = $.Asset.data;
                        //$("#chart-title").html('Number of tablet by  status (Total: <b id="total_asset">' + d.total_asset + '</b>)');
                        //$.Asset.chartId.html("");
                        $.Asset.chartData = [];

                        $.Asset.chartData.push({
                            area: 'Functional',
                            functional: d.functional
                        });
                        $.Asset.chartData.push({
                            area: 'Repaired Functional:',
                            repaired_functional: d.repaired_functional
                        });
                        $.Asset.chartData.push({
                            area: 'Non-Functional',
                            non_functional: d.non_functional
                        });
                        $.Asset.chartData.push({
                            area: 'Damaged',
                            damaged: d.damaged
                        });
                        $.Asset.chartData.push({
                            area: 'Lost',
                            lost: d.lost
                        });
                        $.chart.renderAssetBarChart($.Asset.chartId, $.Asset.chartData, $.Asset.chartLabel['assetBar'], $.Asset.chartColor['assetBar'], -0);
                        //$.chart.renderAssetBarChart(chart div id, data, level, color);
                        $("#chartView").fadeIn();

                    });
                },
                viewHistory: function () {
                    $(document).off('click', '.asset-history').on('click', '.asset-history', function (e) {
                        $.AssetManagement.ajax.getAssetHistory($(this).data("info"));
                        console.log($(this).data("info"));
                    });
                },
                viewDetails: function () {
                    $(document).off('click', '.asset-view').on('click', '.asset-view', function (e) {
                        $.AssetManagement.ajax.getAssetDetails($(this).data("info"));
                    });
                },
            },
            ajax: {
                showStatus: function () {
                    $.ajax({
                        url: $.Asset.baseURL + "?action=getStatus",
                        type: "POST",
                        data: {where: $.Asset.where},
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response);
                            if (response.success == true) {
                                $.Asset.data = response.data[0];
                                $("#title").html('Number of tablet by  status (Total: <b id="total_asset">0</b>)');
                                $.each(response.data[0], function (i, o) {
                                    $("#" + i).text(o);
                                });
                                //Number of tablet by  status (out of <b id="total_asset">0</b>)
                                $("#status-row").fadeIn();
                                //console.log(response);
                            } else {
                                toastr['error']("Error occured while data loading");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });

                },
                showData: function (where) {
                    $("#chartView").fadeOut('100');
                    where += $.Asset.where;
                    $.ajax({
                        url: "asset-management?action=showData",
                        type: "POST",
                        data: {where: where},
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success == true) {
                                $("#tableView").fadeIn();
                                $.Asset.renderTable(response);
                            } else {
                                toastr['error']("Error occured while data loading");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });

                },
            },
            renderTable: function (response) {
                console.log(response);
                var exportTitle = "Asset Data";
                var columns = [
                    {
                        data: "imei1",
                        render: function (d, t, r, m) {
                            return m.row + 1;
                        }, title: '#'
                    },
                    {data: "imei1", title: 'IMEI'},
                    {data: function (d) {
                            return d.modelname;
                        }, title: 'Tab Model'},
                    {data: function (d) {
                            var user = "-";
                            if (d.provname != "null") {
                                user = '<span class="bold">' + d.provname + "</span> - " + (d.designation != "null" ? d.designation : d.typename);
                            }
                            return user;
                        }, title: "Current User"},
//                    {data: function (d) {
//                            return "<b>" + d.statusname + " - " + d.locationname + "</b>";
//                        }, title: "Status"},

//                    {data: function (d) {
//                            return $.app.date(d.received_date).date;
//                        }, title: 'Issue date'},
                    {data: function (d) {
                            return d.active != "null" ? "<b>" + d.tab_duration.replace(/-/g, " ") + "</b>" : "-";
                        }, title: 'Duration'},
                    {data: function (d) {
                            var json = JSON.stringify({"imei1": d.imei1, "providerid": d.providerid, "zillaid": d.zillaid});
                            var btn = "<a class='btn btn-flat btn-primary btn-xs asset-view' id='" + d.imei1 + "' data-info='" + json + "'><b>Details</b></a>&nbsp;";
                            btn += "<a class='btn btn-flat btn-info btn-xs asset-history' id='" + d.imei1 + "' data-info='" + json + "'><b>History</b></a>&nbsp;";
                            return btn;
                        }, title: "Action"}
                ]
                var options = {
                    lengthMenu: [
                        [10, 25, 50, 100, -1],
                        ['10', '25', '50', '100', 'All']
                    ],
                    dom: 'Bfrtip',
                    buttons: [
                        {
                            extend: 'print',
                            text: ' <i class="fa fa-print" aria-hidden="true"></i> Print / PDF',
                            title: '<center class="dt-title">' + exportTitle + '</center>',
                            filename: 'pdf_distributed_asset_info',
                            exportOptions: {columns: [0, 1, 2, 3, 4]}
                        },
                        {
                            extend: 'excelHtml5',
                            text: '<i class="fa fa-file-excel-o" aria-hidden="true"></i> Excel',
                            title: exportTitle,
                            filename: 'excel_distributed_asset_info',
                            exportOptions: {columns: [0, 1, 2, 3, 4]}
                        },
                        {extend: 'pageLength'}
                    ],
                    processing: true,
                    data: response.data,
                    columns: columns
                };
                $('#table').dt(options);
                $.app.overrideDataTableBtn();
                $('.data-view').css("display", "block");
            },
            statusDetailsQuery: {
                1: ['and d.statusid=1', 'Number of tablet by functional'],
                11: ['and d.statusid=1 and d.locationid=1', 'Number of tablet by functional ( user )'],
                12: ['and d.statusid=1 and d.locationid=2', 'Number of tablet by functional ( central store )'],
                13: ['and d.statusid=1 and d.locationid=3', 'Number of tablet by functional ( local store )'],

                2: ['and d.statusid=2', 'Number of tablet by repaired functional'],
                21: ['and d.statusid=2 and d.locationid=4', 'Number of tablet by repaired functional ( user )'],
                22: ['and d.statusid=2 and d.locationid=5', 'Number of tablet by repaired functional ( central store )'],
                23: ['and d.statusid=2 and d.locationid=6', 'Number of tablet by repaired functional ( local store )'],

                3: ['and d.statusid=3', 'Number of tablet by non-functional'],
                31: ['and d.statusid=3 and d.locationid=7', 'Number of tablet by non-functional ( user )'],
                32: ['and d.statusid=3 and d.locationid=8', 'Number of tablet by non-functional ( central store )'],
                33: ['and d.statusid=3 and d.locationid=9', 'Number of tablet by non-functional ( local store )'],
                34: ['and d.statusid=3 and d.locationid=10', 'Number of tablet by non-functional ( vendor )'],

                4: ['and d.statusid=4', 'Number of tablet by damaged'],
                41: ['and d.statusid=4 and d.locationid=11', 'Number of tablet by damaged ( user )'],
                42: ['and d.statusid=4 and d.locationid=12', 'Number of tablet by damaged ( central store )'],
                43: ['and d.statusid=4 and d.locationid=13', 'Number of tablet by damaged ( local store )'],

                5: ['and d.statusid=5', 'Number of tablet by lost'],
                51: ['and d.statusid=5 and d.locationid=14', 'Number of tablet by lost  ( from user )'],
                52: ['and d.statusid=5 and d.locationid=15', 'Number of tablet by lost ( from central store )'],
                53: ['and d.statusid=5 and d.locationid=16', 'Number of tablet by lost ( from local store )'],
            },
            chartLabel: {
                assetBar: ['Number of tablet by status', 'Repaired Functional', 'Non-Functional', 'Damaged', 'Lost']
            },
            chartColor: {
                assetBar: ['#95CEFF', '#F78D1F', '#FFC02D', '#49C1C0', '#5A86C5']
            }
        };
        $.Asset.init();
    });
</script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.flash.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js" type="text/javascript"></script>