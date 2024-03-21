<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/TemplateJs/Chart.bundle.js" type="text/javascript"></script>
<script src="resources/TemplateJs/chart/highcharts.js" type="text/javascript"></script>
<style>
    #rightAlign{
        text-align: right;
    }
    #leftAlign{
        text-align: left;
    }
    canvas {
        -moz-user-select: none;
        -webkit-user-select: none;
        -ms-user-select: none;
    }
    #printTable{
        display: none;
    }
    #presentationType { display: none; }
    #tableView { display: none; }
    #graphView { display: none; }
    #mapView { display: none; }
</style>
<style>
    [class*="col"] { margin-bottom: 10px; }
    .no-margin{
        margin-bottom: 0px!important;
    }
    .box-header.with-border {
        border-bottom: 0px solid #f4f4f4!important;
    }
    .head {
        padding: 0px!important;
    }
</style>
<script>
    var type = ""; //report view tyope variables ex. union wise
    var areaText = "";

    $(document).ready(function () {
        $("#areaDropDownPanel").slideDown("slow"); //Show area dropdowns panel by jquery slideDown
        var defaultStartDate = "04/04/2015"; //for default date
        var regExp = /(\d{1,2})\/(\d{1,2})\/(\d{2,4})/; //for date compare
        //Load District wise Area dropdown
        resetArea("District");

        //Initilization all data representer
        var tableHeader = $('#tableHeader');
        var tableBody = $('#tableBody');
        var tableFooter = $('#tableFooter');
        var tableHeaderP = $('#tableHeaderP');
        var tableBodyP = $('#tableBodyP');
        var tableFooterP = $('#tableFooterP');
        var dashboard = $('#dashboard');
        var chart = $('#chart');
        var jsonLength = null;

        //NID Chart Export portion==============================================

        $('#printChartBtn').click(function () {
            var dataUrl = document.getElementById('canvas').toDataURL(); //attempt to save base64 string to server using this var  
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
            frameDoc.document.write('<style>table, th, td{border:1px solid black; border-collapse: collapse;padding:10px;}th{vertical-align: text-center} td{text-align:right;}</style>');
            frameDoc.document.write('<link href="style.css" rel="stylesheet" type="text/css" />');
            //Append the DIV contents.
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center"><center>Possession of National Identity (NID) Card - ' + type + ' wise</center></h3>');
            frameDoc.document.write('<h5 style="color:black;text-align:center"><center>' + areaText + '</center></h5>');
            //frameDoc.document.write('<div style="text-align:center;margin-left:70px;">');
            frameDoc.document.write('<span style="text-align:center;"><center><img src="' + dataUrl + '"></span></center>');
            //frameDoc.document.write('</div>');
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 500);

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
            frameDoc.document.write('<style>table, th, td{border:1px solid black; border-collapse: collapse;padding:10px;}th{vertical-align: text-center} td{text-align:right;} .area{text-align: left !important;}</style>');
            frameDoc.document.write('<link href="style.css" rel="stylesheet" type="text/css" />');
            //Append the DIV contents.
            frameDoc.document.write('<h3 style="margin-bottom:-12px;"><center>Possession of National Identity (NID) Card - ' + type + ' wise</center></h3>');
            frameDoc.document.write('<h5 style="color:black;"><center> ' + areaText + ' </center></h5>');
            frameDoc.document.write(contents);
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 500);
        });

        //Make CSV using these
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
        //Export CSV  
        $("#exportText").click(function (event) {
            var outputFile = "eMIS_national_id_coverage";
            outputFile = outputFile.replace('.txt', '') + '.txt';
            exportTableToText.apply(this, [$('#dvData > table'), outputFile]); //function call from TemplateHeader
        });
        $("#exportCSV").click(function (event) {
            var outputFile = "eMIS_national_id_coverage ";
            outputFile = outputFile.replace('.csv', '') + '.csv';
            exportTableToCSV.apply(this, [$('#dvData > table'), outputFile]); //function call from TemplateHeader
        });


