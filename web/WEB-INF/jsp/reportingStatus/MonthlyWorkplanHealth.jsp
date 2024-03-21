<%-- 
    Document   : MonthlyWorkplanHealth
    Created on : Jul 9, 2018, 12:06:26 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_advance_workplan.js"></script>
<script src="resources/js/monthYearLoader.js" type="text/javascript"></script>
<style>
    .center{
        text-align: center;
    }
    #tableView{
        display: none;       
    }
    .top{
        vertical-align: top;
    }
    #printTable{
        display: none;
    }
    .callout.callout-success, .callout.callout-danger, .callout.callout-warning {
        border:none!important;
    }
    .callout {
        border-radius: 50px!important;
        padding: 1px 15px 1px 15px!important;
    }
    [class*="col"] { margin-bottom: 10px; }
</style>
<script>
    function getAreaText() {
        var areaText = "";
        var division = " বিভাগ: <b style='color:#3C8DBC'>" + $("#division option:selected").text() + "</b>";
        var district = " জেলা: <b style='color:#3C8DBC'>" + $("#district option:selected").text() + "</b>";
        var upazila = " উপজেলা: <b style='color:#3C8DBC'>" + $("#upazila option:selected").text() + "</b>";
        var union = " ইউনিয়ন: <b style='color:#3C8DBC'>" + $("#union option:selected").text() + "</b>";
        var providerType = " প্রোভাইডার টাইপ: Type: <b style='color:#3C8DBC'>" + $("#providerType option:selected").text() + "</b>";
        var providerId = " প্রোভাইডার: <b style='color:#3C8DBC'>" + $("#provider option:selected").text() + "</b>";
        var month = " মাস: <b style='color:#3C8DBC'>" + $("#month option:selected").text() + "</b>";
        var year = " বছর: <b style='color:#3C8DBC'>" + convertE2B($("#year").val()) + "</b>";

        areaText = division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + union + '&nbsp;&nbsp;<br>' + providerType + '&nbsp;&nbsp;' + providerId + '&nbsp;&nbsp;' + month + '&nbsp;&nbsp;' + year;

        return  areaText;
    }
    $(document).ready(function () {
        $("#areaDropDownPanel").slideDown("slow"); //Show area dropdowns panel by jquery slideDown

        var btn = null;
        $.data = $.app.date();
//        $.app.select.$year('select#year', range($.data.year, 2014, -1)).val($.data.year);
//        $.app.select.$month('select#month').val($.data.month);

        var tableBody = $('#tableBody');
        var tableBodyP = $('#tableBodyP');

        //Load village from Union---------------------------------------------------
        $('select#union').change(function (event) {
            var selectTag = $('#providerType');
            selectTag.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট প্রোভাইডার টাইপ -').appendTo(selectTag);

            if ($('#userDesignation').val() != "HI")
                $('<option>').val("16").text('UHFPO [16]').appendTo(selectTag);

            $('<option>').val("12").text('HI [12]').appendTo(selectTag);
            $('<option>').val("11").text('AHI [11]').appendTo(selectTag);
            $('<option>').val("2").text('HA [2]').appendTo(selectTag);

        });

        $('#printTableBtn').click(function () {
            //alert("Hey");
            //$('#printTable').printElement();
            var contents = $("#printTable").html();
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
            frameDoc.document.write('<style>table, th, td{border:1px solid black; border-collapse: collapse;padding:10px;}th{vertical-align: text-center} td{text-align:left;}</style>');
            //frameDoc.document.write('<link href="style.css" rel="stylesheet" type="text/css" />');
            //Append the DIV contents.
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center!important;"><center>মাসিক অগ্রিম কর্মসংস্থান অনুমোদন</center></h3>');
            frameDoc.document.write('<p style="color:#000!important;text-align:center!important;"><center>' + getAreaText() + '</center></p>');
            frameDoc.document.write(contents);
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 500);
        });

        $("#exportText").click(function (event) {
            var outputFile = "Monthly advance workplan approval";
            outputFile = outputFile.replace('.txt', '') + '.txt';
            exportTableToText.apply(this, [$('#dvData > table'), outputFile]); //function call from TemplateHeader
        });

        //here


        $('#showdataButton').on('click', function (event) {
            $("#tableView").fadeOut("fast");
            $("#viewStatus").html("");

//            var divisionId = $("select#division").val();
//            var districtId = $("select#district").val();
//            var upazilaId = $("select#upazila").val();
//            var unionId = $("select#union").val();
//            var month = $("select#month").val();
//            var year = $("select#year").val();
//            var providerType = $("select#providerType").val();
//            var providerId = $("select#provider").val();

            if ($("select#division").val() == "" || $("select#division").val() == 0) {
                toastr["error"]("<h4><b>Please select division</b></h4>");
                return;
            } else if ($("select#district").val() == "" || $("select#district").val() == 0) {
                toastr["error"]("<h4><b>Please select district</b></h4>");
                return;
            } else if ($("select#upazila").val() == "" || $("select#upazila").val() == 0) {
                toastr["error"]("<h4><b>Please select upazila</b></h4>");
                return;
            } else if ($("select#union").val() == "" || $("select#union").val() == 0) {
                toastr["error"]("<h4><b>Please select union</b></h4>");
                return;
            } else if ($("select#providerType").val() == "" || $("select#providerType").val() == 0) {
                toastr["error"]("<h4><b>Please select provider type</b></h4>");
                return;
            } else if ($("select#provider").val() == "" || $("select#provider").val() == 0) {
                toastr["error"]("<h4><b>Please select provider</b></h4>");
                return;
            } else if ($("select#month").val() == "" || $("select#month").val() == 0) {
                toastr["error"]("<h4><b>Please select month</b></h4>");
                return;
            } else if ($("select#year").val() == "" || $("select#year").val() == 0) {
                toastr["error"]("<h4><b>Please select year</b></h4>");
                return;
            } else {
                //Clear previous table data
                tableBody.empty();
                tableBodyP.empty();

                Pace.track(function () {
                    $.ajax({
                        url: "SupervisionAndMonitoringController?action=getMonthlyWorkplan",
                        data: {
                            districtId: $("select#district").val(),
                            month: $("select#month").val(),
                            year: $("select#year").val(),
                            providerId: $("select#provider").val(),
                            providerType: $("select#providerType").val()
                        },
                        type: 'POST',
                        success: function (response) {

                            var table = $('#data-table').DataTable();
                            table.destroy();
                            tableBody.empty();

                            var json = $.parseJSON(response);
                            var data = $.parseJSON(json.data);


                            if (json.status == "success") {
                                if (data.length != 0) {
                                    $("#transparentTextForBlank").css("display", "none");
                                    $("#tableView").fadeIn("slow");

                                    for (var i = 0; i < data.length; i++) {
                                        var no = (i + 1);
                                        var parsedData = "<tr><td>" + convertE2B(convertDateFrontFormat(data[i].workplandate)) + "</td>"
                                                + "<td>" + getDayByDate(data[i].workplandate) + "</td>"
                                                + "<td>" + data[i].activity + "</td>";

                                        tableBody.append(parsedData);
                                        tableBodyP.append(parsedData);
                                    }
                                    console.log($.app.workplanStatus.pending, data[0].status);
                                    if (data[0].status == 1)
                                        $("#viewStatus").html($.app.workplanStatus.pending);
                                    else if (data[0].status == 2)
                                        $("#viewStatus").html($.app.workplanStatus.submitted);
                                    else if (data[0].status == 3)
                                        $("#viewStatus").html($.app.workplanStatus.notSubmitted);
                                    else
                                        $("#viewStatus").html("");

                                    var table = $('#data-table').DataTable({
                                        "searching": false,
                                        "lengthChange": false,
                                        "paging": false
                                    });
                                    table.draw();


                                } else {
                                    $("#transparentTextForBlank").css("display", "block");
                                    $.toast("Workplan not yet submitted", "warning")();
                                }
                            } else if (json.status == "error") {
                                $("#transparentTextForBlank").css("display", "block");
                                $.toast(json.message, json.status)();
                            }


                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    });//End Ajax
                }); //end pace



            }



        });

    });
