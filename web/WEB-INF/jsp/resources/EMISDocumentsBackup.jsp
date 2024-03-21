<%-- 
    Document   : EMISDocuments
    Created on : Dec 2, 2019, 11:44:19 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<style>
    .box-title {
        font-size: 18px;
        padding: 5px;
        padding-left: 12px;
    }
    .text-left{
        padding-left: 50px!important;
    }
</style>
<script>
    $(function () {

        //User Manual rendered
        var tableBody = $('#tableBody'), slno = 1;
        $.ajax({
            url: "userManual?action=viewUserManual",
            type: 'POST',
            success: function (json) {
                json = JSON.parse(json);
                for (var i = 0; i < json.length; i++) {
                    if (json[i].manualtype == 2)
                        continue;
                    tableBody.append('<tr><td>' + slno + '</td>'
                            + '<td>' + json[i].title + '</td>'
                            + '<td><a href="' + json[i].link + '"  class="btn btn-flat btn-primary btn-xs bold">Download</a></td>'
                            + '</tr>');
                    slno++;
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                toastr["error"]("<b>Request can't be processed</b>");
            }
        });

        //Release note rendered
        var options = {
            paging: false,
            searching: false,
            info: false,
            ordering: false,
            columns: [
                {
                    data: "version",
                    render: function (d, t, r, m) {
                        return m.row + 1;
                    },
                    title: '#'
                },
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
                {app: 'FWA eRegister', register: 'FWA', version: '2.7', date: '2019-05-15'}
                , {app: 'FPI eSupervision System', register: 'FPI', version: '2.3', date: '2019-05-15'}
                , {app: 'UFPO eManagement System', register: 'UFPO', version: '1.1', date: '2019-05-15'}
                , {app: 'HA eRegister', register: 'HA', version: '2.5', date: '2019-07-31'}

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
    });
</script>
<section class="content-header">
    <h1 id="pageTitle">eMIS Documents</h1>
</section>
<!-- Main content -->
<section class="content">

    <div class="row" id="areaPanel">
        <div class="col-md-6 col-xs-12">

            <div class="box box-primary full-screen">
                <div class="box-header with-border" style="padding: 0px;">
                    <p class="box-title">User Manual</p>
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <div class="col-xs-12">
                            <table class="table table-striped table-hover dataTable no-footer" id="data-table">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Manual<span class="pull-right"></span></th>
                                        <th>Download</th>
                                    </tr>
                                </thead>
                                <tbody id="tableBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="box box-primary full-screen">
                <div class="box-header with-border" style="padding: 0px;">
                    <p class="box-title">Source code</p>
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <div class="col-xs-12">
                            <table class="table table-striped table-hover dataTable no-footer" id="data-table">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Module<span class="pull-right"></span></th>
                                        <th>Version</th>
                                        <th>Repositoy</th>
                                    </tr>
                                </thead>
                                <tbody id="tableBody">
                                    <tr>
                                        <td>1</td>
                                        <td>FWA eRegister</td>
                                        <td>2.7</td>
                                        <td><a class="btn btn-flat btn-primary btn-xs btn-view bold" href="#">View</a></td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>FPI eRegister</td>
                                        <td>2.3</td>
                                        <td><a class="btn btn-flat btn-primary btn-xs btn-view bold" href="#">View</a></td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>UFPO eRegister</td>
                                        <td>1.1</td>
                                        <td><a class="btn btn-flat btn-primary btn-xs btn-view bold" href="#">View</a></td>
                                    </tr>
                                    <tr>
                                        <td>4</td>
                                        <td>Monitoring tools</td>
                                        <td>2.0</td>
                                        <td><a class="btn btn-flat btn-primary btn-xs btn-view bold" href="#">View</a></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

        </div>









        <div class="col-md-6 col-xs-12">

            <div class="box box-primary full-screen">
                <div class="box-header with-border" style="padding: 0px;">
                    <p class="box-title">Release notes</p>
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <div class="col-xs-12">
                            <table id="release-notes" class="table table-striped">
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="box box-primary full-screen">
                <div class="box-header with-border" style="padding: 0px;">
                    <p class="box-title">Reports</p>
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <div class="col-xs-12">
                            <table class="table table-striped table-hover dataTable no-footer" id="data-table">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Reports<span class="pull-right"></span></th>
                                        <th class="pull-right">Action</th>
                                    </tr>
                                </thead>
                                <tbody id="tableBody">
                                    <tr>
                                        <td>1</td>
                                        <td>MIS 1 and CSBA report</td>
                                        <td class="pull-right"><a class="btn btn-flat btn-primary btn-xs btn-view bold" href="#">View</a></td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>MIS 2 (FPI)</td>
                                        <td class="pull-right"><a class="btn btn-flat btn-primary btn-xs btn-view bold" href="#">View</a></td>
                                    </tr>
                                    <tr>
                                        <td>4</td>
                                        <td>MIS 4 (Upazila)</td>
                                        <td class="pull-right"><a class="btn btn-flat btn-primary btn-xs btn-view bold" href="#">View</a></td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>Household-wise population</td>
                                        <td class="pull-right"><a class="btn btn-flat btn-primary btn-xs btn-view bold" href="#">View</a></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>


<div id="modalReleaseNote" class="modal fade" role="dialog">
    <div class="modal-dialog report-view">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title"><b><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp; <span id="title">Release notes</span></b> <span id="loading">loading ...</span></h4>
            </div>
            <div class="modal-body">
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