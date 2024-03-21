<%-- 
    Document   : MonthlyAdvanceWorkplanDashboard
    Created on : Nov 28, 2018, 12:32:55 PM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<link href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css"/>
<style>
    .bg-blue p {
        margin: 0 0 -6px!important;
    }
    .small-box p>small {
        margin-top: -2px!important;
    }
</style>
<link href="resources/css/reportingStatus.css" rel="stylesheet" type="text/css"/>
<script src="resources/js/advance_workplan_view.js"></script>
<script src="resources/js/monthYearLoader.js" type="text/javascript"></script>
<section class="content-header">
    <h1>Advance workplan (FP)</h1>
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
                            <div class="col-md-1 col-xs-2">
                                <label for="provtype">Provider </label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="provtype" id="provtype" required>
                                    <option class="opt-3" value="3">FWA [3]</option>
                                    <option class="opt-10" value="10">FPI [10]</option>
                                </select>
                            </div>
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
                                <button type="submit" class="btn btn-flat btn-primary btn-sm btn-block" autocomplete="off" >
                                    <i class="fa fa-table" aria-hidden="true"></i> Show data
                                </button>
                            </div>
                        </div>
                    </form>
                    <span id="dashboard"></span>
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
        $("#year").change(function () {
            if ($.app.date().month == "12" && $("#year").val() == ($.app.date().year + 1)) {
                $('#month').val(1).change();
            }
        });
        $.MAWDashboard = $.MAWDashboard || {
            formData: null,
            isCurrent: false,
            isPreTwoMonth: true,
            preMonth: null,
            preYear: null,
            fuMonth: null,
            fuYear: null,
            currentType: 3,
            init: function () {
                $.app.hideNextMonths(null, null, $.app.moveMonth(1)); // to allow next month
                $.data = $.app.date();
//                $.app.select.$year('select#year', range($.data.year, 2014, -1)).val($.data.year);
//                $.app.select.$month('select#month').val($.data.month);

                if ($.app.date().month == "12") {
                    $("#year").prepend("<option value='" + ($.app.date().year + 1) + "'>" + ($.app.date().year + 1) + "</option>");

                }
                $("#year").change()



                $.MAWDashboard.events.bindEvent();
                $(".full-screen").after($.app.getWatermark());
                //set Previous month year
                $.MAWDashboard.preMonth = $.app.date().month == 1 ? 12 : $.app.date().month - 1;
                $.MAWDashboard.preYear = $.app.date().month == 1 ? $.app.date().year - 1 : $.app.date().year;

                $.MAWDashboard.fuMonth = $.app.date().month == 12 ? 1 : $.app.date().month + 1;
                $.MAWDashboard.fuYear = $.app.date().month == 12 ? $.app.date().year + 1 : $.app.date().year;
            },
            events: {
                bindEvent: function () {
                    $.MAWDashboard.events.viewStatus();
                    $.MAWDashboard.events.viewProviderList();
                    $.MAWDashboard.events.viewWorkplan();
                },
                viewStatus: function () {
                    $(document).off('submit', '#showData').on('submit', '#showData', function (e) {
                        e.preventDefault();
                        $("#details").css("display", "none");
                        var area = $.app.pairs('form');
                        if (area.divid == "") {
                            $.toast('Please select division', 'error')();
                            return false;
                        } else if (area.zillaid == "") {
                            $.toast('Please select district', 'error')();
                            return false;
                        }
                        $.MAWDashboard.isPreTwoMonth = true;
                        $.MAWDashboard.ajax.statusLoader(area);
                    });
                },
                viewProviderList: function () {
                    $(document).off('click', '.small-box-footer').on('click', '.small-box-footer', function (e) {
                        $.MAWDashboard.ajax.getProviderList($(this).attr('id'));
                    });
                },
                viewWorkplan: function () {
                    $(document).off('click', '.workplan-view').on('click', '.workplan-view', function (e) {
                        console.log($(this).data("info"));
                        $.MAWDashboard.ajax.getWorkplan($(this).data("info"));
                    });
                }
            },
            ajax: {
                //totalProvider = 0 ,waiting =1, approved= 2, disapproved = 3, resubmitted = 4;
                statusLoader: function (area) {
                    $('#dashboard').empty();
                    $.ajax({
                        url: "MonthlyWorkplan?action=getStatus",
                        type: "POST",
                        data: {workplanArea: JSON.stringify(area)},
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success == true) {
                                $.MAWDashboard.formData = area;
                                if ((($.MAWDashboard.formData.year == $.data.year + "") && ($.MAWDashboard.formData.month == $.data.month + "")))
                                    $.MAWDashboard.isPreTwoMonth = false;
                                if ((($.MAWDashboard.formData.month == $.MAWDashboard.preMonth) && ($.MAWDashboard.formData.year == $.MAWDashboard.preYear)))
                                    $.MAWDashboard.isPreTwoMonth = false;
                                if ((($.MAWDashboard.formData.month == $.MAWDashboard.fuMonth) && ($.MAWDashboard.formData.year == $.MAWDashboard.fuYear)))
                                    $.MAWDashboard.isPreTwoMonth = false;

                                var dashboard = "";
                                dashboard += $.MAWDashboard.workplanDashboard(0, response.data[0].total_provider); // totalProvider
                                dashboard += $.MAWDashboard.workplanDashboard(4, (response.data[0].approved + response.data[0].resubmitted + response.data[0].disapproved + response.data[0].waiting)); //submitted
                                dashboard += $.MAWDashboard.workplanDashboard(2, response.data[0].approved); // approved
                                dashboard += $.MAWDashboard.workplanDashboard(1, (response.data[0].resubmitted + response.data[0].disapproved + response.data[0].waiting)); //waiting
                                if (!$.MAWDashboard.isPreTwoMonth)
                                    dashboard += $.MAWDashboard.workplanDashboard(3, (response.data[0].total_provider - (response.data[0].approved + response.data[0].resubmitted + response.data[0].disapproved + response.data[0].waiting))); //not submitted

                                $.app.removeWatermark();
                                $(dashboard).hide().appendTo("#dashboard").slideDown(500);
                                $.MAWDashboard.currentType = area.provtype;
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
                        url: "MonthlyWorkplan?action=getProviderList&viewType=" + type,
                        type: "POST",
                        data: {workplanArea: JSON.stringify($.MAWDashboard.formData)},
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success === true) {
                                console.log("json", response)
                                $("#details").css("display", "block");
                                var title = "";
                                if (type == "0") {
                                    if ($.MAWDashboard.currentType == 3) {
                                        title = $.MAWDashboard.type[type] + " list"
                                    } else {
                                        title = "Total " + $.MAWDashboard.type[10].toLowerCase() + " list"
                                    }
                                } else {
                                    title = $.MAWDashboard.type[type] + " provider list"
                                }
                                var exportTitle = 'Advance workplan (FP)  ( ' + title + ' - ' + $("#district option:selected").text().split("[")[0] + ')';
                                $('#typeTitle span').html(title);
                                var columns = [
                                    {data: "name_upazila_eng", title: 'Upazila'},
                                    {data: "name_union_eng", title: 'Union'},
                                    {data: "providerid", title: 'Provider id'},
                                    {data: "provname", title: 'Provider name'},
                                    {data: function (d) {
                                            return "0" + d.mobileno;
                                        }, title: "Mobile"},
                                    {data: function (d) {
                                            var json = JSON.stringify({"zillaid": d.zillaid, "providerid": d.providerid, "provname": d.provname, "provtype": $.MAWDashboard.currentType, "year": d.work_plan_year, "month": d.work_plan_mon});

                                            var action = "<a class='btn btn-flat btn-primary btn-xs workplan-view' id='" + d.providerid + "' data-info='" + json + "'><b> View Workplan</b></a>";
                                            if (d.status == 1)
                                                action += '   <span class="label label-flat label-info label-xs">Waiting</span>';
                                            else if (d.status == 2 && type != 2)
                                                action += '   <span class="label label-flat label-success label-xs">Approved</span>';
                                            else if (d.status == 3)
                                                action += '   <span class="label label-flat label-danger label-xs">Disapproved</span>';
                                            else if (d.status == 4)
                                                action += '   <span class="label label-flat label-warning label-xs">Resubmitted</span>';
                                            return action;
                                        }, title: "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Action&nbsp;&nbsp;&nbsp;&nbsp;"}
                                ]
                                // columns.splice(2, 0, {data: "unit_name", title: 'Unit'});
                                if ($.MAWDashboard.formData.provtype == 3) {
                                    columns.splice(2, 0, {data: function (d) {
                                            var unit = d.unit_name + "";
                                            unit == "null" ? unit = "-" : unit = unit.replace(/\W+/g, ',  ');
                                            return unit;
                                        }, title: 'Unit'});
                                }

                                if ($.MAWDashboard.isPreTwoMonth && $.MAWDashboard.currentType == 3)
                                    columns.splice(3, 3);
                                if ($.MAWDashboard.isPreTwoMonth && $.MAWDashboard.currentType == 10)
                                    columns.splice(2, 3);
                                if (type == 0 || type == 3)
                                    columns.pop();

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
                                            filename: 'pdf_advance_workplan_FP'
                                        },
                                        {
                                            extend: 'excelHtml5',
                                            text: '<i class="fa fa-file-excel-o" aria-hidden="true"></i> Excel',
                                            title: exportTitle,
                                            filename: 'excel_advance_workplan_FP'
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
                getWorkplan: function (json) {
                    $.ajax({
                        url: "MonthlyWorkplan?action=getWorkplan",
                        type: "POST",
                        data: json,
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response)
                            if (response.success == true) {
                                var columns = [
                                    {data: function (d) {
                                            return convertE2B(convertDateFrontFormat(d.workplandate));
                                        }, title: "তারিখ"},
                                    {data: function (d) {
                                            return getDayByDate(d.workplandate);
                                        }, title: "বার"},
                                    {data: function (d) {
                                            return e2b(d.activity);
                                        }, title: 'কর্মসূচি&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'}
                                    //{data: "activity", title: 'কর্মসূচি&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'}
                                ];
                                var options = {
                                    "searching": false,
                                    "lengthChange": false,
                                    "paging": false,
                                    "bInfo": false,
                                    "bAutoWidth": false,
                                    dom: 'Bfrtip',
                                    buttons: [
                                        {
                                            extend: 'print',
                                            text: ' <i class="fa fa-print" aria-hidden="true"></i> Print / PDF',
                                            title: '<center class="dt-title">মাসিক অগ্রিম কর্মসূচী<p>নাম:&nbsp;' + json.provname + '    &nbsp;&nbsp;&nbsp;&nbsp;মাস:&nbsp;' + $.app.monthBangla[json.month] + '    &nbsp;&nbsp;&nbsp;&nbsp;বছর:&nbsp;' + convertE2B(json.year) + '</p></center>',
                                            filename: 'pdf_advance_workplan_FP'
                                        },
                                        {
                                            extend: 'excelHtml5',
                                            text: '<i class="fa fa-file-excel-o" aria-hidden="true"></i> Excel',
                                            title: 'মাসিক অগ্রিম কর্মসূচী  নাম: ' + json.provname + '    মাস: ' + $.app.monthBangla[json.month] + '  বছর: ' + convertE2B(json.year),
                                            filename: 'excel_advance_workplan_FP'
                                        }
                                    ],
                                    processing: true,
                                    data: response.data,
                                    columns: columns
                                };
                                $('#workplan-table').dt(options);
                                $("#provider-info").text("Provider: " + json.provname + " - ID: " + json.providerid);
                                $.app.overrideDataTableBtn();
                                $('#viewWorkplan').modal('show');
                            } else {
                                toastr['error']("Error occured while user load");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                }
            },
            type: {
                0: "Total FWA <small>(Currently active)</small>",
                10: "Total FPI <small>(Currently active)</small>",
                1: "Waiting",
                2: "Approved",
                3: "Not submitted",
                4: "Submitted"
            },
            workplanDashboard: function (type, count) {
                //totalProvider = 0 ,waiting =1, approved= 2, disapproved = 3, resubmitted = 4;
                var color = "", icon = "", xs = "col-xs-6";
                var text = $.MAWDashboard.type[type];
                switch (type) {
                    case 0:
                        color = "bg-blue";
                        var size = $.MAWDashboard.isPreTwoMonth ? '2' : '1';
                        icon = '<i class="fa fa-users" aria-hidden="true"></i>', xs = "col-xs-12 col-lg-offset-" + size;
                        if ($("#provtype").val() == 10) {
                            text = $.MAWDashboard.type[10];
                        }
                        break;
                    case 2:
                        color = "bg-green";
                        icon = '<i class="fa fa-check-square-o" aria-hidden="true"></i>';
                        break;
                    case 4:
                        color = "bg-yellow";
                        icon = '<i class="fa fa-list-alt" aria-hidden="true"></i>';
                        break;
                    case 3:
                        color = "bg-red";
                        icon = '<i class="fa fa-window-close-o" aria-hidden="true"></i>';
                        break;
                    case 1:
                        color = "bg-aqua";
                        icon = '<i class="fa fa-clock-o" aria-hidden="true"></i>';
                        break;
                }
                return '<div class="col-lg-2 ' + xs + '">\
                           <div class="small-box ' + color + '">\
                             <div class="inner">\
                               <h3>' + icon + ' ' + count + '</h3>\
                               <p>' + text + '</p>\
                             </div>\
                               <a href="#" id="' + type + '" class="small-box-footer">View details <i class="fa fa-arrow-circle-right"></i></a>\
                           </div>\
                         </div>';
            }
        };
        $.MAWDashboard.init();
    });
</script>
<div id="viewWorkplan" class="modal fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title">Advance workplan (FP) - <span class="bold" id="provider-info"></span></h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-10 col-md-offset-1">
                        <div class="table-responsive fixed" >
                            <table class="table table-bordered table-striped table-hover" id="workplan-table">
                                <thead>
                                </thead>
                                <tbody id="tableBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.flash.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js" type="text/javascript"></script>