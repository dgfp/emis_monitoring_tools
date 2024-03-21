<%-- 
    Document   : ELCOStatus
    Created on : Mar 19, 2020, 11:11:26 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<!--<script src="resources/js/area_dropdown_control_by_user_elco_status.js"></script>-->
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla_test.js"></script>
<script src="resources/js/$.export.js" type="text/javascript"></script>
<script src="resources/js/$.PRS.js" type="text/javascript"></script>
<style>
    #areaPanel [class*="col"] { margin-bottom: 10px; }
    #areaPanel .box {margin-bottom:5px}
    .info-box-md-container .info-box{ min-height: 56px}
    .info-box-md-container .info-box-icon{ width: 56px; height: 56px; line-height: 56px; font-size: 32px;}
    .info-box-md-container .info-box-content{ margin-left: 56px;}
    .box-body {
        padding: 10px!important;
        padding-bottom: 0px!important;
    }
    .label {
        border-radius: 11px!important;
    }
    label[for=provtypeWise]{ background: #e2e0e0;cursor: pointer;padding: 2px;}
    label.checked[for=provtypeWise]{ background: #e2e0e0;}
    #provtypeWise+#provtype{ display: none}
    #provtypeWise:checked+#provtype{ display: block}
    .selected-color{
        background-color: #0bb7dd;
        color: #fff;
    }
    #tableView, .prs-info{}
    #mapView, #graphView, #areaPanel, .chartViewType{
        display: none;
    }
    .chartViewType{
        margin-bottom: 15px;   
    }
    .numeric_field{
        text-align: right;
    }
    .info-box-text{
        text-transform: capitalize;
    }
    #tableFooter {
        background-color: #fff;
    }
    table.table-bordered thead th,
    table.table-bordered thead td {
        border-left-width: 1px;
        border-top-width: 1px;
    }
    .table-bordered {
        border: 2px solid #f4f4f4;
    }
    .numeric_field{
        width: 12%!important;
        min-width: 12%!important;
    }
    .dataTables_filter > input{
        display: none;
        color: red;
    }
    .content-header h1 {
        color: #000!important;
    }
    .warp{
        padding: 2px 4px; 
        color: #fff;
        border-radius: 7px;
    }
    .type-active{
        background-color: #EC971F;
    }
    .type-inactive{
        background-color: #dbdbdb; 
        color: #6d6d6d;
    }
    .view-active{
        background-color: #31B0D5; 

    }
    .view-inactive{
        background-color: #dbdbdb; 
        color: #6d6d6d;
    }
    .viewTitle{
        margin-top: 0px!important;
        margin-bottom: 16px!important;
        text-align: center;
    }
    #unitDiv, #villDiv, #typeBlock, #household-data-table, #population-data-table {
        display: none;
    }
    #mapView, #graphView, #tableView, .prs-info, #areaPanel{
        display: none;
    }
    #printChart > .table-responsive {
        margin-bottom: 0px!important;
    }
    .form-inline{
        padding-left: 0px!important;
    }
    .form-inline label{
        font-weight: normal!important;
    }
    .viewTitle{
        margin-top: 0px!important;
        margin-bottom: 16px!important;
        text-align: center;
    }
    .table-responsive {
        margin-bottom: 0px!important;
    }
    .label-progress {
        width: 100%;
        padding: 0.4em .7em .4em;
        font-weight: 700;
        line-height: 1.1;
        text-align: center;
        white-space: nowrap;
        border-radius: 0.80em;
        color: #fff;
    }
