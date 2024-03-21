<%-- 
    Document   : module-launching-info
    Created on : Oct 19, 2017, 12:04:50 PM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<link href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css"/>
<style>
</style>
<script>
    $(function () {

        $('.datePickerChooseForm').datepicker({
            dateFormat: 'mm/dd/yyyy',
            todayBtn: "linked",
            clearBtn: true,
            autoclose: true,
//            startDate: new Date('01-01-2015'),
//            endDate: '+0d'
        });

        var TrainingInfoTable;
        generateModuleInformationTable();
        //Edit table data
        $('#data-table').on('click', '.module-info-edit', function () {
            var row = TrainingInfoTable.row($(this).closest('tr')).data();
            $('#update-id').val(row["id"]);
            $('#update-division').val(row["divisioneng"]);
            $('#update-zilla').val(row["zillanameeng"]);
            $('#update-upazila').val(row["upazilanameeng"]);
            $('#update-module').val(row["module_name"]);
            $('#update-training-type').val(row["training_type_name"]);

            $('#update-start-training-date').datepicker({
                format: "dd MM, yyyy"
            }).datepicker('setDate', row["training_start_date"]);
            
            $('#update-end-training-date').datepicker({
                format: "dd MM, yyyy"
            }).datepicker('setDate', row["training_end_date"]);

            $('#update-participant-number').val(row["participant_number"]);
            $("#modalEditModuleInfo").modal('show');
        });
        
        //Delete data
        $('#data-table').on('click', '.module-info-delete', deleteData);
        function deleteData(id){
            var data = $(this).data('id');
            var data = JSON.stringify({id: data});
            $('#deleteModalModuleLaunchingInfo').modal('show');
            $('#btnConfirmDeleteModuleLaunchingInfo').off().on('click', function(){
                UTIL.request('module-launching-info?action=deleteData', {data:data}, "POST").then(function(resp){
                    console.log(resp);
                    if(resp["rowcount"]==1){
                        alert("Successfully delete");
                        $('#deleteModalModuleLaunchingInfo').modal('hide');
                        generateModuleInformationTable();
                    }
                });
            });
        }

        $('#modalEditModuleInfo').on('show.bs.modal', function () {

        });
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
            $zilla.val() && $.app.select.$upazila($upazila, $zilla.val(), "", "");
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
        //Populate module select
        UTIL.request("module-launching-info?action=getModuleName").then(function (resp) {
            var moduleSelect = $('#module_id');
            for (var i = 0; i < resp.length; i++) {
                var obj = resp[i];
                $('<option>').val(obj['id']).text(obj['name']).appendTo(moduleSelect);
            }
        });
        //Populate training type select
        UTIL.request("module-launching-info?action=getTrainingTypeName").then(function (resp) {
            var moduleSelect = $('#training_type_id');
            for (var i = 0; i < resp.length; i++) {
                var obj = resp[i];
                $('<option>').val(obj['id']).text(obj['name']).appendTo(moduleSelect);
            }
        });

        function generateModuleInformationTable() {
            UTIL.request("module-launching-info?action=getData", "", "POST").then(function (resp) {
                var config = {
                    scrollX: true,
                    data: resp,
                    dom: "Plfrtip",
                    columns: [
                        {data: "divisioneng"},
                        {data: "zillanameeng"},
                        {data: "upazilanameeng"},
                        {data: "module_name"},
                        {data: "training_type_name"},
                        {data: "training_start_date"},
                        {data: "training_end_date"},
                        {data: "participant_number"},
                        {data: "document_url", render: function (data, type, row) {
                                if (data != 'null') {
                                    data = '/data/' + data;
                                    return '<a target="_blank" href="' + data + '"' + '> View file</a>';
                                } else {
                                    return '-';
                                }
                            }},
                        {data: null, render: function (data, type, row) {
//                                console.log(data, type, row);
                                return '<button class="btn btn-flat btn-primary btn-sm btn-block module-info-edit" data-id=' + row['id']
                                        + '>'
                                        + '<i class="fa fa-table" aria-hidden="true"></i> Edit'
                                        + '</button>' 
                                + '<button class="btn btn-flat btn-danger btn-sm btn-block module-info-delete" data-id=' + row['id']
                                        + '>'
                                        + '<i class="fa fa-trash" aria-hidden="true"></i> Delete'
                                        + '</button>';
                            }
                        }
                    ]
                };
                if (TrainingInfoTable) {
                    TrainingInfoTable.clear();
                    TrainingInfoTable.destroy();
                }
                TrainingInfoTable = $("#data-table").DataTable(config);
            });
        }
        $('#moduleLaunchingForm').ajaxForm({
            url: 'module-launching-info?action=submitData',
            beforeSubmit: function (formData, jqForm, options) {
                var training_start_date = $("#training_start_date").val();
                var training_end_date = $("#training_end_date").val()
                if (!training_start_date || !training_end_date) {
                    alert("Date required");
                    return false;
                }
            },
            success: function (responseText, statusText, xhr, $form) {
                console.log(responseText, statusText, xhr, $form);
                responseText = JSON.parse(responseText);
                if (responseText["rowcount"] > 0) {
                    $("#moduleLaunchingForm").resetForm();
                    $(".datePickerChooseForm").val("").datepicker("update");
                    $.toast('Data inserted', 'success')();
                } else {
                    $.toast('Try again', 'error')();
                }
                generateModuleInformationTable();
            },
            error: function (responseText, statusText, xhr, $form) {
                $.toast('Try again', 'error')();
            }
        });

//        $("#moduleLaunchingForm").on("submit", function (e) {
//            e.preventDefault();
////            var training_start_date = $("#training_start_date").val()
////            if (!training_start_date) {
////                alert("Date required");
////                return false;
////            }
////            $.ajax({
////                type: 'Post',
////                url: 'module-launching-info?action=submitData',
////                data: $("#moduleLaunchingForm").serialize(),
////                enctype: 'multipart/form-data',
////                success: function(result){
////                    console.log(result);
////                },
////                error: function(result){
////                    console.log("error", result);
////                }
////            });
////            var form = $("#moduleLaunchingForm");
////            console.log(form.serializeArray());
//            //JSON.stringify($.app.pairs('#moduleLaunchingForm'));
//
////            UTIL.request("module-launching-info?action=submitData", {data: data}, "POST").then(function (resp) {
//////                console.log(resp);
////                if (resp["rowcount"] > 0) {
////                    $("#moduleLaunchingForm")[0].reset();
////                }
////                else{
////                    $.toast('Try again', 'error')();
////                }
////                generateModuleInformationTable();
////            });
//        });
//        $("#editModuleInfoForm").ajaxForm({
//            url: 'module-launching-info?action=updateData',
//            success: function(responseText, statusText, xhr, $form){
//                responseText = JSON.parse(responseText);
//                if (responseText["rowcount"] == 1) {
//                    $.toast('Successfully updated', 'success')();
//                    $('#modalEditModuleInfo').modal('hide');
//                } else {
//                    $.toast('Error occured', 'error')();
//                }
//                generateModuleInformationTable();
//            }
//        });
        
        $("#editModuleInfoForm").on("submit", function (e) {
            e.preventDefault();
            var data = JSON.stringify($.app.pairs('#editModuleInfoForm'));
            UTIL.request('module-launching-info?action=updateData', {data: data}, "POST").then(function (resp) {
                console.log(resp);
                if (resp["rowcount"] == 1) {
                    $.toast('Successfully updated', 'success')();
                    $('#modalEditModuleInfo').modal('hide');
                } else {
                    $.toast('Error occured', 'error')();
                }
                generateModuleInformationTable();
            });
        });
    });
