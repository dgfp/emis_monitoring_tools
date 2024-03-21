<%-- 
    Document   : NonRegisteredClients
    Created on : Aug 25, 2019, 10:53:32 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/dropdown_loader_prs.js" type="text/javascript"></script>
<script src="resources/js/$.export.js" type="text/javascript"></script>
<link href="resources/notiflix/notiflix-1.9.1.min.css" rel="stylesheet"/>
<script src="resources/notiflix/notiflix-1.9.1.min.js" type="text/javascript"></script>
<script src="resources/js/$.PRS.js" type="text/javascript"></script>
<style>
    .notiflix-loading{
        background-color: blue;
    }
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
    #mapView, #graphView, #tableView, .prs-info, #areaPanel{
        display: none;
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
                $("table").fadeIn(100);
            } else if (index == 1) {
                $("#tableView").fadeOut(100);
                $("#graphView").fadeIn(100);
                $("table").fadeOut(100);
            } else {
            }
        });
    })
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>Non Registered Clients<small></small></h1>
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

                        <div class="row" id="dateBlock">
                            <div class="col-md-1 col-xs-2">
                                <label for="one" id="">Date</label>
                            </div>
                            <div class="col-md-1 col-xs-2">
                                <label for="startDate">From</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <input type="text" name="startDate" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" id="startDate" readonly="readonly" style="background-color: rgb(255, 255, 255);">
                            </div>
                            <div class="col-md-1 col-xs-2">
                                <label for="endDate">To</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <input type="text" name="endDate" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" id="endDate" readonly="readonly" style="background-color: rgb(255, 255, 255);">
                            </div>
                        </div>

                        <div class="row">
                            <span class="viewBtnBlock">
                                <div class="col-md-1 col-xs-2 btn-label col-md-offset-4 col-xs-offset-2">
                                    <label for="one" id=""></label>
                                </div>
                                <div class="col-md-2 col-xs-4">
                                    <button type="submit" class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                        <i class="fa fa-bar-chart" aria-hidden="true"></i>&nbsp; Show Data
                                    </button>
                                </div>
                            </span>
                        </div>

                        <!--                        <div class="row">
                                                    <div class="col-md-1 col-xs-2">
                                                        <label for="startDate">From</label>
                                                    </div>
                                                    <div class="col-md-2 col-xs-4">
                                                        <input type="text" name="startDate" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" id="startDate" readonly="readonly" style="background-color: rgb(255, 255, 255);">
                                                    </div>
                                                    <div class="col-md-1 col-xs-2">
                                                        <label for="endDate">To</label>
                                                    </div>
                                                    <div class="col-md-2 col-xs-4">
                                                        <input type="text" name="endDate" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" id="endDate" readonly="readonly" style="background-color: rgb(255, 255, 255);">
                                                    </div>
                                                    <div class="col-md-2 col-xs-4 col-md-offset-1 col-xs-offset-2">        
                                                        <button type="submit" class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                                            <i class="fa fa-area-chart" aria-hidden="true"></i> Show data
                                                        </button>
                                                    </div>
                                                </div>-->
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!--    <div class="row info-box-md-container prs-info">
            <div class="col-md-6">
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
            </div>
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

            <div class="row">
                <div class="col-md-10 col-md-offset-1">
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered table-striped table-hover" id="data-table">
                            <thead id="tableHeader">
                                <tr id="tableRow">
                                    <th>#</th>
                                    <th class="viewLevel"><span id="viewLevel"></span></th>
                                    <th class="center">Population</th>
                                    <th class="center">NRC</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>    



        </div>
    </div>
    <!--PRS Data Chart-->
    <div class="box box-primary full-screen" id="graphView">
        <div class="box-header with-border" style="padding: 0px;">
            <p class="box-title bold" style="font-size: 15px;padding: 2px;padding-left: 5px;"></p>
            <div class="box-tools pull-right" style="margin-top: -10px;">
                <button type="button" class="btn btn-flat btn-default btn-xs bold" id="exportPrintChart"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print - PDF</button>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body" id="printChart">
            <div class="row">
                <div class="col-md-12" id="chartCanvas">
                    <div id="chart"></div>
                </div>
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
            title: "Non Registered Clients",
            baseURL: "non-registered-clients",
            divid: "#divid",
            zillaid: "#zillaid",
            upazilaid: "#upazilaid",
            unionid: "#unionid",
            area: null,
            viewType: null,
            tableHeader: $('#tableHeader'),
            tableBody: $('#tableBody'),
            tableFooter: $('#tableFooter'),
            dataTable: $('#data-table'),
            householdProgress: 0,
            populationProgress: 0,
            dataTableLength: 0,
            init: function () {
                $.prs.events.bindEvent();
                //$("#areaPanel").slideDown("slow");
                //$("#areaPanel").after($.app.getWatermark());
            },
            events: {
                bindEvent: function () {
                    $.prs.events.viewData();
                    //$.prs.events.dataTableLength();
                    //$.prs.events.dataTablesFilter();
                    $.prs.events.exportPrint();
                    $.prs.events.exportCSV();
                    $.prs.events.exportPrintChart();
                },
                viewData: function () {
                    $(document).off('submit', '#showData').on('submit', '#showData', function (e) {
                        e.preventDefault();
                        $("#tableView").fadeOut(200);
                        $("#graphView").fadeOut(200);
                        $(".prs-info").fadeOut(200);
                        $("#tableFooter").remove();
                        $(".colspan").attr('colspan', 3);
                        $(".prsProgress").show();
                        var area = $.app.pairs('form');
                        if (area.divid == "") {
                            $.toast('Please select division', 'error')();
                            return false;
                        }
                        if (area.endDate == "") {
                            area.endDate = $.app.date().date;
                        }
                        $.prs.ajax.viewData(area);
                    });
                },
                exportPrint: function () {
                    $(document).off('click', '#exportPrint').on('click', '#exportPrint', function (e) {
                        $.prs.dataTableLength = $('select[name=data-table_length]').val();
                        $($.prs.dataTable).DataTable().page.len(-1).draw();
                        $.export.print($("#export").html(), $.prs.title, $.prs.getArea());
                    });
                },
                exportCSV: function () {
                    $(document).off('click', '#exportCSV').on('click', '#exportCSV', function (e) {
                        $.prs.dataTableLength = $('select[name=data-table_length]').val();
                        $($.prs.dataTable).DataTable().page.len(-1).draw();
//                        var outputFile = "eMIS_population_registration_coverage";
//                        outputFile = outputFile.replace('.csv', '') + '.csv';
//                        exportTableToCSV.apply(this, [$('table'), outputFile]); //function call from TemplateHeader
                        $.export.excel($.prs.dataTable);
                    });
                },
                exportPrintChart: function () {
                    $(document).off('click', '#exportPrintChart').on('click', '#exportPrintChart', function (e) {
                        $.export.printChart($.prs.title, $.prs.getArea());
                    });
                }
            },
            ajax: {
                viewData: function (json) {
                    console.log(JSON.stringify(json));
                    $.ajax({
                        url: $.prs.baseURL + "?viewType=" + $.prs.getViewType(json, 0),
                        type: "POST",
                        data: {prs: JSON.stringify(json)},
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response);
                            if (response.success == true) {
                                $.PRS.resetSwitchBtn($.prs.title);
                                $.app.removeWatermark();
                                $("#tableView").slideDown("slow");
                                $(".prs-info").slideDown("slow");
                                $("table").fadeIn(100);
                                //$.prs.setChartCanvasSize(response.data.length);
                                //$.chart.renderPrsBarChart(response.data, $("#chart"), $.prs.getViewType(json, 2));
                                $("#viewLevel").text($.prs.getViewType(json, 0));

                                var cal = new Calc(response.data);
//                                $.prs.householdProgress = Math.round(finiteFilter(cal.sum.household_rgistered / cal.sum.estimated_household) * 100)
//                                $.prs.populationProgress = Math.round(finiteFilter(cal.sum.population_registered / cal.sum.estimated_population) * 100)
//                                $('#householdPercentage').text($.prs.householdProgress + " %");
//                                $('#populationPercentage').text($.prs.populationProgress + " %");
                                var columns = [
                                    {
                                        orderable: false,
                                        searchable: false,
                                        data: null,
                                        defaultContent: '#'
                                    },
//                                    {data: function (d) {
//                                            return ++$.prs.index;
//                                        }},
                                    {data: $.prs.getViewType(json, 1), class: "viewLevel"},
                                    {data: "progress_population", class: "right"},
                                    {data: "non_registered_client", class: "right"},
//                                    {data: function (d) {
//                                            var v = d.progress_hh ? d.progress_hh.toFixed(1) : 0;
//                                            return v;
//                                        }, class: "right prsProgress"},
//                                    {data: "estimated_population", class: "right"},
//                                    {data: "population_registered", class: "right"},
//                                    {data: function (d) {
//                                            var v = d.progress_population ? d.progress_population.toFixed(1) : 0;
//                                            return v;
//                                        }, class: "right prsProgress"},
                                ]
                                var options = {
                                    rowCallback: function (r, d, i, idx) {
                                        $('td', r).eq(0).html(idx + 1);
                                    },
                                    lengthMenu: [
                                        [10, 25, 50, 100, -1],
                                        ['10', '25', '50', '100', 'All']
                                    ],
                                    fixedHeader: true,
//                                    dom: 'Bfrtip',
//                                    buttons: [
//                                        {
//                                            extend: 'print',
//                                            text: ' <i class="fa fa-print" aria-hidden="true"></i> Print / PDF',
//                                            title: 'Progress of Population Registration',
//                                            messageTop: 'The information in this table is copyright to Sirius Cybernetics Corp.',
//                                            filename: 'pdf_Progress_of_Population_Registration',
//                                        },
//                                        {
//                                            extend: 'excelHtml5',
//                                            text: '<i class="fa fa-file-excel-o" aria-hidden="true"></i> Excel',
//                                            title: "Progress of Population Registration",
//                                            filename: 'excel_Progress_of_Population_Registration+status'
//                                        },
//                                        {extend: 'pageLength'}
//                                    ],
                                    processing: true,
                                    data: response.data,
                                    columns: columns
                                };
                                $($.prs.dataTable).DataTable().destroy();
                                $($.prs.dataTable).dt(options);
                                $($.prs.dataTable).DataTable().draw();
                                //$(".viewLevel").click();

                                //$("#tableFooter").remove();
                                //$("#data-table > tbody").after($.prs.getTableFooter(cal));
//                                $("table").css("width", "100%");
//                                if (json.startDate != "") {
//                                    $.prs.dataTableLength = $('select[name=data-table_length]').val();
//                                    $($.prs.dataTable).DataTable().page.len(-1).draw();
//                                    $.prs.progressHide();
//                                    $($.prs.dataTable).DataTable().page.len($.prs.dataTableLength).draw();
//                                }
//                                setTimeout(function () {
//                                    $(".viewLevel").click();
//                                }, 500);

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
                1: ["District", "zillanameeng", 1],
                2: ["Upazila", "upazilanameeng", 2],
                3: ["Union", "unionnameeng", 3],
                4: ["Union", "unionnameeng", 3]
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
            getTableFooter: function (json) {
                return '<tfoot id="tableFooter">\n<tr class="bold">\
                                <td style="text-align:left" colspan="2">Total</td>\
                                <td class="numeric_field">' + json.sum.estimated_household + '</td>\
                                <td class="numeric_field">' + json.sum.household_rgistered + '</td>\
                                <td class="numeric_field prsProgress">' + $.prs.householdProgress + '</td>\
                                <td class="numeric_field">' + json.sum.estimated_population + '</td>\
                                <td class="numeric_field">' + json.sum.population_registered + '</td>\
                                <td class="numeric_field prsProgress">' + $.prs.populationProgress + '</td>\
                        </tr>\n</tfoot>';
            },
            progressHide: function () {
                $(".colspan").attr('colspan', 2);
                $(".prsProgress").hide();
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
            setChartCanvasSize: function (jsonLen) {
                $('#chartCanvas').removeAttr('class').attr('class', '');
                if (jsonLen == 1 || jsonLen == 2 || jsonLen == 3 || jsonLen == 4)
                    $('#chartCanvas').addClass("col-md-6 col-md-offset-3");
                else if (jsonLen == 5 || jsonLen == 6 || jsonLen == 7 || jsonLen == 8)
                    $('#chartCanvas').addClass("col-md-8 col-md-offset-2");
                else
                    $('#chartCanvas').addClass("col-md-12");
            }
        };//end prs
        $.prs.init();
    });
</script>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<%@include file="/WEB-INF/jspf/DataTableExportResource.jspf" %>