<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/epi_dropdown_controls_add.js"></script>
<style>
.epiDatePickerChoose
{
    cursor:pointer;
    border: 2px solid #00ACD6;
    font-weight: bold;
}
</style>
<script>
    
    $(document).ready(function () {
        
        $("#areaDropDownPanel").fadeIn("slow"); //Show area dropdowns panel by jquery slideDown
        
        $('#btnAddEPISchedule').click(function () {
            var divisionId = $("select#division").val();
            var districtId = $("select#district").val();
            var upazilaId = $("select#upazila").val();
            var unionId = $("select#union").val();
            var wardId = $("select#ward").val();
            var subblockId = $("select#subblock").val();
            var year = $("select#epiCreateYear").val();
            var centerType = $("select#centerType").val();
            
            var centerName = $("#centerName").val();
            var khanaFrom = $("#khanaFrom").val();
            var khanaTo = $("#khanaTo").val();
            
            var scheduleDateJanuary = $("#scheduleDateJanuary").val();
            var scheduleDateFebruary = $("#scheduleDateFebruary").val();
            var scheduleDateMarch = $("#scheduleDateMarch").val();
            var scheduleDateApril = $("#scheduleDateApril").val();
            var scheduleDateMay = $("#scheduleDateMay").val();
            var scheduleDateJune = $("#scheduleDateJune").val();
            var scheduleDateJuly = $("#scheduleDateJuly").val();
            var scheduleDateAugust = $("#scheduleDateAugust").val();
            var scheduleDateSeptember = $("#scheduleDateSeptember").val();
            var scheduleDateOctober = $("#scheduleDateOctober").val();
            var scheduleDateNovember = $("#scheduleDateNovember").val();
            var scheduleDateDecember = $("#scheduleDateDecember").val();
            
            if( divisionId===""){
                toastr["error"]("<h4><b>Please select Division</b></h4>");
                
            }else if( districtId===""){
                toastr["error"]("<h4><b>Please select District</b></h4>");
                
            }else if( upazilaId===""){
                toastr["error"]("<h4><b>Please select Upazila</b></h4>");
                
            }else if( unionId===""){
                toastr["error"]("<h4><b>Please select Union</b></h4>");
                
            }else if( wardId===""){
                toastr["error"]("<h4><b>Please select Ward</b></h4>");
                
            }else if( subblockId===""){
                toastr["error"]("<h4><b>Please select Subblock</b></h4>");
                
            }else if( centerType===""){
                toastr["error"]("<h4><b>Please select Center Type</b></h4>");
                
            }else if( centerName===""){
                toastr["error"]("<h4><b>Please write Center Name</b></h4>");
                
            }else if( khanaFrom===""){
                toastr["error"]("<h4><b>Please write Khana From</b></h4>");
                
            }else if( khanaTo===""){
                toastr["error"]("<h4><b>Please write Khana To</b></h4>");
                
            }else if( scheduleDateJanuary===""){
                toastr["error"]("<h4><b>Please select date of January</b></h4>");
                
            }else if( scheduleDateFebruary===""){
                toastr["error"]("<h4><b>Please select date of February</b></h4>");
                
            }else if( scheduleDateMarch===""){
                toastr["error"]("<h4><b>Please select date of March</b></h4>");
                
            }else if( scheduleDateApril===""){
                toastr["error"]("<h4><b>Please select date of April</b></h4>");
                
            }else if( scheduleDateMay===""){
                toastr["error"]("<h4><b>Please select date of May</b></h4>");
                
            }else if( scheduleDateJune===""){
                toastr["error"]("<h4><b>Please select date of June</b></h4>");
                
            }else if( scheduleDateJuly===""){
                toastr["error"]("<h4><b>Please select date of July</b></h4>");
                
            }else if( scheduleDateAugust===""){
                toastr["error"]("<h4><b>Please select date of August</b></h4>");
                
            }else if( scheduleDateSeptember===""){
                toastr["error"]("<h4><b>Please select date of September</b></h4>");
                
            }else if( scheduleDateOctober===""){
                toastr["error"]("<h4><b>Please select date of October</b></h4>");
                
            }else if( scheduleDateNovember===""){
                toastr["error"]("<h4><b>Please select date of November</b></h4>");
                
            }else if( scheduleDateDecember===""){
                toastr["error"]("<h4><b>Please select date of December</b></h4>");
                
            }else{
                var btn = $(this).button('loading');
                Pace.track(function(){
                    $.ajax({
                        url: 'epi_schedule_add?action=addScheduleData',
                        data: {
                            divisionId: divisionId,
                            districtId: districtId,
                            upazilaId: upazilaId,
                            unionId: unionId,
                            wardId: wardId,
                            subblockId: subblockId,
                            year: year,
                            centerType: centerType,
                            centerName: centerName,
                            khanaFrom: khanaFrom,
                            khanaTo: khanaTo,
                            scheduleDateJanuary: scheduleDateJanuary,
                            scheduleDateFebruary: scheduleDateFebruary,
                            scheduleDateMarch: scheduleDateMarch,
                            scheduleDateApril: scheduleDateApril,
                            scheduleDateMay: scheduleDateMay,
                            scheduleDateJune: scheduleDateJune,
                            scheduleDateJuly: scheduleDateJuly,
                            scheduleDateAugust: scheduleDateAugust,
                            scheduleDateSeptember: scheduleDateSeptember,
                            scheduleDateOctober: scheduleDateOctober,
                            scheduleDateNovember: scheduleDateNovember,
                            scheduleDateDecember: scheduleDateDecember
                        },
                        type: 'POST',
                        success: function (result) {
                            btn.button('reset');
                            if (result === "1") { //change only if one row is affected
                                toastr["success"]("<h4><b>Schedule added successfully</b></h4>");
                            }else if(result === "2"){
                                toastr["warning"]("<h4><b>Schedule already added</b></h4>");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Error while adding epi schedule</b></h4>");
                        }
                    }); //End Ajax
                }); //End Pace
               
                
            }
        });
        


        $("#addScheduleData").submit(function (e) {
            

            /*e.preventDefault();//STOP default action
            var postData = $(this).serializeArray();
            var formURL = $(this).attr("action");
            
            Pace.track(function(){
                    $.ajax({
                        url: formURL,
                        data: postData,
                        type: 'POST',
                        success: function (result) {
                            if (result === "1") { //change only if one row is affected
                                toastr["success"]("<h4><b>Schedule added successfully</b></h4>");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            toastr["error"]("<h4><b>Error while adding epi schedule</b></h4>");
                        }
                    }); //End Ajax
                }); //End Pace
                e.preventDefault();//STOP default action
                */
            e.preventDefault();//STOP default action
            var postData = $(this).serializeArray();
            var formURL = $(this).attr("action");
            console.log(postData);
            console.log(formURL);
            /*$.ajax({
                url: formURL,
                type: 'POST',
                data: postData,
                success: function (result) {
                    if (result === "1") { //change only if one row is affected
                        toastr["success"]("<h4><b>Schedule added successfully</b></h4>");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Error while adding epi schedule</b></h4>");
                }
            });*/
            e.preventDefault();//STOP default action
        
        });
        
        
        $('#epiCreateYear').change(function (event) {
            $('.epiDatePickerChoose').val("");
        });

    });
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Add EPI microplan
  </h1>
  <ol class="breadcrumb">
    <a class="btn btn-flat btn-primary btn-sm" href="schedule_epi_settings"><b><i class="fa fa-calendar-check-o" aria-hidden="true"></i>&nbsp;EPI microplan</b></a>
    <a class="btn btn-flat btn-primary btn-sm" href="EPIMicroPlanning"><b><i class="fa fa-calendar-check-o" aria-hidden="true"></i>&nbsp;EPI microplan (ward wise)</b></a>
    <a class="btn btn-flat btn-info btn-sm" href="epi_schedule_add"><b><i class="fa fa-calendar-plus-o" aria-hidden="true"></i>&nbsp;Add EPI microplan </b></a>
<!--    <a class="btn btn-flat btn-primary btn-sm" href="epischedulebar"><b>EPI session timesr</b></a>-->
  </ol>
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
          <!-- /.box-header -->
          <div class="box-body"> 
<!--            <form action="epi_schedule_add?action=addScheduleData" id="addScheduleData" method="POST">-->
            <div class="row">
                <div class="col-md-1">
                    <label for="district">Division</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="division" id="division"> </select>
                </div>
                
                <div class="col-md-1">
                    <label for="district">District</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="district" id="district"> 
                        <option value="">- Select District -</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="upazila">Upazila</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="upazila" id="upazila">
                        <option value="">- Select Upazila -</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="union">Union</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="union" id="union">
                        <option value="">- Select Union -</option>
                    </select>
                </div>
            </div><br>
            
            <div class="row">
                    <div class="col-md-1">
                        <label for="ward">Ward</label>
                    </div>

                    <div class="col-md-2">
                        <select class="form-control input-sm" name="ward" id="ward" >
                            <option value="">- Select Ward -</option>
                        </select>
                    </div>
                
                    <div class="col-md-1">
                        <label for="subblock">SubBlock</label>
                    </div>

                    <div class="col-md-2">
                        <select class="form-control input-sm" name="subblock" id="subblock" >
                            <option value="">- Select Subblock -</option>
                        </select>
                    </div>

                    <div class="col-md-1">
                        <label for="year">Year</label>
                    </div>
                    <div class="col-md-2">
                        <select class="form-control input-sm" name="year" id="epiCreateYear"> </select>
                    </div>
                
                    <div class="col-md-1">
                        <label for="centerType">  Type</label>
                    </div>
                    <div class="col-md-2">
                        <select name="centerType" id="centerType" class="form-control input-sm">
                            <option value=""> Choose Center Type </option>
                            <option value="1">অস্থায়ী</option>
                            <option value="2">স্থায়ী</option>
                            <option value="3">স্যাটেলাইট</option>
                        </select>
                    </div>
            </div><br>
            
            <div class="row">
                <div class="col-md-1">
                    <label for="centerName">  Name</label>
                </div>
                <div class="col-md-5">
                    <input type="text"  name="centerName" id="centerName" class="form-control input-sm" placeholder="Enter Center name">
                </div>
                 <div class="col-md-1">
                    <label for="khanaFrom">Khana</label>
                </div>
                <div class="col-md-2">
                    <input type="number" class="input form-control input-sm" placeholder="From" min="1" name="khanaFrom" id="khanaFrom"/>

                </div>
                <div class="col-md-1">
                    <label for="khanaTo"> To</label>
                </div>
                <div class="col-md-2">
                    <input type="number" class="input form-control input-sm" placeholder="To" min="1" name="khanaTo" id="khanaTo"/>
                </div>
            </div><br>
            
            <div class="row">
                <div class="col-md-1">
                    <label for="">January</label>
                </div>
                <div class="col-md-2">
                    <input type="text" class="input form-control input-sm epiDatePickerChoose" placeholder="Date of January" name="scheduleDateJanuary" id="scheduleDateJanuary" readonly="" />
                </div>
                <div class="col-md-1">
                    <label for="scheduleDateFebruary">February</label>
                </div>
                <div class="col-md-2">
                    <input type="text" class="input form-control input-sm epiDatePickerChoose" placeholder="Date of February" name="scheduleDateFebruary" id="scheduleDateFebruary" readonly="" />
                </div>
                <div class="col-md-1">
                    <label for="scheduleDateMarch">March</label>
                </div>
                <div class="col-md-2">
                    <input type="text" class="input form-control input-sm epiDatePickerChoose" placeholder="Date of March" name="scheduleDateMarch" id="scheduleDateMarch" readonly="" />
                </div>
                 <div class="col-md-1">
                    <label for="scheduleDateApril">April</label>
                </div>
                <div class="col-md-2">
                    <input type="text" class="input form-control input-sm epiDatePickerChoose" placeholder="Date of April" name="scheduleDateApril" id="scheduleDateApril" readonly="" />
                </div>
            </div><br>
            
            <div class="row">
                <div class="col-md-1">
                    <label for="scheduleDateMay">May</label>
                </div>
                <div class="col-md-2">
                    <input type="text" class="input form-control input-sm epiDatePickerChoose" placeholder="Date of May" name="scheduleDateMay" id="scheduleDateMay" readonly="" />
                </div>
                <div class="col-md-1">
                    <label for="scheduleDateJune">June</label>
                </div>
                <div class="col-md-2">
                    <input type="text" class="input form-control input-sm epiDatePickerChoose" placeholder="Date of June" name="scheduleDateJune" id="scheduleDateJune" readonly="" />
                </div>
                <div class="col-md-1">
                   <label for="scheduleDateJuly">July</label>
               </div>
               <div class="col-md-2">
                   <input type="text" class="input form-control input-sm epiDatePickerChoose" placeholder="Date of July" name="scheduleDateJuly" id="scheduleDateJuly" readonly="" />
               </div>
                <div class="col-md-1">
                   <label for="scheduleDateAugust">August</label>
               </div>
               <div class="col-md-2">
                   <input type="text" class="input form-control input-sm epiDatePickerChoose" placeholder="Date of August" name="scheduleDateAugust" id="scheduleDateAugust" readonly="" />
               </div>
            </div><br>
            
            <div class="row">
                <div class="col-md-1">
                    <label for="scheduleDateSeptember">September</label>
                </div>
                <div class="col-md-2">
                    <input type="text" class="input form-control input-sm epiDatePickerChoose" placeholder="Date of September" name="scheduleDateSeptember" id="scheduleDateSeptember" readonly="" />
                </div>
                <div class="col-md-1">
                    <label for="scheduleDateOctober">October</label>
                </div>
                <div class="col-md-2">
                    <input type="text" class="input form-control input-sm epiDatePickerChoose" placeholder="Date of October" name="scheduleDateOctober" id="scheduleDateOctober" readonly="" />
                </div>
                <div class="col-md-1">
                    <label for="scheduleDateNovember">November</label>
                </div>
                <div class="col-md-2">
                    <input type="text" class="input form-control input-sm epiDatePickerChoose" placeholder="Date of November" name="scheduleDateNovember" id="scheduleDateNovember" readonly="" />
                </div>
                <div class="col-md-1">
                    <label for="scheduleDateDecember">December</label>
                </div>
                <div class="col-md-2">
                    <input type="text" class="input form-control input-sm epiDatePickerChoose" placeholder="Date of December" name="scheduleDateDecember" id="scheduleDateDecember" readonly="" />
                </div>
            </div><br>
            <div class="row">
                <div class="col-md-offset-9 col-md-3  ">
                    <button type="submit" id="btnAddEPISchedule" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block">
                        <b><i class="fa fa-calendar-plus-o" aria-hidden="true"></i> &nbsp;Add  microplan</b>
                    </button>
                </div>
            </div>
<!--            </form>-->
          </div>
        </div>
      </div>
    </div>
</section>
<style>
    .table th{text-align: left;}
</style> 
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script>
            $('.epiDatePickerChoose').datepicker({
            format: 'dd/mm/yyyy',
            clearBtn: true,
            autoclose: true
        });
</script>