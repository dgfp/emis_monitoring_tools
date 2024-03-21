<%-- 
    Document   : sync
    Created on : Jun 2, 2017, 7:44:09 PM
    Author     : Helal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>eMIS</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="resources/logo/rhis_favicon.png">
        <link href="resources/TemplateCSS/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/style.css" rel="stylesheet" type="text/css"/>
        <script src="resources/jquery/jquery.min.js"></script>
        <script src="resources/TemplateJs/toastr.js" type="text/javascript"></script>
        <link href="resources/TemplateCSS/toastr.css" rel="stylesheet" type="text/css"/>
        <script src="resources/js/$.app.js" type="text/javascript"></script>

        <!-- 
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        -->
        <script>
            var jsonData;
            $(document).ready(function () {

                var response = $('#response');
                var tableHead = $('#thead');
                var tableBody = $('#tbody');
                response.prepend('<b id="emis">eMIS</b>');


                $("button").click(function () {
                    tableBody.empty();
                    $('#providerInfo').empty();
                    var providerID = $('#providerID').val();
                    if (providerID === null || providerID === "") {
                        alert("Please enter provider id");
                    } else {
                        response.empty();
                        response.prepend('<img src="resources/images/loader.gif" alt=""/>');
                        $('.table').hide();
                        $.ajax({
                            url: "uploadChecker",
                            data: {
                                providerId: providerID
                            },
                            type: 'POST',
                            success: function (result) {
                                var json = JSON.parse(result);
                                jsonData = json;
                                setTable(json);

                                //                              setTimeout(function() {
                                //                                setTable(json);
                                //                              }, 1000);

                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert("Request can't be processed");
                            }
                        });//Ajax end
                    }


                });


                function setTable(json) {
                    response.empty();

                    if (json.length === 0) {
                        response.empty();
                        response.prepend('<b id="emis">Invalid Provider ID</b>');
                    } else {
                        json[0].zillaid == 'undefined' ? '-' : json[0].zillaid;
                        json[0].zillaid == undefined ? '-' : json[0].zillaid;
                        json[0].zillaid == null ? '-' : json[0].zillaid;
                        json[0].zillaid == 'null' ? '-' : json[0].zillaid;
                        json[0].zillaid == '' ? '-' : json[0].zillaid;

                        var providerHeader = '<li class="nav-item">'
                                + '<p class="nav-link" href="#">Provider ID : <b>' + json[0].providerid + '</b></p>'
                                + '</li>'
                                + '<li class="nav-item">'
                                + '<p class="nav-link" href="#">Provider Name : <b>' + json[0].provider_name + '</b></p>'
                                + '</li>'
                                + '<li class="nav-item">'
                                + '<p class="nav-link" href="#">Provider Type : <b>' + json[0].provtype + '</b></p>'
                                + '</li>'
                                + '<li class="nav-item">'
                                + '<p class="nav-link" href="#">Zilla ID : <b>' + json[0].zillaid + '</b></p>'
                                + '</li>'
                                + '<li class="nav-item">'
                                + '<p class="nav-link" href="#">Upazila ID : <b>' + json[0].upazilaid + '</b></p>'
                                + '</li>'
                                + '<li class="nav-item">'
                                + '<p class="nav-link" href="#">Union ID : <b>' + json[0].unionid + '</b></p>'
                                + '</li>'
                                + '<li class="nav-item">'
                                + '<p class="nav-link" href="#">Mobile : <b>' + json[0].mobile + '</b></p>'
                                + '</li>';

                        $('#providerInfo').append(providerHeader);

                        for (var i = 0; i < json.length; i++) {
                            //var info=json[i].before_after;
                            //var a=info.substring(18, info.length);
                            var tableData = null;

                            $("#hightlightImuHis").addClass("hightlight");
                            $("#hightlightPregWo").addClass("hightlight");
                            $("#hightlightNewBorn").addClass("hightlight");
                            $("#hightlightDeath").addClass("hightlight");
                            $("#hightlightU5").addClass("hightlight");

                            var parsedDataFWA = '<tr><td>' + (i + 1) + '</td>'
                                    + '<td>' + json[i].server_tab + '</td>'
                                    + '<td>' + json[i].visits + '</td>'
                                    + '<td>' + json[i].household + '</td>'
                                    + '<td>' + json[i].ses + '</td>'
                                    + '<td>' + json[i].member + '</td>'
                                    + '<td>' + json[i].temphealthid_member + '</td>'
                                    + '<td>' + json[i].clientmap + '</td>'
                                    + '<td>' + json[i].temphid_clientmap + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + json[i].elco + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + json[i].elcovisit + '</td>'
                                    + '<td>' + json[i].mothernutrition + '</td>'
                                    + '<td>' + json[i].childnutrition + '</td>'
                                    + '<td>' + json[i].injectablewomen + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + json[i].immunizationhistory + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + json[i].pregwomen + '</td>'
                                    + '<td>' + json[i].pregdangersign + '</td>'
                                    + '<td>' + json[i].pregrefer + '</td>'
                                    + '<td>' + json[i].ancservice + '</td>'
                                    + '<td>' + json[i].delivery + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + json[i].newborn + '</td>'
                                    + '<td>' + json[i].pncservicechild + '</td>'
                                    + '<td>' + json[i].pncservicemother + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + json[i].death + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + json[i].adolesent + '</td>'
                                    + '<td>' + json[i].adolescentproblem + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + json[i].under5child + '</td>'
                                    + '<td>' + json[i].under5childproblem + '</td>'
                                    + '<td>' + json[i].under5childadvice + '</td>'
                                    + '<td>' + json[i].migrationout + '</td>'
                                    + '<td>' + json[i].epimaster + '</td>'
                                    + '<td>' + json[i].epimasterwoman + '</td>'
                                    + '<td>' + json[i].sessionmasterupdate + '</td>'
                                    + '<td>' + json[i].sessionmasterwomanupdate + '</td>'
                                    + '<td>' + json[i].vaccinecause + '</td>'
                                    + '<td>' + json[i].imuadversevent + '</td>'
                                    + '<td>' + json[i].fpinfo + '</td>'
                                    + '<td>' + json[i].workplanmaster + '</td>'
                                    + '<td>' + json[i].workplandetail + '</td>'
                                    + '<td>' + json[i].deletedinfo + '</td>'
                                    + '<td>' + json[i].upload_status + '</td>'
                                    + '</tr>';

                            var parsedDataHA = '<tr><td>' + (i + 1) + '</td>'
                                    + '<td>' + json[i].before_after + '</td>'
                                    + '<td>' + json[i].visits + '</td>'
                                    + '<td>' + json[i].household + '</td>'
                                    + '<td>' + json[i].ses + '</td>'
                                    + '<td>' + json[i].member + '</td>'
                                    + '<td>' + json[i].temphealthid_member + '</td>'
                                    + '<td>' + json[i].clientmap + '</td>'
                                    + '<td>' + json[i].temphid_clientmap + '</td>'
                                    + '<td>' + json[i].elco + '</td>'
                                    + '<td>' + json[i].elcovisit + '</td>'
                                    + '<td>' + json[i].mothernutrition + '</td>'
                                    + '<td>' + json[i].childnutrition + '</td>'
                                    + '<td>' + json[i].injectablewomen + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + json[i].immunizationhistory + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + json[i].pregwomen + '</td>'
                                    + '<td>' + json[i].pregdangersign + '</td>'
                                    + '<td>' + json[i].pregrefer + '</td>'
                                    + '<td>' + json[i].ancservice + '</td>'
                                    + '<td>' + json[i].delivery + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + json[i].newborn + '</td>'
                                    + '<td>' + json[i].pncservicechild + '</td>'
                                    + '<td>' + json[i].pncservicemother + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + json[i].death + '</td>'
                                    + '<td>' + json[i].adolesent + '</td>'
                                    + '<td>' + json[i].adolescentproblem + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + json[i].under5child + '</td>'
                                    + '<td>' + json[i].under5childproblem + '</td>'
                                    + '<td>' + json[i].under5childadvice + '</td>'
                                    + '<td>' + json[i].migrationout + '</td>'
                                    + '<td>' + json[i].epimaster + '</td>'
                                    + '<td>' + json[i].epimasterwoman + '</td>'
                                    + '<td>' + json[i].sessionmasterupdate + '</td>'
                                    + '<td>' + json[i].sessionmasterwomanupdate + '</td>'
                                    + '<td>' + json[i].vaccinecause + '</td>'
                                    + '<td>' + json[i].imuadversevent + '</td>'
                                    + '<td>' + json[i].fpinfo + '</td>'
                                    + '<td>' + json[i].workplanmaster + '</td>'
                                    + '<td>' + json[i].workplandetail + '</td>'
                                    + '<td>' + json[i].deletedinfo + '</td>'
                                    + '<td>' + json[i].upload_status + '</td>'
                                    + '</tr>';

                            if (json[0].provtype === 3) {

                                $("#hightlightElco").addClass("hightlight");
                                $("#hightlightElcoVisit").addClass("hightlight");
                                $("#hightlightAdol").addClass("hightlight");
                                tableData = parsedDataFWA;

                            } else if (json[0].provtype === 2) {

                                $('#hightlightElco').removeClass('hightlight');
                                $('#hightlightElcoVisit').removeClass('hightlight');
                                $('#hightlightAdol').removeClass('hightlight');
                                tableData = parsedDataHA;
                            }

                            tableBody.append(tableData);

                        }

                        $("#hightlights").addClass("hightlight");

                        if (json.length > 2 && json[0].provtype === 3) {
                            var parsedDataSum = '<tr><td>' + (i + 1) + '</td>'
                                    + '<td>Comparison (2-3)</td>'
                                    + '<td>' + ((json[1].visits) - (json[2].visits)) + '</td>'
                                    + '<td>' + ((json[1].household) - (json[2].household)) + '</td>'
                                    + '<td>' + ((json[1].ses) - (json[2].ses)) + '</td>'
                                    + '<td>' + ((json[1].member) - (json[2].member)) + '</td>'
                                    + '<td>' + ((json[1].temphealthid_member) - (json[2].temphealthid_member)) + '</td>'
                                    + '<td>' + ((json[1].clientmap) - (json[2].clientmap)) + '</td>'
                                    + '<td>' + ((json[1].temphid_clientmap) - (json[2].temphid_clientmap)) + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + ((json[1].elco) - (json[2].elco)) + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + ((json[1].elcovisit) - (json[2].elcovisit)) + '</td>'
                                    + '<td>' + ((json[1].mothernutrition) - (json[2].mothernutrition)) + '</td>'
                                    + '<td>' + ((json[1].childnutrition) - (json[2].childnutrition)) + '</td>'
                                    + '<td>' + ((json[1].injectablewomen) - (json[2].injectablewomen)) + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + ((json[1].immunizationhistory) - (json[2].immunizationhistory)) + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + ((json[1].pregwomen) - (json[2].pregwomen)) + '</td>'
                                    + '<td>' + ((json[1].pregdangersign) - (json[2].pregdangersign)) + '</td>'
                                    + '<td>' + ((json[1].pregrefer) - (json[2].pregrefer)) + '</td>'
                                    + '<td>' + ((json[1].ancservice) - (json[2].ancservice)) + '</td>'
                                    + '<td>' + ((json[1].delivery) - (json[2].delivery)) + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + ((json[1].newborn) - (json[2].newborn)) + '</td>'
                                    + '<td>' + ((json[1].pncservicechild) - (json[2].pncservicechild)) + '</td>'
                                    + '<td>' + ((json[1].pncservicemother) - (json[2].pncservicemother)) + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + ((json[1].death) - (json[2].death)) + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + ((json[1].adolesent) - (json[2].adolesent)) + '</td>'
                                    + '<td>' + ((json[1].adolescentproblem) - (json[2].adolescentproblem)) + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + ((json[1].under5child) - (json[2].under5child)) + '</td>'
                                    + '<td>' + ((json[1].under5childproblem) - (json[2].under5childproblem)) + '</td>'
                                    + '<td>' + ((json[1].under5childadvice) - (json[2].under5childadvice)) + '</td>'
                                    + '<td>' + ((json[1].migrationout) - (json[2].migrationout)) + '</td>'
                                    + '<td>' + ((json[1].epimaster) - (json[2].epimaster)) + '</td>'
                                    + '<td>' + ((json[1].epimasterwoman) - (json[2].epimasterwoman)) + '</td>'
                                    + '<td>' + ((json[1].sessionmasterupdate) - (json[2].sessionmasterupdate)) + '</td>'
                                    + '<td>' + ((json[1].sessionmasterwomanupdate) - (json[2].sessionmasterwomanupdate)) + '</td>'
                                    + '<td>' + ((json[1].vaccinecause) - (json[2].vaccinecause)) + '</td>'
                                    + '<td>' + ((json[1].imuadversevent) - (json[2].imuadversevent)) + '</td>'
                                    + '<td>' + ((json[1].fpinfo) - (json[2].fpinfo)) + '</td>'
                                    + '<td>' + ((json[1].workplanmaster) - (json[2].workplanmaster)) + '</td>'
                                    + '<td>' + ((json[1].workplandetail) - (json[2].workplandetail)) + '</td>'
                                    + '<td>' + ((json[1].deletedinfo) - (json[2].deletedinfo)) + '</td>'
                                    + '<td>' + ((json[1].upload_status) - (json[2].upload_status)) + '</td>'
                                    + '</tr>';
                            tableBody.append(parsedDataSum);
                        }

                        if (json.length > 2 && json[0].provtype === 2) {
                            var parsedDataSum = '<tr><td>' + (i + 1) + '</td>'
                                    + '<td>Comparison (2-3)</td>'
                                    + '<td>' + ((json[1].visits) - (json[2].visits)) + '</td>'
                                    + '<td>' + ((json[1].household) - (json[2].household)) + '</td>'
                                    + '<td>' + ((json[1].ses) - (json[2].ses)) + '</td>'
                                    + '<td>' + ((json[1].member) - (json[2].member)) + '</td>'
                                    + '<td>' + ((json[1].temphealthid_member) - (json[2].temphealthid_member)) + '</td>'
                                    + '<td>' + ((json[1].clientmap) - (json[2].clientmap)) + '</td>'
                                    + '<td>' + ((json[1].temphid_clientmap) - (json[2].temphid_clientmap)) + '</td>'
                                    + '<td>' + ((json[1].elco) - (json[2].elco)) + '</td>'
                                    + '<td>' + ((json[1].elcovisit) - (json[2].elcovisit)) + '</td>'
                                    + '<td>' + ((json[1].mothernutrition) - (json[2].mothernutrition)) + '</td>'
                                    + '<td>' + ((json[1].childnutrition) - (json[2].childnutrition)) + '</td>'
                                    + '<td>' + ((json[1].injectablewomen) - (json[2].injectablewomen)) + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + ((json[1].immunizationhistory) - (json[2].immunizationhistory)) + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + ((json[1].pregwomen) - (json[2].pregwomen)) + '</td>'
                                    + '<td>' + ((json[1].pregdangersign) - (json[2].pregdangersign)) + '</td>'
                                    + '<td>' + ((json[1].pregrefer) - (json[2].pregrefer)) + '</td>'
                                    + '<td>' + ((json[1].ancservice) - (json[2].ancservice)) + '</td>'
                                    + '<td>' + ((json[1].delivery) - (json[2].delivery)) + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + ((json[1].newborn) - (json[2].newborn)) + '</td>'
                                    + '<td>' + ((json[1].pncservicechild) - (json[2].pncservicechild)) + '</td>'
                                    + '<td>' + ((json[1].pncservicemother) - (json[2].pncservicemother)) + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + ((json[1].death) - (json[2].death)) + '</td>'
                                    + '<td>' + ((json[1].adolesent) - (json[2].adolesent)) + '</td>'
                                    + '<td>' + ((json[1].adolescentproblem) - (json[2].adolescentproblem)) + '</td>'
                                    + '<td style="background-color: #BDEDFF;">' + ((json[1].under5child) - (json[2].under5child)) + '</td>'
                                    + '<td>' + ((json[1].under5childproblem) - (json[2].under5childproblem)) + '</td>'
                                    + '<td>' + ((json[1].under5childadvice) - (json[2].under5childadvice)) + '</td>'
                                    + '<td>' + ((json[1].migrationout) - (json[2].migrationout)) + '</td>'
                                    + '<td>' + ((json[1].epimaster) - (json[2].epimaster)) + '</td>'
                                    + '<td>' + ((json[1].epimasterwoman) - (json[2].epimasterwoman)) + '</td>'
                                    + '<td>' + ((json[1].sessionmasterupdate) - (json[2].sessionmasterupdate)) + '</td>'
                                    + '<td>' + ((json[1].sessionmasterwomanupdate) - (json[2].sessionmasterwomanupdate)) + '</td>'
                                    + '<td>' + ((json[1].vaccinecause) - (json[2].vaccinecause)) + '</td>'
                                    + '<td>' + ((json[1].imuadversevent) - (json[2].imuadversevent)) + '</td>'
                                    + '<td>' + ((json[1].fpinfo) - (json[2].fpinfo)) + '</td>'
                                    + '<td>' + ((json[1].workplanmaster) - (json[2].workplanmaster)) + '</td>'
                                    + '<td>' + ((json[1].workplandetail) - (json[2].workplandetail)) + '</td>'
                                    + '<td>' + ((json[1].deletedinfo) - (json[2].deletedinfo)) + '</td>'
                                    + '<td>' + ((json[1].upload_status) - (json[2].upload_status)) + '</td>'
                                    + '</tr>';
                            tableBody.append(parsedDataSum);
                        }



                        //                    var parsedDataSum = '<tr><td>' + (i + 1) + '</td>'
                        //                            + '<td>Calculation (3-2)</td>'
                        //                            + '<td></td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '<td>-</td>'
                        //                            + '</tr>';


                        $('.table').slideDown("slow");

                    }
                }

            });
        </script>
        <style>
            #emis{
                color:#ECF0F5;
                font-size: 100px;
                margin-bottom: 25px;
            }
            .table{
                display: none;
                width: 200px;
            }
            .header{
                margin-top: 20px;
            }
            .full-width-div {
                position: absolute;
                width: 100%;
                left: 0;
            }
            .hightlight{
                background-color: #BDEDFF;
                font-weight:bold;
            }
        </style>
    </head>

    <body>

        <div class="container">
            <div class="header clearfix">
                <nav>
                    <ul class="nav nav-pills float-right">
                        <!--            <li class="nav-item">
                                         <p class="nav-link" href="#">Load DB</p>
                                    </li>
                                    <li class="nav-item">
                                        <input type="file" class="form-control" id="providerDB">&nbsp;
                                    </li>-->
                        <li class="nav-item">
                            <p class="nav-link" href="#">Enter Provider ID</p>
                        </li>
                        <li class="nav-item">
                            <input type="number" class="form-control" id="providerID">&nbsp;
                        </li>
                        <li class="nav-item">
                            &nbsp; <button type="button" class="btn btn-primary">View</button>
                        </li>

                    </ul>
                </nav>
                <h3 class="text-muted">eMIS Sync Checker</h3>
            </div><hr>

            <ul class="nav nav-pillsright" id="providerInfo">
            </ul><br>

            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="full-width-div">
                            <div class="table-responsive">
                                <table style="width: 100%" class="table table-bordered table-hover">
                                    <colgroup>
                                        <col class="grey" />
                                        <col class="red" span="3" />
                                        <col class="blue" />
                                    </colgroup>
                                    <thead id="thead">
                                        <tr class="label-primary">
                                            <th>#</th>
                                            <th>Before After&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                            <th>Visits</th>
                                            <th>Household</th>
                                            <th>Ses</th>
                                            <th>Member</th>
                                            <th>Temp Hid Member</th>
                                            <th>Clientmap</th>
                                            <th>Temp Hid Clientmap</th>
                                            <th id="hightlightElco">Elco</th>
                                            <th id="hightlightElcoVisit">Elco Visit</th>
                                            <th>Mother Nutrition</th>
                                            <th>Child Nutrition</th>
                                            <th>Injectable Women</th>
                                            <th id="hightlightImuHis">Immunization History</th>
                                            <th id="hightlightPregWo">Pregwomen</th>
                                            <th>Preg Danger Sign</th>
                                            <th>Pregrefer</th>
                                            <th>Anc Service</th>
                                            <th>Delivery</th>
                                            <th id="hightlightNewBorn">Birth</th>
                                            <th>Pnc Service Child</th>                
                                            <th>Pnc Service Mother</th>
                                            <th id="hightlightDeath">Death</th>
                                            <th id="hightlightAdol">Adolesent</th>
                                            <th>Adolescent Problem</th>
                                            <th id="hightlightU5">Under 5 Child</th>
                                            <th>Under 5 Child Problem</th>
                                            <th>Under 5 Child Advice</th>
                                            <th>Migration Out</th>
                                            <th>Epi Master</th>
                                            <th>Epi Master Woman</th>
                                            <th>Session Master Update</th>
                                            <th>Session Master Woman Update</th>
                                            <th>Vaccine Cause</th>
                                            <th>Immunization Adversevent</th>
                                            <th>Fp Info</th>
                                            <th>Work Plan Master</th>
                                            <th>Work Plan Detail</th>
                                            <th>Deleted Info</th>
                                            <th>Upload Status</th>
                                        </tr>
                                    </thead>
                                    <tbody  id="tbody">
                                    </tbody>
                                </table>
                            </div>
                            <div class="text-center" id="response">   
                            </div>
                            <p id="p"></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

