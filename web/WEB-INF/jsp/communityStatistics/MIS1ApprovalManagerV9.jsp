<%-- 
    Document   : MIS1ApprovalManagerV9
    Created on : Apr 2, 2019, 12:46:36 AM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="resources/js/TemplateMIS.js" type="text/javascript"></script>
<script src="resources/js/$.misv9.js"></script>
<style>
    .label {
        border-radius: 11px!important;
    }
    tr {
        max-height: 15px !important;
        height: 15px !important;
    }
    .nav-tabs-custom>.nav-tabs>li.active {
        border-top-color: #F39C12;
    }
    #data-table{
        font-size: 15px;
    }
    #slogan{
        border: 1px solid #000000;
        text-align: center;
        padding: 2px;
        margin-top: 45px;
        word-wrap: break-word;
    }
    #page{
        margin-top: -55px;
    }
    #logo{
        margin-top: 10px;
        margin-left: 5px;
        width:50px;
        height:50px;
    }
    .mis_table th, .mis_table td{ 
        border: 1px solid black!important;
    }
    .center{
        text-align: center;
    }
    #areaPanel [class*="col"] { margin-bottom: 10px; }
    table .btn {
        margin-bottom: 4px;
    }
    #data-table_wrapper  .row {
        margin-right: 0px!important;
        margin-left: 0px!important;
    }
    #data-table_wrapper  .row:nth-child(1) {
        display: none;
    }
    #data-table_wrapper  .row:nth-child(3) {
        display: none;
    }
    td a {
        color: #575a5e;
    }
    .mid{
        vertical-align: middle!important;
    }