</script>
<!-- Content Header (Page header) -->
<section class="content-header a-w">
    <h1>Advance workplan (Health)</h1>
</section>

<!-- Main content -->
<section class="content a-w-area">
    <!------------------------------Load Area----------------------------------->
    <div class="row" id="areaDropDownPanel">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <label for="division">বিভাগ</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="division" id="division"> 
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="district">জেলা</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="district" id="district"> 
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-xs-2">
                            <label for="upazila">উপজেলা</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="upazila" id="upazila">
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="union">ইউনিয়ন</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="union" id="union">
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <label for="union">টাইপ</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="providerType" id="providerType" required>
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-xs-2">
                            <label for="provider">প্রোভাইডার</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="provider" id="provider" required>
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>
                        <div class="col-md-1  col-xs-2">
                            <label for="year">বছর</label>
                        </div>
                        <div class="col-md-2  col-xs-4">
                            <select class="form-control input-sm" name="year" id="year"> </select>
                        </div>
                        <div class="col-md-1  col-xs-2">
                            <label for="month">মাস</label>
                        </div>
                        <div class="col-md-2  col-xs-4">
                            <select class="form-control input-sm" name="month" id="month">
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2 col-md-offset-10">        
                            <button type="button" id="showdataButton" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block" autocomplete="off" >
                                <b><i class="fa fa-table" aria-hidden="true"></i>&nbsp; ডাটা দেখান</b>
                            </button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div id="viewStatus">
    </div>

    <!--Transparent Text For Blank Space-->
    <section class="content-header" id="transparentTextForBlank" style="display: block;">
        <center class="emis_hologram">eMIS</center>
    </section>
    <!--Community Data Table-->
    <div class="box box-primary"  id="tableView">
        <div class="box-header with-border" style="margin-top: -8px;margin-bottom: -5px!important;">
            <h3 class="box-title"><b><span id="prsTypeTitleForTable"></span></b></h3>
            <div class="box-tools pull-right" style="margin-top: 0px;">
                <button id="printTableBtn" type="button" class="btn btn-flat btn-default btn-xs bold"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <button id="exportText" type="button" class="btn btn-flat btn-default btn-xs bold"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Text</button>
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
            </div>
        </div>

        <div class="box-body">
            <div class="col-md-8 col-md-offset-2">
                <div class="table-responsive fixed" >
                    <table class="table table-bordered table-striped table-hover" id="data-table">
                        <thead class="data-table">
                            <tr>
                                <th>তারিখ</th>
                                <th>বার</th>
                                <th>কর্মসূচি</th>
                            </tr>
                        </thead>
                        <tbody id="tableBody">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!--For Print -->
        <div class="box-body"  id="printTable">
            <div id="dvData">
                <table class="table table-bordered table-striped table-hover" align="center">
                    <thead id="tableHeaderP">
                        <tr>
                            <th>তারিখ</th>
                            <th>বার</th>
                            <th>কর্মসূচি</th>
                        </tr>
                    </thead>
                    <tbody id="tableBodyP">
                    </tbody>
                </table>
            </div>
        </div>              
    </div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>