</style>
<script>
    $(function () {
        $('#provtypeWise').on('change', function () {
            $('label[for=provtypeWise]').toggleClass('checked');
            $("#providerwise").val() == "0" ? $("#providerwise").val(1) : $("#providerwise").val(0);
        });
        $('input[type=radio][name=level]').change(function () {
            resetViewType();
            if (this.value == 'aggregate') {
                $("#typeBlock").slideDown(500);
                setViewType(this.value);
            } else if (this.value == 'individual') {
                $("#byMethodCategory, #byMethod").next("span").removeClass("view-active").addClass("view-inactive");
                $("#byMethodCategory, #byMethod").prop("checked", false);
                $("#typeBlock").fadeOut(300);
                setViewType(this.value);
            }
        });

        $('input[type=radio][name=reportType]').change(function () {
            if (this.value == "byMethodCategory") {
                $("#byMethodCategory").next("span").removeClass("view-inactive").addClass("view-active");
                $("#byMethod").next("span").removeClass("view-active").addClass("view-inactive");
            } else {
                $("#byMethod").next("span").removeClass("view-inactive").addClass("view-active");
                $("#byMethodCategory").next("span").removeClass("view-active").addClass("view-inactive");
            }
        });

        var $clickable = $('.clickable').on('click', function (e) {
            var $target = $(e.currentTarget);
            var index = $clickable.index($target)
            $clickable.removeClass('selected-color');
            $target.toggleClass('selected-color');
            if (index == 0) {
                $("#graphView").fadeOut(100);
                $("#tableView").fadeIn(100);
                $("table").fadeIn(100);
            } else if (index == 1) {
                $("#tableView").fadeOut(100);
                $("#graphView").fadeIn(100);
                $("table").fadeOut(100);
            } else {
            }
        });
        function resetViewType() {
            //$("#household-data-table, #population-data-table").css("display", "none");
            $("#aggregate, #individual").next("span").removeClass("type-active").addClass("type-inactive");
            //$("#typeBlock").slideDown();
        }
        function setViewType(selector) {
            $("#" + selector).next("span").removeClass("type-inactive").addClass("type-active");
            //$("#_" + selector).fadeIn();
        }
    })
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>Distribution of eligible couple and visit status by FP methods<small></small></h1>
</section>
<!-- Main content -->
<section class="content">
    <div class="row"  id="areaPanel">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-body" id="a">
                    <form action="prs-coverage" method="post" id="showData">
                        <div class="row">
                            <div class="col-md-1 col-xs-2">
                                <label for="district">Division</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="division" id="division"> 
                                    <option value="">- Select Division -</option>
                                </select>
                            </div>
                            <div class="col-md-1 col-xs-2">
                                <label for="district">District</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="district" id="district">
                                    <option value="">- Select District -</option>
                                </select>
                            </div>
                            <div class="col-md-1 col-xs-2">
                                <label for="upazila">Upazila</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="upazila" id="upazila" >
                                    <option value="">- Select Upazila -</option>
                                </select>
                            </div>
                            <div class="col-md-1 col-xs-2">
                                <label for="union">Union</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="union" id="union" >
                                    <option value="">- Select Union -</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <span id="unitDiv">
                                <div class="col-md-1 col-xs-2">
                                    <label for="unit">Unit</label>
                                </div>
                                <div class="col-md-2 col-xs-4">
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="unit" id="unit" >
                                        <option value="">- select Unit -</option>
                                    </select>
                                </div>
                            </span>
                            <span id="villDiv">
                                <div class="col-md-1 col-xs-2">
                                    <label for="village">Village</label>
                                </div>
                                <div class="col-md-2 col-xs-4">
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="village" id="village" >
                                        <option value="">- select Village -</option>
                                    </select>
                                </div>
                            </span>
                        </div>
                        <!--                        <div class="row">
                                                    <div class="col-md-1 col-xs-2">
                                                        <label for="division">Division</label>
                                                    </div>
                                                    <div class="col-md-2 col-xs-4">
                                                        <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="divid" id="divid">
                                                            <option selected="selected">- Select Division -</option>
                                                        </select>
                                                    </div>
                        
                                                    <div class="col-md-1 col-xs-2">
                                                        <label for="zilla">District</label>
                                                    </div>
                                                    <div class="col-md-2 col-xs-4">
                                                        <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="zillaid" id="zillaid">
                                                            <option selected="selected">- Select District -</option>
                                                        </select>
                                                    </div>
                        
                                                    <div class="col-md-1 col-xs-2">
                                                        <label for="upazila">Upazila</label>
                                                    </div>
                                                    <div class="col-md-2 col-xs-4">
                                                        <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="upazilaid" id="upazilaid">
                                                            <option selected="selected">- Select Upazila -</option>
                                                        </select>
                                                    </div>
                        
                                                    <div class="col-md-1 col-xs-2">
                                                        <label for="union">Union</label>
                                                    </div>
                                                    <div class="col-md-2 col-xs-4">
                                                        <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="unionid" id="unionid">
                                                            <option selected="selected">- Select Union -</option>
                                                        </select>
                                                    </div>
                                                </div>-->
                        <!--                        <div class="row">
                                                    <span id="unitDiv">
                                                        <div class="col-md-1 col-xs-2">
                                                            <label for="unit">Unit</label>
                                                        </div>
                                                        <div class="col-md-2 col-xs-4">
                                                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="unitid" id="unitid" >
                                                                <option value="">- select Unit -</option>
                                                            </select>
                                                        </div>
                                                    </span>
                                                </div>-->

                        <div class="row" id="levelBlock">
                            <div class="col-md-1 col-xs-12">
                                <label for="level">Level</label>
                            </div>
                            <div class="col-md-2 col-xs-6">
                                <label><input type="radio" class="aggregate" id="aggregate" name="level" value="aggregate"> <span class="type-inactive warp">Aggregate</span></label>
                            </div>
                            <div class="col-md-2 col-xs-6">
                                <label><input type="radio" class="individual" id="individual" name="level" value="individual" disabled="true"> <span class="type-inactive warp">Individual</span></label>
                            </div>
                        </div>

                        <div class="row" id="typeBlock">
                            <div class="col-md-1 col-xs-12">
                                <label for="reportType">Type</label>
                            </div>
                            <div class="col-md-2 col-xs-6">
                                <label><input type="radio" id="byMethodCategory" name="reportType" value="byMethodCategory"> <span class="view-inactive warp">By method category</span></label>
                            </div>
                            <div class="col-md-3 col-xs-6">
                                <label><input type="radio" id="byMethod" name="reportType" value="byMethod"> <span class="view-inactive warp">By individual method</span></label>
                            </div>
                        </div>

                        <div class="row">
                            <span class="viewBtnBlock">
                                <div class="col-md-1 col-xs-2 btn-label col-md-offset-4 col-xs-offset-2">
                                    <label for="one" id=""></label>
                                </div>
                                <div class="col-md-2 col-xs-4">
                                    <button type="submit" class="btn btn-flat btn-primary btn-block btn-sm bold" autocomplete="off">
                                        <i class="fa fa-bar-chart" aria-hidden="true"></i>&nbsp; Show Data
                                    </button>
                                </div>
                            </span>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!--    <div class="row info-box-md-container prs-info">
            <div class="col-md-6">
                <div class="row">
                    <div class="col-md-6 col-xs-6">
                        <div class="info-box bg-white selected-color clickable">
                            <span class="info-box-icon bg-aqua"><i class="fa fa-table"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text"><h4></h4></span>
                                <span class="info-box-number center">Table</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-xs-6">
                        <div class="info-box bg-white clickable">
                            <span class="info-box-icon bg-aqua"><i class="fa fa-pie-chart"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text"><h4></h4></span>
                                <span class="info-box-number center">Chart</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>-->
    <!--PRS Data Table-->
    <div class="box box-primary full-screen" id="tableView">
        <div class="box-header with-border" style="padding: 0px;">
            <p class="box-title bold" style="font-size: 15px;padding: 2px;padding-left: 5px;"></p>
            <div class="box-tools pull-right" style="margin-top: -10px;">
                <button type="button" class="btn btn-flat btn-default btn-xs bold" id="exportPrint"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print - PDF</button>
                <a href="#" id ="exportCSV" role='button' class="btn btn-flat btn-default btn-xs bold" style="width:80px;"><i class="fa fa-file-excel-o" aria-hidden="true"></i>&nbsp;Excel</a>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body">   
            <div class="col-md-12 table-responsive">
                <h2 class="viewTitle"><span class="label label-default"></span></h2>
            </div>
            <div class="col-md-12 form-inline sort-by">
                <label>Sort by Method&nbsp;
                    <select class="form-control input-sm" id="sort-by">
                        <!--                        <option value="0">All</option>
                                                <option value="1">Oral pill</option>
                                                <option value="2">Condom</option>
                                                <option value="3">Injectable</option>
                                                <option value="4">IUD</option>
                                                <option value="5">Implant</option>
                                                <option value="6">Permanent method (Male)</option>
                                                <option value="7">Permanent method (Female)</option>-->
                        <option>All</option>
                        <option>Oral pill</option>
                        <option>Condom</option>
                        <option>Injectable</option>
                        <option>IUD</option>
                        <option>Implant</option>
                        <option>Permanent method (Male)</option>
                        <option>Permanent method (Female)</option>
                    </select>
                </label>
            </div>
            <div class="table-responsive fixed" id="export">
                <table class="table table-bordered table-striped table-hover" id="data-table">
                    <thead id="tableHeader" class="data-table">
                    </thead>
                    <tbody id="tableBody">
                    </tbody>
                    <tfoot id="tableFooter">
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
    <!--PRS Data Chart-->
    <div class="box box-primary full-screen" id="graphView">
        <div class="box-header with-border" style="padding: 0px;">
            <p class="box-title bold" style="font-size: 15px;padding: 2px;padding-left: 5px;"></p>
            <div class="box-tools pull-right" style="margin-top: -10px;">
                <button type="button" class="btn btn-flat btn-default btn-xs bold" id="exportPrintChart"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print - PDF</button>
                <a href="#" id="exportImageChart" download="population_characteristics.png" target="_blank" class="btn btn-flat btn-default btn-xs bold"><i class="fa fa-file-image-o" aria-hidden="true"></i>&nbsp;Image</a>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body" id="printChart">
            <div class="col-md-12 table-responsive">
                <h2 class="viewTitle"><span class="label label-default"></span></h2>
            </div>
            <div class="row chartViewType">
                <div class="col-md-2 col-md-offset-4 col-xs-6">
                    <label><input type="radio" id="populationBySex" name="chartViewType" value="populationBySex"> <span class="view-inactive warp">View sex distribution</span></label>
                </div>
                <div class="col-md-3 col-xs-6">
                    <label><input type="radio" id="populationByAgeGroup" name="chartViewType" value="populationByAgeGroup"> <span class="view-inactive warp">View age group distribution</span></label>
                </div>
            </div>
            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="chartCanvas">
                    <div id="chart"></div>
                </div>
            </div><br/>
        </div>
    </div>
    <!--PRS Data Map-->
    <div class="box box-primary" id="mapView">
        <div class="box-header with-border">
            <h3 class="box-title"><b></b>Map Presentation</h3>
            <div class="box-tools pull-right" style="margin-top: 0px;">
                <button type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print</button>
                <button type="button" class="btn btn-box-tool"><i class="fa fa-file-pdf-o" aria-hidden="true"></i>&nbsp;PDF</button>
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                <button id="closeGraph" type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
            </div>
        </div>
        <div class="box-body">
            <div class="table-responsive" >
            </div>
        </div>
    </div>
