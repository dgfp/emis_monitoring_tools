<%-- 
    Document   : PRSCoverage
    Created on : Aug 25, 2019, 3:10:19 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/dropdown_loader_prs.js" type="text/javascript"></script>
<!--<script src="resources/TemplateJs/Chart.bundle.js" type="text/javascript"></script>-->
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
    /*    #mapView, #graphView, #tableView, .prs-info, #areaPanel{
            display: none;
        }*/
    .numeric_field{
        text-align: right;
    }
    .info-box-text{
        text-transform: capitalize;
    }
    td, th {
        border:none;
    }
</style>
<script>
    $(function () {
        $('#provtypeWise').on('change', function () {
            $('label[for=provtypeWise]').toggleClass('checked');
            $("#providerwise").val() == "0" ? $("#providerwise").val(1) : $("#providerwise").val(0);
        });
        var $clickable = $('.clickable').on('click', function (e) {
            var $target = $(e.currentTarget);
            var index = $clickable.index($target)
            $clickable.removeClass('selected-color');
            $target.toggleClass('selected-color');
            if (index == 0) {
                $("#graphView").fadeOut(100);
                $("#tableView").fadeIn(100);
            } else if (index == 1) {
                $("#tableView").fadeOut(100);
                $("#graphView").fadeIn(100);
            } else {
            }
        });
    })
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>Progress of Population Registration<small></small></h1>
</section>
<!-- Main content -->
<section class="content">
    <div class="row"  id="areaPanel">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-body" id="a">
                    <form action="prs-coverage" method="post" id="showData">
                        <!--                        <input type="hidden" name="providerwise" id="providerwise" value="0" />-->
                        <div class="row">
                            <div class="col-md-1 col-xs-2">
                                <label for="division">Division</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="divid" id="divid"><option value="">- Select Division -</option></select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="zilla">District</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="zillaid" id="zillaid"><option value="">- Select District -</option></select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="upazila">Upazila</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="upazilaid" id="upazilaid"><option value="">- Select Upazila -</option></select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="union">Union</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="unionid" id="unionid"><option value="">- Select Union -</option></select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-1 col-xs-2">
                                <label for="startDate">From</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <input type="text" name="startDate" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" id="startDate1" readonly="readonly" style="background-color: rgb(255, 255, 255);">
                            </div>
                            <div class="col-md-1 col-xs-2">
                                <label for="endDate">To</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <input type="text" name="endDate" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" id="endDate1" readonly="readonly" style="background-color: rgb(255, 255, 255);">
                            </div>
                            <!--                            <div class="col-md-1 col-xs-2">
                                                            <label for="provtypeWise" class="center" style="line-height:1em;">Provider Wise?</span>
                                                        </div>
                                                        <div class="col-md-2 col-xs-4">
                                                            <input type="checkbox" name="provtypeWise" id="provtypeWise" class="hidden">
                                                            <select class="form-control" name="provtype" id="provtype">
                                                                <option value="%">All</option>
                                                                <option value="2">HA</option>
                                                                <option value="3">FWA</option>
                                                            </select>
                                                        </div>-->
                            <div class="col-md-2 col-xs-4 col-md-offset-1 col-xs-offset-2">        
                                <button type="submit" class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                    Show data
                                </button>
                                <!--                                <button type="button" id="btn-data" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block" autocomplete="off" >
                                                                    <b><i class="fa fa-table" aria-hidden="true"></i> Show data</b>
                                                                </button>-->
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row info-box-md-container prs-info">
        <div class="col-md-6">
            <div class="row">
                <div class="col-md-6">
                    <div class="info-box bg-white">
                        <span class="info-box-icon bg-yellow"><i class="fa fa-home"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">Household Registered</span>
                            <span class="info-box-number" id="householdPercentage"></span>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="info-box bg-white">
                        <span class="info-box-icon bg-green"><i class="fa fa-users"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">Population Registered</span>
                            <span class="info-box-number" id="populationPercentage"></span>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="col-md-6">
            <div class="row">
                <div class="col-md-6">
                    <div class="info-box bg-white selected-color clickable">
                        <span class="info-box-icon bg-aqua"><i class="fa fa-table"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text"><h4></h4></span>
                            <span class="info-box-number center">Table</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="info-box bg-white clickable">
                        <span class="info-box-icon bg-aqua"><i class="fa fa-pie-chart"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text"><h4></h4></span>
                            <span class="info-box-number center">Chart</span>
                        </div>
                    </div>
                </div>
                <!--                <div class="col-md-4">
                                    <div class="info-box bg-white clickable">
                                        <span class="info-box-icon bg-aqua"><i class="fa fa-map-o"></i></span>
                                        <div class="info-box-content">
                                            <span class="info-box-text"><h4></h4></span>
                                            <span class="info-box-number center">Map</span>
                                        </div>
                                    </div>
                                </div>-->
            </div>
        </div>
    </div>
    <!--PRS Data Table-->
    <div class="box box-primary full-screen" id="tableView">
        <div class="box-header with-border" style="padding: 0px;">
            <p class="box-title" style="font-size: 15px;padding: 5px;bold">Tabular Presfentation</p>
            <div class="box-tools pull-right" style="margin-top: -10px;">
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body">           
            <div class="col-ld-12">

                <div class="table-responsive no-padding">
                    <table id="data-table" class="table table-bordered table-striped table-hover">
                        <thead id="tableHeader">
                            <tr>
                                <th colspan="2"></th>
                                <th colspan="3" class="colspan center">Household</th>
                                <th colspan="3" class="colspan center">Population</th>
                            </tr>
                            <tr>
                                <th>#</th>
                                <th><span id="viewLevel"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                <th class="numeric_field">Census 2011</th>
                                <th class="numeric_field">Registered</th>
                                <th class="numeric_field progressHH">Progress(%)</th>
                                <th class="numeric_field">Census 2011</th>
                                <th class="numeric_field">Registered</th>
                                <th class="numeric_field progressPOP">Progress(%)</th>
                            </tr>
                        </thead>
                        <tbody id="tableBody">
                        </tbody>
                        <tfoot id="tableFooter">
                        </tfoot>
                    </table>
                </div>


                <div class="table-responsive fixed" >
                    <table class="table table-bordered table-striped table-hover" id="data-table">
                        <thead id="tableHeader" class="data-table">
                            <tr>
                                <th colspan="2"></th>
                                <th colspan="3" class="colspan center">Household</th>
                                <th colspan="3" class="colspan center">Population</th>
                            </tr>
                            <tr>
                                <th>#</th>
                                <th><span id="viewLevel"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                <th class="numeric_field">Census 2011</th>
                                <th class="numeric_field">Registered</th>
                                <th class="numeric_field progressHH">Progress(%)</th>
                                <th class="numeric_field">Census 2011</th>
                                <th class="numeric_field">Registered</th>
                                <th class="numeric_field progressPOP">Progress(%)</th>
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
    <!--PRS Data Chart-->
    <div class="box box-primary full-screen" id="graphView">
        <div class="box-header with-border" style="padding: 0px;">
            <p class="box-title" style="font-size: 15px;padding: 5px;bold">Graphical Presentation</p>
            <div class="box-tools pull-right" style="margin-top: -10px;">
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body" id="printChart">
            <div class="table-responsive" >
                <div id="chart"></div>
                <br/>
            </div>
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
        $.prs = $.prs || {
            baseURL: "prs-coverage",
            divid: "#divid",
            zillaid: "#zillaid",
            upazilaid: "#upazilaid",
            unionid: "#unionid",
            area: null,
            viewType: null,
            tableHeader: $('#tableHeader'),
            tableBody: $('#tableBody'),
            tableFooter: $('#tableFooter'),
            householdProgress: 0,
            populationProgress: 0,
            index: 0,
            init: function () {
                $.prs.events.bindEvent();
                $("#areaPanel").slideDown("slow");
                $("#areaPanel").after($.app.getWatermark());
            },
            events: {
                bindEvent: function () {
                    $.prs.events.viewData();
                },
                viewData: function () {
                    $(document).off('submit', '#showData').on('submit', '#showData', function (e) {
                        e.preventDefault();
                        $.prs.index = 0;
//                        $.prs.tableHeader.empty();
//                        $.prs.tableBody.empty();
//                        $.prs.tableFooter.empty();

                        $("#tableView").fadeOut(200);
                        $("#graphView").fadeOut(200);
                        $(".prs-info").fadeOut(200);
                        var area = $.app.pairs('form');
                        if (area.divid == "") {
                            $.toast('Please select division', 'error')();
                            return false;
                        }
                        $.prs.ajax.viewData(area);
                    });
                }
            },
            ajax: {
                viewData: function (json) {
                    $.ajax({
                        url: $.prs.baseURL + "?viewType=" + $.prs.getViewType(json, 0),
                        type: "POST",
                        data: {prs: JSON.stringify(json)},
                        success: function (response) {


                            response = JSON.parse(response);
                            console.log(response);
                            if (response.success == true) {
                                $.app.removeWatermark();
                                $("#tableView").slideDown("slow");
                                $(".prs-info").slideDown("slow");
                                $.chart.renderPrsBarChart(response.data, $("#chart"), 2);
                                $.prs.tableHeader.html($.prs.getTableHeader($.prs.getViewType(json, 0)));
                                var cal = new Calc(response.data);
                                $.prs.householdProgress = Math.round(finiteFilter(cal.sum.household_rgistered / cal.sum.estimated_household) * 100)
                                $.prs.populationProgress = Math.round(finiteFilter(cal.sum.population_registered / cal.sum.estimated_population) * 100)
                                $('#householdPercentage').text($.prs.householdProgress + " %");
                                $('#populationPercentage').text($.prs.populationProgress + " %");
                                var columns = [
                                    {data: function (d) {
                                            $.prs.index += 1;
                                            return $.prs.index;
                                        }},
                                    {data: $.prs.getViewType(json, 1)},
                                    {data: "estimated_household", class: "right"},
                                    {data: "household_rgistered", class: "right"},
//                                    {data: function (d) {
//                                            var v = d.progress_hh ? d.progress_hh.toFixed(1) : 0;
//                                            return v;
//                                        }, class: "right"},
                                    {data: "estimated_population", class: "right"},
                                    {data: "population_registered", class: "right"}
//                                    {data: function (d) {
//                                            var v = d.progress_population ? d.progress_population.toFixed(1) : 0;
//                                            return v;
//                                        }, class: "right"},
                                ]
                                var startDate = json.startDate == "" ? true : false;
                                if (startDate) {
                                    console.log("Here");

                                    columns.splice(4, 0, {data: function (d) {
                                            var v = d.progress_hh ? d.progress_hh.toFixed(1) : 0;
                                            return v;
                                        }, class: "right"});
                                    columns.splice(7, 0, {data: function (d) {
                                            var v = d.progress_population ? d.progress_population.toFixed(1) : 0;
                                            return v;
                                        }, class: "right"});
                                } else {
                                    $(".colspan").attr('colspan', 2);
                                    $(".progressHH").hide();
                                    $(".progressPOP").hide();
                                }

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
                                            title: '<center class="dt-title">abc</center>',
                                            filename: 'pdf_MIS2_approval+status'
                                        },
                                        {
                                            extend: 'excelHtml5',
                                            text: '<i class="fa fa-file-excel-o" aria-hidden="true"></i> Excel',
                                            title: "XYZ",
                                            filename: 'excel_MIS2_approval+status'
                                        },
                                        {extend: 'pageLength'}
                                    ],
                                    processing: true,
                                    data: response.data,
                                    columns: columns
                                };
                                $('#data-table').DataTable().destroy();
                                $('#data-table').dt(options);
                                $.prs.tableFooter.html($.prs.getTableFooter(cal));
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
                1: ["District", "zilanameeng"],
                2: ["Upazila", "upazilanameeng"],
                3: ["Union", "unionnameeng"],
                4: ["Union", "unionnameeng"]
            },
            getViewType: function (json, i) {
                if (json.zillaid == "0")
                    return $.prs.viewLevel[1][i];
                else if (json.upazilaid == "0")
                    return $.prs.viewLevel[2][i];
                else if (json.unionid == "0")
                    return $.prs.viewLevel[3][i];
                else
                    return $.prs.viewLevel[4][i];
            },
            getTableHeader: function (level) {
                return '<tr>'
                        + '<th colspan="2"></th>'
                        + '<th colspan="3" class="colspan">Household</th>'
                        + '<th colspan="3" class="colspan">Population</th>'
                        + '</tr>'
                        + '<tr>'
                        + '<th>#</th>'
                        + '<th>' + level + '</th>'
                        + '<th class="numeric_field">Census 2011</th>'
                        + '<th class="numeric_field">Registered</th>'
                        + '<th class="numeric_field progressHH">Progress(%)</th>'
                        + '<th class="numeric_field">Census 2011</th>'
                        + '<th class="numeric_field">Registered</th>'
                        + '<th class="numeric_field progressPOP">Progress(%)</th>'
                        + '</tr>';
            },
            getTableFooter: function (json) {
                return '<tr>\
                                <td style="text-align:left" colspan="2" rowspan="1">Total</td>\
                                <td class="numeric_field" rowspan="1" colspan="1">' + json.sum.estimated_household + '</td>\
                                <td class="numeric_field" rowspan="1" colspan="1">' + json.sum.household_rgistered + '</td>\
                                <td class="numeric_field progressHH" rowspan="1" colspan="1">' + $.prs.householdProgress + '</td>\
                                <td class="numeric_field" rowspan="1" colspan="1">' + json.sum.estimated_population + '</td>\
                                <td class="numeric_field" rowspan="1" colspan="1">' + json.sum.population_registered + '</td>\
                                <td class="numeric_field progressPOP" rowspan="1" colspan="1">' + $.prs.populationProgress + '</td>\
                        </tr>';
            }
        };//end prs
        $.prs.init();
    });
</script>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<%@include file="/WEB-INF/jspf/DataTableExportResource.jspf" %>