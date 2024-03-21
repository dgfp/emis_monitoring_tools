<%-- 
    Document   : distributionAsset
    Created on : Mar 24, 2019, 9:09:02 AM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<!--<script src="resources/js/asset.js" type="text/javascript"></script>-->
<!--<script src="resources/js/asset_management.js" type="text/javascript"></script>-->
<script src="resources/js/asset.js" type="text/javascript"></script>
<link href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css"/>
<style>
    .label {
        border-radius: 11px!important;
    }
    tbody>tr>:nth-child(5), tbody>tr>:nth-child(7), thead>tr>:nth-child(5), thead>tr>:nth-child(7){
        text-align:center;
    }
    .menu-btn{
        width: 120px;
    }
    .col_ {
        width: 23.666667%;
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
</style>
<section class="content-header">
    <h1>Asset (Distributed)</h1>
    <!--    <ol class="breadcrumb">
            <a class="btn btn-flat btn-info btn-sm menu-btn" href="asset"><b>Distributed Asset</b></a>
            <a class="btn btn-flat btn-primary btn-sm menu-btn" href="asset?type=master"><b>Procured Asset</b></a>
        </ol>-->
</section>
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary full-screen">
                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
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
                                    <option> - select District - </option>
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
                                <label for="provtype">Type</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="provtype" id="provtype"> 
                                    <option value="0">All</option>
                                </select>
                            </div>
                            <div class="col-md-1 col-xs-2">
                                <label for="status_id">Status</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="status_id" id="status_id"> 
                                    <option value="0">All</option>
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
<%@include file="/WEB-INF/jspf/asset-details-modal.jspf" %>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script>
    $(function () {
        $.Asset = $.Asset || {
            provtype: "#provtype",
            statusId: "#status_id",
            baseURL: "asset",
            init: function () {
                $.Asset.events.bindEvent();
                //$.Asset.events.viewData();
                $.Asset.ajax.setDesignation();
                $.Asset.ajax.setStatus();
                //$.Asset.ajax.getDistributedData();
            },
            events: {
                bindEvent: function () {
                    $.Asset.events.showData();
                    $.Asset.events.viewAssetDetails();
                    //$.Asset.events.viewAssetByDesignation();
                    //$.Asset.events.viewAssetByStatus();
                },
                showData: function () {
                    $(document).off('submit', '#showData').on('submit', '#showData', function (e) {
                        e.preventDefault();
                        var area = $.app.pairs('form');
                        if (area.divid == "") {
                            $.toast('Please select division', 'error')();
                            return false;
                        } else if (area.zillaid == "") {
                            $.toast('Please select district', 'error')();
                            return false;
                        } else if(area.zillaid != '49'){
                            $.toast('No data found !', 'error')();
                            return false;
                        }
                        $.Asset.ajax.showData(area);
                    });
                },
                viewAssetDetails: function () {
                    $(document).off('click', '.asset-view').on('click', '.asset-view', function (e) {
                        $.Asset.ajax.viewDistributedAssetDetails($(this).data("info"));
                    });
                },
                viewAssetByDesignation: function () {
                    $(document).off('change', '#designation').on('change', '#designation', function (e) {
                        console.log($(this).val());
                        $.Asset.ajax.viewAssetBySelector();
                    });
                },
                viewAssetByStatus: function () {
                    $(document).off('change', '#status').on('change', '#status', function (e) {
                        console.log($(this).val());
                        $.Asset.ajax.viewAssetBySelector();
                    });
                },
            },
            ajax: {
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
                setStatus: function () {
                    $.ajax({
                        url: "asset?action=getStatus",
                        type: 'POST',
                        success: function (response) {
                            response = JSON.parse(response);
                            var dropdown = $($.Asset.statusId);
                            dropdown.find('option').remove();
                            $('<option>').val("0").text('All').appendTo(dropdown);
                            $.each(response.status, function (i, o) {
                                $('<option>').val(o.status_id).text(o.name + " [" + o.status_id + "]").appendTo(dropdown);
                            });
                        }
                    });
                },
                showData: function (json) {
                    $.ajax({
                        url: $.Asset.baseURL + "?action=showData",
                        type: "POST",
                        data: {asset: JSON.stringify(json)},
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
//                getDistributedData: function () {
//                    $.ajax({
//                        url: "asset?action=getDistributedData",
//                        type: 'POST',
//                        success: function (response) {
//                            response = JSON.parse(response);
//                            if (response.success === true) {
//                                $.Asset.renderTable(response);
//                            } else {
//                                toastr['error']("Error occured while dashboard loading");
//                            }
//                        }, error: function (error) {
//                            toastr['error'](error);
//                        }
//                    });
//                },
//                viewAssetBySelector: function () {
//                    $.ajax({
//                        url: "asset?action=viewAssetBySelector",
//                        type: 'POST',
//                        data: {
//                            designation: $('select#designation').val(),
//                            status: $('select#status').val()
//                        },
//                        success: function (response) {
//                            response = JSON.parse(response);
//                            if (response.success === true) {
//                                $.Asset.renderTable(response);
//                            } else {
//                                toastr['error']("Error occured while dashboard loading");
//                            }
//                        }, error: function (error) {
//                            toastr['error'](error);
//                        }
//                    });
//                },
                viewDistributedAssetDetails: function (json) {
                    console.log(json);

                    $.ajax({
                        url: "asset?action=assetDetails",
                        type: 'POST',
                        data: json,
                        success: function (response) {
                            response = JSON.parse(response);
                            var json = response.data[0];
                            if (response.success === true) {
                                console.log(response);
                                $('#viewAsset').modal('show');
                                var acc = function (status, text) {
                                    return status ? '<span style="color: #04723f">'+text+'</span>' : '<mark><del >' + text + '</del></mark>';
                                }
                                $("#provname").text(json.provname+" - "+json.providerid);
                                $("#providertype").text(json.provtype);
                                $("#mobileno").text(json.mobileno);
                                $("#imei1").text(json.imei1);
                                $("#imei2").text(json.imei2);
                                $("#specification").text(json.brand + " " + json.model);
                                $("#simnumber").text(json.simnumber);
                                $("#simsource").text(json.simsource);
                                $("#simoperator").text(json.simoperator);
                                $("#status1").html($.Asset.status[json.status_id][1]);
                                $("#issueDate").text($.app.date(json.received_date).date);
                                $("#duration").html("<b>" + json.duration.replace(/-/g, " ") + "</b>");
                                $("#accessories").html(acc(json.cover, 'Cover') + ", &nbsp;&nbsp;" + acc(json.screen_protector, 'Screen protector') + ",<br/>" + acc(json.charger, 'Charger') + ", &nbsp;&nbsp;" + acc(json.water_proof_bag, 'Water proof bag'));
                                $('#viewAsset').modal('show');
                            } else {
                                toastr['error']("Error occured while dashboard loading");
                            }
                        }
                    });
                }
            },
            renderTable: function (response) {
                console.log(response);
                var exportTitle = "";
                var columns = [
                    {
                        data: "imei1",
                        render: function (d, t, r, m) {
                            return m.row + 1;
                        }, title: '#'
                    },
                    {data: function (d) {
                            return  "<b>" + d.provname + "</b><span style='color: #575a5e;'> - " + d.providerid + "</span>";
                        }, title: "Provider&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"},
                    {data: "provtype", title: 'Type'},
                    {data: function (d) {
                            return $.Asset.status[d.status_id][1];
                        }, title: "Status"},
                    {data: "imei1", title: 'IMEI'},
                    {data: function (d) {
                            return d.brand + " " + d.model;
                        }, title: 'Tab Model'},
                    {data: function (d) {
                            return $.app.date(d.received_date).date;
                        }, title: 'Issue date'},
                    {data: function (d) {
                            return "<b>" + d.duration.replace(/-/g, " ") + "</b>";
                        }, title: 'Duration'},
                    {data: function (d) {
                            var json = JSON.stringify({"imei1": d.imei1, "providerid": d.providerid, "zillaid": d.zillaid});
                            return  "<a class='btn btn-flat btn-primary btn-xs asset-view' id='" + d.imei1 + "-" + d.providerid + "_" + d.simnumber + "_" + d.mobileno + "' data-info='" + json + "' data-prov='" + JSON.stringify({"provname": d.provname, "providerid": d.providerid}) + "'><b>Details</b></a>";
                        }, title: "Action"}
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
                            exportOptions: {columns: [0, 1, 2, 3, 4, 5, 6, 7]}
                        },
                        {
                            extend: 'excelHtml5',
                            text: '<i class="fa fa-file-excel-o" aria-hidden="true"></i> Excel',
                            title: exportTitle,
                            filename: 'excel_distributed_asset_info',
                            exportOptions: {columns: [0, 1, 2, 3, 4, 5, 6, 7]}
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
            status: {
                1: ['Vendor', '<span class="label label-flat label-info label-xs">Vendor</span>'],
                2: ['In use', '<span class="label label-flat label-success label-xs">In use</span>'],
                3: ['Lost', '<span class="label label-flat label-warning label-xs">Lost</span>'],
                4: ['Damage', '<span class="label label-flat label-danger label-xs">Damage</span>'],
                5: ['In Store', '<span class="label label-flat label-warning label-xs">In Store</span>'],
                6: ['Condemned', '<span class="label label-flat label-default label-xs">Condemned</span>']
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
<!--fixed header
export resource
Response with json array note string json from servlet-->