</script>
<section class="content-header">
    <h1> Training information 
        <!--<small>This page is under construction</small>-->
    </h1>
</section>
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
                    <form action="/" method="post" id="moduleLaunchingForm" enctype='multipart/form-data'>
                        <div class="form-row">
                            <div class="form-group row">
                                <label for="division" class="col-sm-2 col-form-label">Division</label>
                                <div class="col-sm-10">
                                    <select class="form-control" name="division" id="division" required>
                                        <option value="">- Select division -</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="zilla" class="col-sm-2 col-form-label">District</label>
                                <div class="col-sm-10">
                                    <select class="form-control" name="zilla" id="zilla" required>
                                        <option value="">- Select district -</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="upazila" class="col-sm-2 col-form-label">Upazila</label>
                                <div class="col-sm-10">
                                    <select class="form-control" name="upazila" id="upazila" required>
                                        <option value="">- Select upazila -</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="moduleid" class="col-sm-2 col-form-label">Organized For</label>
                                <div class="col-sm-10">
                                    <select class="form-control" name="organized_for" id="organized_for" required>
                                        <option value="">- Select Organization -</option>
                                        <option value="1">DGFP</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="moduleid" class="col-sm-2 col-form-label">Module</label>
                                <div class="col-sm-10">
                                    <select class="form-control" name="module_id" id="module_id" required>
                                        <option value="">- Select module -</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="training_type_id" class="col-sm-2 col-form-label">Training Type</label>
                                <div class="col-sm-10">
                                    <select class="form-control" name="training_type_id" id="training_type_id" required>
                                        <option value="">- Select training type -</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="training_start_date" class="col-sm-2 col-form-label">Start date</label>
                                <div class="col-sm-10">
                                    <input type="text" class="input form-control input-sm datePickerChooseForm" placeholder="yyyy/mm/dd" name="training_start_date" id="training_start_date" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="training_start_date" class="col-sm-2 col-form-label">End date</label>
                                <div class="col-sm-10">
                                    <input type="text" class="input form-control input-sm datePickerChooseForm" placeholder="yyyy/mm/dd" name="training_end_date" id="training_end_date" />
                                </div>
                            </div>
                            <!--                            <div class="form-group row">
                                                            <label for="moduleid" class="col-sm-2 col-form-label">Module</label>
                                                            <div class="col-sm-10">
                                                                <select class="form-control" name="module_id" id="module_id" required>
                                                                    <option value="">- Select module -</option>
                                                                </select>
                                                            </div>
                                                        </div>-->
                            <div class="form-group row">
                                <label for="participant_number" class="col-sm-2 col-form-label">Participant number</label>
                                <div class="col-sm-10">
                                    <input type="number" class="form-control" name="participant_number" id="participant_number" required />
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="document_file" class="col-sm-2 col-form-label">Start date</label>
                                <div class="col-sm-10">
                                    <input type="file" class="input form-control input-sm" name="document_file" id="document_file" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-12">
                                    <button type="submit" class="btn btn-flat btn-primary btn-sm btn-block" autocomplete="off" >
                                        <i class="fa fa-table" aria-hidden="true"></i> Submit
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="box box-primary full-screen">
        <div class="row">
            <div class="col-md-12">
                <h2 id="typeTitle"><span class="label label-default"></span></h2>
                <div class="table-responsive1 no-padding" style="padding: 10px !important;">
                    <table id="data-table" class="table table-bordered table-striped table-hover">
                        <thead id="tableHeader">
                            <tr>
                                <th>Division</th>
                                <th>Zilla</th>
                                <th>Upazila</th>
                                <th>Module</th>
                                <th>Training type</th>
                                <th>Start date</th>
                                <th>End date</th>
                                <th>Participant</th>
                                <th>File</th>
                                <th>Update</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!--Edit modal-->
    <div class="modal fade" id="modalEditModuleInfo" role="dialog">
        <div class="modal-dialog">
            <div class="box">
                <div class="box-body">
                    <div class="modal-content">

                        <form method="post" id="editModuleInfoForm" action="/" class="form-horizontal" role="form">
                            <div class="modal-header">
                                <button type="button" class="close bold" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></button>
                                <h4 class="modal-title bold" id="myModalLabel">Update training information</h4>
                            </div>
                            <div class="modal-body">
                                <div class="form-group form-group-sm hidden">
                                    <label class="control-label col-sm-4"> <span class="star">*</span></label>
                                    <div class="col-sm-5">
                                        <input type="text" class="form-control check-pos-num" name="id" id="update-id">
                                    </div>
                                </div>


                                <div class="form-group form-group-sm">
                                    <label class="control-label col-sm-4">Division: <span class="star">*</span></label>
                                    <div class="col-sm-5">
                                        <input type="text" class="form-control check-pos-num" name="update-division" id="update-division" disabled="true">
                                    </div>
                                </div>

                                <div class="form-group form-group-sm">
                                    <label class="control-label col-sm-4">Zilla: </label>
                                    <div class="col-sm-5">          
                                        <input type="text" class="form-control" name="update-zilla" id="update-zilla" disabled="true">
                                    </div>
                                </div>

                                <div class="form-group form-group-sm">
                                    <label class="control-label col-sm-4">Upazila: </label>
                                    <div class="col-sm-5">
                                        <input type="text" class="form-control" name="update-upazila" id="update-upazila" disabled="true">
                                    </div>
                                </div>
                                <div class="form-group form-group-sm">
                                    <label class="control-label col-sm-4">Module: </label>
                                    <div class="col-sm-5">
                                        <input type="text" class="form-control" name="update-module" id="update-module" disabled="true">
                                    </div>
                                </div>
                                <div class="form-group form-group-sm">
                                    <label class="control-label col-sm-4"> Training type </label>
                                    <div class="col-sm-5">
                                        <input type="text" class="form-control" name="update-training-type" id="update-training-type" disabled="true">
                                    </div>
                                </div>
                                <div class="form-group form-group-sm">
                                    <label class="control-label col-sm-4"> Start date </label>
                                    <div class="col-sm-5">
                                        <input type="text" class="form-control" name="training_start_date" id="update-start-training-date">
                                    </div>
                                </div>
                                <div class="form-group form-group-sm">
                                    <label class="control-label col-sm-4"> End date </label>
                                    <div class="col-sm-5">
                                        <input type="text" class="form-control" name="training_end_date" id="update-end-training-date">
                                    </div>
                                </div>
                                <div class="form-group form-group-sm">
                                    <label class="control-label col-sm-4">Participant number: </label>
                                    <div class="col-sm-5">
                                        <input type="number" class="form-control" name="participant_number" id="update-participant-number">
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-flat btn-success btn-md bold"><i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Update</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Delete modal-->
    <div class="modal fade" id="deleteModalModuleLaunchingInfo" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">

            <!--            <div class="modal-header label-danger">
                            <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                            <h4 class="modal-title"><b><i class="fa fa-trash" aria-hidden="true"></i><span> Are you sure to delete?</span></b></h4>
                        </div>-->

            <div class="modal-header">
                <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold">Confirm Deletion</h4>
            </div>

            <div class="modal-body">
                <h4 class="center bold"><i class="fa fa-question-circle" aria-hidden="true"></i>&nbsp; Are you sure you want to delete ?</h4>
                <p id="deleteReportingUnitName" style="font-size: 16px;text-align: center"></p>
                <!--                <button type="button" id="btnConfirm-deleteVillage" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger">Confirm</button>&nbsp;&nbsp;-->
                <!--                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Cancel</button>-->
            </div>

            <div class="modal-footer">
                <button type="button" id="btnConfirmDeleteModuleLaunchingInfo" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger bold"><i class="fa fa-check-square-o" aria-hidden="true"></i>&nbsp; Confirm</button>&nbsp;&nbsp;
                <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal"><i class="fa fa-window-close-o" aria-hidden="true"></i>&nbsp; Cancel</button>
            </div>
        </div>
    </div>
</div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script>
    $(function () {
        $.MAWDashboard = $.MAWDashboard || {
            formData: null,
            init: function () {
                $.MAWDashboard.events.bindEvent();
                $(".full-screen").after($.app.getWatermark());
            },
            events: {
                bindEvent: function () {
                    $.MAWDashboard.events.demo();
                },
                demo: function () {
                    $(document).off('submit', '#showData').on('submit', '#showData', function (e) {
                        $.MAWDashboard.ajax.demo();
                    });
                },
            },
            ajax: {
                demo: function () {
                    $.ajax({
                        url: "demo?action=getStatus",
                        type: "POST",
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success == true) {
                            } else {
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                }
            }
        };
//        $.MAWDashboard.init();
    });
</script>
<script src="resources/jquery.forms/jquery.form.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.flash.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js" type="text/javascript"></script>
