<%-- 
    Document   : MIS1ApprovalStatusTest
    Created on : Jan 14, 2020, 4:07:01 PM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<link href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/reportingStatus.css" rel="stylesheet" type="text/css"/>
<!--<script src="resources/js/advance_workplan_view.js"></script>-->
<script src="resources/js/reporting_status.js"></script>
<script src="resources/js/$.misv9.js"></script>
<script src="resources/js/TemplateMIS.js" type="text/javascript"></script>
<script src="resources/js/monthYearLoader.js" type="text/javascript"></script>
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
</style>
<script>
</script>
<section class="content-header">
    <h1>MIS 1 approval status</h1>
</section>
<section class="content">
    <div class="row" id="areaPanel">
        <div class="col-md-12">
            <div class="box box-primary full-screen">
                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <form action="MonthlyAdvanceWorkplanDashboard" method="post" id="showData">
                        <input type="hidden" name="provtype" id="provtype" value="3">
                        <div class="row">
                            <div class="col-md-1 col-xs-2">
                                <label for="division">Division</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="divid" id="division"> </select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="zilla">District</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="zillaid" id="district"> 
                                    <option value="">- Select District -</option>
                                </select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="upazila">Upazila</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="upazilaid" id="upazila">
                                    <option value="">- Select Upazila -</option>
                                </select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="union">Union</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="unionid" id="union">
                                    <option value="">- Select Union -</option>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-1  col-xs-2">
                                <label for="year">Year</label>
                            </div>
                            <div class="col-md-2  col-xs-4">
                                <select class="form-control input-sm" name="year" id="year"> </select>
                            </div>
                            <div class="col-md-1  col-xs-2">
                                <label for="month">Month</label>
                            </div>
                            <div class="col-md-2  col-xs-4">
                                <select class="form-control input-sm" name="month" id="month">
                                </select>
                            </div>
                            <div class="col-md-1  col-xs-2">
                            </div>
                            <div class="col-md-2  col-xs-4">
                                <button type="submit" class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                    <i class="fa fa-area-chart" aria-hidden="true"></i> &nbsp;Show data
                                </button>
                            </div>
                        </div>
                    </form>
                    <span id="dashboard" class="cs"></span>
                    <span id="details">
                        <div class="col-md-12">
                            <h2 id="typeTitle"><span class="label label-default"></span></h2>
                            <div class="table-responsive no-padding">
                                <table id="data-table" class="table table-bordered table-striped table-hover">
                                    <thead id="tableHeader">
                                    </thead>
                                    <tbody id="tableBody">
                                    </tbody>
                                    <tfoot id="tableFooter">
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </span>
                </div>
            </div>
        </div>
    </div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script>
    $(function () {
        $.MIS1Status = $.MIS1Status || {
            formData: null,
            isCurrent: false,
            isPreTwoMonth: true,
            preMonth: null,
            preYear: null,
            modal: $("#modalReportView"),
            init: function () {
                $.data = $.app.date();
//                $.app.select.$year('select#year', range($.data.year, 2014, -1)).val($.data.year);
//                $.app.select.$month('select#month').val($.data.month);
//                $.app.hideNextMonths();
                $.MIS1Status.events.bindEvent();
                $(".full-screen").after($.app.getWatermark());
                //set Previous month year
                $.MIS1Status.preMonth = $.app.date().month == 1 ? 12 : $.app.date().month - 1;
                $.MIS1Status.preYear = $.app.date().month == 1 ? $.app.date().year - 1 : $.app.date().year;
                Template.init(1);
            },
            events: {
                bindEvent: function () {
                    $.MIS1Status.events.setUnit();
                    $.MIS1Status.events.viewStatus();
                    $.MIS1Status.events.viewProviderList();
                    $.MIS1Status.events.viewMIS1();
                },
                setUnit: function () {
                    $(document).off('change', '#union').on('change', '#union', function (e) {
                        $.MIS1Status.ajax.setUnit($(this).attr('id'));
                    });
                },
                viewStatus: function () {
                    $(document).off('submit', '#showData').on('submit', '#showData', function (e) {
                        e.preventDefault();
                        var pairs = Template.pairs();
                        var version = Template.getVersion(pairs.year, pairs.month);
                        Template.reset(version);
                        $("#details").css("display", "none");
                        var area = $.app.pairs('form');
                        if (area.divid == "") {
                            $.toast('Please select division', 'error')();
                            return false;
                        } else if (area.zillaid == "") {
                            $.toast('Please select district', 'error')();
                            return false;
                        }
                        $.MIS1Status.isPreTwoMonth = true;
                        $.MIS1Status.ajax.statusLoader(area);
                    });
                },
                viewProviderList: function () {
                    $(document).off('click', '.small-box-footer').on('click', '.small-box-footer', function (e) {
                        $.MIS1Status.ajax.getProviderList($(this).attr('id'));
                    });
                },
                viewMIS1: function () {
                    $(document).off('click', '.mis1-view').on('click', '.mis1-view', function (e) {
                        $.MIS1Status.ajax.getMIS1($(this).data("info"), $(this).data("prov"));
                    });
                }
            },
            ajax: {
                //totalProvider = 0 ,waiting =1, approved= 2, disapproved = 3, resubmitted = 4;
                statusLoader: function (area) {
                    $('#dashboard').empty();
                    $.ajax({
                        url: "mis1-approval-status-test?action=getStatus",
                        type: "POST",
                        data: {misStatus: JSON.stringify(area)},
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success == true) {
                                console.log(response);
                                $.MIS1Status.formData = area;
                                if ((($.MIS1Status.formData.year == $.data.year) && ($.MIS1Status.formData.month == $.data.month)))
                                    $.MIS1Status.isPreTwoMonth = false;
                                if ((($.MIS1Status.formData.month == $.MIS1Status.preMonth) && ($.MIS1Status.formData.year == $.MIS1Status.preYear)))
                                    $.MIS1Status.isPreTwoMonth = false;

                                var dashboard = "";
                                var item = [0, 4, 2, 1];
                                for (i of item) {
                                    dashboard += $.MIS1Status.misDashboard(i, response.data[0]);
                                }


//                                dashboard += $.MIS1Status.misDashboard(0, response.data[0].total_unit); // totalProvider
//                                dashboard += $.MIS1Status.misDashboard(4, response.data[0].submitted); //submitted
//                                dashboard += $.MIS1Status.misDashboard(2, response.data[0].approved); // approved
//                                dashboard += $.MIS1Status.misDashboard(1, (response.data[0].waiting)); //waiting

                                if (!$.MIS1Status.isPreTwoMonth)
                                    dashboard += $.MIS1Status.misDashboard(3, response.data[0]); //not submitted

                                $.app.removeWatermark();
                                $(dashboard).hide().appendTo("#dashboard").slideDown(500);
                                //$(dashboard).hide().appendTo("#dashboard").slideDown(500);
                            } else {
                                $(".full-screen").after($.app.getWatermark());
                                toastr['error']("Error occured while user load");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                },
                getProviderList: function (type) {
                    $.ajax({
                        url: "mis1-approval-status-test?action=getProviderList&viewType=" + type,
                        type: "POST",
                        data: {misStatus: JSON.stringify($.MIS1Status.formData)},
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success === true) {
                                console.log("json", response)
                                $("#details").css("display", "block");
                                var title = type == "0" ? $.MIS1Status.type[type] + " list" : $.MIS1Status.type[type] + " provider list";
                                var exportTitle = 'MIS 1 approval status  ( ' + title + ' - ' + $("#district option:selected").text().split("[")[0] + ')';
                                $('#typeTitle span').html(title);
                                var columns = [
                                    {data: function (d) {
                                            return d.upazilanameeng;
                                        }, title: '#', class: "slno"},
                                    {data: "upazilanameeng", title: 'Upazila'},
                                    {data: "unionnameeng", title: 'Union'},
                                    {data: function (d) {
                                            return d.uname + " [" + d.unit + "]";
                                        }, title: "Unit"},
                                    {data: function (d) {
                                            return $.app.getAssignType(d.assign_type, 1);
                                        }, title: "Unit type", class: "center type"},
//                                    {data: "providerid", title: 'Provider id'},
//                                    {data: "provname", title: 'Provider name'},
                                    {data: function (d) {
                                            var provname = (d.providerid === 5) ? "NGO" : "<b>" + d.provname + "</b>";
                                            return d.providerid + " - " + provname;
                                        }, title: "&nbsp;&nbsp;&nbsp;&nbsp;Provider&nbsp;&nbsp;&nbsp;&nbsp;", class: "prov"},
                                    {data: function (d) {
                                            //var mobileno = (d.mobileno === null) ? "-" : "0"+d.mobileno;
                                            return (d.mobileno === null) ? "-" : "0" + d.mobileno;
                                        }, title: "Mobile"},
                                    {data: function (d) {
                                            var json = JSON.stringify({"zillaid": d.zillaid, "providerid": d.providerid, "unit": d.unit, "provtype": 3, "month": d.month, "year": d.year});
                                            var action = "<a class='btn btn-flat btn-primary btn-xs mis1-view' id='" + d.providerid + "' data-info='" + json + "' data-prov='" + JSON.stringify({"provname": d.provname, "providerid": d.providerid, "assin_type": d.assign_type}) + "'><b> View MIS1</b></a>";
                                            action += $.MIS1Status.status[d.status];
                                            return action;
                                        }, title: "&nbsp;&nbsp;&nbsp;&nbsp;Action&nbsp;&nbsp;&nbsp;&nbsp;"}
                                ]
                                if ($.MIS1Status.isPreTwoMonth)
                                    columns.splice(3, 3);
                                if (type == 0 || type == 3)
                                    columns.pop();

                                var options = {
                                    rowCallback: function (r, d, i, idx) {
                                        $('td', r).eq(0).html(idx + 1);
                                    },
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
                                            filename: 'pdf_MIS2_approval+status'
                                        },
                                        {
                                            extend: 'excelHtml5',
                                            text: '<i class="fa fa-file-excel-o" aria-hidden="true"></i> Excel',
                                            title: exportTitle,
                                            filename: 'excel_MIS2_approval+status'
                                        },
                                        {extend: 'pageLength'}
                                    ],
                                    processing: true,
                                    data: response.data,
                                    columns: columns
                                };
                                $('#data-table').dt(options);
                                $.app.overrideDataTableBtn();
                            } else {
                                $("#details").css("display", "none");
                                toastr['error']("Error occured while dashboard loading");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                },
                getMIS1: function (json, provider) {
                    console.log(json);
                    console.log(provider);
                    $.ajax({
                        url: "mis1-approval-status-test?action=getMIS1",
                        type: "POST",
                        data: {misStatus: JSON.stringify(json)},
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success == true) {
                                $.MIS1Status.renderMIS1(response, provider);
                                $("#provider-info").html("<b> MIS 1 (FWA) - Provider: " + provider.provname + " - ID: " + provider.providerid + "</b>");
                                $.app.mis1PageColor(provider.assin_type);
                                $('#modalReportView').modal('show');
                            } else {
                                toastr['error']("Error occured while user load");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                },
                setUnit: function (unionid) {
                    $.ajax({
                        url: "FWAUnitJsonDataProviderForMISStatus",
                        data: {
                            districtId: $('#district').val(),
                            upazilaId: $('#upazila').val(),
                            unionId: $('#union').val()
                        },
                        type: 'POST',
                        success: function (response) {
                            response = JSON.parse(response);
                            var unit = $('#unit');
                            unit.find('option').remove();
                            $('<option>').val("").text('All').appendTo(unit);
                            for (var i = 0; i < response.length; i++) {
                                var id = response[i].ucode;
                                var name = response[i].uname;
                                $('<option>').val(id).text(name + ' [' + response[i].ucode + ']').appendTo(unit);
                            }
                        }
                    });
                },
            },
            type: {
                0: "FWA unit",
                10: "Total provider",
                1: "Waiting",
                2: "Approved",
                3: "Not submitted",
                4: "Submitted"
            },
//            misDashboard: function (type, d) {
//                //totalProvider = 0 ,waiting =1, approved= 2, disapproved = 3, resubmitted = 4;
//                var color = "", icon = "", xs = "col-xs-6", count = 0, aText = "&nbsp;", bText = "&nbsp;", aVal = "&nbsp;", bVal = "&nbsp;", bColor = "none";
//                switch (type) {
//                    case 0:
//                        var size = $.MIS1Status.isPreTwoMonth ? '2' : '1';
//                        icon = '<i class="fa fa-users" aria-hidden="true"></i>', xs = "col-xs-12 col-lg-offset-" + size;
//                        color = "bg-blue", aText = "Filled-up", bText = "Vacant", bColor = "#007fc9";
//                        count = d.total_unit, aVal = d.total_filled_up, bVal = d.total_vacant;
//                        break;
//                    case 2:
//                        icon = '<i class="fa fa-check-square-o" aria-hidden="true"></i>';
//                        color = "bg-green";
//                        count = d.approved;
//                        break;
//                    case 4:
//                        icon = '<i class="fa fa-list-alt" aria-hidden="true"></i>';
//                        color = "bg-yellow", aText = "Main", bText = "Additional", bColor = "#ffaa2b";
//                        count = d.submitted, aVal = d.submitted_main , bVal = d.submitted_additional;
//                        break;
//                    case 3:
//                        icon = '<i class="fa fa-window-close-o" aria-hidden="true"></i>';
//                        color = "bg-red", aText = "Main", bText = "Additional", bColor = "#ef5847";
//                        count = d.not_submitted, aVal = d.not_submitted_main, bVal = d.not_submitted_vacant;
//                        break;
//                    case 1:
//                        icon = '<i class="fa fa-clock-o" aria-hidden="true"></i>';
//                        color = "bg-aqua";
//                        count = d.waiting;
//                        break;
//                }
//                return '<div class="center col-lg-2 ' + xs + '">\
//                           <div class="small-box ' + color + '">\
//                             <div class="inner">\
//                               <h3>' + count + '</h3>\
//                               <p class="bold">' + $.MIS1Status.type[type] + '</p>\
//                             </div>\
//                             <div class="inner">\
//                               <div class="row">\
//                                    <div class="col-md-6 mb-0">\
//                                        <div class="breakdown" style="background-color:' + bColor + '">\
//                                            <p>' + aText + '</p>\
//                                            <h3>' + aVal + '</h3>\
//                                        </div>\
//                                    </div>\
//                                    <div class="col-md-6 mb-0">\
//                                        <div class="breakdown" style="background-color:' + bColor + '">\
//                                            <p>' + bText + '</p>\
//                                            <h3>' + bVal + '</h3>\
//                                        </div>\
//                                    </div>\
//                                </div>\
//                             </div>\
//                                <a href="#" id="' + type + '" class="small-box-footer">View details <i class="fa fa-arrow-circle-right"></i></a>\
//                           </div>\
//                         </div>';
//            },

            misDashboard: function (type, d) {
                //totalProvider = 0 ,waiting =1, approved= 2, disapproved = 3, resubmitted = 4;
                console.log(type, d);
                var item = {
                    text: $.MIS1Status.type[type],
                    leftText: "&nbsp",
                    rightText: "&nbsp",
                    count: "bg-blue",
                    leftCount: "&nbsp",
                    rightCount: "&nbsp",
                    bgColor: "",
                    bgColorLight: "none",
                    icon: "",
                    xs: "col-xs-6",
                }
                switch (type) {
                    case 0:
                        item.count = d.total_unit;
                        item.leftCount = d.total_filled_up;
                        item.rightCount = d.total_vacant;
                        item.leftText = 'Filled-up';
                        item.rightText = 'Vacant';
                        item.bgColor = 'bg-blue';
                        item.bgColorLight = '#007fc9';
                        item.icon = '<i class="fa fa-users" aria-hidden="true"></i>';
                        var size = ($.MIS1Status.isPreTwoMonth) ? '2' : '1';
                        item.xs = "col-xs-12 col-lg-offset-" + size;
                        break;

                    case 2:
                        item.count = d.approved;
                        item.bgColor = 'bg-green';
                        item.icon = '<i class="fa fa-check-square-o" aria-hidden="true"></i>';
                        break;

                    case 4:
                        item.count = d.submitted;
                        item.leftCount = d.submitted_main;
                        item.rightCount = d.submitted_additional;
                        item.leftText = 'Main';
                        item.rightText = 'Additional';
                        item.bgColor = 'bg-yellow';
                        item.bgColorLight = '#ffaa2b';
                        item.icon = '<i class="fa fa-list-alt" aria-hidden="true"></i>';
                        break;

                    case 3:
                        item.count = d.not_submitted;
                        item.leftCount = d.not_submitted_main;
                        item.rightCount = d.not_submitted_vacant;
                        item.leftText = 'Main';
                        item.rightText = 'Additional';
                        item.bgColor = 'bg-red';
                        item.bgColorLight = '#ef5847';
                        item.icon = '<i class="fa fa-window-close-o" aria-hidden="true"></i>';
                        break;

                    case 1:
                        item.count = d.waiting;
                        item.bgColor = 'bg-aqua';
                        item.icon = '<i class="fa fa-clock-o" aria-hidden="true"></i>';
                        break;
                }
                return '<div class="center col-lg-2 ' + item.xs + '">\
                           <div class="small-box ' + item.bgColor + '">\
                             <div class="inner">\
                               <h3>' + item.count + '</h3>\
                               <p class="bold">' + item.text + '</p>\
                             </div>\
                             <div class="inner">\
                               <div class="row">\
                                    <div class="col-md-6 mb-0">\
                                        <div class="breakdown" style="background-color:' + item.bgColorLight + '">\
                                            <h3>' + item.leftCount + '</h3>\
                                            <p>' + item.leftText + '</p>\
                                        </div>\
                                    </div>\
                                    <div class="col-md-6 mb-0">\
                                        <div class="breakdown" style="background-color:' + item.bgColorLight + '">\
                                            <h3>' + item.rightCount + '</h3>\
                                            <p>' + item.rightText + '</p>\
                                        </div>\
                                    </div>\
                                </div>\
                             </div>\
                                <a href="#" id="' + type + '" class="small-box-footer">View details <i class="fa fa-arrow-circle-right"></i></a>\
                           </div>\
                         </div>';
            },
            status: {
                0: '   <span class="label label-flat label-warning label-xs">Pending</span>',
                1: '   <span class="label label-flat label-success label-xs">Approved</span>',
                2: '   <span class="label label-flat label-danger label-xs">Disapproved</span>',
                3: '   <span class="label label-flat label-warning label-xs">Resubmitted</span>',
                4: '   <span class="label label-flat label-info label-xs">Waiting</span>'
            },
            renderMIS1: function (data, provider) {
                submissionDate = data.modifydate.split(" ")[0];
                data = data.data;
//                var pairs = Template.pairs();
//                var version = Template.getVersion(pairs.year, pairs.month);
//                Template.reset(version);

                var json = data.MIS, mis = data.MIS, lmis = data.LMIS;//, submissionDate = data.submissionDate;
                //Top area part
                function setHeaderArea(row) {
                    var d = {r_unit_name: 'aaa', r_ward_name: 'bbbb', r_un_name: 'ccc', r_upz_name: 'ddd', r_dist_name: 'eee'};
                    if (row) {
                        d = row;
                    }
                    $("#unitValue").html("&nbsp;<b>" + d.r_unit_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#wardValue").html("&nbsp;<b>" + d.r_ward_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#unionValue").html("&nbsp;<b>" + d.r_un_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#upazilaValue").html("&nbsp;<b>" + d.r_upz_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#districtValue").html("&nbsp;<b>" + d.r_dist_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#yearValue").html("<b>" + convertE2B($("#year :selected").text()) + "&nbsp;&nbsp;&nbsp;&nbsp;</b>");
                    $("#monthValue").html("<b>" + $.app.monthBangla[$("#month").val()] + "</b>");
                }
                setHeaderArea(json[0]);
                $("#submissionDate").html("&nbsp;&nbsp;<b>" + e2b(convertToUserDate(submissionDate)) + "</b>");
                $("#providerName").html("&nbsp;&nbsp;<b>" + provider.provname + "</b>");
                //Data rendering into table
                var $tables = $('table', Template.context);
                //Data rendering into table
                var mis_data = mis[0] || {};
                if (!mis_data.r_car && mis_data.r_unit_capable_elco_tot) {
                    var r_car = 0;
                    r_car = $.app.percentage(mis_data.r_unit_all_total_tot, mis_data.r_unit_capable_elco_tot, 2);
                    mis_data.r_car = r_car;
                }
                var NA = [], SKIP = ['r_car', 'r_unit_all_total_tot', 'r_unit_capable_elco_tot'];
                $.each(mis_data, function (k, v) {
                    var _k = '[id$=' + k.replace(/^(r|v)_/, '') + ']', _v = Template.reportValue(v, ~SKIP.indexOf(k));
                    var $k = $tables.find(_k);
                    if ($k.length) {
                        $k.html(_v);
                    } else {
                        NA.push(_k);
                    }
                });

                //LMIS
                var $stockvacuum = {
                    1: 'ক',
                    2: 'খ',
                    3: 'গ',
                    4: 'ঘ'
                }
                $.each(lmis, function (k, v) {
                    $row = e2b(finiteFilter(v));
                    if (k.split("_")[0] == "stockvacuum")
                        $row = $stockvacuum[v];
                    $('.mis_table').find('#' + k).html($row);
                });
            }
        };
        $.MIS1Status.init();
    });
</script>
<%--<%@include file="/WEB-INF/jspf/modalMIS1View.jspf" %>--%>
<%@include file="/WEB-INF/jspf/modalMIS1ViewV9.jspf" %>
<%@include file="/WEB-INF/jspf/modal-mis1-view-v9.jspf" %>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.flash.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js" type="text/javascript"></script>
