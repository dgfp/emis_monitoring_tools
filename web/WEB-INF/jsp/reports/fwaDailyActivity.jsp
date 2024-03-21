<%-- 
    Document   : fwaDailyActivity
    Created on : Oct 26, 2017, 10:51:04 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla.js"></script>
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla.js"></script>
<link href="resources/css/style.css" rel="stylesheet" type="text/css"/>
<style>
    .ui-widget-header {
        background: #3C8DBC!important;
    }   
    .ui-corner-all, .ui-corner-bottom, .ui-corner-left, .ui-corner-bl {
        border-radius: 0px!important;
    }
    .mtz-monthpicker{
        cursor: pointer!important;
    }
    /*    .table-responsive {
            border: 1px solid #000!important;
            border-top-color: #fff!important;
            border-right-color: #fff!important;
            border-bottom-color: #fff!important;
            border-left-color: #fff!important;
        }*/
    /*    table.table-bordered{
            border:1px solid yellow;
        }
        table.table-bordered{
            border:1px solid #fff!important;
        }
        table.table-bordered > thead > tr > th{
            border:1px solid #fff!important;
        }
        table.table-bordered > tbody > tr > td{
            border:1px solid #fff!important;
            padding: 5px;
        }
        #page{
        margin-top: -55px;
        }
         table, th, td {
            padding: 3px;
         }*/

    @font-face {
        font-family: NikoshBAN;
        src: url('resources/fonts/NikoshBAN.ttf');
    }
    @font-face {
        font-family: SolaimanLipi;
        src: url('resources/fonts/SolaimanLipi.ttf');
    }
    .v_field{
        font-family: NikoshBAN;
        font-size: 18px;
    }
    #tableView{
        display: none;       
    }
    [class*="col"] { margin-bottom: 10px; }
</style>

<script>
    function getFWAUnit(value) {
        var unit = null;
        if (value == '01') {
            return "১";
        } else if (value == '02') {
            return "ক ১";
        } else if (value == '03') {
            return "খ ১";
        } else if (value == '04') {
            return "গ ১";
        } else if (value == '05') {
            unit = "২";
        } else if (value == '06') {
            return "ক ২";
        } else if (value == '07') {
            return "খ ২";
        } else if (value == '08') {
            return "গ ২";
        } else if (value == '09') {
            unit = "৩";
        } else if (value == '10') {
            return "ক ৩";
        } else if (value == '11') {
            return "খ ৩";
        } else if (value == '12') {
            return "গ ৩";
        } else {
            return "-";
        }
    }

    function getAreaText() {
        var areaText = null;
        var division = " বিভাগ: <b style='color:#3C8DBC'>" + $("#division option:selected").text().split("[")[0] + "</b>";
        var district = " জেলা: <b style='color:#3C8DBC'>" + $("#district option:selected").text().split("[")[0] + "</b>";
        var upazila = "উপজেলা: <b style='color:#3C8DBC'>" + $("#upazila option:selected").text().split("[")[0] + "</b>";
        var union = "ইউনিয়ন: <b style='color:#3C8DBC'>" + $("#union option:selected").text().split("[")[0] + "</b>";
        var month = "মাস: <b style='color:#3C8DBC'>" + $.app.monthBangla[parseInt($('#monthYear').val().split('/')[0])] + "/  " + convertE2B($('#monthYear').val().split('/')[1]) + "</b>";
        //var eDate="বছর: <b style='color:#3C8DBC'>"+ convertE2B($("#endDate").val())+"</b>";
        areaText = division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + union + '&nbsp;&nbsp;' + month;
        return  areaText;
    }
    $(document).ready(function () {
        var defaultStartDate = "01/01/2014"; //for default date


        //======Elco data export system===============================================================================================
//======Print & PDF Data
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
            frameDoc.document.write('<style>table, th, td{font-family: SolaimanLipi;border:1px solid black; border-collapse: collapse;padding:10px; text-align:center;vertical-align: text-center;}th{vertical-align: text-center} td{text-align:left;font-family: SolaimanLipi;}</style>');
            //Append the DIV contents.
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center!important;"><center> পরিবার পরিকল্পনার তদারকি ছক </center></h3>');
            frameDoc.document.write('<h5 style="color:black!important;;text-align:center!important;"><center>' + getAreaText() + '</center></h5>');
            frameDoc.document.write(contents);
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 500);
        });