//=====================NID Report View Type====================================================================================
        $('#mapViewByBtnClick').click(function () {
            $("#mapImg").attr("src", "resources/icon/map.png");
            $("#graphImg").attr("src", "resources/icon/graph.jpg");
            $("#tableImg").attr("src", "resources/icon/table.jpg");
            $("#mapImgBackground").removeClass("info-box-icon bg-gray").addClass("info-box-icon bg-aqua");
            $("#graphImgBackground").removeClass("info-box-icon bg-aqua").addClass("info-box-icon bg-gray");
            $("#tableImgBackground").removeClass("info-box-icon bg-aqua").addClass("info-box-icon bg-gray");

            //add remove css class
            $("#mapViewByBtnClick").css("background-color", "#00ACD6");
            $("#graphViewByBtnClick").css("background-color", "#FFFFFF");
            $("#tableViewByBtnClick").css("background-color", "#FFFFFF");

            $("#tableView").fadeOut("slow");
            $("#graphView").fadeOut("slow");

            //$( "#tableView" ).toggle( "slide" );
            //$( "#graphView" ).toggle( "slide" );
            //document.getElementById('tableView').style.display = "none";
            //document.getElementById('graphView').style.display = "none";

            document.getElementById('graphView').style.display = "none";
            document.getElementById('tableView').style.display = "none";
            $("#mapView").fadeIn("slow");
        });

        $('#graphViewByBtnClick').click(function () {
            $("#mapImg").attr("src", "resources/icon/map.jpg");
            $("#graphImg").attr("src", "resources/icon/graph.png");
            $("#tableImg").attr("src", "resources/icon/table.jpg");
            $("#mapImgBackground").removeClass("info-box-icon bg-aqua").addClass("info-box-icon bg-gray");
            $("#graphImgBackground").removeClass("info-box-icon bg-gray").addClass("info-box-icon bg-aqua");
            $("#tableImgBackground").removeClass("info-box-icon bg-aqua").addClass("info-box-icon bg-gray");

            //add remove css class
            $("#mapViewByBtnClick").css("background-color", "#FFFFFF");
            $("#graphViewByBtnClick").css("background-color", "#00ACD6");
            $("#tableViewByBtnClick").css("background-color", "#FFFFFF");

            //$('#graphView').slideDown("slow");
            //$( "#graphView" ).toggle( "slide" );
            //$("#tableView").fadeOut("slow");

            document.getElementById('mapView').style.display = "none";
            document.getElementById('tableView').style.display = "none";
            $("#graphView").fadeIn("slow");
        });

        $('#tableViewByBtnClick').click(function () {
            $("#mapImg").attr("src", "resources/icon/map.jpg");
            $("#graphImg").attr("src", "resources/icon/graph.jpg");
            $("#tableImg").attr("src", "resources/icon/table.png");
            $("#mapImgBackground").removeClass("info-box-icon bg-aqua").addClass("info-box-icon bg-gray");
            $("#graphImgBackground").removeClass("info-box-icon bg-aqua").addClass("info-box-icon bg-gray");
            $("#tableImgBackground").removeClass("info-box-icon bg-gray").addClass("info-box-icon bg-aqua");

            //add remove css class
            $("#mapViewByBtnClick").css("background-color", "#FFFFFF");
            $("#graphViewByBtnClick").css("background-color", "#FFFFFF");
            $("#tableViewByBtnClick").css("background-color", "#00ACD6");

            document.getElementById('graphView').style.display = "none";
            //$('#tableView').slideDown("slow");
            //$( "#tableView" ).toggle( "slide" );
            //$("#graphView").fadeOut("slow");
            document.getElementById('mapView').style.display = "none";
            document.getElementById('graphView').style.display = "none";
            $("#tableView").fadeIn("slow");

        });


        function removeExistingClass() {
            $("#tableViewByBtnClick").removeClass('btn btn-info btn-flat');
            $("#tableViewByBtnClick").removeClass('btn btn-default btn-flat');

            $("#graphViewByBtnClick").removeClass('btn btn-info btn-flat');
            $("#graphViewByBtnClick").removeClass('btn btn-default btn-flat');

            $("#mapViewByBtnClick").removeClass('btn btn-info btn-flat');
            $("#mapViewByBtnClick").removeClass('btn btn-default btn-flat');
        }

