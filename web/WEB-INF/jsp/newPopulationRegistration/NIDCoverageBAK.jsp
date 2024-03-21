<%-- 
    Document   : NIDCoverage
    Created on : Apr 6, 2020, 3:48:14 AM
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
    .dataTables_filter > input{
        display: none;
        color: red;
    }


    .progress {
        height: 36px;
        background-color: #3A3A41!important;
    }
    .progress-bar-green, .progress-bar-success {
        background-color: #7CB5EC!important;
    }

    .progress {
        margin-bottom: 0px;
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
    <h1>Possession of National Identity (NID) Card<small></small></h1>
</section>
<!-- Main content -->
<section class="content">
    <%@include file="/WEB-INF/jspf/prsAreaPanel.jspf" %>
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
            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered table-striped table-hover" id="data-table">
                            <thead id="tableHeader">
                                <tr id="tableRow">
                                    <th>#</th>
                                    <th class="viewLevel"><span id="viewLevel"></span></th>
                                    <th class="numeric_field">Registered</th>
                                    <th class="numeric_field">Eligible(18+)</th>
                                    <th class="numeric_field">Have NID card (%)</th>
                                    <th class="numeric_field">Never had (%)</th>
                                    <th class="numeric_field">Lost (%)</th>
                                    <th class="numeric_field">Can’t locate (%)</th>
                                    <th class="numeric_field">Kept in other place (%)</th>
                                    <th class="numeric_field">Not citizen (%)</th>
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
            title: "Possession of Mobile phone",
            baseURL: "nid-coverage",
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
            withMobileProgress: 0,
            withoutMobileProgress: 0,
            dataTableLength: 0,
            init: function () {
                $.prs.events.bindEvent();
                //$("#areaPanel").slideDown("slow");
                //$("#areaPanel").after($.app.getWatermark());
            },
            events: {
                bindEvent: function () {
                    $.prs.events.viewData();
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
                        //$(".prsProgress").show();
                        var area = $.app.pairs('form');
                        if (area.divid == "") {
                            $.toast('Please select division', 'error')();
                            return false;
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

                                $.prs.setChartCanvasSize(response.data.length);
                                //var chartType = ((response.data.length == 1) ? 'pie' : 'bar');
                                //$.chart.renderMobileChart(response.data, $("#chart"), $.prs.getViewType(json, 2), chartType);
                                
                                if (response.data.length == 1) {
                                    $.chart.renderPIE(response.data, $("#chart"), $.chart.NID);
                                } else {
                                    $.chart.NID.area = $.prs.getViewType(json, 1);
                                    $.chart.renderBAR(response.data, $("#chart"), $.chart.NID);
                                }
                                

                                //$.chart.renderMobileChart(json, chart, 1,'pie');
                                $("#viewLevel").text($.prs.getViewType(json, 0));

                                var cal = new Calc(response.data);
                                //$.prs.withMobileProgress = parseFloat((cal.sum.have_mobile_no / cal.sum.number_of_total_household * 100).toFixed(2));
                                $.prs.withMobileProgress = Math.round(finiteFilter(cal.sum.have_mobile_no / cal.sum.number_of_total_household) * 100);
                                //$.prs.withMobileProgress = (100 - parseFloat((cal.sum.have_mobile_no / cal.sum.number_of_total_household * 100).toFixed(2))).toFixed(2);
                                $.prs.withoutMobileProgress = (100 - $.prs.withMobileProgress);//Math.round(finiteFilter(cal.sum.have_mobile_no / cal.sum.number_of_total_household) * 100)

                                console.log($.prs.withMobileProgress, $.prs.withoutMobileProgress);

                                $('#withMobileProgress').text($.prs.withMobileProgress);
                                $('#withoutMobileProgress').text($.prs.withoutMobileProgress);
                                $('#progressbar').css('width', $.prs.withMobileProgress + '%');


                                var columns = [
                                    {
                                        orderable: false,
                                        searchable: false,
                                        data: null,
                                        defaultContent: '#'
                                    },
                                    {data: $.prs.getViewType(json, 1), class: "viewLevel"},
                                    {data: "registered", class: "right"},
                                    {data: "eligible", class: "right"},
                                    {data: function (d) {
                                            return parseFloat((d.havenid / d.eligible * 100).toFixed(1));
                                        }, class: "right prsProgress"},
                                    {data: function (d) {
                                            return parseFloat((d.dont_have / d.eligible * 100).toFixed(1));
                                        }, class: "right prsProgress"},
                                    {data: function (d) {
                                            return parseFloat((d.missing / d.eligible * 100).toFixed(1));
                                        }, class: "right prsProgress"},
                                    {data: function (d) {
                                            return parseFloat((d.not_found / d.eligible * 100).toFixed(1));
                                        }, class: "right prsProgress"},
                                    {data: function (d) {
                                            return parseFloat((d.other_place / d.eligible * 100).toFixed(1));
                                        }, class: "right prsProgress"},
                                    {data: function (d) {
                                            return parseFloat((d.not_citizen / d.eligible * 100).toFixed(1));
                                        }, class: "right prsProgress"},
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
                                    processing: true,
                                    data: response.data,
                                    columns: columns
                                };
                                $($.prs.dataTable).DataTable().destroy();
                                $($.prs.dataTable).dt(options);
                                $($.prs.dataTable).DataTable().draw();

                                //$("#data-table > tbody").after($.prs.getTableFooter(cal, $.prs.withMobileProgress, $.prs.withoutMobileProgress));
                                $("table").css("width", "100%");

                                setTimeout(function () {
                                    $(".viewLevel").click();
                                }, 500);

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
                2: ["Upazila", "upname", 2],
                3: ["Union", "uname", 3],
                4: ["Union", "uname", 3]
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
            getTableFooter: function (json, withMobileAVG, withoutMobileAVG) {
                return "<tfoot id='tableFooter'>\
                            <tr class='bold'>\
                                <td style='text-align:left' colspan='2'>Total</td>\
                                <td class='numeric_field'>" + json.sum.number_of_total_household + "</td>\
                                <td class='numeric_field'>" + withMobileAVG + "</td>\
                                <td class='numeric_field'>" + withoutMobileAVG + "</td>\
                            </tr>\
                        </tfoot>";
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
                if (jsonLen == 1)
                    $('#chartCanvas').addClass("col-md-4 col-md-offset-4");
                else if (jsonLen == 2 || jsonLen == 3 || jsonLen == 4)
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