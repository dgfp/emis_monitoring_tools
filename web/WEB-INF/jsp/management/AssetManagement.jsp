<%-- 
    Document   : AssetManagement
    Created on : Sep 13, 2020, 6:26:43 AM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/AssetManagement.js" type="text/javascript"></script>
<link href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css"/>
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<style>
    .label {
        border-radius: 11px!important;
    }
    /*    tbody>tr>:nth-child(5), tbody>tr>:nth-child(7), thead>tr>:nth-child(5), thead>tr>:nth-child(7){
            text-align:center;
        }*/
    .menu-btn{
        width: 120px;
    }
    .col_ {
        width: 23.666667%;
        margin-bottom: 0px!important;
    }
    label{
        margin-top: 5px;
    }
    [class*="col"] { margin-bottom: 10px; }
    .data-view{
        display: none;
        margin-top: 10px;
    }
    table.table-bordered thead th,
    table.table-bordered thead td {
        border-left-width: 1px;
        border-top-width: 1px;
    }
    .table-bordered {
        border: 2px solid #f4f4f4;
    }
    .numeric_field{
        width: 12%!important;
        min-width: 12%!important;
    }
    .dataTables_filter > input{
        display: none;
        color: red;
    }
    .modal-body> h4{
        margin-top: 0px!important;
        display: inline-block;
        justify-content: center;
        align-items: center;
        text-decoration: underline;
    }
    #distributeDeviceForm, #distributeProviderForm, #distributeResourcePersonForm, #userTypeForm, #input-lost{
        display: none;
    }
    .type-active {
        background-color: #EC971F;
    }
    .warp {
        padding: 2px 4px;
        color: #fff;
        border-radius: 7px;
    }
    .type-inactive {
        background-color: #dbdbdb;
        color: #6d6d6d;
    }
</style>
<section class="content-header">
    <h1>Asset Management</h1>
    <ol class="breadcrumb">
        <a class="btn btn-flat btn-default btn-sm" href="asset-dashboard"><b>&nbsp;&nbsp;Dashboard&nbsp;&nbsp;</b></a>
<!--        <a class="btn btn-flat btn-default btn-sm" href="asset-reports"><b>Details</b></a>-->
        <a class="btn btn-flat btn-primary btn-sm" href="asset-management"><b>Management</b></a>
        <a class="btn btn-flat btn-default btn-sm bold" href="asset-management-procurement">Manage Procurement</a>
    </ol>
</section>
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary full-screen">
                <div class="box-header with-border">
                    <div class="form-group form-group-sm">
                        <div class="col-md-2 col-xs-4 col_">
                            <a class="btn btn-flat btn-success btn-sm" id="addNewDevice"><i class="fa fa-plus-circle" aria-hidden="true"></i> <b>&nbsp;Add New Device</b></a>
                        </div>
                    </div>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">

                    <form action="asset" method="post" id="showData">
                        <div class="row">
                            <div class="col-md-1 col-xs-2">
                                <label for="division">Division</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="divid" id="divid"> </select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="zilla">District</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="zillaid" id="zillaid"> 
                                    <option value="0">All</option>
                                </select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="upazilaid">Upazila</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="upazilaid" id="upazilaid">
                                    <option value="0">All</option>
                                </select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="unionid">Union</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="unionid" id="unionid">
                                    <option value="0">All</option>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-1 col-xs-2">
                                <label for="status_id">Status</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="statusid" id="statusid"> 
                                    <option value="0">All</option>
                                </select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="">Location</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="locationid" id="locationid"> 
                                    <option value="0">All</option>
                                    <option value="1">User</option>
                                    <option value="2">Central store</option>
                                    <option value="3">Local store</option>
                                </select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="">User type</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="usertype" id="usertype"> 
                                    <option value="0">All</option>
                                    <option value="1">Provider</option>
                                    <option value="2">Other user</option>
                                    <option value="3">None user</option>
                                </select>
                            </div>

                            <div class="col-md-1  col-xs-2">
                            </div>
                            <div class="col-md-2  col-xs-4">
                                <button type="submit" class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                    <i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; Show data
                                </button>
                            </div>
                        </div>
                    </form>
                    <div class="col-md-12 data-view">
                        <div class="table-responsive fixed">
                            <table id="table" class="table table-hover table-striped">
                                <thead id="tableHeader">
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
    </div>
</section>









