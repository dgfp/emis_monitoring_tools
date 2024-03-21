<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/ProviderActivityMonitoringDropdowns.js"></script>
<link href="resources/css/newStyle.css" rel="stylesheet" type="text/css"/>
<style>
    #name{
        width: 100px;
    }
    #tableView{
        display: none;
    }
    #area{
        display: none; 
        padding-bottom: 22px;
    }
    #printTable{
        display: none;
    }
</style>
<style media="print" type="text/css">
    .box, .carTable{
        border: 0!important;
    }
    #areaPanel, #back-to-top, .box-header, .main-footer, #viewStatus{
        display: none !important;
    }
    .providerName{
        color: #000!important;
    }

    table, th, td {
        padding: 3px;
        padding-left: 5px;
        font-size: 14px;
    }
</style>
<script>
    var areaText = "";
    $(document).ready(function () {
        $(".full-screen").after($.app.getWatermark());

        //======Print & PDF Data
        $('#printTableBtn').click(function () {
            var contents = $(".table-responsive").html();
            var frame1 = $('<iframe />');
            frame1[0].name = "frame1";
            frame1.css({"position": "absolute", "top": "-1000000px"});
            $("body").append(frame1);
            var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
            frameDoc.document.open();
            frameDoc.document.write('<html><head><title>eMIS Initiative</title>');

            frameDoc.document.write('</head><body>');
            frameDoc.document.write('<style>table, th, td{border:1px solid black; border-collapse: collapse;padding:5px;}th{vertical-align: text-right} td{text-align:left;}.providerName{text-align:left!important}</style>');
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center!important;"><center>Provider Activity Monitoring</center></h3>');
            frameDoc.document.write('<h5 style="color:black;text-align:center!important;"><center>' + areaText + '</center></h5>');
            frameDoc.document.write(contents);
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 500);
        });

        function convertVertical() {
            var x = $("#data-table").find("th,td");
            var i = $("#data-table").find("tr").length;
            var j = x.length / i;
            var newT = $("<table id='display-table' class='table table-bordered table-striped table-hover'>").appendTo("tbody");
            for (j1 = 0; j1 < j; j1++) {
                var temp = $("<tr>").appendTo(newT);
                for (var i1 = 0; i1 < i; i1++) {
                    temp.append($(x[i1 * j + j1]).clone());
                }

            }
            $("#data-table").html($("#display-table").html());
        }
        var tableHtml = $('.data').html();


        $('#showdataButton').click(function () {
            $('.data').html("");
            $('.data').html(tableHtml);

            $("#area").css("display", "none");
            $("#tableView").fadeOut("slow");
            var defaultStartDate = "01/01/2017"; //for default date
            var regExp = /(\d{1,2})\/(\d{1,2})\/(\d{2,4})/; //for date compare

            var tableHeader = $('#tableHeader');
            var tableBody = $('#tableBody');
            var tableFooter = $('#tableFooter');
            var tableHeaderP = $('#tableHeaderP');
            var tableBodyP = $('#tableBodyP');
            var tableFooterP = $('#tableFooterP');

            tableHeader.empty();
            tableHeader.html("");
            tableBody.empty();
            tableBody.html("");
            tableFooter.empty();
            tableHeaderP.empty();
            tableBodyP.empty();
            tableFooterP.empty();


            var startDate = $("#startDate").val() === "" ? defaultStartDate : $("#startDate").val();
            var endDate = $("#endDate").val();

            //Check end Date
            var date = endDate.substring(0, 2);
            var month = endDate.substring(3, 5);
            var year = endDate.substring(6, 10);
            var myDate = new Date(year, month - 1, date);
            var today = new Date();
            //end 
            var date = "";  //endDate.toISOString().slice(0,10);

            if ($("select#district").val() === "") {
                toastr["error"]("<h4><b>Please select district</b></h4>");
                return;
            } else if ($("select#upazila").val() === "") {
                toastr["error"]("<h4><b>Please select upazila</b></h4>");
                return;

            } else if ($("select#providerType").val() === "") {
                toastr["error"]("<h4><b>Please select provider type</b></h4>");
                return;

            } 
//            else if (parseInt(startDate.replace(regExp, "$3$2$1")) > parseInt(endDate.replace(regExp, "$3$2$1"))) {
//                toastr["error"]("<h4><b>Start date should be smaller than end date</b></h4>");
//                return;
//            } 
            else if (myDate > today) {
                toastr["error"]("<h4><b>End date should not greater than todays date</b></h4>");
                return;
            }

            //Individual
            if ($("select#providerType").val() === '3') {
                endDate = endDate.split("/");
                endDate = endDate[2] + "-" + endDate[1] + "-" + endDate[0];

                startDate = startDate.split("/");
                startDate = startDate[2] + "-" + startDate[1] + "-" + startDate[0];
                $.ajax({
                    url: "ProviderActivityMonitoring?action=FWA",
                    data: {
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val(),
                        providerCode: $("select#provider").val(),
                        startDate: startDate,
                        endDate: endDate
                    },
                    type: 'POST',
                    success: function (result) {
                        var json = null;
                        json = JSON.parse(result);

                        if (json.length === 0) {
                            toastr["error"]("<h4><b>No data found</b></h4>");
                            return;
                        }

                        $.app.removeWatermark();
                        $("#area").css("display", "block");
                        //show table view after data load
                        $("#tableView").fadeIn("slow");
                        //Show locations title when area panel is minimize or in export data
                        var district = " District: <b style='color:#3C8DBC'>" + $("#district option:selected").text() + "</b>";
                        var upazila = "Upazila: <b style='color:#3C8DBC'>" + $("#upazila option:selected").text() + "</b>";
                        var union = "Union: <b style='color:#3C8DBC'>" + $("#union option:selected").text() + "</b>";

                        var providerType = "Type: <b style='color:#3C8DBC'>" + $("#providerType option:selected").text() + "</b>";
                        var provider = "Provider: <b style='color:#3C8DBC'>" + $("#provider option:selected").text() + "</b>";

                        var sDate = "From: <b style='color:#3C8DBC'>" + startDate + "</b>";
                        var eDate = "To: <b style='color:#3C8DBC'>" + endDate + "</b>";
                        areaText = district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + union + '&nbsp;&nbsp;' + providerType + '&nbsp;&nbsp;' + provider + '&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate;
                        $("#area").html(areaText);
                        $('#collapseArea').click(); //minimize area panel
                        $("#area").css("display", "block");

                        var parsedHeader = '<tr class="label-primary" style="text-align: right!important;">'
//                                + '<th class="label-primary right">SL No.</th>'
//                                + '<th class="label-primary right">Provider ID</th>'
                                + '<th class="providerName label-primary right">Provider</th>'
//                                    +'<th>Household</th>'
//                                    +'<th>Ses</th>'
//                                    +'<th>Visits</th>'
//                                    +'<th>Member</th>'
//                                    +'<th>Clientmap</th>'                           
                                + '<th class="right">Eligible Couple (ELCO) registrtion</th>'
                                + '<th class="right">Elco visit</th>'
//                                    +'<th>Immunization History</th>'
                                + '<th class="right">Pregnant Women registration</th>'
                                + '<th class="right">Refer of pregnant woman at risk</th>'
                                + '<th class="right">ANC</th>'
//                                    +'<th class="right">Preg Danger Sign</th>'
                                + '<th class="right">Delivery</th>'
                                + '<th class="right">Birth</th>'
                                + '<th class="right">PNC (Child)</th>'
                                + '<th class="right">PNC (Mother)</th>'
                                + '<th class="right">Death</th>'
                                + '<th class="right">Injectable provided </th>'
                                + '<th class="right">Adolesent registration</th>'
                                + '<th class="right">Adolescent care provided</th>'
                                + '<th class="right">Under 5 child registration</th>'
                                + '<th class="right">Under 5 Child care</th>'
//                                    +'<th class="right">Under 5 Child Problem</th>'
                                + '<th class="right">Nutrition (Mother) service</th>'
                                + '<th class="right">Nutrition (Child) service</th>'
                                + '<th class="right">HID Card distributed</th>'
//                                    +'<th>Migration Out</th>'
//                                    +'<th>Vaccine Cause</th>'
//                                    +'<th>Epi Master</th>'
//                                    +'<th>Epi Master Woman</th>'
//                                    +'<th>Epi Scheduler</th>'
//                                    +'<th>Session Master</th>'
//                                    +'<th>Session Master Woman</th>'
//                                    +'<th>Work Plan Detail</th>'
//                                    +'<th>Work Plan Master</th>'
//                                    +'<th>Brand Method</th>'
//                                    +'<th>OCP LIST</th>'
//                                    +'<th>Attendant Designation</th>'
//                                    +'<th>Elco Event</th>'
//                                    +'<th>Immunization</th>'
//                                    +'<th>Ado Symtom</th>'
//                                    +'<th>Treatment</th>'
//                                    +'<th>Classfication</th>'
//                                    +'<th>Current Stock</th>'
//                                    +'<th>FWA Unit</th>'
//                                    +'<th>HA Block</th>'
//                                    +'<th>Provider DB</th>'
//                                    +'<th>Provider Type</th>'
//                                    +'<th>Item</th>'
//                                    +'<th>Symtom</th>'
//                                   +'<th>Death Reason</th>'
//                                   +'<th>FPA Item</th>'
//                                   +'<th>Month</th>'
                                + '</tr>';

                        tableHeader.append(parsedHeader);
                        //tableHeaderP.append(parsedHeader);
//                        var table = $('#data-table').DataTable();
//                        table.destroy();
                        tableBody.empty();

                        for (var i = 0; i < json.length; i++) {

                            var parsedData = '<tr>'
//                                    + '<td class="bold">' + json[i].providerid + '</td>'
                                    + '<td class="providerName label-primary bold">' + json[i].providerid + ' - ' + json[i].provider_name + '</td>'
//                                + '<td>' +json[i].household+ '</td>'
//                                + '<td>' +json[i].ses+ '</td>'
//                                + '<td>' +json[i].visits+ '</td>'
//                                + '<td>' +json[i].member+ '</td>'
//                                + '<td>' +json[i].clientmap+ '</td>'
                                    + '<td>' + json[i].elco + '</td>'
                                    + '<td>' + json[i].elcovisit + '</td>'
//                                + '<td>' +json[i].immunizationhistory+ '</td>'
                                    + '<td>' + json[i].pregwomen + '</td>'
                                    + '<td>' + json[i].pregrefer + '</td>'
                                    + '<td>' + json[i].ancservice + '</td>'
//                                + '<td>' +json[i].pregdangersign+ '</td>'
                                    + '<td>' + json[i].delivery + '</td>'
                                    + '<td>' + json[i].newborn + '</td>'
                                    + '<td>' + json[i].pncservicechild + '</td>'
                                    + '<td>' + json[i].pncservicemother + '</td>'
                                    + '<td>' + json[i].death + '</td>'
                                    + '<td>' + json[i].womaninjectable + '</td>'
                                    + '<td>' + json[i].adolescent + '</td>'
                                    + '<td>' + json[i].adolescentproblem + '</td>'
                                    + '<td>' + json[i].under5child + '</td>'
                                    + '<td>' + json[i].under5childadvice + '</td>'
//                                + '<td>' +json[i].under5childproblem+ '</td>'
                                    + '<td>' + json[i].mothernutrition + '</td>'
                                    + '<td>' + json[i].childnutrition + '</td>'
                                    + '<td>-</td></tr>';

//                                + '<td>' +json[i].migrationout+ '</td>'
//                                + '<td>' +json[i].vaccinecause+ '</td>'
//                                + '<td>' +json[i].epimaster+ '</td>'
//                                + '<td>' +json[i].epimasterwoman+ '</td>'
//                                + '<td>' +json[i].epischedulerupdate+ '</td>'
//                                + '<td>' +json[i].sessionmasterupdate+ '</td>'
//                                + '<td>' +json[i].sessionmasterwomanupdate+ '</td>'
//                                + '<td>' +json[i].workplandetail+ '</td>'
//                                + '<td>' +json[i].workplanmaster+ '</td>';
                            /*  + '<td>' +json[i].brandmethod+ '</td>';
                             + '<td>' +json[i].ocplist+ '</td>'
                             + '<td>' +json[i].attendantdesignation+ '</td>'
                             + '<td>' +json[i].elcoevent+ '</td>'
                             + '<td>' +json[i].immunization+ '</td>'
                             + '<td>' +json[i].adosymtom+ '</td>'
                             + '<td>' +json[i].treatment+ '</td>'
                             + '<td>' +json[i].classfication+ '</td>'
                             + '<td>' +json[i].currentstock+ '</td>'
                             + '<td>' +json[i].fwaunit+ '</td>'
                             + '<td>' +json[i].hablock+ '</td>'
                             + '<td>' +json[i].providerdb+ '</td>'
                             + '<td>' +json[i].providertype+ '</td>'
                             + '<td>' +json[i].item+ '</td>'
                             + '<td>' +json[i].symtom+ '</td>'
                             + '<td>' +json[i].deathreason+ '</td>'
                             + '<td>' +json[i].fpaitem+ '</td>'
                             + '<td>' +json[i].month+ '</td>';*/
                            tableBody.append(parsedData);
                            //tableBodyP.append(parsedData);
                        }
                        //Convert vertical table to horizontal
                        convertVertical();
                        //$(".data-table").parent("#data-table").hide();

//                        var table = $('#data-table').DataTable({
//                            fixedHeader: {
//                                header: true
//                            }
//                        });

                        //load();
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                    }
                }); //End Ajax Request 


            } else if ($("select#providerType").val() === '2') {
                endDate = endDate.split("/");
                endDate = endDate[2] + "-" + endDate[1] + "-" + endDate[0];

                startDate = startDate.split("/");
                startDate = startDate[2] + "-" + startDate[1] + "-" + startDate[0];

                $.ajax({
                    url: "ProviderActivityMonitoring?action=HA",
                    data: {
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val(),
                        providerCode: $("select#provider").val(),
                        startDate: startDate,
                        endDate: endDate
                    },
                    type: 'POST',
                    success: function (result) {
                        var json = null;
                        json = JSON.parse(result);

                        if (json.length === 0) {
                            toastr["error"]("<h4><b>No data found</b></h4>");
                            return;
                        }
                        $.app.removeWatermark();
                        $("#area").css("display", "block");
                        //show table view after data load
                        $("#tableView").fadeIn("slow");
                        //Show locations title when area panel is minimize or in export data
                        var district = " District: <b style='color:#3C8DBC'>" + $("#district option:selected").text() + "</b>";
                        var upazila = "Upazila: <b style='color:#3C8DBC'>" + $("#upazila option:selected").text() + "</b>";
                        var union = "Union: <b style='color:#3C8DBC'>" + $("#union option:selected").text() + "</b>";

                        var providerType = "Unit: <b style='color:#3C8DBC'>" + $("#providerType option:selected").text() + "</b>";
                        var provider = "Village: <b style='color:#3C8DBC'>" + $("#provider option:selected").text() + "</b>";

                        var sDate = "From: <b style='color:#3C8DBC'>" + startDate + "</b>";
                        var eDate = "To: <b style='color:#3C8DBC'>" + endDate + "</b>";
                        areaText = district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + union + '&nbsp;&nbsp;' + providerType + '&nbsp;&nbsp;' + provider + '&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate;
                        $("#area").html(areaText);
                        $('#collapseArea').click(); //minimize area panel
                        $("#area").css("display", "block");


                        var parsedHeader = '<tr class="label-primary">'
                                + '<th>SL No.</th>'
                                + '<th>Provider ID</th>'
                                + '<th id="name" class="providerName">Provider Name &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>'
                                + '<th>Immunization History</th>'
                                + '<th>Pregnant Women registration</th>'
                                + '<th>Refer of Pregnant woman <br/>at risk</th>'
                                + '<th>ANC</th>'
                                + '<th>Delivery</th>'
                                + '<th>Birth</th>'
                                + '<th>PNC (Child)</th>'
                                + '<th>PNC (Mother)</th>'
                                + '<th>Death</th>'
                                + '<th>Under 5 Child registration</th>'
                                + '<th>Under 5 Child care</th>'
                                + '<th>EPI (Child) registration</th>'
                                + '<th>EPI (Women) registration</th>'
                                + '<th>EPI Session conducted</th>'
                                + '<th>HID Card distributed</th>'
                                + '</tr>';

                        tableHeader.append(parsedHeader);
                        //tableHeaderP.append(parsedHeader);

                        var table = $('#data-table').DataTable();
                        table.destroy();
                        tableBody.empty();

                        for (var i = 0; i < json.length; i++) {
                            var parsedData = '<tr><td>' + (i + 1) + '</td>'
                                    + '<td>' + json[i].providerid + '</td>'
                                    + '<td class="providerName">' + json[i].provider_name + '</td>'
                                    + '<td>' + json[i].immunizationhistory + '</td>'
                                    + '<td>' + json[i].pregwomen + '</td>'
                                    + '<td>' + json[i].pregrefer + '</td>'
                                    + '<td>' + json[i].ancservice + '</td>'
                                    + '<td>' + json[i].delivery + '</td>'
                                    + '<td>' + json[i].newborn + '</td>'
                                    + '<td>' + json[i].pncservicechild + '</td>'
                                    + '<td>' + json[i].pncservicemother + '</td>'
                                    + '<td>' + json[i].death + '</td>'
                                    + '<td>' + json[i].under5child + '</td>'
                                    + '<td>' + json[i].under5childadvice + '</td>'
                                    + '<td>-</td>'
                                    + '<td>-</td>'
                                    + '<td>-</td>'
                                    + '<td>-</td>'
                                    + '</tr>';
                            tableBody.append(parsedData);
                            //tableBodyP.append(parsedData);
                        }
                        var table = $('#data-table').DataTable({
                            fixedHeader: {
                                header: true
                            }
                        });

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                    }
                }); //End Ajax Request 
            }//end if else
        });//end button click
    });
    function  loads() {
        var options = {
            width: 700,
            height: 300,
            pinnedRows: 1,
            pinnedCols: 1,
            container: "#scrollableTable",
            removeOriginal: true
        };
        $("#ExampleTable").tablescroller(options);
    }

