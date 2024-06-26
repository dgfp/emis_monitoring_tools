<%-- 
    Document   : deathUpdated
    Created on : Aug 9, 2017, 1:05:50 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/area_dropdown_control_by_user.js"></script>
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
</style>
<script>
    var startDate=null;
    function convertToCustomDateFormat(dateString) {
        var parts = dateString.split("-");
        var year = parts[0];
        var month = parts[1];
        var date = parts[2];
        return date + "/" + month + "/" + year;
    }
    function getFWAUnit(value) {
        var unit=null;
        if(value=='01'){
            unit="1";
        }else if(value=='02'){
            unit="1KA";
        }else if(value=='03'){
            unit="1KHA";
        }else if(value=='04'){
            unit="1GA";
        }else if(value=='05'){
            unit="2";
        }else if(value=='06'){
            unit="2KA";
        }else if(value=='07'){
            unit="2KHA";
        }else if(value=='08'){
            unit="2GA";
        }else if(value=='09'){
            unit="3";
        }else if(value=='10'){
            unit="3KA";
        }else if(value=='11'){
            unit="3KHA";
        }else if(value=='12'){
            unit="3GA";
        }else{
            unit="-";
        }

        return unit;
    }
    $(document).ready(function () {
        if($('#userCategory').val()=='1' || $('#userCategory').val()=='2'){
            $("#communityStatisticsAccessHF").css("display", "none");
        }
        
        $("#areaDropDownPanel").slideDown("slow"); //Show area dropdowns panel by jquery slideDown
        var regExp = /(\d{1,2})\/(\d{1,2})\/(\d{2,4})/; //for date compare
        var defaultStartDate="01/01/2014"; //for default date
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
            frame1.css({ "position": "absolute", "top": "-1000000px" });
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
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center!important;"><center>Infant registration coverage for EPI</center></h3>');
            frameDoc.document.write('<h5 style="color:black;text-align:center!important;"><center>'+getAreaText()+'</center></h5>');
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
            var outputFile = "eMIS_births";
            outputFile = outputFile.replace('.txt','') + '.txt';
            exportTableToText.apply(this, [$('#dvData > table'), outputFile]); //function call from TemplateHeader
        });
        
