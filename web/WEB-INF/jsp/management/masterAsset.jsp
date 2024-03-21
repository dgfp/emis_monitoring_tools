<%-- 
    Document   : distributionAsset
    Created on : Mar 24, 2019, 9:09:02 AM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<link href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css"/>
<style>
    .label {
        border-radius: 11px!important;
    }
    tbody>tr>:nth-child(6) , thead>tr>:nth-child(6){
        text-align:center;
    }
    .menu-btn{
        width: 120px;
    }
</style>
<section class="content-header">
    <h1>Asset (Procured)</h1>
    <ol class="breadcrumb">
        <a class="btn btn-flat btn-primary btn-sm menu-btn" href="asset"><b>Distributed Asset</b></a>
        <a class="btn btn-flat btn-info btn-sm menu-btn" href="asset?type=master"><b>Procured Asset</b></a>
    </ol>
</section>
<section class="content">
    <div class="box box-primary full-screen">
        <div class="box-header with-border">
            <div class="form-group form-group-sm">
                <div class="col-md-1 col-xs-2">
                    <label>Sort by Status</label>
                </div>
                <div class="col-md-2 col-xs-4">
                    <select class="form-control input-sm" name="status" id="status"> 
                        <option selected="selected">Loading</option>
                    </select>
                </div>
            </div>
            <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body">
            <div class="table-responsive">
                <table id="data-table" class="table table-hover table-striped">
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
</section>
<%@include file="/WEB-INF/jspf/asset-details-modal.jspf" %>
<script>
    $(function () {
        $.Asset = $.Asset || {
            init: function () {
                $.Asset.events.bindEvent();
                $.Asset.ajax.setStatus();
                $.Asset.ajax.getMasterAsset();
            },
            events: {
                bindEvent: function () {
                    $.Asset.events.viewAssetDetails();
                    $.Asset.events.viewAssetByStatus();
                },
                viewAssetDetails: function () {
                    $(document).off('click', '.asset-details').on('click', '.asset-details', function (e) {
                        console.log($(this).data("info"));
                        $.Asset.ajax.viewAssetDetails($(this).data("info"));
                    });
                },
                viewAssetByStatus: function () {
                    $(document).off('change', '#status').on('change', '#status', function (e) {
                        console.log($(this).val());
                        $.Asset.ajax.viewAssetByStatus();
                    });
                }
            },
            ajax: {
                setStatus: function () {
                    $.ajax({
                        url: "asset?action=getStatus",
                        type: 'POST',
                        success: function (response) {
                            response = JSON.parse(response);
                            var status = $('select#status');
                            status.find('option').remove();
                            $('<option>').val("0").text('All').appendTo(status);
                            $('<option>').val("").text('Not used').appendTo(status);
                            for (var i = 0; i < response.status.length; i++) {
                                var id = response.status[i].current_status;
                                var name = response.status[i].current_status;
                                $('<option>').val(id).text(name).appendTo(status);
                            }
                        }
                    });
                },
                getMasterAsset: function () {
                    $.ajax({
                        url: "asset?action=getMasterAsset",
                        type: 'POST',
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success === true) {
                                $.Asset.renderTable(response);
                            } else {
                                toastr['error']("Error occured while dashboard loading");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                },
                viewAssetByStatus: function () {
                    $.ajax({
                        url: "asset?action=viewAssetByStatus",
                        type: 'POST',
                        data: {
                            status: $('select#status').val()
                        },
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success === true) {
                                $.Asset.renderTable(response);
                            } else {
                                toastr['error']("Error occured while dashboard loading");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                },
                viewAssetDetails: function (json) {
                    $.ajax({
                        url: "asset?action=viewDistributedMasterAssetDetails",
                        type: 'POST',
                        data: json,
                        success: function (response) {
                            response = JSON.parse(response);

                            if (response.success === true) {
                                var acc = function (status, text) {
                                    return status?text: '<mark><del >' + text + '</del></mark>';
                                }
                                console.log("Hey: ",response.data[0].name_of_user);
                                $("#imei1").text(response.data[0].imei1);
                                $("#current_status").html($.Asset.getStatus(response.data[0].current_status));
                                $("#tab_model").text(response.data[0].tab_model);
                                $("#sim_number").text(response.data[0].sim_number2);
                                $("#sim_source").text(response.data[0].sim_source);
                                $("#accessories").html(acc(response.data[0].cover, 'Cover') + ", &nbsp;&nbsp;" + acc(response.data[0].screen_protector, 'Screen protector') + ", &nbsp;&nbsp;" + acc(response.data[0].charger, 'Charger') + ", &nbsp;&nbsp;" + acc(response.data[0].water_proof_bag, 'Water proof bag'));
                                var user = response.data[0].name_of_user!=""? response.data[0].name_of_user + " - " + response.data[0].designation + " - " + response.data[0].providerid : "";
                                $("#name_of_user").text(user);
                                $("#mobileno").text(response.data[0].mobileno2);
                                $('#viewAsset').modal('show');
                            } else {
                                toastr['error']("Error occured while dashboard loading");
                            }
                        }
                    });
                }
            },
            getStatus: function (current_status) {
                current_status = current_status || '-';
                var codeList = {
                    "Lost": ["warning"],
                    "In use": ["success"],
                    "In Store": ["default"],
                    "Damage": ["danger"],
                    "Vendor": ["info"],
                    "-": ["default", "Not in use"]
                }

                var getStatus = function (current_status) {
                    var item = codeList[current_status];
                    var color = item[0];
                    var text = item[1] || current_status;
                    return '   <span class="label label-flat label-' + color + ' label-xs">' + text + '</span>';
                }
                var action = getStatus(current_status) || "";
                return action;
            },
            renderTable: function (response) {
                var exportTitle = "";
                var columns = [
                    {data: "imei1", title: 'IMEI 1'},
                    {data: "imei2", title: 'IMEI 2'},
                    {data: function (d) {
                            return d.brand + " " + d.model;
                        }, title: "Tab model"},
                    {data: function (d) {
                            var d = d.purchased_date.split("-");
                            ;
                            return d[2] + "/" + d[1] + "/" + d[0];
                        }, title: "Purchased Date"},
//                    {data: function (d) {
//                            return d.accessories;
//                        }, title: "Accessories"},
                    {data: function (d) {
                            var action = $.Asset.getStatus(d.current_status);
                            if (d.current_status != null) {
                                var json = JSON.stringify({"imei1": d.imei1, "sim_number": d.sim_number, "name_of_user": d.name_of_user, "providerid": d.providerid, "mobileno": d.mobileno});
                                action += " <a class='btn btn-flat btn-primary btn-xs asset-details' id='" + d.imei1 + "-" + d.providerid + "_" + d.sim_number + "_" + d.mobileno + "' data-info='" + json + "' data-prov='" + JSON.stringify({"provname": d.provname, "providerid": d.providerid}) + "'><b>Details</b></a>";
                            }
                            return action;
                        }, title: "Status"}
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
                            filename: 'pdf_distributed_asset_info'
                        },
                        {
                            extend: 'excelHtml5',
                            text: '<i class="fa fa-file-excel-o" aria-hidden="true"></i> Excel',
                            title: exportTitle,
                            filename: 'excel_distributed_asset_info'
                        },
                        {extend: 'pageLength'}
                    ],
                    processing: true,
                    data: response.data,
                    columns: columns
                };
                $('#data-table').dt(options);
                $.app.overrideDataTableBtn();

            }
        };
        $.Asset.init();
    });
</script>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.flash.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js" type="text/javascript"></script>