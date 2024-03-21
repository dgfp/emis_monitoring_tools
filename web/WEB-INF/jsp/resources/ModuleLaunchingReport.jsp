<%-- 
    Document   : module-launching-info
    Created on : Oct 19, 2017, 12:04:50 PM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeaderELCO.jspf" %>
<script src="resources/js/area_dropdown_control_global.js"></script>
<style>
    #dateBlock,#training-type-container{
        display: none;
    }
    .div-span{
        border-bottom: 1px solid #dbc5c5;
        text-align: left;
        padding-left: 3px;
    }

    .rm-padd{
        padding-left: 0 !important;
        padding-right: 0 !important;
    }
    #unitDiv, #villDiv, #_monthly, #_yearly, #viewTypeBlock {
        display: none;
    }
    #printTable{
        display: none;
    }
    #tableView{
        display: none;
    }
    .box-body {
        padding: 10px 10px 0px 10px!important;
    }
    #areaDropDownPanel [class*="col"] { margin-bottom: 10px; }
    #radioDiv { margin-bottom: 0px!important; }
    span.td {
        border-top-color: #e0e0e0;
    }
    #rightAlign{
        text-align: right!important;
        vertical-align: middle;
    }
    #areaDropDownPanel .box {
        margin-bottom: 0px!important;
    }
    #tableFooter {
        background-color: #fff;
        font-weight: bold;
    }
    .label-progress{
        width: 100%;
        padding: 0.4em .7em .4em;
        font-weight: 700;
        line-height: 1.1;
        text-align: center;
        white-space: nowrap;
        border-radius: .25em;
    }

    .ui-widget-header {
        background: #3C8DBC!important;
    }   
    .ui-corner-all, .ui-corner-bottom, .ui-corner-left, .ui-corner-bl {
        border-radius: 0px!important;
    }
    .mtz-monthpicker{
        cursor: pointer!important;
    }
    .warp{
        padding: 2px 4px; 
        color: #fff;
        border-radius: 7px;
    }
    .type-active{
        background-color: #EC971F;
    }
    .type-inactive{
        background-color: #dbdbdb; 
        color: #6d6d6d;
    }
    .view-active{
        background-color: #31B0D5; 

    }
    .view-inactive{
        background-color: #dbdbdb; 
        color: #6d6d6d;
    }
    .viewTitle{
        margin-top: 0px!important;
        margin-bottom: 16px!important;
        text-align: center;
    }
    .viewTitle > .label-default {
        background-color: #efefef;
    }
    .monthPickerChoose{
        background-color: rgb(255, 255, 255)!important;
    }
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
    #tableView, .prs-info{}
    #mapView, #graphView, #areaPanel{
        display: none;
    }
    .numeric_field{
        text-align: right;
    }
    .info-box-text{
        text-transform: capitalize;
    }
    #tableFooter {
        background-color: #fff;
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
    .content-header h1 {
        color: #000!important;
    }
    #mapView, #graphView, #tableView, .prs-info, #areaPanel, .status-info{
        display: none;
    }

    .box-header.with-border {
        border-bottom: none!important; 
    }
    #sort-by{
        display: none;
    }
    .training-ft-completeness{
        text-align: right;
    }
    .custom-search-text{
        /*text-align: right;*/
        /*width: 70px;*/
        padding-right: 20px;
        padding-bottom: 10px;
        font-weight:700;
    }
