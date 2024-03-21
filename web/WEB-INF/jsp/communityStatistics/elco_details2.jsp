<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_elco.js"></script>
<style>
    #villDiv{
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
    [class*="col"] { margin-bottom: 10px; }
    span.td {
        border-top-color: #e0e0e0;
    }
</style>
<script>
    var areaText="";
    var p = "";
    var a = [];
    function convertToCustomDateFormat(dateString) {
        var parts = dateString.split("-");
        var year = parts[0];
        var month = parts[1];
        var date = parts[2];
        return date + "/" + month + "/" + year;
    }
    
    $(document).ready(function () {
            $("#areaDropDownPanel").slideDown("slow"); //Show area dropdowns panel by jquery slideDown
        
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
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center!important;"><center>ELCO registration coverage</center></h3>');
            frameDoc.document.write('<h5 style="color:black;text-align:center!important;"><center>'+areaText+'</center></h5>');
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
            var outputFile = "eMIS_elco_registration_coverage";
            outputFile = outputFile.replace('.txt','') + '.txt';
            exportTableToText.apply(this, [$('#dvData > table'), outputFile]); //function call from TemplateHeader
        });
        $("#exportCSV").click(function (event) {
            var outputFile = "eMIS_elco_registration_coverage ";
            outputFile = outputFile.replace('.csv', '') + '.csv';
            exportTableToCSV.apply(this, [$('#dvData > table'), outputFile]); //function call from TemplateHeader
        });
        
