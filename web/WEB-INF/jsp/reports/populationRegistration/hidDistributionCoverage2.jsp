<%-- 
    Document   : prs_progress
    Created on : Dec 28, 2016, 9:49:35 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/TemplateJs/Chart.bundle.js" type="text/javascript"></script>
<script src="resources/TemplateJs/chart/highcharts.js" type="text/javascript"></script>
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
    /*    .table>tbody>tr>td{
            height:30px;
            padding:0px;
            border-top: 0px;
          }*/
    #printTable{
        display: none;
    }
</style>

<script>
    var type = ""; //report view tyope variables example: union wise
    var areaText = "";

    $(document).ready(function () {

        $("#areaDropDownPanel").slideDown("slow"); //Show area dropdowns panel by jquery slideDown
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
//======PRS export data (Chart)===============================================================================================
//======Export chart as image printChartBtn
        $('#imgChartBtn').click(function () {
            var c = document.getElementById('chart');
            var t = c.getContext('2d');
            window.location.href = image;

            window.open('', document.getElementById('mycanvas').toDataURL());
        });

//======Export chart as print-pdf printChartBtn        
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
                frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center"><center>HID distribution coverage - ' + type + ' wise</center></h3>');
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

//======PRS export data (Table)===============================================================================================
//======Print Data
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
            frameDoc.document.write('<style>table, th, td{border:1px solid black; border-collapse: collapse;padding:10px;}th{vertical-align: text-center} td{text-align:right;}</style>');
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
            var outputFile = "eMIS_HID_distribution_coverage";
            outputFile = outputFile.replace('.txt', '') + '.txt';
            exportTableToText.apply(this, [$('#dvData > table'), outputFile]); //function call from TemplateHeader
        });
        $("#exportCSV").click(function (event) {
            var outputFile = "eMIS_HID_distribution_coverage ";
            outputFile = outputFile.replace('.csv', '') + '.csv';
            exportTableToCSV.apply(this, [$('#dvData > table'), outputFile]); //function call from TemplateHeader
        });
//=======END===========================================================================================================================

//```````````````````````````````````````````````````````````````````````````````END DATA EXPORT SYSTEM`````````````````````````````````````````````````````````````````````        




//======PRS Report View type by button click===========================================================================================
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

