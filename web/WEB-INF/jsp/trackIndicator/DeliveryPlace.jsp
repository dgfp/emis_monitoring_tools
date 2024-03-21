<%-- 
    Document   : Delivery
    Created on : Jan 29, 2019, 2:51:51 PM
    Author     : Helal
	Delivery by place and attendant
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<style>
    .form-group {
        margin-bottom: 0px!important;
    }
    .select2-container--default .select2-selection--single .select2-selection__rendered {
        line-height: 22px;
    }
    #userComboLevel{
        font-size: 16px;
        font-weight: bold;
    }
    .none{
        display: none;
    }
    #viewUserDetails{
        font-size: 18px;
        margin-right: 30px!important;
    }
    .form-control {
        display: inline!important;
    }
    [class*="col"] { margin-bottom: 10px; }
    .small-box {
        margin-bottom: 3px!important;
    }
    #details{
        display: none;
    }
    #typeTitle{
        text-align: center;
    }
    div.dt-buttons {
        float: right;
    }
    .label{
        border-radius: 10px;
    }

    .dt-print-preview{ font-size: 11px !important; }
    .dt-title{ font-size: 16px!important; }
    .dt-title p { font-size: 13px!important;  margin-top: 7px}

    @media print {
        table{ font-size: 11px !important; border-collapse: collapse !important; border: 0}
        table th, table td { border: 1px solid #333}
        .dt-title{ font-size: 16px!important; }
        .dt-title p { font-size: 13px!important;  margin-top: 7px}
        html, body {
            border: 1px solid white;
            height: 99%;
            page-break-after: avoid;
            page-break-before: avoid;
        }
    }
</style>
<script>
     $(function () {
     var provTypes = $.app.getProvTypes(0);
     var $provType = $('select#provtype').Select(provTypes, {placeholder: null, value: 3}),
     $division = $.app.select.$division('select#division'),
     $zilla = $('select#zilla'),
     $upazila = $('select#upazila'),
     $union = $('select#union'),
     $btn = $('#btn-summary'), //$("button#btn-data"),
     init = 1;
     $provType.on('Select', function (e, data) {
     console.log(data);
     $.app.cache.provtype = data;
     });
     
     $division.change(function (e) {
     $zilla.Select();
     $upazila.Select();
     $union.Select();
     $division.val() && $.app.select.$zilla($zilla, $division.val());
     }).on('Select', function (e, data) {
     !init && $(this).val(30).change(); // && $(this).prop('disabled', 1);
     $.app.cache.division = data;
     });
     $zilla.change(function (e) {
     $upazila.Select();
     $union.Select();
     $zilla.val() && $.app.select.$upazila($upazila, $zilla.val(), "", "All");
     //alert($zilla.val());
     }).on('Select', function (e, data) {
     !init && $(this).val(93).change(); //&& $(this).prop('disabled', 1);
     $.app.cache.zilla = data;
     });
     $upazila.change(function (e) {
     $union.Select();
     $zilla.val() && $upazila.val() && $.app.select.$union($union, $zilla.val(), $upazila.val(), '', 'All');
     }).on('Select', function (e, data) {
     //!init && $(this).val(66).change();
     !init++ && $(this).val('') && $btn.click();
     $.app.cache.upazila = data;
     });
     $union.on('Select', function (e, data) {
     //!init++ && $(this).val('') && $btn.click();
     $.app.cache.union = data;
     });
     
     });
     
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle">Place of delivery</h1>
</section>
<!-- Main content -->
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
                                <label for="union">Provider </label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control" name="provtype" id="provtype" required>
                                    <option class="opt-3" value="3">FWA [3]</option>
                                    <option class="opt-10" value="10">FPI [10]</option>
                                </select>
                            </div>
                            <div class="col-md-1  col-xs-2">
                                <label for="month">Month</label>
                            </div>
                            <div class="col-md-2  col-xs-4">
                                <select class="form-control input-sm" name="month" id="month">
                                </select>
                            </div>
                            <div class="col-md-1  col-xs-2">
                                <label for="year">Year</label>
                            </div>
                            <div class="col-md-2  col-xs-4">
                                <select class="form-control input-sm" name="year" id="year"> </select>
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