//================================================END=====================================        
        
        


        $('#showdataButton').click(function () {
            $("#tableView").fadeOut();
            //$("#tableView").css("display", "none");
            
            var defaultStartDate="01/01/2015"; //for default date
            var regExp = /(\d{1,2})\/(\d{1,2})\/(\d{2,4})/; //for date compare
            var tableHeader = $('#tableHeader');
            var tableBody = $('#tableBody');
            var tableFooter = $('#tableFooter');
            //For export(print) data
            var tableHeaderP = $('#tableHeaderP');
            var tableBodyP = $('#tableBodyP');
            var tableFooterP = $('#tableFooterP');
            
            var startDate = $("#startDate").val()==="" ? defaultStartDate : $("#startDate").val();
            var endDate = $("#endDate").val();
            
            //Check end Date
             var date = endDate.substring(0, 2);
            var month = endDate.substring(3, 5);
            var year = endDate.substring(6, 10);
            var myDate = new Date(year, month - 1, date);
            var today = new Date();
            //end 
            var date = "";  //endDate.toISOString().slice(0,10);
            
            if($("select#district").val()===""){
                toastr["error"]("<h4><b>Please select district</b></h4>");
                return;
            }else if($("select#upazila").val()===""){
                toastr["error"]("<h4><b>Please select upazila</b></h4>");
                return;
                
            }else if(parseInt(startDate.replace(regExp, "$3$2$1")) > parseInt(endDate.replace(regExp, "$3$2$1"))){
                toastr["error"]("<h4><b>Start date should be smaller than end date</b></h4>");
                return;
            }else if(myDate > today){
                toastr["error"]("<h4><b>End date should not greater than todays date</b></h4>");
                return;
            }
            
            var reportType=null;
            if($("input[type='radio']#reportType").is(':checked')) {
                reportType= $("input[type='radio']#reportType:checked").val();
            }
            
            tableHeader.empty();
            tableBody.empty(); //first empty table before showing data
            tableFooter.empty();
            tableHeaderP.empty();
            tableBodyP.empty(); //first empty table before showing data
            tableFooterP.empty();
            
            var btn = $(this).button('loading');
            //Individual
            if (reportType=== "overall") {
                endDate = endDate.split("/");
                endDate=endDate[2]+"-"+endDate[1]+"-"+endDate[0];

                startDate = startDate.split("/");
                startDate=startDate[2]+"-"+startDate[1]+"-"+startDate[0];
                
                Pace.track(function(){
                    $.ajax({
                        url: "elco_details2?action=Individual",
                        data: {
                            districtId:  $("select#district").val()=='0'? "" : $("select#district").val(),
                            upazilaId:  $("select#upazila").val()=='0'? "" : $("select#upazila").val(),
                            unionId:  $("select#union").val()=='0'? "" : $("select#union").val(),
                            unitId: $("select#unit").val()=='0'? "" : $("select#unit").val(),
                            villageId: $("select#village").val()=='0'? "" : $("select#village").val(),
                            startDate: startDate,
                            endDate: endDate
                        },
                        type: 'POST',
                        success: function (result) {
                             var json=null;

                            json = JSON.parse(result);
                            btn.button('reset');

                            if (json.length === 0) {
                                toastr["error"]("<h4><b>No data found</b></h4>");
                                return;
                            }
                            $("#transparentTextForBlank").css("display","none");
                            //show table view after data load
                            $("#tableView").fadeIn("slow");
                            //Show locations title when area panel is minimize or in export data
                            var division=" Division: <b style='color:#3C8DBC'>"+ $("#division option:selected").text()+"</b>";
                            var district=" District: <b style='color:#3C8DBC'>"+ $("#district option:selected").text()+"</b>";
                            var upazila="Upazila: <b style='color:#3C8DBC'>"+ $("#upazila option:selected").text()+"</b>";
                            var union="Union: <b style='color:#3C8DBC'>"+ $("#union option:selected").text()+"</b>";
                            var unit="Unit: <b style='color:#3C8DBC'>"+ $("#unit option:selected").text()+"</b>";
                            var village="Village: <b style='color:#3C8DBC'>"+ $("#village option:selected").text()+"</b>";
                            var sDate="From: <b style='color:#3C8DBC'>"+ $("#startDate").val() + "</b>";
                            var eDate="To: <b style='color:#3C8DBC'>"+ $("#endDate").val() +"</b>";
                            areaText=division +',&nbsp;&nbsp;'+ district +',&nbsp;&nbsp;'+ upazila +',&nbsp;&nbsp;'+union+'&nbsp;&nbsp;'+unit+'&nbsp;&nbsp;'+village+'&nbsp;&nbsp;'+sDate+'&nbsp;&nbsp;'+eDate;
                                
                                
                            
                            tableHeader.empty();
                            var parsedHeader = "<tr>"
                                    + "<th style='vertical-align: top;'>SL No.</th>"
                                    + "<th style='vertical-align: top;'>Village</th>"
                                    + "<th style='vertical-align: top;'>Elco No</th>"
                                    + "<th style='vertical-align: top;'>ELCO Name</th>"
                                    + "<th style='vertical-align: top;'>Age</th>"
                                    + "<th style='vertical-align: top;'>Husband</th>"
                                    +"<th style='vertical-align: top;'>Mobile</th>"
                                    +"<th style='vertical-align: top;'>Current Status</th>"
                                    +"<th style='vertical-align: top;'>Last Visit Date</th>"
                                    //+"<th>EDD</th>"
                                    + "</tr>";
                        
                            tableHeader.append(parsedHeader);
                            tableHeaderP.append(parsedHeader);
                            
                            var table = $('#data-table').DataTable(); 
                            table.destroy();
                            tableBody.empty();
                            for (var i = 0; i < json.length; i++) {
                                var vDate=json[i].vdate;
                                vDate=vDate.split("-");
                                vDate=vDate[2]+"/"+vDate[1]+"/"+vDate[0];
                            var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                    + "<td>" + json[i].village + "</td>"
                                    + "<td>" + ((json[i].elcono === "null") ? "-" : json[i].elcono) + "</td>"
                                    + "<td>" + json[i].elconame + "</td>"
                                    + "<td>" + ((json[i].age === "null") ? "-" : json[i].age) + "</td>"
                                    + "<td>" + ((json[i].husband === "null") ? "-" : json[i].husband) + "</td>"
                                    + "<td>" + ((json[i].mobileno === "null") ? "-" : json[i].mobileno) + "</td>"
                                    + "<td>" + ((json[i].evname === "null") ? "-" : json[i].evname) + "</td>"
                                    + "<td>" + ((json[i].vdate === "null") ? "-" : vDate) + "</td>";
                            tableBody.append(parsedData);
                            tableBodyP.append(parsedData);
                            }
                            
                            var table = $('#data-table').DataTable();
                            table.draw();                     
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(jqXHR+" ~   "+textStatus+"  ~   "+errorThrown);
                            btn.button('reset');
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    }); //End Ajax Request 
                }); //End Pace 
            }else if (reportType === "providerWise") {
                
                var unit= $('#unit :selected').text().split(" ");  //$("select#unit").val().split("[");
                //alert(unit[0]);
                //alert(Number(unitId));

                Pace.track(function(){
                    $.ajax({
                        url: "elco_details2?action=Aggregate",
                        data: {
                            districtId:  $("select#district").val(),
                            upazilaId:  $("select#upazila").val()=='0'? "" : $("select#upazila").val(),
                            unionId:  $("select#union").val()=='0'? "" : $("select#union").val(),
                            unitId: $("select#unit").val()=='0'? "" : $("select#unit").val(), //$("select#unit").val(), //Number($("select#unit").val()),//unit[0]==="All" ? "%" : unit[0],//$("select#unit").val(),
                            startDate: $("#startDate").val(),
                            endDate: endDate

                        },
                        type: 'POST',
                        success: function (result) {
                            var json = JSON.parse(result);
                            if (json.length === 0) {
                                btn.button('reset');
                                toastr["error"]("<h4><b>No data found</b></h4>");
                                return;
                            }
                            console.log(json);
                            $("#transparentTextForBlank").css("display","none");
                            $("#tableView").fadeIn("slow");
                            //Show locations title when area panel is minimize or in export data
                            var division=" Division: <b style='color:#3C8DBC'>"+ $("#division option:selected").text()+"</b>";
                            var district=" District: <b style='color:#3C8DBC'>"+ $("#district option:selected").text()+"</b>";
                            var upazila="Upazila: <b style='color:#3C8DBC'>"+ $("#upazila option:selected").text()+"</b>";
                            var union="Union: <b style='color:#3C8DBC'>"+ $("#union option:selected").text()+"</b>";
                            var unit="Unit: <b style='color:#3C8DBC'>"+ $("#unit option:selected").text()+"</b>";
                            var village="Village: <b style='color:#3C8DBC'>"+ $("#village option:selected").text()+"</b>";
                            var sDate="From: <b style='color:#3C8DBC'>"+$("#startDate").val()+ "</b>";
                            var eDate="To: <b style='color:#3C8DBC'>"+ $("#endDate").val() +"</b>";
                            areaText=division +',&nbsp;&nbsp;'+ district +',&nbsp;&nbsp;'+ upazila +',&nbsp;&nbsp;'+union+'&nbsp;&nbsp;'+unit+'&nbsp;&nbsp;'+village+'&nbsp;&nbsp;'+sDate+'&nbsp;&nbsp;'+eDate;
                                
                                
                            var parsedHeader = "<tr>"
                                        + "<th style='vertical-align: top;'>#</th>"
                                        + "<th style='vertical-align: top;'>Union</th>"
                                        + "<th style='vertical-align: top;'>Unit</th>"
                                        + "<th style='vertical-align: top;width: 220px!important'>Provider</th>"
                                        + "<th style='vertical-align: top;'>Household Reg.</th>"
                                        + "<th style='vertical-align: top;'>Elco (Paper Reg.)</th>"
                                        + "<th style='vertical-align: top;'>Elco (Tab)</th>"
                                        + "<th style='vertical-align: top;'>Progress (%)</th>"
                                        + "<th style='vertical-align: top;'>Area Total</th>"
                                    + "</tr>";

                            tableHeader.append(parsedHeader);
                            tableHeaderP.append(parsedHeader);
                            
                            var table = $('#data-table').DataTable(); 
                            table.destroy();
                            tableBody.empty();

                            var paperSum=0, householdSum=0, tabSum = 0, areaSum=0;
                            for (var i = 0; i < json.length; i++) {
                                
                                var progress=( (parseInt(json[i].totalelco) || 0) / (parseInt(json[i].totalelcokhata) || 0)  )*100;
                                
                                var provider = "", household = "", elco = "", paper = "";
                                p = "";
                                a = [];
                                
                                $.each( json[i].provname, function( key, value ) {
                                        provider+="<span class='td'>"+value+" ( "+ json[i].providerid[key] +" )</span>\n";
                                });
                                $.each( json[i].hhh, function( key, value ) {
                                        household+="<span class='td'>"+value+"</span>\n";
                                        householdSum = householdSum+value;
                                });
                                $.each( json[i].totalelcokhata, function( key, value ) {
                                        paper+="<span class='td'>"+value+"</span>\n";
                                        paperSum = paperSum + value;
                                        a.push(value);
                                });
                                $.each( json[i].totalelco, function( key, value ) {
                                        elco+="<span class='td'>"+value+"</span>\n";
                                        tabSum = tabSum + value;
                                        p+="<span class='td'>"+ Math.round(finiteFilter(( (parseInt(value) || 0) / (parseInt(a[key]) || 0)  )*100))+"</span>\n";
                                });
                                
                                
//                                if(json[i].provname.length>1){
//                                    $.each( json[i].provname, function( key, value ) {
//                                        prov+="<span class='td'>"+value+"</span>";
//                                        //console.log( key + ": " + value );
//                                      });
//                                }else{
//                                    prov = 
//                                }
                                
                                //pSum+=json[i].totalelcosum;
                                var parsedData = "<tr id='centerAlign'><td>" + (i + 1) + "</td>"
                                        + "<td id='centerAlign'>" + json[i].unionname + "</td>"
                                        + "<td id='centerAlign'>" + $.app.getUnit(json[i].unit,0) + "</td>"
                                        //+ "<td id='rightAlign'>" + json[i].provname +"("+json[i].providerid + ")</td>"
                                         + "<td id='centerAlign' class='p0'>" + provider + "</td>"
                                        + "<td id='rightAlign' class='p0'>" + household+ "</td>"
                                        
                                         + "<td id='rightAlign' class='p0'>" + paper + "</td>"
                                        + "<td id='rightAlign' class='p0'>" + elco + "</td>"
//                                        + "<td id='rightAlign'>" + (parseInt(json[i].totalelcokhata) || 0) + "</td>"
//                                        + "<td id='rightAlign'>" + (parseInt(json[i].totalelco) || 0) + "</td>"
//                                        + "<td id='rightAlign'>"+Math.round(finiteFilter(progress))+" </td>"
                                        + "<td id='rightAlign' class='p0'>"+p+" </td>"
                                + "<td id='rightAlign'>" + json[i].totalelcosum + "</td> </tr>";
                                
                                    areaSum = areaSum + json[i].totalelcosum

                                tableBody.append(parsedData);
                                tableBodyP.append(parsedData);
                            }
                            
                            
                            var cal = new Calc(json);

                            var footerData = "<tr> <td style='text-align:left' colspan='4'>Total</td>"
                                    + "<td id='rightAlign'>" + householdSum + "</td>"
                                    + "<td id='rightAlign'>" + paperSum + "</td>"
                                    + "<td id='rightAlign'>" + tabSum + "</td>"
                                    + "<td id='rightAlign'>" + Math.round(finiteFilter(( tabSum / paperSum )*100)) + " </td>"
//                                    + "<td id='rightAlign'>-</td>"
                                    + "<td id='rightAlign'>" + areaSum + " </td>";

                            $('#tableFooter').append(footerData);
                            $('#tableFooterP').append(footerData);
                            btn.button('reset');
                            
                            $("#data-table").DataTable();
                            
                            
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(jqXHR.statusText+" ~   "+textStatus+"  ~   "+errorThrown);
                            btn.button('reset');
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    }); //End Ajax Request
                }); //End Pace Loading
            
            }
        
        });
    });
