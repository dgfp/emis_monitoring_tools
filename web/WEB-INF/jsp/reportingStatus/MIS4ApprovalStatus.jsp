<%-- 
    Document   : MIS4ApprovalStatus
    Created on : Jan 30, 2019, 3:46:00 PM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<link href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/reportingStatus.css" rel="stylesheet" type="text/css"/>
<script src="resources/js/advance_workplan_view.js"></script>
<script src="resources/js/monthYearLoader.js" type="text/javascript"></script>
<script src="resources/js/TemplateMIS.js" type="text/javascript"></script>
<section class="content-header">
    <h1>MIS 4 approval status</h1>
</section>
<section class="content">
    <div class="row">
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
                        <input type="hidden" name="provtype" id="provtype" value="15">
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
                        </div>
                        <div class="row">
                            <div class="col-md-2  col-xs-4 col-md-offset-10 col-xs-offset-8">
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
        $.MIS4Status = $.MIS4Status || {
            formData: null,
            isCurrent: false,
            isPreTwoMonth: true,
            preMonth: null,
            preYear: null,
            currentType: 15,
            modal: $("#modal-report-view"),
            init: function () {
                $.data = $.app.date();
//                $.app.select.$year('select#year', range($.data.year, 2012, -1)).val($.data.year);
//                $.app.select.$month('select#month').val($.data.month);
                $.MIS4Status.events.bindEvent();
                $(".full-screen").after($.app.getWatermark());
                //set Previous month year
                $.MIS4Status.preMonth = $.app.date().month == 1 ? 12 : $.app.date().month - 1;
                $.MIS4Status.preYear = $.app.date().month == 1 ? $.app.date().year - 1 : $.app.date().year;
            },
            events: {
                bindEvent: function () {
                    $.MIS4Status.events.viewStatus();
                    $.MIS4Status.events.viewProviderList();
                    $.MIS4Status.events.viewMIS4();
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
                        $.MIS4Status.isPreTwoMonth = true;
                        $.MIS4Status.ajax.statusLoader(area);
                    });
                },
                viewProviderList: function () {
                    $(document).off('click', '.small-box-footer').on('click', '.small-box-footer', function (e) {
                        $.MIS4Status.ajax.getProviderList($(this).attr('id'));
                    });
                },
                viewMIS4: function () {
                    $(document).off('click', '.mis4-view').on('click', '.mis4-view', function (e) {
                        $.MIS4Status.ajax.getMIS4($(this).data("info"), $(this).data("prov"));
                    });
                }
            },
            ajax: {
                statusLoader: function (area) {
                    $('#dashboard').empty();
                    $.ajax({
                        url: "mis4-approval-status?action=getStatus",
                        type: "POST",
                        data: {misStatus: JSON.stringify(area)},
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success == true) {
                                $.MIS4Status.formData = area;
                                if ((($.MIS4Status.formData.year == $.data.year) && ($.MIS4Status.formData.month == $.data.month)))
                                    $.MIS4Status.isPreTwoMonth = false;
                                if ((($.MIS4Status.formData.month == $.MIS4Status.preMonth) && ($.MIS4Status.formData.year == $.MIS4Status.preYear)))
                                    $.MIS4Status.isPreTwoMonth = false;

                                var dashboard = "";
                                dashboard += $.MIS4Status.misDashboard(0, response.data[0].total_provider); // totalProvider
                                dashboard += $.MIS4Status.misDashboard(4, response.data[0].submitted); //submitted
                                dashboard += $.MIS4Status.misDashboard(2, response.data[0].approved); // approved
                                dashboard += $.MIS4Status.misDashboard(1, (response.data[0].need_to_resubmit + response.data[0].pending + response.data[0].reopened + response.data[0].resubmitted)); //waiting

                                if (!$.MIS4Status.isPreTwoMonth)
                                    dashboard += $.MIS4Status.misDashboard(3, response.data[0].not_submitted); //not submitted

                                $.app.removeWatermark();
                                $(dashboard).hide().appendTo("#dashboard").slideDown(500);
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
                        url: "mis4-approval-status?action=getProviderList&viewType=" + type,
                        type: "POST",
                        data: {misStatus: JSON.stringify($.MIS4Status.formData)},
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success === true) {
                                $("#details").css("display", "block");
                                var title = type == "0" ? "Total " + $.MIS4Status.type[type].toLowerCase() + " list" : $.MIS4Status.type[type] + " provider list";
                                var exportTitle = 'MIS 4 approval status  ( ' + title + ' - ' + $("#district option:selected").text().split("[")[0] + ')';
                                $('#typeTitle span').html(title);
                                var columns = [
                                    {data: "name_upazila_eng", title: 'Upazila'},
                                    {data: "providerid", title: 'Provider id'},
                                    {data: "provname", title: 'Provider name'},
                                    {data: function (d) {
                                            return "0" + d.mobileno;
                                        }, title: "Mobile"},
                                    {data: function (d) {
                                            var json = JSON.stringify({"zillaid": d.zillaid, "upazilaid": d.upazilaid, "providerid": d.providerid, "unit": d.unit, "provtype": 15, "month": d.month, "year": d.year});
                                            var action = "<a class='btn btn-flat btn-primary btn-xs mis4-view' id='" + d.providerid + "' data-info='" + json + "' data-prov='" + JSON.stringify({"provname": d.provname, "providerid": d.providerid}) + "'><b> View MIS4</b></a>";
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
                                if ($.MIS4Status.isPreTwoMonth)
                                    columns.splice(3, 3);
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
                                            filename: 'pdf_MIS4_approval+status'
                                        },
                                        {
                                            extend: 'excelHtml5',
                                            text: '<i class="fa fa-file-excel-o" aria-hidden="true"></i> Excel',
                                            title: exportTitle,
                                            filename: 'excel_MIS4_approval+status'
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
                getMIS4: function (json, provider) {
                    $.ajax({
                        url: "mis4-approval-status?action=getMIS4",
                        type: "POST",
                        data: {misStatus: JSON.stringify(json)},
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success == true) {
                                var mis4 = response.data.mis4;
                                mis4.zillaname = response.zillaname;
                                mis4.upazilaname = response.upazilaname;
                                $("#provider-info").html("<b>MIS 4 (Upazila) - Provider: " + provider.provname + " - ID: " + provider.providerid + "</b>");
                                console.log(response);
                                $.MIS4.renderMIS4(response.data.union, response.data.mis4, response);
                                $.MIS4Status.modal.modal('show');
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
                0: "Reporting upazila",
                1: "Waiting",
                2: "Approved",
                3: "Not submitted",
                4: "Submitted"
            },
            misDashboard: function (type, count) {
                //totalProvider = 0 ,waiting =1, approved= 2, disapproved = 3, resubmitted = 4;
                var color = "", icon = "", xs = "col-xs-6";
                switch (type) {
                    case 0:
                        color = "bg-blue";
                        var size = $.MIS4Status.isPreTwoMonth ? '2' : '1';
                        icon = '<i class="fa fa-users" aria-hidden="true"></i>', xs = "col-xs-12 col-lg-offset-" + size;
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
                               <p>' + $.MIS4Status.type[type] + '</p>\
                             </div>\
                               <a href="#" id="' + type + '" class="small-box-footer">View details <i class="fa fa-arrow-circle-right"></i></a>\
                           </div>\
                         </div>';
            }
        };
        $.MIS4Status.init();
    });
</script>
<%@include file="/WEB-INF/jspf/modalMIS4ViewV9.jspf" %>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.flash.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js" type="text/javascript"></script>