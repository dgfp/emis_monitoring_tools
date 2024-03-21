<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/epi_dropdown_controls_view.js"></script>
<style>
    #tableContent{
      display: none;  
    }
    .epiDatePickerChoose
    {
        cursor:pointer;
        border: 2px solid #00ACD6;
        font-weight: bold;
    }
</style>
<script>

    /*function upazilaAndUnionSelected() {

        var upazilaId = $("select#upazila").val();
        var unionId = $("select#union").val();
        var wardId = $("select#ward").val();
        var subblockId = $("select#subblock").val();
        var year = $("select#year").val();
        var message = "";
        var error = false;



        if (upazilaId.length === 0) {
            message += "Select a specific Upazila\n";
            error = true;
        }
        if (unionId.length === 0) {
            message += "Select a specific Union\n";
            error = true;
        }
        if (wardId.length === 0) {
            message += "Select a ward\n ";
            error = true;
        }
        if (subblockId.length === 0) {
            message += "Select a sub block\n ";
            error = true;
        }
        if (year.length === 0) {
            message += "Select a year\n ";
            error = true;
        }
        if (error === true) {
            alert(message);
            return false;
        } else {
            return true;
        }
    }*/
     
    $(document).ready(function () {
        
        $("#areaDropDownPanel").slideDown("slow"); //Show area dropdowns panel by jquery slideDown
        
        $('#btnConfirm').click(function () {
            if (!upazilaAndUnionSelected()) {
                $('#DeleteSchedule').modal('hide');
                return;
            }
            var btn = $(this).button('loading');
            $.ajax({
                url: "schedule_epi_settings?action=deleteScheduleData",
                data: {
                    district: $("select#district").val(),
                    upazila: $("select#upazila").val(),
                    union: $("select#union").val(),
                    ward: $("select#ward").val(),
                    subblock: $("select#subblock").val(),
                    year: $("select#year").val()
                },
                type: 'POST',
                success: function (result) {
                        btn.button('reset');
                        $('#scheduleTableData').empty();
                        $('#DeleteSchedule').modal('hide');
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    btn.button('reset');
                    alert("Error while fetching data");
                }
            });

        });
        
        
       
        $('#btnConfirmToEdit').click(function () {
            var divisionId = $("select#division").val();
            var districtId = $("select#district").val();
            var upazilaId = $("select#upazila").val();
            var unionId = $("select#union").val();
            var wardId = $("select#ward").val();
            var subblockId = $("select#subblock").val();
            var year = $("select#year").val();
            
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
            
            if( centerName===""){
                toastr["error"]("<h4><b>Please write Center Name</b></h4>");
                
            }else if( khanaFrom===""){
                toastr["error"]("<h4><b>Please write Khana From</b></h4>");
                
            }else if( khanaTo===""){
                toastr["error"]("<h4><b>Please write Khana To</b></h4>");
                
            }else if( scheduleDateJanuary==="" && year!='2016'){
                toastr["error"]("<h4><b>Please select date of January</b></h4>");
                
            }else if( scheduleDateFebruary==="" && year!='2016'){
                toastr["error"]("<h4><b>Please select date of February</b></h4>");
                
            }else if( scheduleDateMarch==="" && year!='2016'){
                toastr["error"]("<h4><b>Please select date of March</b></h4>");
                
            }else if( scheduleDateApril==="" && year!='2016'){
                toastr["error"]("<h4><b>Please select date of April</b></h4>");
                
            }else if( scheduleDateMay==="" && year!='2016'){
                toastr["error"]("<h4><b>Please select date of May</b></h4>");
                
            }else if( scheduleDateJune==="" && year!='2016'){
                toastr["error"]("<h4><b>Please select date of June</b></h4>");
                
            }else if( scheduleDateJuly==="" && year!='2016'){
                toastr["error"]("<h4><b>Please select date of July</b></h4>");
                
            }else if( scheduleDateAugust==="" && year!='2016'){
                toastr["error"]("<h4><b>Please select date of August</b></h4>");
                
            }else if( scheduleDateSeptember==="" && year!='2016'){
                toastr["error"]("<h4><b>Please select date of September</b></h4>");
                
            }else if( scheduleDateOctober==="" && year!='2016'){
                toastr["error"]("<h4><b>Please select date of October</b></h4>");
                
            }else if( scheduleDateNovember===""){
                toastr["error"]("<h4><b>Please select date of November</b></h4>");
                
            }else if( scheduleDateDecember===""){
                toastr["error"]("<h4><b>Please select date of December</b></h4>");
                
            }else{
                var btn = $(this).button('loading');
                Pace.track(function(){
                    $.ajax({
                        url: "schedule_epi_settings?action=updateScheduleData",
                        data: {
                            district: $("select#district").val(),
                            upazila: $("select#upazila").val(),
                            union: $("select#union").val(),
                            ward: $("select#ward").val(),
                            subblock: $("select#subblock").val(),
                            year: $("select#year").val(),
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
                            
                            toastr["success"]("<h4><b>Schedule update successfully</b></h4>");
                            $("#btnShowSchedule").trigger('click');
                            $('#updateEPISchedule').modal('hide');
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Error while update data</b></h4>");
                        }
                    });//end ajax
                    
                });//end pace
                
            }//end else
            
        });//end update click
        
        $('#btnShowSchedule').click(function () {
            $("#tableContent").fadeOut("fast");
            //resetUpdate();
            epiTwelveMonthDates($('#year').val());
            resetUpdate();
            
            var divisionId = $("select#division").val();
            var districtId = $("select#district").val();
            var upazilaId = $("select#upazila").val();
            var unionId = $("select#union").val();
            var wardId = $("select#ward").val();
            var subblockId = $("select#subblock").val();
            var year = $("select#year").val();
            
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
                
            }else{
                var btn = $(this).button('loading');
                $('#scheduleTableData').empty();
                
                Pace.track(function(){
                    $.ajax({
                        url: "schedule_epi_settings?action=getScheduleData",
                        data: {
                            district: $("select#district").val(),
                            upazila: $("select#upazila").val(),
                            union: $("select#union").val(),
                            ward: $("select#ward").val(),
                            subblock: $("select#subblock").val(),
                            year: $("select#year").val()
                        },
                        type: 'POST',
                        success: function (result) {
                            btn.button('reset');
                            var json = JSON.parse(result);
                            if(json.length===0){
                                //$("#tableContent").fadeOut("slow");
                                //$("#tableContent").css("display","none");
                                //$("#transparentTextForBlank").css("display","none");
                                toastr["warning"]("<h4><b>No EPI session found</b></h4>");
                                $("#transparentTextForBlank").fadeIn("slow");
                                return;
                            }
                            resetUpdate();
                            $("#transparentTextForBlank").css("display","none");
                           $("#tableContent").fadeIn("slow");
                           //Set for update
                           $('#centerName').val(json[0].centername);
                           $('#khanaFrom').val(json[0].khananofrom);
                           $('#khanaTo').val(json[0].khananoto);
                           /*
                           //$('#scheduleDateJanuary').val(json[0].scheduledate1);
                           //January
                           if(json[0].scheduledate1!=null || json[0].scheduledate1!=""){
                               $("#scheduleDateJanuary").datepicker({
                                    format: 'dd/mm/yyyy'
                                }).datepicker('setDate', json[0].scheduledate1);
                               
                           }
                           //$('#scheduleDateFebruary').val(json[1].scheduledate1);
                           //February
                           if(json[1].scheduledate1!=null || json[1].scheduledate1!=""){
                               $("#scheduleDateFebruary").datepicker({
                                    format: 'dd/mm/yyyy'
                                }).datepicker('setDate', json[1].scheduledate1);
                               
                           }
                           //$('#scheduleDateMarch').val(json[2].scheduledate1);
                           //March
                           if(json[2].scheduledate1!=null || json[2].scheduledate1!=""){
                               $("#scheduleDateMarch").datepicker({
                                    format: 'dd/mm/yyyy'
                                }).datepicker('setDate', json[2].scheduledate1);
                               
                           }
                           //$('#scheduleDateApril').val(json[3].scheduledate1);
                           //April
                           if(json[3].scheduledate1!=null || json[3].scheduledate1!=""){
                               $("#scheduleDateApril").datepicker({
                                    format: 'dd/mm/yyyy'
                                }).datepicker('setDate', json[3].scheduledate1);
                               
                           }
                           //$('#scheduleDateMay').val(json[4].scheduledate1);
                           //May
                           if(json[4].scheduledate1!=null || json[4].scheduledate1!=""){
                               $("#scheduleDateMay").datepicker({
                                    format: 'dd/mm/yyyy'
                                }).datepicker('setDate', json[4].scheduledate1);
                               
                           }
                           //$('#scheduleDateJune').val(json[5].scheduledate1);
                           //June
                           if(json[5].scheduledate1!=null || json[5].scheduledate1!=""){
                               $("#scheduleDateJune").datepicker({
                                    format: 'dd/mm/yyyy'
                                }).datepicker('setDate', json[5].scheduledate1);
                               
                           }
                           //$('#scheduleDateJuly').val(json[6].scheduledate1);
                           //July
                           if(json[6].scheduledate1!=null || json[6].scheduledate1!=""){
                               $("#scheduleDateJuly").datepicker({
                                    format: 'dd/mm/yyyy'
                                }).datepicker('setDate', json[6].scheduledate1);
                               
                           }
                           //$('#scheduleDateAugust').val(json[7].scheduledate1);
                           //August
                           if(json[7].scheduledate1!=null || json[7].scheduledate1!=""){
                               $("#scheduleDateAugust").datepicker({
                                    format: 'dd/mm/yyyy'
                                }).datepicker('setDate', json[7].scheduledate1);
                               
                           }
                           //$('#scheduleDateSeptember').val(json[8].scheduledate1);
                           //October
                           if(json[8].scheduledate1!=null || json[8].scheduledate1!=""){
                               $("#scheduleDateSeptember").datepicker({
                                    format: 'dd/mm/yyyy'
                                }).datepicker('setDate', json[8].scheduledate1);
                               
                           }
                           //$('#scheduleDateOctober').val(json[9].scheduledate1);
                           //October
                           if(json[9].scheduledate1!=="" || json[9].scheduledate1!==null || json[11].scheduledate1!=='null'){
                               $("#scheduleDateOctober").datepicker({
                                    format: 'dd/mm/yyyy'
                                }).datepicker('setDate', json[9].scheduledate1);
                               
                           }
                           //November
                           if(json[10].scheduledate1!=="" || json[10].scheduledate1!==null || json[10].scheduledate1!=='null'){
                               $("#scheduleDateNovember").datepicker({
                                    format: 'dd/mm/yyyy'
                                }).datepicker('setDate', json[10].scheduledate1);
                               
                           }
                           //December
                           if(json[11].scheduledate1!=="" || json[11].scheduledate1!==null || json[11].scheduledate1!=='null'){
                               $("#scheduleDateDecember").datepicker({
                                    format: 'dd/mm/yyyy'
                                }).datepicker('setDate', json[11].scheduledate1);
                               
                           }*/
    
                //$("#scheduleDateDecember").datepicker("setDate", new Date(json[11].scheduledate1));
                           //$('#scheduleDateDecember').attr('value', new Date(json[11].scheduledate1));
                           
                           
                           
                            for (var i = 0; i < json.length; i++) {
                                var parsedData = "<tr>"
                                        //+"<td>" + (i + 1) + "</td>"
                                        + "<td> " + json[i].scheduleyear + "</td>"
                                        + "<td> " + geWard(json[i].wardold) + "</td>"
                                        + "<td> " + getBlock(json[i].subblockid) + "</td>"

                                        + "<td><b> " + json[i].centername + " </b></td>"
                                       // + "<td> " + json[i].khanatotal + "</td>"
                                        + "<td> " + json[i].khananofrom + "</td>"
                                        + "<td> " + json[i].khananoto + "</td>"
                                        + "<td> " + getType(json[i].centertype) + "</td>"
                                        + "<td><b> " + json[i].scheduledate1 + " </b></td>"
                                        //  + "<td><a href='' class='delete' >delete</a></td>"
                                        + "</tr>";
                                $('#scheduleTableData').append(parsedData);
                                
                                //Set date for update
                                var monthOfDate=json[i].scheduledate.split("-");
                                //January
                                if(monthOfDate[1]=='01'){
                                    $("#scheduleDateJanuary").datepicker({
                                         format: 'dd/mm/yyyy'
                                     }).datepicker('setDate', json[i].scheduledate1);

                                }
                                //February
                                if(monthOfDate[1]=='02'){
                                    $("#scheduleDateFebruary").datepicker({
                                         format: 'dd/mm/yyyy'
                                     }).datepicker('setDate', json[i].scheduledate1);

                                }
                                //March
                                if(monthOfDate[1]=='03'){
                                    $("#scheduleDateMarch").datepicker({
                                         format: 'dd/mm/yyyy'
                                     }).datepicker('setDate', json[i].scheduledate1);

                                }
                                //April
                                if(monthOfDate[1]=='04'){
                                    $("#scheduleDateApril").datepicker({
                                         format: 'dd/mm/yyyy'
                                     }).datepicker('setDate', json[i].scheduledate1);

                                }
                                //May
                                if(monthOfDate[1]=='05'){
                                    $("#scheduleDateMay").datepicker({
                                         format: 'dd/mm/yyyy'
                                     }).datepicker('setDate', json[i].scheduledate1);

                                }
                                //June
                                if(monthOfDate[1]=='06'){
                                    $("#scheduleDateJune").datepicker({
                                         format: 'dd/mm/yyyy'
                                     }).datepicker('setDate', json[i].scheduledate1);

                                }
                                //July
                                if(monthOfDate[1]=='07'){
                                    $("#scheduleDateJuly").datepicker({
                                         format: 'dd/mm/yyyy'
                                     }).datepicker('setDate', json[i].scheduledate1);

                                }
                                //August
                                if(monthOfDate[1]=='08'){
                                    $("#scheduleDateAugust").datepicker({
                                         format: 'dd/mm/yyyy'
                                     }).datepicker('setDate', json[i].scheduledate1);

                                }
                                //October
                                if(monthOfDate[1]=='09'){
                                    $("#scheduleDateSeptember").datepicker({
                                         format: 'dd/mm/yyyy'
                                     }).datepicker('setDate', json[i].scheduledate1);

                                }
                                //October
                                if(monthOfDate[1]=='10'){
                                    $("#scheduleDateOctober").datepicker({
                                         format: 'dd/mm/yyyy'
                                     }).datepicker('setDate', json[i].scheduledate1);

                                }
                                //November
                                if(monthOfDate[1]==='11'){
                                    $("#scheduleDateNovember").datepicker({
                                         format: 'dd/mm/yyyy'
                                     }).datepicker('setDate', json[i].scheduledate1);

                                }
                                //December
                                if(monthOfDate[1]==='12'){
                                    $("#scheduleDateDecember").datepicker({
                                         format: 'dd/mm/yyyy'
                                     }).datepicker('setDate', json[i].scheduledate1);

                                }
                                
                                
                                
                            }//end loop\\
                            
                            //epiTwelveMonthDates($('#year').val());
                            
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Error while fetching data</b></h4>");
                        }
                    });//end ajax
                    
                });//end pace
            }//end else
            
        });//end btn click



        $("#addScheduleData").submit(function (e) {

            e.preventDefault();
            var postData = $(this).serializeArray();
            var formURL = $(this).attr("action");
            $.ajax({
                url: formURL,
                type: "POST",
                data: postData,
                success: function (result) {
                    if (result === "1") { //change only if one row is affected
                        alert("Schedule added");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error while adding village");
                }
            });
            e.preventDefault();	//STOP default action
        });
        
        
        function resetUpdate(){
            $('#centerName').val("");
            $('#khanaFrom').val("");
            $('#khanaTo').val("");
            
            $("#scheduleDateJanuary").val("");
            $("#scheduleDateFebruary").val("");
            $("#scheduleDateMarch").val("");
            $("#scheduleDateApril").val("");
            $("#scheduleDateMay").val("");
            $("#scheduleDateJune").val("");
            $("#scheduleDateJuly").val("");
            $("#scheduleDateAugust").val("");
            $("#scheduleDateSeptember").val("");
            $("#scheduleDateOctober").val("");
            $("#scheduleDateNovember").val("");
            $("#scheduleDateDecember").val("");

        }
        
        
        
        
function epiTwelveMonthDates(year){
        
        //January
        $("#scheduleDateJanuary").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/01/"+year).datepicker('setEndDate', endDateOfSelectedMonth("01",year)+"/01/"+year);
        
        //February
        $("#scheduleDateFebruary").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/02/"+year).datepicker('setEndDate', endDateOfSelectedMonth("02",year)+"/02/"+year);
        
        //March
        $("#scheduleDateMarch").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/03/"+year).datepicker('setEndDate', endDateOfSelectedMonth("03",year)+"/03/"+year);
        
        //April
        $("#scheduleDateApril").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/04/"+year).datepicker('setEndDate', endDateOfSelectedMonth("04",year)+"/04/"+year);
        
        //May
        $("#scheduleDateMay").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/05/"+year).datepicker('setEndDate', endDateOfSelectedMonth("05",year)+"/05/"+year);
        
        //June
        $("#scheduleDateJune").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/06/"+year).datepicker('setEndDate', endDateOfSelectedMonth("06",year)+"/06/"+year);
        
        //July
        $("#scheduleDateJuly").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/07/"+year).datepicker('setEndDate', endDateOfSelectedMonth("07",year)+"/07/"+year);
        
        //August
        $("#scheduleDateAugust").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/08/"+year).datepicker('setEndDate', endDateOfSelectedMonth("08",year)+"/08/"+year);
        
        //Setember
        $("#scheduleDateSeptember").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/09/"+year).datepicker('setEndDate', endDateOfSelectedMonth("09",year)+"/09/"+year);
        
        //October
        $("#scheduleDateOctober").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/10/"+year).datepicker('setEndDate', endDateOfSelectedMonth("10",year)+"/10/"+year);
        
        //November
        $("#scheduleDateNovember").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/11/"+year).datepicker('setEndDate', endDateOfSelectedMonth("11",year)+"/11/"+year);
        
        //December
        $("#scheduleDateDecember").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/12/"+year).datepicker('setEndDate', endDateOfSelectedMonth("12",year)+"/12/"+year);
    }
    function endDateOfSelectedMonth(month,year){
        return new Date(new Date(year,month,1).getFullYear(), new Date(year,month,1).getMonth(), 0).getDate();
    }

    });
    
    //---------------------------------------------------------------------------------------Edit User ------------------------------------------------------------------------
    function  editUserHandler(){
            $('#updateEPISchedule').modal('show');
    }

