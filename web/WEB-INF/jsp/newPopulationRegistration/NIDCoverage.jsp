<%-- 
    Document   : NIDCoverage
    Created on : Apr 6, 2020, 3:48:14 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeaderELCO.jspf" %>
<script src="resources/js/dropdown_loader_prs_dgfp.js" type="text/javascript"></script>
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
    #unitDiv, #dateBlock, #household-data-table, #population-data-table {
        display: none;
    }
    #mapView, #graphView, #tableView, .prs-info, #areaPanel{
        display: none;
    }
    #printChart > .table-responsive {
        margin-bottom: 0px!important;
    }
    .monthPickerChoose{
        background-color: rgb(255, 255, 255)!important;
    }
    .ui-widget-header {
        background: #3C8DBC!important;
    }   
    .ui-corner-all, .ui-corner-bottom, .ui-corner-left, .ui-corner-bl {
        border-radius: 0px!important;
    }
    .mtz-monthpicker{
        cursor: pointer!important;
    }
</style>
<script>
    $(function () {
        $('#provtypeWise').on('change', function () {
            $('label[for=provtypeWise]').toggleClass('checked');
            $("#providerwise").val() == "0" ? $("#providerwise").val(1) : $("#providerwise").val(0);
        });
//        $('input[type=radio][name=level]').change(function () {
//            resetViewType();
//            if (this.value == 'household') {
//                setViewType(this.value);
//            } else if (this.value == 'population') {
//                setViewType(this.value);
//            }
//        });
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
            $("#household-data-table, #population-data-table").css("display", "none");
            $("#household, #population").next("span").removeClass("view-active").addClass("view-inactive");
            $("#dateBlock").slideDown();
        }

        function resetViewType() {
            $("#_atPoint, #_monthly").css("display", "none");
            $("#atPoint, #monthly").next("span").removeClass("view-active").addClass("view-inactive");
            $("#dateBlock").slideDown();
        }
        function setViewType(selector) {
            $("#" + selector).next("span").removeClass("view-inactive").addClass("view-active");
            $("#_" + selector).fadeIn();
        }
        $('input[type=radio][name=level]').change(function () {
            resetViewType();
            if (this.value == 'atPoint') {
                setViewType(this.value);
            } else if (this.value == 'monthly') {
                setViewType(this.value);
            }
        });
    })
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>Status of National ID coverage<small></small></h1>
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
                        </div>
                        <div class="row">
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
                        </div>

                        <div class="row" id="viewTypeBlock">
                            <div class="col-md-1 col-xs-12">
                                <label for="viewType">Type</label>
                            </div>
                            <div class="col-md-2 col-xs-6">
                                <label><input type="radio" id="atPoint" name="level" value="atPoint"> <span class="view-inactive warp">Status up to date</span></label>
                            </div>
                            <div class="col-md-2 col-xs-6">
                                <label><input type="radio" id="monthly" name="level" value="monthly"> <span class="view-inactive warp">Monthly status</span></label>
                            </div>
                        </div>

                        <div class="row" id="dateBlock">
                            <div class="col-md-1 col-xs-2">
                                <label for="one" id="">Date</label>
                            </div>
                            <span id="_atPoint">
                                <input type="hidden" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="startDate" id="startDate" />
                                <div class="col-md-1 col-xs-1">
                                    <label for="one" id="">On</label>
                                </div>
                                <div class="col-md-2 col-xs-3">
                                    <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="endDate" id="endDate" />
                                </div>
                            </span>
                            <span id="_monthly">
                                <div class="col-md-1 col-xs-1">
                                    <label for="one" id="">From</label>
                                </div>
                                <div class="col-md-2 col-xs-3">
                                    <input type="text" class="form-control input-sm mtz-monthpicker-widgetcontainer monthPickerChoose" placeholder="mm/yyyy" name="startMonthYear" id="startMonthYear">
                                </div>
                                <div class="col-md-1 col-xs-1">
                                    <label for="one" id="">To</label>
                                </div>
                                <div class="col-md-2 col-xs-3">
                                    <input type="text" class="form-control input-sm mtz-monthpicker-widgetcontainer monthPickerChoose" placeholder="mm/yyyy" name="endMonthYear" id="endMonthYear">
                                </div>
                            </span>
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
    <div class="row info-box-md-container prs-info">
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
    </div>
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
                <h2 class="viewTitle"><span class="label label-default" style="font-size:21px;"></span></h2>
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
                <a href="#" id="exportImageChart" download="national_id_coverage.png" target="_blank" class="btn btn-flat btn-default btn-xs bold"><i class="fa fa-file-image-o" aria-hidden="true"></i>&nbsp;Image</a>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body" id="printChart">
            <div class="row">
                <div class="col-md-12 table-responsive">
                    <h2 class="viewTitle"><span class="label label-default" style="font-size:21px;"></span></h2>
                </div>
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
        $.NID = {
            title: "Status of National ID coverage",
            baseURL: "nid-coverage",
            divid: "#divid",
            zillaid: "#zillaid",
            upazilaid: "#upazilaid",
            unionid: "#unionid",
            area: null,
            viewType: null,
            totalObj: {},
            chartId: $("#chart"),
            chartData: [],
            tableHeader: $('#tableHeader'),
            tableBody: $('#tableBody'),
            tableFooter: $('#tableFooter'),
            dataTable: $('#data-table'),
            data: null,
            init: function () {
                $.app.removeWatermark();
                $.NID.events.bindEvent();
            },
            events: {
                bindEvent: function () {
                    $.NID.events.viewData();
                    //$.NID.events.populationChartViewType();
                    $.NID.events.exportPrint();
                    $.NID.events.exportCSV();
                    $.NID.events.exportPrintChart();
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
                        console.log(area);
                        if (area.divid == "") {
                            $.toast('Please select division', 'error')();
                            return false;
                        } else if (area.zillaid == "") {
                            $.toast('Please select district', 'error')();
                            return;
                        } else if (area.level == undefined) {
                            $.toast('Please select type', 'error')();
                            return;
                        }
                        if (area.level == "atPoint" && area.endDate == "") {
                            $.toast("Please select date", "error")();
                            return;
                        }
                        if (area.level == "monthly" && area.startMonthYear == "") {
                            $.toast("Please select month", "error")();
                            return;
                        } else if (area.level == "monthly" && area.endMonthYear == "") {
                            $.toast("Please select month", "error")();
                            return;
                        } else if (area.level == "monthly" && !$.app.monthChecker(area)) {
                            $.toast("Start month should be smaller than end month", "error")();
                            return;
                        }
                        $.NID.ajax.viewData(area);
                    });
                },
                exportPrint: function () {
                    $(document).off('click', '#exportPrint').on('click', '#exportPrint', function (e) {
                        $.NID.dataTableLength = $('select[name=data-table_length]').val();
                        $($.NID.dataTable).DataTable().page.len(-1).draw();
                        $.export.print($("#export").html(), $.NID.title + "<br/>" + $('.viewTitle > .label').html(), $.NID.getArea());
                    });
                },
                exportCSV: function () {
                    $(document).off('click', '#exportCSV').on('click', '#exportCSV', function (e) {
                        $.NID.dataTableLength = $('select[name=data-table_length]').val();
                        $($.NID.dataTable).DataTable().page.len(-1).draw();
                        $.export.excel($.NID.dataTable);
                    });
                },
                exportPrintChart: function () {
                    $(document).off('click', '#exportPrintChart').on('click', '#exportPrintChart', function (e) {
                        $.export.printChart($.NID.title + "<br/>" + $('.viewTitle > .label').html(), $.NID.getArea());
                    });
                }
            },
            ajax: {
                viewData: function (json) {
                    $.ajax({
                        url: $.NID.baseURL + "?viewType=" + $.NID.getViewType(json, 0),
                        type: "POST",
                        data: {data: JSON.stringify(json)},
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response);
                            if (response.success == true) {
                                var data = response.data;
                                $.NID.data = response.data;
                                if (data.length === 0) {
                                    $.toast('No data found', 'error')();
                                    //toast("error", "No data found");
                                    return;
                                }
                                $('.chartViewType').css('display', 'block');
                                $.PRS.resetSwitchBtn($.NID.title);
                                $.app.removeWatermark();
                                $("#tableView").slideDown("slow");
                                $(".prs-info").slideDown("slow");
                                $("table").fadeIn(100);
                                var cal = new Calc(data);
                                $.NID.resetTable();
                                $.NID.chartData = [];
                                var columns = [];
                                var isUnitWise = false, klass = "left";
                                var footer = "";
                                $.NID.chartId.html("");
                                var viewType = $.NID.getViewType(json, 0);
                                if (viewType == "Unit") {
                                    isUnitWise = true;
                                    klass = "center";
                                }

                                if (json.level == "atPoint") {
                                    $('.viewTitle > .label-default').text($.NID.viewTitle[json.level] + "" + json.endDate);
                                    $.NID.tableHeader.append($.NID.getStatusUpToDateHeader(viewType, isUnitWise, klass));
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
                                                return d[$.NID.getViewType(json, 1)] + "" + unit;
                                            }, class: "viewLevel " + klass},

                                        {data: "eligible"},
                                        {data: function (d) {
                                                return $.app.isFloat(d.have_nid);
                                            }},
                                        {data: function (d) {
                                                return $.app.isFloat(d.dont_had_nid);
                                            }},
                                        {data: function (d) {
                                                return $.app.isFloat(d.updated_later);
                                            }}
                                    ];
                                    footer = $.NID.getStatusUpToDateFooter(cal, data.length, $.NID.getTotalText(json, 0));//Footer
                                    //Chart data preparing
                                    $.each(data, function (i, o) {
                                        $.NID.chartData.push({
                                            area: o[$.NID.getViewType(json, 1)] + " ( n=" + o.eligible + " )",
                                            have_nid: $.app.isFloat(o.have_nid),
                                            dont_had_nid: $.app.isFloat(o.dont_had_nid),
                                            updated_later: $.app.isFloat(o.updated_later)
                                        });
                                    });
                                    $.NID.chartData.push({
                                        area: $.NID.getTotalText(json, 0) + " Total ( n=" + cal.sum.eligible + " )",
                                        have_nid: ((cal.sum.have_nid) / data.length).toFixed(1),
                                        dont_had_nid: ((cal.sum.dont_had_nid) / data.length).toFixed(1),
                                        updated_later: ((cal.sum.updated_later) / data.length).toFixed(1)
                                    });
                                    $.chart.renderBar($.NID.chartId, $.NID.chartData, $.NID.chartLabel['atPoint'], $.NID.chartColor['atPoint'], 100); //chart



                                } else if (json.level == "monthly") {
                                    $('.viewTitle > .label-default').text($.NID.viewTitle[json.level] + "" + json.startMonthYear + " and " + json.endMonthYear);
                                    var d = $.NID.processMonthlyData(data, $.NID.getViewType(json, 1));
                                    console.log(d);
                                    //Reset data after processing
                                    data = d.tableData;
                                    cal = new Calc(data);
                                    $.NID.tableHeader.append($.NID.getMonthlyHeader(viewType, isUnitWise, klass, d.tableHeader));
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
                                                return d[$.NID.getViewType(json, 1)] + "" + unit;
                                            }, class: "viewLevel " + klass},
                                        {data: "eligible"},
                                    ];
                                    $.each(d.months, function (index, value) {
                                        //var id = "month_" + index;
                                        columns.push({data: function (d) {
                                                return $.app.isFloat(d["month_" + index]);
                                            }});
                                    });
                                    footer = $.NID.getMonthlyFooter(cal, data.length, $.NID.getTotalText(json, 0), d.months);//Footer
                                    d.chartData.push($.NID.totalObj);
                                    $.chart.renderBar($.NID.chartId, d.chartData, d.chartLabel, $.NID.chartColor['monthly'], 100);
                                }
                                if (viewType == "Unit") {
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

                            } else {
                                toastr['error']("Error occured while data loading");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                }//end viewData
            }, //end ajax
            viewLevel: {
                0: ["District", "zillanameeng", 1],
                1: ["Upazila", "upazilanameeng", 1],
                2: ["Union", "unionnameeng", 2],
                3: ["Unit", "uname", 3],
                4: ["Unit", "uname", 3]
            },
            getViewType: function (json, i) {
                if (json.upazilaid == "0")
                    return $.NID.viewLevel[1][i];
                else if (json.unionid == "0")
                    return $.NID.viewLevel[2][i];
                else if (json.unitid == "0")
                    return $.NID.viewLevel[3][i];
                else
                    return $.NID.viewLevel[4][i];
            },
            getTotalText: function (json, i) {
                if (json.upazilaid == "0")
                    return $.NID.viewLevel[0][i];
                else if (json.unionid == "0")
                    return $.NID.viewLevel[1][i];
                else if (json.unitid == "0")
                    return $.NID.viewLevel[2][i];
                else
                    return $.NID.viewLevel[3][i];
            },
            resetTable: function () {
                $.NID.tableHeader.empty();
                $.NID.tableBody.empty();
                $.NID.tableFooter.empty();
            },
            getStatusUpToDateHeader: function (viewType, isUnitWise, klass) {
                var provider = isUnitWise ? '<th>Provider</th>' : '';
                return '<tr id="tableRow">\
                            <th>#</th>\
                            <th class="viewLevel" style="text-align:' + klass + '">' + viewType + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>' + provider + '\
                            <th>No. of population aged 18 years and above</th>\
                            <th>Have NID card (%)</th>\
                            <th>Never had NID card (%)</th>\
                            <th>Could not show (updated later) (%)</th>\
                        </tr>';

            },
            getStatusUpToDateFooter: function (json, length, type) {
                var colspan = 2;
                if (type == "Unit" || type == "Union")
                    colspan = 3;
                return '<tfoot id="tableFooter">\n<tr class="bold">\
                                <td style="text-align:left" colspan="' + colspan + '">' + type + ' Total</td>\
                                <td>' + json.sum.eligible + '</td>\
                                <td>' + ((json.sum.have_nid) / length).toFixed(1) + '</td>\
                                <td>' + ((json.sum.dont_had_nid) / length).toFixed(1) + '</td>\
                                <td>' + ((json.sum.updated_later) / length).toFixed(1) + '</td>\
                        </tr>\n</tfoot>';
            },
            getMonthlyHeader: function (viewType, isUnitWise, klass, th) {
                var provider = isUnitWise ? '<th>Provider</th>' : '';
                return '<tr id="tableRow">\
                            <th>#</th>\
                            <th class="viewLevel" style="text-align:' + klass + '">' + viewType + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>' + provider + '\
                            <th>No. of population aged 18 years and above</th>\
                            ' + th + '\
                        </tr>';

            },
            getMonthlyFooter: function (json, length, type, months) {
                $.NID.totalObj = {};
                $.NID.totalObj = {area: type + ' Total ( n=' + json.sum.eligible + ' )'};
                var th = "";
                $.each(months, function (i, v) {
                    $.NID.totalObj["month_" + i] = ((json.sum["month_" + i]) / length).toFixed(1);
                    th += '<td>' + ((json.sum["month_" + i]) / length).toFixed(1) + '</td>';
                });
                var colspan = 2;
                if (type == "Unit" || type == "Union")
                    colspan = 3;
                return '<tfoot id="tableFooter">\n<tr class="bold">\
                                <td style="text-align:left" colspan="' + colspan + '">' + type + ' Total</td>\
                                <td>' + json.sum.eligible + '</td>\\n\
                                ' + th + '\
                        </tr>\n</tfoot>';


            },
            getArea: function () {
                var area = "Division: " + $("#divid option:selected").text();
                area += "&nbsp; District: " + $("#zillaid option:selected").text();
                area += "&nbsp; Upazila: " + $("#upazilaid option:selected").text();
                area += "&nbsp; Union: " + $("#unionid option:selected").text();
                area += "&nbsp; From: " + $("#startDate").val();
                area += "&nbsp; To: " + $("#endDate").val();
                return area;
            },
            processMonthlyData: function (data, areaType) {
                //response variables
                var response = {tableHeader: "", chartLabel: [], months: null, area: null, tableData: [], chartData: []};
                //distinct month
                response.months = data.filter(function (a) {
                    var key = a['months'] + '|' + a['years'];
                    if (!this[key]) {
                        this[key] = true;
                        return true;
                    }
                }, Object.create(null));
                //make table column using distinct month
                $.each(response.months, function (i, v) {
                    var head = $.app.monthShort[v.months] + " " + (v.years).toString().substring(2, 4)
                    response.tableHeader += "<th style='vertical-align: top;'>" + head + "</th>";
                    response.chartLabel.push(head);
                });
                //distinct area
                response.area = data.map(item => item[areaType]).filter((value, index, self) => self.indexOf(value) === index);
                //Table data and chart data added here
                $.each(response.area, function (i, v) {
                    var tableDataObj = {}, chartDataObj = {};
                    tableDataObj[areaType] = v;
                    $.each(response.months, function (index, value) {

                        //Filterimg Data
                        var row = data.filter(obj => obj[areaType] == v && obj.months == value.months && obj.years == value.years)[0];
                        //
                        chartDataObj['area'] = v + " ( n=" + row.eligible + " )";

                        //Table data added here
                        if (areaType == "uname") {
                            tableDataObj.assign_type = row.assign_type;
                            tableDataObj.providerid = row.providerid;
                            tableDataObj.providermobile = row.providermobile;
                            tableDataObj.provname = row.provname;
                        }
                        tableDataObj.eligible = row.eligible;
                        tableDataObj["month_" + index] = row.have_nid;
                        //Chart data added here
                        chartDataObj["month_" + index] = row.have_nid;
                    });
                    response.tableData.push(tableDataObj);
                    response.chartData.push(chartDataObj);
                });
                return response;
            },
            viewTitle: {
                atPoint: "Percent distribution of national ID availability in population aged 18 years and above up to ",
                monthly: "Percentage of registered population aged 18 years and above has national ID between "
            },
            chartLabel: {
                atPoint: ['Have NID card', 'Never had NID card', 'Could not show (updated later)']
            },
            chartColor: {
                atPoint: ['#7AB2EF', '#ff8989', '#e53232'],
                monthly: ['#EF3E69', '#F78D1F', '#FFC02D', '#49C1C0', '#5A86C5', '#0D8181', '#F16582', '#B1B5BE', '#7E69AE', '#9BCCED', '#DC84B7', '#B61C8C']
            }
        };
        $.NID.init();
    });
</script>

<%--<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>--%>
<%@include file="/WEB-INF/jspf/DataTableExportResource.jspf" %>
<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/themes/smoothness/jquery-ui.css">
<link href="resources/datepicker/MonthPicker.min.css" rel="stylesheet" type="text/css" />
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script src = "https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src="https://cdn.rawgit.com/digitalBush/jquery.maskedinput/1.4.1/dist/jquery.maskedinput.min.js"></script>
<script src="resources/datepicker/MonthPicker.min.js"></script>
<script>
    $(document).ready(function () {
        $(".select2").tooltip({
            content: '.'
        });
        $('#startMonthYear, #endMonthYear').MonthPicker({
            MaxMonth: 0,
            MinMonth: -11,
            Button: false
        });
    });
</script>
<style>
    .ui-tooltip {
        padding: 0px!important;
        position: absolute;
        z-index: 9999;
        max-width: 0px!important;
        -webkit-box-shadow: 0 0 0px #aaa!important;
        box-shadow: 0 0 0px #aaa!important;
        border: none;
        color: #fff;
    }
</style>