//======Make CSV export using these function=====================================================
        /*function exportTableToCSV($table, filename) {
         var $headers = $table.find('tr:has(th)')
         ,$rows = $table.find('tr:has(td)')
         
         // Temporary delimiter characters unlikely to be typed by keyboard
         // This is to avoid accidentally splitting the actual contents
         ,tmpColDelim = String.fromCharCode(11) // vertical tab character
         ,tmpRowDelim = String.fromCharCode(0) // null character
         
         // actual delimiter characters for CSV format
         ,colDelim = '","'
         ,rowDelim = '"\r\n"';
         
         // Grab text from table into CSV formatted string
         var csv = '"';
         csv += formatRows($headers.map(grabRow));
         csv += rowDelim;
         csv += formatRows($rows.map(grabRow)) + '"';
         
         // Data URI
         var csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv);
         
         // For IE (tested 10+)
         if (window.navigator.msSaveOrOpenBlob) {
         var blob = new Blob([decodeURIComponent(encodeURI(csv))], {
         type: "text/csv;charset=utf-8;"
         });
         navigator.msSaveBlob(blob, filename);
         } else {
         $(this)
         .attr({
         'download': filename
         ,'href': csvData
         //,'target' : '_blank' //if you want it to open in a new window
         });
         }
         
         // Format the output so it has the appropriate delimiters
         function formatRows(rows){
         return rows.get().join(tmpRowDelim)
         .split(tmpRowDelim).join(rowDelim)
         .split(tmpColDelim).join(colDelim);
         }
         // Grab and format a row from the table
         function grabRow(i,row){
         var $row = $(row);
         //for some reason $cols = $row.find('td') || $row.find('th') won't work...
         var $cols = $row.find('td'); 
         if(!$cols.length) $cols = $row.find('th');  
         
         return $cols.map(grabCol)
         .get().join(tmpColDelim);
         }
         // Grab and format a column from the table 
         function grabCol(j,col){
         var $col = $(col),
         $text = $col.text();
         return $text.replace('"', '""'); // escape double quotes
         }
         }*/
//======Export CSV using these function==========================================================
        $("#exportText").click(function (event) {
            var outputFile = "eMIS_FWA_Daily_Activity";
            outputFile = outputFile.replace('.txt', '') + '.txt';
            exportTableToText.apply(this, [$('#dvData > table'), outputFile]); //function call from TemplateHeader
        });