</style>
<script>
    var TrainingInfoTable;
    $(function () {
//        loadData();
        $("#areaDropDownPanel").slideDown("slow");
        $("#training_end_date").datepicker("setDate", 'today');
//        $('.datePickerChooseForm').datepicker({
//            dateFormat: 'mm/dd/yyyy',
//            todayBtn: "linked",
//            clearBtn: true,
//            autoclose: true,
////            startDate: new Date('01-01-2015'),
//            endDate: '+0d'
//        });

        $('#exportPrint').click(function () {
            console.log(TrainingInfoTable.draw());
            return false;
            var contents = TrainingInfoTable.draw();
            var frame1 = $('<iframe />');
            frame1[0].name = "frame1";
            frame1.css({"position": "absolute", "top": "-1000000px"});
            $("body").append(frame1);
            var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
            frameDoc.document.open();
            //Create a new HTML document.
            frameDoc.document.write('<html><head><title>eMIS Initiative</title>');
            frameDoc.document.write('</head><body>');
            //Append the external CSS file. //border-collapse: collapse;
            frameDoc.document.write('<style>table, th, td{border:1px solid black; border-collapse: collapse;padding:10px;}th{vertical-align: text-center} th td{text-align:left;} .area{text-align: left !important;}</style>');
            //Append the DIV contents.
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center!important;"><center>Eligible couple registration status</center></h3>');
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center!important;"><center>' + $('.viewTitle > .label').html() + '</center></h3>');
            frameDoc.document.write('<h5 style="color:black;text-align:center!important;"><center>' + "" + '</center></h5>');
            frameDoc.document.write(contents);
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 500);
        });
        $.ajax({
            url: 'module-launching-report?action=getModule',
            type: "POST",
            success: function (data, textStatus, jqXHR) {
                try {
                    console.log(data);
                    var selectTag = $('#module_id');
                    selectTag.find('option').remove();
                    $('<option>').val("").text('- All -').appendTo(selectTag);
                    for (var i = 0; i < data.length; i++) {
                        var id = data[i].id;
                        var name = data[i].name;
                        $('<option>').val(id).text(name).appendTo(selectTag);
                    }
                } catch (e) {
                    console.log(e);
                    $.toast('Request can not be processed', 'error')();
                }
            },
            error: function (jqXHR, textStatus, error) {
                console.log(error);
                $.toast('Request can not be processed', 'error')();
            }
        });
        $.ajax({
            url: 'module-launching-report?action=getTrainingType',
            type: "POST",
            success: function (data, textStatus, jqXHR) {
                try {
                    console.log(data);
                    var selectTag = $('#training_type_id');
                    selectTag.find('option').remove();
                    $('<option>').val("").text('- Select Type -').appendTo(selectTag);
                    for (var i = 0; i < data.length; i++) {
                        var id = data[i].id;
                        var name = data[i].name;
                        $('<option>').val(id).text(name).appendTo(selectTag);
                    }
                } catch (e) {
                    console.log(e);
                    $.toast('Request can not be processed', 'error')();
                }
            },
            error: function (jqXHR, textStatus, error) {
                console.log(error);
                $.toast('Request can not be processed', 'error')();
            }
        });
        $('#moduleLaunchingReportForm').on('submit', function (e) {
            e.preventDefault();
            var data = $.app.pairs("#moduleLaunchingReportForm");
            console.log(data);
            var startDate = moment(data["training_start_date"], "DD/MM/YYYY").toDate();
            var endDate = moment(data["training_end_date"], "DD/MM/YYYY").toDate();
            console.log(startDate, endDate);
            var isAfter = moment(startDate).isAfter(endDate);
            if (endDate == "Invalid Date") {
                $.toast('Select proper to date', 'error')();
                return false;
            }
            if (isAfter) {
                $.toast('End date should not be less than start date', 'error')();
                return false;
            }
            if (data["division"] == "") {
                $.toast('Please select division', 'error')();
                return false;
            }
            if (data["training_type_id"] == "") {
                $.toast('Please select training type', 'error')();
                return false;
            }
            var modified_data = {};
            $.map(data, function (v, k) {
                console.log(v, k);
                if ((k == 'training_start_date' || k == 'training_end_date') && !v) {
                    modified_data[k] = null;
                } else if (!v || v == '0') {
                    modified_data[k] = '%';
                } else {
                    modified_data[k] = v;
                }
//                modified_data[k] = v;
            });
            if (modified_data["training_start_date"]) {
                modified_data["training_start_date"] = moment(modified_data["training_start_date"], "DD/MM/YYYY").format("MM/DD/YYYY");
            }
            if (modified_data["training_end_date"]) {
                modified_data["training_end_date"] = moment(modified_data["training_end_date"], "DD/MM/YYYY").format("MM/DD/YYYY");
            }
            console.log(modified_data);
//            return false;
            $.ajax({
                url: 'module-launching-report?action=getReportCatchment',
                type: "POST",
                data: {data: JSON.stringify(modified_data)},
                success: function (data, textStatus, jqXHR) {
                    try {
                        generateModuleReport(data);
                        $("#tableView").slideDown("slow");
                    } catch (e) {
                        console.log(e);
                        $.toast('Request can not be processed', 'error')();
                    }
                },
                error: function (jqXHR, textStatus, error) {
                    $.toast('Request can not be processed', 'error')();
                }
            });
        });
//        //Populate module select
//        UTIL.request("module-launching-info?action=getModuleName").then(function (resp) {
//            var moduleSelect = $('#module_id');
//            for (var i = 0; i < resp.length; i++) {
//                var obj = resp[i];
//                $('<option>').val(obj['id']).text(obj['name']).appendTo(moduleSelect);
//            }
//        });
//        //Populate training type select
//        UTIL.request("module-launching-info?action=getTrainingTypeName").then(function (resp) {
//            var moduleSelect = $('#training_type_id');
//            for (var i = 0; i < resp.length; i++) {
//                var obj = resp[i];
//                $('<option>').val(obj['id']).text(obj['name']).appendTo(moduleSelect);
//            }
//        });
        function loadData() {
            $.ajax({
                url: 'module-launching-report?action=getReport',
                type: "POST",
                success: function (data, textStatus, jqXHR) {
//                    console.log(data);
                    generateModuleReport(data);
//                    var data = JSON.parse(data);
//                    generateModuleReport(data);
                    $("#tableView").slideDown("slow");
                },
                error: function (jqXHR, textStatus, error) {
                    $.toast('Request can not be processed', 'error')();
                }
            });
        }
        function generateModuleReport(data) {
            console.log(data);
            var config = {
                data: data,
                dom: 'Pli<"row"<"col-md-3 col-md-offset-7"<"custom-search-text pull-right">>>f<"training-ft-completeness">rtp', //
                columns: [
                    {data: "upazilanameeng"},
                    {data: function (d) {
                            return "";
                        }},
                    {data: function (d) {
                            return "";
                        }},
                    {data: function (d) {
                            return "";
                        }},
                    {data: function (d) {
                            return "";
                        }},
                    {data: function (d) {
                            return "";
                        }},
                    {data: "status"}
//                    {data: null, render: function (data, type, row) {
////                                console.log(data, type, row);
//                            return '<button class="btn btn-flat btn-primary btn-sm btn-block module-info-edit" data-id=' + row['id']
//                                    + '>'
//                                    + '<i class="fa fa-table" aria-hidden="true"></i> Edit'
//                                    + '</button>';
//                        }
//                    }
                ],
                columnDefs: [{orderable: false, targets: [1, 2, 3, 4, 5]}, {"searchable": false, "targets": [1, 2, 3, 4, 5]}],
                createdRow: function (row, data, dataIndex) {
//                    console.log(data);
                    var len = data['json'].length;
                    UTIL.generateDivSpanDT($('td:eq(1)', row), len, data['json'], 'module');
                    UTIL.generateDivSpanDT($('td:eq(2)', row), len, data['json'], 'training_start_date');
                    UTIL.generateDivSpanDT($('td:eq(3)', row), len, data['json'], 'training_end_date');
                    UTIL.generateDivSpanDT($('td:eq(4)', row), len, data['json'], 'participant_number');
                    UTIL.generateDivSpanDT($('td:eq(5)', row), len, data['json'], 'total_batch');
                },
                drawCallback: function (settings) {
                    var api = this.api();
//                    console.log(api.rows().data());
                    var data = api.rows({search:'applied'}).data();
                    var sum_participant = 0;
                    var sum_batch = 0;
                    $.each(data, function (i, d) {
                        $.each(d['json'], function (i2, d2) {
//                            console.log(d2["participant_number"]);
                            sum_participant = sum_participant + d2["participant_number"];
                        });
                    });
                    $.each(data, function (i, d) {
                        $.each(d['json'], function (i2, d2) {
//                            console.log(d2["participant_number"]);
                            sum_batch = sum_batch + d2["total_batch"];
                        });
                    });
                    $('#total_participant').html(sum_participant);
                    $('#total_batch').html(sum_batch);
                },
                "oLanguage": {
                    "sSearch": "Upazila "
                },
                initComplete: function () {
                    this.api().columns(6).every(function () {
                        if ($('#training_type_id').val() == "2" || $('#module_id').val() != "") {
//                            config.columnDefs.push({visible: false, targets: [6]});
                        } else {
                            var column = this;

                            var select = $('<select id="formfilter" class="filterdropdown form-control input-sm"><option value="">' + "All" + '</option></select>')
                                    .appendTo($($('div.training-ft-completeness')).empty())
                                    .on('change', function (e) {
                                        e.stopPropagation();
                                        var val = $.fn.dataTable.util.escapeRegex(
                                                $(this).val()
                                                );
                                        console.log(column);
                                        column
                                                .search(val ? '^' + val + '$' : '', true, false)
                                                .draw();
                                    });

                            column.data().unique().sort().each(function (d, j) {
                                select.append('<option value="' + d + '">' + d + '</option>');
                            });
                            var header = $('.custom-search-text').html("Search By: ");
                            var label = $('<label style="font-weight: 500;width:200px;">Completeness&nbsp</label>').prependTo('div.training-ft-completeness');
                            $('.dataTables_filter input[type="search"]').css(
                                    {'width': '198px'}
                            );
                        }
                    })
                }
            };
            if (TrainingInfoTable) {
                TrainingInfoTable.clear();
                TrainingInfoTable.destroy();
            }
            if ($('#training_type_id').val() == "2" || $('#module_id').val() != "") {
                config.columnDefs.push({visible: false, targets: [6]});
            }
            TrainingInfoTable = $("#data-table").DataTable(config);
//            $("div.training-ft-completeness").html('<b>Custom tool bar! Text/images etc.</b>');
        }
    }
    );
