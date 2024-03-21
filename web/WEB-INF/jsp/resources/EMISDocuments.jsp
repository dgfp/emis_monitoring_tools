<%-- 
    Document   : EMISDocuments
    Created on : Dec 2, 2019, 11:44:19 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<style>
    ul {
        padding-inline-start: 20px;
    }
    .description-block {
        text-align: left;
    }
    .box-header.with-border {
        border-bottom: 2px solid #f4f4f4;
    }
    .box-header {
        padding: 4px 10px;
    }
    .box-title {
        position: absolute;
        top: 15px;
        left: 60px;
        font-weight: 600;
    }
    .box-tools {
        top: 12px!important;
    }
    .emis-doc ul { padding-left: 18px; list-style:none; }
    .emis-doc li { margin-bottom:5px; }
    .emis-doc li:before {    
        font-family: 'FontAwesome';
        content: '\f101';
        margin:0 4px 0 -15px;
    }
</style>
<script>
    $(function () {
        //Release note rendered
        var data = [
            {app: 'FWA eRegister', register: 'FWA', version: '2.7', date: '2019-05-15'}
            , {app: 'FPI eSupervision System', register: 'FPI', version: '2.3', date: '2019-05-15'}
            , {app: 'UFPO eManagement System', register: 'UFPO', version: '1.1', date: '2019-05-15'}
            , {app: 'HA eRegister', register: 'HA', version: '2.5', date: '2019-07-31'}

        ];
        $.each(data, function (i, o) {
            $('#release-notes').append('<li><a href="' + [o.register, o.version].join('-') + '" class="btn-view">' + o.app + '</a></li>');
        });
        var $modal = $('.modal#modalReleaseNote').css('padding', 0);
        $('.btn-view').click(function (e) {
            e.preventDefault();
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
<section class="content">
    <div class="row">
        <div class="col-md-3">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <img src="resources/images/doc/manual7.png" alt="Italian Trulli" width="40" height="40">
                    <h3 class="box-title">User Manual</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body emis-doc">
                    <ul>
                        <li><a href="http://www.rhis.net.bd/wp-content/uploads/2016/09/Population-Registration-System.pdf">PRS</a></li>
                        <li><a href="http://www.rhis.net.bd/wp-content/uploads/2017/10/FWA-eRegister-User-Manual-v2.7.pdf">FWA e-Register</a></li>
                        <li><a href="http://www.rhis.net.bd/wp-content/uploads/2016/09/Facility-e-Register-for-Family-Welfare-Visitor-FWV.pdf">FWV e-Register</a></li>
                        <li><a href="http://www.rhis.net.bd/wp-content/uploads/2016/09/FPI-eSupervision-User-Manual-v2.3.pdf">FPI e-Supervision System</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="box box-success">
                <div class="box-header with-border">
                    <img src="resources/images/doc/note.png" alt="Italian Trulli" width="40" height="40">
                    <h3 class="box-title">Release notes</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body emis-doc">
                    <ul id="release-notes">
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="box box-warning">
                <div class="box-header with-border">
                    <img src="resources/images/doc/code2.png" alt="Italian Trulli" width="40" height="40">
                    <h3 class="box-title">Source code</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body emis-doc">
                    <ul>
                        <li><a href="#">FWA eRegister</a></li>
                        <li><a href="#">FPI e-Supervision System</a></li>
                        <li><a href="#">UFPO e-Supervision System</a></li>
                        <li><a href="#">Monitoring Tools</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="box box-danger">
                <div class="box-header with-border">
                    <img src="resources/images/doc/report3.png" alt="Italian Trulli" width="40" height="40">
                    <h3 class="box-title">Reports</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body emis-doc">
                    <ul>
                        <li><a href="#">MIS 1 (FWA)</a></li>
                        <li><a href="#">MIS 2 (FPI)</a></li>
                        <li><a href="#">MIS 4 (Upazila)</a></li>
                        <li><a href="#">ELCO by acceptor status</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>







    <div class="row">
        <div class="col-md-3">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <img src="resources/images/doc/brochure1.png" alt="Italian Trulli" width="40" height="40">
                    <h3 class="box-title">Brochure</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body emis-doc">
                    <ul>
                        <li><a href="#">Brochure title 1</a></li>
                        <li><a href="#">Brochure title 2</a></li>
                        <li><a href="#">Brochure title 3</a></li>
                        <li><a href="#">Brochure title 4</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="box box-success">
                <div class="box-header with-border">
                    <img src="resources/images/doc/flowchart2.png" alt="Italian Trulli" width="40" height="40">
                    <h3 class="box-title">Flowchart</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body emis-doc">
                    <ul>
                        <li><a href="#">Flowchart title 1</a></li>
                        <li><a href="#">Flowchart title 2</a></li>
                        <li><a href="#">Flowchart title 3</a></li>
                        <li><a href="#">Flowchart title 4</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="box box-warning">
                <div class="box-header with-border">
                    <img src="resources/images/doc/er1.png" alt="Italian Trulli" width="40" height="40">
                    <h3 class="box-title">ER diagram</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body emis-doc">
                    <ul>
                        <li><a href="#">ER diagram title 1</a></li>
                        <li><a href="#">ER diagram title 2</a></li>
                        <li><a href="#">ER diagram title 3</a></li>
                        <li><a href="#">ER diagram title 4</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="box box-danger">
                <div class="box-header with-border">
                    <img src="resources/images/doc/er2.png" alt="Italian Trulli" width="40" height="40">
                    <h3 class="box-title">Data dictionary</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body emis-doc">
                    <ul>
                        <li><a href="#">Data dictionary title 1</a></li>
                        <li><a href="#">Data dictionary title 2</a></li>
                        <li><a href="#">Data dictionary title 3</a></li>
                        <li><a href="#">Data dictionary title 4</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>

<div id="modalReleaseNote" class="modal fade" role="dialog">
    <div class="modal-dialog report-view box-danger">
        <div class="modal-content">
            <div class="modal-header with-border label-success">
                <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold">Release notes</h4>
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