//---------------------------------------------------------------------------------------Delete User ------------------------------------------------------------------------
    function  deleteUserHandler(index){
         console.log(index);
            $('#deleteUser').modal('show');
//            $('#deleteUserId').val(jsonUser[index].uname);
//            $('#deleteUserName').val(jsonUser[index].userid);
//            $('#deleteName').val(jsonUser[index].name);
    }
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>EPI microplan</h1>
  <ol class="breadcrumb">
    <a class="btn btn-flat btn-info btn-sm" href="schedule_epi_settings"><b><i class="fa fa-calendar-check-o" aria-hidden="true"></i>&nbsp;EPI microplan</b></a>
    <a class="btn btn-flat btn-primary btn-sm" href="EPIMicroPlanning"><b><i class="fa fa-calendar-check-o" aria-hidden="true"></i>&nbsp;EPI microplan (ward wise)</b></a>
    <a class="btn btn-flat btn-primary btn-sm" href="epi_schedule_add"><b><i class="fa fa-calendar-plus-o" aria-hidden="true"></i>&nbsp;Add EPI microplan </b></a>
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
                        <option value="">- Select SubBlock -</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="year">Year</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="year" id="year"> </select>
                </div>

                <div class="col-md-2 col-md-offset-1">
                    <button type="button" id="btnShowSchedule" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off">
                        <i class="fa fa-calendar" aria-hidden="true"></i> <b>View Schedule</b>
                    </button>
                </div>