</script>
<section class="content-header">
    <h1> Training Report 
<!--        <small>This page is under construction</small>-->
    </h1>
</section>
<section class="content">
    <div class="row" id="areaDropDownPanel">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-body">
                    <form role="form" id="moduleLaunchingReportForm">
                        <input type="hidden" value="${userLevel}" id="userLevel">
                        <div class="row">
                            <div class="col-md-1 col-xs-2">
                                <label for="district">Division</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="division" id="division"> 
                                    <!--<option value="">- Select Division -</option>-->
                                </select>
                            </div>
                            <div class="col-md-1 col-xs-2">
                                <label for="district">District</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="zilla" id="district">
                                    <option value="">- Select District -</option>
                                </select>
                            </div>
                            <div class="col-md-1 col-xs-2">
                                <label for="upazila">Upazila</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="upazila" id="upazila" >
                                    <option value="">- Select Upazila -</option>
                                </select>
                            </div>
                            <!--                            <div class="col-md-1 col-xs-2">
                                                            <label for="union">Union</label>
                                                        </div>
                                                        <div class="col-md-2 col-xs-4">
                                                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="union" id="union" >
                                                                <option value="">- Select Union -</option>
                                                            </select>
                                                        </div>-->
                        </div>
                        <div class="row">

                            <div class="col-md-1 col-xs-2">
                                <label for="upazila">Module</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="module_id" id="module_id" >
                                    <option value="">- Select All -</option>
                                </select>
                            </div>


                        </div>
                        <div id="training-type-container">
                            <div class="row">

                                <div class="col-md-1 col-xs-2">
                                    <label for="upazila">Type</label>
                                </div>
                                <div class="col-md-2 col-xs-4">
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="training_type_id" id="training_type_id" >
                                        <option value="">- Select All -</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <span id="unitDiv">
                                    <div class="col-md-1 col-xs-2">
                                        <label for="unit">Unit</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <!--                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="unit" id="unit" >
                                                                                <option value="">- select Unit -</option>
                                                                            </select>-->
                                    </div>
                                </span>
                                <span id="villDiv">
                                    <div class="col-md-1 col-xs-2">
                                        <label for="village">Village</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <!--                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="village" id="village" >
                                                                                <option value="">- select Village -</option>
                                                                            </select>-->
                                    </div>
                                </span>
                            </div>
                        </div>
                        <!--                        <div class="row">
                                                    <div class="col-md-1 col-xs-2">
                                                        <label for="reportType">Level</label>
                                                    </div>
                                                    <div class="col-md-2 col-xs-4">
                                                        <label><input type="radio" class="aggregate" id="aggregate" name="reportType" value="aggregate"> <span class="type-inactive  warp">Aggregate</span></label>
                                                    </div>
                                                    <div class="col-md-2 col-xs-4 individualBlock">
                                                        <label><input type="radio" class="individual" id="individual" name="reportType" value="individual" disabled="true"> <span class="type-inactive warp">Individual</span></label>
                                                    </div>
                                                </div>-->

                        <!--                        <div class="row" id="viewTypeBlock">
                                                    <div class="col-md-1 col-xs-12">
                                                        <label for="viewType">Type</label>
                                                    </div>
                                                                                <div class="col-md-2 col-xs-6">
                                                                                    <label><input type="radio" id="atPoint" name="viewType" value="atPoint"> <span class="view-inactive warp">Progress on a date</span></label>
                                                                                </div>
                                                    <div class="col-md-2 col-xs-6">
                                                        <label><input type="radio" id="monthly" name="viewType" value="monthly"> <span class="view-inactive warp">Monthly progress</span></label>
                                                    </div>
                                                    <div class="col-md-2 col-xs-6">
                                                        <label><input type="radio" id="yearly" name="viewType" value="yearly"> <span class="view-inactive warp">Yearly progress</span></label>
                                                    </div>
                                                    <div class="col-md-4 col-xs-6">
                                                        <label><input type="radio" id="periodical" name="viewType" value="periodical"> <span class="view-inactive warp">Periodic performance</span></label>
                                                    </div>
                                                </div>-->

                        <div class="row" id="dateBlock">
                            <div class="col-md-1 col-xs-2">
                                <label for="one" id="">Date</label>
                            </div>
                            <span id="_atPoint">

                                <div class="col-md-1 col-xs-1">
                                    <label for="one" id="">From</label>
                                </div>
                                <div class="col-md-2 col-xs-3">
                                    <input class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="training_start_date" id="training_start_date" />
                                </div>
                                <div class="col-md-1 col-xs-1">
                                    <label for="one" id="">To</label>
                                </div>
                                <div class="col-md-2 col-xs-3">
                                    <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="training_end_date" id="training_end_date" />
                                </div>
                            </span>

                            <!--                            <span id="_periodical">
                                                            <div class="col-md-1 col-xs-1">
                                                                <label for="one" id="">From</label>
                                                            </div>
                                                            <div class="col-md-2 col-xs-3">
                                                                <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="periodicalStartDate" id="periodicalStartDate" />
                                                            </div>
                                                            <div class="col-md-1 col-xs-1">
                                                                <label for="one" id="">To</label>
                                                            </div>
                                                            <div class="col-md-2 col-xs-3">
                                                                <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="periodicalEndDate" id="periodicalEndDate" />
                                                            </div>
                                                        </span>-->

                            <!--                            <span id="_monthly">
                                                            <div class="col-md-1 col-xs-1">
                                                                <label for="one" id="">From</label>
                                                            </div>
                                                            <div class="col-md-2 col-xs-3">
                                                                <input type="text" class="form-control input-sm mtz-monthpicker-widgetcontainer monthPickerChoose" placeholder="mm/yyyy" name="startMonthYear" id="startMonthYear">
                                                            </div>
                                                            <div class="col-md-1 col-xs-1">
                                                                <label for="one" id="">To</label>
                                                            </div>
                                                            <div class="col-md-2 col-xs-3">
                                                                <input type="text" class="form-control input-sm mtz-monthpicker-widgetcontainer monthPickerChoose" placeholder="mm/yyyy" name="endMonthYear" id="endMonthYear">
                                                            </div>
                                                        </span>
                            
                                                        <span id="_yearly">
                                                            <div class="col-md-1 col-xs-1">
                                                                <label for="one" id="">From</label>
                                                            </div>
                                                            <div class="col-md-2 col-xs-3">
                                                                <select class="form-control input-sm" name="startYear" id="startYear">
                                                                    <option value="">- select Year -</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-md-1 col-xs-1">
                                                                <label for="one" id="">To</label>
                                                            </div>
                                                            <div class="col-md-2 col-xs-3">
                                                                <select class="form-control input-sm" name="endYear" id="endYear">
                                                                    <option value="">- select Year -</option>
                                                                </select>
                                                            </div>
                                                        </span>-->
                        </div>

                        <div class="row">
                            <span class="viewBtnBlock">
                                <div class="col-md-1 col-xs-2 btn-label col-md-offset-4 col-xs-offset-2">
                                    <label for="one" id=""></label>
                                </div>
                                <div class="col-md-2 col-xs-4">
                                    <button type="submit" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm bold" autocomplete="off">
                                        <i class="fa fa-bar-chart" aria-hidden="true"></i>&nbsp; Show Data
                                    </button>
                                </div>
                            </span>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="box box-primary full-screen" id="tableView">

        <div class="box-header with-border" style="padding: 0px;">
            <p class="box-title bold" style="font-size: 15px;padding: 2px;padding-left: 5px;"></p>
            <div class="box-tools pull-right" style="margin-top: -10px;">
                <!--<button type="button" class="btn btn-flat btn-default btn-xs bold" id="exportPrint"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print - PDF</button>-->
                <!--<a href="#" id="exportCSV" role="button" class="btn btn-flat btn-default btn-xs bold" style="width:80px;"><i class="fa fa-file-excel-o" aria-hidden="true"></i>&nbsp;Excel</a>-->
                <!--                <a href="#" id="exportText" role="button" class="btn btn-flat btn-default btn-xs bold" style="width:80px;"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Text</a>-->
                <!--<button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>-->
            </div>
        </div>
        <!--<div id="test">hhh</div>-->
        <div class="box-body">
            <div class="row">
                <div class="col-md-12 table-responsive">
                    <!--<h2 class="viewTitle"><span class="label label-default">Module Launching Report</span></h2>-->
                </div>
                <div class="col-md-12" id="table-col">
                    <div class="table-responsive fixed" >
                        <table id="data-table" class="table table-bordered table-hover">
                            <thead id="tableHeader" class="data-table">
                            <th>Upazila</th>
                            <th>Module</th>

                            <th>Start date</th>
                            <th>End date</th>
                            <th>Participant</th>
                            <th>Total batch</th>
                            <th>Completeness</th>
                            </thead>
                            <!--                            <tbody id="tableBody">
                                                        </tbody>-->
                            <!--<tfoot id="tableFooter">
                            </tfoot>-->
                            <tfoot>
                                <tr>
                                    <th colspan="4">Total</th>
                                    <th id="total_participant"></th>
                                    <th id="total_batch"></th>
                                    <th></th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

            </div>
        </div> 
        <!--For Print -->
        <!--        <div class="box-body"  id="printTable">
                    <div id="dvData" align="center">
                        <table class="table table-bordered table-striped table-hover">
                            <thead id="tableHeaderP" style="text-align: left">
                            </thead>
                            <tbody id="tableBodyP">
                            </tbody>
                            <tfoot id="tableFooterP">
                            </tfoot>
                        </table>
                    </div>
                </div>  -->
    </div>

</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script src="resources/jquery.forms/jquery.form.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/plug-ins/1.11.3/api/sum().js" type="text/javascript"></script>
