<%-- 
    Document   : Presentation
    Created on : Jan 30, 2019, 12:47:21 PM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>

<style>
</style>
<script>
    $(function () {
        var options = {
            paging: false,
            searching: false,
            info: false,
            ordering: false,
            //order: [[0, "desc"]],
            columns: [
                {data: 'app', title: 'App&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'},
                {data: 'version', title: 'Version'},
                {data: {
                        _: function (d) {
                            var m = moment(d.date, 'YYYY-MM-DD');
                            return m.format('DD  MMMM, YYYY');
                        },
                        sort: 'date'
                    }, title: 'Date'},
                {data: function (d) {
                        return '<a class="btn btn-flat btn-primary btn-xs btn-view" href="' + [d.register, d.version].join('-') + '"><b>View</b></a>'
                    }, title: 'View'}],
            data: [
                {app: 'FWA eRegister', register: 'FWA', version: '3.4', date: '2021-11-22'}
                , {app: 'FPI eSupervision System', register: 'FPI', version: '2.8', date: '2021-06-20'}
                , {app: 'UFPO eManagement System', register: 'UFPO', version: '1.9', date: '2022-02-07'}
                , {app: 'HA eRegister', register: 'HA', version: '2.5', date: '2019-07-31'}
                , {app: 'Facility Module', register: 'FacilityModule', version: '2.51-20200125', date: '2020-01-26'}
            ]
        };
        var $modal = $('.modal#modalReleaseNote').css('padding', 0);
        var $dt = $('table#release-notes');
        $dt.dt(options);
        $dt.on('click', '.btn-view', function () {
            var url = 'Release-note?filename=' + $(this).attr('href') + '.txt';
            $modal.modal('show');
            var $loading = $modal.find('#loading').html('loading....');
            var $body = $modal.find('.modal-body .box-body');
            var xhr = $.post(url);
            xhr.then(console.log, console.log);
            xhr.done(function (res) {
                res = $.parseJSON(res);
                $body.html(res.data);
                $loading.empty();
            });
            return false;
        });

//        Download
        $('#download_pdf').click(function () {
            var doc = new jsPDF();
            var specialElementHandlers = {
                '#download_pdf_container': function (element, renderer) {
                    return true;
                }
            };
            doc.fromHTML($('#download_pdf_container').html(), 15, 15, {
                'width': 170,
                'elementHandlers': specialElementHandlers
            });
            doc.save('release-notes.pdf');
        });
    });
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle">Release notes</h1>
</section>
<!-- Main content -->
<section class="content">
    <div class="row" id="areaPanel">
        <div class="col-xs-12">
            <div class="box box-primary full-screen">
                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <%--
                    <% 
                        String designation = request.getParameter("designation").toString();
                        System.out.println("designation :" + designation);
                        if (designation != null) {
                    %>
                    <%@include file="/WEB-INF/release-notes/FWA-2.7.0.jsp" %>
                    <%
                       } 
                    %>
                    --%>
                    <div class="col-xs-10 col-xs-offset-1">
                        <table id="release-notes" class="table table-striped">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="content-header">
    <h1 id="pageTitle">Release notes (previous versions)</h1>
</section>
<div id="modalReleaseNote" class="modal fade" role="dialog">
    <div class="modal-dialog report-view">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header label-primary">
                <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title"><b><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp; <span id="title">Release notes</span></b> <span id="loading">loading ...</span>
                    <button id="download_pdf" class="btn btn-primary">Download</button>
                </h4>
            </div>
            <div class="modal-body" id="download_pdf_container">
                <div class="box-body">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