<!--                <div class="col-md-2 col-md-offset-1">
                    <button type="button" id="" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off" data-toggle="modal" data-target="#DeleteSchedule">
                        <i class="fa fa-trash" aria-hidden="true"></i> Delete All
                    </button>
                </div>-->
            </div>    
          </div>
        </div>
      </div>
    </div>
    <!--Transparent Text For Blank Space-->        
    <section class="content-header" id="transparentTextForBlank" style="display: block;">
        <center class="emis_hologram">eMIS</center>
    </section>
    
    <!--Table body-->
    
    <div class="row" id="tableContent">
    <div class="col-xs-12">
        <div class="box box-primary">
            <div class="box-body">
            

                    <div class="box-tools pull-right" style="margin-right: 2px;">
                        <a class="btn btn-flat btn-warning btn-sm" onclick="editUserHandler(&quot;0&quot;)"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> <b>Update</b></a>
<!--                        <a class="btn btn-flat btn-danger btn-sm" onclick="deleteUserHandler(&quot;3&quot;)"><i class="fa fa-trash" aria-hidden="true"></i> <b>Delete all</b></a>-->
                    </div>
                
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover" id="data-table">
                    <thead class="data-table">
                        <tr>
                            <th>Year</th>
                            <th>Ward No</th>
                            <th>Block / Site</th>
                            <th>Center</th>
                            <th>Household From</th>
                            <th>Household To</th>
                            <th> Type</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody id="scheduleTableData">
                    </tbody>
                </table>
                
