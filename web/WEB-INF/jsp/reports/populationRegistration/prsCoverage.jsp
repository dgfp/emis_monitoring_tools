<%-- 
    Document   : registrationCoverage
    Created on : Dec 28, 2016, 9:49:35 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/TemplateJs/Chart.bundle.js" type="text/javascript"></script>
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
</style>
<script>
    $(function () {
        $('#provtypeWise').on('change', function () {
            $('label[for=provtypeWise]').toggleClass('checked');
        });
        var $clickable = $('.clickable').on('click', function (e) {
            var $target = $(e.currentTarget);
            var index = $clickable.index($target)
            $clickable.removeClass('selected-color');
            $target.toggleClass('selected-color');

        });
    })
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>Progress of Population Registration<small></small></h1>
</section>
<!-- Main content -->
<section class="content">
    <div class="row"  id="areaPanel">
        <div class="col-md-12">
            <div class="box box-primary">
                <!--                <div class="box-header with-border">
                                    <div class="box-tools pull-right" style="margin-top: -10px;">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                        </button>
                                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                                    </div>
                                </div>-->
                <!-- /.box-header -->
                <div class="box-body" id="a">
                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <label for="division">Division</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="divid" id="division"><option value="">- Select Division -</option></select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="zilla">District</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="zillaid" id="zilla"> 
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
                            <label for="startDate">From</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="startDate" id="startDate">
                                <option value="">- From -</option>
                            </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="endDate">To</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="endDate" id="endDate">
                                <option value="">- To -</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-xs-2">
                            <label for="provtypeWise" class="center" style="line-height:1em;">Provider Wise?</span>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <input type="checkbox" name="provtypeWise" id="provtypeWise" class="hidden">
                            <select class="form-control" name="provtype" id="provtype">
                                <option value="%">All</option>
                                <option value="2">HA</option>
                                <option value="3">FWA</option>
                            </select>
                        </div>
                        <div class="col-md-2 col-xs-4 col-md-offset-1 col-xs-offset-2">        
                            <button type="button" id="btn-data" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block" autocomplete="off" >
                                <b><i class="fa fa-table" aria-hidden="true"></i> Show data</b>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row info-box-md-container">
        <div class="col-md-6">
            <div class="row">
                <div class="col-md-6">
                    <div class="info-box bg-white">
                        <span class="info-box-icon bg-yellow"><i class="fa fa-home"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">Household</span>
                            <span class="info-box-number">0%</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="info-box bg-white">
                        <span class="info-box-icon bg-green"><i class="fa fa-users"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">Population</span>
                            <span class="info-box-number">0%</span>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="col-md-6">
            <div class="row">
                <div class="col-md-4">
                    <div class="info-box bg-white selected-color clickable">
                        <span class="info-box-icon bg-aqua"><i class="fa fa-table"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text"><h4></h4></span>
                            <span class="info-box-number center">Table</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="info-box bg-white clickable">
                        <span class="info-box-icon bg-aqua"><i class="fa fa-pie-chart"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text"><h4></h4></span>
                            <span class="info-box-number center">Chart</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="info-box bg-white clickable">
                        <span class="info-box-icon bg-aqua"><i class="fa fa-map-o"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text"><h4></h4></span>
                            <span class="info-box-number center">Map</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!------------------------------Load progress percentage Dashboard Data----------------------------------->
    <div class="row" id="dashboard">
    </div>

    <!--PRS Data Table-->
    <div class="box box-primary full-screen" id="tableView">
        <div class="box-header with-border">
            <h3 class="box-title"><b></b>Tabular Presentation</h3>
            <div class="box-tools pull-right" style="margin-top: 0px;">
                <button id="printTableBtn" type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <a href="#" id ="exportCSV" role='button' class="btn btn-box-tool"><i class="fa fa-file-excel-o" aria-hidden="true"></i>&nbsp;CSV</a>
                <a href="#" id ="exportText" role='button' class="btn btn-box-tool"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Text</a>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>

        <div class="box-body">
            <!--Data Table-->               
            <div class="col-ld-12" id="">
                <div class="table-responsive fixed" >
                    <div id="dvData">
                        <table class="table table-bordered table-striped table-hover" id="data-table">
                            <thead id="tableHeader" class="data-table">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter" class="data-table">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--PRS Data Chart-->
    <div class="box box-primary full-screen" id="graphView">
        <div class="box-header with-border">
            <h3 class="box-title"><b></b>Graphical Presentation</h3>
            <div class="box-tools pull-right" style="margin-top: 0px;">
                <button id="printChartBtn" type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body" id="printChart">
            <div class="table-responsive" >
                <div id="chart"></div>
                <br/>
            </div>
        </div>
    </div>

    <!--PRS Data Map-->
    <div class="box box-primary" id="mapView">
        <div class="box-header with-border">
            <h3 class="box-title"><b></b>Map Presentation</h3>
            <div class="box-tools pull-right" style="margin-top: 0px;">
                <button type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print</button>
                <button type="button" class="btn btn-box-tool"><i class="fa fa-file-pdf-o" aria-hidden="true"></i>&nbsp;PDF</button>
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                <button id="closeGraph" type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
            </div>
        </div>
        <div class="box-body">
            <div class="table-responsive" >
            </div>
        </div>
    </div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script src="resources/js/prsDropDowns.js" type="text/javascript"></script>