//======PRS Report District Wise==============================================================================================
        $('#showDistrictPRS').click(function () {

            //reset all data presenter like Dashboard - chart - Table
            resetAllDataPresenter();

            //get parameters from dropdowns
            var divisionId = $("select#division1").val();
            var districtId = $("select#district1").val();
            var startDate = $("#startDate1").val();
            var endDate = $("#endDate1").val();


            //Validation
            if (divisionId === "") {
                toastr["error"]("<h4><b>Please select Division</b></h4>");

            } else if (parseInt(startDate.replace(regExp, "$3$2$1")) > parseInt(endDate.replace(regExp, "$3$2$1"))) {
                toastr["error"]("<h4><b>Start date should be smaller than end date</b></h4>");

            } else {
                var btn = $(this).button('loading'); //Start show data button loading
                //Ajax with req with Pace loading
                console.log(districtId);
                Pace.track(function () {
                    $.ajax({
                        url: "HIDDistributionCoverage?action=HIDDistrict",
                        data: {
                            divisionId: divisionId,
                            districtId: districtId,
                            startDate: startDate,
                            endDate: endDate
                        },
                        type: 'POST',
                        success: function (result) {

                            var json = JSON.parse(result);

                            if (json.length === 0) {
                                toastr["error"]("<h4><b>No Data Found</b></h4>");
                            } else {
                                //Show locations title when area panel is minimize
                                var division = "Division: <b style='color:#3C8DBC'>" + $("#division1 option:selected").text() + "</b>";
                                var district = " District: <b style='color:#3C8DBC'>" + $("#district1 option:selected").text() + "</b>";
                                var sDate = "From: <b style='color:#3C8DBC'>" + startDate + "</b>";
                                var eDate = "To: <b style='color:#3C8DBC'>" + endDate + "</b>";
                                areaText = division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate;
                                $("#area").html(division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate);

                                $('#collapseArea').click(); //minimize area panel
                                $('#presentationType').slideDown("slow"); //Show data presentation type buttons
                                $("#graphView").fadeIn("slow"); //Show graph initially

//==============================Chart View District wise
                                $.chart.renderHIDBarChart(json,chart,1);
//==============================End Chart

//==============================Table View District wise
                                //For Data table header
                                tableHeader.empty();
                                tableHeaderP.empty();
                                var header = '<tr id="tableRow">'
                                        + '<th colspan="2"></th>'
                                        + '<th colspan="4">Household</th>'
                                        + '<th colspan="2">Population</th>'
                                        + '</tr>'
                                        + '<tr id="tableRow">'
                                        + '<th>#</th>'
                                        + '<th>District</th>'
                                        + '<th class="numeric_field">Registered household</th>'
                                        + '<th class="numeric_field">HHs received HIDs for all members (%)</th>'
                                        + '<th class="numeric_field">HH received HIDs but not all members (%)</th>'
                                        + '<th class="numeric_field">HH not received any HID yet (%)</th>'
                                        + '<th class="numeric_field">Registered population (n)</th>'
                                        + '<th class="numeric_field">Population not received HIDs (%)</th>'
                                        + '</tr>';
                                tableHeader.append(header);
                                tableHeaderP.append(header);

                                //For Data table body
                                var table = $('#data-table').DataTable();
                                table.destroy();
                                tableBody.empty();
                                tableBodyP.empty();
                                for (var i = 0; i < json.length; i++) {
                                    var parsedData = "<tr id='tableRow'><td>" + (i + 1) + "</td>"
                                            + "<td>" + json[i].zillanameeng + "</td>"
                                            + "<td class='numeric_field'>" + json[i].registered_household_1 + "</td>"
                                            + "<td class='numeric_field'>" + (json[i].hh_received_hids_for_all_members_pecentage_2).toFixed(2) + "</td>"
                                            + "<td class='numeric_field'>" + (json[i].hh_received_hid_but_not_all_members_partial_percentage_3).toFixed(2) + "</td>"
                                            + "<td class='numeric_field'>" + (json[i].hh_not_received_any_hid_yet_percentage_4).toFixed(2) + "</td>"

                                            + "<td class='numeric_field'>" + json[i].registered_member_5 + "</td>"
                                            + "<td class='numeric_field'>" + (100 - (json[i].population_received_hid_pecentage_6)).toFixed(2) + "</td>"
                                            + "</tr>";
                                    tableBody.append(parsedData);
                                    tableBodyP.append(parsedData);
                                }

                                var cal = new Calc(json);
                                //For Table bottom part and Dashboard
                                var footerData = "<tr id='tableRow'> <td style='text-align:left' colspan='2'>Total</td>"
                                        + "<td class='numeric_field'>" + cal.sum.registered_household_1 + "</td>"
                                        + "<td class='numeric_field'>" + finiteFilter(cal.avg('hh_received_hids_for_all_members_pecentage_2')).toFixed(2) + "</td>"
                                        + "<td class='numeric_field'>" + finiteFilter(cal.avg('hh_received_hid_but_not_all_members_partial_percentage_3')).toFixed(2) + "</td>"
                                        + "<td class='numeric_field'>" + finiteFilter(cal.avg('hh_not_received_any_hid_yet_percentage_4')).toFixed(2) + "</td>"
                                        + "<td class='numeric_field'>" + cal.sum.registered_member_5 + "</td>"
                                        + "<td class='numeric_field'>" + finiteFilter(100 - cal.avg('population_received_hid_pecentage_6')).toFixed(2) + "</td>"
                                        + "</tr>";

                                tableFooter.empty();
                                tableFooterP.empty();
                                tableFooter.append(footerData);
                                tableFooterP.append(footerData);

                                //Make progress Dashboard
                                //$('#dashboard').append(getDashboard(Math.round((completed_hh_sum / total_hh_sum) * 100), Math.round((completed_pop_sum / total_pop_sum) * 100)));
                                var table = $('#data-table').DataTable();
                                table.draw();

//==============================End Table
                            } //end else  - json.length === 0

                            btn.button('reset'); //Stop show data button loading
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
            var startDate = $("#startDate2").val();
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
                        url: "HIDDistributionCoverage?action=HIDUpazila",
                        data: {
                            divisionId: divisionId,
                            districtId: districtId,
                            upazilaId: upazilaId,
                            startDate: startDate,
                            endDate: endDate
                        },
                        type: 'POST',
                        success: function (result) {
                            btn.button('reset');
                            var json = JSON.parse(result);

                            if (json.length === 0) {
                                btn.button('reset');
                                toastr["error"]("<h4><b>No Data Found</b></h4>");
                            } else {
                                //Show location when area panle is minimize title
                                var division = "Division: <b style='color:#3C8DBC'>" + $("#division2 option:selected").text() + "</b>";
                                var district = " District: <b style='color:#3C8DBC'>" + $("#district2 option:selected").text() + "</b>";
                                var upazila = " Upazila: <b style='color:#3C8DBC'>" + $("#upazila2 option:selected").text() + "</b>";
                                var sDate = "From: <b style='color:#3C8DBC'>" + startDate + "</b>";
                                var eDate = "To: <b style='color:#3C8DBC'>" + endDate + "</b>";
                                areaText = division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate;
                                $("#area").html(division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate);

                                $('#collapseArea').click(); //minimze area panel
                                $('#presentationType').slideDown("slow"); //Show data presentation type buttons
                                $("#graphView").fadeIn("slow"); //Show TAble initially

                                //<-Chart-> Upazila wise========================
                                $.chart.renderHIDBarChart(json,chart,2);
                                //End <-Chart->=================================

                                //<-Table-> Upazila wise========================
                                //For Data table header
                                tableHeader.empty();
                                tableHeaderP.empty();
                                var header = '<tr id="tableRow">'
                                        + '<th colspan="2"></th>'
                                        + '<th colspan="4">Household</th>'
                                        + '<th colspan="2">Population</th>'
                                        + '</tr>'
                                        + '<tr id="tableRow">'
                                        + '<th>#</th>'
                                        + '<th>Upazila</th>'
                                        + '<th class="numeric_field">Registered household</th>'
                                        + '<th class="numeric_field">HHs received HIDs for all members (%)</th>'
                                        + '<th class="numeric_field">HH received HIDs but not all members (%)</th>'
                                        + '<th class="numeric_field">HH not received any HID yet (%)</th>'
                                        + '<th class="numeric_field">Registered population (n)</th>'
                                        + '<th class="numeric_field">Population not received HIDs (%)</th>'
                                        + '</tr>';
                                tableHeader.append(header);
                                tableHeaderP.append(header);

                                //For Data table body
                                var table = $('#data-table').DataTable();
                                table.destroy();
                                tableBody.empty();
                                tableBodyP.empty();
                                for (var i = 0; i < json.length; i++) {
                                    var row = json[i];
                                    var parsedData = "<tr id='tableRow'><td>" + (i + 1) + "</td>"
                                            + "<td>" + json[i].upazilanameeng + "</td>"
                                            + "<td class='numeric_field'>" + row.registered_household_1+ "</td>"
                                            + "<td class='numeric_field'>" + (row.hh_received_hids_for_all_members_pecentage_2).toFixed(2) + "</td>"
                                            + "<td class='numeric_field'>" + (row.hh_received_hid_but_not_all_members_partial_percentage_3).toFixed(2) + "</td>"
                                            + "<td class='numeric_field'>" + (row.hh_not_received_any_hid_yet_percentage_4).toFixed(2) + "</td>"

                                            + "<td class='numeric_field'>" + row.registered_member_5 + "</td>"
                                            + "<td class='numeric_field'>" + (100 - (row.population_received_hid_pecentage_6)).toFixed(2) + "</td>"
                                            + "</tr>";
                                    tableBody.append(parsedData);
                                    tableBodyP.append(parsedData);
                                }

                                var cal = new Calc(json);
                                //For Table bottom part and Dashboard
                                var footerData = "<tr id='tableRow'> <td style='text-align:left' colspan='2'>Total</td>"
                                        + "<td class='numeric_field'>" + cal.sum.registered_household_1 + "</td>"
                                        + "<td class='numeric_field'>" + finiteFilter(cal.avg('hh_received_hids_for_all_members_pecentage_2')).toFixed(2) + "</td>"
                                        + "<td class='numeric_field'>" + finiteFilter(cal.avg('hh_received_hid_but_not_all_members_partial_percentage_3')).toFixed(2) + "</td>"
                                        + "<td class='numeric_field'>" + finiteFilter(cal.avg('hh_not_received_any_hid_yet_percentage_4')).toFixed(2) + "</td>"
                                        + "<td class='numeric_field'>" + cal.sum.registered_member_5 + "</td>"
                                        + "<td class='numeric_field'>" + finiteFilter(100 - cal.avg('population_received_hid_pecentage_6')).toFixed(2) + "</td>"
                                        + "</tr>";

                                tableFooter.empty();
                                tableFooterP.empty();
                                tableFooter.append(footerData);
                                tableFooterP.append(footerData);
                                //Dashboard
                                //$('#dashboard').append(getDashboard(Math.round((completed_hh_sum / total_hh_sum) * 100), Math.round((completed_pop_sum / total_pop_sum) * 100)));
                                var table = $('#data-table').DataTable();
                                table.draw();
                                //End <-Table->=================================

                            } //End else - json.length === 0

                            btn.button('reset'); //Stop show data button loading
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
            var startDate = $("#startDate3").val();
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
                        url: "HIDDistributionCoverage?action=HIDUnion",
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
                            btn.button('reset');
                            var json = JSON.parse(result);

                            if (json.length === 0) {
                                btn.button('reset');
                                toastr["error"]("<h4><b>No Data Found</b></h4>");
                            } else {

                                //Show location when area panle is minimize title
                                var division = "Division: <b style='color:#3C8DBC'>" + $("#division3 option:selected").text() + "</b>";
                                var district = " District: <b style='color:#3C8DBC'>" + $("#district3 option:selected").text() + "</b>";
                                var upazila = " Upazila: <b style='color:#3C8DBC'>" + $("#upazila3 option:selected").text() + "</b>";
                                var union = " Union: <b style='color:#3C8DBC'>" + $("#union3 option:selected").text() + "</b>";
                                var sDate = "From: <b style='color:#3C8DBC'>" + startDate + "</b>";
                                var eDate = "To: <b style='color:#3C8DBC'>" + endDate + "</b>";
                                areaText = division + ' ' + district + ' ' + upazila + ' ' + union + ' ' + sDate + ' ' + eDate; //for 
                                $("#area").html(division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + union + ',&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate);


                                $('#collapseArea').click(); //minimze area panel
                                $('#presentationType').slideDown("slow"); //Show data presentation type buttons
                                $("#graphView").fadeIn("slow"); //Show Table Data initially

                                //<-Chart-> Upazila wise========================
                                $.chart.renderHIDBarChart(json,chart,3);
                                //End <-Chart->=================================

                                //<-Table-> Union wise============================
                                //
                                //For Data table header
                                tableHeader.empty();
                                tableHeaderP.empty();
                                var header = '<tr id="tableRow">'
                                        + '<th colspan="2"></th>'
                                        + '<th colspan="4">Household</th>'
                                        + '<th colspan="2">Population</th>'
                                        + '</tr>'
                                        + '<tr id="tableRow">'
                                        + '<th>#</th>'
                                        + '<th>Union</th>'
                                        + '<th class="numeric_field">Registered household</th>'
                                        + '<th class="numeric_field">HHs received HIDs for all members (%)</th>'
                                        + '<th class="numeric_field">HH received HIDs but not all members (%)</th>'
                                        + '<th class="numeric_field">HH not received any HID yet (%)</th>'
                                        + '<th class="numeric_field">Registered population (n)</th>'
                                        + '<th class="numeric_field">Population not received HIDs (%)</th>'
                                        + '</tr>';
                                tableHeader.append(header);
                                tableHeaderP.append(header);

                                //For Data table body
                                var table = $('#data-table').DataTable();
                                table.destroy();
                                tableBody.empty();
                                tableBodyP.empty();
                                for (var i = 0; i < json.length; i++) {
                                    var row = json[i];
                                    var parsedData = "<tr id='tableRow'><td>" + (i + 1) + "</td>"
                                    +"<td>" + row.unionnameeng + "</td>"
                                            + "<td class='numeric_field'>" + row.registered_household_1 + "</td>"
                                            + "<td class='numeric_field'>" + (row.hh_received_hids_for_all_members_pecentage_2).toFixed(2) + "</td>"
                                            + "<td class='numeric_field'>" + (row.hh_received_hid_but_not_all_members_partial_percentage_3).toFixed(2) + "</td>"
                                            + "<td class='numeric_field'>" + (row.hh_not_received_any_hid_yet_percentage_4).toFixed(2) + "</td>"

                                            + "<td class='numeric_field'>" + row.registered_member_5 + "</td>"
                                            + "<td class='numeric_field'>" + (100 - (row.population_received_hid_pecentage_6)).toFixed(2) + "</td>"
                                            + "</tr>";
                                    tableBody.append(parsedData);
                                    tableBodyP.append(parsedData);

                                }

                                var cal = new Calc(json);
                                //For Table bottom part and Dashboard
                                var footerData = "<tr id='tableRow'> <td style='text-align:left' colspan='2'>Total</td>"
                                        + "<td class='numeric_field'>" + cal.sum.registered_household_1 + "</td>"
                                        + "<td class='numeric_field'>" + finiteFilter(cal.avg('hh_received_hids_for_all_members_pecentage_2')).toFixed(2) + "</td>"
                                        + "<td class='numeric_field'>" + finiteFilter(cal.avg('hh_received_hid_but_not_all_members_partial_percentage_3')).toFixed(2) + "</td>"
                                        + "<td class='numeric_field'>" + finiteFilter(cal.avg('hh_not_received_any_hid_yet_percentage_4')).toFixed(2) + "</td>"
                                        + "<td class='numeric_field'>" + cal.sum.registered_member_5 + "</td>"
                                        + "<td class='numeric_field'>" + finiteFilter(100 - cal.avg('population_received_hid_pecentage_6')).toFixed(2) + "</td>"
                                        + "</tr>";

                                tableFooter.empty();
                                tableFooterP.empty();
                                tableFooter.append(footerData);
                                tableFooterP.append(footerData);

                                //Dashboard
                                //$('#dashboard').append(getDashboard(Math.round((completed_hh_sum / total_hh_sum) * 100), Math.round((completed_pop_sum / total_pop_sum) * 100)));
                                var table = $('#data-table').DataTable();
                                table.draw();
                                //End <-Table->=================================

                            }//end else  - json.length === 0 

                            btn.button('reset'); //Stop show data button loading
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
        function getDashboard(household, population) {
            return '<div class="col-lg-6 col-xs-6">'
                    + '<div class="small-box bg-aqua">'
                    + '<div class="inner">'
                    + '<h3>' + household + ' %</h3>'
                    + '<h4>Household Registered</h4>'
                    + '</div>'
                    + '<div class="icon">'
                    + '<i class="fa fa-home" aria-hidden="true"></i>'
                    + '</div>'
                    + '<sapn class="small-box-footer"></sapn>'
                    + '</div>'
                    + '</div>'
                    + '<div class="col-lg-6 col-xs-6">'
                    + '<div class="small-box bg-green">'
                    + '<div class="inner">'
                    + '<h3>' + population + ' %</h3>'
                    + '<h4>Population Registered</h4>'
                    + '</div>'
                    + '<div class="icon">'
                    + '<i class="fa fa-users" aria-hidden="true"></i>'
                    + '</div>'
                    + '<sapn class="small-box-footer"></sapn>'
                    + '</div>'
                    + '</div>';
        }
    });
</script>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>HID Card distribution coverage<small></small></h1>
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
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                <button id="closeGraph" type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
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
    <div class="box box-primary" id="graphView">
        <div class="box-header with-border">
            <h3 class="box-title"><b></b>Graphical Presentation</h3>
            <div class="box-tools pull-right" style="margin-top: 0px;">
                <button id="printChartBtn" type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <!--                <button type="button" id="imgChartBtn" class="btn btn-box-tool"><i class="fa fa-file-pdf-o" aria-hidden="true"></i>&nbsp;PDF</button>-->
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                <button id="closeGraph" type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
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
    <div class="box box-primary" id="tableView">
        <div class="box-header with-border">
            <h3 class="box-title"><b></b>Tabular Presentation</h3>
            <div class="box-tools pull-right" style="margin-top: 0px;">
                <button id="printTableBtn" type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <a href="#" id ="exportCSV" role='button' class="btn btn-box-tool"><i class="fa fa-file-excel-o" aria-hidden="true"></i>&nbsp;CSV</a>
                <a href="#" id ="exportText" role='button' class="btn btn-box-tool"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Text</a>
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
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