<div id="addNewDeviceModal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold">Add New Device <b  id="nameAsEditProvTitle" style="color: rgb(245, 136, 18);"></b></h4>
            </div>
            <form  action="asset-management" method="post" id="addNewDeviceSubmit">
                <div class="modal-body">
                    <h4 class="center">Device information</h4><br>
                    <div class="row">
                        <div class="col-md-4 col-xs-8">
                            <div class="form-group">
                                <label for="n_imei1">IMEI 1:</label>
                                <input class="form-control" placeholder="imei1" name="n_imei1" id="n_imei1" required>
                            </div>
                        </div>

                        <div class="col-md-4 col-xs-8">
                            <div class="form-group">
                                <label for="n_imei2">IMEI 2:</label>
                                <input class="form-control" placeholder="imei1" name="n_imei2" id="n_imei2">
                            </div>
                        </div>

                        <div class="col-md-4 col-xs-8">
                            <div class="form-group">
                                <label for="n_imei2">Model:</label>
                                <select class="form-control" name="model" id='model' required>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 col-xs-8">
                            <div class="form-group">
                                <label for="purchaseorderno">Purchase order no: </label>
                                <input class="form-control" placeholder="" name="purchaseorderno" id="purchaseorderno">
                            </div>
                        </div>
                        <div class="col-md-4 col-xs-8">
                            <div class="form-group">
                                <label for="purchaseddate">Purchase date:</label>
                                <input type="text" class="input form-control datePickerChooseAll" placeholder="dd/mm/yyyy" name="purchaseddate" id="purchaseddate" autocomplete="off" required>
                            </div>
                        </div>
                        <div class="col-md-4 col-xs-8">
                            <div class="form-group">
                                <label for="purchasedby">Purchased by</label>
                                <select class="form-control" name="purchasedby" id='purchasedby' required>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 col-xs-8">
                            <div class="form-group">
                                <label for="telcoid">Telcom:</label>
                                <select class="form-control" name="telcoid" id="telcoid" required></select>
                            </div>
                        </div>
                        <div class="col-md-4 col-xs-8">
                            <div class="form-group">
                                <label for="simnumber">SIM number:</label>
                                <input type="text" class="form-control" placeholder="" name="simnumber" id="simnumber" pattern="01\d{9}" required="" autocomplete="off" required>
                            </div>
                        </div>
                        <div class="col-md-4 col-xs-8">
                            <div class="form-group">
                                <label for="warrentyperiod">Warrenty period: </label>
                                <input class="form-control" placeholder="Warrenty period e.g 5" name="warrentyperiod" id="warrentyperiod" required>
                            </div>
                        </div>
                    </div>

                    <br/>

                    <h4 class="center">Update Status? 
                    </h4>&nbsp;&nbsp;
                    <span class="material-switch"><input name="distributeDevice" id="distributeDevice"  type="checkbox"><label for="distributeDevice" class="label-success"></label></span>

                    <div id="distributeDeviceForm">
                        <div class="row">
                            <div class="col-md-2">
                                <label for="statusid">Accessories</label>
                            </div>
                            <div class="col-md-2">
                                <label><input type="checkbox" checked="" name="charger" id="charger">&nbsp;Charger</label>
                            </div>
                            <div class="col-md-2">
                                <label><input type="checkbox" checked="" name="cover" id="cover">&nbsp;Cover</label>
                            </div>
                            <div class="col-md-2">
                                <label><input type="checkbox" checked="" name="screenprotector" id="screenprotector">&nbsp;Screen Protector</label>
                            </div>
                            <div class="col-md-2">
                                <label><input type="checkbox" checked="" name="waterproofbag" id="waterproofbag">&nbsp;Water Proof Bag</label>
                            </div>
                        </div>
                        <br/>

                        <div class="row">
                            <div class="col-md-4 col-xs-8">
                                <div class="form-group">
                                    <label for="n_statusid">Status:</label>
                                    <select class="form-control" name="n_statusid" id='n_statusid'>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-8">
                                <div class="form-group">
                                    <label for="n_locationid">Location:</label>
                                    <select class="form-control" name="n_locationid" id='n_locationid'>
                                        <option value="">- select -</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-8" id="userTypeForm">
                                <div class="form-group">
                                    <label for="warrentyperiod">User type: </label><br/>
                                    <label><input type="radio" class="provider" id="provider" name="userType" value="1"> <span class="warp type-inactive">&nbsp;Provider&nbsp;</span></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <label><input type="radio" class="resourcePerson" id="resourcePerson" name="userType" value="2" disabled=""> <span class="type-inactive warp">&nbsp;Other&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 col-xs-8">
                                <div class="form-group">
                                    <label for="receiveddate">Received date:</label>
                                    <input type="text" class="input form-control datePickerChooseAll" placeholder="dd/mm/yyyy" name="receiveddate" id="receiveddate" autocomplete="off">
                                </div>
                            </div>

                            <span id="input-lost">
                                <div class="col-md-4 col-xs-8">
                                    <div class="form-group">
                                        <label for="lost_gd">GD:</label>
                                        <input class="form-control" placeholder="" name="lost_gd" id="lost_gd" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-4 col-xs-8">
                                    <div class="form-group">
                                        <label for="verification">Verification:</label><br/>
                                        <label><input type="radio" id="verified" name="lost_varified" value="1"> <span class="warp type-inactive">&nbsp;Verified&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <label><input type="radio"  id="not_verified" name="lost_varified" value="2"> <span class="type-inactive warp">&nbsp;Not Verified&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
                                    </div>
                                </div>
                            </span>
                        </div>

                        <!--                        <div class="row">
                                                    <div class="col-md-4 col-xs-8">
                                                        <div class="form-group">
                                                            <label for="receiveddate">Received date:</label>
                                                            <input type="text" class="input form-control datePickerChooseAll" placeholder="dd/mm/yyyy" name="receiveddate" id="receiveddate" autocomplete="off">
                                                        </div>
                                                    </div>
                                                </div>-->

                    </div>





                    <div id="distributeProviderForm">
                        <div class="row">
                            <div class="col-md-4 col-xs-8">
                                <div class="form-group">
                                    <label for="n_divid">Division:</label>
                                    <select class="form-control" name="n_divid" id='n_divid'>
                                        <option value="">- select -</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-8">
                                <div class="form-group">
                                    <label for="n_zillaid">District:</label>
                                    <select class="form-control" name="n_zillaid" id='n_zillaid'>
                                        <option value="">- select -</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-8">
                                <div class="form-group">
                                    <label for="n_upazilaid">Upazila:</label>
                                    <select class="form-control" name="n_upazilaid" id='n_upazilaid'>
                                        <option value="">- select -</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 col-xs-8">
                                <div class="form-group">
                                    <label for="n_unionid">Union:</label>
                                    <select class="form-control" name="n_unionid" id='n_unionid'>
                                        <option value="">- select -</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-8">
                                <div class="form-group">
                                    <label for="providerType">Provider type:</label>
                                    <select class="form-control" name="providerType" id='providerType'>
                                        <option class="opt-" value="">- Select provider type -</option>
                                        <option class="opt-2" value="2">HA [2]</option>
                                        <option class="opt-3" value="3">FWA [3]</option>
                                        <option class="opt-4" value="4">FWV [4]</option>
                                        <option class="opt-5" value="5">SACMO_FP [5]</option>
                                        <option class="opt-6" value="6">SACMO_HS [6]</option>
                                        <option class="opt-7" value="7">PHARMACIST_FP [7]</option>
                                        <option class="opt-8" value="8">PHARMACIST_HS [8]</option>
                                        <option class="opt-9" value="9">CHCP [9]</option>
                                        <option class="opt-10" value="10">FPI [10]</option>
                                        <option class="opt-11" value="11">AHI [11]</option>
                                        <option class="opt-12" value="12">HI [12]</option>
                                        <option class="opt-14" value="14">MOMCH [14]</option>
                                        <option class="opt-15" value="15">UFPO [15]</option>
                                        <option class="opt-16" value="16">UHFPO [16]</option>
                                        <option class="opt-101" value="101">PARAMEDIC [101]</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-8">
                                <div class="form-group">
                                    <label for="providerid">Provider:</label>
                                    <select class="form-control" name="providerid" id='providerid'>
                                        <option value="">- select -</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="distributeResourcePersonForm">
                        <div class="row">
                            <div class="col-md-2">
                                <label for="providerid">Select person</label>
                            </div>
                            <div class="col-md-4">
                                <select class="form-control" name="providerid" id='providerid'>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Updating" class="btn btn-flat btn-success bold"><i class="fa fa-check-square-o" aria-hidden="true"></i>&nbsp;Submit</button>
                    <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal"><i class="fa fa-window-close-o" aria-hidden="true"></i>&nbsp;Cancel</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/jspf/asset-details-modal.jspf" %>
