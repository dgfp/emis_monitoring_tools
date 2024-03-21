<%-- 
    Document   : ReportSubmission
    Created on : Feb 28, 2018, 11:53:41 AM
    Author     : Helal | m.helal.k@gmail.com
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="resources/js/$.mis.js"></script>
<style>
    .label {
        border-radius: 11px!important;
    }
    tr {
        max-height: 15px !important;
        height: 15px !important;
    }
    #data-table{
        font-size: 15px;
    }
    .nav-tabs-custom>.nav-tabs>li.active {
        border-top-color: #F39C12;
    }
    .mis-form-1{
        background:#87bbf9;
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
    [class*="col"] { margin-bottom: 10px; }
</style>
<script>
    $(document).ready(function () {
        var btn = null;
        $.data = $.app.date();
        $.app.select.$year('select#year', range($.data.year, 2012, -1)).val($.data.year);
        $.app.select.$month('select#month').val($.data.month);

        //Load report type dropdown
        var selectTag = $('#reportType');
        if (true) {
            $('<option selected>').val('701').text('MIS 1 and CSBA report').appendTo(selectTag);
        }

        var table = null;
        var options = {
            data: [],
            bDestroy: true,
            searching: false,
            paging: false,
            rowCallback: function (r, d, i, idx) {
                //console.log('fnRowCallback',this, r,d, i, idx);
                $('td', r).eq(0).html(idx + 1);
                //$('table').parent().parent().prev().remove();
            },
            columns: [
                {
                    orderable: false,
                    searchable: false,
                    data: null,
                    defaultContent: '#'
                },
                {data: 'unionnameeng', defaultContent: '-'},
                {data: function (d) {
                        //return  d.fwaunit;
                        return  $.getUnitName(d.fwaunit, 0);
                    }, defaultContent: '-'},
                {data: function (d) {
                        return  d.provname + " (" + d.providerid + ")"
                    }, defaultContent: '-'},
                {data: function (d) {
                        return (d.systementrydate && $.app.date(d.systementrydate) || {}).datetimeHuman || '';
                    }, defaultContent: '-'},
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
                    }},
                {data: function (d) {
                        var disable = d.approved == null ? 'disabled' : '';
                        var actions = '<a class="btn btn-flat btn-primary btn-xs action-view" ' + disable + '><b><i class="fa fa-eye"></i> View</b></a> <a class="btn btn-flat btn-warning btn-xs action-response" ' + disable + '  data-loading-text=" <i class=\'fa fa-spinner fa-pulse\'></i> Loading"><b><i class="fa fa-edit"></i> Approve/ Return</b></a>';
                        var mdate = "2018-03-19 17:34:23.39774";
                        //mdate = d.modifydate
                        var dayDiff = Math.ceil($.data.dayDiff);
                        if (d.approved == 1 && dayDiff <= 3) {
                            //actions += ' <a class="btn bg-gray  btn-flat btn-xs action-reopen" ' + disable + '><b><i class="fa fa-undo" aria-hidden="true"></i> Reopen</b></a>';
                        }
                        return actions;
                    }, defaultContent: '-',className:'center'}
            ]
        };


        $('#data-table').on('click', 'tbody tr a:not([disabled])', function (e) {
            var tr = $(this).closest('tr');
            var data = table.row(tr).data();
            $.data.currentSubmission = data;
            if ($(this).is('.action-view')) {
                //Load MIS-1 view modal
                data.html != null ? $('#modal-report-view').modal('show', data) : $('#modalReportView').modal('show', data);

            } else if ($(this).is('.action-response')) {
                $('#responseViewTitle')
                        .html(data.modreptitle + " - " + data.provname);
                $("select#action").prop('selectedIndex', 0);
                $("#actionBtn").attr("disabled", data.approved === 1);
                btn = $(this).button('loading');
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
            console.log("Called with data");
            var data = e.relatedTarget;
            $(e.target).find('#reportViewTitle').html(data.modreptitle + " - " + data.provname);

            if (data.data != null) {
                $.MIS.renderMIS1(JSON.parse(data.data));
            } else {
                $.toast('Click blue view button to see MIS-1', 'warning')();
            }
            $('#providerName').html("<b>" + data.provname + "</b>");
        });

        $('#modal-report-view').on('shown.bs.modal', function (e) {
            console.log("Called with html");
            var data = e.relatedTarget;
            $(e.target).find('#reportViewTitle').html(data.modreptitle + " - " + data.provname).end().find('#report').html(data.html);
        });

        function loadTableData(month, year) {
            Pace.track(function () {
                $.ajax({
                    url: "mis1-approval-manager-v9?action=showData",
                    type: 'POST',
                    data: {
                        month: month,
                        year: year,
                        reportType: $('select#reportType').val()
                    }}).done(renderTable);
            });
        }
        ;

        function loadReviewData(data) {
            Pace.track(function () {
                $.ajax({
                    url: "mis1-approval-manager-v9?action=reviewData",
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
            console.log("GO: " + d.html);
            var method = $.data.currentSubmission.approved == 1 ? 'removeClass' : 'addClass';
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
            console.log(data);
            //Ajax Request
            var xhr = $.ajax({url: url, type: 'POST', data: data});
            //xhr.done($.toast('Response submit successfully', 'success')).fail($.toast('Something went wrong', 'error'));
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
            <div class="box box-primary">
                <div class="box-header with-border">
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
                </div>
                <!-- table -->
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped table-hover" id="data-table">
                            <thead class="data-table">
                                <tr>
                                    <th>#</th>
                                    <th>Union</th>
                                    <th>Unit</th>
                                    <th>Provider&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                    <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                    <th style="text-align: center">Status</th>
                                    <th style="text-align: center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Actions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
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
<%@include file="/WEB-INF/jspf/modalMIS1View.jspf" %>
<%@include file="/WEB-INF/jspf/modal-report-response.jspf" %>
<%@include file="/WEB-INF/jspf/modal-mis1-view.jspf" %>
<!-------- End Report Modal ----------->  
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>