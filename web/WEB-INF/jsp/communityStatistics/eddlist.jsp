<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/area_dropdown_controls_preg.js"></script>
<script src="resources/TemplateJs/chart/exporting.js" type="text/javascript"></script>
<script src="resources/TemplateJs/export/jquery.tabletoCSV.js" type="text/javascript"></script>
<style>
    .center{
        text-align: center;
    }
    #statusTotalCount{
        display: none;
        margin-bottom: -20px;
    }
    #tableView{
         display: none;       
    }
</style>
<script>
    function convertToCustomDateFormat(dateString) {
        var parts = dateString.split("-");
        var year = parts[0];
        var month = parts[1];
        var date = parts[2];
        return date + "/" + month + "/" + year;
    }
    var areaText="";
    $(document).ready(function () {
        
        var defaultStartDate="2014-01-01"; //for default date
        var tableHeader = $('#tableHeader');
        var tableBody = $('#tableBody');
        var tableFooter = $('#tableFooter');



        $('#showdataButton').click(function () {
            $("#tableView").fadeOut("slow");
            if($("select#district").val()===""){
                toastr["error"]("<h4><b>Please select district</b></h4>");
                return;
            }else if($("select#upazila").val()===""){
                toastr["error"]("<h4><b>Please select upazila</b></h4>");
                return;
            }
            
           
            var reportType=null;
            if($("input[type='radio']#reportType").is(':checked')) {
                reportType= $("input[type='radio']#reportType:checked").val();
            }
            
            tableHeader.empty();
            tableBody.empty(); //first empty table before showing data
            tableFooter.empty();
            


            if (reportType=== "individual") {
                //var mouzaVill=$("select#village").val();
                var mouzaId=null;
                var villageId=null;
                if($("select#village").val().length!==0){
                    var VillMouza=$("select#village").val().split(" ");
                    mouzaId=VillMouza[0];
                    villageId=VillMouza[1];
                }

                var btn = $(this).button('loading');
                Pace.track(function(){
                    $.ajax({
                        url: "eddlist?action=Individual",
                        data: {
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            unitId: $("select#unit").val(),
                            villageId:villageId,
                            mouzaId: mouzaId
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
                            $("#tableView").fadeIn("slow");
                            tableHeader.empty();
                            var parsedHeader = "<tr>"
                                    + "<th style='width:10px!importtant'>SL<br> No.</th>"
                                    + "<th>Village</th>"
                                    + "<th>Elco No.</th>"
                                    + "<th>Preg. Woman</th>"
                                    + "<th>Age</th>"
                                    + "<th>Husband</th>"
                                    +"<th>Mobile</th>"
                                    +"<th>LMP</th>"
                                    +"<th>EDD</th>"
                                    +"<th class='center'>Status</th>"
                                    + "</tr>";
                            tableHeader.append(parsedHeader);
                            
                            var table = $('#data-table').DataTable(); 
                            table.destroy();
                            tableBody.empty();
                            var active=0,due=0;
                            for (var i = 0; i < json.length; i++) {
                                var status=null;
                                if(json[i].case==="OVER DUE"){
                                    status="<span class='label label-flat label-danger label-xs'>&nbsp;&nbsp;Due&nbsp;&nbsp;</span>";
                                    due++;
                                }else if(json[i].case==="ACTIVE"){
                                    status="<span class='label label-flat label-success label-xs'>Active</span>";
                                    active++;
                                }
                                
                                
                                var parsedData = "<tr style='width:10px!importtant'><td>" + (i + 1) + "</td>"
                                        + "<td>" + json[i].villagenameeng + "</td>"
                                        + "<td>" + ((json[i].elcono === "null") ? "-" : json[i].elcono)  + "</td>"
                                        + "<td>" + json[i].nameeng + "</td>"
                                        + "<td>" + json[i].age + "</td>"
                                        + "<td>" + ((json[i].husbandname === "null") ? "-" : json[i].husbandname) + "</td>"
                                        + "<td>" + ((json[i].mobileno1 === "null") ? "-" : json[i].mobileno1) + "</td>"
                                        + "<td>" + convertToCustomDateFormat(json[i].lmp) + "</td>"
                                        + "<td>" + convertToCustomDateFormat(json[i].edd) + "</td>"
                                        + "<td class='center'>" + status + "</td>";
                                tableBody.append(parsedData);
                            }
                            $("#statusTotalCount").fadeIn("slow");
                            $('#active').html("<span class='label label-flat label-success label-xs'><b>"+active+"</b></span>");
                            $('#due').html("<span class='label label-flat label-danger label-xs'><b>"+due+"</b></span>");
                            var table = $('#data-table').DataTable();
                            table.draw();

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    }); //End Ajax Request 
                }); //End Pace 
            }else if (reportType === "aggregate") {
                toastr["error"]("<h4><b>Report Type Aggregated Under Development</b></h4>");
                /*
                var unit= $('#unit :selected').text().split(" ");  //$("select#unit").val().split("[");
                alert(unit[0]);

                Pace.track(function(){
                    $.ajax({
                        url: "elco_details?action=Aggregate",
                        data: {
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            unitId: unit[0]==="All" ? "%" : unit[0],//$("select#unit").val(),
                            startDate: $("#startDate").val()==="" ? defaultStartDate : $("#startDate").val(),//  $("#startDate").val(),
                            endDate:$("#endDate").val()

                        },
                        type: 'POST',
                        success: function (result) {
                            var json = JSON.parse(result);
                            if (json.length === 0) {
                                btn.button('reset');
                                toastr["error"]("<h4><b>No data found</b></h4>");
                                return;
                            }

                            var parsedHeader = "<tr>"
                                        + "<th>SL No.</th>"
                                        + "<th>Unit</th>"
                                        + "<th>Provider</th>"
                                        + "<th>Household Reg.</th>"
                                        + "<th>Elco (Paper Reg.)</th>"
                                        + "<th>Elco (Tab)</th>"
                                        + "<th>Progress (%)</th>"
                                    + "</tr>";

                            tableHeader.append(parsedHeader);
                            var progressSum=0, totalhh_sum = 0, totalmember_sum = 0, elco_eligible_sum = 0, elcoinregisterkhata_sum=0,
                                    elco_register_sum = 0, currentlypregnent_sum = 0, elco_peper_sum= 0, elco_tablet_sum=0, elco_prs_sum=0;

                            for (var i = 0; i < json.length; i++) {
                                var progress=((parseInt(json[i].elco_tablet) || 0)/parseInt(json[i].elco_peper_register))*100;

                                var parsedData = "<tr id='centerAlign'><td>" + (i + 1) + "</td>"
                                        + "<td id='centerAlign'>" + json[i].unitname + "</td>"
                                        + "<td id='rightAlign'>" + json[i].providername +"("+json[i].providerid + ")</td>"
                                        + "<td id='rightAlign'>" + json[i].totalhh + "</td>"
                                        + "<td id='rightAlign'>" + json[i].elco_peper_register + "</td>"
                                        + "<td id='rightAlign'>" + (parseInt(json[i].elco_tablet) || 0) + "</td>"
                                        + "<td id='rightAlign'>"+Math.round( progress)+" </td> </tr>";

                                tableBody.append(parsedData);

                                totalhh_sum += parseInt(json[i].totalhh);
                                elco_peper_sum += parseInt(json[i].elco_peper_register);
                                elco_tablet_sum += (parseInt(json[i].elco_tablet) || 0);
                                progressSum+=progress;

                            }

                            var footerData = "<tr> <td style='text-align:left' colspan='3'>Total</td>"
                                    + "<td id='rightAlign'>" + totalhh_sum + "</td>"
                                    + "<td id='rightAlign'>" + elco_peper_sum + "</td>"
                                    + "<td id='rightAlign'>" + elco_tablet_sum + "</td>"
                                    + "<td id='rightAlign'>" + Math.round((elco_tablet_sum/elco_peper_sum)*100) + " </td>";

                            $('#tableFooter').append(footerData);
                            btn.button('reset');
                            
                            $("#data-table").DataTable();
                            
                            
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    }); //End Ajax Request
                }); //End Pace Loading
            */
            }

        });
    });
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1><span style="color:#4fef2f;"><i class="fa fa-check-circle" aria-hidden="true"></i></span>Pregnant registration coverage</h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <div class="row">
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
            <div class="row">
                <div class="col-md-1 col-xs-2">
                    <label for="district">District</label>
                </div>
                <div class="col-md-2 col-xs-4">
                    <select class="form-control input-sm" name="district" id="district"> </select>
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
                <div class="col-md-1 col-xs-2">
                    <label for="unit">Unit</label>
                </div>
                <div class="col-md-2 col-xs-4">
                    <select class="form-control input-sm" name="unit" id="unit" >
                        <option value="">- select Unit -</option>
                    </select>
                </div>


            </div>
            <br/>

            <div class="row">
                
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
                    <label for="reportType">Report Type</label>
                </div>
                <div class="col-md-2 col-xs-4" id="radioDiv">
                    <span><input class="providerWise" type="radio"  id="reportType" name="reportType" value="aggregate" checked="checked"> Aggregate </span><br>
                    <span><input class="overall" type="radio"  id="reportType" name="reportType" value="individual"> Individual</span>
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
                <div class="col-md-10">
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
    
    <!--Pregnant Data Table-->
    <div class="box box-primary"  id="tableView">
        <div class="box-header with-border" style="margin-top: -8px;margin-bottom: -5px!important;">
            <h3 class="box-title"><b><span id="prsTypeTitleForTable"></span></b></h3>
                <div class="box-tools pull-right" style="margin-top: 0px;">
                    <button id="printTableBtn" type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                    <a href="#" id ="exportCSV" role='button' class="btn btn-box-tool"><i class="fa fa-file-excel-o" aria-hidden="true"></i>&nbsp;CSV</a>
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                </div>
        </div>

            <div class="box-body">
                    <h4 style=" text-align: center!important;" id="statusTotalCount"><b>Total Active:<span id="active"></span> Total Due:<span id="due"></span></b></h4>
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
</section>


<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>