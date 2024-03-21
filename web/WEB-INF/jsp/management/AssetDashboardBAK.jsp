<%-- 
    Document   : AssetDashboardBAK
    Created on : Feb 3, 2021, 4:13:00 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/AssetDashboard/TabletStockStatus.js" type="text/javascript"></script>
<script src="resources/js/AssetDashboard/TabletFunctionalityStatus.js" type="text/javascript"></script>
<script src="resources/js/AssetDashboard/ProjectedPurchaseNeed.js" type="text/javascript"></script>
<script src="resources/js/AssetDashboard/NumberOfTabletsLost.js" type="text/javascript"></script>
<link href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css"/>
<style>
    .small-box h3 {
        font-size: 32px;
        margin: 0 0 -2px 0;
    }
    .small-box p {
        font-size: 14px;
        margin: 0px 0 -9px;
        font-weight: bold;
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
        padding-bottom: 16px!important;
    }
    table{
        table-layout: fixed;
    }
    .wd-80{
        width: 80px;
    }
    .modelName{
        width: 70px;
    }
    .needToPurchase{
        width: 120px;
    }
    .d{
        margin-right: 4.2%;
    }
    .info-box-number {
        font-size: 28px;
        color: #00324f;
    }
    .info-box-text {
        text-transform: capitalize;
        font-weight: bold;
        color: #00324f;
    }
    .label-progress {
        width: 80%;
        padding: 0.3em .6em .3em;
        font-weight: 700;
        line-height: 1.0;
        text-align: center;
        white-space: nowrap;
        border-radius: 10.8em;
        color: #fff;
    }
    .centerText{
        /*        margin-left:auto; 
                margin-right:auto;
                vertical-align: middle;
                text-align: center;*/
        display: table-cell;
        vertical-align : middle;text-align:center;
    }
    .table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
        vertical-align: middle;
    }
</style>
<style>
    .status-box {
        position: relative;
        border-radius: 3px;
        background: #ffffff;
        border-top: 3px solid #d2d6de;
        margin-bottom: 15px;
        width: 100%;
        box-shadow: 0 1px 1px rgba(0,0,0,0.1);
    }
    .status-box-body {
        border-top-left-radius: 0;
        border-top-right-radius: 0;
        border-bottom-right-radius: 3px;
        border-bottom-left-radius: 3px;
        /*        padding: 10px;*/
        padding-top: 10px;
        padding-right: 10px;
        padding-bottom: 2px!important;
        padding-left: 10px;
    }
    .status-box.box-success {
        border-top-color: #00a65a;
    }
    .status-box.box-primary {
        border-top-color: #3c8dbc;
    }
    .status-box.box-info {
        border-top-color: #00c0ef;
    }
    .status-box.box-warning {
        border-top-color: #f39c12;
    }
    .status-box.box-danger {
        border-top-color: #dd4b39;
    }
    .status-box-body> .box-title{
        font-size: 15px;
    }
    .box-title{
        padding: 2px 0px;
        border-radius: 5px;
        text-align: center;
        margin-top: -4px;
        color: #fff;
    }
    .box-title-success{
        background-color: #449D44;
    }
    .box-title-primary{
        background-color: #286090;
    }
    .box-title-info{
        background-color: #31B0D5;
    }
    .box-title-warning{
        background-color: #EC971F;
    }
    .box-title-danger{
        background-color: #C9302C;
    }
    .status-box-body  > p{
        font-size: 17px;
    }
</style>
<script>
    $(function () {
        var $clickable = $('.btn-tab').on('click', function (e) {
            var $target = $(e.currentTarget);
            var index = $clickable.index($target);
            console.log($target);
            console.log($clickable);
            console.log(index);
            $("#" + $target.parent('p').attr('id')).children().removeClass('btn-primary');
            $("#" + $target.parent('p').attr('id')).children().addClass('btn-default');
            $target.removeClass('btn-default');
            $target.toggleClass('btn-primary');
        });
        if ($.app.user.userlevel == 2 || $.app.user.userlevel == 3 || $.app.user.userlevel == 4) {
            $(".breadcrumb").html("");
        }

        if ($.app.user.userlevel == 2 || $.app.user.userlevel == 3 || $.app.user.userlevel == 4) {
            $("#age-of-tablet").css("display", "none");
            $("#tablet-status-by-warranty-period").css("display", "none");
            $("#tablet-repair-status").css("display", "none");
        }

        if ($.app.user.userlevel == 2 || $.app.user.userlevel == 3 || $.app.user.userlevel == 4) {
            $("#distributeType").text("Received");
            $("#store").text("Local Store");
        } else {
            $("#distributeType").text("Purchased");
            $("#store").text("Central Store");
        }




        $(".box-title").on('click', function (event) {

            // Make sure this.hash has a value before overriding default behavior
            if (this.hash !== "") {
                // Prevent default anchor click behavior
                event.preventDefault();

                // Store hash
                var hash = this.hash;

                // Using jQuery's animate() method to add smooth page scroll
                // The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
                $('html, body').animate({
                    scrollTop: $(hash).offset().top
                }, 600, function () {

                    // Add hash (#) to URL when done scrolling (default click behavior)
                    window.location.hash = hash;
                });
            } // End if
        });
    });
</script>
<section class="content-header">
    <h1 id="pageTitle">Asset Dashboard</h1>
    <ol class="breadcrumb">
        <a class="btn btn-flat btn-primary btn-sm" href="asset-dashboard"><b>Dashboard</b></a>
        <a class="btn btn-flat btn-default btn-sm" href="asset-reports"><b>Details</b></a>
        <a class="btn btn-flat btn-default btn-sm" href="asset-management"><b>Manage</b></a>
    </ol>