//=====================NID Report View Type eND====================================================================================



        //NID Report District Wise=================================================
        $('#showDistrictPRS').click(function () {

            //reset all data presenter like Dashboard - chart - Table
            resetAllDataPresenter();

            //Get Parameter
            var divisionId = $("select#division1").val();
            var districtId = $("select#district1").val();
            var startDate = $("#startDate1").val() === "" ? defaultStartDate : $("#startDate1").val();
            var endDate = $("#endDate1").val();

            //alert("Date:"+startDate);

            if (divisionId === "") {
                toastr["error"]("<h4><b>Please select Division</b></h4>");

            } else if (districtId === "") {
                toastr["error"]("<h4><b>Please select District</b></h4>");

            } else if (parseInt(startDate.replace(regExp, "$3$2$1")) > parseInt(endDate.replace(regExp, "$3$2$1"))) {
                toastr["error"]("<h4><b>Start date should be smaller than end date</b></h4>");

            } else {

                var btn = $(this).button('loading');
                Pace.track(function () {
                    $.ajax({
                        url: "NidPossessionStatus?action=showDistrictWise",
                        data: {
                            divisionId: divisionId,
                            districtId: districtId,
                            startDate: startDate,
                            endDate: endDate
                        },
                        type: 'POST',
                        success: function (result) {
                            btn.button('reset');
                            var json = JSON.parse(result);
                            jsonLength = json.length;
                            if (json.length === 0) {

                                toastr["error"]("<h4><b>No data found</b></h4>");
                                return;
                            } else {
                                //Show location when area panle is minimize title
                                var division = "Division: <b style='color:#3C8DBC'>" + $("#division1 option:selected").text() + "</b>";
                                var district = " District: <b style='color:#3C8DBC'>" + $("#district1 option:selected").text() + "</b>";
                                var s = $("#startDate1").val() === "" ? "-" : $("#startDate1").val();
                                var sDate = "From: <b style='color:#3C8DBC'>" + s + "</b>";
                                var eDate = "To: <b style='color:#3C8DBC'>" + endDate + "</b>";
                                areaText = division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate;
                                $("#area").html(division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate);

                                $('#collapseArea').click(); //minimze area panel
                                $('#presentationType').slideDown("slow"); //Show data presentation type buttons
                                $("#graphView").fadeIn("slow"); //Show TAble initially

                                //<-Chart-Upazila-> NID Possession Status===================
                                if (json.length == 1) {
                                    $.chart.renderPIE(json, chart, $.chart.NID);
                                } else {
                                    $.chart.NID.area = 'distname';
                                    $.chart.renderBAR(json, chart, $.chart.NID);
                                }
                                //End <-Chart-Upazila->=====================================

                                //<-Table-> NID Possession Status===================
                                //For Data table header
                                tableHeader.empty();
                                tableHeaderP.empty();
                                var header = "<tr>"
                                        + "<th style='vertical-align: text-top'>#</th>"
                                        + "<th style='vertical-align: text-top'>District</th>"
                                        + "<th style='vertical-align: text-top'>Registered</th>"
                                        + "<th style='vertical-align: text-top'>Eligible(18+)</th>"
                                        + "<th style='vertical-align: text-top'>Have NID card (%)</th>"
                                        + "<th style='vertical-align: text-top'>Never had (%)</th>"
                                        + "<th style='vertical-align: text-top'>Lost (%)</th>"
                                        + "<th style='vertical-align: text-top'>Can’t locate (%)</th>"
                                        + "<th style='vertical-align: text-top'>Kept in other place (%)</th>"
                                        + "<th style='vertical-align: text-top'>Not citizen (%)</th>"
                                        + "</tr>";
                                tableHeader.append(header);
                                tableHeaderP.append(header);

                                var registered_sum = 0, eligible_sum = 0, havenid_sum = 0,
                                        dont_have_sum = 0, missing_sum = 0, not_found_sum = 0, other_place_sum = 0, not_citizen_sum = 0;

                                //Reset Data Tables
                                var table = $('#data-table').DataTable();
                                table.destroy();
                                tableBody.empty();
                                tableBodyP.empty();
                                for (var i = 0; i < json.length; i++) {

                                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                            + "<td id='leftAlign' class='area'>" + json[i].distname + "</td>"
                                            + "<td id='rightAlign'>" + json[i].registered + "</td>"
                                            + "<td id='rightAlign'>" + json[i].eligible + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].havenid / json[i].eligible * 100).toFixed(2)) + "</td>"
//                                            + "<td id='rightAlign'>" + json[i].percent + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].dont_have / json[i].eligible * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].missing / json[i].eligible * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].not_found / json[i].eligible * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].other_place / json[i].eligible * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].not_citizen / json[i].eligible * 100).toFixed(2)) + "</tr>";

                                    tableBody.append(parsedData);
                                    tableBodyP.append(parsedData);

                                    registered_sum += json[i].registered;
                                    eligible_sum += json[i].eligible;
                                    havenid_sum += json[i].havenid;
                                    dont_have_sum += json[i].dont_have;
                                    missing_sum += json[i].missing;
                                    not_found_sum += json[i].not_found;
                                    other_place_sum += json[i].other_place;
                                    not_citizen_sum += json[i].not_citizen;
                                }

                                if (registered_sum > 0 || eligible_sum > 0 || havenid_sum > 0
                                        || dont_have_sum > 0 || missing_sum > 0 || not_found_sum || not_found_sum > 0
                                        || other_place_sum > 0 || not_citizen_sum > 0
                                        ) {
                                    var footerData = "<tr> <td style='text-align:left' colspan='2'>Total</td>"
                                            + "<td id='rightAlign'>" + registered_sum + "</td>"
                                            + "<td id='rightAlign'>" + eligible_sum + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((havenid_sum / eligible_sum * 100).toFixed(2)) + "</td>"
//                                            + "<td id='rightAlign'>" + ((havenid_sum / registered_sum) * 100).toFixed(2) + "</td>"                                      
                                            + "<td id='rightAlign'>" + parseFloat((dont_have_sum / eligible_sum * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((missing_sum / eligible_sum * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((not_found_sum / eligible_sum * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((other_place_sum / eligible_sum * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((not_citizen_sum / eligible_sum * 100).toFixed(2)) + "</tr>";

                                    tableFooter.empty();
                                    tableFooterP.empty();
                                    tableFooter.append(footerData);
                                    tableFooterP.append(footerData);
                                    var table = $('#data-table').DataTable();
                                    table.draw();
                                }
                                //End <-Table-District->=====================================            

                                btn.button('reset');

                            }//end check it empty json or not

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    }); //End Ajax request

                }); //End Pace loading

            }//end validation else
        });

        //NID Report Upazila Wise=================================================
        $('#showUpazilaPRS').click(function () {

            //reset all data presenter like Dashboard - chart - Table
            resetAllDataPresenter();

            //Get Parameter
            var divisionId = $("select#division2").val();
            var districtId = $("select#district2").val();
            var upazilaId = $("select#upazila2").val();
            var startDate = $("#startDate2").val() === "" ? defaultStartDate : $("#startDate2").val();
            var endDate = $("#endDate2").val();

            if (divisionId === "") {
                toastr["error"]("<h4><b>Please select Division</b></h4>");

            } else if (districtId === "") {
                toastr["error"]("<h4><b>Please select District</b></h4>");

            } else if (upazilaId === "") {
                toastr["error"]("<h4><b>Please select Upazila</b></h4>");

            } else if (parseInt(startDate.replace(regExp, "$3$2$1")) > parseInt(endDate.replace(regExp, "$3$2$1"))) {
                toastr["error"]("<h4><b>Start date should be smaller than end date</b></h4>");

            } else {
                var btn = $(this).button('loading');
                Pace.track(function () {
                    $.ajax({
                        url: "NidPossessionStatus?action=showUpazilaWise",
                        data: {
                            districtId: districtId,
                            upazilaId: upazilaId,
                            startDate: startDate,
                            endDate: endDate
                        },
                        type: 'POST',
                        success: function (result) {
                            var json = JSON.parse(result);
                            jsonLength = json.length;
                            if (json.length === 0) {
                                btn.button('reset');
                                toastr["error"]("<h4><b>No data found</b></h4>");
                            } else {
                                //Show location when area panle is minimize title
                                var division = "Division: <b style='color:#3C8DBC'>" + $("#division2 option:selected").text() + "</b>";
                                var district = " District: <b style='color:#3C8DBC'>" + $("#district2 option:selected").text() + "</b>";
                                var upazila = " Upazila: <b style='color:#3C8DBC'>" + $("#upazila2 option:selected").text() + "</b>";
                                var s = $("#startDate2").val() === "" ? "-" : $("#startDate2").val();
                                var sDate = "From: <b style='color:#3C8DBC'>" + s + "</b>";
                                var eDate = "To: <b style='color:#3C8DBC'>" + endDate + "</b>";
                                areaText = division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate;
                                $("#area").html(division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate);

                                $('#collapseArea').click(); //minimze area panel
                                $('#presentationType').slideDown("slow"); //Show data presentation type buttons
                                $("#graphView").fadeIn("slow"); //Show TAble initially

                                //<-Chart-Upazila-> NID Possession Status===================
                                if (json.length == 1) {
                                    $.chart.renderPIE(json, chart, $.chart.NID);
                                } else {
                                    $.chart.NID.area = 'upname';
                                    $.chart.renderBAR(json, chart, $.chart.NID);
                                }
                                //End <-Chart-Upazila->=====================================

                                //<-Table-Upazila-> NID Possession Status===================
                                //For Data table header
                                tableHeader.empty();
                                tableHeaderP.empty();
                                var header = "<tr>"
                                        + "<th style='vertical-align: text-top'>#</th>"
                                        + "<th style='vertical-align: text-top'>Upazila</th>"
                                        + "<th style='vertical-align: text-top'>Registered</th>"
                                        + "<th style='vertical-align: text-top'>Eligible(18+)</th>"
                                        + "<th>Have NID card (%)</th>"
//                                    +"<th>(%)</th>"
                                        + "<th>Never had (%)</th>"
                                        + "<th>Lost (%)</th>"
                                        + "<th>Can’t locate (%)</th>"
                                        + "<th>Kept in other place (%)</th>"
                                        + "<th>Not citizen (%)</th>"
                                        + "</tr>";
                                tableHeader.append(header);
                                tableHeaderP.append(header);

                                var registered_sum = 0, eligible_sum = 0, havenid_sum = 0,
                                        dont_have_sum = 0, missing_sum = 0, not_found_sum = 0, other_place_sum = 0, not_citizen_sum = 0;
                                //Reset data table
                                var table = $('#data-table').DataTable();
                                table.destroy();
                                tableBody.empty();
                                tableBodyP.empty();
                                for (var i = 0; i < json.length; i++) {

                                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                            + "<td id='leftAlign' class='area'>" + json[i].upname + "</td>"
                                            + "<td id='rightAlign'>" + json[i].registered + "</td>"
                                            + "<td id='rightAlign'>" + json[i].eligible + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].havenid / json[i].eligible * 100).toFixed(2)) + "</td>"
//                                            + "<td id='rightAlign'>" + json[i].percent + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].dont_have / json[i].eligible * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].missing / json[i].eligible * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].not_found / json[i].eligible * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].other_place / json[i].eligible * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].not_citizen / json[i].eligible * 100).toFixed(2)) + "</tr>";

                                    tableBody.append(parsedData);
                                    tableBodyP.append(parsedData);

                                    registered_sum += json[i].registered;
                                    eligible_sum += json[i].eligible;
                                    havenid_sum += json[i].havenid;
                                    dont_have_sum += json[i].dont_have;
                                    missing_sum += json[i].missing;
                                    not_found_sum += json[i].not_found;
                                    other_place_sum += json[i].other_place;
                                    not_citizen_sum += json[i].not_citizen;
                                }

                                if (registered_sum > 0 || eligible_sum > 0 || havenid_sum > 0
                                        || dont_have_sum > 0 || missing_sum > 0 || not_found_sum || not_found_sum > 0
                                        || other_place_sum > 0 || not_citizen_sum > 0
                                        ) {
                                    var footerData = "<tr> <td style='text-align:left' colspan='2'>Total</td>"
                                            + "<td id='rightAlign'>" + registered_sum + "</td>"
                                            + "<td id='rightAlign'>" + eligible_sum + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((havenid_sum / eligible_sum * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((dont_have_sum / eligible_sum * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((missing_sum / eligible_sum * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((not_found_sum / eligible_sum * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((other_place_sum / eligible_sum * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((not_citizen_sum / eligible_sum * 100).toFixed(2)) + "</tr>";

                                    tableFooter.empty();
                                    tableFooterP.empty();
                                    tableFooter.append(footerData);
                                    tableFooterP.append(footerData);
                                    var table = $('#data-table').DataTable();
                                    table.draw();
                                }
                                //End <-Table-Upazila->=====================================            

                                btn.button('reset');

                            }//end check it empty json or not

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    }); //End Ajax request

                }); //End Pace loading

            }//end else
        }); //end show upazila wise



        //NID Report Union Wise=================================================
        $('#showUnionPRS').click(function () {

            //reset all data presenter like Dashboard - chart - Table
            resetAllDataPresenter();

            //Get Parameter
            var divisionId = $("select#division3").val();
            var districtId = $("select#district3").val();
            var upazilaId = $("select#upazila3").val();
            var unionId = $("select#union3").val();
            var startDate = $("#startDate3").val() === "" ? defaultStartDate : $("#startDate3").val();
            var endDate = $("#endDate3").val();

            if (divisionId === "") {
                toastr["error"]("<h4><b>Please select Division</b></h4>");

            } else if (districtId === "") {
                toastr["error"]("<h4><b>Please select District</b></h4>");

            } else if (upazilaId === "") {
                toastr["error"]("<h4><b>Please select Upazila</b></h4>");

            } else if (unionId === "") {
                toastr["error"]("<h4><b>Please select Union</b></h4>");

            } else if (parseInt(startDate.replace(regExp, "$3$2$1")) > parseInt(endDate.replace(regExp, "$3$2$1"))) {
                toastr["error"]("<h4><b>Start date should be smaller than end date</b></h4>");

            } else {
                var btn = $(this).button('loading');
                Pace.track(function () {
                    $.ajax({
                        url: "NidPossessionStatus?action=showUnionWise",
                        data: {
                            districtId: districtId,
                            upazilaId: upazilaId,
                            unionId: unionId,
                            startDate: startDate,
                            endDate: endDate
                        },
                        type: 'POST',
                        success: function (result) {
                            var json = JSON.parse(result);
                            jsonLength = json.length;
                            if (json.length === 0) {
                                btn.button('reset');
                                toastr["error"]("<h4><b>No data found</b></h4>");
                            } else {
                                //Show location when area panle is minimize title
                                var division = "Division: <b style='color:#3C8DBC'>" + $("#division3 option:selected").text() + "</b>";
                                var district = " District: <b style='color:#3C8DBC'>" + $("#district3 option:selected").text() + "</b>";
                                var upazila = " Upazila: <b style='color:#3C8DBC'>" + $("#upazila3 option:selected").text() + "</b>";
                                var union = " Union: <b style='color:#3C8DBC'>" + $("#union3 option:selected").text() + "</b>";
                                var s = $("#startDate3").val() === "" ? "-" : $("#startDate3").val();
                                var sDate = "From: <b style='color:#3C8DBC'>" + s + "</b>";
                                var eDate = "To: <b style='color:#3C8DBC'>" + endDate + "</b>";
                                areaText = division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + union + ',&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate;
                                $("#area").html(division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + union + ',&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate);

                                $('#collapseArea').click(); //minimze area panel
                                $('#presentationType').slideDown("slow"); //Show data presentation type buttons
                                $("#graphView").fadeIn("slow"); //Show TAble initially

                                //<-Chart-Union> NID Possession Status===================
                                if (json.length == 1) {
                                    $.chart.renderPIE(json, chart, $.chart.NID);
                                } else {
                                    $.chart.NID.area = 'uname';
                                    $.chart.renderBAR(json, chart, $.chart.NID);
                                }
                                //End <-Chart->=====================================     

                                //<-Table-Union-> NID Possession Status===================

                                //For Data table header
                                tableHeader.empty();
                                tableHeaderP.empty();
                                var header = "<tr>"
                                        + "<th style='vertical-align: text-top'>#</th>"
                                        + "<th style='vertical-align: text-top;'>Union</th>"
                                        + "<th style='vertical-align: text-top'>Registered</th>"
                                        + "<th style='vertical-align: text-top'>Eligible(18+)</th>"
                                        + "<th style='vertical-align: text-top'>Have NID card (%)</th>"
                                        + "<th style='vertical-align: text-top'>Never had (%)</th>"
                                        + "<th style='vertical-align: text-top'>Lost (%)</th>"
                                        + "<th style='vertical-align: text-top'>Can’t locate (%)</th>"
                                        + "<th style='vertical-align: text-top'>Kept in other place (%)</th>"
                                        + "<th style='vertical-align: text-top'>Not citizen (%)</th>"
                                        + "</tr>";
                                tableHeader.append(header);
                                tableHeaderP.append(header);

                                var registered_sum = 0, eligible_sum = 0, havenid_sum = 0,
                                        dont_have_sum = 0, missing_sum = 0, not_found_sum = 0, other_place_sum = 0, not_citizen_sum = 0;
                                //Reset Data tables
                                var table = $('#data-table').DataTable();
                                table.destroy();
                                tableBody.empty();
                                tableBodyP.empty();

                                for (var i = 0; i < json.length; i++) {

                                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                            + "<td style='text-align: left;' class='area'>" + json[i].uname + "</td>"
                                            + "<td id='rightAlign'>" + json[i].registered + "</td>"
                                            + "<td id='rightAlign'>" + json[i].eligible + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].havenid / json[i].eligible * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].dont_have / json[i].eligible * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].missing / json[i].eligible * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].not_found / json[i].eligible * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].other_place / json[i].eligible * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((json[i].not_citizen / json[i].eligible * 100).toFixed(2)) + "</td></tr>";

                                    tableBody.append(parsedData);
                                    tableBodyP.append(parsedData);

                                    registered_sum += json[i].registered;
                                    eligible_sum += json[i].eligible;
                                    havenid_sum += json[i].havenid;
                                    dont_have_sum += json[i].dont_have;
                                    missing_sum += json[i].missing;
                                    not_found_sum += json[i].not_found;
                                    other_place_sum += json[i].other_place;
                                    not_citizen_sum += json[i].not_citizen;
                                }

                                if (registered_sum > 0 || eligible_sum > 0 || havenid_sum > 0
                                        || dont_have_sum > 0 || missing_sum > 0 || not_found_sum || not_found_sum > 0
                                        || other_place_sum > 0 || not_citizen_sum > 0
                                        ) {
                                    var footerData = "<tr> <td style='text-align:left' colspan='2'>Total</td>"
                                            + "<td id='rightAlign'>" + registered_sum + "</td>"
                                            + "<td id='rightAlign'>" + eligible_sum + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((havenid_sum / eligible_sum * 100).toFixed(2)) + "</td>"
                                            //                                        + "<td id='rightAlign'>" + ((havenid_sum / registered_sum) * 100).toFixed(2) + "</td>"                                      
                                            + "<td id='rightAlign'>" + parseFloat((dont_have_sum / eligible_sum * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((missing_sum / eligible_sum * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((not_found_sum / eligible_sum * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((other_place_sum / eligible_sum * 100).toFixed(2)) + "</td>"
                                            + "<td id='rightAlign'>" + parseFloat((not_citizen_sum / eligible_sum * 100).toFixed(2)) + "</tr>";

                                    tableFooter.empty();
                                    tableFooterP.empty();
                                    tableFooter.append(footerData);
                                    tableFooterP.append(footerData);
                                    var table = $('#data-table').DataTable();
                                    table.draw();
                                }
                                //End <-Table-Union->=====================================

                                btn.button('reset');

                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    }); //End Ajax request

                }); //End Pace loading

            } //End Else

        }); //End Show Data button click



//======PRS Report Provider Wise===============================================================================================
        $('#showProviderPRS').click(function () {
            resetAllDataPresenter();

            var divisionId = $("select#division5").val();
            var districtId = $("select#district5").val();
            var upazilaId = $("select#upazila5").val();
            var unionId = $("select#union5").val();
            var designation = $("select#designation5").val();
            var startDate = $("#startDate5").val();
            var endDate = $("#endDate5").val();

            if (divisionId === "") {
                toastr["error"]("<h4><b>Please select Division</b></h4>");

            } else if (districtId === "") {
                toastr["error"]("<h4><b>Please select District</b></h4>");

            } else if (upazilaId === "") {
                toastr["error"]("<h4><b>Please select Upazila</b></h4>");

            } else if (parseInt(startDate.replace(regExp, "$3$2$1")) > parseInt(endDate.replace(regExp, "$3$2$1"))) {
                toastr["error"]("<h4><b>Start date should be smaller than end date</b></h4>");

            } else {
                var btn = $(this).button('loading'); //Start show-data button loading
                Pace.track(function () {
                    $.ajax({
                        url: "NidPossessionStatus?action=prsProgressProviderWise",
                        data: {
                            districtId: districtId,
                            upazilaId: upazilaId,
                            unionId: unionId,
                            designation: designation,
                            startDate: startDate,
                            endDate: endDate
                        },
                        type: 'POST',
                        success: function (result) {
                            btn.button('reset');
                            var json = JSON.parse(result);
                            console.log(json);
                            if (json.length === 0) {
                                toastr["error"]("<h4><b>No Data Found</b></h4>");
                                btn.button('reset');
                            } else {


                                //Show location when area panle is minimize title
                                var division = "Division: <b style='color:#3C8DBC'>" + $("#division5 option:selected").text() + "</b>";
                                var district = " District: <b style='color:#3C8DBC'>" + $("#district5 option:selected").text() + "</b>";
                                var upazila = " Upazila: <b style='color:#3C8DBC'>" + $("#upazila5 option:selected").text() + "</b>";
                                var union = " Union: <b style='color:#3C8DBC'>" + $("#union5 option:selected").text() + "</b>";
                                var designation = " Designation <b style='color:#3C8DBC'>" + $("#designation5 option:selected").text() + "</b>";
                                var sDate = "From: <b style='color:#3C8DBC'>" + startDate + "</b>";
                                var eDate = "To: <b style='color:#3C8DBC'>" + endDate + "</b>";
                                areaText = division + ' ' + district + ' ' + upazila + ' ' + union + ' ' + sDate + ' ' + eDate; //for 
                                //$.registrationCoverage.reportTitle = division + ' ' + district + ' ' + upazila + ' ' + union + ' ' + sDate + ' ' + eDate; //for 
                                $("#area").html(division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + union + ',&nbsp;&nbsp;' + designation + ',&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate);


                                $('#collapseArea').click(); //minimze area panel
                                $("#tableView").fadeIn("slow");
                                //<-Table-> Upazila wise========================
                                //For Data table header
                                tableHeader.empty();
                                tableHeaderP.empty();
                                var header = '<tr class="remove-wrap">'
                                        + '<th style="vertical-align: text-top">#</th>'
                                        + '<th style="vertical-align: text-top">Upazila</th>'
                                        + '<th style="vertical-align: text-top">Union</th>'
                                        + '<th style="vertical-align: text-top">Provider&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>'
                                        + '<th style="vertical-align: text-top">Designation</th>'
                                        + '<th style="vertical-align: text-top">Start date</th>'
                                        + '<th style="vertical-align: text-top">End date</th>'
                                        + "<th style='vertical-align: text-top'>Registered</th>"
                                        + "<th style='vertical-align: text-top'>Eligible(18+)</th>"
                                        + "<th style='vertical-align: text-top'>Have NID card (%)</th>"
                                        + "<th style='vertical-align: text-top'>Never had (%)</th>"
                                        + "<th style='vertical-align: text-top'>Lost (%)</th>"
                                        + "<th style='vertical-align: text-top'>Can’t locate (%)</th>"
                                        + "<th style='vertical-align: text-top'>Kept in other place (%)</th>"
                                        + "<th style='vertical-align: text-top'>Not citizen (%)</th>"
                                        + '</tr>';
                                tableHeader.append(header);
                                tableHeaderP.append(header);

                                //For Data table reset
                                var table = $('#data-table').DataTable();
                                table.destroy();
                                tableBody.empty();
                                tableBodyP.empty();
                                for (var i = 0; i < json.length; i++) {

                                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                            + "<td class='area'>" + json[i].upazilanameeng + "</td>"
                                            + "<td class='area'>" + json[i].unionnameeng + "</td>"
                                            + "<td class='area'>" + json[i].provname + "  (" + json[i].providerid + ")</td>"
                                            + "<td class='area'>" + json[i].provtype + "</td>"
                                            + "<td>" + json[i].start_date + "</td>"
                                            + "<td>" + json[i].end_date + "</td>"
                                            + "<td class='numeric_field'>" + json[i].population + "</td>"
                                            + "<td class='numeric_field'>" + json[i].eligible + "</td>"
                                            + "<td class='numeric_field'>" + finiteFilter(parseFloat((json[i].have_nid / json[i].eligible * 100).toFixed(2))) + "</td>"
                                            + "<td class='numeric_field'>" + finiteFilter(parseFloat((json[i].dont_have / json[i].eligible * 100).toFixed(2))) + "</td>"
                                            + "<td class='numeric_field'>" + finiteFilter(parseFloat((json[i].missing / json[i].eligible * 100).toFixed(2))) + "</td>"
                                            + "<td class='numeric_field'>" + finiteFilter(parseFloat((json[i].not_found / json[i].eligible * 100).toFixed(2))) + "</td>"
                                            + "<td class='numeric_field'>" + finiteFilter(parseFloat((json[i].other_place / json[i].eligible * 100).toFixed(2))) + "</td>"
                                            + "<td class='numeric_field'>" + finiteFilter(parseFloat((json[i].not_citizen / json[i].eligible * 100).toFixed(2))) + "</td>"
                                            + "</tr>";

                                    tableBody.append(parsedData);
                                    tableBodyP.append(parsedData);
                                }

                                var cal = new Calc(json);

                                var footerData = "<tr> <td style='text-align:left' colspan='4'>Total</td>"
                                        + "<td id='rightAlign'>" + cal.sum.totalhousehold + "</td>"
                                        + "<td id='rightAlign'>" + cal.sum.totalelcokhata + "</td>"
                                        + "<td id='rightAlign'>" + cal.sum.totalelco + "</td>"
                                        + "<td id='rightAlign'>" + Math.round(finiteFilter((cal.sum.totalelco / cal.sum.totalelcokhata) * 100)) + " </td>";

                                var footerData = "<tr> <td style='text-align:left' colspan='7'>Total</td>"
                                        + "<td class='numeric_field'>" + cal.sum.population + "</td>"
                                        + "<td class='numeric_field'>" + cal.sum.eligible + "</td>"
                                        + "<td class='numeric_field'>" + parseFloat((cal.sum.have_nid / cal.sum.eligible * 100).toFixed(2)) + "</td>"
                                        + "<td class='numeric_field'>" + parseFloat((cal.sum.dont_have / cal.sum.eligible * 100).toFixed(2)) + "</td>"
                                        + "<td class='numeric_field'>" + parseFloat((cal.sum.missing / cal.sum.eligible * 100).toFixed(2)) + "</td>"
                                        + "<td class='numeric_field'>" + parseFloat((cal.sum.not_found / cal.sum.eligible * 100).toFixed(2)) + "</td>"
                                        + "<td class='numeric_field'>" + parseFloat((cal.sum.other_place / cal.sum.eligible * 100).toFixed(2)) + "</td>"
                                        + "<td class='numeric_field'>" + parseFloat((cal.sum.not_citizen / cal.sum.eligible * 100).toFixed(2)) + "</td></tr>";

                                tableFooter.empty();
                                tableFooterP.empty();
                                tableFooter.append(footerData);
                                tableFooterP.append(footerData);
                                var table = $('#data-table').DataTable();
                                table.draw();
                                btn.button('reset');
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    });

                });
            }
        }); //End Show PRS type Provider
//======END============================================================================================================================


        function resetAllDataPresenter() {
            tableHeader.empty();
            tableBody.empty();
            tableFooter.empty();
            dashboard.empty();
            chart.empty();
            document.getElementById('transparentTextForBlank').style.display = "none";
            document.getElementById('presentationType').style.display = "none";
            document.getElementById('tableView').style.display = "none";
            document.getElementById('graphView').style.display = "none";
            document.getElementById('mapView').style.display = "none";

            $("#mapViewByBtnClick").css("background-color", "#FFFFFF");
            $("#graphViewByBtnClick").css("background-color", "#00ACD6");
            $("#tableViewByBtnClick").css("background-color", "#FFFFFF");
        }

    }); //End jQuery

    //Get date as YYYY-MM_DD
    Date.prototype.yyyymmdd = function () {
        var yyyy = this.getFullYear();
        var mm = this.getMonth() < 9 ? "0" + (this.getMonth() + 1) : (this.getMonth() + 1); // getMonth() is zero-based
        var dd = this.getDate() < 10 ? "0" + this.getDate() : this.getDate();
        return "".concat(yyyy).concat("-" + mm + "-").concat(dd);
    };

    function  getDateFormat(date) {

        var getDate = date.split('-');

        var day = getDate[0];
        var month = getDate[1];
        var year = getDate[2];

        return year + "-" + month + "-" + day;
    }
</script>

<!-- Content Header (Page header) -->
<section class="content-header">
    <!--  <h1>Possession of National Identity Card<small>এই টুল ব্যবহার করে এন আইডি গ্রহণ করা হয়েছে কিনা তা পর্যালচনা করুন  </small></h1>-->
    <h1>Possession of National Identity (NID) Card</h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load area dropdowns panel----------------------------------->
    <div class="row" id="areaDropDownPanel" style="display:none;">
        <div class="col-md-12 no-margin">
            <div class="box box-primary">
            <div class="box-header with-border head">
            </div>
                <div class="box-body" >
                    <div class="nav-tabs-custom" style="margin-top:  -10px;margin-bottom:  -9px;">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#districtWise" data-toggle="tab" onclick="resetArea('District')"> District Wise</a></li>
                            <li><a href="#upazilaWise" data-toggle="tab" onclick='resetArea("Upazila")'> Upazila Wise</a></li>
                            <li><a href="#unionWise" data-toggle="tab" onclick='resetArea("Union")'> Union Wise</a></li>
                            <li><a href="#providerWise" data-toggle="tab" onclick='resetArea("Provider")'> Provider Wise</a></li>
                        </ul>
                        <div class="tab-content">
                            <input type="hidden" value="${userLevel}" id="userLevel">
                            <!--------------------------District Wise---------------------------------------------------->                
                            <div class="tab-pane active" id="districtWise">
                                <div class="row">
                                    <div class="col-md-1 col-xs-2">
                                        <label for="division1" id="">Division</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <select class="form-control input-sm" id="division1">
                                            <option value="">- Select Division -</option>
                                        </select>
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                        <label for="district1" id="">District</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <select class="form-control input-sm" id="district1">
                                            <option value="">Select</option>
                                        </select>
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                        <label for="one" id="">From</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" id="startDate1" />
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                        <label for="one" id="">To</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" id="endDate1" />
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-md-1 col-xs-2">
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                    </div>     
                                    <div class="col-md-1 col-xs-2">
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                    </div>                        
                                    <div class="col-md-1 col-xs-2">
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <button type="button" id="showDistrictPRS" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off">
                                            <i class="fa fa-bar-chart" aria-hidden="true"></i> View Data
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!--------------------------Upazilla Wise---------------------------------------------------->
                            <div class="tab-pane" id="upazilaWise">
                                <div class="row">
                                    <div class="col-md-1 col-xs-2">
                                        <label for="division2" id="">Division</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <select class="form-control input-sm" id="division2">
                                            <option value="">Select</option>
                                        </select>
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                        <label for="district2" id="">District</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <select class="form-control input-sm" id="district2">
                                            <option value="">Select</option>
                                        </select>
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                        <label for="upazila2" id="">Upazila</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <select class="form-control input-sm" id="upazila2">
                                            <option value="">Select</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1 col-xs-2">
                                        <label for="one" id="">From</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy"  id="startDate2" />
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                        <label for="one" id="">To</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" id="endDate2" />
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <button type="button" id="showUpazilaPRS" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off">
                                            <i class="fa fa-bar-chart" aria-hidden="true"></i> View Data
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <!--------------------------Union Wise---------------------------------------------------->               
                            <div class="tab-pane" id="unionWise">
                                <div class="row">
                                    <div class="col-md-1 col-xs-2">
                                        <label for="one" id="">Division</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <select class="form-control input-sm" id="division3">
                                            <option value="">Select</option>
                                        </select>
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                        <label for="district3" id="">District</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <select class="form-control input-sm" id="district3">
                                            <option value="">Select</option>
                                        </select>
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                        <label for="upazila3" id="">Upazila</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <select class="form-control input-sm" id="upazila3">
                                            <option value="">Select</option>
                                        </select>
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                        <label for="union3" id="">Union</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <select class="form-control input-sm" id="union3">
                                            <option value="">Select</option>
                                        </select>
                                    </div>

                                </div>
                                <div class="row">

                                    <div class="col-md-1 col-xs-2">
                                        <label for="one" id="">From</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="startDate" id="startDate3" />
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                        <label for="one" id="">To</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="endDate" id="endDate3" />
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <button type="button" id="showUnionPRS" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off">
                                            <i class="fa fa-bar-chart" aria-hidden="true"></i> View Data
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <!--------------------------Provider Wise---------------------------------------------------->               
                            <div class="tab-pane" id="providerWise">
                                <div class="row">
                                    <div class="col-md-1 col-xs-2">
                                        <label for="division5" id="">Division</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <select class="form-control input-sm" id="division5">
                                            <option value="">Select</option>
                                        </select>
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                        <label for="district5" id="">District</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <select class="form-control input-sm" id="district5">
                                            <option value="">Select</option>
                                        </select>
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                        <label for="upazila5" id="">Upazila</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <select class="form-control input-sm" id="upazila5">
                                            <option value="">Select</option>
                                        </select>
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                        <label for="union5" id="">Union</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <select class="form-control input-sm" id="union5">
                                            <option value="">Select</option>
                                        </select>
                                    </div>

                                </div>
                                <div class="row">

                                    <div class="col-md-1 col-xs-2">
                                        <label for="designation" id="">Designation</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <select class="form-control input-sm" id="designation5">
                                            <option value="%">All</option>
                                            <option value="2">HA</option>
                                            <option value="3">FWA</option>
                                        </select>
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                        <label for="one" id="">From</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="startDate" id="startDate5" />
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                        <label for="one" id="">To</label>
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="endDate" id="endDate5" />
                                    </div>

                                    <div class="col-md-1 col-xs-2">
                                    </div>
                                    <div class="col-md-2 col-xs-4">
                                        <button type="button" id="showProviderPRS" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off">
                                            <i class="fa fa-bar-chart" aria-hidden="true"></i> View Data
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><h4><center id="area"></center></h4>
            </div>
        </div>
    </div>


    <!------------------------------Load Data Presentation Type panel----------------------------------->
    <%@include file="/WEB-INF/jspf/prsDataPresentationType.jspf" %>

    <!--NID Data Map-->
    <div class="box box-primary full-screen" id="mapView">
        <div class="box-header with-border">
            <h3 class="box-title"><b></b>Map Presentation</h3>
            <div class="box-tools pull-right" style="margin-top: 0px;">
                <button type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print</button>
                <button type="button" class="btn btn-box-tool"><i class="fa fa-file-pdf-o" aria-hidden="true"></i>&nbsp;PDF</button>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body">
            <div class="table-responsive" >
                <h1 style="color:#f9d390;font-size: 60px;"><center style="margin-bottom: 150px;">This part is under development</center></h1>
                <br/>
            </div>
        </div>
    </div>

    <!--NID Data Chart-->
    <div class="box box-primary full-screen" id="graphView">
        <div class="box-header with-border">
            <h3 class="box-title">Graphical Presentation</h3>
            <div class="box-tools pull-right" style="margin-top: 0px;">
                <button id="printChartBtn" type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body" id="printChart">
            <div class="table-responsive" >
                <div id="chart"></div>
                <br/>
            </div>
        </div>
    </div>
    <!--Demo-->
    <span id="dashboard">
    </span>

    <!--NID Data Table-->
    <div class="box box-primary full-screen" id="tableView">
        <div class="box-header with-border">
            <h3 class="box-title">Tabular Presentation</h3>
            <div class="box-tools pull-right" style="margin-top: 0px;">
                <button type="button" id="printTableBtn" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <a href="#" id ="exportCSV" role='button' class="btn btn-box-tool"><i class="fa fa-file-excel-o" aria-hidden="true"></i>&nbsp;CSV</a>
                <a href="#" id ="exportText" role='button' class="btn btn-box-tool"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Text</a>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body">
            <!--Data Table-->               
            <div class="col-ld-12" id="">
                <div class="table-responsive" >
                    <div id="dvData">
                        <table class="table table-bordered table-striped" id="data-table">
                            <thead id="tableHeader" class="data-table">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter" class="data-table">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="box-body" id="printTable">
            <div id="dvData">
                <table class="table table-bordered table-striped" align="center">
                    <thead id="tableHeaderP">
                    </thead>
                    <tbody id="tableBodyP">
                    </tbody>
                    <tfoot id="tableFooterP">
                    </tfoot>
                </table>
            </div>
        </div>

    </div> 
</section>

<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>

<script src="resources/js/prsDropDowns.js" type="text/javascript"></script>
<style>
    .panel-actions {
        margin-top: -20px;
        margin-bottom: 0;
        text-align: right;
    }
    .panel-actions a {
        color:#333;
    }
    .panel-fullscreen {
        display: block;
        z-index: 9999;
        position: fixed;
        width: 100%;
        height: 100%;
        top: 0;
        right: 0;
        left: 0;
        bottom: 0;
        overflow: auto;
    }
</style>
<script>

                                $(document).ready(function () {
                                    //Toggle fullscreen
                                    $("#panel-fullscreen").click(function (e) {
                                        e.preventDefault();

                                        var $this = $(this);

                                        if ($this.children('i').hasClass('fa fa-expand'))
                                        {
                                            $this.children('i').removeClass('fa fa-expand');
                                            $this.children('i').addClass('fa fa-compress');
                                        } else if ($this.children('i').hasClass('fa fa-compress'))
                                        {
                                            $this.children('i').removeClass('fa fa-compress');
                                            $this.children('i').addClass('fa fa-expand');
                                        }
                                        $(this).closest('#tableView').toggleClass('panel-fullscreen');
                                    });
                                });

</script>