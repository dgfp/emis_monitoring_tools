<%-- 
    Document   : PopulationStatistics
    Created on : May 3, 2020, 10:50:04 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
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
</style>
<script>
    $(function () {
        $('#provtypeWise').on('change', function () {
            $('label[for=provtypeWise]').toggleClass('checked');
            $("#providerwise").val() == "0" ? $("#providerwise").val(1) : $("#providerwise").val(0);
        });
        $('input[type=radio][name=level]').change(function () {
            resetViewType();
            if (this.value == 'household') {
                setViewType(this.value);
            } else if (this.value == 'population') {
                setViewType(this.value);
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
            $("#household-data-table, #population-data-table").css("display", "none");
            $("#household, #population").next("span").removeClass("view-active").addClass("view-inactive");
            $("#dateBlock").slideDown();
        }
        function setViewType(selector) {
            $("#" + selector).next("span").removeClass("view-inactive").addClass("view-active");
            $("#_" + selector).fadeIn();
        }
    })
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>Household & population statistics up to a selected date<small></small></h1>
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
                                <label for="viewType">Level</label>
                            </div>
                            <div class="col-md-2 col-xs-6">
                                <label><input type="radio" id="household" name="level" value="household"> <span class="view-inactive warp">Household</span></label>
                            </div>
                            <div class="col-md-2 col-xs-6">
                                <label><input type="radio" id="population" name="level" value="population"> <span class="view-inactive warp">Population</span></label>
                            </div>
                        </div>

                        <div class="row" id="dateBlock">
                            <div class="col-md-1 col-xs-2">
                                <label for="one" id="">Date</label>
                            </div>
                            <input type="hidden" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="startDate" id="startDate" />
                            <div class="col-md-1 col-xs-1">
                                <label for="one" id="">On</label>
                            </div>
                            <div class="col-md-2 col-xs-3">
                                <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="endDate" id="endDate" />
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
    <div class="row info-box-md-container prs-info">
        <!--        <div class="col-md-6">
                    <div class="row">
                        <div class="col-md-6 col-xs-6">
                            <div class="info-box bg-white">
                                <span class="info-box-icon bg-yellow"><i class="fa fa-home"></i></span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Household Registered</span>
                                    <span class="info-box-number" id="householdPercentage"></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xs-6">
                            <div class="info-box bg-white">
                                <span class="info-box-icon bg-green"><i class="fa fa-users"></i></span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Population Registered</span>
                                    <span class="info-box-number" id="populationPercentage"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>-->
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
                <h2 class="viewTitle"><span class="label label-default"></span></h2>
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
    function nullZero(value) {
        if (value == "null" || value == null) {
            return 0;
        } else {
            return value;
        }
    }
    $(function () {
        $.pc = {
            title: "Population characteristics",
            baseURL: "population-statistics",
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
                    $.pc.events.populationChartViewType();
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
                        if (area.divid == "") {
                            $.toast('Please select division', 'error')();
                            return false;
                        } else if (area.zillaid == "") {
                            $.toast('Please select district', 'error')();
                            return;
                        } else if (area.level == undefined) {
                            $.toast('Please select level', 'error')();
                            return;
                        } else if (area.endDate == "") {
                            $.toast('Please select date', 'error')();
                            return;
                        }
                        $.pc.ajax.viewData(area);
                    });
                },
                populationChartViewType: function () {
                    $('input[type=radio][name=chartViewType]').change(function () {
                        $("#populationBySex, #populationByAgeGroup").next("span").removeClass("view-active").addClass("view-inactive");
                        $.pc.chartId.html("");
                        $.pc.chartData = [];
                        $("#" + this.value).next("span").removeClass("view-inactive").addClass("view-active");
                        var area = $.app.pairs('form');
                        var cal = new Calc($.pc.data);
                        var length = $.pc.data.length;
                        var viewType = $.pc.getViewType(area, 0);

                        if (this.value == 'populationBySex') {
                            $.each($.pc.data, function (i, o) {
                                var obj = {
                                    area: o[$.pc.getViewType(area, 1)] + " ( n=" + nullZero(o.number_of_population) + " )",
                                    male_percentage: $.app.isFloat(nullZero(o.male_percentage)),
                                    female_percentage: $.app.isFloat(nullZero(o.female_percentage))
                                }
                                $.pc.chartData.push(obj);
                            });
                            $.pc.chartData.push({
                                area: $.pc.getTotalText(area, 0) + " Total ( n=" + cal.sum.number_of_population + " )",
                                male_percentage: ((cal.sum.male_percentage) / length).toFixed(1),
                                female_percentage: ((cal.sum.female_percentage) / length).toFixed(1),
                            });

                        } else if (this.value == 'populationByAgeGroup') {
                            $.each($.pc.data, function (i, o) {
                                var obj = {
                                    area: o[$.pc.getViewType(area, 1)] + " ( n=" + nullZero(o.number_of_population) + " )",
                                    population_less_than_5: $.app.isFloat(nullZero(o.population_less_than_5)),
                                    population_between_5_9: $.app.isFloat(nullZero(o.population_between_5_9)),
                                    population_between_10_19: $.app.isFloat(nullZero(o.population_between_10_19)),
                                    population_between_20_29: $.app.isFloat(nullZero(o.population_between_20_29)),
                                    population_between_30_39: $.app.isFloat(nullZero(o.population_between_30_39)),
                                    population_between_40_49: $.app.isFloat(nullZero(o.population_between_40_49)),
                                    population_between_50_64: $.app.isFloat(nullZero(o.population_between_50_64)),
                                    population_grater_than_65: $.app.isFloat(nullZero(o.population_grater_than_65))
                                }
                                $.pc.chartData.push(obj);
                            });
                            $.pc.chartData.push({
                                area: $.pc.getTotalText(area, 0) + " Total ( n=" + cal.sum.number_of_population + " )",
                                population_less_than_5: ((cal.sum.population_less_than_5) / length).toFixed(1),
                                population_between_5_9: ((cal.sum.population_between_5_9) / length).toFixed(1),
                                population_between_10_19: ((cal.sum.population_between_10_19) / length).toFixed(1),
                                population_between_20_29: ((cal.sum.population_between_20_29) / length).toFixed(1),
                                population_between_30_39: ((cal.sum.population_between_30_39) / length).toFixed(1),
                                population_between_40_49: ((cal.sum.population_between_40_49) / length).toFixed(1),
                                population_between_50_64: ((cal.sum.population_between_50_64) / length).toFixed(1),
                                population_grater_than_65: ((cal.sum.population_grater_than_65) / length).toFixed(1)
                            });
                        }
                        $.chart.renderBar($.pc.chartId, $.pc.chartData, $.pc.chartLabel[this.value], $.pc.chartColor[this.value], 0);
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
                                    $.toast('No data found', 'error')();
                                    return;
                                }
                                $.PRS.resetSwitchBtn($.pc.title);
                                $.app.removeWatermark();
                                $.pc.resetChartViewType();
                                $('.viewTitle > .label-default').text($.pc.viewTitle[json.level] + "" + json.endDate);
                                $("#tableView").slideDown("slow");
                                $(".prs-info").slideDown("slow");
                                $("table").fadeIn(100);
                                //$.pc.setChartCanvasSize(response.data.length);
                                var cal = new Calc(data);
                                $.pc.resetTable();
                                $.pc.chartData = [];
                                var columns = [];
                                var isUnitWise = false, klass = "left";
                                var footer = "";
                                $.pc.chartId.html("");
                                var viewType = $.pc.getViewType(json, 0);
                                //viewType == "Unit" ? isUnitWise = true : isUnitWise = false;
                                if (viewType == "Unit") {
                                    isUnitWise = true;
                                    klass = "center";
                                }

                                if (json.level == "household") {
                                    $('.chartViewType').css('display', 'none');

                                    $.pc.tableHeader.append($.pc.getHouseholdHeader(viewType, isUnitWise, klass));
                                    $("#data-table").DataTable().clear();
                                    columns = [
                                        {
                                            orderable: false,
                                            searchable: false,
                                            data: null,
                                            defaultContent: '#'
                                        },
//                                        {data: $.pc.getViewType(json, 1), class: "viewLevel"},
                                        {data: function (d) {
                                                var unit = "";
                                                if (d.uname != undefined)
                                                    unit = "<br/>" + $.app.getAssignType(d.assign_type, 1);
                                                return d[$.pc.getViewType(json, 1)] + "" + unit;
                                            }, class: "viewLevel " + klass},
                                        {data: function (d) {
                                                return nullZero(d.number_of_hh);
                                            }},
                                        {data: function (d) {
                                                return $.app.isFloat(nullZero(d.avg_hh_size));
                                            }},
                                        {data: function (d) {
                                                return $.app.isFloat(nullZero(d.male_head_percentage));
                                            }},
                                        {data: function (d) {
                                                return $.app.isFloat(nullZero(d.female_head_percentage));
                                            }}
                                    ];
                                    footer = $.pc.getHouseholdFooter(cal, data.length, $.pc.getTotalText(json, 0));//Footer
                                    //Chart rendering
                                    $.each(data, function (i, o) {
                                        $.pc.chartData.push({
                                            area: o[$.pc.getViewType(json, 1)] + " ( n=" + nullZero(o.number_of_hh) + " )",
                                            male_head_percentage: $.app.isFloat(nullZero(o.male_head_percentage)),
                                            female_head_percentage: $.app.isFloat(nullZero(o.female_head_percentage))
                                        });
                                    });
                                    $.pc.chartData.push({area: $.pc.getTotalText(json, 0) + " Total ( n=" + cal.sum.number_of_hh + " )", male_head: ((cal.sum.male_head_percentage) / data.length).toFixed(1), female_head: ((cal.sum.female_head_percentage) / data.length).toFixed(1)});
                                    $.chart.renderBar($.pc.chartId, $.pc.chartData, $.pc.chartLabel['householdByHead'], $.pc.chartColor['householdByHead'], 0);

                                } else if (json.level == "population") {
                                    $('.chartViewType').css('display', 'block');

                                    $.pc.tableHeader.append($.pc.getPopulationHeader(viewType, isUnitWise, klass));
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
                                        {data: function (d) {
                                                return nullZero(d.number_of_population);
                                            }},
                                        {data: function (d) {
                                                return $.app.isFloat(nullZero(d.male_percentage));
                                            }},
                                        {data: function (d) {
                                                return $.app.isFloat(nullZero(d.female_percentage));
                                            }},
                                        {data: function (d) {
                                                return $.app.isFloat(nullZero(d.population_less_than_5));
                                            }},
                                        {data: function (d) {
                                                return $.app.isFloat(nullZero(d.population_between_5_9));
                                            }},
                                        {data: function (d) {
                                                return $.app.isFloat(nullZero(d.population_between_10_19));
                                            }},
                                        {data: function (d) {
                                                return $.app.isFloat(nullZero(d.population_between_20_29));
                                            }},
                                        {data: function (d) {
                                                return $.app.isFloat(nullZero(d.population_between_30_39));
                                            }},
                                        {data: function (d) {
                                                return $.app.isFloat(nullZero(d.population_between_40_49));
                                            }},
                                        {data: function (d) {
                                                return $.app.isFloat(nullZero(d.population_between_50_64));
                                            }},
                                        {data: function (d) {
                                                return $.app.isFloat(nullZero(d.population_grater_than_65));
                                            }}
                                    ];
                                    footer = $.pc.getPopulationFooter(cal, data.length, $.pc.getTotalText(json, 0));//Footer
//                                    //Chart rendering
//                                    $.each(data, function (i, o) {
//                                        var obj = {
//                                            area: o[$.pc.getViewType(json, 1)],
//                                            population_less_than_5: $.app.isFloat(o.population_less_than_5),
//                                            population_between_5_9: $.app.isFloat(o.population_between_5_9),
//                                            population_between_10_19: $.app.isFloat(o.population_between_10_19),
//                                            population_between_20_29: $.app.isFloat(o.population_between_20_29),
//                                            population_between_30_39: $.app.isFloat(o.population_between_30_39),
//                                            population_between_40_49: $.app.isFloat(o.population_between_40_49),
//                                            population_between_50_64: $.app.isFloat(o.population_between_50_64),
//                                            population_grater_than_65: $.app.isFloat(o.population_grater_than_65)
//                                        }
//                                        $.pc.chartData.push(obj);
//                                    });
//                                    //$.pc.chartData.push({area: viewType + " Total", male_head: ((cal.sum.male_head_percentage) / data.length).toFixed(1), female_head: ((cal.sum.female_head_percentage) / data.length).toFixed(1)});
//                                    $.chart.renderBar($.pc.chartId, $.pc.chartData, $.pc.chartLabel['populationByAgeGroup'], $.pc.chartColor['populationByAgeGroup']);

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
//                                var options = {
//                                    rowCallback: function (r, d, i, idx) {
//                                        $('td', r).eq(0).html(idx + 1);
//                                    },
//                                    lengthMenu: [
//                                        [10, 20, 50, 100, -1],
//                                        ['10', '20', '50', '100', 'All']
//                                    ],
//                                    "pageLength": 20,
//                                    processing: true,
//                                    data: data,
//                                    columns: columns
//                                };
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
                    return $.pc.viewLevel[1][i];
                else if (json.unionid == "0")
                    return $.pc.viewLevel[2][i];
                else if (json.unitid == "0")
                    return $.pc.viewLevel[3][i];
                else
                    return $.pc.viewLevel[4][i];
            },
            getTotalText: function (json, i) {
                if (json.upazilaid == "0")
                    return $.pc.viewLevel[0][i];
                else if (json.unionid == "0")
                    return $.pc.viewLevel[1][i];
                else if (json.unitid == "0")
                    return $.pc.viewLevel[2][i];
                else
                    return $.pc.viewLevel[3][i];
            },
            resetTable: function () {
                $.pc.tableHeader.empty();
                $.pc.tableBody.empty();
                $.pc.tableFooter.empty();
            },
            getHouseholdHeader: function (viewType, isUnitWise, klass) {
                return '<tr id="tableRow">\
                            <th rowspan="2">#</th>\
                            <th rowspan="2" class="viewLevel" style="text-align:' + klass + '">' + viewType + '</th>' + $.pc.getProviderHead(isUnitWise) + '\
                            <th rowspan="2">Household (n)</th>\
                            <th rowspan="2">Average household size</th>\
                            <th colspan="2" class="center colspan">Household head</th>\
                        </tr>\
                        <tr id="tableRow">\
                            <th>Male head (%)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                            <th>Female head (%)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                        </tr>';
            },
            getPopulationHeader: function (viewType, isUnitWise, klass) {
                return '<tr id="tableRow">\
                            <th rowspan="2">#</th>\
                            <th rowspan="2" class="viewLevel" style="text-align:' + klass + '">' + viewType + '</th>' + $.pc.getProviderHead(isUnitWise) + '\
                            <th colspan="3" class="center colspan">Population</th>\
                            <th colspan="8" class="center colspan">% of population by age group (in years)</th>\
                        </tr>\
                        <tr id="tableRow">\
                            <th>Total (n)</th>\
                            <th>Male (%)</th>\
                            <th>Female (%)</th>\
                            <th><5</th>\
                            <th>5-9</th>\
                            <th>10-19</th>\
                            <th>20-29</th>\
                            <th>30-39</th>\
                            <th>40-49</th>\
                            <th>50-64</th>\
                            <th>65+</th>\
                        </tr>';
            },
            getHouseholdFooter: function (json, length, type) {
                var colspan = 2;
                if (type == "Unit" || type == "Union")
                    colspan = 3;
                return '<tfoot id="tableFooter">\n<tr class="bold">\
                                <td style="text-align:left" colspan="' + colspan + '">' + type + ' Total</td>\
                                <td>' + json.sum.number_of_hh + '</td>\
                                <td>' + ((json.sum.avg_hh_size) / length).toFixed(1) + '</td>\
                                <td>' + ((json.sum.male_head_percentage) / length).toFixed(1) + '</td>\
                                <td>' + ((json.sum.female_head_percentage) / length).toFixed(1) + '</td>\
                        </tr>\n</tfoot>';
            },
            getPopulationFooter: function (json, length, type) {
                var colspan = 2;
                if (type == "Unit" || type == "Union")
                    colspan = 3;
                return '<tfoot id="tableFooter">\n<tr class="bold">\
                                <td style="text-align:left" colspan="' + colspan + '">' + type + ' Total</td>\
                                <td>' + json.sum.number_of_population + '</td>\
                                <td>' + ((json.sum.male_percentage) / length).toFixed(1) + '</td>\
                                <td>' + ((json.sum.female_percentage) / length).toFixed(1) + '</td>\
                                <td>' + ((json.sum.population_less_than_5) / length).toFixed(1) + '</td>\
                                <td>' + ((json.sum.population_between_5_9) / length).toFixed(1) + '</td>\
                                <td>' + ((json.sum.population_between_10_19) / length).toFixed(1) + '</td>\
                                <td>' + ((json.sum.population_between_20_29) / length).toFixed(1) + '</td>\
                                <td>' + ((json.sum.population_between_30_39) / length).toFixed(1) + '</td>\
                                <td>' + ((json.sum.population_between_40_49) / length).toFixed(1) + '</td>\
                                <td>' + ((json.sum.population_between_50_64) / length).toFixed(1) + '</td>\
                                <td>' + ((json.sum.population_grater_than_65) / length).toFixed(1) + '</td>\
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
            getProviderHead: function (isUnitWise) {
                var providerHead = "";
                if (isUnitWise)
                    providerHead = '<th rowspan="2">Provider</th>';
                return providerHead;
            },
            viewTitle: {
                household: 'Characteristics of registered household up to ',
                population: 'Characteristics of registered population by sex and age group up to  ',
            },
            setChartCanvasSize: function (jsonLen) {
                $('#chartCanvas').removeAttr('class').attr('class', '');
                if (jsonLen == 1 || jsonLen == 2 || jsonLen == 3 || jsonLen == 4)
                    $('#chartCanvas').addClass("col-md-6 col-md-offset-3");
                else if (jsonLen == 5 || jsonLen == 6 || jsonLen == 7 || jsonLen == 8)
                    $('#chartCanvas').addClass("col-md-8 col-md-offset-2");
                else
                    $('#chartCanvas').addClass("col-md-12");
            },
            resetChartViewType: function () {
                $("#populationBySex, #populationByAgeGroup").next("span").removeClass("view-active").addClass("view-inactive");
                $("#populationBySex, #populationByAgeGroup").prop("checked", false);
            },
            chartLabel: {
                populationBySex: ['Male', 'Female'],
                populationByAgeGroup: ['<5', '5-9', '10-19', '20-29', '30-39', '40-49', '50-64', '65+'],
                householdByHead: ['Male head', 'Female head']
            },
            chartColor: {
                populationBySex: ["#95CEFF", "#434348"],
                populationByAgeGroup: ['#AD312B', '#EB667B', '#347672', '#53B4A9', '#8189BA', '#4D4888', '#DC83AF', '#B52980'],
                householdByHead: ["#95CEFF", "#434348"],
            }
        };//end prs
        $.pc.init();
    });
</script>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<%@include file="/WEB-INF/jspf/DataTableExportResource.jspf" %>