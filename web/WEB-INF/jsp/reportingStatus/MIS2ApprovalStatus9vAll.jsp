<%-- 
    Document   : MIS2ApprovalStatus
    Created on : Jan 30, 2019, 3:44:34 PM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<link href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/reportingStatus.css" rel="stylesheet" type="text/css"/>
<!--<script src="resources/js/advance_workplan_view.js"></script>-->
<script src="resources/js/reporting_status.js"></script>
<script src="resources/js/monthYearLoader.js" type="text/javascript"></script>
<style>
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
<section class="content-header">
    <h1>MIS 2 approval status</h1>
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
                        <input type="hidden" name="unit" id="unit">
                        <input type="hidden" name="provtype" id="provtype" value="10">
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
                    <div id="dashboard" class="row text-center"></div>
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

        $.MIS2Status = $.MIS2Status || {
            formData: null,
            isCurrent: false,
            isPreTwoMonth: true,
            preMonth: null,
            preYear: null,
            currentType: 3,
            modal: $("#modal-report-view"),
            init: function () {

                $.data = $.app.date();
//                $.app.select.$year('select#year', range($.data.year, 2012, -1)).val($.data.year);
//                $.app.select.$month('select#month').val($.data.month);
//                $.app.hideNextMonths();
                $.MIS2Status.events.bindEvent();
                $(".full-screen").after($.app.getWatermark());
                //set Previous month year
                $.MIS2Status.preMonth = $.app.date().month == 1 ? 12 : $.app.date().month - 1;
                $.MIS2Status.preYear = $.app.date().month == 1 ? $.app.date().year - 1 : $.app.date().year;
            },
            events: {
                bindEvent: function () {
                    $.MIS2Status.events.viewStatus();
                    $.MIS2Status.events.viewProviderList();
                    $.MIS2Status.events.viewMIS2();
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
                        $.MIS2Status.isPreTwoMonth = true;
                        $.MIS2Status.ajax.statusLoader(area);
                    });
                },
                viewProviderList: function () {
                    $(document).off('click', '.small-box-footer').on('click', '.small-box-footer', function (e) {
                        $.MIS2Status.ajax.getProviderList($(this).attr('id'));
                    });
                },
                viewMIS2: function () {
                    $(document).off('click', '.mis2-view').on('click', '.mis2-view', function (e) {
                        $.MIS2Status.ajax.getMIS2($(this).data("info"), $(this).data("prov"));
                    });
                }
            },
            ajax: {
                statusLoader: function (area) {
                    $('#dashboard').empty();
                    $.ajax({
                        url: "mis2-approval-status-9v-all?action=getStatus",
                        type: "POST",
                        data: {misStatus: JSON.stringify(area)},
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success == true) {
                                $.MIS2Status.formData = area;
                                if ((($.MIS2Status.formData.year == $.data.year) && ($.MIS2Status.formData.month == $.data.month)))
                                    $.MIS2Status.isPreTwoMonth = false;
                                if ((($.MIS2Status.formData.month == $.MIS2Status.preMonth) && ($.MIS2Status.formData.year == $.MIS2Status.preYear)))
                                    $.MIS2Status.isPreTwoMonth = false;
                                /*
                                 * NIBRAS AR RAKIB
                                 *  
                                 */
                                var rows = REPORTING_STATUS.init({text: "union", data: response.data, isPreTwoMonth: $.MIS2Status.isPreTwoMonth});
                                $.app.removeWatermark();
                                $(rows).hide().appendTo("#dashboard").slideDown(500);
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
                        url: "mis2-approval-status-9v-all?action=getProviderList&viewType=" + type,
                        type: "POST",
                        data: {misStatus: JSON.stringify($.MIS2Status.formData)},
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success === true) {
                                console.log("json", response)
                                $("#details").css("display", "block");
                                var title = type == "0" ? "Total " + $.MIS2Status.type[type].toLowerCase() + " list" : $.MIS2Status.type[type] + " provider list";
                                var exportTitle = 'MIS 2 approval status  ( ' + title + ' - ' + $("#district option:selected").text().split("[")[0] + ')';
                                $('#typeTitle span').html(title);
                                var columns = [
                                    {data: function (d) {
                                            return d.name_upazila_eng;
                                        }, title: '#', class: "slno"},
                                    {data: "name_upazila_eng", title: 'Upazila'},
                                    {data: "unionnameeng", title: 'Union'},
                                    {data: function (d) {
                                            return $.app.getAssignType(d["assign_type"], 2);
                                        }, title: 'Union Type', class: "center type"},
                                    {data: function (d) {
                                            var provname = (d["provname"] === 5) ? "NGO" : "<b>" + d["provname"] + "</b>";
                                            return (d["providerid"] || "") + " - " + provname;
                                        }, title: 'Provider'},
                                    {data: function (d) {
                                            return "0" + d.mobileno;
                                        }, title: "Mobile"},
                                    {data: function (d) {
                                            var json = JSON.stringify({"zillaid": d.zillaid, "upazilaid": d.upazilaid, "unionid": d.reporting_unionid, "providerid": d.providerid, "provtype": 10, "month": d.month, "year": d.year});
                                            console.log(d);
                                            var action = "<a class='btn btn-flat btn-primary btn-xs mis2-view' id='" + d.providerid + "' data-info='" + json + "' data-prov='" + JSON.stringify({"provname": d.provname, "providerid": d.providerid}) + "'><b> View MIS2</b></a>";
                                            if (d.status == 0)
                                                action += '   <span class="label label-flat label-warning label-xs">Pending</span>';
                                            else if (d.status == 1)
                                                action += '   <span class="label label-flat label-success label-xs">Approved</span>';
                                            else if (d.status == 2)
                                                action += '   <span class="label label-flat label-danger label-xs">Disapproved</span>';
                                            else if (d.status == 3)
                                                action += '   <span class="label label-flat label-warning label-xs">Resubmitted</span>';
                                            else if (d.status == 4)
                                                action += '   <span class="label label-flat label-info label-xs">Waiting</span>';
                                            return action;
                                        }, title: "&nbsp;&nbsp;&nbsp;&nbsp;Action&nbsp;&nbsp;&nbsp;&nbsp;"}
                                ]
                                if ($.MIS2Status.isPreTwoMonth)
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
                getMIS2: function (json, provider) {
                    $.ajax({
                        url: "mis2-approval-status-9v-all?action=getMIS2",
                        type: "POST",
                        data: {misStatus: JSON.stringify(json)},
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response);
                            if (response.success == true) {
                                $("#provider-info").html("<b> MIS 2 (FPI) - Provider: " + provider.provname + " - ID: " + provider.providerid + "</b>");
                                $.MIS2Status.modal.find('#report').html(response.data[0].html);
                                $('#slogan').html($.app.slogan);

                                $("#submissionDate").html("&nbsp;&nbsp;<b>" + e2b(convertToUserDate(response.data[0].modifydate.split(" ")[0])) + "</b>");
                                $.MIS2Status.modal.modal('show');
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
                0: "Reporting union",
                1: "Waiting",
                2: "Approved",
                3: "Not submitted",
                4: "Submitted"
            }
        };
        $.MIS2Status.init();
    });
</script>
<%--<%@include file="/WEB-INF/jspf/modal-mis2-view.jspf" %>--%>
<%@include file="/WEB-INF/jspf/modalMIS2ViewV9.jspf" %>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.flash.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js" type="text/javascript"></script>
<script src="resources/js/reportingconfig.js"></script>
