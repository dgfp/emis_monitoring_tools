<%-- 
    Document   : pregnantUpdated
    Created on : Aug 10, 2017, 9:27:09 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/area_dropdown_control_by_user.js"></script>
<style>
    .center{
        text-align: center;
    }
    #statusTotalCount{
        display: none;   
    }
    .box-title{
        text-align: center!important;
    }
    #tableView{
        display: none;       
    }
    #individualViewType{
        margin-top: 5px;
    }
    /*    #printTable{
            display: none;
        }*/
    #rightAlign{
        text-align: right!important;
    }
    .label {
        border-radius: 11px!important;
    }
    .box {
        margin-bottom: 0px;
    }
</style>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>Pregnant woman</h1>
    <ol class="breadcrumb" id="communityStatisticsAccessHF">
        <a class="btn btn-flat btn-info btn-sm" href="pregnant"><i class="fa fa-users" aria-hidden="true"></i> <b>&nbsp;Family Planning</b></a>
        <a class="btn btn-flat btn-primary btn-sm" href="pregnantHA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-heartbeat" aria-hidden="true"></i> <b>&nbsp;Health&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></a>
    </ol>
</section>
<!-- Main content -->
<section class="content">
    <%@include file="/WEB-INF/jspf/communityArea.jspf" %>
    <!--Transparent Text For Blank Space-->
    <section class="content-header" id="transparentTextForBlank" style="display: block;">
        <center class="emis_hologram">eMIS</center>
    </section>
    <!--Pregnant Data Table-->
    <div class="box box-primary"  id="tableView">
        <div class="box-header with-border" style="margin-top: -8px;margin-bottom: -5px!important;">
            <h3 class="box-title" style="text-align: center!important;">
                <span id="statusTotalCount">
                    <b>
                        Sort by
                    </b> 
                    <Select id="individualViewType">
                        <option value="all" selected>All</option>
                        <option value="current">Current</option>
                        <option value="completed">Completed</option>
                    </Select>&nbsp;&nbsp;
                    <b id="countTitle1">Total&nbsp;<span id="all1"></span>&nbsp;&nbsp;&nbsp;&nbsp;Active&nbsp;<span id="active1"></span>&nbsp;&nbsp;&nbsp;&nbsp;Due&nbsp;<span id="due1"></span>&nbsp;&nbsp;&nbsp;&nbsp;Completed&nbsp;<span id="completed1"></span></b>
                    <b id="countTitle">Total&nbsp;<span id="all"></span>&nbsp;&nbsp;&nbsp;&nbsp;Active&nbsp;<span id="active"></span>&nbsp;&nbsp;&nbsp;&nbsp;Due&nbsp;<span id="due"></span></b>
                    <b id="countTitle3">Total&nbsp;<span id="completed3"></span></b>
                </span>
            </h3>

            <div class="box-tools pull-right" style="margin-top: 0px;">
                <button id="printTableBtn" type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <a href="#" id ="exportCSV" role='button' class="btn btn-box-tool"><i class="fa fa-file-excel-o" aria-hidden="true"></i>&nbsp;CSV</a>
                <a href="#" id ="exportText" role='button' class="btn btn-box-tool"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Text</a>
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
            </div>
        </div>

        <div class="box-body" id="printTable">
            <div class="table-responsive" >
                <table id="data-table" class="table table-bordered table-striped table-hover">
                    <thead id="tableHeader" class="data-table">
                    </thead>
                    <tbody id="tableBody">
                    </tbody>
                    <tfoot id="tableFooter">
                    </tfoot>
                </table>
            </div>
        </div>
        <!--For Print -->
        <div class="box-body"  id="printTable1">
            <div id="dvData">
                <table class="table table-bordered table-striped table-hover" align="center">
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
<script src="http://cdn.datatables.net/plug-ins/1.10.20/sorting/datetime-moment.js"></script>


<script>
    function convertToCustomDateFormat(dateString) {
        var parts = dateString.split("-");
        var year = parts[0];
        var month = parts[1];
        var date = parts[2];
        return date + "/" + month + "/" + year;
    }
    var individualJsonCurrent = null;
    var individualJsonCompleted = null;
    var startDate = null;

    function getFWAUnit(value) {
        var unit = null;
        if (value == '01') {
            unit = "1";
        } else if (value == '02') {
            unit = "1KA";
        } else if (value == '03') {
            unit = "1KHA";
        } else if (value == '04') {
            unit = "1GA";
        } else if (value == '05') {
            unit = "2";
        } else if (value == '06') {
            unit = "2KA";
        } else if (value == '07') {
            unit = "2KHA";
        } else if (value == '08') {
            unit = "2GA";
        } else if (value == '09') {
            unit = "3";
        } else if (value == '10') {
            unit = "3KA";
        } else if (value == '11') {
            unit = "3KHA";
        } else if (value == '12') {
            unit = "3GA";
        } else {
            unit = "-";
        }

        return unit;
    }
    $(document).ready(function () {
        if ($('#userCategory').val() == '1' || $('#userCategory').val() == '2') {
            $("#communityStatisticsAccessHF").css("display", "none");
        }

        $("#areaDropDownPanel").slideDown("slow"); //Show area dropdowns panel by jquery slideDown
        var regExp = /(\d{1,2})\/(\d{1,2})\/(\d{2,4})/; //for date compare
        var defaultStartDate = "01/01/2014"; //for default date
        var tableHeader = $('#tableHeader');
        var tableBody = $('#tableBody');
        var tableFooter = $('#tableFooter');
        //For export(print) data
        var tableHeaderP = $('#tableHeaderP');
        var tableBodyP = $('#tableBodyP');
        var tableFooterP = $('#tableFooterP');


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
            frameDoc.document.write('<style>table, th, td{border:1px solid black; border-collapse: collapse;padding:10px;}th{vertical-align: text-center} td{text-align:right;} .area{text-align: left !important;}</style>');
            frameDoc.document.write('<link href="style.css" rel="stylesheet" type="text/css" />');
            //Append the DIV contents.
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center!important;"><center>Pregnant woman registration coverage</center></h3>');
            frameDoc.document.write('<h5 style="color:black;text-align:center!important;"><center>' + getAreaText() + '</center></h5>');
            frameDoc.document.write(contents);
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 500);
        });