</style>
<script>
    $(document).ready(function () {
        Template = $.extend(true, Template, {
            mis: {
                1: {
                    8: {viewURL: "mis1-approval-manager-v9?action=showData"},
                    9: {viewURL: "ReportSubmission?action=showData"}
                }
            },
            getHiddenClass: {
                8: "hidden",
                9: ""
            }
        });

        Template.init(1);

        var btn = null;
        $.data = $.app.date();
        $.app.select.$year('select#year', range($.data.year, 2014, -1)).val($.data.year);
        $.app.select.$month('select#month').val($.data.month);
        $.app.hideNextMonths();
        //Load report type dropdown
        var selectTag = $('#reportType');
        $('<option selected>').val('701').text('MIS 1 (FWA)').appendTo(selectTag);

        var table = null;
        var options = {
            data: [],
            bDestroy: true,
            searching: false,
            paging: false,
            "bLengthChange": true,
            "bInfo": true,
            columns: [
                {
                    data: "upazilanameeng",
                    render: function (d, t, r, m) {
                        return m.row + 1;
                    }
                },
                {data: 'unionnameeng', defaultContent: '-', className: 'mid'},
                {data: function (d) {
                        //return  d.fwaunit;
                        return  $.getUnitName(d.fwaunit, 0);
                    }, defaultContent: '-', className: 'mid'},
                {data: function (d) {
                        return  "<b>" + d.provname + "</b><br/> <span style='color: #575a5e;'>ID: " + d.providerid + " Mob: <a href='tel:+880" + d.mobileno + "'>0" + d.mobileno + "</a></span>";
                    }, defaultContent: '-'},
                {data: function (d) {
                        return (d.systementrydate && $.app.date(d.systementrydate) || {}).datetimeHuman || '';
                    }, defaultContent: '-', className: 'mid'},
                {data: function (d, r) {
                        console.log('approved', d);
                        var statusTypes = {
                            null: {text: 'Not submitted', label: 'danger'},
                            0: {text: 'Pending', label: 'warning'},
                            1: {text: 'Approved', label: 'success'},
                            2: {text: 'Returned', label: 'warning'},
                            3: {text: 'Resubmitted', label: 'warning'},
                            4: {text: 'Reopened', label: 'primary'}
                        };
                        var status = statusTypes[d.approved] || statusTypes[null];
                        return  "<span class='label label-flat label-sm label-" + status.label + "' style='width:90px; display:inline-block; padding:5px;text-align:center;'>" + status.text + "</span>";
                    }, className: 'center mid'},
                {data: function (d) {
                        var disable = d.approved == null ? 'disabled' : '';

                        var actions = '<a class="btn btn-flat btn-primary center btn-xs action-view" ' + disable + ' style="justify-content: center;"><b><i class="fa fa-eye"></i> View</b></a> <a class="btn btn-flat center btn-warning ' + Template.getHiddenClass[Template.getVersion($('#year').val(), $('#month').val())] + ' btn-xs action-response" ' + disable + '  data-loading-text=" <i class=\'fa fa-spinner fa-pulse\'></i> Loading"><b><i class="fa fa-edit"></i> Approve/ Return</b></a>';
                        var mdate = "2018-03-19 17:34:23.39774";
                        //mdate = d.modifydate
                        var dayDiff = Math.ceil($.data.dayDiff);
                        if (d.approved == 1 && dayDiff <= 3) {
                            //actions += ' <a class="btn bg-gray  btn-flat btn-xs action-reopen" ' + disable + '><b><i class="fa fa-undo" aria-hidden="true"></i> Reopen</b></a>';
                        }
                        return actions;
                    }, defaultContent: '-', className: 'center mid'}
            ]
        };


        $('#data-table').on('click', 'tbody tr a:not([disabled])', function (e) {
            var tr = $(this).closest('tr');
            var data = table.row(tr).data();
            $.data.currentSubmission = data;
            if ($(this).is('.action-view')) {
                //Load MIS-1 view modal
                //data.html != null ? $('#modal-report-view').modal('show', data) : $('#modalReportView').modal('show', data);
                $('#modalReportView').modal('show', data);

            } else if ($(this).is('.action-response')) {
                $('#responseViewTitle')
                        .html(data.modreptitle + " - " + data.provname);
                $("select#action").prop('selectedIndex', 0);
                $("#actionBtn").attr("disabled", data.approved === 1);
                btn = $(this).button('loading');
                console.log(data);
                loadReviewData(data);
            }
        });
        //zzz
        $('#modal-report-response').on('click', '.action-view', function (e) {
            var index = +$(this).data('index');
            var data = $.data.currentReview[index];
            data.modreptitle = $.data.currentSubmission.modreptitle;
            console.log('currentReview', data.html);
            $('#modal-report-view').modal('show', data);
            //data.html==null ?  $('#modalReportView').modal('show', data) : $('#modal-report-view').modal('show', data);
        });

        $('#modalReportView').on('shown.bs.modal', function (e) {
            var data = e.relatedTarget;
            $(e.target).find('#reportViewTitle').html(data.modreptitle + " - Provider: " + data.provname + " - ID:" + data.providerid);

            if (data.data != null) {
                $.MIS.renderMIS1(data);
            } else {
                $.toast('Click blue view button to see MIS-1', 'warning')();
            }
            $("#providerName").html("&nbsp;&nbsp;<b>" + data.provname + "</b>");
        });

        $('#modal-report-view').on('shown.bs.modal', function (e) {
            console.log("Called with html");
            var data = e.relatedTarget;
            $(e.target).find('#reportViewTitle').html(data.modreptitle + " - " + data.provname).end().find('#report').html(data.html);
        });

        function loadTableData(month, year) {
            $.ajax({
                url: Template.getViewURL(Template.getVersion(year, month)),
                type: 'POST',
                data: {
                    month: month,
                    year: year,
                    reportType: $('select#reportType').val()
                }}).done(renderTable);
        }
        ;

        function loadReviewData(data) {
            Pace.track(function () {
                $.ajax({
                    url: "ReportSubmission?action=reviewData",
                    type: 'POST',
                    data: {
                        submission_id: data.submission_id
                    }
                }).done(renderReview);
            });
        }
        ;

        function renderTable(data) {
            options.data = $.parseJSON(data);
            //console.log(data);
            btn && btn.button('reset');
            if (table) {
                table.clear();
                table.rows.add(options.data);
                table.draw();
            } else {
                table = $('#data-table').DataTable(options);
            }
        }

        function renderReview(data) {
            btn && btn.button('reset');
            var d = $.parseJSON(data);
            $.data.currentReview = d;
            $("#districtid").val(d[0].zillaid);
            $("#upazilaid").val(d[0].upazilaid);
            $("#unionid").val(d[0].unionid);
            //$("#hiddenReport").val(data); //set data
            //$('.direct-chat-messages').html("");
            //{"review_id":8,"submission_id":1520190482228,"submission_to":93132,"provname":"Mukul Akter"}];
            var covsersation = "";
            for (var i = 0, submission_from = 0, j = 0; i < d.length; i++) {
                var nameAlign = "pull-right", dateAlign = "pull-left", titleAlign = "right", isSuper = 1;
                if (submission_from != d[i].submission_from) {
                    ++j;
                }
                if (j & 1) {
                    nameAlign = "pull-left", dateAlign = "pull-right", titleAlign = "", isSuper = 0;
                }

                var notes = d[i].notes == "" || d[i].notes == null ? '&nbsp;' : d[i].notes;
                covsersation += '<div class="direct-chat-msg ' + titleAlign + '">'
                        + '<div class="direct-chat-info clearfix">'
                        + '<span class="direct-chat-name ' + nameAlign + '">' + d[i].provname + '</span>'
                        + '<span class="direct-chat-timestamp ' + dateAlign + '">' + $.app.date(d[i].systementrydate).datetimeHuman + '</span>'
                        + '</div>'
                        + '<span class="direct-chat-img">' + (isSuper ? 'S' : 'P') + '</span>'
                        + '<div class="direct-chat-text"><span class="pill-right">'
                        + (!isSuper ? '<a class="btn btn-flat btn-warning btn-xs action-view" data-index="' + i + '" ><b>View</b></a></span> ' : '')
                        + notes + '</div>'
                        + '</div>';
                submission_from = d[i].submission_from;
            }

            console.log(submission_from, $.data.currentSubmission.submission_from);
            $('.direct-chat-messages').html(covsersation);
            //var method = !(i & 1) ? 'show' : 'hide';
//            var method = $.data.currentSubmission.approved == 1 ? 'removeClass' : 'addClass';
//            $('#modal-report-response').modal('show', d).find('.overlay')[method]('hidden');

            var method = ($.data.currentSubmission.approved == 1) || ($.data.currentSubmission.approved == 2) ? 'removeClass' : 'addClass';
            $('#modal-report-response').modal('show', d).find('.overlay')[method]('hidden');

            //d.html!=null ?  $('#modal-report-view').modal('show', d).find('.overlay')[method]('hidden') : $('#modalReportView').modal('show', data).find('.overlay')[method]('hidden');
        }

        loadTableData($.data.month, $.data.year);

        $('#showDataButton').on('click', function () {
            btn = $(this).button('loading');
            loadTableData($('select#month').val(), $('select#year').val());
        });

        //actionOnResponse
        $('#form-report-response').on('click', 'button', function (e) {
            console.log(this, e.target, e.currentTarget);
            var target = e.currentTarget,
                    status = $(target).data('status'),
                    form = target.form;
            formReportResponse(form, {status: status});
            return false;
        });

        function formReportResponse(form, options) {
            var that = form,
                    serialize = $(that).serializeArray(),
                    data = serialize.reduce(function (p, n) {
                        p[n.name] = n.value;
                        return p;
                    }, {}),
                    url = $(that).attr('action');
            data = $.extend({}, data, options || {});
            //console.log(data);
            if (!data.status) {
                $.toast('Please select response type', 'error')();
                return;
            }

            //Add aditional Data from selected row
            var firstRow = $.data.currentReview[0] || {};
            data.submission_id = firstRow.submission_id;
            data.submission_from = firstRow.submission_to;
            data.submission_to = firstRow.submission_from;
            data.fwaunit = $.data.currentSubmission.fwaunit;
            data.month = $('select#month').val();
            data.year = $('select#year').val();
            data.reportType = $('select#reportType').val();

            var xhr = $.ajax({url: url, type: 'POST', data: data});
            xhr.done(function (data) {
                $('#modal-report-response').modal('hide');
                $('#showDataButton').click();
            }).fail($.toast('Something went wrong', 'error'));
            that.reset();
        }
        ;
    });
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle">MIS 1 approval manager</h1>
</section>
<!-- Main content -->
<section class="content">
    <div class="row" id="areaPanel">
        <div class="col-xs-12">
            <input type="hidden" value="${userLevel}" id="userLevel">
            <div class="box box-primary full-screen">
                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <!-- table -->
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <label for="district">Year</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="year" id="year"> </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="division">Month</label>
                        </div>
                        <div class="col-md-2  col-xs-4">
                            <select class="form-control input-sm" name="month" id="month">
                            </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="district">Report</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="reportType" id="reportType"> </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for=""></label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <button type="button" id="showDataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off">
                                <b><i class="fa fa-bar-chart" aria-hidden="true"></i> View</b>
                            </button>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <!--<table class="table table-bordered table-striped table-hover" id="data-table">-->
                        <table class="table table-striped table-hover" id="data-table">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Union</th>
                                    <th>Unit</th>
                                    <th>Provider&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                    <th>Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                    <th style="text-align: center">Status</th>
                                    <th style="text-align: center">&nbsp;&nbsp;&nbsp;&nbsp;Actions&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                </tr>
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-------- Start Report Modal ----------->
<%@include file="/WEB-INF/jspf/modalMIS1ViewV9.jspf" %>
<%@include file="/WEB-INF/jspf/modal-report-response-v9.jspf" %>
<%@include file="/WEB-INF/jspf/modal-mis1-view-v9.jspf" %>
<!-------- End Report Modal ----------->  
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>