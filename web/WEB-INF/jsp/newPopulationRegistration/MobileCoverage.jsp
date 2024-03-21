<%-- 
    Document   : MobileCoverage
    Created on : Jun 18, 2020, 4:27:42 AM
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
    <h1>Status of mobile phone coverage at household level<small></small></h1>
</section>
<!-- Main content -->
<%@include file="/WEB-INF/jspf/prsSection.jspf" %>
<script>
    $(function () {
        $.Mobile = {
            title: "Status of mobile phone coverage at household level",
            baseURL: "mobile-phone-coverage",
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
                $.Mobile.events.bindEvent();
            },
            events: {
                bindEvent: function () {
                    $.Mobile.events.viewData();
                    //$.Mobile.events.populationChartViewType();
                    $.Mobile.events.exportPrint();
                    $.Mobile.events.exportCSV();
                    $.Mobile.events.exportPrintChart();
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
                        $.Mobile.ajax.viewData(area);
                    });
                },
                exportPrint: function () {
                    $(document).off('click', '#exportPrint').on('click', '#exportPrint', function (e) {
                        $.Mobile.dataTableLength = $('select[name=data-table_length]').val();
                        $($.Mobile.dataTable).DataTable().page.len(-1).draw();
                        $.export.print($("#export").html(), $.Mobile.title + "<br/>" + $('.viewTitle > .label').html(), $.Mobile.getArea());
                    });
                },
                exportCSV: function () {
                    $(document).off('click', '#exportCSV').on('click', '#exportCSV', function (e) {
                        $.Mobile.dataTableLength = $('select[name=data-table_length]').val();
                        $($.Mobile.dataTable).DataTable().page.len(-1).draw();
                        $.export.excel($.Mobile.dataTable);
                    });
                },
                exportPrintChart: function () {
                    $(document).off('click', '#exportPrintChart').on('click', '#exportPrintChart', function (e) {
                        $.export.printChart($.Mobile.title + "<br/>" + $('.viewTitle > .label').html(), $.Mobile.getArea());
                    });
                }
            },
            ajax: {
                viewData: function (json) {
                    $.ajax({
                        url: $.Mobile.baseURL + "?viewType=" + $.Mobile.getViewType(json, 0),
                        type: "POST",
                        data: {data: JSON.stringify(json)},
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response);
                            if (response.success == true) {
                                var data = response.data;
                                $.Mobile.data = response.data;
                                if (data.length === 0) {
                                    toastr['error']("No data found");
                                    return;
                                }
                                $('.chartViewType').css('display', 'block');
                                $.PRS.resetSwitchBtn($.Mobile.title);
                                $.app.removeWatermark();
                                $("#tableView").slideDown("slow");
                                $(".prs-info").slideDown("slow");
                                $("table").fadeIn(100);
                                var cal = new Calc(data);
                                $.Mobile.resetTable();
                                $.Mobile.chartData = [];
                                var columns = [];
                                var isUnitWise = false, klass = "left";
                                var footer = "";
                                $.Mobile.chartId.html("");
                                var viewType = $.Mobile.getViewType(json, 0);
                                if (viewType == "Unit") {
                                    isUnitWise = true;
                                    klass = "center";
                                }

                                if (json.level == "atPoint") {
                                    $('.viewTitle > .label-default').text($.Mobile.viewTitle[json.level] + "" + json.endDate);
                                    $.Mobile.tableHeader.append($.Mobile.getStatusUpToDateHeader(viewType, isUnitWise, klass));
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
                                                return d[$.Mobile.getViewType(json, 1)] + "" + unit;
                                            }, class: "viewLevel " + klass},

                                        {data: "eligible"},
                                        {data: function (d) {
                                                return $.app.isFloat(d.have_mobileno);
                                            }},
                                        {data: function (d) {
                                                return $.app.isFloat(d.do_not_have_mobileno);
                                            }}
                                    ];
                                    footer = $.Mobile.getStatusUpToDateFooter(cal, data.length, $.Mobile.getTotalText(json, 0));//Footer
                                    //Chart data preparing
                                    $.each(data, function (i, o) {
                                        $.Mobile.chartData.push({
                                            area: o[$.Mobile.getViewType(json, 1)] + " ( n=" + o.eligible + " )",
                                            have_mobileno: $.app.isFloat(o.have_mobileno),
                                            do_not_have_mobileno: $.app.isFloat(o.do_not_have_mobileno)
                                        });
                                    });
                                    $.Mobile.chartData.push({
                                        area: $.Mobile.getTotalText(json, 0) + " Total ( n=" + cal.sum.eligible + " )",
                                        have_mobileno: ((cal.sum.have_mobileno) / data.length).toFixed(1),
                                        do_not_have_mobileno: ((cal.sum.do_not_have_mobileno) / data.length).toFixed(1)
                                    });
                                    $.chart.renderBar($.Mobile.chartId, $.Mobile.chartData, $.Mobile.chartLabel['atPoint'], $.Mobile.chartColor['atPoint'], 100); //chart
                                    


                                } else if (json.level == "monthly") {
                                    $('.viewTitle > .label-default').text($.Mobile.viewTitle[json.level] + "" + json.startMonthYear + " and " + json.endMonthYear);
                                    var d = $.Mobile.processMonthlyData(data, $.Mobile.getViewType(json, 1));
                                    console.log(d);
                                    //Reset data after processing
                                    data = d.tableData;
                                    cal = new Calc(data);
                                    $.Mobile.tableHeader.append($.Mobile.getMonthlyHeader(viewType, isUnitWise, klass, d.tableHeader));
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
                                                return d[$.Mobile.getViewType(json, 1)] + "" + unit;
                                            }, class: "viewLevel " + klass},
                                        {data: "eligible"},
                                    ];
                                    $.each(d.months, function (index, value) {
                                        //var id = "month_" + index;
                                        columns.push({data: function (d) {
                                                return $.app.isFloat(d["month_" + index]);
                                            }});
                                    });
                                    footer = $.Mobile.getMonthlyFooter(cal, data.length, $.Mobile.getTotalText(json, 0), d.months);//Footer
                                    d.chartData.push($.Mobile.totalObj);
                                    $.chart.renderBar($.Mobile.chartId, d.chartData, d.chartLabel, $.Mobile.chartColor['monthly'], 100);
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
                    return $.Mobile.viewLevel[1][i];
                else if (json.unionid == "0")
                    return $.Mobile.viewLevel[2][i];
                else if (json.unitid == "0")
                    return $.Mobile.viewLevel[3][i];
                else
                    return $.Mobile.viewLevel[4][i];
            },
            getTotalText: function (json, i) {
                if (json.upazilaid == "0")
                    return $.Mobile.viewLevel[0][i];
                else if (json.unionid == "0")
                    return $.Mobile.viewLevel[1][i];
                else if (json.unitid == "0")
                    return $.Mobile.viewLevel[2][i];
                else
                    return $.Mobile.viewLevel[3][i];
            },
            resetTable: function () {
                $.Mobile.tableHeader.empty();
                $.Mobile.tableBody.empty();
                $.Mobile.tableFooter.empty();
            },
            getStatusUpToDateHeader: function (viewType, isUnitWise, klass) {
                var provider = isUnitWise ? '<th>Provider</th>' : '';
                return '<tr id="tableRow">\
                            <th>#</th>\
                            <th class="viewLevel" style="text-align:' + klass + '">' + viewType + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>' + provider + '\
                            <th>No. of household registered</th>\
                            <th>Have mobile phone (%)</th>\
                            <th>Do not have mobile phone (%)</th>\
                        </tr>';

            },
            getStatusUpToDateFooter: function (json, length, type) {
                var colspan = 2;
                if (type == "Unit" || type == "Union")
                    colspan = 3;
                return '<tfoot id="tableFooter">\n<tr class="bold">\
                                <td style="text-align:left" colspan="' + colspan + '">' + type + ' Total</td>\
                                <td>' + json.sum.eligible + '</td>\
                                <td>' + ((json.sum.have_mobileno) / length).toFixed(1) + '</td>\
                                <td>' + ((json.sum.do_not_have_mobileno) / length).toFixed(1) + '</td>\
                        </tr>\n</tfoot>';
            },
            getMonthlyHeader: function (viewType, isUnitWise, klass, th) {
                var provider = isUnitWise ? '<th>Provider</th>' : '';
                return '<tr id="tableRow">\
                            <th>#</th>\
                            <th class="viewLevel" style="text-align:' + klass + '">' + viewType + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>' + provider + '\
                            <th>No. of household registered</th>\
                            ' + th + '\
                        </tr>';

            },
            getMonthlyFooter: function (json, length, type, months) {
                $.Mobile.totalObj = {};
                $.Mobile.totalObj = {area: type + ' Total ( n=' + json.sum.eligible + ' )'};
                var th = "";
                $.each(months, function (i, v) {
                    $.Mobile.totalObj["month_" + i] = ((json.sum["month_" + i]) / length).toFixed(1);
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
                        tableDataObj["month_" + index] = row.have_mobileno;
                        //Chart data added here
                        chartDataObj["month_" + index] = row.have_mobileno;
                    });
                    response.tableData.push(tableDataObj);
                    response.chartData.push(chartDataObj);
                });
                return response;
            },
            viewTitle: {
                atPoint: "Percent distribution of mobile phone available in registered household up to ",
                monthly: "Percentage of registered household has at least one mobile phone between "
            },
            chartLabel: {
                atPoint: ['Have mobile phone', 'Do not have mobile phone']
            },
            chartColor: {
                atPoint: ['#7AB2EF', '#ff8989', '#e53232'],
                monthly: ['#EF3E69', '#F78D1F', '#FFC02D', '#49C1C0', '#5A86C5', '#0D8181', '#F16582', '#B1B5BE', '#7E69AE', '#9BCCED', '#DC84B7', '#B61C8C']
            }
        };
        $.Mobile.init();
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