</script>
<!-- Content Header (Page header) -->
<section class="content-header"> 
      <h1><span style="color:#4fef2f;"><i class="fa fa-check-circle" aria-hidden="true"></i></span>
          ELCO registration coverage<small>updated</small></h1>
</section>

<!-- Main content -->
<section class="content">
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
          <div class="box-body">
            <input type="hidden" value="${userLevel}" id="userLevel">
            <div class="row">
                <div class="col-md-1 col-xs-2">
                    <label for="district">Division</label>
                </div>
                <div class="col-md-2 col-xs-4">
                    <select class="form-control input-sm" name="division" id="division"> 
                        <option value="">- Select Division -</option>
                    </select>
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
                        <option value="">- Select Union -</option>
                    </select>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-1 col-xs-2">
                    <label for="unit">Unit</label>
                </div>
                <div class="col-md-2 col-xs-4">
                    <select class="form-control input-sm" name="unit" id="unit" >
                        <option value="">- select Unit -</option>
                    </select>
                </div>
                
                <span id="villDiv">
                    <div class="col-md-1 col-xs-2">
                        <label for="village">Village</label>
                    </div>
                    <div class="col-md-2 col-xs-4">
                        <select class="form-control input-sm" name="village" id="village" >
                            <option value="">- select Village -</option>
                        </select>
                    </div>
                </span>
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
                <div class="col-md-1 col-xs-2">
                    <label for="reportType">Report Type</label>
                </div>
                <div class="col-md-2 col-xs-4" id="radioDiv">
                    <span><input class="providerWise" type="radio"  id="reportType" name="reportType" value="providerWise" checked="checked"> Aggregate </span><br>
                    <span><input class="overall" type="radio"  id="reportType" name="reportType" value="overall" disabled="true"> Individual</span>
                </div>
                <div class="col-md-1 col-xs-2">
                    <label for="one" id=""></label>
                </div>
                <div class="col-md-2 col-xs-4">
                    <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off">
                        <i class="fa fa-bar-chart" aria-hidden="true"></i> View Data
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
    
    <!--Elco Data Table-->
    <div class="box box-primary" id="tableView">
        <div class="box-header with-border" style="margin-top: -8px;margin-bottom: -5px!important;">
            <h3 class="box-title"><b><span id="prsTypeTitleForTable"></span></b></h3>
                <div class="box-tools pull-right" style="margin-top: 0px;">
                    <button id="printTableBtn" type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
<!--                    <a href="#" id ="exportCSV" role='button' class="btn btn-box-tool"><i class="fa fa-file-excel-o" aria-hidden="true"></i>&nbsp;CSV</a>-->
                    <a href="#" id ="exportText" role='button' class="btn btn-box-tool"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Text</a>
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                </div>
        </div>

            <div class="box-body">
                <div class="table-responsive fixed" >
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
            <div class="box-body"  id="printTable">
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