//================================================END===================================== 
        
        
        $('#showdataButton').click(function () {
            $("#tableView").fadeOut("slow");
            var divisionId=$("select#division").val();
            var districtId=$("select#district").val();
            var upazilaId=$("select#upazila").val();
            var unionId=$("select#union").val();
            var unitId=$("select#unit").val();
            var villageId=$("select#village").val();
        
            var tableBody = $('#tableBody');
            tableBody.empty();
            
             if( $("select#division").val()=="" || $("select#division").val()==0){
                toastr["error"]("<h4><b>Please select division</b></h4>");
                return ;
            }else if( $("select#district").val()=="" || $("select#district").val()==0){
                toastr["error"]("<h4><b>Please select district</b></h4>");
                return ;
            }else if($("#endDate").val()==""){
                toastr["error"]("<h4><b>Please select End Date</b></h4>");
                return;
            }else if(parseInt($("#startDate").val().replace(regExp, "$3$2$1")) > parseInt($("#endDate").val().replace(regExp, "$3$2$1"))){
                toastr["error"]("<h4><b>Start date should be smaller than end date</b></h4>");
                return;
            }else{
                //Get report type
                var reportType=null;
                if($("input[type='radio']#reportType").is(':checked')) {
                    reportType= $("input[type='radio']#reportType:checked").val();
                }
                //Set start Date
                startDate=$("#startDate").val();
                if( startDate===""){
                    startDate=defaultStartDate;
                }
                //Clear previous table data
                tableHeader.empty();
                tableBody.empty(); 
                tableFooter.empty();
                tableHeaderP.empty();
                tableBodyP.empty(); //first empty table before showing data
                tableFooterP.empty();

                if (reportType=== "individual") {
                    if( $("select#district").val()=="" || $("select#district").val()==0){
                        toastr["error"]("<h4><b>Please select district</b></h4>");
                        return ;
                    }
                        var btn = $(this).button('loading');
                        Pace.track(function(){
                            $.ajax({
                                url: "immunization_infant?action=Individual",
                                data: {
                                    districtId: $("select#district").val()=='0'? "" : $("select#district").val(),
                                    upazilaId: $("select#upazila").val()=='0'? "" : $("select#upazila").val(),
                                    unionId: $("select#union").val()=='0'? "" : $("select#union").val(),
                                    unitId: $("select#unit").val()=='0'? "" : $("select#unit").val(),
                                    villageId: $("select#village").val()=='0'? "" : $("select#village").val(),
                                    startDate: startDate,
                                    endDate: $("#endDate").val()
                                },
                                type: 'POST',
                                success: function (result) {

                                    var json = JSON.parse(result);

                                    if (json.length === 0) {
                                        btn.button('reset');
                                        toastr["error"]("<h4><b>No data found</b></h4>");
                                        return;
                                    }
                                    $("#transparentTextForBlank").css("display","none");
                                    //show table view after data load
                                    $("#tableView").fadeIn("slow");
                                    
                                    tableHeader.empty();
                                    var parsedHeader = "<tr>"
                                            + "<th style='vertical-align: top;'>SL No.</th>"
//                                            + "<th style='vertical-align: top;'>Upazila</th>"
//                                            + "<th style='vertical-align: top;'>Union</th>"
                                            + "<th style='vertical-align: top;'>Village</th>"
                                            + "<th style='vertical-align: top;'>Name</th>"
                                            + "<th style='vertical-align: top;'>Mother's Name</th>"
                                            + "<th style='vertical-align: top;'>Father Name</th>"
                                            + "<th style='vertical-align: top;'>Mobile</th>"
                                            + "<th style='vertical-align: top;'>Date of Birth</th>"
                                            + "</tr>";
                                    tableHeader.append(parsedHeader);
                                    tableHeaderP.append(parsedHeader);

                                    var table = $('#data-table').DataTable(); 
                                    table.destroy();
                                    tableBody.empty();
                                    console.log(json);
                                    for (var i = 0; i < json.length; i++) {

                                        var fatherName = nullConverter(json[i].fathername);
                                        var motherName = nullConverter(json[i].mothername);

                                        var parsedData = "<tr><td>" + (i + 1) + "</td>"
//                                                + "<td>" + json[i].upzila + "</td>"
//                                                + "<td>" + json[i].union + "</td>"
                                                + "<td>" + json[i].village + "</td>"
                                                + "<td>" + json[i].name + "</td>"
                                                + "<td>" + motherName + "</td>"
                                                + "<td>" + fatherName + "</td>"
                                                + "<td>" + nullConverter(json[i].mobileno) + "</td>"
                                                + "<td>" + moment(json[i].dob).format('DD MMM YYYY') + "</td>";

                                        tableBody.append(parsedData);
                                        tableBodyP.append(parsedData);
                                    }
                                    var table = $('#data-table').DataTable();
                                    table.draw();
                                    btn.button('reset');
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    btn.button('reset');
                                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                                }
                            });//End Ajax
                        }); //end pace
                    
                }else if (reportType === "aggregate") {
                    
                    //Upazila wise aggregate=============================================================
                    if(upazilaId=="0"){
                        var btn = $(this).button('loading');
                        Pace.track(function(){
                            $.ajax({
                                url: "immunization_infant?action=AggregateUpazila",
                                data: {
                                    districtId: $("select#district").val(),
                                    startDate: startDate,
                                    endDate: $("#endDate").val()
                                },
                                type: 'POST',
                                success: function (result) {

                                    var json=null;
                                    json = JSON.parse(result);
                                    btn.button('reset');

                                    if (json.length === 0) {
                                        toastr["error"]("<h4><b>No data found</b></h4>");
                                        return;
                                    }else{
                                        generateAggregateTable(json,"Upazila");
                                    }
                                    

                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    btn.button('reset');
                                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                                }
                            }); //End Ajax Request 
                        }); //End Pace 
                        
                    //Union wise aggregate    
                    }else if(unionId=="0"){
                        var btn = $(this).button('loading');
                        Pace.track(function(){
                            $.ajax({
                                url: "immunization_infant?action=AggregateUnion",
                                data: {
                                    districtId: $("select#district").val(),
                                    upazilaId: $("select#upazila").val(),
                                    startDate: startDate,
                                    endDate: $("#endDate").val()
                                },
                                type: 'POST',
                                success: function (result) {

                                     var json=null;
                                    json = JSON.parse(result);
                                    btn.button('reset');

                                    if (json.length === 0) {
                                        toastr["error"]("<h4><b>No data found</b></h4>");
                                        return;
                                    }else{
                                        generateAggregateTable(json,"Union");
                                    }

                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    btn.button('reset');
                                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                                }
                            }); //End Ajax Request 
                        }); //End Pace 
                       
                    //Unit wise aggregate    
                    }else if(unitId=="0"){
                        var btn = $(this).button('loading');
                        Pace.track(function(){
                            $.ajax({
                                url: "immunization_infant?action=AggregateUnit",
                                data: {
                                    districtId: $("select#district").val(),
                                    upazilaId: $("select#upazila").val(),
                                    unionId: $("select#union").val(),
                                    startDate: startDate,
                                    endDate: $("#endDate").val()
                                },
                                type: 'POST',
                                success: function (result) {

                                     var json=null;
                                    json = JSON.parse(result);
                                    btn.button('reset');

                                    if (json.length === 0) {
                                        toastr["error"]("<h4><b>No data found</b></h4>");
                                        return;
                                    }else{
                                        generateAggregateTable(json,"Unit");
                                    }

                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    btn.button('reset');
                                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                                }
                            }); //End Ajax Request 
                        }); //End Pace 
                        
                    }else if(villageId=="0"){
                        var btn = $(this).button('loading');
                        Pace.track(function(){
                            $.ajax({
                                url: "immunization_infant?action=AggregateVillage",
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

                                     var json=null;
                                    json = JSON.parse(result);
                                    btn.button('reset');

                                    if (json.length === 0) {
                                        toastr["error"]("<h4><b>No data found</b></h4>");
                                        return;
                                    }else{
                                        generateAggregateTable(json,"Village");
                                    }

                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    btn.button('reset');
                                    toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                                }
                            }); //End Ajax Request 
                        }); //End Pace 
                        
                    }else{
                        toastr["error"]("<h4><b>Please select all village</b></h4>");
                    }
                }

                }
                /*
                
                
                var startDate=$("#startDate").val();
                if( startDate==""){
                    startDate="01/01/2015"; 
                }
                
                var btn = $(this).button('loading');
                Pace.track(function(){
                    $.ajax({
                        url: "births",
                        data: {
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            villageId: $("select#village").val(),
                            startDate: startDate,
                            endDate: $("#endDate").val()
                        },
                        type: 'POST',
                        success: function (result) {

                            var json = JSON.parse(result);

                            if (json.length === 0) {
                                btn.button('reset');
                                toastr["error"]("<h4><b>No data found</b></h4>");
                                return;
                            }

                            for (var i = 0; i < json.length; i++) {

                                var fatherName = nullConverter(json[i].fathername);
                                var motherName = nullConverter(json[i].mothername);
                                var placeofbirth = nullConverter(json[i].placeofbirth);

                                var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                        + "<td>" + json[i].upzila + "</td>"
                                        + "<td>" + json[i].union + "</td>"
                                        + "<td>" + json[i].village + "</td>"
                                        + "<td>" + json[i].name + "</td>"
                                        + "<td>" + motherName + "</td>"
                                        + "<td>" + fatherName + "</td>"
                                        + "<td>" + json[i].dob + "</td>"
                                        + "<td>" + placeofbirth + "</td></tr>";

                                tableBody.append(parsedData);
                            }

                            btn.button('reset');
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    });//End Ajax
                }); //end pace
            }//end else
            */
            
        }); //end button click
        
        
        
        //======for different type of aggrate report======================================================================================================
        function generateAggregateTable(json,viewType){
            var areaName="";

            $("#transparentTextForBlank").css("display","none"); //transparent emis text remove
            $("#tableView").fadeIn("slow");

            tableHeader.empty();
            var parsedHeader = "<tr>"
                    + "<th style='vertical-align: top;'>SL No.</th>"
                    + "<th style='vertical-align: top;'>"+viewType+"</th>"
                    + "<th style='vertical-align: top;'>Registered Population</th>"
                    + "<th style='vertical-align: top;'>Registered Infant</th>"
                    + "<th style='vertical-align: top;'>Progress(%)</th>"
                    + "</tr>";
            tableHeader.append(parsedHeader);
            tableHeaderP.append(parsedHeader);

            var table = $('#data-table').DataTable(); 
            table.destroy();
            tableBody.empty();
            //------Bottom Sum------
            var registered_population_sum = 0, reg_infant_sum = 0, progress_sum= 0;
            //----------------------
            for (var i = 0; i < json.length; i++) {
                
                if(viewType=="Upazila"){
                    areaName=json[i].upzilaname;

                }else if(viewType=="Union"){
                    areaName=json[i].unionname;

                }else if(viewType=="Unit"){
                    areaName=getFWAUnit(json[i].unit);

                }else if(viewType=="Village"){
                    areaName=json[i].villagenameeng;

                }else{
                    areaName="";
                }

                var parsedData = "<tr><td>" + (i + 1) + "</td>"
                        + "<td>" + areaName + "</td>"
                        + "<td>" + json[i].reg_pop + "</td>"
                        + "<td>" + ((json[i].reg_infant === "null") ? "0" : json[i].reg_infant) + "</td>"
                        + "<td> - </td>";
                tableBody.append(parsedData);
                tableBodyP.append(parsedData);


                if(json[i].reg_pop != "null")
                    registered_population_sum += parseInt(json[i].reg_pop);

                if(json[i].reg_infant != "null")
                    reg_infant_sum += parseInt(json[i].reg_infant);
            }
            var footerData = "<tr> <td style='text-align:left' colspan='2'>Total</td>"
            + "<td id='rightAlign'>" + registered_population_sum + "</td>"
            + "<td id='rightAlign'>" + reg_infant_sum + "</td>"
            + "<td id='rightAlign'>-</td>";

            $('#tableFooter').append(footerData);
            $('#tableFooterP').append(footerData);

            var table = $('#data-table').DataTable();
            table.draw();

        }//end generateAggregateTable function


    });

    function nullConverter(value) {

        if (value === "null")
            return "-";
        else
            return value;
    }
    function getAreaText(){
        var areaText=null;
        var division=" Division: <b style='color:#3C8DBC'>"+ $("#division option:selected").text()+"</b>";
        var district=" District: <b style='color:#3C8DBC'>"+ $("#district option:selected").text()+"</b>";
        var upazila="Upazila: <b style='color:#3C8DBC'>"+ $("#upazila option:selected").text()+"</b>";
        var union="Union: <b style='color:#3C8DBC'>"+ $("#union option:selected").text()+"</b>";
        var unit="Unit: <b style='color:#3C8DBC'>"+ $("#unit option:selected").text()+"</b>";
        var village="Village: <b style='color:#3C8DBC'>"+ $("#village option:selected").text()+"</b>";
        var sDate="From: <b style='color:#3C8DBC'>"+ startDate+ "</b>";
        var eDate="To: <b style='color:#3C8DBC'>"+ $("#endDate").val()+"</b>";
        areaText=division +',&nbsp;&nbsp;'+ district +',&nbsp;&nbsp;'+ upazila +',&nbsp;&nbsp;'+union+'&nbsp;&nbsp;'+unit+'&nbsp;&nbsp;'+village+'&nbsp;&nbsp;'+sDate+'&nbsp;&nbsp;'+eDate;
        return  areaText;
    }
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1><span style="color:#4fef2f;"><i class="fa fa-check-circle" aria-hidden="true"></i></span> Infant registration coverage for EPI</h1>
  <ol class="breadcrumb" id="communityStatisticsAccessHF">
    <a class="btn btn-flat btn-info btn-sm" href="immunization_infant"><i class="fa fa-users" aria-hidden="true"></i> <b>&nbsp;Family Planning</b></a>
    <a class="btn btn-flat btn-primary btn-sm" href="immunization_infant_ha">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-heartbeat" aria-hidden="true"></i> <b>&nbsp;Health&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></a>
  </ol>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area & Data Table----------------------------------->
    <%@include file="/WEB-INF/jspf/communityAreaWithTable.jspf" %>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>