</section>
<section class="content">

    <div class="row status-row" id="status-row" style="display: block;">
        <div class="col-md-3  col-xs-6">
            <div class="status-box box-success">
                <div class="status-box-body emis-doc">
                    <a href="#projected_purchase_need_link" class="status-details box-title" id="2"><h3 id="status_total_need" class="box-title box-title-success bold">0</h3></a>
                    <p class="center bold">Total Need</p>
                </div>
            </div>
        </div>

        <div class="col-md-3 col-xs-6">
            <div class="box box-primary">
                <div class="status-box-body emis-doc">
                    <a href="#tablet_stock_status_link" class="status-details box-title" id="2"><h3 id="status_purchased" class="box-title box-title-primary bold">0</h3></a>
                    <p id="distributeType" class="center bold">Purchased</p>
                </div>
            </div>
        </div>

        <div class="col-md-3 col-xs-6">
            <div class="box box-info">
                <div class="status-box-body emis-doc">
                    <a href="#tablet_stock_status_link" class="status-details box-title" id="2"><h3 id="status_distributed" class="box-title box-title-info bold">0</h3></a>
                    <p class="center bold">Distributed</p>
                </div>
            </div>
        </div>

        <div class="col-md-3 col-xs-6">
            <div class="box box-warning">
                <div class="status-box-body emis-doc">
                    <a href="#tablet_stock_status_link" class="status-details box-title" id="2"><h3 id="status_central_store" class="box-title box-title-warning bold">0</h3></a>
                    <p id="store" class="center bold">Central Store</p>
                </div>
            </div>
        </div>
    </div>


    <div class="row status-row" id="status-row" style="display: block;">
        <div class="col-md-3  col-xs-6">
            <div class="status-box box-success">
                <div class="status-box-body emis-doc">
                    <a href="#tablet_functionality_status_title" class="status-details box-title" id="2"><h3 id="status_functional" class="box-title box-title-success bold">0</h3></a>
                    <p class="center bold">Functional</p>
                </div>
            </div>
        </div>

        <div class="col-md-3 col-xs-6">
            <div class="box box-primary">
                <div class="status-box-body emis-doc">
                    <a href="#tablet-repair-status" class="status-details box-title" id="2"><h3 id="status_repairable" class="box-title box-title-primary bold">0</h3></a>
                    <p class="center bold">Non-functional (Repairable)</p>
                </div>
            </div>
        </div>

        <div class="col-md-3 col-xs-6">
            <div class="box box-info">
                <div class="status-box-body emis-doc">
                    <a href="#tablet-repair-status" class="status-details box-title" id="2"><h3 id="status_vendor" class="box-title box-title-info bold">0</h3></a>
                    <p class="center bold">Vendor</p>
                </div>
            </div>
        </div>

        <div class="col-md-3 col-xs-6">
            <div class="box box-warning">
                <div class="status-box-body emis-doc">
                    <a href="#tablet-repair-status" class="status-details box-danger" id="2"><h3 id="status_repaired" class="box-title box-title-warning bold">0</h3></a>
                    <p class="center bold">Repaired</p>
                </div>
            </div>
        </div>
    </div>


    <div class="row status-row" id="status-row" style="display: block;">
        <div class="col-md-4 col-xs-6">
            <div class="box box-info">
                <div class="status-box-body emis-doc">
                    <a href="#age-of-tablet" class="status-details box-title" id="2"><h3 id="status_over_3_years" class="box-title box-title-info bold">0</h3></a>
                    <p class="center bold">Over 36 months</p>
                </div>
            </div>
        </div>

        <div class="col-md-4 col-xs-6">
            <div class="box box-warning">
                <div class="status-box-body emis-doc">
                    <a href="#tablet_functionality_status_title" class="status-details box-title" id="2"><h3 id="status_damaged" class="box-title box-title-warning bold">0</h3></a>
                    <p class="center bold">Damaged</p>
                </div>
            </div>
        </div>

        <div class="col-md-4 col-xs-6">
            <div class="box box-danger">
                <div class="status-box-body emis-doc">
                    <a href="#tablet_functionality_status_title" class="status-details box-title" id="2"><h3 id="status_lost" class="box-title box-title-danger bold">0</h3></a>
                    <p class="center bold">Lost</p>
                </div>
            </div>
        </div>
    </div>






    <!--    <div class="row" id="areaPanel">
            <div class="col-md-12">
                <span id="dashboard">
                    <div class="col-lg-3 col-xs-6" style="">
                        <div class="small-box bg-green">
                            <div class="inner">
                                <h3 id="status_total_need">0</h3>
                                <p>Total Need</p>
                            </div>
                            <p class="small-box-footer">&nbsp;Total Need</p>   
                        </div>
                    </div>
                    <div class="col-lg-3 col-xs-6" style="">
                        <div class="small-box bg-blue">
                            <div class="inner">
                                <h3 id="status_purchased">0</h3>
                                <p id="distributeType">Purchased</p>
                            </div>
                            <p class="small-box-footer">&nbsp;</p>                       
                        </div>
                    </div>
                    <div class="col-lg-3 col-xs-6" style="">
                        <div class="small-box bg-aqua">
                            <div class="inner">
                                <h3 id="status_distributed">0</h3>
                                <p>Distributed</p>
                            </div>
                            <p class="small-box-footer">&nbsp;</p>                 
                        </div>
                    </div>
                    <div class="col-lg-3 col-xs-6" style="">
                        <div class="small-box bg-yellow">
                            <div class="inner">
                                <h3 id="status_central_store">0</h3>
                                <p id="store">Central Store</p>
                            </div>
                            <p class="small-box-footer">&nbsp;</p>    
                        </div>
                    </div>
                </span>
            </div>
        </div>
    
        <div class="row" id="areaPanel">
            <div class="col-md-12">
                <span id="dashboard">
                    <div class="col-lg-3 col-xs-6" style="">
                        <div class="small-box bg-green">
                            <div class="inner">
                                <h3 id="status_functional">0</h3>
                                <p>Functional</p>
                            </div>
                            <p class="small-box-footer">&nbsp;</p>   
                        </div>
                    </div>
                    <div class="col-lg-3 col-xs-6" style="">
                        <div class="small-box bg-blue">
                            <div class="inner">
                                <h3 id="status_repairable">0</h3>
                                <p>Non-functional (Repairable)</p>
                            </div>
                            <p class="small-box-footer">&nbsp;</p>                       
                        </div>
                    </div>
                    <div class="col-lg-3 col-xs-6" style="">
                        <div class="small-box bg-aqua">
                            <div class="inner">
                                <h3 id="status_vendor">0</h3>
                                <p>Vendor</p>
                            </div>
                            <p class="small-box-footer">&nbsp;</p>                 
                        </div>
                    </div>
                    <div class="col-lg-3 col-xs-6" style="">
                        <div class="small-box bg-yellow">
                            <div class="inner">
                                <h3 id="status_repaired">0</h3>
                                <p>Repaired</p>
                            </div>
                            <p class="small-box-footer">&nbsp;</p>    
                        </div>
                    </div>
                </span>
            </div>
        </div>
    
        <div class="row" id="areaPanel">
            <div class="col-md-12">
                <span id="dashboard">
                    <div class="col-lg-4 col-xs-6" style="">
                        <div class="small-box bg-blue">
                            <div class="inner">
                                <h3 id="status_over_3_years">0</h3>
                                <p>Over 3 Years</p>
                            </div>
                            <p class="small-box-footer">&nbsp;</p>   
                        </div>
                    </div>
                    <div class="col-lg-4 col-xs-6" style="">
                        <div class="small-box bg-orange">
                            <div class="inner">
                                <h3 id="status_damaged">0</h3>
                                <p>Damaged</p>
                            </div>
                            <p class="small-box-footer">&nbsp;</p>                       
                        </div>
                    </div>
                    <div class="col-lg-4 col-xs-6" style="">
                        <div class="small-box bg-red">
                            <div class="inner">
                                <h3 id="status_lost">0</h3>
                                <p>Lost</p>
                            </div>
                            <p class="small-box-footer">&nbsp;</p>                 
                        </div>
                    </div>
                </span>
            </div>
        </div>-->




    <div class="row main">
        <div class="col-md-6" id="tablet_stock_status_link">
            <h4 class="bold">Tablet Stock Status</h4>
            <div class="box box-primary full-screen">
                <div class="box-header with-border" style="padding: 0px;">
                    <p class="box-title bold" style="font-size: 15px;padding: 2px;padding-left: 5px;"></p>
                    <p class="box-title" id="tablet_stock_status_title" style="font-size: 14px;">
                        <a href="#tablet-stock-status-table" class="btn btn-flat btn-primary btn-xs bold btn-tab" data-toggle="tab" aria-expanded="false">&nbsp;Table</a>
                        <a href="#tablet-stock-status-chart" class="btn btn-flat btn-default btn-xs bold btn-tab" data-toggle="tab" aria-expanded="false">&nbsp;Chart</a>
                    </p>
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <!--                        <button type="button" class="btn btn-flat btn-default btn-xs bold" id="exportPrint"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print - PDF</button>
                                                <a href="#" id ="exportCSV" role='button' class="btn btn-flat btn-default btn-xs bold" style="width:80px;"><i class="fa fa-file-excel-o" aria-hidden="true"></i>&nbsp;Excel</a>-->
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <form action="asset-dashboard" method="post" id="showTabletStockStatus">
                            <div class="col-md-3 col-xs-4 input-area">
                                <div class="form-group">
                                    <label for="sel1">Division:</label>
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="division1" id="division1"> 
                                        <option value="0">All</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-3 col-xs-4 input-area">
                                <div class="form-group">
                                    <label for="sel1">District:</label>
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="district1" id="district1"> 
                                        <option value="0">All</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-3 col-xs-4 input-area">
                                <div class="form-group">
                                    <label for="sel1">Upazila:</label>
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="upazila1" id="upazila1"> 
                                        <option value="0">All</option>
                                    </select>
                                </div>
                            </div>


                            <div class="col-md-3 col-xs-4">
                                <div class="form-group">
                                    <label for="usr">&nbsp;</label>
                                    <button type="submit" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                        <i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; Show data
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="tab-content no-padding">
                        <div class="row tab-pane active" id="tablet-stock-status-table">
                            <div class="col-md-12">
                                <table id="tablet_stock_status" class="table table-striped">
                                    <thead id="tableHeader">
                                    </thead>
                                    <tbody id="tableBody">
                                    </tbody>
                                    <tfoot align="right">
                                        <tr>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <div class="row tab-pane" id="tablet-stock-status-chart">
                            <div class="col-md-12" id="tablet_stock_status_chart">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>









        <div class="col-md-6" id="tablet_functionality_status_link">
            <h4 class="bold">Tablet Functionality Status</h4>
            <div class="box box-primary full-screen">
                <div class="box-header with-border" style="padding: 0px;">
                    <p class="box-title bold" style="font-size: 15px;padding: 2px;padding-left: 5px;"></p>
                    <p class="box-title" id="tablet_functionality_status_title" style="font-size: 14px;">
                        <a href="#tablet-functionality-status-table" class="btn btn-flat btn-primary btn-xs bold btn-tab" data-toggle="tab" aria-expanded="false">&nbsp;Table</a>
                        <a href="#tablet-functionality-status-chart" class="btn btn-flat btn-default btn-xs bold btn-tab" data-toggle="tab" aria-expanded="false">&nbsp;Chart</a>
                    </p>
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <form action="asset-dashboard" method="post" id="showTabletFunctionalityStatus">
                            <div class="col-md-3 col-xs-4 input-area">
                                <div class="form-group">
                                    <label for="sel1">Division:</label>
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="division2" id="division2"> 
                                        <option value="0">All</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-3 col-xs-4 input-area">
                                <div class="form-group">
                                    <label for="sel1">District:</label>
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="district2" id="district2"> 
                                        <option value="0">All</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-3 col-xs-4 input-area">
                                <div class="form-group">
                                    <label for="sel1">Upazila:</label>
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="upazila2" id="upazila2"> 
                                        <option value="0">All</option>
                                    </select>
                                </div>
                            </div>


                            <div class="col-md-3 col-xs-4">
                                <div class="form-group">
                                    <label for="usr">&nbsp;</label>
                                    <button type="submit" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                        <i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; Show data
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="tab-content no-padding">
                        <div class="row tab-pane active" id="tablet-functionality-status-table">
                            <div class="col-md-12">
                                <table id="tablet_functionality_status" class="table table-striped">
                                    <thead id="tableHeader">
                                    </thead>
                                    <tbody id="tableBody">
                                    </tbody>
                                    <tfoot align="right">
                                        <tr>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <div class="row tab-pane" id="tablet-functionality-status-chart">
                            <div class="col-md-12" id="tablet_functionality_status_chart">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>










    <div class="row" id="areaPanel">
        <div class="col-md-6" id="age-of-tablet">
            <h4 class="bold">Age of Tablet</h4>
            <div class="box box-primary full-screen">
                <div class="box-header with-border" style="padding: 0px;">
                    <p class="box-title bold" style="font-size: 15px;padding: 2px;padding-left: 5px;"></p>
                    <p class="box-title" id="age_of_tablet_title" style="font-size: 14px;">
                        <a href="#age-of-tablet-table" class="btn btn-flat btn-primary btn-xs bold btn-tab" data-toggle="tab" aria-expanded="false">&nbsp;Table</a>
                        <a href="#age-of-tablet-chart" class="btn btn-flat btn-default btn-xs bold btn-tab" data-toggle="tab" aria-expanded="false">&nbsp;Chart</a>
                    </p>
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <!--                        <button type="button" class="btn btn-flat btn-default btn-xs bold" id="exportPrint"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print - PDF</button>
                                                <a href="#" id ="exportCSV" role='button' class="btn btn-flat btn-default btn-xs bold" style="width:80px;"><i class="fa fa-file-excel-o" aria-hidden="true"></i>&nbsp;Excel</a>-->
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <!--                    <div class="row">
                                            <form action="asset-dashboard" method="post" id="showAgeOfTablet">
                                                <div class="col-md-3 col-xs-4 input-area">
                                                    <div class="form-group">
                                                        <label for="sel1">Division:</label>
                                                        <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="division3" id="division3"> 
                                                            <option value="0">All</option>
                                                        </select>
                                                    </div>
                                                </div>
                    
                                                <div class="col-md-3 col-xs-4 input-area">
                                                    <div class="form-group">
                                                        <label for="sel1">District:</label>
                                                        <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="district3" id="district3"> 
                                                            <option value="0">All</option>
                                                        </select>
                                                    </div>
                                                </div>
                    
                                                <div class="col-md-3 col-xs-4 input-area">
                                                    <div class="form-group">
                                                        <label for="sel1">Upazila:</label>
                                                        <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="upazila3" id="upazila3"> 
                                                            <option value="0">All</option>
                                                        </select>
                                                    </div>
                                                </div>
                    
                    
                                                <div class="col-md-3 col-xs-4">
                                                    <div class="form-group">
                                                        <label for="usr">&nbsp;</label>
                                                        <button type="submit" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                                            <i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; Show data
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>-->
                    <div class="tab-content no-padding">
                        <div class="row tab-pane active" id="age-of-tablet-table">
                            <div class="col-md-12">
                                <table id="age_of_tablet" class="table table-striped">
                                    <thead id="tableHeader">
                                    </thead>
                                    <tbody id="tableBody">
                                    </tbody>
                                    <tfoot align="right">
                                        <tr>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <div class="row tab-pane" id="age-of-tablet-chart">
                            <div class="col-md-12" id="age_of_tablet_chart">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6" id="tablet-status-by-warranty-period">
            <h4 class="bold">Tablet Status by Warranty Period</h4>
            <div class="box box-primary full-screen">
                <div class="box-header with-border" style="padding: 0px;">
                    <p class="box-title bold" style="font-size: 15px;padding: 2px;padding-left: 5px;"></p>
                    <p class="box-title" id="tablet_status_by_warranty_period_title" style="font-size: 14px;">
                        <a href="#tablet-status-by-warranty-period-table" class="btn btn-flat btn-primary btn-xs bold btn-tab" data-toggle="tab" aria-expanded="false">&nbsp;Table</a>
                        <a href="#tablet-status-by-warranty-period-chart" class="btn btn-flat btn-default btn-xs bold btn-tab" data-toggle="tab" aria-expanded="false">&nbsp;Chart</a>
                    </p>
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <!--                    <div class="row">
                                            <form action="asset-dashboard" method="post" id="showAgeOfTablet">
                                                <div class="col-md-3 col-xs-4 input-area">
                                                    <div class="form-group">
                                                        <label for="sel1">Division:</label>
                                                        <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="division4" id="division4"> 
                                                            <option value="0">All</option>
                                                        </select>
                                                    </div>
                                                </div>
                    
                                                <div class="col-md-3 col-xs-4 input-area">
                                                    <div class="form-group">
                                                        <label for="sel1">District:</label>
                                                        <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="district4" id="district4"> 
                                                            <option value="0">All</option>
                                                        </select>
                                                    </div>
                                                </div>
                    
                                                <div class="col-md-3 col-xs-4 input-area">
                                                    <div class="form-group">
                                                        <label for="sel1">Upazila:</label>
                                                        <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="upazila4" id="upazila4"> 
                                                            <option value="0">All</option>
                                                        </select>
                                                    </div>
                                                </div>
                    
                    
                                                <div class="col-md-3 col-xs-4">
                                                    <div class="form-group">
                                                        <label for="usr">&nbsp;</label>
                                                        <button type="submit" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block bold disabled" autocomplete="off" >
                                                            <i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; Show data
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>-->


                    <div class="tab-content no-padding" style="margin-bottom: 15px;">
                        <div class="row tab-pane active" id="tablet-status-by-warranty-period-table">
                            <div class="col-md-12">
                                <table id="tablet_status_by_warranty_period" class="table table-striped">
                                    <thead id="tableHeader">
                                    </thead>
                                    <tbody id="tableBody">
                                    </tbody>
                                    <tfoot align="right">
                                        <tr>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <div class="row tab-pane" id="tablet-status-by-warranty-period-chart">
                            <div class="col-md-12" id="tablet_status_by_warranty_chart">
                                <h2 class="center">Chart will goes here</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>










    <div class="row main">
        <div class="col-md-12" id="projected_purchase_need_link">
            <h4 class="bold">Projected Purchase Need</h4>
            <div class="box box-primary full-screen">
                <div class="box-header with-border" style="padding: 0px;">
                    <p class="box-title bold" style="font-size: 15px;padding: 2px;padding-left: 5px;"></p>
                    <p class="box-title" id="projected_purchase_need_title" style="font-size: 14px;">
                        <a href="#projected-purchase-need-table" class="btn btn-flat btn-primary btn-xs bold btn-tab" data-toggle="tab" aria-expanded="false">&nbsp;Table</a>
                        <a href="#projected-purchase-need-chart" class="btn btn-flat btn-default btn-xs bold btn-tab" data-toggle="tab" aria-expanded="false">&nbsp;Chart</a>
                    </p>
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <form action="asset-dashboard" method="post" id="showProjectedPurchaseNeed">
                            <div class="col-md-3 col-xs-4 input-area">
                                <div class="form-group">
                                    <label for="sel1">Division:</label>
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="division3" id="division3"> 
                                        <option value="0">All</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-3 col-xs-4 input-area">
                                <div class="form-group">
                                    <label for="sel1">District:</label>
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="district3" id="district3"> 
                                        <option value="0">All</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-3 col-xs-4 input-area">
                                <div class="form-group">
                                    <label for="sel1">Upazila:</label>
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="upazila3" id="upazila3"> 
                                        <option value="0">All</option>
                                    </select>
                                </div>
                            </div>


                            <div class="col-md-3 col-xs-4">
                                <div class="form-group">
                                    <label for="usr">&nbsp;</label>
                                    <button type="submit" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                        <i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; Show data
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="tab-content no-padding">
                        <div class="row tab-pane active" id="projected-purchase-need-table">
                            <div class="col-md-12">
                                <table id="projected_purchase_need" class="table table-striped">
                                    <thead id="tableHeader">
                                    </thead>
                                    <tbody id="tableBody">
                                    </tbody>
                                    <tfoot align="right">
                                        <tr>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </tfoot>
                                </table>
                                <p class="bold" style="color:red">* 10% added to actual number</p>
                            </div>
                        </div>
                        <div class="row tab-pane" id="projected-purchase-need-chart">
                            <div class="col-md-12" id="projected_purchase_need_chart">
                                <h2 class="center">Chart will goes here</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>








    <div class="row">
        <div class="col-md-6" id="number_of_tablets_lost_link">
            <h4 class="bold">Number of Tablets Lost</h4>
            <div class="box box-primary full-screen">
                <div class="box-header with-border" style="padding: 0px;">
                    <p class="box-title bold" style="font-size: 15px;padding: 2px;padding-left: 5px;"></p>
                    <p class="box-title" id="number_of_tablets_lost_title" style="font-size: 14px;">
                        <a href="#number-of-tablets-lost-table" class="btn btn-flat btn-primary btn-xs bold btn-tab" data-toggle="tab" aria-expanded="false">&nbsp;Table</a>
                        <a href="#number-of-tablets-lost-chart" class="btn btn-flat btn-default btn-xs bold btn-tab" data-toggle="tab" aria-expanded="false">&nbsp;Chart</a>
                    </p>
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <form action="asset-dashboard" method="post" id="showNumberOfTabletsLost">
                            <div class="col-md-3 col-xs-4 input-area">
                                <div class="form-group">
                                    <label for="sel1">Division:</label>
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="division4" id="division4"> 
                                        <option value="0">All</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-3 col-xs-4 input-area">
                                <div class="form-group">
                                    <label for="sel1">District:</label>
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="district4" id="district4"> 
                                        <option value="0">All</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-3 col-xs-4 input-area">
                                <div class="form-group">
                                    <label for="sel1">Upazila:</label>
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="upazila4" id="upazila4"> 
                                        <option value="0">All</option>
                                    </select>
                                </div>
                            </div>


                            <div class="col-md-3 col-xs-4">
                                <div class="form-group">
                                    <label for="usr">&nbsp;</label>
                                    <button type="submit" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                        <i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; Show data
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="tab-content no-padding">
                        <div class="row tab-pane active" id="number-of-tablets-lost-table">
                            <div class="col-md-12">
                                <table id="number_of_tablets_lost" class="table table-striped">
                                    <thead id="tableHeader">
                                    </thead>
                                    <tbody id="tableBody">
                                    </tbody>
                                    <tfoot align="right">
                                        <tr>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <div class="row tab-pane" id="number-of-tablets-lost-chart">
                            <div class="col-md-12" id="number_of_tablets_lost_chart">
                                <h2 class="center">Chart will goes here</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6" id="tablet-repair-status">
            <h4 class="bold">Tablet Repair Status</h4>
            <div class="box box-primary full-screen">
                <div class="box-header with-border" style="padding: 0px;">
                    <p class="box-title bold" style="font-size: 15px;padding: 2px;padding-left: 5px;"></p>
                    <p class="box-title" id="tablet_repair_status_title" style="font-size: 14px;">
                        <a href="#tablet-repair-status-table" class="btn btn-flat btn-primary btn-xs bold btn-tab" data-toggle="tab" aria-expanded="false">&nbsp;Table</a>
                        <a href="#tablet-repair-status-chart" class="btn btn-flat btn-default btn-xs bold btn-tab" data-toggle="tab" aria-expanded="false">&nbsp;Chart</a>
                    </p>
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <!--                    <div class="row">
                                            <form action="asset-dashboard" method="post" id="showAgeOfTablet">
                                                <div class="col-md-3 col-xs-4 input-area">
                                                    <div class="form-group">
                                                        <label for="sel1">Division:</label>
                                                        <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="division4" id="division4"> 
                                                            <option value="0">All</option>
                                                        </select>
                                                    </div>
                                                </div>
                    
                                                <div class="col-md-3 col-xs-4 input-area">
                                                    <div class="form-group">
                                                        <label for="sel1">District:</label>
                                                        <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="district4" id="district4"> 
                                                            <option value="0">All</option>
                                                        </select>
                                                    </div>
                                                </div>
                    
                                                <div class="col-md-3 col-xs-4 input-area">
                                                    <div class="form-group">
                                                        <label for="sel1">Upazila:</label>
                                                        <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="upazila4" id="upazila4"> 
                                                            <option value="0">All</option>
                                                        </select>
                                                    </div>
                                                </div>
                    
                    
                                                <div class="col-md-3 col-xs-4">
                                                    <div class="form-group">
                                                        <label for="usr">&nbsp;</label>
                                                        <button type="submit" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                                            <i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; Show data
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>-->


                    <div class="tab-content no-padding" style="margin-bottom: 111px;">
                        <div class="row tab-pane active" id="tablet-repair-status-table">
                            <div class="col-md-12">
                                <table id="tablet_repair_status" class="table table-striped">
                                    <thead id="tableHeader">
                                    </thead>
                                    <tbody id="tableBody">
                                    </tbody>
                                    <tfoot align="right">
                                        <tr>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <div class="row tab-pane" id="tablet-repair-status-chart">
                            <div class="col-md-12" id="tablet_repair_status_chart">
                                <h2 class="center">Chart will goes here</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%@include file="/WEB-INF/jspf/asset-details-modal.jspf" %>