//================================================END===================================== 

        $('#showdataButton').click(function () {
            $("#tableView").fadeOut("slow");
            var tableBody = $('#tableBody');

            //Report Validation---------------------------------------------------------------------------------------------------------------
            if ($("select#division").val() === "") {
                toastr["error"]("<h4><b>বিভাগ সিলেক্ট করুন </b></h4>");

            } else if ($("select#district").val() === "") {
                toastr["error"]("<h4><b>জেলা সিলেক্ট করুন </b></h4>");

            } else if ($("select#upazila").val() === "") {
                toastr["error"]("<h4><b>উপজেলা সিলেক্ট করুন</b></h4>");

            } else if ($("select#union").val() === "") {
                toastr["error"]("<h4><b>ইউনিয়ন সিলেক্ট করুন</b></h4>");

            } else if ($("#monthYear").val() === "") {
                toastr["error"]("<h4><b>মাস সিলেক্ট করুন</b></h4>");

            } else {
                var d = $.app.getCurrentPreviousDate(4, 2018).split('~')[0];
                var btn = $(this).button('loading');
                Pace.track(function () {
                    $.ajax({
                        url: "fwaDailyActivity",
                        data: {
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            startDate: $.app.getCurrentPreviousDate($('#monthYear').val().split('/')[0], $('#monthYear').val().split('/')[1]).split('~')[0],
                            endDate: $.app.getCurrentPreviousDate($('#monthYear').val().split('/')[0], $('#monthYear').val().split('/')[1]).split('~')[1]
                        },
                        type: 'POST',
                        success: function (result) {
                            btn.button('reset');
                            var json = JSON.parse(result);

                            if (json.length === 0) {
                                toastr["error"]("<h4><b>No data found</b></h4>");
                                return;
                            }
                            tableBody.empty();
                            $("#transparentTextForBlank").css("display", "none");
                            //show table view after data load
                            $("#tableView").fadeIn("slow");

                            for (var i = 0; i < json.length; i++) {

                                var services = json[i].services;
                                var parsedData = "<tr><td>" + convertE2B((i + 1)) + "</td>"
                                        + "<td>" + json[i].provname + " (" + json[i].providerid + ")</td>"
                                        + "<td>" + getFWAUnit(json[i].fwaunit) + "</td>"
                                        + "<td>" + $.app.monthBangla[parseInt($('#monthYear').val().split('/')[0])] + "/  " + convertE2B($('#monthYear').val().split('/')[1]) + "</td>"
                                        + "<td>" + services.substring(1, services.length - 1).replace(/['"]+/g, '').split(',').join(', ') + "</td>";
                                tableBody.append(parsedData);
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            alert.append(getAlert("Request can't be processed", "danger"));
                        }
                    }); //End Ajax Call
                }); //end pace

            }//end else

        }); //End show data button click

    });


</script>
${sessionScope.designation=='FPI'  && sessionScope.userLevel=='5'? 
  "<input type='hidden' id='isProvider' value='1'>" : "<input type='hidden' id='isSubmitAccess' value='0'>"}
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle">
        eRegister wise monitoring <small id="isCSBA"></small>
    </h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <div class="row" id="areaPanel">
        <div class="col-md-12">
            <div class="box box-primary">
                <input type="hidden" value="${userLevel}" id="userLevel">
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
                    <div class="row secondRow">

                        <div class="col-md-1 col-xs-2">
                            <label for="year">মাস</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <input type="text" class="form-control input-sm" placeholder="mm/yyyy" name="monthYear" id="monthYear" />
                        </div>


                        <div class="col-md-1 col-xs-2">
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off">
                                <b><i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; রিপোর্ট দেখুন</b>
                            </button>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Transparent Text For Blank Space-->
    <section class="content-header" id="transparentTextForBlank" style="display: block;">
        <center class="emis_hologram">eMIS</center>
    </section>

    <!--------------------------------------------------------------------------------Data Table Goes Here-------------------------------------------------------------------------------->  
    <div class="box box-primary full-screen" id="tableView">    
        <div class="box-header with-border">
            <div class="box-tools pull-right" style="margin-top: -10px;">
                <button id="printTableBtn" type="button" class="btn btn-flat btn-default btn-xs bold"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body">
            <div class="row">
                <div class="col-sm-12" id="printTable">
                    <div id="dvData">
                        <table id="data-table" class="table table-bordered table-striped table-hover" align="center">
                            <thead id="tableHeader" class="data-table">
                                <tr>
                                    <th>#</th>
                                    <th >প্রোভাইডার </th>
                                    <th >ইউনিট</th>
                                    <th >মাস</th>
                                    <th >কার্যক্রম</th>
                                </tr>
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>        
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/themes/smoothness/jquery-ui.css">
<script src="https://www.jqueryscript.net/demo/jQuery-Plugin-For-jQuery-UI-Month-Year-Picker-mtz-monthpicker/jquery.mtz.monthpicker.js"></script>
<script>
    $('#monthYear').monthpicker({pattern: 'mm/yyyy',
        selectedYear: (new Date()).getFullYear(),
        startYear: 2014,
        finalYear: (new Date()).getFullYear()});
    var options = {
        selectedYear: (new Date()).getFullYear(),
        startYear: 2014,
        finalYear: (new Date()).getFullYear(),
        openOnFocus: false // Let's now use a button to show the widget
    };
</script>