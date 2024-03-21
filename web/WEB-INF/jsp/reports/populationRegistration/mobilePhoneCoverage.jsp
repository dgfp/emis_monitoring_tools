<%-- 
    Document   : mobilePhoneCoverage
    Created on : Oct 1, 2017, 11:30:48 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/TemplateJs/Chart.bundle.js" type="text/javascript"></script>
<script src="resources/TemplateJs/chart/highcharts.js" type="text/javascript"></script>
<script src="resources/js/Chart.js" type="text/javascript"></script>
<style>
    #rightalign{
        text-align: right;
    }
    .numeric_field{
        text-align: right;
    }
    #presentationType { display: none; }
    #tableView { display: none; }
    #graphView { display: none; }
    #mapView { display: none; }
    #printTable{
        display: none;
    }
    .progress {
        background-color: #3A3A41!important;
    }
    .progress-bar-green, .progress-bar-success {
        background-color: #7CB5EC!important;
    }
</style>

<script>
    var type = ""; //report view tyope variables example: union wise
    var areaText = "";

    $(document).ready(function () {

        $("#areaDropDownPanel").slideDown("slow"); //Show area dropdowns panel by jquery slideDown
        var defaultStartDate = "01/01/2009"; //for default date
        var regExp = /(\d{1,2})\/(\d{1,2})\/(\d{2,4})/; //for date compare
        resetArea("District"); //Load District wise Area dropdown

        //Initilization of all data representer
        var tableHeader = $('#tableHeader');
        var tableBody = $('#tableBody');
        var tableFooter = $('#tableFooter');
        var tableHeaderP = $('#tableHeaderP');
        var tableBodyP = $('#tableBodyP');
        var tableFooterP = $('#tableFooterP');

        var dashboard = $('#dashboard');
        var chart = $('#chart');

//```````````````````````````````````````````````````````````````````````````````DATA EXPORT SYSTEM BEGIN`````````````````````````````````````````````````````````````````````                
//======Export chart as print-pdf        
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
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center"><center>Possession  of Mobile phone (for HH) - ' + type + ' wise</center></h3>');
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
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center!important;"><center>HID distribution coverage - ' + type + ' wise</center></h3>');
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

//======Export CSV using these function
        $("#exportText").click(function (event) {
            var outputFile = "eMIS_mobile_phone_coverage";
            outputFile = outputFile.replace('.txt', '') + '.txt';
            exportTableToText.apply(this, [$('#dvData > table'), outputFile]); //function call from TemplateHeader
        });
        $("#exportCSV").click(function (event) {
            var outputFile = "eMIS_mobile_phone_coverage ";
            outputFile = outputFile.replace('.csv', '') + '.csv';
            exportTableToCSV.apply(this, [$('#dvData > table'), outputFile]); //function call from TemplateHeader
        });
//=======END===========================================================================================================================

//```````````````````````````````````````````````````````````````````````````````END DATA EXPORT SYSTEM`````````````````````````````````````````````````````````````````````        


//======NID Report View type by button click===========================================================================================
        $('#mapViewByBtnClick').click(function () {
            $("#mapImg").attr("src", "resources/icon/map.png");
            $("#graphImg").attr("src", "resources/icon/graph.jpg");
            $("#tableImg").attr("src", "resources/icon/table.jpg");
            $("#mapImgBackground").removeClass("info-box-icon bg-gray").addClass("info-box-icon bg-aqua");
            $("#graphImgBackground").removeClass("info-box-icon bg-aqua").addClass("info-box-icon bg-gray");
            $("#tableImgBackground").removeClass("info-box-icon bg-aqua").addClass("info-box-icon bg-gray");
            //set selected color
            $("#mapViewByBtnClick").css("background-color", "#00ACD6");
            $("#graphViewByBtnClick").css("background-color", "#FFFFFF");
            $("#tableViewByBtnClick").css("background-color", "#FFFFFF");
            //Show hide - show type button
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
            //set selected color
            $("#mapViewByBtnClick").css("background-color", "#FFFFFF");
            $("#graphViewByBtnClick").css("background-color", "#00ACD6");
            $("#tableViewByBtnClick").css("background-color", "#FFFFFF");
            //Show hide - show type button
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
            //set selected color
            $("#mapViewByBtnClick").css("background-color", "#FFFFFF");
            $("#graphViewByBtnClick").css("background-color", "#FFFFFF");
            $("#tableViewByBtnClick").css("background-color", "#00ACD6");
            //Show hide - show type button
            document.getElementById('mapView').style.display = "none";
            document.getElementById('graphView').style.display = "none";
            $("#tableView").fadeIn("slow");
        });
//=======END==================================================================================================================

//======Mobile Coverage District Wise==============================================================================================
        $('#showDistrictPRS').click(function () {

            //reset all data presenter like Dashboard - chart - Table
            resetAllDataPresenter();

            //get parameters from dropdowns
            var divisionId = $("select#division1").val();
            var districtId = $("select#district1").val();
            var startDate = $("#startDate1").val() === "" ? defaultStartDate : $("#startDate1").val();
            var endDate = $("#endDate1").val();

            //Validation
            if (divisionId === "") {
                toastr["error"]("<h4><b>Please select Division</b></h4>");

            } else if (parseInt(startDate.replace(regExp, "$3$2$1")) > parseInt(endDate.replace(regExp, "$3$2$1"))) {
                toastr["error"]("<h4><b>Start date should be smaller than end date</b></h4>");

            } else {
                var btn = $(this).button('loading'); //Start show data button loading
                //Ajax with req with Pace loading
                Pace.track(function () {
                    $.ajax({
                        url: "MobilePhoneCoverage?action=mobileCoverageDistrict",
                        data: {
                            divisionId: divisionId,
                            districtId: districtId,
                            startDate: startDate,
                            endDate: endDate
                        },
                        type: 'POST',
                        success: function (result) {

                            var json = JSON.parse(result);
                            btn.button('reset');

                            if (json.length === 0) {
                                toastr["error"]("<h4><b>No Data Found</b></h4>");
                            } else {
                                //Show locations title when area panel is minimize
                                var division = "Division: <b style='color:#3C8DBC'>" + $("#division1 option:selected").text() + "</b>";
                                var district = " District: <b style='color:#3C8DBC'>" + $("#district1 option:selected").text() + "</b>";
                                var s = $("#startDate1").val() === "" ? "-" : $("#startDate1").val();
                                var sDate = "From: <b style='color:#3C8DBC'>" + s + "</b>";
                                var eDate = "To: <b style='color:#3C8DBC'>" + endDate + "</b>";
                                areaText = division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate;
                                $("#area").html(division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + sDate  + '&nbsp;&nbsp;' + eDate);

                                $('#collapseArea').click(); //minimize area panel
                                $('#presentationType').slideDown("slow"); //Show data presentation type buttons
                                $("#graphView").fadeIn("slow"); //Show graph initially

//==============================Chart View District wise
                                if (json.length == 1)
                                    $.chart.renderMobileChart(json, chart, 1,'pie');
                                else 
                                    $.chart.renderMobileChart(json, chart, 2,'bar');
//==============================End Chart

//==============================Table View District wise
                                //For Data table header
                                tableHeader.empty();
                                tableHeaderP.empty();
                                var header = "<tr>"
                                        + "<th style='vertical-align: text-top'>#</th>"
                                        + "<th style='vertical-align: text-top;'>DIstrict</th>"
                                        + "<th style='vertical-align: text-top' class='numeric_field'>Registered household</th>"
                                        + "<th style='vertical-align: text-top' class='numeric_field'>With mobile no (%)</th>"
                                        + "<th style='vertical-align: text-top' class='numeric_field'>Without mobile no (%)</th>"
                                        + "</tr>";
                                tableHeader.append(header);
                                tableHeaderP.append(header);

                                //For Data table body
                                var table = $('#data-table').DataTable();
                                table.destroy();
                                tableBody.empty();
                                tableBodyP.empty();
                                for (var i = 0; i < json.length; i++) {
                                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                            + "<td class='area'>" + json[i].zillanameeng + "</td>"
                                            + "<td class='numeric_field'>" + json[i].number_of_total_household + "</td>"
                                            + "<td class='numeric_field'>" + parseFloat((json[i].have_mobile_no / json[i].number_of_total_household * 100).toFixed(2)) + "</td>"
                                            + "<td class='numeric_field'>" + parseFloat(((json[i].number_of_total_household - json[i].have_mobile_no) / json[i].number_of_total_household * 100).toFixed(2)) + "</td>"
                                            + "</tr>";
                                    tableBody.append(parsedData);
                                    tableBodyP.append(parsedData);

                                }

                                //For Table bottom part and Dashboard
                                var cal = new Calc(json);
                                var avg_have_mobile = parseFloat((cal.sum.have_mobile_no / cal.sum.number_of_total_household * 100).toFixed(2));
                                var avg_dont_have_mobile = (100 - parseFloat((cal.sum.have_mobile_no / cal.sum.number_of_total_household * 100).toFixed(2))).toFixed(2);
                                var footerData = "<tr> <td style='text-align:left' colspan='2'>Total</td>"
                                        + "<td class='numeric_field'>" + cal.sum.number_of_total_household + "</td>"
                                        + "<td class='numeric_field'>" + avg_have_mobile + "</td>"
                                        + "<td class='numeric_field'>" + avg_dont_have_mobile + "</td>"
                                        + "</tr>";

                                tableFooter.empty();
                                tableFooterP.empty();
                                tableFooter.append(footerData);
                                tableFooterP.append(footerData);

                                //Make progress Dashboard
                                $('#dashboard').append(getDashboard(avg_have_mobile, avg_dont_have_mobile));
                                var table = $('#data-table').DataTable();
                                table.draw();

//==============================End Table
                            } //end else  - json.length === 0
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset'); //Stop show data button loading
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    });//End Ajax call for PRS type District
                }); //End Pace for PRS type District
            } //End Validation else
        });//End Show PRS type District
//======END===================================================================================================================

//======PRS Report Upazila Wise===============================================================================================
        $('#showUpazilaPRS').click(function () {
            //reset all data presenter like Dashboard - chart - Table
            resetAllDataPresenter();

            var divisionId = $("select#division2").val();
            var districtId = $("select#district2").val();
            var upazilaId = $("select#upazila2").val();
            var startDate = $("#startDate2").val() === "" ? defaultStartDate : $("#startDate2").val();
            var endDate = $("#endDate2").val();

            if (divisionId === "") {
                toastr["error"]("<h4><b>Please select Division</b></h4>");

            } else if (districtId === "") {
                toastr["error"]("<h4><b>Please select District</b></h4>");

            } else if (parseInt(startDate.replace(regExp, "$3$2$1")) > parseInt(endDate.replace(regExp, "$3$2$1"))) {
                toastr["error"]("<h4><b>Start date should be smaller than end date</b></h4>");

            } else {
                var btn = $(this).button('loading'); //Start show data button loading

                Pace.track(function () {
                    $.ajax({
                        url: "MobilePhoneCoverage?action=mobileCoverageUpazila",
                        data: {
                            divisionId: divisionId,
                            districtId: districtId,
                            upazilaId: upazilaId,
                            startDate: startDate,
                            endDate: endDate
                        },
                        type: 'POST',
                        success: function (result) {

                            var json = JSON.parse(result);
                            btn.button('reset');

                            if (json.length === 0) {
                                toastr["error"]("<h4><b>No Data Found</b></h4>");
                                return;
                            } else {
                                //Show location when area panle is minimize title
                                var division = "Division: <b style='color:#3C8DBC'>" + $("#division2 option:selected").text() + "</b>";
                                var district = " District: <b style='color:#3C8DBC'>" + $("#district2 option:selected").text() + "</b>";
                                var upazila = " Upazila: <b style='color:#3C8DBC'>" + $("#upazila2 option:selected").text() + "</b>";
                                var s = $("#startDate2").val() === "" ? "-" : $("#startDate2").val();
                                var sDate = "From: <b style='color:#3C8DBC'>" + s + "</b>";
                                var eDate = "To: <b style='color:#3C8DBC'>" + endDate + "</b>";
                                areaText = division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate;
                                $("#area").html(division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + sDate  + '&nbsp;&nbsp;' + eDate);

                                $('#collapseArea').click(); //minimze area panel
                                $('#presentationType').slideDown("slow"); //Show data presentation type buttons
                                $("#graphView").fadeIn("slow"); //Show TAble initially

                                //<-Chart-> Upazila wise========================
                                if (json.length == 1)
                                    $.chart.renderMobileChart(json, chart, 1,'pie');
                                else
                                    $.chart.renderMobileChart(json, chart, 2,'bar');
                                //End <-Chart->===============================

                                //<-Table-> Upazila wise========================
                                //For Data table header
                                tableHeader.empty();
                                tableHeaderP.empty();
                                var header = "<tr>"
                                        + "<th style='vertical-align: text-top'>#</th>"
                                        + "<th style='vertical-align: text-top;'>Upazila</th>"
                                        + "<th style='vertical-align: text-top' class='numeric_field'>Registered household</th>"
                                        + "<th style='vertical-align: text-top' class='numeric_field'>With mobile no (%)</th>"
                                        + "<th style='vertical-align: text-top' class='numeric_field'>Without mobile no (%)</th>"
                                        + "</tr>";
                                tableHeader.append(header);
                                tableHeaderP.append(header);

                                //For Data table body
                                var table = $('#data-table').DataTable();
                                table.destroy();
                                tableBody.empty();
                                tableBodyP.empty();
                                for (var i = 0; i < json.length; i++) {
                                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                            + "<td class='area'>" + json[i].upazilanameeng + "</td>"
                                            + "<td class='numeric_field'>" + json[i].number_of_total_household + "</td>"
                                            + "<td class='numeric_field'>" + parseFloat((json[i].have_mobile_no / json[i].number_of_total_household * 100).toFixed(2)) + "</td>"
                                            + "<td class='numeric_field'>" + parseFloat(((json[i].number_of_total_household - json[i].have_mobile_no) / json[i].number_of_total_household * 100).toFixed(2)) + "</td>"
                                            + "</tr>";
                                    tableBody.append(parsedData);
                                    tableBodyP.append(parsedData);
                                }

                                //For Table bottom part and Dashboard
                                var cal = new Calc(json);
                                var avg_have_mobile = parseFloat((cal.sum.have_mobile_no / cal.sum.number_of_total_household * 100).toFixed(2));
                                var avg_dont_have_mobile = (100 - parseFloat((cal.sum.have_mobile_no / cal.sum.number_of_total_household * 100).toFixed(2))).toFixed(2);
                                var footerData = "<tr> <td style='text-align:left' colspan='2'>Total</td>"
                                        + "<td class='numeric_field'>" + cal.sum.number_of_total_household + "</td>"
                                        + "<td class='numeric_field'>" + avg_have_mobile + "</td>"
                                        + "<td class='numeric_field'>" + avg_dont_have_mobile + "</td>"
                                        + "</tr>";

                                tableFooter.empty();
                                tableFooterP.empty();
                                tableFooter.append(footerData);
                                tableFooterP.append(footerData);
                                //Dashboard
                                $('#dashboard').append(getDashboard(avg_have_mobile, avg_dont_have_mobile));
                                var table = $('#data-table').DataTable();
                                table.draw();
                                //End <-Table->=================================

                            } //End else - json.length === 0
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset'); //Stop show data button loading
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    }); //End Ajax call for PRS type Upazila
                }); //End Pace for PRS type Upazila
            }
        }); //End Show PRS type Upazila=========================================
//======END===========================================================================================================================


//======PRS Report Union Wise=========================================================================================================
        $('#showUnionPRS').click(function () {
            //reset all data presenter like Dashboard - chart - Table
            resetAllDataPresenter();

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

            } else if (parseInt(startDate.replace(regExp, "$3$2$1")) > parseInt(endDate.replace(regExp, "$3$2$1"))) {
                toastr["error"]("<h4><b>Start date should be smaller than end date</b></h4>");

            } else {
                var btn = $(this).button('loading'); //Start show data button loading

                Pace.track(function () {
                    $.ajax({
                        url: "MobilePhoneCoverage?action=mobileCoverageUnion",
                        data: {
                            divisionId: divisionId,
                            districtId: districtId,
                            upazilaId: upazilaId,
                            unionId: unionId,
                            startDate: startDate,
                            endDate: endDate
                        },
                        type: 'POST',
                        success: function (result) {
                            var json = JSON.parse(result);
                            btn.button('reset');

                            if (json.length === 0) {
                                toastr["error"]("<h4><b>No Data Found</b></h4>");
                                return;
                            } else {

                                //Show location when area panle is minimize title
                                var division = "Division: <b style='color:#3C8DBC'>" + $("#division3 option:selected").text() + "</b>";
                                var district = " District: <b style='color:#3C8DBC'>" + $("#district3 option:selected").text() + "</b>";
                                var upazila = " Upazila: <b style='color:#3C8DBC'>" + $("#upazila3 option:selected").text() + "</b>";
                                var union = " Union: <b style='color:#3C8DBC'>" + $("#union3 option:selected").text() + "</b>";
                                var s = $("#startDate3").val() === "" ? "-" : $("#startDate3").val();
                                var sDate = "From: <b style='color:#3C8DBC'>" + s + "</b>";
                                var eDate = "To: <b style='color:#3C8DBC'>" + endDate + "</b>";
                                areaText = division + ' ' + district + ' ' + upazila + ' ' + union + ' ' + sDate + ' ' + eDate; //for 
                                $("#area").html(division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + union + ',&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate);


                                $('#collapseArea').click(); //minimze area panel
                                $('#presentationType').slideDown("slow"); //Show data presentation type buttons
                                $("#graphView").fadeIn("slow"); //Show Table Data initially

                                //<-Chart-> Union wise==========================
                                if (json.length == 1) {
                                    $.chart.renderMobileChart(json, chart, 1,'pie');
                                } else {
                                    $.chart.renderMobileChart(json, chart, 2,'bar');
                                }
                                //End <-Chart->===============================

                                //<-Table-> Union wise==========================
                                //
                                //For Data table header
                                tableHeader.empty();
                                tableHeaderP.empty();
                                var header = "<tr>"
                                        + "<th style='vertical-align: text-top'>#</th>"
                                        + "<th style='vertical-align: text-top;'>Union</th>"
                                        + "<th style='vertical-align: text-top' class='numeric_field'>Registered household</th>"
                                        + "<th style='vertical-align: text-top' class='numeric_field'>With mobile no (%)</th>"
                                        + "<th style='vertical-align: text-top' class='numeric_field'>Without mobile no (%)</th>"
                                        + "</tr>";
                                tableHeader.append(header);
                                tableHeaderP.append(header);

                                //Variables for bottom part

                                //For Data table body
                                var table = $('#data-table').DataTable();
                                table.destroy();
                                tableBody.empty();
                                tableBodyP.empty();
                                for (var i = 0; i < json.length; i++) {
                                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                            + "<td class='area'>" + json[i].unionnameeng + "</td>"
                                            + "<td class='numeric_field'>" + json[i].number_of_total_household + "</td>"
                                            + "<td class='numeric_field'>" + parseFloat((json[i].have_mobile_no / json[i].number_of_total_household * 100).toFixed(2)) + "</td>"
                                            + "<td class='numeric_field'>" + parseFloat(((json[i].number_of_total_household - json[i].have_mobile_no) / json[i].number_of_total_household * 100).toFixed(2)) + "</td>"
                                            + "</tr>";
                                    tableBody.append(parsedData);
                                    tableBodyP.append(parsedData);
                                }

                                //For Table bottom part and Dashboard
                                var cal = new Calc(json);
                                var avg_have_mobile = parseFloat((cal.sum.have_mobile_no / cal.sum.number_of_total_household * 100).toFixed(2));
                                var avg_dont_have_mobile = (100 - parseFloat((cal.sum.have_mobile_no / cal.sum.number_of_total_household * 100).toFixed(2))).toFixed(2);
                                var footerData = "<tr> <td style='text-align:left' colspan='2'>Total</td>"
                                        + "<td class='numeric_field'>" + cal.sum.number_of_total_household + "</td>"
                                        + "<td class='numeric_field'>" + avg_have_mobile + "</td>"
                                        + "<td class='numeric_field'>" + avg_dont_have_mobile + "</td>"
                                        + "</tr>";

                                tableFooter.empty();
                                tableFooterP.empty();
                                tableFooter.append(footerData);
                                tableFooterP.append(footerData);
                                //Dashboard
                                //$('#dashboard').append(getDashboard(avg_have_mobile,avg_dont_have_mobile));
                                $('#dashboard').append(getDashboard(avg_have_mobile, avg_dont_have_mobile));
                                var table = $('#data-table').DataTable();
                                table.draw();
                                //End <-Table->=================================

                            }//end else  - json.length === 0 
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset'); //Stop show data button loading
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    }); //End Ajax call for PRS type Union
                }); //End Pace for PRS type Union
            } //End validation else           
        }); //End Show PRS type Union===========================================
//======END===========================================================================================================================

//======Others funtions================================================================================================================
//======Reset all - Dashboard - Data view type buttons - graph - map - table
        function resetAllDataPresenter() {
            tableHeader.empty();
            tableBody.empty();
            tableFooter.empty();
            dashboard.empty();
            chart.empty();
            document.getElementById('transparentTextForBlank').style.display = "none";
            document.getElementById('presentationType').style.display = "none";
            document.getElementById('mapView').style.display = "none";
            document.getElementById('tableView').style.display = "none";
            document.getElementById('graphView').style.display = "none";

            $("#mapViewByBtnClick").css("background-color", "#FFFFFF");
            $("#graphViewByBtnClick").css("background-color", "#00ACD6");
            $("#tableViewByBtnClick").css("background-color", "#FFFFFF");
        }

//======Make and set Dashboar for PRS
        function getDashboard(have_mobileno, do_not_have_mobileno) {
            return '<div class="col-sm-12 no-margin">'
                    + '<div class="clearfix">'
                    + ' <b class="pull-left">With mobile no (%): ' + have_mobileno + ' %</b>'
                    + '<b class="pull-right">Without mobile no (%): ' + do_not_have_mobileno + ' %</b>'
                    + '</div>'
                    + '<div class="progress progress-md active">'
                    + '<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: ' + have_mobileno + '%">'
                    + '<span class="sr-only">20% Complete</span>'
                    + '</div>'
                    + '</div>'
                    + '</div>';
        }
    });
</script>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>Possession  of Mobile phone<small></small></h1>
</section>

<!-- Main content -->
<section class="content">

    <!------------------------------Load area dropdowns panel----------------------------------->
    <%@include file="/WEB-INF/jspf/prsArea2.jspf" %>

    <!------------------------------Load progress percentage Dashboard Data----------------------------------->
    <div class="row" id="dashboard">
    </div>

    <!------------------------------Load Data Presentation Type panel----------------------------------->
    <%@include file="/WEB-INF/jspf/prsDataPresentationType.jspf" %>


    <!--PRS Data Map-->
    <div class="box box-primary" id="mapView">
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


    <!--PRS Data Chart-->
    <div class="box box-primary full-screen" id="graphView">
        <div class="box-header with-border">
            <h3 class="box-title"><b></b>Graphical Presentation</h3>
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


    <!--PRS Data Table-->
    <div class="box box-primary full-screen" id="tableView">
        <div class="box-header with-border">
            <h3 class="box-title"><b></b>Tabular Presentation</h3>
            <div class="box-tools pull-right" style="margin-top: 0px;">
                <button id="printTableBtn" type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <a href="#" id ="exportCSV" role='button' class="btn btn-box-tool"><i class="fa fa-file-excel-o" aria-hidden="true"></i>&nbsp;CSV</a>
                <a href="#" id ="exportText" role='button' class="btn btn-box-tool"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Text</a>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>

        <div class="box-body">
            <!--Data Table-->               
            <div class="col-ld-12" id="">
                <div class="table-responsive fixed" >
                    <div id="dvData">
                        <table class="table table-bordered table-striped table-hover" id="data-table">

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
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script src="resources/js/prsDropDowns.js" type="text/javascript"></script>