<%@include file="/WEB-INF/jspf/asset-history-modal.jspf" %>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script>
    $(function () {
        $.Asset = {
            baseURL: "asset-dashboard-bak",
            where: "",
            data: null,
            cal: null,
            isNational: false,
            init: function () {
                $.Asset.ajax.showDashboard();
                $.Asset.events.bindEvent();
            },
            events: {
                bindEvent: function () {
                    $.Asset.events.viewTabletStockStatus();
                    $.Asset.events.viewTabletFunctionalityStatus();
                    $.Asset.events.viewProjectedPurchaseNeed();
                    $.Asset.events.viewNumberOfTabletsLost();
                    //$.Asset.events.viewAgeOfTablet();
                },
                viewTabletStockStatus: function () {
                    $(document).off('submit', '#showTabletStockStatus').on('submit', '#showTabletStockStatus', function (e) {
                        e.preventDefault();
                        var obj = $.app.pairs('#showTabletStockStatus');
                        var data = {divid: obj.division1, zillaid: obj.district1, upazilaid: obj.upazila1};
                        $.ajax({
                            url: $.Asset.baseURL + "?action=getTabletStockStatus",
                            type: "POST",
                            data: {asset: JSON.stringify(data)},
                            success: function (response) {
                                response = JSON.parse(response);
                                console.log(response);
                                if (response.success == true) {
//                                    var tablet_stock_status = 'tablet_stock_status';
//                                    $.Asset.renderTable(response.tablet_stock_status, $.Asset.column(tablet_stock_status), tablet_stock_status, $.Asset.title[tablet_stock_status]);
//                                    $.chart.renderAssetBarChart($.Asset.chartId(tablet_stock_status), $.Asset.chartData(tablet_stock_status, response.tablet_stock_status), $.Asset.chartLabel[tablet_stock_status], $.Asset.chartColor[tablet_stock_status]);
                                    if (obj.division1 != 0)
                                        $.Asset.isNational = true;
                                    var tablet_stock_status = 'tablet_stock_status';
                                    $.Asset.renderTable(response.tablet_stock_status, $.Asset.column(tablet_stock_status), tablet_stock_status, $.Asset.title[tablet_stock_status]);
                                    $.chart.renderAssetBarChart($.Asset.chartId(tablet_stock_status), $.Asset.chartData(tablet_stock_status, response.tablet_stock_status), $.Asset.chartLabel[tablet_stock_status], $.Asset.chartColor[tablet_stock_status]);
                                    $.Asset.isNational = false;
                                } else {
                                    toastr['error']("Error occured while data loading");
                                }
                            }, error: function (error) {
                                toastr['error'](error);
                            }
                        });

                    });
                },
                viewTabletFunctionalityStatus: function () {
                    $(document).off('submit', '#showTabletFunctionalityStatus').on('submit', '#showTabletFunctionalityStatus', function (e) {
                        e.preventDefault();
                        var obj = $.app.pairs('#showTabletFunctionalityStatus');
                        var data = {divid: obj.division2, zillaid: obj.district2, upazilaid: obj.upazila2};
                        $.ajax({
                            url: $.Asset.baseURL + "?action=getTabletFunctionalityStatus",
                            type: "POST",
                            data: {asset: JSON.stringify(data)},
                            success: function (response) {
                                response = JSON.parse(response);
                                console.log(response);
                                if (response.success == true) {
                                    if (obj.division2 != 0)
                                        $.Asset.isNational = true;
                                    var tablet_functionality_status = 'tablet_functionality_status';
                                    $.Asset.renderTable(response.tablet_functionality_status, $.Asset.column(tablet_functionality_status), tablet_functionality_status, $.Asset.title[tablet_functionality_status]);
                                    $.chart.renderAssetBarChart($.Asset.chartId(tablet_functionality_status), $.Asset.chartData(tablet_functionality_status, response.tablet_functionality_status), $.Asset.chartLabel[tablet_functionality_status], $.Asset.chartColor[tablet_functionality_status]);
                                    $.Asset.isNational = false;
                                } else {
                                    toastr['error']("Error occured while data loading");
                                }
                            }, error: function (error) {
                                toastr['error'](error);
                            }
                        });

                    });
                },
//                viewAgeOfTablet: function () {
//                    $(document).off('submit', '#showAgeOfTablet').on('submit', '#showAgeOfTablet', function (e) {
//                        e.preventDefault();
//                        var obj = $.app.pairs('#showAgeOfTablet');
//                        var data = {divid: obj.division3, zillaid: obj.district3, upazilaid: obj.upazila3};
//                        $.ajax({
//                            url: $.Asset.baseURL + "?action=getAgeOfTablet",
//                            type: "POST",
//                            data: {asset: JSON.stringify(data)},
//                            success: function (response) {
//                                response = JSON.parse(response);
//                                console.log(response);
//                                if (response.success == true) {
//                                    var age_of_tablet = 'age_of_tablet';
//                                    $.Asset.renderTable(response.age_of_tablet, $.Asset.column(age_of_tablet), age_of_tablet, $.Asset.title[age_of_tablet]);
//                                    $.chart.renderAssetBarChart($.Asset.chartId(age_of_tablet), $.Asset.chartData(age_of_tablet, response.age_of_tablet), $.Asset.chartLabel[age_of_tablet], $.Asset.chartColor[age_of_tablet]);
//                                } else {
//                                    toastr['error']("Error occured while data loading");
//                                }
//                            }, error: function (error) {
//                                toastr['error'](error);
//                            }
//                        });
//
//                    });
//                },
                viewProjectedPurchaseNeed: function () {
                    $(document).off('submit', '#showProjectedPurchaseNeed').on('submit', '#showProjectedPurchaseNeed', function (e) {
                        e.preventDefault();
                        var obj3 = $.app.pairs('#showProjectedPurchaseNeed');
                        var data = {divid: obj3.division3, zillaid: obj3.district3, upazilaid: obj3.upazila3};
                        $.ajax({
                            url: $.Asset.baseURL + "?action=getProjectedPurchaseNeedByLevel",
                            type: "POST",
                            data: {asset: JSON.stringify(data)},
                            success: function (response) {
                                response = JSON.parse(response);
                                console.log(response);
                                if (response.success == true) {

                                    if (obj3.division3 != 0)
                                        $.Asset.isNational = true;


                                    var object = response.projected_purchase_need[0];
                                    var obj = [];
                                    var sum = 0;
                                    for (var property in object) {
                                        if (property != "currently_functional") {
                                            sum += object[property];
                                        }
                                    }

                                    var purchaseGap = sum - object.currently_functional;
                                    obj.push({
                                        typename: 'FWA',
                                        total_user: object.fwa,
                                        currently_functional: object.currently_functional,
                                        purchase_gap: purchaseGap
                                    });
                                    obj.push({
                                        typename: 'FPI',
                                        total_user: object.fpi,
                                        currently_functional: object.currently_functional,
                                        purchase_gap: purchaseGap
                                    });
                                    obj.push({
                                        typename: 'FWV',
                                        total_user: object.fwv,
                                        currently_functional: object.currently_functional,
                                        purchase_gap: purchaseGap
                                    });
                                    obj.push({
                                        typename: 'SACMO',
                                        total_user: object.sacmo,
                                        currently_functional: object.currently_functional,
                                        purchase_gap: purchaseGap
                                    });
                                    obj.push({
                                        typename: 'Upazila Office',
                                        total_user: object.upazila_office,
                                        currently_functional: object.currently_functional,
                                        purchase_gap: purchaseGap
                                    });
                                    if (obj3.upazila3 == 0) {
                                        obj.push({
                                            typename: 'District Office',
                                            total_user: object.district_office,
                                            currently_functional: object.currently_functional,
                                            purchase_gap: purchaseGap
                                        });
                                    }
                                    if (obj3.division3 == 0) {
                                        obj.push({
                                            typename: 'Central Level',
                                            total_user: object.central_level,
                                            currently_functional: object.currently_functional,
                                            purchase_gap: purchaseGap
                                        });
                                    }
                                    console.log(obj);
                                    var projected_purchase_need = 'projected_purchase_need';
                                    $.Asset.renderTable(obj, $.Asset.column(projected_purchase_need), projected_purchase_need, $.Asset.title[projected_purchase_need]);
                                    //$.chart.renderAssetBarChart($.Asset.chartId(age_of_tablet), $.Asset.chartData(age_of_tablet, response.age_of_tablet), $.Asset.chartLabel[age_of_tablet], $.Asset.chartColor[age_of_tablet]);
                                    var col3 = $('#projected_purchase_need td:nth-child(3)');
                                    var col4 = $('#projected_purchase_need td:nth-child(4)');
                                    $.Asset.modifyTableRowspan(col3);
                                    $.Asset.modifyTableRowspan(col4);

                                    $.Asset.isNational = false;
                                } else {
                                    toastr['error']("Error occured while data loading");
                                }
                            }, error: function (error) {
                                toastr['error'](error);
                            }
                        });

                    });
                },
                viewNumberOfTabletsLost: function () {
                    $(document).off('submit', '#showNumberOfTabletsLost').on('submit', '#showNumberOfTabletsLost', function (e) {
                        e.preventDefault();
                        var obj = $.app.pairs('#showNumberOfTabletsLost');
                        var data = {divid: obj.division4, zillaid: obj.district4, upazilaid: obj.upazila4};
                        $.ajax({
                            url: $.Asset.baseURL + "?action=getNumberOfTabletsLost",
                            type: "POST",
                            data: {asset: JSON.stringify(data)},
                            success: function (response) {
                                response = JSON.parse(response);
                                console.log(response);
                                if (response.success == true) {
                                    if (obj.division4 != 0)
                                        $.Asset.isNational = true;

                                    var number_of_tablets_lost = 'number_of_tablets_lost';
                                    $.Asset.renderTable(response.number_of_tablets_lost, $.Asset.column(number_of_tablets_lost), number_of_tablets_lost, $.Asset.title[number_of_tablets_lost]);
                                    //$.chart.renderAssetBarChart($.Asset.chartId(age_of_tablet), $.Asset.chartData(age_of_tablet, response.age_of_tablet), $.Asset.chartLabel[age_of_tablet], $.Asset.chartColor[age_of_tablet]);

                                    $.Asset.isNational = false;
                                } else {
                                    toastr['error']("Error occured while data loading");
                                }
                            }, error: function (error) {
                                toastr['error'](error);
                            }
                        });

                    });
                },
            },
            ajax: {
                showDashboard: function () {
                    var data = {divid: "0", zillaid: "0", upazilaid: "0"};
                    $.ajax({
                        url: $.Asset.baseURL + "?action=getDashboard",
                        type: "POST",
                        data: {asset: JSON.stringify(data)},
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response);

                            if (response.success == true) {


                                // Projected purchase need - preload
                                var object = response.projected_purchase_need[0];
                                var obj = [];
                                var sum = 0;
                                for (var property in object) {
                                    if (property != "currently_functional") {
                                        sum += object[property];
                                    }
                                }
                                //End 

                                // Status rendering
                                //First row
                                var status = response.status[0];
                                $("#status_total_need").html(c(sum));
                                $("#status_purchased").html(c(status.purchased));

                                if (response.tablet_stock_status.length != 0) {
                                    var cal_tablet_stock_status = new Calc(response.tablet_stock_status);
                                    $("#status_distributed").html(c(cal_tablet_stock_status.sum.tablet_distributed_functional_user
                                            + cal_tablet_stock_status.sum.tablet_distributed_functional_local_store
                                            + cal_tablet_stock_status.sum.tablet_distributed_repaired_functional_user
                                            + cal_tablet_stock_status.sum.tablet_distributed_repaired_functional_local_store
                                            + cal_tablet_stock_status.sum.tablet_distributed_non_functional_user
                                            + cal_tablet_stock_status.sum.tablet_distributed_non_functional_local_store
                                            + cal_tablet_stock_status.sum.tablet_distributed_non_functional_vendor));
                                    $("#status_central_store").html(c(cal_tablet_stock_status.sum.tablet_in_central_store_functional + cal_tablet_stock_status.sum.tablet_in_central_store_repaired_functional + cal_tablet_stock_status.sum.tablet_in_central_store_non_functional));
                                }
                                //Second row
                                $("#status_functional").html(c(status.functional + status.repaired_functional));
                                $("#status_repairable").html(c(status.repairable));
                                var cal_tablet_repair_status = new Calc(response.tablet_repair_status);
                                $("#status_vendor").html(c(cal_tablet_repair_status.sum.sent_to_vendor));
                                $("#status_repaired").html(c(cal_tablet_repair_status.sum.repaired));

                                //Third row
                                $("#status_over_3_years").html(c(new Calc(response.age_of_tablet).sum.over_36_months));
                                $("#status_damaged").html(c(status.damaged));
                                $("#status_lost").html(c(status.lost));
                                //End

                                // Tablet Stock Status - Table
                                var tablet_stock_status = 'tablet_stock_status';
                                $.Asset.renderTable(response.tablet_stock_status, $.Asset.column(tablet_stock_status), tablet_stock_status, $.Asset.title[tablet_stock_status]);
                                //Tablet Stock Status - Chart
                                $.chart.renderAssetBarChart($.Asset.chartId(tablet_stock_status), $.Asset.chartData(tablet_stock_status, response.tablet_stock_status), $.Asset.chartLabel[tablet_stock_status], $.Asset.chartColor[tablet_stock_status]);


                                // Tablet Functionality Status - Table
                                var tablet_functionality_status = 'tablet_functionality_status';
                                $.Asset.renderTable(response.tablet_functionality_status, $.Asset.column(tablet_functionality_status), tablet_functionality_status, $.Asset.title[tablet_functionality_status]);
                                // Tablet Functionality Status - Chart
                                $.chart.renderAssetBarChart($.Asset.chartId(tablet_functionality_status), $.Asset.chartData(tablet_functionality_status, response.tablet_functionality_status), $.Asset.chartLabel[tablet_functionality_status], $.Asset.chartColor[tablet_functionality_status]);


                                // Age of Tablet
                                if ($.app.user.userlevel != 2 && $.app.user.userlevel != 3 && $.app.user.userlevel != 4) {
                                    var age_of_tablet = 'age_of_tablet';
                                    $.Asset.renderTable(response.age_of_tablet, $.Asset.column(age_of_tablet), age_of_tablet, $.Asset.title[age_of_tablet]);
                                    $.chart.renderAssetBarChart($.Asset.chartId(age_of_tablet), $.Asset.chartData(age_of_tablet, response.age_of_tablet), $.Asset.chartLabel[age_of_tablet], $.Asset.chartColor[age_of_tablet]);
                                }

                                // Tablet Status by Warranty Period
                                if ($.app.user.userlevel != 2 && $.app.user.userlevel != 3 && $.app.user.userlevel != 4) {
                                    var tablet_status_by_warranty_period = 'tablet_status_by_warranty_period';
                                    $.Asset.renderTable(response.tablet_status_by_warranty_period, $.Asset.column(tablet_status_by_warranty_period), tablet_status_by_warranty_period, $.Asset.title[tablet_status_by_warranty_period]);
                                    //$.chart.renderAssetBarChart($.Asset.chartId(age_of_tablet), $.Asset.chartData(age_of_tablet, response.age_of_tablet), $.Asset.chartLabel[age_of_tablet], $.Asset.chartColor[age_of_tablet]);
                                }

                                // Projected purchase need
                                var purchaseGap = sum - object.currently_functional;
                                obj.push({
                                    typename: 'FWA',
                                    total_user: object.fwa,
                                    currently_functional: object.currently_functional,
                                    purchase_gap: purchaseGap
                                });
                                obj.push({
                                    typename: 'FPI',
                                    total_user: object.fpi,
                                    currently_functional: object.currently_functional,
                                    purchase_gap: purchaseGap
                                });
                                obj.push({
                                    typename: 'FWV',
                                    total_user: object.fwv,
                                    currently_functional: object.currently_functional,
                                    purchase_gap: purchaseGap
                                });
                                obj.push({
                                    typename: 'SACMO',
                                    total_user: object.sacmo,
                                    currently_functional: object.currently_functional,
                                    purchase_gap: purchaseGap
                                });
                                obj.push({
                                    typename: 'Upazila Office',
                                    total_user: object.upazila_office,
                                    currently_functional: object.currently_functional,
                                    purchase_gap: purchaseGap
                                });
                                if ($.app.user.userlevel != 4) {
                                    obj.push({
                                        typename: 'District Office',
                                        total_user: object.district_office,
                                        currently_functional: object.currently_functional,
                                        purchase_gap: purchaseGap
                                    });
                                }
                                if ($.app.user.userlevel != 2 && $.app.user.userlevel != 3 && $.app.user.userlevel != 4) {
                                    obj.push({
                                        typename: 'Central Level',
                                        total_user: object.central_level,
                                        currently_functional: object.currently_functional,
                                        purchase_gap: purchaseGap
                                    });
                                }
                                console.log(obj);
                                var projected_purchase_need = 'projected_purchase_need';
                                $.Asset.renderTable(obj, $.Asset.column(projected_purchase_need), projected_purchase_need, $.Asset.title[projected_purchase_need]);
                                //$.chart.renderAssetBarChart($.Asset.chartId(age_of_tablet), $.Asset.chartData(age_of_tablet, response.age_of_tablet), $.Asset.chartLabel[age_of_tablet], $.Asset.chartColor[age_of_tablet]);



                                // Number of tablets lost
                                var number_of_tablets_lost = 'number_of_tablets_lost';
                                $.Asset.renderTable(response.number_of_tablets_lost, $.Asset.column(number_of_tablets_lost), number_of_tablets_lost, $.Asset.title[number_of_tablets_lost]);
                                //$.chart.renderAssetBarChart($.Asset.chartId(age_of_tablet), $.Asset.chartData(age_of_tablet, response.age_of_tablet), $.Asset.chartLabel[age_of_tablet], $.Asset.chartColor[age_of_tablet]);


                                // Tablet Repair Status
                                if ($.app.user.userlevel != 2 && $.app.user.userlevel != 3 && $.app.user.userlevel != 4) {
                                    var tablet_repair_status = 'tablet_repair_status';
                                    $.Asset.renderTable(response.tablet_repair_status, $.Asset.column(tablet_repair_status), tablet_repair_status, $.Asset.title[tablet_repair_status]);
                                    //$.chart.renderAssetBarChart($.Asset.chartId(age_of_tablet), $.Asset.chartData(age_of_tablet, response.age_of_tablet), $.Asset.chartLabel[age_of_tablet], $.Asset.chartColor[age_of_tablet]);
                                }


                                //Merge Projected Purchase Need table
                                var col3 = $('#projected_purchase_need td:nth-child(3)');
                                var col4 = $('#projected_purchase_need td:nth-child(4)');
                                $.Asset.modifyTableRowspan(col3);
                                $.Asset.modifyTableRowspan(col4);

                                function c(x) {
                                    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                }

                            } else {
                                toastr['error']("Error occured while data loading");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });

                },
            },
            renderTable: function (data, columns, id, title) {
                //console.log(columns);
                //Make total footer based column length
                var options = {
                    footerCallback: function (row, data, start, end, display) {
                        var api = this.api(), data;
                        // converting to interger to find total
                        var intVal = function (i) {
                            return typeof i === 'string' ?
                                    i.replace(/[\$,]/g, '') * 1 :
                                    typeof i === 'number' ?
                                    i : 0;
                        };
                        // computing column Total of the complete result 
                        var footerData = [];
                        for (var i = 1; i < columns.length; i++) {
                            footerData.push(api
                                    .column(i)
                                    .data()
                                    .reduce(function (a, b) {
                                        return intVal(a) + intVal(b);
                                    }, 0));
                            if (id == "tablet_status_by_warranty_period" || id == "projected_purchase_need") {
                                break;
                            }
                        }
                        $(api.column(0).footer()).html('Total');
                        for (var i = 1; i < columns.length; i++) {
                            $(api.column(i).footer()).html(footerData[i - 1]);
                        }
                    },
//                    lengthMenu: [
//                        [10, 25, 50, 100, -1],
//                        ['10', '25', '50', '100', 'All']
//                    ],
                    dom: 'Bfrtip',
                    buttons: [
                        {
                            extend: 'print',
                            text: ' <i class="fa fa-print" aria-hidden="true"></i> Print / PDF',
                            title: title,
                            filename: title,
                            footer: true
                        },
                        {
                            extend: 'excelHtml5',
                            text: '<i class="fa fa-file-excel-o" aria-hidden="true"></i> Excel',
                            title: title,
                            filename: title,
                            footer: true
                        },
                    ],
                    processing: true,
                    data: data,
                    columns: columns,
                    "searching": false,
                    "lengthChange": false,
                    "paging": false,
                    "ordering": false,
                    "filter": false,
                    "info": false
                };
                $('#' + id).dtAsset(options, id);
                $.app.overrideDataTableBtn();
                $('.data-view').css("display", "block");
            },
            column: function (name) {
                // Purchased - Received
                //Center - local
                var main = "purchased", store = "central";
                if ($.app.user.userlevel == 2 || $.app.user.userlevel == 3 || $.app.user.userlevel == 4 || $.Asset.isNational) {
                    main = "received", store = "local";
                }

                var column = {
                    tablet_stock_status: [
                        {data: "modelname", title: "Model name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;", className: "modelName"},
                        {data: "tablet_purchased", title: "Tablet " + main},
                        {data: function (d) {
                                return (d.tablet_distributed_functional_user
                                        + d.tablet_distributed_functional_local_store
                                        + d.tablet_distributed_repaired_functional_user
                                        + d.tablet_distributed_repaired_functional_local_store
                                        + d.tablet_distributed_non_functional_user
                                        + d.tablet_distributed_non_functional_local_store
                                        + d.tablet_distributed_non_functional_vendor);
                            }, title: "Tablet distributed"},
                        {data: function (d) {
                                return (d.tablet_in_central_store_functional + d.tablet_in_central_store_repaired_functional + d.tablet_in_central_store_non_functional);
                            }, title: "Tablet in " + store + " store"},
                    ],
                    tablet_functionality_status: [
                        {data: "modelname", title: "Model name", className: "modelName"},
                        {data: "tablet_purchased", title: "Tablet " + main},
                        {data: "functional", title: "Functional"},
                        {data: "repairable", title: "Repairable"},
                        {data: "damaged", title: "Damaged"},
                        {data: "lost", title: "Lost"}
                    ],
                    age_of_tablet: [
                        {data: "modelname", title: "Model name", className: "modelName"},
                        {data: "tablet_purchased", title: "Tablet " + main},
                        {data: "less_than_12_months", title: "Less than 12 months"},
                        {data: "between_13_and_24_months", title: "Between 13 and 24 months"},
                        {data: "between_25_and_36_months", title: "Between 25 and 36 months"},
                        {data: "over_36_months", title: "Over 36 months"}
                    ],
                    tablet_status_by_warranty_period: [
                        {data: "modelname", title: "Model name", className: "modelName"},
                        {data: "tablet_purchased", title: "Tablet " + main},
                        {data: function (d) {
                                return $.app.date(d.purchaseddate).date
                            }, title: "Purchase date"},
                        {data: "warrentyperiod", title: "Warranty (Year)"},
                        {data: function (d) {
                                return $.app.date(d.purchaseddate).added(d.warrentyperiod);
                            }, title: " Expiration date"},
                        {data: function (d) {
                                if (d.warrentyperiod == null) {
                                    return "";
                                } else {
                                    if ($.app.date().fullDate > $.app.date(d.purchaseddate).fullAdded(d.warrentyperiod)) {
                                        return '<div class="label-progress" style="background-color:#ff3d3d;">Yes</div>';
                                    } else {
                                        return '<div class="label-progress" style="background-color:#00A65A;">No</div>';
                                    }
                                }
                            }, title: "Expired"}
                    ],
                    projected_purchase_need: [
                        {data: "typename", title: "User Type"},
                        {data: function (d) {
                                return d.total_user;
                            }, title: "Tablet needed by number of users <span style='color: red;'>*</span>"},
                        {data: function (d) {
                                return d.currently_functional;
                            }, title: "Current users", className: "centerText"},
                        {data: function (d) {
                                return d.purchase_gap;
                            }, title: "Purchase requirement", className: "centerText"}
                    ],
                    number_of_tablets_lost: [
                        {data: "modelname", title: "Model name", className: "modelName"},
                        {data: "lost", title: "Total lost"},
                        {data: "gd_received", title: "Number GD copy received"},
                        {data: "gd_verified", title: "Number of investigation done by supervisor"}
                    ],
                    tablet_repair_status: [
                        {data: "modelname", title: "Model name", className: "modelName"},
                        {data: "non_functional", title: "Non-functional"},
                        {data: "sent_to_vendor", title: "Sent to vendor"},
                        {data: "repaired", title: "Repaired"}
                    ]
                }
                return column[name];
            },
            chartId: function (id) {
                return   id + "_chart";
            },
            title: {
                tablet_stock_status: "Tablet Stock Status",
                tablet_functionality_status: "Tablet Functionality Status",
                age_of_tablet: "Age of Tablet",
                tablet_status_by_warranty_period: "Tablet Status by Warranty Period",
                projected_purchase_need: "Projected Purchase Need",
                number_of_tablets_lost: "Number of Tablets Lost",
                tablet_repair_status: "Tablet Repair Status"
            },
            chartLabel: {
                tablet_stock_status: ['Tablet Purchased', 'Tablet Distributed', 'Tablet in central store'],
                tablet_functionality_status: ['Tablet Purchased', 'Functional', 'Repairable', 'Damaged', 'Lost'],
                age_of_tablet: ['Tablet Purchased', 'Less than 1 year', '1-2 years', '2-3 years', 'More than 3 years']
            },
            chartColor: {
                tablet_stock_status: ['#0c89ff', '#F78D1F', '#95CEFF'],
                tablet_functionality_status: ['#95CEFF', '#F78D1F', '#FFC02D', '#49C1C0', '#5A86C5'],
                age_of_tablet: ['#95CEFF', '#F78D1F', '#FFC02D', '#49C1C0', '#5A86C5']
            },
            chartData: function (id, data) {
                var chartData = [];
                if (id == "tablet_stock_status") {
                    $.each(data, function (i, o) {
                        chartData.push({
                            area: o.modelname,
                            purchased: o.tablet_purchased,
                            distributed: (o.tablet_distributed_functional_user
                                    + o.tablet_distributed_functional_local_store
                                    + o.tablet_distributed_repaired_functional_user
                                    + o.tablet_distributed_repaired_functional_local_store
                                    + o.tablet_distributed_non_functional_user
                                    + o.tablet_distributed_non_functional_local_store
                                    + o.tablet_distributed_non_functional_vendor),
                            central_store: (o.tablet_in_central_store_functional + o.tablet_in_central_store_repaired_functional + o.tablet_in_central_store_non_functional)
                        });
                    });

                } else if (id == "tablet_functionality_status") {
                    $.each(data, function (i, o) {
                        chartData.push({
                            area: o.modelname,
                            purchased: o.tablet_purchased,
                            functional: o.functional,
                            repairable: o.repairable,
                            damaged: o.damaged,
                            lost: o.lost
                        });
                    });

                } else if (id == "age_of_tablet") {
                    $.each(data, function (i, o) {
                        chartData.push({
                            area: o.modelname,
                            purchased: o.tablet_purchased,
                            less_than_one_year: o.less_than_one_year,
                            one_to_two_years: o.one_to_two_years,
                            two_to_three_years: o.two_to_three_years,
                            more_than_three_year: o.more_than_three_year
                        });
                    });
                }
                return chartData;
            },
            modifyTableRowspan: function (column) {
                var prevText = "";
                var counter = 0;
                column.each(function (index) {
                    var textValue = $(this).text();

                    if (index === 0) {
                        prevText = textValue;
                    }
                    if (textValue !== prevText || index === column.length - 1) {
                        var first = index - counter;

                        if (index === column.length - 1) {
                            counter = counter + 1;
                        }
                        column.eq(first).attr('rowspan', counter);

                        if (index === column.length - 1)
                        {
                            for (var j = index; j > first; j--) {
                                column.eq(j).remove();
                            }
                        } else {
                            for (var i = index - 1; i > first; i--) {
                                column.eq(i).remove();
                            }
                        }
                        prevText = textValue;
                        counter = 0;
                    }
                    counter++;
                });
            },
        };
        $.Asset.init();
    });
</script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.flash.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js" type="text/javascript"></script>