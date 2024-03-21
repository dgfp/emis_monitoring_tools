<%-- 
    Document   : epi_report
    Created on : Mar 21, 2017, 12:20:59 PM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_epi_bangla.js"></script>
<script src="resources/js/mis1TabResponsive.js" type="text/javascript"></script>

<style>
        .tg  {border-collapse:collapse;border-spacing:0;}
        .tg td{font-family:Arial, sans-serif;font-size:13px;padding:12px 6px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
        .tg th{font-family:Arial, sans-serif;font-size:13px;font-weight:normal;padding:12px 6px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
        .tg .tg-0e45{font-size:13px}
        .tg .tg-q19q{font-size:13px;vertical-align:top}
        .tg .tg-yw4l{vertical-align:top}
    .center{
        text-align: center;
    }
</style>
<script>
    $(document).ready(function () {

        //Show data button click
        $('#showdataButton').click(function () {
            setDefaultTable();

            if( $("select#division").val()===""){
	toastr["error"]("<h4><b>বিভাগ সিলেক্ট করুন </b></h4>");

            }else if($("select#district").val()===""){
                    toastr["error"]("<h4><b>জেলা সিলেক্ট করুন </b></h4>");

            }else if($("select#upazila").val()===""){
                    toastr["error"]("<h4><b>উপজেলা সিলেক্ট করুন </b></h4>");

            }else if($("select#union").val()===""){
                    toastr["error"]("<h4><b>ইউনিয়ন সিলেক্ট করুন </b></h4>");

            }else if($("select#ward").val()===""){
                    toastr["error"]("<h4><b>ওয়ার্ড সিলেক্ট করুন </b></h4>");

            }else if($("select#subblock").val()===""){
                    toastr["error"]("<h4><b>সাব ব্লক সিলেক্ট করুন </b></h4>");

            }else if($("select#year").val()===""){
                    toastr["error"]("<h4><b>সন সিলেক্ট করুন </b></h4>");

            }else if($("select#nameOfEPICenter").val()===""){
                    toastr["error"]("<h4><b>টিকাদান কেন্দ্রের নাম সিলেক্ট করুন </b></h4>");

            }else{
                var str=$("select#nameOfEPICenter").val();
                var epi = str.split('~');
                var scheduleDate=epi[0];
                var centerName=epi[1];
                
                var btn = $(this).button('loading');
                //Ajax Begin
                Pace.track(function(){
                    $.ajax({
                        url: "epi_report",
                        data: {
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            wardId: $("select#ward").val(),
                            subblockId: $("select#subblock").val(),
                            scheduleDate: scheduleDate,
                            centerName: centerName
                        },
                        type: 'POST',
                        success: function (result) {
                            btn.button('reset');
                            var json = JSON.parse(result);
                            
                            if (json.length === 0) {
                               toastr["error"]("<h4><b>কোন ডাটা পাওয়া যায়নি</b></h4>");
                               return;
                            }else{
                                //fill top variables 
                                //$('#epiDay').html("..");
                                $('#epiDate').html(scheduleDate);
    //                            $('#timeOfMRCombination').html("..");
    //                            $('#timeOfBCGCombination').html("..");

                                var tableBody = $('#tableBody');
                                tableBody.empty();

    //===============================calculation variables==========================================
                                var bcgReceivedTotal=0;

                                var penta1ReceivedTotal=0;
                                var penta2ReceivedTotal=0;
                                var penta3ReceivedTotal=0;

                                var pcv1ReceivedTotal=0;
                                var pcv2ReceivedTotal=0;
                                var pcv3ReceivedTotal=0;

                                var opv0ReceivedTotal=0;
                                var opv1ReceivedTotal=0;
                                var opv2ReceivedTotal=0;

                                var ipvReceivedTotal=0;

                                var mrdate1ReceivedTotal=0;
                                var mrdate2ReceivedTotal=0;

                                //Boys Girls Count
                                var penta3TotalReceivedBoy=0;
                                var penta3TotalReceivedGirl=0;

                                var ipvTotalReceivedBoy=0;
                                var ipvTotalReceivedGirl=0;

                                var mrTotalReceivedBoy=0;
                                var mrTotalReceivedGirl=0;

                                var humTotalReceivedBoy=0;
                                var humTotalReceivedGirl=0;

     //=========================================================================================
                                for (var i = 0; i <  json.length; i++) {
                                    var gender="মেয়ে";
                                    var zero="<span style='font-size:15px;'>0<span>";
                                    var emptySet="<b style='font-size:15px;'>∅<b>";

                                    //Initially value is zero
                                    var bcgStatus=zero;
                                    var penta1Status=zero;
                                    var penta2Status=zero;
                                    var penta3Status=zero;
                                    var pcv1Status=zero;
                                    var pcv2Status=zero;
                                    var pcv3Status=zero;
                                    var opv0Status=zero;
                                    var opv1Status=zero;
                                    var opv2Status=zero;
                                    var ipvStatus=zero;
                                    var mrdate1Status=zero;
                                    var mrdate2Status=zero;


                                    if(json[i].sex==="1"){
                                        gender="ছেলে";
                                    }//gender ----------------------------------------------------------------------------------------------------------

                                    if(json[i].bcg!==""){
                                        bcgStatus=emptySet;
                                        bcgReceivedTotal++;
                                    }//bcg --------------------------------------------------------------------------------------------------------------

                                    if(json[i].penta1!==""){
                                        penta1Status=emptySet;
                                        penta1ReceivedTotal++;
                                    }                                
                                    if(json[i].penta2!==""){
                                        penta2Status=emptySet;
                                        penta2ReceivedTotal++;
                                    }                                
                                    if(json[i].penta3!==""){
                                        penta3Status=emptySet;
                                        penta3ReceivedTotal++;

                                        if(json[i].sex==="1"){
                                            penta3TotalReceivedBoy++;
                                        }else{
                                            penta3TotalReceivedGirl++;
                                        }
                                    }//penta 1 2 3 -----------------------------------------------------------------------------------------------------

                                    if(json[i].pcv1!==""){
                                        pcv1Status=emptySet;
                                        pcv1ReceivedTotal++;
                                    }                                
                                    if(json[i].pcv2!==""){
                                        pcv2Status=emptySet;
                                        pcv2ReceivedTotal++;
                                    }                                
                                    if(json[i].pcv3!==""){
                                        pcv3Status=emptySet;
                                        pcv3ReceivedTotal++;
                                    }//pcv 1 2 3 -------------------------------------------------------------------------------------------------------

                                    if(json[i].opv0!==""){
                                        opv0Status=emptySet;
                                        opv0ReceivedTotal++;
                                    }                                
                                    if(json[i].opv1!==""){
                                        opv1Status=emptySet;
                                        opv1ReceivedTotal++;
                                    }                                
                                    if(json[i].opv2!==""){
                                        opv2Status=emptySet;
                                        opv2ReceivedTotal++;
                                    }//opv 0 1 2 -------------------------------------------------------------------------------------------------------

                                    if(json[i].ipv!==""){
                                        ipvStatus=emptySet;
                                        ipvReceivedTotal++;

                                        if(json[i].sex==="1"){
                                            ipvTotalReceivedBoy++;
                                        }else{
                                            ipvTotalReceivedGirl++;
                                        }
                                    }//ipv ---------------------------------------------------------------------------------------------------------------

                                    if(json[i].mrdate1!==""){
                                        mrdate1Status=emptySet;
                                        mrdate1ReceivedTotal++;

                                        if(json[i].sex==="1"){
                                            mrTotalReceivedBoy++;
                                        }else{
                                            mrTotalReceivedGirl++;
                                        }
                                    }                                
                                    if(json[i].mrdate2!==""){
                                        mrdate2Status=emptySet;
                                        mrdate2ReceivedTotal++;

                                        if(json[i].sex==="1"){
                                            humTotalReceivedBoy++;
                                        }else{
                                            humTotalReceivedGirl++;
                                        }
                                    }//mrdate 1 2 -----------------------------------------------------------------------------------------------------
                                    json[i].totalimmunization_="";
                                    var parsedData = "<tr>"
                                        +"<td class='tg-031e center'>"+(i+1)+"</td>"
                                        +"<td class='tg-031e center'>"+json[i].regno+"</td>"
                                        +"<td class='tg-031e center'>"+json[i].regdate+"</td>"
                                        +"<td class='tg-031e center'>"+json[i].nameeng+"</td>"
                                        +"<td class='tg-031e center'>"+gender+"</td>"
                                        +"<td class='tg-031e center'>"+json[i].dob+"</td>"
                                        +"<td class='tg-031e center'>"+json[i].fathername+"</td>"
                                        +"<td class='tg-031e center'>"+bcgStatus+"</td>"
                                        +"<td class='tg-031e center'>"+penta1Status+"</td>"
                                        +"<td class='tg-031e center'>"+penta2Status+"</td>"
                                        +"<td class='tg-031e center'>"+penta3Status+"</td>"
                                        +"<td class='tg-031e center'>"+pcv1Status+"</td>"
                                        +"<td class='tg-031e center'>"+pcv2Status+"</td>"
                                        +"<td class='tg-031e center'>"+pcv3Status+"</td>"
                                        +"<td class='tg-031e center'>"+opv0Status+"</td>"
                                        +"<td class='tg-031e center'>"+opv1Status+"</td>"
                                        +"<td class='tg-031e center'>"+opv2Status+"</td>"
                                        +"<td class='tg-031e center'></td>"
                                        +"<td class='tg-031e center'></td>"
                                        +"<td class='tg-031e center'>"+ipvStatus+"</td>"
                                        +"<td class='tg-031e center'>"+mrdate1Status+"</td>"
                                        +"<td class='tg-031e center'>"+mrdate2Status+"</td>"
                                        +"<td class='tg-031e center'></td>"
                                        +"<td class='tg-031e center'></td>"
                                        +"<td class='tg-yw4l center'>"+json[i].totalimmunization_+"</td>"
                                        +"<td class='tg-yw4l center'>"+json[i].bridno+"</td>"
                                        +"<td class='tg-yw4l center'>"+json[i].fillupcertidate+"</td>"
                                    +"</tr>";
                                    tableBody.append(parsedData);
                                }

    //=================================Calculation part============================================

                                //BCG pcv1ReceivedTotal
                                $('#sessionTargetBCG').html(json.length);
                                $('#sessionReceivedBCG').html(bcgReceivedTotal);
                                $('#sessionExceptBCG').html(json.length-bcgReceivedTotal);
                                //$('#sessionExternalReceivedBCG').html(bcgReceivedTotal);
                                $('#sessionTotalReceivedBCG').html(bcgReceivedTotal);

                                //Penta1
                                $('#sessionTargetPenta1').html(json.length);
                                $('#sessionReceivedPenta1').html(penta1ReceivedTotal);
                                $('#sessionExceptPenta1').html(json.length-penta1ReceivedTotal);
                                //$('#sessionExternalReceivedPenta1').html(penta1ReceivedTotal);
                                $('#sessionTotalReceivedPenta1').html(penta1ReceivedTotal);

                                //Penta2
                                $('#sessionTargetPenta2').html(json.length);
                                $('#sessionReceivedPenta2').html(penta2ReceivedTotal);
                                $('#sessionExceptPenta2').html(json.length-penta2ReceivedTotal);
                                //$('#sessionExternalReceivedPenta2').html(penta2ReceivedTotal);
                                $('#sessionTotalReceivedPenta2').html(penta2ReceivedTotal);

                                //Penta3
                                $('#sessionTargetPenta3').html(json.length);
                                $('#sessionReceivedPenta3').html(penta3ReceivedTotal);
                                $('#sessionExceptPenta3').html(json.length-penta3ReceivedTotal);
                                //$('#sessionExternalReceivedPenta3').html(penta3ReceivedTotal);
                                $('#sessionTotalReceivedPenta3').html(penta3ReceivedTotal);

                                //Pcv1
                                $('#sessionTargetPcv1').html(json.length);
                                $('#sessionReceivedPcv1').html(pcv1ReceivedTotal);
                                $('#sessionExceptPcv1').html(json.length-pcv1ReceivedTotal);
                                //$('#sessionExternalReceivedPcv1').html(pcv1ReceivedTotal);
                                $('#sessionTotalReceivedPcv1').html(pcv1ReceivedTotal);

                                //Pcv2
                                $('#sessionTargetPcv2').html(json.length);
                                $('#sessionReceivedPcv2').html(pcv2ReceivedTotal);
                                $('#sessionExceptPcv2').html(json.length-pcv2ReceivedTotal);
                                //$('#sessionExternalReceivedPcv2').html(pcv2ReceivedTotal);
                                $('#sessionTotalReceivedPcv2').html(pcv2ReceivedTotal);

                                //Pcv3 opv0ReceivedTotal
                                $('#sessionTargetPcv3').html(json.length);
                                $('#sessionReceivedPcv3').html(pcv3ReceivedTotal);
                                $('#sessionExceptPcv3').html(json.length-pcv3ReceivedTotal);
                                //$('#sessionExternalReceivedPcv3').html(pcv3ReceivedTotal);
                                $('#sessionTotalReceivedPcv3').html(pcv3ReceivedTotal);

                                //Opv0
                                $('#sessionTargetOpv0').html(json.length);
                                $('#sessionReceivedOpv0').html(opv0ReceivedTotal);
                                $('#sessionExceptOpv0').html(json.length-opv0ReceivedTotal);
                                //$('#sessionExternalReceivedOpv0').html(opv0ReceivedTotal);
                                $('#sessionTotalReceivedOpv0').html(opv0ReceivedTotal);

                                //Opv1
                                $('#sessionTargetOpv1').html(json.length);
                                $('#sessionReceivedOpv1').html(opv1ReceivedTotal);
                                $('#sessionExceptOpv1').html(json.length-opv1ReceivedTotal);
                                //$('#sessionExternalReceivedOpv1').html(opv1ReceivedTotal);
                                $('#sessionTotalReceivedOpv1').html(opv1ReceivedTotal);

                                //Opv2
                                $('#sessionTargetOpv2').html(json.length);
                                $('#sessionReceivedOpv2').html(opv2ReceivedTotal);
                                $('#sessionExceptOpv2').html(json.length-opv2ReceivedTotal);
                                //$('#sessionExternalReceivedOpv2').html(opv2ReceivedTotal);
                                $('#sessionTotalReceivedOpv2').html(opv2ReceivedTotal);

                                //IPV 
                                $('#sessionTargetIpv').html(json.length);
                                $('#sessionReceivedIpv').html(ipvReceivedTotal);
                                $('#sessionExceptIpv').html(json.length-ipvReceivedTotal);
                                //$('#sessionExternalReceivedIpv').html(ipvReceivedTotal);
                                $('#sessionTotalReceivedIpv').html(ipvReceivedTotal);

                                //mrdate1  
                                $('#sessionTargetMrdate1').html(json.length);
                                $('#sessionReceivedMrdate1').html(mrdate1ReceivedTotal);
                                $('#sessionExceptMrdate1').html(json.length-mrdate1ReceivedTotal);
                                //$('#sessionExternalReceivedMrdate1').html(mrdate1ReceivedTotal);
                                $('#sessionTotalReceivedMrdate1').html(mrdate1ReceivedTotal);

                                //mrdate2
                                $('#sessionTargetMrdate2').html(json.length);
                                $('#sessionReceivedMrdate2').html(mrdate2ReceivedTotal);
                                $('#sessionExceptMrdate2').html(json.length-mrdate2ReceivedTotal);
                                //$('#sessionExternalReceivedMrdate2').html(mrdate2ReceivedTotal);
                                $('#sessionTotalReceivedMrdate2').html(mrdate2ReceivedTotal);

                                //Boy Girl Calculation
                                $('#penta_male').html(penta3TotalReceivedBoy);
                                $('#penta_female').html(penta3TotalReceivedGirl);

                                $('#ipv_male').html(ipvTotalReceivedBoy);
                                $('#ipv_female').html(ipvTotalReceivedGirl);

                                $('#mr_male').html(mrTotalReceivedBoy);
                                $('#mr_female').html(mrTotalReceivedGirl);

                                $('#hum_male').html(humTotalReceivedBoy);
                                $('#hum_female').html(humTotalReceivedGirl);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>অনুরোধটি প্রক্রিয়াধীন করা যাচ্ছে না</b></h4>");
                        }
                    }); //Ajax end
                });//Pace End
            } //else end
            
        }); //button click end
    }); //Jquery end
    
    function setDefaultTable(){
        var tableBody = $('#tableBody');
        tableBody.empty();
        for (var i = 1; i < 18; i++) {
                var parsedData = "<tr>"
                +"<td class='tg-031e'></td>"
                +"<td class='tg-031e'></td>"
                +"<td class='tg-031e'></td>"
                +"<td class='tg-031e'></td>"
                +"<td class='tg-031e'></td>"
                +"<td class='tg-031e'></td>"
                +"<td class='tg-031e'></td>"
                +"<td class='tg-031e'></td>"
                +"<td class='tg-031e'></td>"
                +"<td class='tg-031e'></td>"
                +"<td class='tg-031e'></td>"
                +"<td class='tg-031e'></td>"
                +"<td class='tg-yw4l'></td>"
                +"<td class='tg-yw4l'></td>"
                +"<td class='tg-yw4l'></td>"
                +"<td class='tg-yw4l'></td>"
                +"<td class='tg-yw4l'></td>"
                +"<td class='tg-yw4l'></td>"
                +"<td class='tg-yw4l'></td>"
                +"<td class='tg-031e'></td>"
                +"<td class='tg-031e'></td>"
                +"<td class='tg-031e'></td>"
                +"<td class='tg-031e'></td>"
                +"<td class='tg-031e'></td>"
                +"<td class='tg-yw4l'></td>"
                +"<td class='tg-yw4l'></td>"
                +"<td class='tg-yw4l'></td>"
            +"</tr>";
                tableBody.append(parsedData);
            }
    }
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1><span style="color:#4fef2f;"><i class="fa fa-check-circle" aria-hidden="true"></i></span> EPI daily tally sheet (Infant) <small> দৈনিক টিকা ও অন্যান্য সেবা রিপোর্ট (শিশু) </small></h1>
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
          <!-- /.box-header -->
          <div class="box-body">
              
              
            <div class="row">
                <div class="col-md-1">
                  জেলা/সিটি করপোরেশনঃ
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="district" id="district"> </select>
                </div>
                
                <div class="col-md-1">
                    উপজেলা/পৌরসভা/জোনঃ
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="upazila" id="upazila">
                        <option value="">-সিল্টেক্ট করুন-</option>
                    </select>
                </div>
                
                <div class="col-md-1">
                    ইউনিয়ন/জোনঃ
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="union" id="union">
                        <option value="">-সিল্টেক্ট করুন-</option>
                    </select>
                </div>
                
<!--                <div class="col-md-1">
                    গ্রাম/মহল্লার নামঃ
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="village" id="village" disabled="">
                        <option value="">-সিল্টেক্ট করুন-</option>
                    </select>
                </div>-->
                <div class="col-md-1">
                    ওয়ার্ডঃ
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="ward" id="ward">
                        <option value="">-সিল্টেক্ট করুন-</option>
                    </select>
                </div>
            </div><br>
            
            <div class="row">
                <div class="col-md-1">
                    সাব ব্লকঃ
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="subblock" id="subblock">
                    <option value="">-সিল্টেক্ট করুন-</option>
                    </select>
                    
                </div>
                
                <div class="col-md-1">
                    সনঃ
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="year" id="year">
                        <option value="">-সিল্টেক্ট করুন-</option>
                    </select>
                </div>
                
                <div class="col-md-1">
                    টিকাদান কেন্দ্রের নামঃ
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="nameOfEPICenter" id="nameOfEPICenter">
                        <option value="">-সিল্টেক্ট করুন-</option>
                    </select>
                </div>
                <div class="col-md-1">
                </div>
                <div class="col-md-2">
                   <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block" autocomplete="off">
                        <i class="fa fa-bar-chart" aria-hidden="true"></i> ডাটা দেখান
                    </button>
                </div>
                
            </div><br>
          </div>
        </div>
      </div>
    </div>
    
    
    

    <div class="col-ld-12">
        <div class="box box-primary">
            <div class="box-header with-border">
                <div class="box-tools pull-right" style="margin-top: -10px;">
                    <button type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print</button>
                    <button type="button" class="btn btn-box-tool"><i class="fa fa-file-pdf-o" aria-hidden="true"></i>&nbsp;PDF</button>
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                </div>
            </div>
            <div class="box-body">
                <h4 style="text-align: center;margin-top: 0px;;"><b>দৈনিক টিকা ও অন্যান্য সেবা রিপোর্ট (শিশু)</b></h4>
                <h5 style="text-align: center;margin-top: 5px;">টিকাদানের বারঃ <span id="epiDay">..................................</span>    টিকা দানের তারিখঃ <span id="epiDate">..................................</span> বিসিজি টিকা সংমিশ্রণের সময়ঃ <span id="timeOfBCGCombination">..................................</span>    এমআর টিকা সংমিশ্রণের সময়ঃ <span id="timeOfMRCombination">..................................</span>  </h5>
                <div class="table-responsive">
                    <table class="tg" style="table-layout: fixed; width: 1481px;">
                        <colgroup>
                            <col style="width: 50px;">
                            <col style="width: 50px">
                            <col style="width: 85px">
                            <col style="width: 150px">
                            <col style="width: 45px">
                            <col style="width: 85px">
                            <col style="width: 150px">
                            <col style="width: 50px">
                            <col style="width: 45px">
                            <col style="width: 45px">
                            <col style="width: 45px">
                            <col style="width: 45px">
                            <col style="width: 45px">
                            <col style="width: 45px">
                            <col style="width: 45px">
                            <col style="width: 45px">
                            <col style="width: 45px">
                            <col style="width: 45px">
                            <col style="width: 45px">
                            <col style="width: 50px">
                            <col style="width: 52px">
                            <col style="width: 50px">
                            <col style="width: 60px">
                            <col style="width: 60px">
                            <col style="width: 150px">
                            <col style="width: 70px">
                            <col style="width: 70px">
                            
<!--                            <col style="width: 121px">
                            <col style="width: 81px">
                            <col style="width: 90px">-->
                        </colgroup>
                        <tr>
                            <th class="tg-031e center" rowspan="3">ক্রমিক নং</th>
                            <th class="tg-031e center" rowspan="3">রেজিঃ নং</th>
                            <th class="tg-031e center" rowspan="3">রেজিঃ<br>তারিখ</th>
                            <th class="tg-031e center" rowspan="3">শিশুর নাম</th>
                            <th class="tg-031e center" rowspan="3">ছেলে/মেয়ে</th>
                            <th class="tg-031e center" rowspan="3">জন্ম<br>তারিখ</th>
                            <th class="tg-0e45" rowspan="3">মাতা/পিতা/অভিভাবকেরঃ<br>ক) নাম<br>খ) মোবাইল নম্বর<br>গ) ঠিকানা</th>
                            <th class="tg-0e45 center" rowspan="3">বিসিজি</th>
                            <th class="tg-0e45 center" colspan="11">শিশুটি কোন টিকার কোন ডোজ পাবে তা "০" চিহ্ন দিয়ে পূরণ করুন এবং টিকা দেয়ার পর "০" চিহ্নটি আড়াআড়ি &#8709; ভাবে কেটে দিন</th>
                            <th class="tg-031e"></th>
                            <th class="tg-031e"></th>
                            <th class="tg-031e"></th>
                            <th class="tg-0e45 center" rowspan="3">১২-২৩ মাস হলে টিক চিহ্ন দিন<br>(হামের দ্বিতয় ডোজ ব্যতিত)</th>
                            <th class="tg-0e45 center" rowspan="3">প্রাপ্যতা অনুযায়ী সকল টিকা নেয়া শেষ হয়েছে (হ্যা/না)</th>
                            <th class="tg-0e45" rowspan="3">ক)শিশুকে টিকা দেওয়া সম্ভব না হলে তার কারণ লিখুন<br>খ) বহিরাগত শিশু হলে লিখুন "বহিরাগত"<br>গ) মন্তব্য (যদি থাকে ) লিখুন</th>
                            <th class="tg-q19q center" rowspan="3">শিশুটির জন্ম নিবন্ধন ফর্ম পূরণ করা হয়েছে (হ্যা/না)</th>
                            <th class="tg-q19q center" rowspan="3">শিশুটির জন্ম নিবন্ধন সার্টিফিকেট বিতরন করা হয়েছে<br>(হ্যা/না)</th>
                        </tr>
                        <tr>
                            <td class="tg-0e45 center" colspan="3">পেন্টাভ্যালেন্ট</td>
                            <td class="tg-0e45 center" colspan="3">পিসিভি</td>
                            <td class="tg-0e45 center" colspan="5">ওপিভি</td>
                            <td class="tg-0e45 center" rowspan="2">আই পিভি<br>টিকা</td>
                            <td class="tg-0e45 center" rowspan="2">এমআর<br>টিকা<br>(হাম রুবেলা)</td>
                            <td class="tg-0e45 center" rowspan="2">হামের টিকা<br>(হাম ২য় <br>ডোজ)</td>
                        </tr>
                        <tr>
                            <td class="tg-0e45 center">১ম</td>
                            <td class="tg-0e45 center">২য়</td>
                            <td class="tg-0e45 center">৩য়</td>
                            <td class="tg-0e45 center">১ম</td>
                            <td class="tg-0e45 center">২য়</td>
                            <td class="tg-0e45 center">৩য়</td>
                            <td class="tg-0e45 center">০</td>
                            <td class="tg-0e45 center">১ম</td>
                            <td class="tg-0e45 center">২য়</td>
                            <td class="tg-0e45 center">৩য়</td>
                            <td class="tg-0e45 center">৪র্থ</td>
                        </tr>
                        <tbody id="tableBody">
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        </tbody>
                        <tr>
                            <td class="tg-0e45" colspan="7">ক) (০) চিহ্ন যোগ করে আজকের সেশনের লক্ষমাত্রা লিখুন</td>
                            <td class="tg-031e center" id="sessionTargetBCG"></td>
                            <td class="tg-031e center" id="sessionTargetPenta1"></td>
                            <td class="tg-031e center" id="sessionTargetPenta2"></td>
                            <td class="tg-031e center" id="sessionTargetPenta3"></td>
                            <td class="tg-031e center" id="sessionTargetPcv1"></td>
                            <td class="tg-031e center" id="sessionTargetPcv2"></td>
                            <td class="tg-031e center" id="sessionTargetPcv3"></td>
                            <td class="tg-031e center" id="sessionTargetOpv0"></td>
                            <td class="tg-031e center" id="sessionTargetOpv1"></td>
                            <td class="tg-031e center" id="sessionTargetOpv2"></td>
                            <td class="tg-031e center" id="sessionTargetOpv3"></td>
                            <td class="tg-031e center" id="sessionTargetOpv4"></td>
                            <td class="tg-031e center" id="sessionTargetIpv"></td>
                            <td class="tg-031e center" id="sessionTargetMrdate1"></td>
                            <td class="tg-031e center" id="sessionTargetMrdate2"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-0e45 center" rowspan="2">মোট হ্যাঁ</td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                        </tr>
                        <tr>
                            <td class="tg-0e45" colspan="7">খ) (&#8709;) চিহ্ন যোগ করে আজকের সেশনের টিকা পাওয়া উদ্দিষ্ট শিশুর মোট সংখ্যা লিখুন</td>
                            <td class="tg-031e center" id="sessionReceivedBCG"></td>
                            <td class="tg-031e center" id="sessionReceivedPenta1"></td>
                            <td class="tg-031e center" id="sessionReceivedPenta2"></td>
                            <td class="tg-031e center" id="sessionReceivedPenta3"></td>
                            <td class="tg-031e center" id="sessionReceivedPcv1"></td>
                            <td class="tg-031e center" id="sessionReceivedPcv2"></td>
                            <td class="tg-031e center" id="sessionReceivedPcv3"></td>
                            <td class="tg-031e center" id="sessionReceivedOpv0"></td>
                            <td class="tg-031e center" id="sessionReceivedOpv1"></td>
                            <td class="tg-031e center" id="sessionReceivedOpv2"></td>
                            <td class="tg-031e center" id="sessionReceivedOpv3"></td>
                            <td class="tg-031e center" id="sessionReceivedOpv4"></td>
                            <td class="tg-031e center" id="sessionReceivedIpv"></td>
                            <td class="tg-031e center" id="sessionReceivedMrdate1"></td>
                            <td class="tg-031e center" id="sessionReceivedMrdate2"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                        </tr>
                        <tr>
                            <td class="tg-0e45" colspan="7">গ) আজকের সেশনে বাদপড়া শিশুর (উদ্দিষ্ট) মোট সংখ্যা (ক-খ)</td>
                            <td class="tg-031e center" id="sessionExceptBCG"></td>
                            <td class="tg-031e center" id="sessionExceptPenta1"></td>
                            <td class="tg-031e center" id="sessionExceptPenta2"></td>
                            <td class="tg-031e center" id="sessionExceptPenta3"></td>
                            <td class="tg-031e center" id="sessionExceptPcv1"></td>
                            <td class="tg-031e center" id="sessionExceptPcv2"></td>
                            <td class="tg-031e center" id="sessionExceptPcv3"></td>
                            <td class="tg-031e center" id="sessionExceptOpv0"></td>
                            <td class="tg-031e center" id="sessionExceptOpv1"></td>
                            <td class="tg-031e center" id="sessionExceptOpv2"></td>
                            <td class="tg-031e center" id="sessionExceptOpv3"></td>
                            <td class="tg-031e center" id="sessionExceptOpv4"></td>
                            <td class="tg-031e center" id="sessionExceptIpv"></td>
                            <td class="tg-031e center" id="sessionExceptMrdate1"></td>
                            <td class="tg-031e center" id="sessionExceptMrdate2"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-0e45 center" colspan="4" rowspan="2">আজকের সেশনের টিকাপ্রাপ্ত শিশুদের মধ্যে প্রাপ্যতা অনুযায়ী সকল টিকা নেওয়া শেষ হয়েছেঃ (রেজিঃ বই শেষ হয়েছে)</td>
                        </tr>
                        <tr>
                            <td class="tg-0e45" colspan="7">ঘ) (&#8709;) চিহ্ন যোগ করে আজকের সেশনের বহিরাগত টিকা পাওয়া শিশুর মোট সংখ্যা লিখুন</td>
                            <td class="tg-031e center" id="sessionExternalReceivedBCG"></td>
                            <td class="tg-031e center" id="sessionExternalReceivedPenta1"></td>
                            <td class="tg-031e center" id="sessionExternalReceivedPenta2"></td>
                            <td class="tg-031e center" id="sessionExternalReceivedPenta3"></td>
                            <td class="tg-031e center" id="sessionExternalReceivedPcv1"></td>
                            <td class="tg-031e center" id="sessionExternalReceivedPcv2"></td>
                            <td class="tg-031e center" id="sessionExternalReceivedPcv3"></td>
                            <td class="tg-031e center" id="sessionExternalReceivedOpv0"></td>
                            <td class="tg-031e center" id="sessionExternalReceivedOpv1"></td>
                            <td class="tg-031e center" id="sessionExternalReceivedOpv2"></td>
                            <td class="tg-031e center" id="sessionExternalReceivedOpv3"></td>
                            <td class="tg-031e center" id="sessionExternalReceivedOpv4"></td>
                            <td class="tg-031e center" id="sessionExternalReceivedIpv"></td>
                            <td class="tg-031e center" id="sessionExternalReceivedMrdate1"></td>
                            <td class="tg-031e center" id="sessionExternalReceivedMrdate2"></td>
                            <td class="tg-031e"></td>
                        </tr>
                        <tr>
                            <td class="tg-0e45" colspan="7">ঙ) (&#8709;) চিহ্ন যোগ করে আজকের সেশনের সর্বমোট টিকা পাওয়া শিশুর সংখ্যা লিখুন (খ+ঘ)</td>
                            <td class="tg-031e center" id="sessionTotalReceivedBCG"></td>
                            <td class="tg-031e center" id="sessionTotalReceivedPenta1"></td>
                            <td class="tg-031e center" id="sessionTotalReceivedPenta2"></td>
                            <td class="tg-031e center" id="sessionTotalReceivedPenta3"></td>
                            <td class="tg-031e center" id="sessionTotalReceivedPcv1"></td>
                            <td class="tg-031e center" id="sessionTotalReceivedPcv2"></td>
                            <td class="tg-031e center" id="sessionTotalReceivedPcv3"></td>
                            <td class="tg-031e center" id="sessionTotalReceivedOpv0"></td>
                            <td class="tg-031e center" id="sessionTotalReceivedOpv1"></td>
                            <td class="tg-031e center" id="sessionTotalReceivedOpv2"></td>
                            <td class="tg-031e center" id="sessionTotalReceivedOpv3"></td>
                            <td class="tg-031e center" id="sessionTotalReceivedOpv4"></td>
                            <td class="tg-031e center" id="sessionTotalReceivedIpv"></td>
                            <td class="tg-031e center" id="sessionTotalReceivedMrdate1"></td>
                            <td class="tg-031e center" id="sessionTotalReceivedMrdate2"></td>
                            <td class="tg-0e45 center" colspan="4"> ছেলের সংখ্যাঃ                   মেয়ের সংখ্যাঃ</td>
                        </tr>
                        <tr>
                            <td class="tg-0e45 center" colspan="4">টিকা পাওয়া ছেলে এবং মেয়ের সংখ্যা</td>
                            <td class="tg-0e45" colspan="4">পেন্টা ৩ঃ    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ছেলে - <span id="penta_male"></span>    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                মেয়ে - <span id="penta_female"></span></td>
                            
                            <td class="tg-0e45" colspan="8">আইপিভিঃ    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ছেলে - <span id="ipv_male"></span>    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                মেয়ে - <span id="ipv_female"></span></td>
                            
                            <td class="tg-q19q" colspan="6">এমআরঃ    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ছেলে - <span id="mr_male"></span>    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                মেয়ে - <span id="mr_female"></span></td>
                            
                            <td class="tg-0e45" colspan="5">হামঃ    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ছেলে - <span id="hum_male"></span>    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                মেয়ে - <span id="hum_female"></span></td>
                        </tr>
                        <tr><td colspan="27"><table>                        <tr>
                            <td class="tg-q19q" colspan="2" rowspan="3">প্রাপ্ত ভ্যাকসিন ভায়ালের <br>হিসাব</td>
                            <td class="tg-q19q" colspan="4">বিসিজি ও ডাইলুয়েন্ট</td>
                            <td class="tg-q19q" colspan="3">পেন্টা (ডিপিটি,হেপ-বি,হিব)</td>
                            <td class="tg-q19q" colspan="3">পিসিভি</td>
                            <td class="tg-q19q" colspan="4">ওপিভি</td>
                            <td class="tg-q19q" colspan="3">আইপিভি</td>
                            <td class="tg-q19q" colspan="6">এমআর টিকা ও ডাইলুয়েন্ট </td>
                            <td class="tg-q19q" colspan="4">হাম টিকা ও ডাইলুয়েন্ট</td>
                        </tr>
                        <tr>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q">ভ্যাকসিন<br>প্রস্তুত কারকের নাম</td>
                            <td class="tg-q19q">ডাইলুয়েন্ট প্রস্তুতকারকের নাম</td>
                            <td class="tg-q19q">ব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা g</td>
                            <td class="tg-q19q">ব্যবহৃত</td>
                            <td class="tg-q19q">অব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q">অব্যবহৃত</td>
                            <td class="tg-q19q">অব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q">পূর্ণ ব্যবহৃত</td>
                            <td class="tg-q19q">আংশিক ব্যবহৃত</td>
                            <td class="tg-q19q">অব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q">ব্যবহৃত</td>
                            <td class="tg-q19q">অব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q" colspan="2">ভ্যাকসিন প্রস্তুতকারকের নাম</td>
                            <td class="tg-q19q" colspan="2">ডাইলুয়েন্ট প্রস্তুতকারকের নাম</td>
                            <td class="tg-q19q">ব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q">ভ্যাকসিন প্রস্তুতকারকের নাম</td>
                            <td class="tg-q19q">ডাইলুয়েন্ট<br>প্রস্তুতকারকের নাম</td>
                            <td class="tg-q19q">ব্যবহৃত</td>
                        </tr>
                        <tr>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr></table></td></tr>
                        <tr>
                            <td class="tg-q19q" colspan="14">স্বাস্থ্য সহকারী/ টিকাদানকারীর নাম ও স্বাক্ষর</td>
                            <td class="tg-q19q" colspan="13">পঃ কঃ সহকারী/ টিকাদানকারীর নাম ও স্বাক্ষরঃ</td>
                        </tr>
                        <tr>
                            <td class="tg-q19q" colspan="14">স্বাঃ পরিঃ/ সহ স্বাঃ পরিঃ/সহঃ পঃ পঃ পরিঃ- এর নাম, পদবী ও স্বাক্ষর</td>
                            <td class="tg-q19q" colspan="13">মন্তব্য</td>
                        </tr>
                        <tr>
                            <td class="tg-q19q" colspan="14">উপঃ স্বাঃ ও পঃ পঃ কর্মকর্তা/ সি সি / পৌরসভা কর্তৃপক্ষ/ অন্যান্য সুপারভাইজারের নাম, পদবী, মোবাইল নং ও স্বাক্ষর</td>
                            <td class="tg-q19q" colspan="13">মন্তব্য</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
            <!-- End tally sheet -->
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>



<!--<div id="page-wrapper" style="margin-top:-20px;">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <h3>দৈনিক টিকা ও অন্যান্য সেবা রিপোর্ট(শিশু)</h3>
            </div>
        </div>

        <div class="well well-sm">
            <div class="row">


                <div class="col-md-2">
                    <label for="sub_block">সাব ব্লকঃ</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="sub_block" id="sub_block"> </select>
                </div>
                <div class="col-md-2">
                    <label for="name_of_vaccine_taking_place">টিকাদান কেন্দ্রের নামঃ</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="name_of_vaccine_taking_place" id="name_of_vaccine_taking_place"> </select>
                </div>
                <div class="col-md-2">
                    <label for="village">গ্রাম/মহল্লার নামঃ</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="village" id="village"> </select>
                </div>

            </div>

            <div class="row">
                <div class="col-md-2">
                    <label for="ward">ওয়ার্ডঃ</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="ward" id="ward"> </select>
                </div>
                <div class="col-md-2">
                    <label for="union">ইউনিয়ন/জোনঃ</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="union" id="union"> </select>
                </div>
                <div class="col-md-2">
                    <label for="upazila">উপজেলা/পৌরসভা/জোনঃ</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="upazila" id="upazila"> </select>
                </div>



            </div>


            <div class="row">
                <div class="col-md-2">
                    <label for="district">জেলা/সিটি করপোরেশনঃ</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="district" id="district"> </select>
                </div>
                <div class="col-md-2">
                    <label for="week_day_of_vaccine">টিকাদানের  বারঃ</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="week_day_of_vaccine" id="week_day_of_vaccine"> </select>
                </div>

                <div class="col-md-2">
                    <label for="startDate">টিকা দানের তারিখঃ</label>
                </div>

                <div class="col-md-2">
                    <input type="text" class="input form-control input-sm" placeholder="dd/mm/yyyy" name="startDate" id="startDate"/>
                </div>



            </div>
        </div>
    </div>

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
            <div class="col-ld-12">
                <div class="table-responsive">
                    <table class="tg" style="table-layout: fixed; width: 1481px">
                        <colgroup>
                            <col style="width: 41px">
                            <col style="width: 51px">
                            <col style="width: 61px">
                            <col style="width: 61px">
                            <col style="width: 51px">
                            <col style="width: 51px">
                            <col style="width: 41px">
                            <col style="width: 41px">
                            <col style="width: 42px">
                            <col style="width: 41px">
                            <col style="width: 62px">
                            <col style="width: 31px">
                            <col style="width: 31px">
                            <col style="width: 31px">
                            <col style="width: 31px">
                            <col style="width: 31px">
                            <col style="width: 31px">
                            <col style="width: 31px">
                            <col style="width: 31px">
                            <col style="width: 31px">
                            <col style="width: 31px">
                            <col style="width: 31px">
                            <col style="width: 51px">
                            <col style="width: 56px">
                            <col style="width: 51px">
                            <col style="width: 66px">
                            <col style="width: 81px">
                            <col style="width: 121px">
                            <col style="width: 81px">
                            <col style="width: 90px">
                        </colgroup>
                        <tr>
                            <th class="tg-031e" rowspan="3">ক্রমিক নং</th>
                            <th class="tg-031e" rowspan="3">রেজিঃ নং</th>
                            <th class="tg-031e" rowspan="3">রেজিঃ<br>তারিখ</th>
                            <th class="tg-031e" rowspan="3">শিশুর নাম</th>
                            <th class="tg-031e" rowspan="3">ছেলে/মেয়ে</th>
                            <th class="tg-031e" rowspan="3">জন্ম<br>তারিখ</th>
                            <th class="tg-0e45" colspan="4" rowspan="3">মাতা/পিতা/অভিভাবকেরঃ<br>ক) নাম<br>খ) মোবাইল নম্বর<br>গ) ঠিকানা</th>
                            <th class="tg-0e45" rowspan="3">বিসিজি</th>
                            <th class="tg-0e45" colspan="11">শিশুটি কোন টিকার কোন ডোজ পাবে তা "০" চিহ্ন দিয়ে পূরণ করুন এবং টিকা দেয়ার পর "০" চিহ্নটি আড়াআড়িভাবে কেটে দিন</th>
                            <th class="tg-031e"></th>
                            <th class="tg-031e"></th>
                            <th class="tg-031e"></th>
                            <th class="tg-0e45" rowspan="3">১২-২৩ মাস হলে টিক চিহ্ন দিন<br>(হামের দ্বিতয় ডোজ ব্যতিত)</th>
                            <th class="tg-0e45" rowspan="3">প্রাপ্যতা অনুযায়ী সকল টিকা নেয়া শেষ হয়েছে (হ্যা/না)</th>
                            <th class="tg-q19q" rowspan="3">ক)শিশুকে টিকা দেওয়া সম্ভব না হলে তার কারণ লিখুন<br>খ) বহিরাগত শিশু হলে লিখুন "বহিরাগত"<br>গ) মন্তব্য (যদি থাকে ) লিখুন</th>
                            <th class="tg-q19q" rowspan="3">শিশুটির জন্ম নিবন্ধন ফর্ম পূরণ করা হয়েছে (হ্যা/না)</th>
                            <th class="tg-q19q" rowspan="3">শিশুটির জন্ম নিবন্ধন সার্টিফিকেট বিতরন করা হয়েছে<br>(হ্যা/না)</th>
                        </tr>
                        <tr>
                            <td class="tg-0e45" colspan="3">পেন্টাভ্যালেন্ট</td>
                            <td class="tg-0e45" colspan="3">পিসিভি</td>
                            <td class="tg-q19q" colspan="5">ওপিভি</td>
                            <td class="tg-0e45" rowspan="2">আই পিভি<br>টিকা</td>
                            <td class="tg-0e45" rowspan="2">এমআর<br>টিকা<br>(হাম রুবেলা)</td>
                            <td class="tg-0e45" rowspan="2">হামের টিকা<br>(হাম ২য় <br>ডোজ)</td>
                        </tr>
                        <tr>
                            <td class="tg-0e45">১ম</td>
                            <td class="tg-0e45">২য়</td>
                            <td class="tg-0e45">৩য়</td>
                            <td class="tg-0e45">১ম</td>
                            <td class="tg-q19q">২য়</td>
                            <td class="tg-q19q">৩য়</td>
                            <td class="tg-q19q">০</td>
                            <td class="tg-q19q">১ম</td>
                            <td class="tg-q19q">২য়</td>
                            <td class="tg-q19q">৩য়</td>
                            <td class="tg-q19q">৪র্থ</td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-0e45" colspan="10">ক) (০) চিহ্ন যোগ করে আজকের সেশনের লক্ষমাত্রা লিখুন</td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-0e45" rowspan="2">মোট হ্যাঃ</td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-0e45" colspan="10">খ) () চিহ্ন যোগ করে আজকের সেশনের টিকা পাওয়া উদ্দিষ্ট শিশুর মোট সংখ্যা লিখুন</td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-0e45" colspan="10">গ) আজকের সেশনে বাদপড়া শিশুর (উদ্দিষ্ট) মোট সংখ্যা (ক-খ)</td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-0e45" colspan="4" rowspan="2">আজকের সেশনের টিকাপ্রাপ্ত শিশুদের মধ্যে প্রাপ্যতা অনুযায়ী সকল টিকা নেওয়া শেষ হয়েছেঃ (রেজিঃ বই শেষ হয়েছে)</td>
                        </tr>
                        <tr>
                            <td class="tg-0e45" colspan="10">ঘ) () চিহ্ন যোগ করে আজকের সেশনের বহিরাগত টিকা পাওয়া শিশুর মোট সংখ্যা লিখুন</td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                        </tr>
                        <tr>
                            <td class="tg-0e45" colspan="10">ঙ) () চিহ্ন যোগ করে আজকের সেশনের সর্বমোট টিকা পাওয়া শিশুর সংখ্যা লিখুন (খ+ঘ)</td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-0e45" colspan="4">       ছেলের সংখ্যাঃ                   মেয়ের সংখ্যাঃ</td>
                        </tr>
                        <tr>
                            <td class="tg-0e45" colspan="4">টিকা পাওয়া ছেলে এবং মেয়ের সংখ্যা</td>
                            <td class="tg-0e45" colspan="7">পেন্টা ৩ঃ ছেলেঃ                     মেয়েঃ</td>
                            <td class="tg-0e45" colspan="8">আইপিভিঃ ছেলেঃ           মেয়েঃ </td>
                            <td class="tg-q19q" colspan="6">এমআরঃ ছেলেঃ                 মেয়েঃ</td>
                            <td class="tg-0e45" colspan="5">হামঃ ছেলেঃ                                                     মেয়েঃ </td>
                        </tr>
                        <tr>
                            <td class="tg-q19q" colspan="2" rowspan="3">প্রাপ্ত ভ্যাকসিন ভায়ালের <br>হিসাব</td>
                            <td class="tg-q19q" colspan="5">বিসিজি ও ডাইলুয়েন্ট</td>
                            <td class="tg-q19q" colspan="5">পেন্টা (ডিপিটি,হেপ-বি,হিব)</td>
                            <td class="tg-q19q" colspan="3">পিসিভি</td>
                            <td class="tg-q19q" colspan="4">ওপিভি</td>
                            <td class="tg-q19q" colspan="3">আইপিভি</td>
                            <td class="tg-q19q" colspan="6">এমআর টিকা ও ডাইলুয়েন্ট </td>
                            <td class="tg-q19q" colspan="4">হাম টিকা ও ডাইলুয়েন্ট</td>
                        </tr>
                        <tr>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q">ভ্যাকসিন<br>প্রস্তুত কারকের নাম</td>
                            <td class="tg-q19q" colspan="2">ডাইলুয়েন্ট প্রস্তুতকারকের নাম</td>
                            <td class="tg-q19q">ব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা </td>
                            <td class="tg-q19q">ব্যবহৃত</td>
                            <td class="tg-q19q">অব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q">অব্যবহৃত</td>
                            <td class="tg-q19q">অব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q">পূর্ণ ব্যবহৃত</td>
                            <td class="tg-q19q">আংশিক ব্যবহৃত</td>
                            <td class="tg-q19q">অব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q">ব্যবহৃত</td>
                            <td class="tg-q19q">অব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q" colspan="2">ভ্যাকসিন প্রস্তুতকারকের নাম</td>
                            <td class="tg-q19q" colspan="2">ডাইলুয়েন্ট প্রস্তুতকারকের নাম</td>
                            <td class="tg-q19q">ব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q">ভ্যাকসিন প্রস্তুতকারকের নাম</td>
                            <td class="tg-q19q">ডাইলুয়েন্ট<br>প্রস্তুতকারকের নাম</td>
                            <td class="tg-q19q">ব্যবহৃত</td>
                        </tr>
                        <tr>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l" colspan="2"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-q19q" colspan="15">স্বাস্থ্য সহকারী/ টিকাদানকারীর নাম ও স্বাক্ষর</td>
                            <td class="tg-q19q" colspan="15">পঃ কঃ সহকারী/ টিকাদানকারীর নাম ও স্বাক্ষরঃ</td>
                        </tr>
                        <tr>
                            <td class="tg-q19q" colspan="15">স্বাঃ পরিঃ/ সহ স্বাঃ পরিঃ/সহঃ পঃ পঃ পরিঃ- এর নাম, পদবী ও স্বাক্ষর</td>
                            <td class="tg-q19q" colspan="15">মন্তব্য</td>
                        </tr>
                        <tr>
                            <td class="tg-q19q" colspan="15">উপঃ স্বাঃ ও পঃ পঃ কর্মকর্তা/ সি সি / পৌরসভা কর্তৃপক্ষ/ অন্যান্য সুপারভাইজারের নাম, পদবী, মোবাইল নং ও স্বাক্ষর</td>
                            <td class="tg-q19q" colspan="15">মন্তব্য</td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- End tally sheet -->
    
    
    
<!--    
        </div>

    </div>-->