//======Export CSV using these function==========================================================
        $("#exportText").click(function (event) {
            var outputFile = "eMIS_pregnant_woman_registration_coverage";
            outputFile = outputFile.replace('.txt', '') + '.txt';
            exportTableToText.apply(this, [$('#dvData > table'), outputFile]); //function call from TemplateHeader
        });
        $("#exportCSV").click(function (event) {
            var outputFile = "eMIS_pregnant_woman_registration_coverage ";
            outputFile = outputFile.replace('.csv', '') + '.csv';
            exportTableToCSV.apply(this, [$('#dvData > table'), outputFile]); //function call from TemplateHeader
        });
//================================================END===================================== 

        //Render individual data globallly
        var individual_active_current = 0, individual_due_current = 0;
        function renderData(data) {
            individual_active_current = 0;
            individual_due_current = 0;
            tableHeader.empty();
            var parsedHeader = "<tr>"
                    + "<th style='vertical-align: top;'>#</th>"
                    + "<th style='vertical-align: top;'>Village</th>"
                    + "<th style='vertical-align: top;'>ELCO No.</th>"
                    + "<th style='vertical-align: top;'>Pregnant Woman</th>"
                    + "<th style='vertical-align: top;'>Age</th>"
                    + "<th style='vertical-align: top;'>Husband</th>"
                    + "<th style='vertical-align: top;'>Mobile</th>"
                    + "<th style='vertical-align: top;width:60px;'>LMP</th>"
                    + "<th style='vertical-align: top;width:60px;'>EDD</th>"
                    + "<th style='vertical-align: top;' class='center'>Status</th>"
                    + "</tr>";
            tableHeader.append(parsedHeader);
            $('#data-table').DataTable().destroy();
//            $.fn.dataTable.moment( 'DD/MM/YYYY' );
//            $.fn.dataTable.moment('M/D/YYYY');
//            $.fn.dataTable.moment('dddd D MMMM YYYY');
            $('#data-table').dataTable({
                processing: true,
                data: data,
                "createdRow": function (t, d, i) {
                    (d.case === "over due") ? (individual_due_current++) : "";
                    (d.case === "active") ? (individual_active_current++) : "";
                },
//                "columnDefs": [ { "type": "datetime-moment" } ]
//
//                 “columnDefs”: [{ “type”: “date”, “targets”: [7] }],
//                "columnDefs": [{"type": "datetime-moment"}],
//                "aoColumnDefs": [
//                    {sType: "date-custom", aTargets: [7]} //based on your date column
//                ],
                columns: [{
                        data: "villagenameeng",
                        render: function (d, t, r, m) {
                            return m.row + 1;
                        }
                    },
                    {
                        data: "villagenameeng"
                    }, {
                        data: function (d) {
                            return (d.elcono === "null") ? "--" : d.elcono
                        }
                    }, {
                        data: "nameeng"
                    }, {
                        data: "age"
                    }, {
                        data: function (d) {
                            return (d.husbandname === "null") ? "--" : d.husbandname
                        }
                    }, {
                        data: function (d) {
                            return (d.mobileno1 === "null") ? "--" : "0" + d.mobileno1
                        }
                    },
                    {
                        data: "lmp",
//                        "type": "date",
                        render: function (d) {
                            if (d === null)
                                return "";
                            return moment(d).format('DD MMM YYYY');
                        }
//                        type:'date',
//                        render: function(d, t, r){
//                            var dt = $.app.date(d);
//                            return d;
//                        }
                    },
//                    {
//                        data: function (d) {
//                            var dt =  $.app.date(d.lmp);
//                            //console.log(dt, typeof(dt.date));
//                           // return new Date($.app.date(d.lmp).date);
//                            console.log(d.Imp);//y-m-d->d/m/y
//                            return new Date(dt.year, dt.month, dt.day);
//                            //return d.lmp;
//                        }
//                    }, 
//                    {
//                        data: 'lmp',
//                        type: 'date',
//                        render: function (data, type, row) {
//                            return data ? moment(data).format('DD/MM/YY') : '';
//                        }
//                    },

                    {
                        data: function (d) {
                            //return $.app.date(d.edd).date;
                            return moment(d.edd).format('DD MMM YYYY');
                            //return d.edd;
                        }
                    }, {
                        data: function (d) {
                            status = "";
                            (d.case === "over due") ? (status = "Due") : (d.case === "active") ? (status = "Active") : status = "Completed";
                            klass = (d.case === "over due") ? "label-danger" : (d.case === "active") ? "label-success" : "label-info";
                            return "<span class='label label-flat " + klass + " label-sm'>" + status + "</span>";
                        }, class: "center"
                    }
                ]

            });
        }



        $('#showdataButton').click(function () {
            $("#tableView").fadeOut("slow");
            var divisionId = $("select#division").val();
            var districtId = $("select#district").val();
            var upazilaId = $("select#upazila").val();
            var unionId = $("select#union").val();
            var unitId = $("select#unit").val();
            var villageId = $("select#village").val();

            var tableBody = $('#tableBody');
            tableBody.empty();

            if ($("select#division").val() == "" || $("select#division").val() == 0) {
                toastr["error"]("<h4><b>Please select division</b></h4>");
                return;
            } else if ($("select#district").val() == "" || $("select#district").val() == 0) {
                toastr["error"]("<h4><b>Please select district</b></h4>");
                return;
            } else if ($("#endDate").val() == "") {
                toastr["error"]("<h4><b>Please select End Date</b></h4>");
                return;
            } else if (parseInt($("#startDate").val().replace(regExp, "$3$2$1")) > parseInt($("#endDate").val().replace(regExp, "$3$2$1"))) {
                toastr["error"]("<h4><b>Start date should be smaller than end date</b></h4>");
                return;
            } else {
                //Get report type
                var reportType = null;
                if ($("input[type='radio']#reportType").is(':checked')) {
                    reportType = $("input[type='radio']#reportType:checked").val();
                }
                //Set start Date
                startDate = $("#startDate").val();
                if (startDate === "") {
                    startDate = defaultStartDate;
                }
                //Clear previous table data
                tableHeader.empty();
                tableBody.empty();
                tableFooter.empty();
                tableHeaderP.empty();
                tableBodyP.empty(); //first empty table before showing data
                tableFooterP.empty();






                if (reportType === "individual") {
                    //global for individual



//                    function renderData(data) {
//                        tableHeader.empty();
//                        var parsedHeader = "<tr>"
//                                + "<th style='vertical-align: top;'>SL No.</th>"
//                                + "<th style='vertical-align: top;'>Village</th>"
//                                + "<th style='vertical-align: top;'>Elco No.</th>"
//                                + "<th style='vertical-align: top;'>Preg. Woman</th>"
//                                + "<th style='vertical-align: top;'>Age</th>"
//                                + "<th style='vertical-align: top;'>Husband</th>"
//                                + "<th style='vertical-align: top;'>Mobile</th>"
//                                + "<th style='vertical-align: top;'>LMP</th>"
//                                + "<th style='vertical-align: top;'>EDD</th>"
//                                + "<th style='vertical-align: top;' class='center'>Status</th>"
//                                + "</tr>";
//                        tableHeader.append(parsedHeader);
//                        $('#data-table').DataTable().destroy();
//                        $('#data-table').dataTable({
//                            processing: true,
//                            data: data,
//                            "createdRow": function (t, d, i) {
//                                (d.case === "over due") ? (individual_due_current++) : "";
//                                (d.case === "active") ? (individual_active_current++) : "";
//                            },
//                            columns: [{
//                                    data: "villagenameeng",
//                                    render: function (d, t, r, m) {
//                                        return m.row + 1;
//                                    }
//                                },
//                                {
//                                    data: "villagenameeng"
//                                }, {
//                                    data: "elcono"
//                                }, {
//                                    data: "nameeng"
//                                }, {
//                                    data: "age"
//                                }, {
//                                    data: function (d) {
//                                        return (d.husbandname === "null") ? "--" : d.husbandname
//                                    }
//                                }, {
//                                    data: function (d) {
//                                        return (d.mobileno1 === "null") ? "--" : d.mobileno1
//                                    }
//                                }, {
//                                    data: function (d) {
//                                        return $.app.date(d.lmp).date;
//                                    }
//                                }, {
//                                    data: function (d) {
//                                        return $.app.date(d.edd).date;
//                                    }
//                                }, {
//                                    data: function (d) {
//                                        status = "";
//                                        (d.case === "over due") ? (status = "Due") : (d.case === "active") ? (status = "Active") : "";
//                                        klass = (d.case === "over due") ? "label-danger" : (d.case === "active") ? "label-success" : "";
//                                        return "<span class='label label-flat " + klass + " label-sm'>" + status + "</span>";
//                                    }
//                                }
//                            ]
//
//                        });
//                    }




                    if ($("select#district").val() == "" || $("select#district").val() == 0) {
                        toastr["error"]("<h4><b>Please select district</b></h4>");
                        return;
                    }
//                    if( $("select#upazila").val()=="" || $("select#upazila").val()==0){
//                        toastr["error"]("<h4><b>Please select upazila</b></h4>");
//                        return ;
//                    }
                    var m = "";
                    var v = "";
                    if (villageId.length > 1) {
                        var vill = $('#village').find(":selected").text().split(" "); //$("select#village").val().split(" ");        
                        m = vill[vill.length - 3];
                        v = vill[vill.length - 2];
                    }
                    var btn = $(this).button('loading');
                    $.ajax({
                        url: "pregnant?action=Individual",
                        data: {
                            districtId: $("select#district").val() == '0' ? "" : $("select#district").val(),
                            upazilaId: $("select#upazila").val() == '0' ? "" : $("select#upazila").val(),
                            unionId: $("select#union").val() == '0' ? "" : $("select#union").val(),
                            unitId: $("select#unit").val() == '0' ? "" : $("select#unit").val(),
                            villageId: v,
                            mouzaId: m,
                            startDate: startDate,
                            endDate: $("#endDate").val()
                        },
                        type: 'POST',
                        success: function (result) {
                            btn.button('reset');
                            var data = JSON.parse(result);
                            var json = data.current;
                            individualJsonCurrent = data.current;
                            individualJsonCompleted = data.completed;

                            if (json.length === 0) {
                                toastr["error"]("<h4><b>No data found</b></h4>");
                                return;
                            }
                            $("#transparentTextForBlank").css("display", "none");
                            //show table view after data load
                            $("#tableView").fadeIn("slow");
                            //Show locations title when area panel is minimize or in export data
//                                var division=" Division: <b style='color:#3C8DBC'>"+ $("#division option:selected").text()+"</b>";
//                                var district=" District: <b style='color:#3C8DBC'>"+ $("#district option:selected").text()+"</b>";
//                                var upazila="Upazila: <b style='color:#3C8DBC'>"+ $("#upazila option:selected").text()+"</b>";
//                                var union="Union: <b style='color:#3C8DBC'>"+ $("#union option:selected").text()+"</b>";
//                                var unit="Unit: <b style='color:#3C8DBC'>"+ $("#unit option:selected").text()+"</b>";
//                                var village="Village: <b style='color:#3C8DBC'>"+ $("#village option:selected").text()+"</b>";
//                                var sDate="From: <b style='color:#3C8DBC'>"+startDate+ "</b>";
//                                var eDate="To: <b style='color:#3C8DBC'>"+ $("#endDate").val() +"</b>";
//                                areaText=division +',&nbsp;&nbsp;'+ district +',&nbsp;&nbsp;'+ upazila +',&nbsp;&nbsp;'+union+'&nbsp;&nbsp;'+unit+'&nbsp;&nbsp;'+village+'&nbsp;&nbsp;'+sDate+'&nbsp;&nbsp;'+eDate;


                            //render
                            renderData(data.current.concat(data.completed));

//                                var table = $('#data-table').DataTable(); 
//                                table.destroy();
//                                tableBody.empty();

                            $("#countTitle").hide();
                            $("#countTitle3").hide();
//                                for (var i = 0; i < json.length; i++) {
//                                    var status=null;
//                                    if(json[i].case==="over due"){
//                                        status="<span class='label label-flat label-danger label-xs'>&nbsp;&nbsp;Due&nbsp;&nbsp;</span>";
//                                        due++;
//                                    }else if(json[i].case==="active"){
//                                        status="<span class='label label-flat label-success label-xs'>Active</span>";
//                                        active++;
//                                    }
//                                    var parsedData = "<tr style='width:10px!importtant'><td>" + (i + 1) + "</td>"
//                                            + "<td class='area'>" + json[i].villagenameeng + "</td>"
//                                            + "<td id='rightAlign'>" + ((json[i].elcono === "null") ? "-" : json[i].elcono)  + "</td>"
//                                            + "<td class='area'>" + json[i].nameeng + "</td>"
//                                            + "<td id='rightAlign'>" + json[i].age + "</td>"
//                                            + "<td class='area'>" + ((json[i].husbandname === "null") ? "-" : json[i].husbandname) + "</td>"
//                                            + "<td>" + ((json[i].mobileno1 === "null") ? "-" : json[i].mobileno1) + "</td>"
//                                            + "<td>" + json[i].lmp + "</td>"
//                                            + "<td>" + json[i].edd + "</td>" //$.app.date(convertToCustomDateFormat(json[i].edd)).datetime
//                                            + "<td class='center'>" + status + "</td>";
//                                    tableBody.append(parsedData);
//                                    tableBodyP.append(parsedData);
//                                    serial++;
//                                }
//                                serial++;
//                                for (var i = 0; i < individualJsonCompleted.length; i++) {
//                                    
//                                    var parsedData = "<tr style='width:10px!importtant'><td>" + (serial + i) + "</td>"
//                                            + "<td>" + individualJsonCompleted[i].villagenameeng + "</td>"
//                                            + "<td id='rightAlign'>" + ((individualJsonCompleted[i].elcono === "null") ? "-" : individualJsonCompleted[i].elcono)  + "</td>"
//                                            + "<td>" + individualJsonCompleted[i].nameeng + "</td>"
//                                            + "<td id='rightAlign'>" + individualJsonCompleted[i].age + "</td>"
//                                            + "<td>" + ((individualJsonCompleted[i].husbandname === "null") ? "-" : individualJsonCompleted[i].husbandname) + "</td>"
//                                            + "<td>" + ((individualJsonCompleted[i].mobileno1 === "null") ? "-" : individualJsonCompleted[i].mobileno1) + "</td>"
//                                            + "<td>" + convertToCustomDateFormat(individualJsonCompleted[i].lmp) + "</td>"
//                                            + "<td>" + convertToCustomDateFormat(individualJsonCompleted[i].edd) + "</td>"
//                                            + "<td class='center'><span class='label label-flat label-info label-xs'>Completed</span></td>";
//                                    tableBody.append(parsedData);
//                                    tableBodyP.append(parsedData);
//                                }
//                                
//                                
                            $('#individualViewType').prop('selectedIndex', 0);//                                
                            $("#countTitle1").show();
                            $("#statusTotalCount").fadeIn("slow");
                            var sum = individual_active_current + individual_due_current + (individualJsonCompleted.length);
                            $('#active1').html("<span class='label label-flat label-success label-xs'><b>" + individual_active_current + "</b></span>");
                            $('#due1').html("<span class='label label-flat label-danger label-xs'><b>" + individual_due_current + "</b></span>");
                            $('#completed1').html("<span class='label label-flat label-info label-xs'><b>" + individualJsonCompleted.length + "</b></span>");
                            $('#all1').html("<span class='label label-flat label-primary label-xs'><b>" + sum + "</b></span>");
////                                var table = $('#data-table').DataTable();
////                                table.draw();
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    });//End Ajax

                    /*
                     * 
                     * INDIVIDUAL ENDS
                     */




















                } else if (reportType === "aggregate") {

                    $("#statusTotalCount").css("display", "none");
                    //Upazila wise aggregate=============================================================
                    if (upazilaId == "0") {
                        var btn = $(this).button('loading');
                        Pace.track(function () {
                            $.ajax({
                                url: "pregnant?action=AggregateUpazila",
                                data: {
                                    districtId: $("select#district").val(),
                                    startDate: startDate,
                                    endDate: $("#endDate").val()
                                },
                                type: 'POST',
                                success: function (result) {

                                    var json = null;
                                    json = JSON.parse(result);
                                    btn.button('reset');

                                    if (json.length === 0) {
                                        toastr["error"]("<h4><b>No data found</b></h4>");
                                        return;
                                    } else {
                                        generateAggregateTable(json, "Upazila");
                                    }
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    btn.button('reset');
                                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                                }
                            }); //End Ajax Request 
                        }); //End Pace 

//=========================================Union wise aggregate=======================================================
                    } else if (unionId == "0") {
                        var btn = $(this).button('loading');
                        Pace.track(function () {
                            $.ajax({
                                url: "pregnant?action=AggregateUnion",
                                data: {
                                    districtId: $("select#district").val(),
                                    upazilaId: $("select#upazila").val(),
                                    startDate: startDate,
                                    endDate: $("#endDate").val()
                                },
                                type: 'POST',
                                success: function (result) {

                                    var json = null;
                                    json = JSON.parse(result);
                                    btn.button('reset');

                                    if (json.length === 0) {
                                        toastr["error"]("<h4><b>No data found</b></h4>");
                                        return;
                                    } else {
                                        generateAggregateTable(json, "Union");
                                    }
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    btn.button('reset');
                                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                                }
                            }); //End Ajax Request 
                        }); //End Pace 
//========================================Unit wise aggregate   =================================================
                    } else if (unitId == "0") {
                        var btn = $(this).button('loading');
                        Pace.track(function () {
                            $.ajax({
                                url: "pregnant?action=AggregateUnit",
                                data: {
                                    districtId: $("select#district").val(),
                                    upazilaId: $("select#upazila").val(),
                                    unionId: $("select#union").val(),
                                    startDate: startDate,
                                    endDate: $("#endDate").val()
                                },
                                type: 'POST',
                                success: function (result) {

                                    var json = null;
                                    json = JSON.parse(result);
                                    btn.button('reset');

                                    if (json.length === 0) {
                                        toastr["error"]("<h4><b>No data found</b></h4>");
                                        return;
                                    } else {
                                        generateAggregateTable(json, "Unit");
                                    }
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    btn.button('reset');
                                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                                }
                            }); //End Ajax Request 
                        }); //End Pace 
//=========================================================== Village wise aggregate =======================================================                       
                    } else if (villageId == "0") {
                        var btn = $(this).button('loading');
                        Pace.track(function () {
                            $.ajax({
                                url: "pregnant?action=AggregateVillage",
                                data: {
                                    districtId: $("select#district").val(),
                                    upazilaId: $("select#upazila").val(),
                                    unionId: $("select#union").val(),
                                    unitId: $("select#unit").val(),
                                    startDate: startDate,
                                    endDate: $("#endDate").val()
                                },
                                type: 'POST',
                                success: function (result) {

                                    var json = null;
                                    json = JSON.parse(result);
                                    btn.button('reset');

                                    if (json.length === 0) {
                                        toastr["error"]("<h4><b>No data found</b></h4>");
                                        return;
                                    } else {
                                        generateAggregateTable(json, "Village");
                                    }
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    btn.button('reset');
                                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                                }
                            }); //End Ajax Request 
                        }); //End Pace 

                    } else {
                        toastr["error"]("<h4><b>Please select all village</b></h4>");
                    }
                }

            }
        }); //end button click

        //Top Drop down data view type-------------------------------------------------------------------------------------------------
        $('#individualViewType').change(function (event) {
            var viewType = $('#individualViewType').val();
            //$("#tableView").fadeOut("slow");
            tableHeader.empty();
            tableBody.empty();
            tableFooter.empty();
            tableHeaderP.empty();
            tableBodyP.empty();
            tableFooterP.empty();

            if (viewType == "completed") {
                renderData(individualJsonCompleted);
                $("#countTitle").hide();
                $("#countTitle1").hide();
                $("#tableView").fadeIn("slow");

//                tableHeader.empty();
//                var parsedHeader = "<tr>"
//                        + "<th style='vertical-align: top;'>SL No.</th>"
//                        + "<th style='vertical-align: top;'>Village</th>"
//                        + "<th style='vertical-align: top;'>Elco No.</th>"
//                        + "<th style='vertical-align: top;'>Preg. Woman</th>"
//                        + "<th style='vertical-align: top;'>Age</th>"
//                        + "<th style='vertical-align: top;'>Husband</th>"
//                        + "<th style='vertical-align: top;'>Mobile</th>"
//                        + "<th style='vertical-align: top;'>LMP</th>"
//                        + "<th style='vertical-align: top;'>EDD</th>"
//                        + "<th style='vertical-align: top;' class='center'>Status</th>"
//                        + "</tr>";
//                tableHeader.append(parsedHeader);
//                tableHeaderP.append(parsedHeader);
//
//                var table = $('#data-table').DataTable();
//                table.destroy();
//                tableBody.empty();
//                for (var i = 0; i < individualJsonCompleted.length; i++) {
//                    var parsedData = "<tr style='width:10px!importtant'><td>" + (i + 1) + "</td>"
//                            + "<td >" + individualJsonCompleted[i].villagenameeng + "</td>"
//                            + "<td id='rightAlign'>" + ((individualJsonCompleted[i].elcono === "null") ? "-" : individualJsonCompleted[i].elcono) + "</td>"
//                            + "<td>" + individualJsonCompleted[i].nameeng + "</td>"
//                            + "<td id='rightAlign'>" + individualJsonCompleted[i].age + "</td>"
//                            + "<td>" + ((individualJsonCompleted[i].husbandname === "null") ? "-" : individualJsonCompleted[i].husbandname) + "</td>"
//                            + "<td>" + ((individualJsonCompleted[i].mobileno1 === "null") ? "-" : individualJsonCompleted[i].mobileno1) + "</td>"
//                            + "<td>" + convertToCustomDateFormat(individualJsonCompleted[i].lmp) + "</td>"
//                            + "<td>" + convertToCustomDateFormat(individualJsonCompleted[i].edd) + "</td>"
//                            + "<td class='center'><span class='label label-flat label-info label-xs'>Completed</span></td>";
//                    tableBody.append(parsedData);
//                    tableBodyP.append(parsedData);
//                }
                $("#countTitle3").show();
                $('#completed3').html("<span class='label label-flat label-info label-xs'><b>" + individualJsonCompleted.length + "</b></span>");
//                var table = $('#data-table').DataTable();
//                table.draw();

            } else if (viewType == "current") {
                renderData(individualJsonCurrent);
                $("#countTitle1").hide();
                $("#countTitle3").hide();
                $("#tableView").fadeIn("slow");
//                tableHeader.empty();
//                var parsedHeader = "<tr>"
//                        + "<th style='vertical-align: top;'>SL No.</th>"
//                        + "<th style='vertical-align: top;'>Village</th>"
//                        + "<th style='vertical-align: top;'>Elco No.</th>"
//                        + "<th style='vertical-align: top;'>Preg. Woman</th>"
//                        + "<th style='vertical-align: top;'>Age</th>"
//                        + "<th style='vertical-align: top;'>Husband</th>"
//                        + "<th style='vertical-align: top;'>Mobile</th>"
//                        + "<th style='vertical-align: top;'>LMP</th>"
//                        + "<th style='vertical-align: top;'>EDD</th>"
//                        + "<th style='vertical-align: top;' class='center'>Status</th>"
//                        + "</tr>";
//                tableHeader.append(parsedHeader);
//                tableHeaderP.append(parsedHeader);
//
//                var table = $('#data-table').DataTable();
//                table.destroy();
//                tableBody.empty();
//                var active = 0, due = 0;
//                for (var i = 0; i < individualJsonCurrent.length; i++) {
//                    $("#countTitle").fadeIn("slow");
//                    var status = null;
//                    if (individualJsonCurrent[i].case === "OVER DUE") {
//                        status = "<span class='label label-flat label-danger label-xs'>&nbsp;&nbsp;Due&nbsp;&nbsp;</span>";
//                        due++;
//                    } else if (individualJsonCurrent[i].case === "ACTIVE") {
//                        status = "<span class='label label-flat label-success label-xs'>Active</span>";
//                        active++;
//                    }
//                    var parsedData = "<tr style='width:10px!importtant'><td>" + (i + 1) + "</td>"
//                            + "<td>" + individualJsonCurrent[i].villagenameeng + "</td>"
//                            + "<td id='rightAlign'>" + ((individualJsonCurrent[i].elcono === "null") ? "-" : individualJsonCurrent[i].elcono) + "</td>"
//                            + "<td>" + individualJsonCurrent[i].nameeng + "</td>"
//                            + "<td id='rightAlign'>" + individualJsonCurrent[i].age + "</td>"
//                            + "<td>" + ((individualJsonCurrent[i].husbandname === "null") ? "-" : individualJsonCurrent[i].husbandname) + "</td>"
//                            + "<td>" + ((individualJsonCurrent[i].mobileno1 === "null") ? "-" : individualJsonCurrent[i].mobileno1) + "</td>"
//                            + "<td>" + convertToCustomDateFormat(individualJsonCurrent[i].lmp) + "</td>"
//                            + "<td>" + convertToCustomDateFormat(individualJsonCurrent[i].edd) + "</td>"
//                            + "<td class='center'>" + status + "</td>";
//                    tableBody.append(parsedData);
//                    tableBodyP.append(parsedData);
//                }
                $("#countTitle").show();
                $('#active').html("<span class='label label-flat label-success label-xs'><b>" + individual_active_current + "</b></span>");
                $('#due').html("<span class='label label-flat label-danger label-xs'><b>" + individual_due_current + "</b></span>");
                $('#all').html("<span class='label label-flat label-primary label-xs'><b>" + (individual_active_current + individual_due_current) + "</b></span>");
//                var table = $('#data-table').DataTable();
//                table.draw();

            } else if (viewType == "all") {
                renderData(individualJsonCurrent.concat(individualJsonCompleted));
                $("#countTitle").hide();
                $("#countTitle3").hide();
                $("#tableView").fadeIn("slow");
//                tableHeader.empty();
//                var parsedHeader = "<tr>"
//                        + "<th style='vertical-align: top;'>SL No.</th>"
//                        + "<th style='vertical-align: top;'>Village</th>"
//                        + "<th style='vertical-align: top;'>Elco No.</th>"
//                        + "<th style='vertical-align: top;'>Preg. Woman</th>"
//                        + "<th style='vertical-align: top;'>Age</th>"
//                        + "<th style='vertical-align: top;'>Husband</th>"
//                        + "<th style='vertical-align: top;'>Mobile</th>"
//                        + "<th style='vertical-align: top;'>LMP</th>"
//                        + "<th style='vertical-align: top;'>EDD</th>"
//                        + "<th style='vertical-align: top;' class='center'>Status</th>"
//                        + "</tr>";
//                tableHeader.append(parsedHeader);
//                tableHeaderP.append(parsedHeader);
//
//                var table = $('#data-table').DataTable();
//                table.destroy();
//                tableBody.empty();
//                var active = 0, due = 0, serialNo = 0;
//                for (var i = 0; i < individualJsonCurrent.length; i++) {
//                    $("#countTitle1").fadeIn("slow");
//                    var status = null;
//                    if (individualJsonCurrent[i].case === "OVER DUE") {
//                        status = "<span class='label label-flat label-danger label-xs'>&nbsp;&nbsp;Due&nbsp;&nbsp;</span>";
//                        due++;
//                    } else if (individualJsonCurrent[i].case === "ACTIVE") {
//                        status = "<span class='label label-flat label-success label-xs'>Active</span>";
//                        active++;
//                    }
//                    var parsedData = "<tr style='width:10px!importtant'><td>" + (i + 1) + "</td>"
//                            + "<td>" + individualJsonCurrent[i].villagenameeng + "</td>"
//                            + "<td id='rightAlign'>" + ((individualJsonCurrent[i].elcono === "null") ? "-" : individualJsonCurrent[i].elcono) + "</td>"
//                            + "<td>" + individualJsonCurrent[i].nameeng + "</td>"
//                            + "<td id='rightAlign'>" + individualJsonCurrent[i].age + "</td>"
//                            + "<td>" + ((individualJsonCurrent[i].husbandname === "null") ? "-" : individualJsonCurrent[i].husbandname) + "</td>"
//                            + "<td>" + ((individualJsonCurrent[i].mobileno1 === "null") ? "-" : individualJsonCurrent[i].mobileno1) + "</td>"
//                            + "<td>" + convertToCustomDateFormat(individualJsonCurrent[i].lmp) + "</td>"
//                            + "<td>" + convertToCustomDateFormat(individualJsonCurrent[i].edd) + "</td>"
//                            + "<td class='center'>" + status + "</td>";
//                    tableBody.append(parsedData);
//                    tableBodyP.append(parsedData);
//                    serialNo++;
//                }
//                for (var i = 0; i < individualJsonCompleted.length; i++) {
//                    var parsedData = "<tr style='width:10px!importtant'><td>" + (serialNo + i) + "</td>"
//                            + "<td>" + individualJsonCompleted[i].villagenameeng + "</td>"
//                            + "<td id='rightAlign'>" + ((individualJsonCompleted[i].elcono === "null") ? "-" : individualJsonCompleted[i].elcono) + "</td>"
//                            + "<td>" + individualJsonCompleted[i].nameeng + "</td>"
//                            + "<td id='rightAlign'>" + individualJsonCompleted[i].age + "</td>"
//                            + "<td>" + ((individualJsonCompleted[i].husbandname === "null") ? "-" : individualJsonCompleted[i].husbandname) + "</td>"
//                            + "<td>" + ((individualJsonCompleted[i].mobileno1 === "null") ? "-" : individualJsonCompleted[i].mobileno1) + "</td>"
//                            + "<td>" + convertToCustomDateFormat(individualJsonCompleted[i].lmp) + "</td>"
//                            + "<td>" + convertToCustomDateFormat(individualJsonCompleted[i].edd) + "</td>"
//                            + "<td class='center'><span class='label label-flat label-info label-xs'>Completed</span></td>";
//                    tableBody.append(parsedData);
//                    tableBodyP.append(parsedData);
//                }
                $("#countTitle1").show();
//                var sum = active + due + (individualJsonCompleted.length);
//                $('#active1').html("<span class='label label-flat label-success label-xs'><b>" + active + "</b></span>");
//                $('#due1').html("<span class='label label-flat label-danger label-xs'><b>" + due + "</b></span>");
//                $('#completed1').html("<span class='label label-flat label-info label-xs'><b>" + individualJsonCompleted.length + "</b></span>");
//                $('#all1').html("<span class='label label-flat label-primary label-xs'><b>" + sum + "</b></span>");
//                $("#countTitle1").show();
                $("#statusTotalCount").fadeIn("slow");
                var sum = individual_active_current + individual_due_current + (individualJsonCompleted.length);
                $('#active1').html("<span class='label label-flat label-success label-xs'><b>" + individual_active_current + "</b></span>");
                $('#due1').html("<span class='label label-flat label-danger label-xs'><b>" + individual_due_current + "</b></span>");
                $('#completed1').html("<span class='label label-flat label-info label-xs'><b>" + individualJsonCompleted.length + "</b></span>");
                $('#all1').html("<span class='label label-flat label-primary label-xs'><b>" + sum + "</b></span>");
//                var table = $('#data-table').DataTable();
//                table.draw();

            }
        });



        //======for different type of aggrate report======================================================================================================
        function generateAggregateTable(json, viewType) {
            var areaName = "";

            $("#transparentTextForBlank").css("display", "none"); //transparent emis text remove
            $("#tableView").fadeIn("slow");

            tableHeader.empty();
            var parsedHeader = "<tr>"
                    + "<th style='vertical-align: top;'>#</th>"
                    + "<th style='vertical-align: top;'>" + viewType + "</th>"
                    + "<th style='vertical-align: top;'>Registered Population</th>"
                    + "<th style='vertical-align: top;'>Registered Pregnant Woman</th>"
//                    + "<th style='vertical-align: top;'>Progress(%)</th>"
                    + "</tr>";
            tableHeader.append(parsedHeader);
            tableHeaderP.append(parsedHeader);

            var table = $('#data-table').DataTable();
            table.destroy();
            tableBody.empty();
            //------Bottom Sum------
            var registered_population_sum = 0, registered_pregnant_sum = 0, progress_sum = 0;
            //------------
            for (var i = 0; i < json.length; i++) {
                console.log("Out Of the if: " + json[i].unionname);

                if (viewType == "Upazila") {
                    areaName = json[i].upzilaname;

                } else if (viewType == "Union") {
                    areaName = json[i].unionname;
                    console.log("In the if: " + json[i].unionname);

                } else if (viewType == "Unit") {
                    areaName = getFWAUnit(json[i].unit);

                } else if (viewType == "Village") {
                    areaName = json[i].villagenameeng;

                } else {
                    areaName = "";
                }

                var parsedData = "<tr><td>" + (i + 1) + "</td>"
                        + "<td class='area'>" + areaName + "</td>"
                        + "<td id='rightAlign'>" + json[i].reg_pop + "</td>"
                        + "<td id='rightAlign'>" + ((json[i].reg_preg === "null") ? "0" : json[i].reg_preg) + "</td></tr>";
//                        + "<td> - </td>";
                tableBody.append(parsedData);
                tableBodyP.append(parsedData);
                ///fffff

                if (json[i].reg_pop != "null")
                    registered_population_sum += parseInt(json[i].reg_pop);

                if (json[i].reg_preg != "null")
                    registered_pregnant_sum += parseInt(json[i].reg_preg);
            }
            var footerData = "<tr> <td style='text-align:left' colspan='2'>Total</td>"
                    + "<td id='rightAlign'>" + registered_population_sum + "</td>"
                    + "<td id='rightAlign'>" + registered_pregnant_sum + "</td></tr>"
//            + "<td id='rightAlign'>-</td>";

            $('#tableFooter').append(footerData);
            $('#tableFooterP').append(footerData);

            var table = $('#data-table').DataTable();
            table.draw();

        }//end generateAggregateTable


    });//Jquery End

    function nullConverter(value) {

        if (value === "null")
            return "-";
        else
            return value;
    }

    function getAreaText() {
        var areaText = null;
        var division = " Division: <b style='color:#3C8DBC'>" + $("#division option:selected").text() + "</b>";
        var district = " District: <b style='color:#3C8DBC'>" + $("#district option:selected").text() + "</b>";
        var upazila = "Upazila: <b style='color:#3C8DBC'>" + $("#upazila option:selected").text() + "</b>";
        var union = "Union: <b style='color:#3C8DBC'>" + $("#union option:selected").text() + "</b>";
        var unit = "Unit: <b style='color:#3C8DBC'>" + $("#unit option:selected").text() + "</b>";
        var village = "Village: <b style='color:#3C8DBC'>" + $("#village option:selected").text() + "</b>";
        var sDate = "From: <b style='color:#3C8DBC'>" + $("#startDate").val() + "</b>";
        var eDate = "To: <b style='color:#3C8DBC'>" + $("#endDate").val() + "</b>";
        areaText = division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + union + '&nbsp;&nbsp;' + unit + '&nbsp;&nbsp;' + village + '&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate;
        return  areaText;
    }

</script>