<!--                <ul class="pager pull-right">
                <li><a href="#">Previous</a></li>
                <li><a href="#">1</a></li>
                <li class="active"><a href="#">2</a></li>
                <li><a href="#">Next</a></li>
                </ul>-->
            </div>
        </div>
        
      </div>
    </div>
  </div>
</section>

  <!--Delete Modal -->
  <div class="modal fade" id="DeleteSchedule" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Are you sure ?</h4>
        </div>
        <div class="modal-body">
          <button type="button" id="btnConfirm" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-primary btn-sm">Confirm</button>
          <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Cancel</button>
        </div>
      </div>
    </div>
  </div>
    
    
    <!-------------------------------------------------------------------------------- edit User Modal -------------------------------------------------------------------------------->  
    <div class="modal fade" id="updateEPISchedule" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header label-warning">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><b style="color:#fff">&#10006;</b></span>
                </button>
                <h4 class="modal-title"><b><i class="fa fa-pencil-square-o" aria-hidden="true"></i><span>    &nbsp; Update EPI session</span></b></h4>
            </div>
            <div class="modal-body c-modal-body">
                    <div class="box-body">
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
                        </div>
                        <br>
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
                        </div>
                        <br>
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
                        </div>
                        <br>
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
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-12">
                                <button type="button"  id="btnConfirmToEdit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Updating" class="btn btn-flat btn-warning pull-right"><b>Submit Update</b></button>&nbsp;&nbsp;
                                
                            </div>
                        </div>
                    </div>
            </div>

        </div>
    </div>
</div>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