</script>
<!-- Content Header (Page header) -->
<section class="content-header"> 
    <h1>Provider activity monitoring</h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <div class="row">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button id="collapseArea" type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <label for="district">Division</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="division" id="division"> </select>
                        </div>
                        <div class="col-md-1 col-xs-2">
                            <label for="district">District</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="district" id="district">
                                <option value="">- Select District -</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-xs-2">
                            <label for="upazila">Upazila</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="upazila" id="upazila" >
                                <option value="">- Select Upazila -</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-xs-2">
                            <label for="union">Union</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="union" id="union" >
                                <option value="">- Select Unon -</option>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <label for="unit">Type</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="providerType" id="providerType" >
                                <option value="">- select Provider Type -</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-xs-2">
                            <label for="unit">Provider</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="provider" id="provider" >
                                <option value="">- select Provider -</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-xs-2">
                            <label for="one" id="">Start Date</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="startDate" id="startDate" />
                        </div>
                        <div class="col-md-1 col-xs-2">
                            <label for="one" id="">End Date</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="endDate" id="endDate" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-2 col-xs-4 col-md-offset-10 col-xs-offset-8">
                            <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off">
                                <i class="fa fa-bar-chart" aria-hidden="true"></i> View Data
                            </button>
                        </div>
                    </div>
                </div><h4><center id="area"></center></h4>
            </div>
        </div>
    </div>

    <!--Elco Data Table-->
    <div class="box box-primary full-screen" id="tableView">
        <div class="box-header with-border" style="margin-top: -8px;margin-bottom: -5px!important;">
            <h3 class="box-title"><b><span id="prsTypeTitleForTable"></span></b></h3>
            <div class="box-tools pull-right" style="margin-top: 0px;">
                <button class="buttons-print btn btn-flat btn-default btn-xs" tabindex="0" aria-controls="tablet_stock_status" type="button" style="font-weight: bold;"><span> <i class="fa fa-print" aria-hidden="true"></i> Print / PDF</span></button>
                <button onclick="window.print();" type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body data">
            <div class="table-responsive" >
                <table id="data-table" cellspacing="0" class="table table-fixed table-bordered table-striped table-hover display">
                    <thead id="tableHeader" class="data-table">
                    </thead>
                    <tbody id="tableBody">
                    </tbody>
                    <tfoot id="tableFooter">
                    </tfoot>
                </table>
            </div>
        </div>

        <!--For print table-->
        <!--        <div class="box-body" id="printTable">
                    <div class="dvData">
                        <table class="table table-bordered table-striped table-hover" align="center">
                            <thead id="tableHeaderP">
                            </thead>
                            <tbody id="tableBodyP">
                            </tbody>
                            <tfoot id="tableFooterP">
                            </tfoot>
                        </table>
                    </div>
                </div>-->

    </div>
</section>
<script>
    $(document).ready(function () {
        //Area collapse button toggle FOR show location
        $("#collapseArea").click(function () {
            $("#area").toggle();
        });
    });
</script>

<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>