<%@include file="/WEB-INF/jspf/asset-history-modal.jspf" %>
<%@include file="/WEB-INF/jspf/asset-update-modal.jspf" %>
<%@include file="/WEB-INF/jspf/asset-redistribution-modal.jspf" %>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script>
    $(function () {
        $.Asset = {
            addNewDeviceResource: null,
            provtype: "#provtype",
            statusId: "#statusid",
            locationid: "#locationid",
            baseURL: "asset-management",
            init: function () {
                $.Asset.events.bindEvent();
                $.Asset.events.viewData();
                $.Asset.ajax.showData('');
                $.Asset.ajax.getStatus();
                $.Asset.ajax.getDistributedData();
            },
            events: {
                bindEvent: function () {
                    $.Asset.events.changeStatus();
                    $.Asset.events.showData();

                    //$.Asset.events.viewAssetByDesignation();
                    //$.Asset.events.viewAssetByStatus();
                    $.Asset.events.addNewDevice();
                    $.Asset.events.addNewDeviceSubmit();
                    $.Asset.events.addNewDeviceDistribution();
                    $.Asset.events.selectUserType();
                    $.Asset.events.selectStatus();
                    $.Asset.events.selectLocation();
                    $.Asset.events.loadProvider();

                    //Action
                    $.Asset.events.viewDetails();
                    $.Asset.events.viewHistory();

                },
                changeStatus: function () {
                    $(document).off('change', '#statusid').on('change', '#statusid', function (e) {
                        $.Asset.ajax.getLocation($($.Asset.statusId).val());
                    });
                },
                showData: function () {
                    var response = {data: null};
                    //$.Asset.renderTable(response);
                    $(document).off('submit', '#showData').on('submit', '#showData', function (e) {
                        e.preventDefault();
                        var area = $.app.pairs('#showData');
                        console.log(area);
                        var where = "";
                        $.each(area, function (i, o) {
                            if (o != "0") {
                                where += " and d." + i + "=" + o;
                            }
                            console.log(i, o);
                        });
                        console.log(where);
                        $.Asset.ajax.showData(where);
                    });
                },
                addNewDeviceSubmit: function () {
                    $(document).off('submit', '#addNewDeviceSubmit').on('submit', '#addNewDeviceSubmit', function (e) {
                        e.preventDefault();
                        var area = $.app.pairs('#addNewDeviceSubmit');
                        console.log(area);
                        $.Asset.ajax.addNewDeviceSubmit(area);
                    });
                },
                viewDetails: function () {
                    $(document).off('click', '.asset-view').on('click', '.asset-view', function (e) {
                        $.AssetManagement.ajax.getAssetDetails($(this).data("info"));
                    });
                },
                viewHistory: function () {
                    $(document).off('click', '.asset-history').on('click', '.asset-history', function (e) {
                        $.AssetManagement.ajax.getAssetHistory($(this).data("info"));
                    });
                },
//                viewAssetByDesignation: function () {
//                    $(document).off('change', '#designation').on('change', '#designation', function (e) {
//                        console.log($(this).val());
//                        $.Asset.ajax.viewAssetBySelector();
//                    });
//                },
//                viewAssetByStatus: function () {
//                    $(document).off('change', '#status').on('change', '#status', function (e) {
//                        console.log($(this).val());
//                        $.Asset.ajax.viewAssetBySelector();
//                    });
//                },






                addNewDevice: function () {
                    $(document).off('click', '#addNewDevice').on('click', '#addNewDevice', function (e) {
                        //getAddNewDeviceResource
                        $.ajax({
                            url: $.Asset.baseURL + "?action=getAddNewDeviceResource",
                            type: 'POST',
                            success: function (response) {
                                response = JSON.parse(response);
                                $.Asset.addNewDeviceResource = response;
                                console.log(response);
                                if (response.success) {
                                    $.Asset.fillupDropdown($("select#model"), response.model, "modelid", "modelname", "- Select Model -");
                                    $.Asset.fillupDropdown($("select#purchasedby"), response.organization, "organizationid", "name", "- Select Organization -");
                                    $.Asset.fillupDropdown($("select#telcoid"), response.telco, "telcoid", "telconame", "- Select Telcom -");
                                    $.Asset.fillupDropdown($("select#n_statusid"), response.status, "statusid", "statusname", "- Select Status -");
                                    $("#addNewDeviceModal").modal('show');
                                } else {

                                }
                            }
                        });
//                        function fillupDropdown(selector, data, value, text, defaultText) {
//                            selector.find('option').remove();
//                            $('<option>').val("").text(defaultText).appendTo(selector);
//                            $.each(data, function (i, o) {
//                                $('<option>').val(o[value]).text(o[text]).appendTo(selector);
//                            });
//                        }
                    });
                },
                selectStatus: function () {
                    $(document).off('change', '#n_statusid').on('change', '#n_statusid', function (e) {
                        var data = $.Asset.addNewDeviceResource.location.filter(obj => obj.statusid == $(this).val());
                        $.Asset.fillupDropdown($("select#n_locationid"), data, "locationid", "locationname", "- Select Location -");
                        //reset
                        $('input[type=radio][name=userType]').attr('checked', false);
                        $("#distributeProviderForm").css("display", "none");
                        $("#distributeResourcePersonForm").css("display", "none");
                        $("#userTypeForm").css("display", "none");
                        if ($(this).val() == 5) {
                            $("#input-lost").css("display", "block");
                        } else {
                            $("#input-lost").css("display", "none");
                        }
                    });
                },
                selectLocation: function () {
                    $(document).off('change', '#n_locationid').on('change', '#n_locationid', function (e) {
                        //reset
                        $('input[type=radio][name=userType]').attr('checked', false);
                        $("#distributeProviderForm").css("display", "none");
                        $("#distributeResourcePersonForm").css("display", "none");
                        if ($(this).find(":selected").text() == "User" || $(this).find(":selected").text() == "From user") {
                            //userTypeForm
                            $("#userTypeForm").css("display", "block");
                        } else {
                            $("#userTypeForm").css("display", "none");
                        }
                    });
                },
                addNewDeviceDistribution: function () {
                    $(document).off('change', '#distributeDevice').on('change', '#distributeDevice', function (e) {
                        //reset
                        $('input[type=radio][name=userType]').attr('checked', false);
                        $("#distributeProviderForm").css("display", "none");
                        $("#distributeResourcePersonForm").css("display", "none");
                        $("#userTypeForm").css("display", "none");

                        if ($(this).prop('checked')) {
                            $("#distributeDeviceForm").slideDown();
                        } else {
                            $("#distributeDeviceForm").slideUp();
                        }
                    });
                },
                selectUserType: function () {
                    $('input[type=radio][name=userType]').change(function () {
                        if (this.value == '1') {
                            $("#distributeProviderForm").css("display", "block");
                            $("#distributeResourcePersonForm").css("display", "none");
                        } else if (this.value == '2') {
                            $("#distributeResourcePersonForm").css("display", "block");
                            $("#distributeProviderForm").css("display", "none");

                        }
                        //$("#" + this.value).next("span").removeClass("type-inactive").addClass("type-active");
                    });
                },
                loadProvider: function () {
                    $(document).off('change', '#providerType').on('change', '#providerType', function (e) {
                        $.AssetManagement.ajax.getProvider($("#n_divid").val(), $("#n_zillaid").val(), $("#n_upazilaid").val(), $("#n_unionid").val(), $("#providerType").val());
                    });
                },
            },
            ajax: {
                showData: function (where) {
                    console.log(where);
                    $.ajax({
                        url: $.Asset.baseURL + "?action=showData",
                        type: "POST",
                        data: {where: where},
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success == true) {
                                $.Asset.renderTable(response);
                            } else {
                                toastr['error']("Error occured while data loading");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                },
                addNewDeviceSubmit: function (json) {
                    console.log(json);
                    $.ajax({
                        url: $.Asset.baseURL + "?action=addNewDevice",
                        type: "POST",
                        data: {asset: JSON.stringify(json)},
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success == true) {
                                console.log(response);
                                if(response.data=2){
                                    toastr['success']("Device added successfully");
                                }else{
                                    toastr['error']("Somthing went wrong");
                                }
                                $( "#showData" ).submit();
                                $('#addNewDeviceModal').modal('hide');
                            } else {
                                toastr['error']("Error occured while data loading");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                },
                setDesignation: function () {
                    $.ajax({
                        url: "asset?action=getDesignation",
                        type: 'POST',
                        success: function (response) {
                            response = JSON.parse(response);
                            var dropdown = $($.Asset.provtype);
                            dropdown.find('option').remove();
                            $('<option>').val("0").text('All').appendTo(dropdown);
                            $.each(response.designation, function (i, o) {
                                $('<option>').val(o.provtype).text(o.typename + " [" + o.provtype + "]").appendTo(dropdown);
                            });
                        }
                    });
                },
                getStatus: function () {
                    $.ajax({
                        url: $.Asset.baseURL + "?action=getStatus",
                        type: 'POST',
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response);
                            var dropdown = $($.Asset.statusId);
                            dropdown.find('option').remove();
                            $('<option>').val("0").text('All').appendTo(dropdown);
                            //$('<option>').val("0").text('Not used').appendTo(dropdown);
                            $.each(response.data, function (i, o) {
                                $('<option>').val(o.statusid).text(o.statusname).appendTo(dropdown);
                            });
                        }
                    });
                },
                getLocation: function (statusId) {
                    $.ajax({
                        url: $.Asset.baseURL + "?action=getLocation",
                        type: 'POST',
                        data: {statusId: statusId},
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response);
                            var dropdown = $($.Asset.locationid);
                            dropdown.find('option').remove();
                            $('<option>').val("0").text('All').appendTo(dropdown);
                            //$('<option>').val("0").text('Not used').appendTo(dropdown);
                            $.each(response.data, function (i, o) {
                                $('<option>').val(o.locationid).text(o.locationname).appendTo(dropdown);
                            });
                        }
                    });
                }
            },
            renderTable: function (response) {
                console.log(response);
                var exportTitle = "Asset data";
                var columns = [
                    {
                        data: "imei1",
                        render: function (d, t, r, m) {
                            return m.row + 1;
                        }, title: '#'
                    },
                    {data: "imei1", title: 'IMEI No.'},
//                    {data: function (d) {
//                            return d.modelname;
//                        }, title: 'Tab Model'},
                    {data: function (d) {
                            var user = "-";
                            if (d.provname != "null") {
                                user = '<span class="bold">' + d.provname + "</span> - " + (d.designation != "null" ? d.designation : d.typename);
                            }
                            return user;
                        }, title: "Current User"},
//                    {data: "typename", title: 'Designation'},
                    {data: function (d) {
                            return d.active != "null" ? "<b>" + d.statusname + "  ( " + d.locationname + " )</b>" : "-";
                        }, title: "Status"},
//                    {data: function (d) {
//                            return $.app.date(d.received_date).date;
//                        }, title: 'Issue date'},
                    {data: function (d) {
                            return d.active != "null" ? "<b>" + d.tab_duration.replace(/-/g, " ") + "</b>" : "-";
                        }, title: 'Duration'},
                    {data: function (d) {
                            var json = JSON.stringify({"imei1": d.imei1, "providerid": d.providerid, "zillaid": d.zillaid});
                            var btn = "<a class='btn btn-flat btn-primary btn-xs asset-view' id='" + d.imei1 + "' data-info='" + json + "'><b>Details</b></a>&nbsp;";
                            btn += "<a class='btn btn-flat btn-info btn-xs asset-history' id='" + d.imei1 + "' data-info='" + json + "'><b>History</b></a>&nbsp;";
                            //btn += "<a class='btn btn-flat btn-warning btn-xs asset-update' data-toggle='modal' data-target='#assetUpdate'><b>Update</b></a>&nbsp;";
                            btn += "<a class='btn btn-flat btn-warning btn-xs asset-redistribution' disabled><b>Update Status</b></a>";
                            return btn;
                        }, title: "Action&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"}
                ]
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
                            filename: 'pdf_distributed_asset_info',
                            exportOptions: {columns: [0, 1, 2, 3, 4]}
                        },
                        {
                            extend: 'excelHtml5',
                            text: '<i class="fa fa-file-excel-o" aria-hidden="true"></i> Excel',
                            title: exportTitle,
                            filename: 'excel_distributed_asset_info',
                            exportOptions: {columns: [0, 1, 2, 3, 4]}
                        },
                        {extend: 'pageLength'}
                    ],
                    processing: true,
                    data: response.data,
                    columns: columns
                };
                $('#table').dt(options);
                $.app.overrideDataTableBtn();
                $('.data-view').css("display", "block");
            },
            fillupDropdown: function (selector, data, value, text, defaultText) {
                selector.find('option').remove();
                $('<option>').val("").text(defaultText).appendTo(selector);
                $.each(data, function (i, o) {
                    $('<option>').val(o[value]).text(o[text]).appendTo(selector);
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