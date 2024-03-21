<%-- 
    Document   : epiMicroPlanning
    Created on : Nov 14, 2017, 9:50:47 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/epi_dropdown_controls_view.js"></script>
<style>
    #tableContent{
      display: none;  
    }
    .coverPage{
      display: none;  
    }
    .epiDatePickerChoose
    {
        cursor:pointer;
        border: 2px solid #00ACD6;
        font-weight: bold;
    }
    .centerName{
    text-align: left;
    padding-left: 8px!important;
}
    .tg  {border-collapse:collapse;border-spacing:0;}
    .tg td{font-family:Arial, sans-serif;font-size:12px;padding:3px 2px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
    .tg th{font-family:Arial, sans-serif;font-size:12px;font-weight:normal;padding:3px 2px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
    .tg .tg-0e45{font-size:11px}
    .tg .tg-q19q{font-size:11px;vertical-align:top}
    .tg .tg-yw4l{vertical-align:top}
    .center{
        text-align: center;
    }
    .left{
        text-align: left;
    }
    @font-face {
        font-family: NikoshBAN;
        src: url('resources/fonts/NikoshBAN.ttf');
    }
    .numeric_field{
        font-family: NikoshBAN;
        font-size: 17px;
    }
</style>
<script>
    $(document).ready(function () {
        
        
        //======Print & PDF Data
        $('#printTableBtn').click(function () {
            $('table').each(function () {
                $(this).css({
                    "page-break-after": "always"
                });
            });
           // window.print();
            
            var contents = $("#printContent").html();
            var frame1 = $('<iframe />');
            frame1[0].name = "frame1";
            frame1.css({ "position": "absolute", "top": "-1000000px" });
            $("body").append(frame1);
            var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
            frameDoc.document.open();
            frameDoc.document.write('<html><head><title>eMIS Initiative</title>');
            frameDoc.document.write('</head><body>');
            frameDoc.document.write('<style></style>');
            frameDoc.document.write('<link href="resources/css/epiMicroPlanPrint.css" rel="stylesheet" type="text/css" />');
            frameDoc.document.write(contents);
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 500);
        });
        
        
        $("#areaDropDownPanel").slideDown("slow"); //Show area dropdowns panel by jquery slideDown
        
        $('#btnShowSchedule').click(function () {
            $("#tableContent").fadeOut("fast");
            var epiMicroPlanTables = $('#epiMicroPlanTables').html();
            epiMicroPlanTables="";
            $('#epiMicroPlanTables').html(epiMicroPlanTables);
            
            var divisionId = $("select#division").val();
            var districtId = $("select#district").val();
            var upazilaId = $("select#upazila").val();
            var year = $("select#year").val();
            
            if( divisionId===""){
                toastr["error"]("<h4><b>Please select Division</b></h4>");
                
            }else if( districtId===""){
                toastr["error"]("<h4><b>Please select District</b></h4>");
                
            }else if( upazilaId===""){
                toastr["error"]("<h4><b>Please select Upazila</b></h4>");
                
            }else{
                var btn = $(this).button('loading');
                Pace.track(function(){
                    $.ajax({
                        url: "EPIMicroPlanning",
                        data: {
                            divisionId: divisionId,
                            districtId: districtId,
                            upazilaId: upazilaId,
                            year: year
                        },
                        type: 'POST',
                        success: function (result) {
                            btn.button('reset');
                            var json = JSON.parse(result);
                            var epi=json.epi;
                            var areaInfo=json.areaInfo;
                            if(epi.length===0){
                                $("#transparentTextForBlank").fadeIn("slow");
                                toastr["warning"]("<h4><b>No EPI micro plan found</b></h4>");
                                return;
                            }
                            $("#transparentTextForBlank").css("display","none");
                            $("#tableContent").fadeIn("slow");
                            //var epiMicroPlanTables=$('#epiMicroPlanTables');
                            for (var i = 0; i <  areaInfo.length; i++) {
                                
                                //Set Here  here
                                epiMicroPlanTables+=(getHeader(areaInfo[i].name_zila,areaInfo[i].name_upazila,areaInfo[i].name_union));
                                //Set Cover page titles
                                $('#title1').text("উপজেলা স্বাস্থ্য কমপ্লেক্স, "+ areaInfo[0].name_upazila +", "+ areaInfo[0].name_zila +"");
                                $('#title2').text("ইপিআই ম্যানেজমেন্ট ও মাইক্রোপ্ল্যানিং "+ replaceNoE2B($('#year option:selected').text()) +" ইং");
                                $('#title3').text("উপজেলা/পৌরসভা/জোনঃ "+ areaInfo[0].name_upazila +"");
                                
                                for (var j = 0; j <  epi.length; j++) {
                                    if(areaInfo[i].unid === epi[j].unid ){
    
                                        //For the first line of micro plan table
                                        if((epi[j].wardid=='1' && epi[j].subblockid=='1') || (epi[j].wardid=='2' && epi[j].subblockid=='1') || (epi[j].wardid=='3' && epi[j].subblockid=='1')){
                                            epiMicroPlanTables+=('<tr>'
                                                                                    +'<td rowspan="8">'+replaceNoE2B(epi[j].wardid+'')+'</td>'
                                                                                    +'<td>'+getBlock(epi[j].subblockid)+'</td>'
                                                                                    +'<td id="" class="centerName">'+epi[j].centername+'&nbsp;&nbsp;&nbsp;</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].khananofrom+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].khananoto+'')+'</td>'
                                                                                    +'<td>'+getType(epi[j].centertype)+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].january+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].february+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].march+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].april+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].may+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].june+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].july+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].august+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].september+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].october+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].november+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].december+'')+'</td>'
                                                                                    +'<td rowspan="8"></td>'
                                                                                +'</tr>');
                                        
                                        //For the last line of micro plan table
                                        }else{
                                            epiMicroPlanTables+=('<tr>'
                                                                                    +'<td>'+getBlock(epi[j].subblockid)+'</td>'
                                                                                    +'<td id="" class="centerName">'+epi[j].centername+'&nbsp;&nbsp;&nbsp;</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].khananofrom+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].khananoto+'')+'</td>'
                                                                                    +'<td>'+getType(epi[j].centertype)+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].january+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].february+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].march+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].april+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].may+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].june+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].july+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].august+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].september+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].october+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].november+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].december+'')+'</td>'
                                                                                +'</tr>');
                                            
                                        }
                                        /*else if((epi[j].wardid=='1' && epi[j].subblockid=='8') || (epi[j].wardid=='2' && epi[j].subblockid=='8') || (epi[j].wardid=='3' && epi[j].subblockid=='8')){
                                            epiMicroPlanTables+=('<tr>'
                                                                                    +'<td>'+getBlock(epi[j].subblockid)+'</td>'
                                                                                    +'<td>'+epi[j].centername+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].khananofrom+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].khananoto+'')+'</td>'
                                                                                    +'<td>'+getType(epi[j].centertype)+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].january+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].february+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].march+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].april+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].may+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].june+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].july+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].august+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].september+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].october+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].november+'')+'</td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].december+'')+'</td>'
                                                                                +'</tr>'
                                                                                +'<tr>'
                                                                                    +'<td></td>'
                                                                                    +'<td></td>'
                                                                                    +'<td></td>'
                                                                                    +'<td>'+replaceNoE2B(epi[j].khananoto+'')+'</td>'
                                                                                    +'<td>'+getType(epi[j].centertype)+'</td>'
                                                                                    +'<td></td>'
                                                                                    +'<td></td>'
                                                                                    +'<td></td>'
                                                                                    +'<td></td>'
                                                                                    +'<td></td>'
                                                                                    +'<td></td>'
                                                                                    +'<td></td>'
                                                                                    +'<td></td>'
                                                                                    +'<td></td>'
                                                                                    +'<td></td>'
                                                                                    +'<td></td>'
                                                                                    +'<td></td>'
                                                                                +'</tr>');
                                        
                                        //For the middle lines of micro plan table
                                        }
                                        */
                                        
                                    }
                                }
                                epiMicroPlanTables+=('</table><br>');
                                $('#epiMicroPlanTables').html(epiMicroPlanTables);
                                
                            }
                            
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Error while fetching data</b></h4>");
                        }
                    });//end ajax
                    
                });//end pace
            }//end else
            
        });//end btn click
        
        
    });
    function getHeader(zila,upazila,union){
        return '<table class="tg" style="width: 1245px;height:200px;text-align: center;">'
                        +'<caption style="color:#000;font-weight: bold;" class="unionWiseCaption">ইউনিয়ন:- '+union+', &nbsp;&nbsp;উপজেলা:- '+ upazila +', &nbsp;&nbsp;জেলা:- '+ zila +', &nbsp;&nbsp;সন:- '+ replaceNoE2B($('#year option:selected').text()) +' ইং</caption>'
                            +'<colgroup>'
                                    +'<col style="width: 20px">'
                                    +'<col style="width: 40px">'
                                    +'<col style="width: 130px">'
                                    +'<col style="width: 25px">'
                                    +'<col style="width: 20px">'
                                    +'<col style="width: 45px">'
                                    +'<col style="width: 20px">'
                                    +'<col style="width: 20px">'
                                    +'<col style="width: 20px">'
                                    +'<col style="width: 20px">'
                                    +'<col style="width: 20px">'
                                    +'<col style="width: 20px">'
                                    +'<col style="width: 20px">'
                                    +'<col style="width: 20px">'
                                    +'<col style="width: 20px">'
                                    +'<col style="width: 10px">'
                                    +'<col style="width: 10px">'
                                    +'<col style="width: 10px">'
                                    +'<col style="width: 20px">'
                            +'</colgroup>'
                            +'<tr>'
                                    +'<td rowspan="2">ক্রমিক <br>নং</td>'
                                    +'<td rowspan="2">সাব<br>ব্লক/সাইট</td>'
                                    +'<td rowspan="2" class="">কেন্দ্রের নাম ও ঠিকানা&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>'
                                    +'<td colspan="2">বাড়ি নং</td>'
                                    +'<td rowspan="2">কেন্দ্রের ধরন<br>(স্থায়ী/ অস্থায়ী<br>কমিউনিটি<br>ক্লিনিক<br>স্যাটেলাইট)</td>'
                                    +'<td colspan="12">তারিখ</td>'
                                    +'<td rowspan="2">কর্মীর নাম, পদবী ও<br>মোবাইল নং</td>'
                            +'</tr>'
                            +'<tr>'
                                    +'<td>হতে</td>'
                                    +'<td>পর্যন্ত </td>'
                                    +'<td>জানু</td>'
                                    +'<td>ফেব্র্রু</td>'
                                    +'<td>মার্চ</td>'
                                    +'<td>এপ্রিল</td>'
                                    +'<td>মে</td>'
                                    +'<td>জুন</td>'
                                    +'<td>জুলাই</td>'
                                    +'<td>অগাস্ট</td>'
                                    +'<td>সেটেম্বর</td>'
                                    +'<td>অক্টোবর</td>'
                                    +'<td>নভেম্বর</td>'
                                    +'<td>ডিসেম্বর</td>'
                            +'</tr>';
    }
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    EPI microplan (ward wise)
    <small></small>
  </h1>
  <ol class="breadcrumb">
    <a class="btn btn-flat btn-primary btn-sm" href="schedule_epi_settings"><b><i class="fa fa-calendar-check-o" aria-hidden="true"></i>&nbsp;EPI microplan</b></a>
    <a class="btn btn-flat btn-info btn-sm" href="EPIMicroPlanning"><b><i class="fa fa-calendar-check-o" aria-hidden="true"></i>&nbsp;EPI microplan (ward wise)</b></a>
    <a class="btn btn-flat btn-primary btn-sm" href="epi_schedule_add"><b><i class="fa fa-calendar-plus-o" aria-hidden="true"></i>&nbsp;Add EPI microplan </b></a>
  </ol>
