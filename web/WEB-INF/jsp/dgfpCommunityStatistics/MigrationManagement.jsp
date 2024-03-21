<%-- 
    Document   : MigrationManagement
    Created on : Mar 19, 2020, 10:57:07 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_migration_management.js"></script>
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
    #unitDiv, #villDiv, #household-data-table, #population-data-table {
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
        $('input[type=radio][name=level]').change(function () {
            $("#aggregate, #individual").next("span").removeClass("type-active").addClass("type-inactive");
            $("#" + this.value).next("span").removeClass("type-inactive").addClass("type-active");
        });
    })
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>Status of pending migration<small></small></h1>
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
                        </div>
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
    $(function () {
        $.pc = {
            title: "Status of pending migration",
            baseURL: "migration-management",
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
                    //$.pc.events.sortMethod();
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
                $.PRS.resetSwitchBtn($.pc.title);
                $.app.removeWatermark();
                $('.viewTitle > .label-default').text($.pc.viewTitle[json.level]);
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

                if (json.level == "aggregate") {
                    $.pc.tableHeader.append($.pc.getAggregateHeader(viewType, isUnitWise, klass));
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
                        {data: "pending_migration_in"},
                        {data: function (d) {
                                return "0";
                            }},
                        //{data: "pending_migration_out"},
                        {data: "pending_migration_in"}
                    ];
                    console.log("Fourth");
                    footer = $.pc.getAggregateFooter(cal, data.length, $.pc.getTotalText(json, 0));//Footer

                } else if (json.level == "individual") {
                    $.pc.tableHeader.append($.pc.getIndividualHeader());
                    $("#data-table").DataTable().clear();
                    columns = [
                        {
                            orderable: false,
                            searchable: false,
                            data: null,
                            defaultContent: '#'
                        },
                        {data: "nameeng"},
                        {data: function (d) {
                                if (d.fathername == null || d.fathername == 'null' || d.fathername == "") {
                                    return "-";
                                } else {
                                    return d.fathername;
                                }
                            }},

                        {data: "age"},
                        {data: function (d) {

                                if (d.sex == 1)
                                    return "Male";
                                else
                                    return "Female";

                            }},
                        {data: function (d) {
                                if (d.mobileno == null || d.mobileno == 'null' || d.mobileno == "") {
                                    return "-";
                                } else {
                                    return "0" + d.mobileno;
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
                1: ["Upazila", "upazilanameeng", 1],
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
            getAggregateHeader: function (viewType, isUnitWise, klass) {
                return '<tr id="tableRow">\
                            <th>#</th>\
                            <th class="viewLevel" style="text-align:' + klass + '">' + viewType + '</th>' + $.pc.getProviderHead(isUnitWise) + '\
                            <th  class="center colspan">Pending migration in (n)</th>\
                            <th  class="center colspan">Pending migration out (n)</th>\
                            <th  class="center colspan">Total</th>\
                        </tr>';
            },
            getIndividualHeader: function () {
                return '<tr id="tableRow">\
                            <th>#</th>\
                            <th class="center colspan">Name</th>\
                            <th class="center colspan">Father/ Husband</th>\
                            <th class="center colspan">Age</th>\
                            <th class="center colspan">Gender</th>\
                            <th class="center colspan">Mobile</th>\
                        </tr>';
            },
            getAggregateFooter: function (json, length, type) {
                var colspan = 2;
                if (type == "Unit" || type == "Union")
                    colspan = 3;
                return '<tfoot id="tableFooter">\n<tr class="bold">\
                                <td style="text-align:left" colspan="' + colspan + '">' + type + ' Total</td>\
                                <td>' + json.sum.pending_migration_in + '</td>\
                                <td>0</td>\
                                <td>' + json.sum.pending_migration_in + '</td>\
                        </tr>\n</tfoot>';
            },
            getArea: function () {
                var area = "Division: " + $("#divid option:selected").text();
                area += "&nbsp; District: " + $("#zillaid option:selected").text();
                area += "&nbsp; Upazila: " + $("#upazilaid option:selected").text();
                area += "&nbsp; Union: " + $("#unionid option:selected").text();
                area += "&nbsp; Unit: " + $("#unit option:selected").text();
                return area;
            },
            getProviderHead: function (isUnitWise) {
                var providerHead = "";
                if (isUnitWise)
                    providerHead = '<th>Provider</th>';
                return providerHead;
            },
            viewTitle: {
                aggregate: 'Number of pending migration in/out',
                individual: 'List of individuals with pending migration in/out',
            }
        };//end prs
        $.pc.init();
    });
</script>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<%@include file="/WEB-INF/jspf/DataTableExportResource.jspf" %>