</section>
<script>
    $(function () {
        $.pc = {
            title: "Distribution of eligible couple and visit status by FP methods",
            baseURL: "elco-status",
            divid: "#divid",
            zillaid: "#zillaid",
            upazilaid: "#upazilaid",
            unionid: "#unionid",
            area: null,
            viewType: null,
            chartId: $("#chart"),
            chartData: [],
            tableHeader: $('#tableHeader'),
            tableBody: $('#tableBody'),
            tableFooter: $('#tableFooter'),
            dataTable: $('#data-table'),
            data: null,
            init: function () {
                $.app.removeWatermark();
                $.pc.events.bindEvent();
            },
            events: {
                bindEvent: function () {
                    $.pc.events.viewData();
                    $.pc.events.sortMethod();
                    $.pc.events.exportPrint();
                    $.pc.events.exportCSV();
                    $.pc.events.exportPrintChart();
                },
                viewData: function () {
                    $(document).off('submit', '#showData').on('submit', '#showData', function (e) {
                        e.preventDefault();
                        $("#tableView").fadeOut(200);
                        $("#graphView").fadeOut(200);
                        $(".prs-info").fadeOut(200);
                        $("#tableFooter").remove();
                        $(".prsProgress").show();
                        var area = $.app.pairs('form');
                        if (area.division == "") {
                            $.toast('Please select division', 'error')();
                            return false;
                        } else if (area.district == "") {
                            $.toast('Please select district', 'error')();
                            return;
                        } else if (area.level == undefined) {
                            $.toast('Please select level', 'error')();
                            return;
                        } else if (area.level == "aggregate" && area.reportType == undefined) {
                            $.toast('Please select type', 'error')();
                            return;
                        }
                        $.pc.ajax.viewData(area);
                    });
                },
                sortMethod: function () {
                    $(document).off('change', '#sort-by').on('change', '#sort-by', function (e) {
                        var sort = $("#sort-by").val();
                        var data = $.pc.data;
                        if (sort != "All") {
                            data = $.pc.data.filter(function (obj) {
                                return obj.currstatus == sort
                            });
                        }
                        $.pc.renderTableData(data, $.app.pairs('form'), true);
                    });
                },
                exportPrint: function () {
                    $(document).off('click', '#exportPrint').on('click', '#exportPrint', function (e) {
                        $.pc.dataTableLength = $('select[name=data-table_length]').val();
                        $($.pc.dataTable).DataTable().page.len(-1).draw();
                        $.export.print($("#export").html(), $.pc.title + "<br/>" + $('.viewTitle > .label').html(), $.pc.getArea());
                    });
                },
                exportCSV: function () {
                    $(document).off('click', '#exportCSV').on('click', '#exportCSV', function (e) {
                        $.pc.dataTableLength = $('select[name=data-table_length]').val();
                        $($.pc.dataTable).DataTable().page.len(-1).draw();
                        $.export.excel($.pc.dataTable);
                    });
                },
                exportPrintChart: function () {
                    $(document).off('click', '#exportPrintChart').on('click', '#exportPrintChart', function (e) {
                        $.export.printChart($.pc.title + "<br/>" + $('.viewTitle > .label').html(), $.pc.getArea());
                    });
                }
            },
            ajax: {
                viewData: function (json) {
                    console.log(json);
                    $.ajax({
                        url: $.pc.baseURL + "?viewType=" + $.pc.getViewType(json, 0),
                        type: "POST",
                        data: {data: JSON.stringify(json)},
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response);
                            if (response.success == true) {
                                var data = response.data;
                                $.pc.data = response.data;
                                if (data.length === 0) {
                                    toast("error", "No data found");
                                    return;
                                }
                                $.pc.renderTableData(data, json, false);
                            } else {
                                toastr['error']("Error occured while data loading");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                }//end viewData
            }, //end ajax
            renderTableData: function (data, json, isSorted) {
                if (!isSorted)
                    $("#sort-by").val($("#sort-by option:first").val());
                $(".sort-by").css("display", "none");

                $.PRS.resetSwitchBtn($.pc.title);
                $.app.removeWatermark();
                $('.viewTitle > .label-default').text($.pc.viewTitle[json.reportType]);
                $("#tableView").slideDown("slow");
                $(".prs-info").slideDown("slow");
                $("table").fadeIn(100);
                var cal = new Calc(data);
                $.pc.resetTable();
                var columns = [];
                var isUnitWise = false, klass = "left";
                var footer = "";
                var viewType = $.pc.getViewType(json, 0);
                //viewType == "Unit" ? isUnitWise = true : isUnitWise = false;
                if (viewType == "Unit") {
                    isUnitWise = true;
                    klass = "center";
                }

                if (json.level == "aggregate" && json.reportType == "byMethodCategory") {
                    $.pc.tableHeader.append($.pc.getByMethodCategoryHeader(viewType, isUnitWise, klass));
                    $("#data-table").DataTable().clear();
                    columns = [
                        {
                            orderable: false,
                            searchable: false,
                            data: null,
                            defaultContent: '#'
                        },
                        {data: function (d) {
                                var unit = "";
                                if (d.uname != undefined)
                                    unit = "<br/>" + $.app.getAssignType(d.assign_type, 1);
                                return d[$.pc.getViewType(json, 1)] + "" + unit;
                            }, class: "viewLevel " + klass},
                        {data: "short_term_method_acceptors"},
                        {data: function (d) {
                                return $.app.isFloat(d["short_term_method_visit"]);
                            }},
                        {data: "long_term_method_acceptors"},
                        {data: function (d) {
                                return $.app.isFloat(d.long_term_method_visit);
                            }},
                        {data: "permanent_method_acceptors"},
                        {data: function (d) {
                                return $.app.isFloat(d.permanent_method_visit);
                            }}
                    ];
                    footer = $.pc.getByMethodCategoryFooter(cal, data.length, $.pc.getTotalText(json, 0));//Footer

                } else if (json.level == "aggregate" && json.reportType == "byMethod") {
                    $.pc.tableHeader.append($.pc.getByMethodHeader(viewType, isUnitWise, klass));
                    $("#data-table").DataTable().clear();
                    columns = [
                        {
                            orderable: false,
                            searchable: false,
                            data: null,
                            defaultContent: '#'
                        },
                        {data: function (d) {
                                var unit = "";
                                if (d.uname != undefined)
                                    unit = "<br/>" + $.app.getAssignType(d.assign_type, 1);
                                return d[$.pc.getViewType(json, 1)] + "" + unit;
                            }, class: "viewLevel " + klass},
                        {data: "oral_pill"},
                        {data: function (d) {
                                return $.app.isFloat(d.oral_pill_visit);
                            }},
                        {data: "condom"},
                        {data: function (d) {
                                return $.app.isFloat(d.condom_visit);
                            }},
                        {data: "injectable"},
                        {data: function (d) {
                                return $.app.isFloat(d.injectable_visit);
                            }},
                        {data: "iud"},
                        {data: function (d) {
                                return $.app.isFloat(d.iud_visit);
                            }},
                        {data: "implant"},
                        {data: function (d) {
                                return $.app.isFloat(d.implant_visit);
                            }},
                        {data: "permanent_male"},
                        {data: function (d) {
                                return $.app.isFloat(d.permanent_male_visit);
                            }},
                        {data: "permanent_female"},
                        {data: function (d) {
                                return $.app.isFloat(d.permanent_female_visit);
                            }}
                    ];
                    footer = $.pc.getByMethodFooter(cal, data.length, $.pc.getTotalText(json, 0));//Footer

                } else if (json.level == "individual" && json.reportType == undefined) {
                    $(".sort-by").css("display", "block");
                    $.pc.tableHeader.append($.pc.getIndividualHeader());
                    $("#data-table").DataTable().clear();
                    columns = [
                        {
                            orderable: false,
                            searchable: false,
                            data: null,
                            defaultContent: '#'
                        },
                        {data: "village"},
                        {data: "elconame"},
                        {data: "age"},
                        {data: "husband"},
                        {data: function (d) {
                                if (d.mobileno == null || d.mobileno == 'null' || d.mobileno == "") {
                                    return "-";
                                } else {
                                    return "0" + d.mobileno;
                                }
                            }},
                        {data: function (d) {
                                if (d.currstatus == null || d.currstatus == 'null' || d.currstatus == "") {
                                    return "-";
                                } else {
                                    return d.currstatus;
                                }
                            }},
                        {data: function (d) {
                                if (d.vdate == null || d.vdate == 'null' || d.vdate == "") {
                                    return "-";
                                } else {
                                    /*
                                     var regExp = /(\d{1,2})\/(\d{1,2})\/(\d{2,4})/;
                                     var three_month_back_date = $.app.date(new Date(new Date().setMonth(new Date().getMonth() - 3))).date;
                                     var visit_date = $.app.date(new Date(d.vdate)).date;
                                     if (parseInt(visit_date.replace(regExp, "$3$2$1")) >= parseInt(three_month_back_date.replace(regExp, "$3$2$1"))) {
                                     return '<div class="label-progress" style="background-color:#00A65A;">' + visit_date + '</div>';
                                     } else {
                                     return '<div class="label-progress" style="background-color:#ff3d3d;">' + visit_date + '</div>';
                                     }
                                     */
                                    var three_month_back_date = new Date(new Date().setMonth(new Date().getMonth() - 3));
                                    var visit_date = new Date(d.vdate);
                                    if (visit_date >= three_month_back_date) {
                                        return '<div class="label-progress" style="background-color:#00A65A;">' + $.app.date(new Date(d.vdate)).date + '</div>';
                                    } else {
                                        return '<div class="label-progress" style="background-color:#ff3d3d;">' + $.app.date(new Date(d.vdate)).date + '</div>';
                                    }

                                }
                            }}
                    ];

                }

                if (viewType == "Unit" && json.level == "aggregate") {
                    columns.splice(2, 0, {data:
                                function (d) {
                                    var provname = (d.providerid === 5) ? "NGO" : "<b>" + d.provname + "</b>";
                                    var mobile = (d.providermobile === "null") ? "-" : d.providermobile;
                                    return provname + "<br/>" + mobile;
                                }
                    });
                }

                $("#data-table").DataTable().destroy();
                $("#data-table").dt($.app.dataTableOptions(data, columns));
                $("#data-table").DataTable().draw();
                $("#data-table > tbody").after(footer);
            },
            viewLevel: {
                0: ["District", "zillanameeng", 1],
                1: ["Upazila", "upzilanameeng", 1],
                2: ["Union", "unionnameeng", 2],
                3: ["Unit", "uname", 3],
                4: ["Unit", "uname", 3]
            },
            getViewType: function (json, i) {
                if (json.upazila == "0")
                    return $.pc.viewLevel[1][i];
                else if (json.union == "0")
                    return $.pc.viewLevel[2][i];
                else if (json.unit == "0")
                    return $.pc.viewLevel[3][i];
                else
                    return $.pc.viewLevel[4][i];
            },
            getTotalText: function (json, i) {
                if (json.upazila == "0")
                    return $.pc.viewLevel[0][i];
                else if (json.union == "0")
                    return $.pc.viewLevel[1][i];
                else if (json.unit == "0")
                    return $.pc.viewLevel[2][i];
                else
                    return $.pc.viewLevel[3][i];
            },
            resetTable: function () {
                $.pc.tableHeader.empty();
                $.pc.tableBody.empty();
                $.pc.tableFooter.empty();
            },
            getByMethodCategoryHeader: function (viewType, isUnitWise, klass) {
                return '<tr id="tableRow">\
                            <th rowspan="2">#</th>\
                            <th rowspan="2" class="viewLevel" style="text-align:' + klass + '">' + viewType + '</th>' + $.pc.getProviderHead(isUnitWise) + '\
                            <th colspan="2" class="center colspan">Short-term method</th>\
                            <th colspan="2" class="center colspan">Long-term method</th>\
                            <th colspan="2" class="center colspan">Permanent method</th>\
                        </tr>\
                        <tr id="tableRow">\
                            <th>Acceptor (n)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                            <th>Visited (%)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                            <th>Acceptor (n)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                            <th>Visited (%)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                            <th>Acceptor (n)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                            <th>Visited (%)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                        </tr>';
            },
            getByMethodHeader: function (viewType, isUnitWise, klass) {
                return '<tr id="tableRow">\
                            <th rowspan="2">#</th>\
                            <th rowspan="2" class="viewLevel" style="text-align:' + klass + '">' + viewType + '</th>' + $.pc.getProviderHead(isUnitWise) + '\
                            <th colspan="2" class="center colspan">Oral pill</th>\
                            <th colspan="2" class="center colspan">Condom</th>\
                            <th colspan="2" class="center colspan">Injectable</th>\
                            <th colspan="2" class="center colspan">IUD</th>\
                            <th colspan="2" class="center colspan">Implant</th>\
                            <th colspan="2" class="center colspan">Permanent method (Male)</th>\
                            <th colspan="2" class="center colspan">Permanent method (Female)</th>\
                        </tr>\
                        <tr id="tableRow">\
                            <th>Acceptor (n)</th>\
                            <th>Visited (%)</th>\
                            <th>Acceptor (n)</th>\
                            <th>Visited (%)</th>\
                            <th>Acceptor (n)</th>\
                            <th>Visited (%)</th>\
                            <th>Acceptor (n)</th>\
                            <th>Visited (%)</th>\
                            <th>Acceptor (n)</th>\
                            <th>Visited (%)</th>\
                            <th>Acceptor (n)</th>\
                            <th>Visited (%)</th>\
                            <th>Acceptor (n)</th>\
                            <th>Visited (%)</th>\
                        </tr>';
            },
            getIndividualHeader: function () {
                return '<tr id="tableRow">\
                            <th>#</th>\
                            <th class="center colspan">Village</th>\
                            <th class="center colspan">Name</th>\
                            <th class="center colspan">Age</th>\
                            <th class="center colspan">Husband</th>\
                            <th class="center colspan">Mobile</th>\
                            <th class="center colspan">Current status</th>\\n\
                            <th class="center colspan">Last visit</th>\
                        </tr>';
            },
            getByMethodCategoryFooter: function (json, length, type) {
                var colspan = 2;
                if (type == "Unit" || type == "Union")
                    colspan = 3;
                return '<tfoot id="tableFooter">\n<tr class="bold">\
                                <td style="text-align:left" colspan="' + colspan + '">' + type + ' Total</td>\
                                <td>' + json.sum.short_term_method_acceptors + '</td>\
                                <td>' + ((json.sum.short_term_method_visit) / length).toFixed(1) + '</td>\
                                <td>' + json.sum.long_term_method_acceptors + '</td>\
                                <td>' + ((json.sum.long_term_method_visit) / length).toFixed(1) + '</td>\
                                <td>' + json.sum.permanent_method_acceptors + '</td>\
                                <td>' + ((json.sum.permanent_method_visit) / length).toFixed(1) + '</td>\
                        </tr>\n</tfoot>';
            },
            getByMethodFooter: function (json, length, type) {
                var colspan = 2;
                if (type == "Unit" || type == "Union")
                    colspan = 3;
                return '<tfoot id="tableFooter">\n<tr class="bold">\
                                <td style="text-align:left" colspan="' + colspan + '">' + type + ' Total</td>\
                                <td>' + json.sum.oral_pill + '</td>\
                                <td>' + ((json.sum.oral_pill_visit) / length).toFixed(1) + '</td>\
                                <td>' + json.sum.condom + '</td>\
                                <td>' + ((json.sum.condom_visit) / length).toFixed(1) + '</td>\
                                <td>' + json.sum.injectable + '</td>\
                                <td>' + ((json.sum.injectable_visit) / length).toFixed(1) + '</td>\
                                <td>' + json.sum.iud + '</td>\
                                <td>' + ((json.sum.iud_visit) / length).toFixed(1) + '</td>\
                                <td>' + json.sum.implant + '</td>\
                                <td>' + ((json.sum.implant_visit) / length).toFixed(1) + '</td>\
                                <td>' + json.sum.permanent_male + '</td>\
                                <td>' + ((json.sum.permanent_male_visit) / length).toFixed(1) + '</td>\
                                <td>' + json.sum.permanent_female + '</td>\
                                <td>' + ((json.sum.permanent_female_visit) / length).toFixed(1) + '</td>\
                        </tr>\n</tfoot>';
            },
            getArea: function () {
                var area = "Division: " + $("#divid option:selected").text();
                area += "&nbsp; District: " + $("#zillaid option:selected").text();
                area += "&nbsp; Upazila: " + $("#upazilaid option:selected").text();
                area += "&nbsp; Union: " + $("#unionid option:selected").text();
                area += "&nbsp; Unit: " + $("#unit option:selected").text();
                area += "&nbsp; Village: " + $("#village option:selected").text();
                return area;
            },
            getProviderHead: function (isUnitWise) {
                var providerHead = "";
                if (isUnitWise)
                    providerHead = '<th rowspan="2">Provider</th>';
                return providerHead;
            },
            viewTitle: {
                byMethodCategory: 'Percentage of eligible couples visited by FWA during last three months, by method category',
                byMethod: 'Percentage of eligible couples visited by FWA during last three months, by individual method',
                undefined: 'List of eligible couples with their visit status during last three months'
            }
        };//end prs
        $.pc.init();
    });
</script>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<%@include file="/WEB-INF/jspf/DataTableExportResource.jspf" %>