</section>
<!-- Main content -->
<section class="content" id="areaDropDownPanel">
    <!------------------------------Load Area----------------------------------->
    <div class="row">
      <div class="col-md-12">
        <div class="box box-primary">
          <div class="box-header with-border">
              <div class="box-tools pull-right" style="margin-top: -10px;">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
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
                    <label for="year">Year</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="year" id="year"> </select>
                </div>

<!--                <div class="col-md-1">
                    <label for="union">Union</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="union" id="union">
                        <option value="">- Select Union -</option>
                    </select>
                </div>-->
            </div><br>
            
            <div class="row">
<!--                <div class="col-md-1">
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
                </div>-->

                <div class="col-md-9">
                </div>

                <div class="col-md-2 col-md-offset-1">
                    <button type="button" id="btnShowSchedule" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off">
                        <i class="fa fa-calendar" aria-hidden="true"></i> <b>View Schedule</b>
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
    
    <!--Table body-->
    <div class="col-ld-12" id="tableContent">
        <div class="box box-primary">
            <div class="box-header with-border">
                <div class="box-tools pull-right" style="margin-top: -10px;">
                    <button id="printTableBtn" type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool btn-remove" data-widget="remove"><i class="fa fa-times"></i></button>
                </div>
            </div>
            <div class="box-body" id="printContent">
                <table class="coverPage" >
                    <colgroup>
                            <col style="width: 1000%">
                    </colgroup>
                    <thead>
                            <tr class="borderNone">
                                <th><h1 id="title1"></h1></th>
                            </tr>
                            <tr class="borderNone">
                                    <th><p id="title2"></p></th>
                            </tr>
                            <tr class="borderNone">
                                    <th><img width="480px" height="480px" src="resources/images/epi_child.jpg" alt="epi_child"></th>
                            </tr>
                            <tr>
                                    <th><p id="title3"></p></th>
                            </tr>
                    </thead>	
	</table>
                <h4 style="text-align: center;margin-top: 0px;" class="firstCaption"><b>ওয়ার্ড ভিত্তিক সেশন পরিকল্পনা (উপজেলা)</b></h4>
                <div class="table-responsive" id="epiMicroPlanTables">
                </div>
            </div>
        </div>
    </div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>