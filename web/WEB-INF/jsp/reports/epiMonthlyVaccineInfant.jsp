<%-- 
    Document   : epi_report
    Created on : May 25, 2017, 12:20:59 PM
    Author     : Helal | m.helal.k@gmail.com
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_epi_monthly_bangla.js"></script>
<!--<script src="resources/js/mis1TabResponsive.js" type="text/javascript"></script>-->

<style>
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
            padding-left: 5px!important;
        }
        .deactive{
            background-color: #f4f2f2;
        }
        .hide{
            display: none;
        }
        @font-face {
            font-family: SolaimanLipi;
            src: url('resources/fonts/SolaimanLipi.ttf');
        }
        [class*="col"] { margin-bottom: 10px; }
        .export{
            display: none;
        }
</style>

<script>
    $(document).ready(function(){
        
        //======Print Data
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
            //frameDoc.document.write('<style>table, th, td{border:1px solid black; border-collapse: collapse;padding:10px;}th{vertical-align: text-center} td{text-align:right;}</style>');


            frameDoc.document.write('<style>table, th, td{} .tg  {border-collapse:collapse;border-spacing:0;}</style>');
            frameDoc.document.write('<style>.tg td{font-family: SolaimanLipi;font-size:15px;padding:7px 6px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}</style>');
            frameDoc.document.write('<style>.tf td{font-family: SolaimanLipi;font-size:15px;padding:0px!important;padding-right: 26px!important;border-width:0px;overflow:hidden;}</style>');
            frameDoc.document.write('<style>table{width: 1845px;} .caption{margin-top:6px!important;} #title{text-align: right;}</style>');


            //Append the DIV contents.
            //frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center!important;"><center>EPI monthly report (Infant)</center></h3>');
            //frameDoc.document.write('<h5 style="color:black;text-align:center!important;"><center>'+areaText+'</center></h5>');
            frameDoc.document.write(contents);
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 500);
        });
        
        
        
        $('#showdataButton').click(function () {
            $('#tableBody').html("");
            setDefault();
            
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

            }
//            else if($("select#subblock").val()===""){
//                    toastr["error"]("<h4><b>সাব ব্লক সিলেক্ট করুন </b></h4>");
//
//            }
            else if($("select#year").val()===""){
                    toastr["error"]("<h4><b>সন সিলেক্ট করুন </b></h4>");

            }
            else if($("select#month").val()===""){
                    toastr["error"]("<h4><b>মাস সিলেক্ট করুন</b></h4>");

            }
//            else if($("select#nameOfEPICenter").val()===""){
//                    toastr["error"]("<h4><b>টিকাদান কেন্দ্রের নাম সিলেক্ট করুন </b></h4>");
//
//            }
            else{
                //load----------------------------------------------------------------
                var btn = $(this).button('loading');
                
                $.ajax({
                    url: "EPIMonthlyVaccineInfant",
                    data: {
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val(),
                        wardId: $("select#ward").val(),
                        month: $("select#month").val(),
                        year: $("select#year").val()
                    },
                    type: 'POST',
                    success: function (result) {
                        btn.button('reset');
                        var json = JSON.parse(result);
                        
                        if (json.length === 0) {
                            toastr["error"]("<h4><b>কোন ডাটা পাওয়া যায়নি</b></h4>");
                            return;
                        }else{
                            
                            $('#yearName').html(convertE2B("<b>"+$("select#year").val())+"</b>&nbsp;&nbsp;&nbsp;&nbsp;");
                            $('#monthName').html("<b>"+$( "#month option:selected" ).text()+"</b>&nbsp;&nbsp;&nbsp;&nbsp;");
                            $('#districtName').html("<b>"+$( "#district option:selected" ).text()+"</b>&nbsp;&nbsp;&nbsp;&nbsp;");
                            
                            
                            var tableBody = $('#tableBody');
                            tableBody.empty();
//===============================calculation variables===========================================
                            var bcgReceiptTotal=0;
                            
                            var penta1ReceiptTotal=0;
                            var penta2ReceiptTotal=0;
                            var penta3MaleReceiptTotal=0;
                            var penta3FemaleReceiptTotal=0;
                            
                            var pcv1ReceiptTotal=0;
                            var pcv2ReceiptTotal=0;
                            var pcv3MaleReceiptTotal=0;
                            var pcv3FemaleReceiptTotal=0;
                            
                            var opv0ReceiptTotal=0;
                            var opv1ReceiptTotal=0;
                            var opv2ReceiptTotal=0;
                            var opv3ReceiptTotal=0;
                            
                            var ipv1MaleReceiptTotal=0;
                            var ipv1FemaleReceiptTotal=0;
                            var ipv2MaleReceiptTotal=0;
                            var ipv2FemaleReceiptTotal=0;
                            
                            var mr1MaleReceiptTotal=0;
                            var mr1FemaleReceiptTotal=0;
                            var mr2MaleReceiptTotal=0;
                            var mr2FemaleReceiptTotal=0;
                            
                            var totalImmunizationMaleReceiptTotal=0;
                            var totalImmunizationFemaleReceiptTotal=0;
                            
                            var fillupCertiDateReceiptTotal=0;
                            var brIdNoReceiptTotal=0;
                            var deathCntReceiptTotal=0;
                            
                            for (var i = 0; i < json.length; i++) {
                                
                                var bcg="-";
                                
                                var penta1="-";
                                var penta2="-";
                                var penta3Male="-";
                                var penta3Female="-";
                                
                                var pcv1="-";
                                var pcv2="-";
                                var pcv3Male="-";
                                var pcv3Female="-";
                                
                                var opv0="-";
                                var opv1="-";
                                var opv2="-";
                                var opv3="-";
                                
                                var ipv1Male="-";
                                var ipv1Female="-";
                                var ipv2Male="-";
                                var ipv2Female="-";
                                
                                var mr1Male="-";
                                var mr1Female="-";
                                var mr2Male="-";
                                var mr2Female="-";
                                
                                var totalImmunizationMale="-";
                                var totalImmunizationFemale="-";
                                
                                var fillupCertiDate="-";
                                var brIdNo="-";
                                var deathCnt="-";
                                
                                //-----bcg----------------------------------------------------------------------------------------------------------------------------------------
                                if(json[i].bcg!==""){
                                    bcg=convertE2B(json[i].bcg);
                                    bcgReceiptTotal+=json[i].bcg;
                                }
                                //-----penta-------------------------------------------------------------------------------------------------------------------------------------
                                if(json[i].penta1!==""){
                                    penta1=convertE2B(json[i].penta1);
                                    penta1ReceiptTotal+=json[i].penta1;
                                }
                                if(json[i].penta2!==""){
                                    penta2=convertE2B(json[i].penta2);
                                    penta2ReceiptTotal+=json[i].penta2;
                                }
                                if(json[i].penta3_male!==""){
                                    penta3Male=convertE2B(json[i].penta3_male);
                                    penta3MaleReceiptTotal+=json[i].penta3_male;
                                }
                                if(json[i].penta3_female!==""){
                                    penta3Female=convertE2B(json[i].penta3_female);
                                    penta3FemaleReceiptTotal+=json[i].penta3_female;
                                }
                                //-----pcv----------------------------------------------------------------------------------------------------------------------------------------
                                if(json[i].pcv1!==""){
                                    pcv1=convertE2B(json[i].pcv1);
                                    pcv1ReceiptTotal+=json[i].pcv1;
                                }
                                if(json[i].pcv2!==""){
                                    pcv2=convertE2B(json[i].pcv2);
                                    pcv2ReceiptTotal+=json[i].pcv2;
                                }
                                if(json[i].pcv3_male!==""){
                                    pcv3Male=convertE2B(json[i].pcv3_male);
                                    pcv3MaleReceiptTotal+=json[i].pcv3_male;
                                }
                                if(json[i].pcv3_female!==""){
                                    pcv3Female=convertE2B(json[i].pcv3_female);
                                    pcv3FemaleReceiptTotal+=json[i].pcv3_female;
                                }
                                //-----opv----------------------------------------------------------------------------------------------------------------------------------------
                                if(json[i].opv0!==""){
                                    opv0=convertE2B(json[i].opv0);
                                    opv0ReceiptTotal+=json[i].opv0;
                                }
                                if(json[i].opv1!==""){
                                    opv1=convertE2B(json[i].opv1);
                                    opv1ReceiptTotal+=json[i].opv1;
                                }
                                if(json[i].opv2!==""){
                                    opv2=convertE2B(json[i].opv2);
                                    opv2ReceiptTotal+=json[i].opv2;
                                }
                                if(json[i].opv3!==""){
                                    opv3=convertE2B(json[i].opv3);
                                    opv3ReceiptTotal+=json[i].opv3;
                                }
                                //-----ipv-----------------------------------------------------------------------------------------------------------------------------------------
                                if(json[i].ipv1_male!==""){
                                    ipv1Male=convertE2B(json[i].ipv1_male);
                                    ipv1MaleReceiptTotal+=json[i].ipv1_male;
                                }
                                if(json[i].ipv1_female!==""){
                                    ipv1Female=convertE2B(json[i].ipv1_female);
                                    ipv1FemaleReceiptTotal+=json[i].ipv1_female;
                                }
                                if(json[i].ipv2_male!==""){
                                    ipv2Male=convertE2B(json[i].ipv2_male);
                                    ipv2MaleReceiptTotal+=json[i].ipv2_male;
                                }
                                if(json[i].ipv2_female!==""){
                                    ipv2Female=convertE2B(json[i].ipv2_female);
                                    ipv2FemaleReceiptTotal+=json[i].ipv2_female;
                                }
                                //-----mr-----------------------------------------------------------------------------------------------------------------------------------------
                                if(json[i].mrdate1_male!==""){
                                    mr1Male=convertE2B(json[i].mrdate1_male);
                                    mr1MaleReceiptTotal+=json[i].mrdate1_male;
                                }
                                if(json[i].mrdate1_female!==""){
                                    mr1Female=convertE2B(json[i].mrdate1_female);
                                    mr1FemaleReceiptTotal+=json[i].mrdate1_female;
                                }
                                if(json[i].mrdate2_male!==""){
                                    mr2Male=convertE2B(json[i].mrdate2_male);
                                    mr2MaleReceiptTotal+=json[i].mrdate2_male;
                                }
                                if(json[i].mrdate2_female!==""){
                                    mr2Female=convertE2B(json[i].mrdate2_female);
                                    mr2FemaleReceiptTotal+=json[i].mrdate2_female;
                                }
                                //-----Imu total---------------------------------------------------------------------------------------------------------------------------------
                                if(json[i].totalimmunization_male!==""){
                                    totalImmunizationMale=convertE2B(json[i].totalimmunization_male);
                                    totalImmunizationMaleReceiptTotal+=json[i].totalimmunization_male;
                                }
                                if(json[i].totalimmunization_female!==""){
                                    totalImmunizationFemale=convertE2B(json[i].totalimmunization_female);
                                    totalImmunizationFemaleReceiptTotal+=json[i].totalimmunization_female;
                                }
                                //-----Others---------------------------------------------------------------------------------------------------------------------------------
                                if(json[i].fillupcertidate!==""){
                                    fillupCertiDate=convertE2B(json[i].fillupcertidate);
                                    fillupCertiDateReceiptTotal+=json[i].fillupcertidate;
                                }
                                if(json[i].bridno!==""){
                                    brIdNo=convertE2B(json[i].bridno);
                                    brIdNoReceiptTotal+=json[i].bridno;
                                }
                                if(json[i].death_cnt!==""){
                                    deathCnt=convertE2B(json[i].death_cnt);
                                    deathCntReceiptTotal+=json[i].death_cnt;
                                }
                                
                                var parsedData='<tr>'
                                    +'<td id="">'+  convertE2B((i+1)) +'</td>'
                                    +'<td class="left">'+json[i].centername+'</td>'
                                    +'<td >'+bcg+'</td>'
                                    +'<td>'+penta1+'</td>'
                                    +'<td>'+penta2+'</td>'
                                    +'<td>'+penta3Male+'</td>'
                                    +'<td>'+penta3Female+'</td>'
                                    +'<td>'+pcv1+'</td>'
                                    +'<td>'+pcv2+'</td>'
                                    +'<td>'+pcv3Male+'</td>'
                                    +'<td>'+pcv3Female+'</td>'
                                    +'<td>'+opv0+'</td>'
                                    +'<td>'+opv1+'</td>'
                                    +'<td>'+opv2+'</td>'
                                    +'<td>'+opv3+'</td>'
                                    +'<td>'+ipv1Male+'</td>'
                                    +'<td>'+ipv1Female+'</td>'
                                    +'<td>'+ipv2Male+'</td>'
                                    +'<td>'+ipv2Female+'</td>'
                                    +'<td>'+mr1Male+'</td>'
                                    +'<td>'+mr1Female+'</td>'
                                    +'<td>'+mr2Male+'</td>'
                                    +'<td>'+mr2Female+'</td>'
                                    +'<td></td>'
                                    +'<td></td>'
                                    +'<td></td>'
                                    +'<td></td>'
                                    +'<td></td>'
                                    +'<td>'+totalImmunizationMale+'</td>'
                                    +'<td>'+totalImmunizationFemale+'</td>'
                                    +'<td>'+fillupCertiDate+'</td>'
                                    +'<td>'+brIdNo+'</td>'
                                    +'<td>'+deathCnt+'</td>'
                                    +'<td></td>'
                                +'</tr>';
                                tableBody.append(parsedData);
                            }
                            //Calculation part goes here
                            $('#bcgReceiptTotal').html(convertE2B(bcgReceiptTotal));
                            
                            $('#penta1ReceiptTotal').html(convertE2B(penta1ReceiptTotal));
                            $('#penta2ReceiptTotal').html(convertE2B(penta2ReceiptTotal));
                            $('#penta3MaleReceiptTotal').html(convertE2B(penta3MaleReceiptTotal));
                            $('#penta3FemaleReceiptTotal').html(convertE2B(penta3FemaleReceiptTotal));
                            $('#penta3MaleFemaleReceiptTotal').html(convertE2B(penta3MaleReceiptTotal+penta3FemaleReceiptTotal));
                            
                            $('#pcv1ReceiptTotal').html(convertE2B(pcv1ReceiptTotal));
                            $('#pcv2ReceiptTotal').html(convertE2B(pcv2ReceiptTotal));
                            $('#pcv3MaleReceiptTotal').html(convertE2B(pcv3MaleReceiptTotal));
                            $('#pcv3FemaleReceiptTotal').html(convertE2B(pcv3FemaleReceiptTotal));
                            $('#pcv3MaleFemaleReceiptTotal').html(convertE2B(pcv3MaleReceiptTotal+pcv3FemaleReceiptTotal));
                            
                            $('#opv0ReceiptTotal').html(convertE2B(opv0ReceiptTotal));
                            $('#opv1ReceiptTotal').html(convertE2B(opv1ReceiptTotal));
                            $('#opv2ReceiptTotal').html(convertE2B(opv2ReceiptTotal));
                            $('#opv3ReceiptTotal').html(convertE2B(opv3ReceiptTotal));
                            
                            $('#ipv1MaleReceiptTotal').html(convertE2B(ipv1MaleReceiptTotal));
                            $('#ipv1FemaleReceiptTotal').html(convertE2B(ipv1FemaleReceiptTotal));
                            $('#ipv1MaleFemaleReceiptTotal').html(convertE2B(ipv1MaleReceiptTotal+ipv1FemaleReceiptTotal));
                            $('#ipv2MaleReceiptTotal').html(convertE2B(ipv2MaleReceiptTotal));
                            $('#ipv2FemaleReceiptTotal').html(convertE2B(ipv2FemaleReceiptTotal));
                            $('#ipv2MaleFemaleReceiptTotal').html(convertE2B(ipv2MaleReceiptTotal+ipv2FemaleReceiptTotal));
                            
                            $('#mr1MaleReceiptTotal').html(convertE2B(mr1MaleReceiptTotal));
                            $('#mr1FemaleReceiptTotal').html(convertE2B(mr1FemaleReceiptTotal));
                            $('#mr1MaleFemaleReceiptTotal').html(convertE2B(mr1MaleReceiptTotal+mr1FemaleReceiptTotal));
                            $('#mr2MaleReceiptTotal').html(convertE2B(mr2MaleReceiptTotal));
                            $('#mr2FemaleReceiptTotal').html(convertE2B(mr2FemaleReceiptTotal));
                            $('#mr2MaleFemaleReceiptTotal').html(convertE2B(mr2MaleReceiptTotal+mr2FemaleReceiptTotal));
                            
                            $('#totalImmunizationMaleReceiptTotal').html(convertE2B(totalImmunizationMaleReceiptTotal));
                            $('#totalImmunizationFemaleReceiptTotal').html(convertE2B(totalImmunizationFemaleReceiptTotal));
                            $('#totalImmunizationMaleFemaleReceiptTotal').html(convertE2B(totalImmunizationMaleReceiptTotal+totalImmunizationFemaleReceiptTotal));
                            
                            $('#fillupCertiDateReceiptTotal').html(convertE2B(fillupCertiDateReceiptTotal));
                            $('#brIdNoReceiptTotal').html(convertE2B(brIdNoReceiptTotal));
                            $('#deathCntReceiptTotal').html(convertE2B(deathCntReceiptTotal));
                            
                               
                        }

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        btn.button('reset');
                        toastr["error"]("<h4><b>অনুরোধটি প্রক্রিয়াধীন করা যাচ্ছে না</b></h4>");
                    }
                });

            }
            

        });

    });
    function setDefault(){
        
        $('#yearName').html("..................................");
        $('#monthName').html("..................................");
        $('#districtName').html("..................................");
        
        $('#bcgReceiptTotal').html("");
                            
        $('#penta1ReceiptTotal').html("");
        $('#penta2ReceiptTotal').html("");
        $('#penta3MaleReceiptTotal').html("");
        $('#penta3FemaleReceiptTotal').html("");
        $('#penta3MaleFemaleReceiptTotal').html("");

        $('#pcv1ReceiptTotal').html("");
        $('#pcv2ReceiptTotal').html("");
        $('#pcv3MaleReceiptTotal').html("");
        $('#pcv3FemaleReceiptTotal').html("");
        $('#pcv3MaleFemaleReceiptTotal').html("");

        $('#opv0ReceiptTotal').html("");
        $('#opv1ReceiptTotal').html("");
        $('#opv2ReceiptTotal').html("");
        $('#opv3ReceiptTotal').html("");

        $('#ipv1MaleReceiptTotal').html("");
        $('#ipv1FemaleReceiptTotal').html("");
        $('#ipv1MaleFemaleReceiptTotal').html("");
        $('#ipv2MaleReceiptTotal').html("");
        $('#ipv2FemaleReceiptTotal').html("");
        $('#ipv2MaleFemaleReceiptTotal').html("");

        $('#mr1MaleReceiptTotal').html("");
        $('#mr1FemaleReceiptTotal').html("");
        $('#mr1MaleFemaleReceiptTotal').html("");
        $('#mr2MaleReceiptTotal').html("");
        $('#mr2FemaleReceiptTotal').html();
        $('#mr2MaleFemaleReceiptTotal').html("");

        $('#totalImmunizationMaleReceiptTotal').html("");
        $('#totalImmunizationFemaleReceiptTotal').html("");
        $('#totalImmunizationMaleFemaleReceiptTotal').html("");

        $('#fillupCertiDateReceiptTotal').html("");
        $('#brIdNoReceiptTotal').html("");
        $('#deathCntReceiptTotal').html("");
        
        $('#tableBody').html("");
        for (var i = 0; i < 16; i++) {
            var bodyRow='<tr>'
                            +'<td id="">&nbsp;</td>'
                            +'<td id="area"></td>'
                            +'<td id="bcg"></td>'
                            +'<td id="penta_one_boy"></td>'
                            +'<td id="penta_one_girl"></td>'
                            +'<td id="penta_two_boy"></td>'
                            +'<td id="penta_two_girl"></td>'
                            +'<td id="penta_three_boy"></td>'
                            +'<td id="penta_three_girl"></td>'
                            +'<td id="pcv_one_boy"></td>'
                            +'<td id="pcv_one_girl"></td>'
                            +'<td id="pcv_two_boy"></td>'
                            +'<td id="pcv_two_girl"></td>'
                            +'<td id="pcv_three_boy"></td>'
                            +'<td id="pcv_three_girl"></td>'
                            +'<td id="opv_zero_boy"></td>'
                            +'<td id="opv_zero_girl"></td>'
                            +'<td id="opv_one_boy"></td>'
                            +'<td id="opv_one_girl"></td>'
                            +'<td id="opv_two_boy"></td>'
                            +'<td id="opv_two_girl"></td>'
                            +'<td id="opv_three_boy"></td>'
                            +'<td id="opv_three_girl"></td>'
                            +'<td id="ipv_boy"></td>'
                            +'<td id="ipv_girl"></td>'
                            +'<td id="mr_boy"></td>'
                            +'<td id="mr_girl"></td>'
                            +'<td></td>'
                            +'<td></td>'
                            +'<td></td>'
                            +'<td></td>'
                            +'<td></td>'
                            +'<td></td>'
                            +'<td></td>'
                        +'</tr>';
            $('#tableBody').append(bodyRow);
        }
        
    }
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>EPI report (Infant)<small>ইপিআই মাসিক টিকাদানের রিপোর্ট (শিশু)</small></h1>
</section>
<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
        <%@include file="/WEB-INF/jspf/HAAreaControls_EPI_Monthly.jspf" %>
<!--    <div class="row" id="areaPanel">
      <div class="col-md-12">
        <div class="box box-primary">
          <div class="box-header with-border">
              <div class="box-tools pull-right" style="margin-top: -10px;">
              <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
              </button>
              <button type="button" class="btn btn-box-tool btn-remove" data-widget="remove"><i class="fa fa-times"></i></button>
            </div>
          </div>
           /.box-header 
          <input type="hidden" value="${userLevel}" id="userLevel">
          <div class="box-body">
            <div class="row">
                <div class="col-md-1">
                    <label for="division">বিভাগ</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="division" id="division"> 
                        <option value="">- সিল্টেক্ট করুন -</option>
                    </select>
                </div>
                
                <div class="col-md-1">
                    <label for="district">জেলা/সিটি করপোরেশন</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="district" id="district"> 
                        <option value="">- সিল্টেক্ট করুন -</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="upazila">উপজেলা/পৌরসভা/জোন</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="upazila" id="upazila">
                        <option value="">-সিল্টেক্ট করুন-</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="union">ইউনিয়ন/জোন</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="union" id="union">
                        <option value="">-সিল্টেক্ট করুন-</option>
                    </select>
                </div>
                
            </div>
            <br>
            <div class="row secondRow">
                
                <div class="col-md-1">
                    <label for="ward">ওয়ার্ড</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="ward" id="ward">
                        <option value="">-সিল্টেক্ট করুন-</option>
                    </select>
                </div>
                
                <div class="col-md-1">
                    <label for="subblock">সাব ব্লক</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="subblock" id="subblock">
                        <option value="">-সিল্টেক্ট করুন-</option>
                    </select>
                </div>
                
                <div class="col-md-1">
                    <label for="year">সন</label>
                </div>
                <div class="col-md-2">
                     <select class="form-control input-sm" name="year" id="year">
                        <option value="">-সিল্টেক্ট করুন-</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="nameOfEPICenter">টিকাদান কেন্দ্রের নাম</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="nameOfEPICenter" id="nameOfEPICenter">
                        <option value="">-সিল্টেক্ট করুন-</option>
                    </select>
                </div>
                <div class="col-md-1">
                    <label for="month">মাস</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="month" id="month">
                        <option value="1">জানুয়ারি</option>
                        <option value="2">ফেব্রুয়ারি</option>
                        <option value="3">মার্চ</option>
                        <option value="4">এপ্রিল</option>
                        <option value="5">মে</option>
                        <option value="6">জুন</option>
                        <option value="7">জুলাই</option>
                        <option value="8">অগাস্ট</option>
                        <option value="9">সেপ্টেম্বর</option>
                        <option value="10">অক্টোবর</option>
                        <option value="11">নভেম্বর</option>
                        <option value="12">ডিসেম্বর</option>
                    </select>
                </div>
                
                <div class="col-md-1">
                </div>
                <div class="col-md-2">
                   <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off">
                       <b><i class="fa fa-bar-chart" aria-hidden="true"></i>&nbsp;  ডাটা দেখান</b>
                    </button>
                </div>

            </div>
            
          </div>
        </div>
      </div>
    </div>-->
          
    
    <div class="col-ld-12">
        <div class="box box-primary">
            <div class="box-header with-border">
                <div class="box-tools pull-right" style="margin-top: -10px;">
                    <button id="printTableBtn" type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool btn-remove" data-widget="remove"><i class="fa fa-times"></i></button>
                </div>
            </div>
            <div class="box-body">
<!--                <h4 style="text-align: center;margin-top: 0px;;"><b>ইপিআই মাসিক টিকাদানের রিপোর্ট (শিশু)</b></h4>
                <h5 style="text-align: center;margin-top: 5px;">রিপোর্ট প্রদানের স্থানঃ ওয়ার্ড/ ইউনিয়ন/ উপজেলা/ পৌরসভা/ জোন/ সিটি করপোরেশন/ জেলাঃ <span id="">..................................</span>    রিপোর্টিং প্রদানের মাসঃ<span id="">..................................</span> সালঃ  <span id="timeOfBCGCombination">..................................</span>  </h5>
                -->
                <div class="table-responsive" id="printTable">
                <table class="tg" style="width: 2071px;height:200px;text-align: center;">
                        <colgroup>
                            <col style="width: 50px">
                            <col style="width: 350px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 64px">
                            <col style="width: 64px">
                            <col style="width: 64px">
                            <col style="width: 64px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                            <col style="width: 55px">
                        </colgroup>
                        <thead id="tableHeader">
                        <tr>
                            <th colspan="23" rowspan="3" class="center" style="border-left: 1px solid #fff;border-top: 1px solid #fff;">
<!--                                <b>ইপিআই মাসিক টিকাদানের রিপোর্ট (শিশু)<b>-->
                                <h4 style="margin-top: 0px;;"><b id="title">ইপিআই মাসিক টিকাদানের রিপোর্ট (শিশু)</b></h4>
                                <h5 style="text-align: center;margin-top: 5px;">রিপোর্ট প্রদানের স্থানঃ ওয়ার্ড/ ইউনিয়ন/ উপজেলা/ পৌরসভা/ জোন/ সিটি করপোরেশন/ জেলাঃ <span id="districtName">..................................</span>    রিপোর্টিং প্রদানের মাসঃ<span id="monthName">..................................</span> সালঃ  <span id="yearName">..................................</span>  </h5>
                            </th>
                            <th colspan="7" class="center">লক্ষমাত্রা</th>
                            <th colspan="2" class="center">১২ মাসের</th>
                            <th colspan="2" class="center">১ মাসের</th>
                        </tr>
                        <tr>
                            <td colspan="7">০-১১ মাস বয়সী শিশু</td>
                            <td colspan="2"></td>
                            <td colspan="2"></td>
                        </tr>
                        <tr>
                            <td colspan="7">১২-২৩ মাস বয়সী শিশু</td>
                            <td colspan="2"></td>
                            <td colspan="2"></td>
                        </tr>
                        <tr>
                            <td rowspan="4">ক্রমিক <br>নং</td>
                            <td rowspan="4">সাব-ব্লক/সাইট/ ওয়ার্ড/জোন/ ইউনিয়ন/উপজেলা/পৌরসভা</td>
                            <td colspan="19">০-১১ মাস বয়সী শিশু</td>
                            <td colspan="2">১৫-১৮ মাস বয়সী শিশু</td>
                            <td colspan="5" rowspan="3">১২-২৩ মাস বয়সী শিশু<br>(হাম/ এমআর ২য় ডোজ ব্যতিত যে সব টিকা ১২-২৩ মাস বয়সের মধ্যে নিয়েছে সেসব টিকার নাম এবং সংখ্যা খালি ঘরে লিখতে হবে)</td>
                            <td colspan="2" rowspan="3">প্রাপ্যতা অনুযায়ী সকল টিকা নেয়া শেষ হয়েছেঃ<br>(রেজিঃ বই থেকে<br>লিখতে হবে)</td>
                            <td rowspan="4">মোট কতজন শিশুর জন্ম নিবন্ধন ফর্ম পূরণ করা হয়েছে</td>
                            <td rowspan="4">মোট কতটি জন্ম নিবন্ধন<br>সার্টিফিকেট বিতরন করা হয়েছে</td>
                            <td rowspan="4">শিশু মৃত্যুর সংখ্যা <br>(প্রযোজ্য<br>ক্ষেত্রে)</td>
                            <td rowspan="4">মন্তব্য</td>
                        </tr>
                        <tr>
                            <td rowspan="2"><br>বিসিজি</td>
                            <td colspan="4">পেন্টাভ্যালেন্ট</td>
                            <td colspan="4">পিসিভি</td>
                            <td colspan="4">ওপিভি</td>
                            <td colspan="2" rowspan="2">আইপিভি ১</td>
                            <td colspan="2" rowspan="2">আইপিভি ২</td>
                            <td colspan="2" rowspan="2">এমআর টিকা (হাম রুবেলা)</td>
                            <td colspan="2" rowspan="2">হাম/ এমআর (২য় ডোজ) টিকা </td>
                        </tr>
                        <tr>
                            <td>১ম</td>
                            <td>২য়</td>
                            <td colspan="2">৩য়</td>
                            <td>১ম</td>
                            <td>২য়</td>
                            <td colspan="2">৩য়</td>
                            <td>০</td>
                            <td>১ম</td>
                            <td>২য়</td>
                            <td>৩য়</td>
                        </tr>
                        <tr>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td>ছেলে</td>
                            <td>মেয়ে</td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td>ছেলে</td>
                            <td>মেয়ে</td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td>ছেলে</td>
                            <td>মেয়ে</td>
                            <td>ছেলে</td>
                            <td>মেয়ে</td>
                            <td>ছেলে</td>
                            <td>মেয়ে</td>
                            <td>ছেলে</td>
                            <td>মেয়ে</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td colspan="1">ছেলে</td>
                            <td colspan="1">মেয়ে</td>
                        </tr>
                        </thead>
                        <tbody id="tableBody">
                        <tr>
                            <td id="">&nbsp;</td>
                            <td id="area"></td>
                            <td id="bcg"></td>
                            <td id="penta_one_boy"></td>
                            <td id="penta_one_girl"></td>
                            <td id="penta_two_boy"></td>
                            <td id="penta_two_girl"></td>
                            <td id="penta_three_boy"></td>
                            <td id="penta_three_girl"></td>
                            <td id="pcv_one_boy"></td>
                            <td id="pcv_one_girl"></td>
                            <td id="pcv_two_boy"></td>
                            <td id="pcv_two_girl"></td>
                            <td id="pcv_three_boy"></td>
                            <td id="pcv_three_girl"></td>
                            <td id="opv_zero_boy"></td>
                            <td id="opv_zero_girl"></td>
                            <td id="opv_one_boy"></td>
                            <td id="opv_one_girl"></td>
                            <td id="opv_two_boy"></td>
                            <td id="opv_two_girl"></td>
                            <td id="opv_three_boy"></td>
                            <td id="opv_three_girl"></td>
                            <td id="ipv_boy"></td>
                            <td id="ipv_girl"></td>
                            <td id="mr_boy"></td>
                            <td id="mr_girl"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        
                        <tr>
                            <td id="">&nbsp;</td>
                            <td id="area"></td>
                            <td id="bcg"></td>
                            <td id="penta_one_boy"></td>
                            <td id="penta_one_girl"></td>
                            <td id="penta_two_boy"></td>
                            <td id="penta_two_girl"></td>
                            <td id="penta_three_boy"></td>
                            <td id="penta_three_girl"></td>
                            <td id="pcv_one_boy"></td>
                            <td id="pcv_one_girl"></td>
                            <td id="pcv_two_boy"></td>
                            <td id="pcv_two_girl"></td>
                            <td id="pcv_three_boy"></td>
                            <td id="pcv_three_girl"></td>
                            <td id="opv_zero_boy"></td>
                            <td id="opv_zero_girl"></td>
                            <td id="opv_one_boy"></td>
                            <td id="opv_one_girl"></td>
                            <td id="opv_two_boy"></td>
                            <td id="opv_two_girl"></td>
                            <td id="opv_three_boy"></td>
                            <td id="opv_three_girl"></td>
                            <td id="ipv_boy"></td>
                            <td id="ipv_girl"></td>
                            <td id="mr_boy"></td>
                            <td id="mr_girl"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td id="">&nbsp;</td>
                            <td id="area"></td>
                            <td id="bcg"></td>
                            <td id="penta_one_boy"></td>
                            <td id="penta_one_girl"></td>
                            <td id="penta_two_boy"></td>
                            <td id="penta_two_girl"></td>
                            <td id="penta_three_boy"></td>
                            <td id="penta_three_girl"></td>
                            <td id="pcv_one_boy"></td>
                            <td id="pcv_one_girl"></td>
                            <td id="pcv_two_boy"></td>
                            <td id="pcv_two_girl"></td>
                            <td id="pcv_three_boy"></td>
                            <td id="pcv_three_girl"></td>
                            <td id="opv_zero_boy"></td>
                            <td id="opv_zero_girl"></td>
                            <td id="opv_one_boy"></td>
                            <td id="opv_one_girl"></td>
                            <td id="opv_two_boy"></td>
                            <td id="opv_two_girl"></td>
                            <td id="opv_three_boy"></td>
                            <td id="opv_three_girl"></td>
                            <td id="ipv_boy"></td>
                            <td id="ipv_girl"></td>
                            <td id="mr_boy"></td>
                            <td id="mr_girl"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td id="">&nbsp;</td>
                            <td id="area"></td>
                            <td id="bcg"></td>
                            <td id="penta_one_boy"></td>
                            <td id="penta_one_girl"></td>
                            <td id="penta_two_boy"></td>
                            <td id="penta_two_girl"></td>
                            <td id="penta_three_boy"></td>
                            <td id="penta_three_girl"></td>
                            <td id="pcv_one_boy"></td>
                            <td id="pcv_one_girl"></td>
                            <td id="pcv_two_boy"></td>
                            <td id="pcv_two_girl"></td>
                            <td id="pcv_three_boy"></td>
                            <td id="pcv_three_girl"></td>
                            <td id="opv_zero_boy"></td>
                            <td id="opv_zero_girl"></td>
                            <td id="opv_one_boy"></td>
                            <td id="opv_one_girl"></td>
                            <td id="opv_two_boy"></td>
                            <td id="opv_two_girl"></td>
                            <td id="opv_three_boy"></td>
                            <td id="opv_three_girl"></td>
                            <td id="ipv_boy"></td>
                            <td id="ipv_girl"></td>
                            <td id="mr_boy"></td>
                            <td id="mr_girl"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td id="">&nbsp;</td>
                            <td id="area"></td>
                            <td id="bcg"></td>
                            <td id="penta_one_boy"></td>
                            <td id="penta_one_girl"></td>
                            <td id="penta_two_boy"></td>
                            <td id="penta_two_girl"></td>
                            <td id="penta_three_boy"></td>
                            <td id="penta_three_girl"></td>
                            <td id="pcv_one_boy"></td>
                            <td id="pcv_one_girl"></td>
                            <td id="pcv_two_boy"></td>
                            <td id="pcv_two_girl"></td>
                            <td id="pcv_three_boy"></td>
                            <td id="pcv_three_girl"></td>
                            <td id="opv_zero_boy"></td>
                            <td id="opv_zero_girl"></td>
                            <td id="opv_one_boy"></td>
                            <td id="opv_one_girl"></td>
                            <td id="opv_two_boy"></td>
                            <td id="opv_two_girl"></td>
                            <td id="opv_three_boy"></td>
                            <td id="opv_three_girl"></td>
                            <td id="ipv_boy"></td>
                            <td id="ipv_girl"></td>
                            <td id="mr_boy"></td>
                            <td id="mr_girl"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td id="">&nbsp;</td>
                            <td id="area"></td>
                            <td id="bcg"></td>
                            <td id="penta_one_boy"></td>
                            <td id="penta_one_girl"></td>
                            <td id="penta_two_boy"></td>
                            <td id="penta_two_girl"></td>
                            <td id="penta_three_boy"></td>
                            <td id="penta_three_girl"></td>
                            <td id="pcv_one_boy"></td>
                            <td id="pcv_one_girl"></td>
                            <td id="pcv_two_boy"></td>
                            <td id="pcv_two_girl"></td>
                            <td id="pcv_three_boy"></td>
                            <td id="pcv_three_girl"></td>
                            <td id="opv_zero_boy"></td>
                            <td id="opv_zero_girl"></td>
                            <td id="opv_one_boy"></td>
                            <td id="opv_one_girl"></td>
                            <td id="opv_two_boy"></td>
                            <td id="opv_two_girl"></td>
                            <td id="opv_three_boy"></td>
                            <td id="opv_three_girl"></td>
                            <td id="ipv_boy"></td>
                            <td id="ipv_girl"></td>
                            <td id="mr_boy"></td>
                            <td id="mr_girl"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td id="">&nbsp;</td>
                            <td id="area"></td>
                            <td id="bcg"></td>
                            <td id="penta_one_boy"></td>
                            <td id="penta_one_girl"></td>
                            <td id="penta_two_boy"></td>
                            <td id="penta_two_girl"></td>
                            <td id="penta_three_boy"></td>
                            <td id="penta_three_girl"></td>
                            <td id="pcv_one_boy"></td>
                            <td id="pcv_one_girl"></td>
                            <td id="pcv_two_boy"></td>
                            <td id="pcv_two_girl"></td>
                            <td id="pcv_three_boy"></td>
                            <td id="pcv_three_girl"></td>
                            <td id="opv_zero_boy"></td>
                            <td id="opv_zero_girl"></td>
                            <td id="opv_one_boy"></td>
                            <td id="opv_one_girl"></td>
                            <td id="opv_two_boy"></td>
                            <td id="opv_two_girl"></td>
                            <td id="opv_three_boy"></td>
                            <td id="opv_three_girl"></td>
                            <td id="ipv_boy"></td>
                            <td id="ipv_girl"></td>
                            <td id="mr_boy"></td>
                            <td id="mr_girl"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td id="">&nbsp;</td>
                            <td id="area"></td>
                            <td id="bcg"></td>
                            <td id="penta_one_boy"></td>
                            <td id="penta_one_girl"></td>
                            <td id="penta_two_boy"></td>
                            <td id="penta_two_girl"></td>
                            <td id="penta_three_boy"></td>
                            <td id="penta_three_girl"></td>
                            <td id="pcv_one_boy"></td>
                            <td id="pcv_one_girl"></td>
                            <td id="pcv_two_boy"></td>
                            <td id="pcv_two_girl"></td>
                            <td id="pcv_three_boy"></td>
                            <td id="pcv_three_girl"></td>
                            <td id="opv_zero_boy"></td>
                            <td id="opv_zero_girl"></td>
                            <td id="opv_one_boy"></td>
                            <td id="opv_one_girl"></td>
                            <td id="opv_two_boy"></td>
                            <td id="opv_two_girl"></td>
                            <td id="opv_three_boy"></td>
                            <td id="opv_three_girl"></td>
                            <td id="ipv_boy"></td>
                            <td id="ipv_girl"></td>
                            <td id="mr_boy"></td>
                            <td id="mr_girl"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td id="">&nbsp;</td>
                            <td id="area"></td>
                            <td id="bcg"></td>
                            <td id="penta_one_boy"></td>
                            <td id="penta_one_girl"></td>
                            <td id="penta_two_boy"></td>
                            <td id="penta_two_girl"></td>
                            <td id="penta_three_boy"></td>
                            <td id="penta_three_girl"></td>
                            <td id="pcv_one_boy"></td>
                            <td id="pcv_one_girl"></td>
                            <td id="pcv_two_boy"></td>
                            <td id="pcv_two_girl"></td>
                            <td id="pcv_three_boy"></td>
                            <td id="pcv_three_girl"></td>
                            <td id="opv_zero_boy"></td>
                            <td id="opv_zero_girl"></td>
                            <td id="opv_one_boy"></td>
                            <td id="opv_one_girl"></td>
                            <td id="opv_two_boy"></td>
                            <td id="opv_two_girl"></td>
                            <td id="opv_three_boy"></td>
                            <td id="opv_three_girl"></td>
                            <td id="ipv_boy"></td>
                            <td id="ipv_girl"></td>
                            <td id="mr_boy"></td>
                            <td id="mr_girl"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td id="">&nbsp;</td>
                            <td id="area"></td>
                            <td id="bcg"></td>
                            <td id="penta_one_boy"></td>
                            <td id="penta_one_girl"></td>
                            <td id="penta_two_boy"></td>
                            <td id="penta_two_girl"></td>
                            <td id="penta_three_boy"></td>
                            <td id="penta_three_girl"></td>
                            <td id="pcv_one_boy"></td>
                            <td id="pcv_one_girl"></td>
                            <td id="pcv_two_boy"></td>
                            <td id="pcv_two_girl"></td>
                            <td id="pcv_three_boy"></td>
                            <td id="pcv_three_girl"></td>
                            <td id="opv_zero_boy"></td>
                            <td id="opv_zero_girl"></td>
                            <td id="opv_one_boy"></td>
                            <td id="opv_one_girl"></td>
                            <td id="opv_two_boy"></td>
                            <td id="opv_two_girl"></td>
                            <td id="opv_three_boy"></td>
                            <td id="opv_three_girl"></td>
                            <td id="ipv_boy"></td>
                            <td id="ipv_girl"></td>
                            <td id="mr_boy"></td>
                            <td id="mr_girl"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td id="">&nbsp;</td>
                            <td id="area"></td>
                            <td id="bcg"></td>
                            <td id="penta_one_boy"></td>
                            <td id="penta_one_girl"></td>
                            <td id="penta_two_boy"></td>
                            <td id="penta_two_girl"></td>
                            <td id="penta_three_boy"></td>
                            <td id="penta_three_girl"></td>
                            <td id="pcv_one_boy"></td>
                            <td id="pcv_one_girl"></td>
                            <td id="pcv_two_boy"></td>
                            <td id="pcv_two_girl"></td>
                            <td id="pcv_three_boy"></td>
                            <td id="pcv_three_girl"></td>
                            <td id="opv_zero_boy"></td>
                            <td id="opv_zero_girl"></td>
                            <td id="opv_one_boy"></td>
                            <td id="opv_one_girl"></td>
                            <td id="opv_two_boy"></td>
                            <td id="opv_two_girl"></td>
                            <td id="opv_three_boy"></td>
                            <td id="opv_three_girl"></td>
                            <td id="ipv_boy"></td>
                            <td id="ipv_girl"></td>
                            <td id="mr_boy"></td>
                            <td id="mr_girl"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td id="">&nbsp;</td>
                            <td id="area"></td>
                            <td id="bcg"></td>
                            <td id="penta_one_boy"></td>
                            <td id="penta_one_girl"></td>
                            <td id="penta_two_boy"></td>
                            <td id="penta_two_girl"></td>
                            <td id="penta_three_boy"></td>
                            <td id="penta_three_girl"></td>
                            <td id="pcv_one_boy"></td>
                            <td id="pcv_one_girl"></td>
                            <td id="pcv_two_boy"></td>
                            <td id="pcv_two_girl"></td>
                            <td id="pcv_three_boy"></td>
                            <td id="pcv_three_girl"></td>
                            <td id="opv_zero_boy"></td>
                            <td id="opv_zero_girl"></td>
                            <td id="opv_one_boy"></td>
                            <td id="opv_one_girl"></td>
                            <td id="opv_two_boy"></td>
                            <td id="opv_two_girl"></td>
                            <td id="opv_three_boy"></td>
                            <td id="opv_three_girl"></td>
                            <td id="ipv_boy"></td>
                            <td id="ipv_girl"></td>
                            <td id="mr_boy"></td>
                            <td id="mr_girl"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td id="">&nbsp;</td>
                            <td id="area"></td>
                            <td id="bcg"></td>
                            <td id="penta_one_boy"></td>
                            <td id="penta_one_girl"></td>
                            <td id="penta_two_boy"></td>
                            <td id="penta_two_girl"></td>
                            <td id="penta_three_boy"></td>
                            <td id="penta_three_girl"></td>
                            <td id="pcv_one_boy"></td>
                            <td id="pcv_one_girl"></td>
                            <td id="pcv_two_boy"></td>
                            <td id="pcv_two_girl"></td>
                            <td id="pcv_three_boy"></td>
                            <td id="pcv_three_girl"></td>
                            <td id="opv_zero_boy"></td>
                            <td id="opv_zero_girl"></td>
                            <td id="opv_one_boy"></td>
                            <td id="opv_one_girl"></td>
                            <td id="opv_two_boy"></td>
                            <td id="opv_two_girl"></td>
                            <td id="opv_three_boy"></td>
                            <td id="opv_three_girl"></td>
                            <td id="ipv_boy"></td>
                            <td id="ipv_girl"></td>
                            <td id="mr_boy"></td>
                            <td id="mr_girl"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td id="">&nbsp;</td>
                            <td id="area"></td>
                            <td id="bcg"></td>
                            <td id="penta_one_boy"></td>
                            <td id="penta_one_girl"></td>
                            <td id="penta_two_boy"></td>
                            <td id="penta_two_girl"></td>
                            <td id="penta_three_boy"></td>
                            <td id="penta_three_girl"></td>
                            <td id="pcv_one_boy"></td>
                            <td id="pcv_one_girl"></td>
                            <td id="pcv_two_boy"></td>
                            <td id="pcv_two_girl"></td>
                            <td id="pcv_three_boy"></td>
                            <td id="pcv_three_girl"></td>
                            <td id="opv_zero_boy"></td>
                            <td id="opv_zero_girl"></td>
                            <td id="opv_one_boy"></td>
                            <td id="opv_one_girl"></td>
                            <td id="opv_two_boy"></td>
                            <td id="opv_two_girl"></td>
                            <td id="opv_three_boy"></td>
                            <td id="opv_three_girl"></td>
                            <td id="ipv_boy"></td>
                            <td id="ipv_girl"></td>
                            <td id="mr_boy"></td>
                            <td id="mr_girl"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td id="">&nbsp;</td>
                            <td id="area"></td>
                            <td id="bcg"></td>
                            <td id="penta_one_boy"></td>
                            <td id="penta_one_girl"></td>
                            <td id="penta_two_boy"></td>
                            <td id="penta_two_girl"></td>
                            <td id="penta_three_boy"></td>
                            <td id="penta_three_girl"></td>
                            <td id="pcv_one_boy"></td>
                            <td id="pcv_one_girl"></td>
                            <td id="pcv_two_boy"></td>
                            <td id="pcv_two_girl"></td>
                            <td id="pcv_three_boy"></td>
                            <td id="pcv_three_girl"></td>
                            <td id="opv_zero_boy"></td>
                            <td id="opv_zero_girl"></td>
                            <td id="opv_one_boy"></td>
                            <td id="opv_one_girl"></td>
                            <td id="opv_two_boy"></td>
                            <td id="opv_two_girl"></td>
                            <td id="opv_three_boy"></td>
                            <td id="opv_three_girl"></td>
                            <td id="ipv_boy"></td>
                            <td id="ipv_girl"></td>
                            <td id="mr_boy"></td>
                            <td id="mr_girl"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td id="">&nbsp;</td>
                            <td id="area"></td>
                            <td id="bcg"></td>
                            <td id="penta_one_boy"></td>
                            <td id="penta_one_girl"></td>
                            <td id="penta_two_boy"></td>
                            <td id="penta_two_girl"></td>
                            <td id="penta_three_boy"></td>
                            <td id="penta_three_girl"></td>
                            <td id="pcv_one_boy"></td>
                            <td id="pcv_one_girl"></td>
                            <td id="pcv_two_boy"></td>
                            <td id="pcv_two_girl"></td>
                            <td id="pcv_three_boy"></td>
                            <td id="pcv_three_girl"></td>
                            <td id="opv_zero_boy"></td>
                            <td id="opv_zero_girl"></td>
                            <td id="opv_one_boy"></td>
                            <td id="opv_one_girl"></td>
                            <td id="opv_two_boy"></td>
                            <td id="opv_two_girl"></td>
                            <td id="opv_three_boy"></td>
                            <td id="opv_three_girl"></td>
                            <td id="ipv_boy"></td>
                            <td id="ipv_girl"></td>
                            <td id="mr_boy"></td>
                            <td id="mr_girl"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="2" class="left">ক) চলতি মাসে মোট টিকা প্রাপ্ত ছেলে ও মেয়ের সংখ্যা</td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"</td>
                            <td id="penta3MaleReceiptTotal"></td>
                            <td id="penta3FemaleReceiptTotal"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td id="pcv3MaleReceiptTotal"></td>
                            <td id="pcv3FemaleReceiptTotal"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td id="ipv1MaleReceiptTotal"></td>
                            <td id="ipv1FemaleReceiptTotal"></td>
                            <td id="ipv2MaleReceiptTotal"></td>
                            <td id="ipv2FemaleReceiptTotal"></td>
                            <td id="mr1MaleReceiptTotal"></td>
                            <td id="mr1FemaleReceiptTotal"></td>
                            <td id="mr2MaleReceiptTotal"></td>
                            <td id="mr2FemaleReceiptTotal"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td id="totalImmunizationMaleReceiptTotal"></td>
                            <td id="totalImmunizationFemaleReceiptTotal"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                        </tr>
                        <tr>
                            <td colspan="2"  class="left">খ) চলতি মাসে মোট টিকা প্রাপ্তির সংখ্যা</td>
                            <td id="bcgReceiptTotal"></td>
                            <td id="penta1ReceiptTotal"></td>
                            <td id="penta2ReceiptTotal"></td>
                            <td id="penta3MaleFemaleReceiptTotal" colspan="2"></td>
                            <td id="pcv1ReceiptTotal"></td>
                            <td id="pcv2ReceiptTotal"></td>
                            <td id="pcv3MaleFemaleReceiptTotal" colspan="2"></td>
                            <td id="opv0ReceiptTotal"></td>
                            <td id="opv1ReceiptTotal"></td>
                            <td id="opv2ReceiptTotal"></td>
                            <td id="opv3ReceiptTotal"></td>
                            <td id="ipv1MaleFemaleReceiptTotal" colspan="2"></td>
                            <td id="ipv2MaleFemaleReceiptTotal" colspan="2"></td>
                            <td id="mr1MaleFemaleReceiptTotal" colspan="2"></td>
                            <td id="mr2MaleFemaleReceiptTotal" colspan="2"></td>
                            <td id=""></td>
                            <td id=""></td>
                            <td id=""></td>
                            <td id=""></td>
                            <td id=""></td>
                            <td id="totalImmunizationMaleFemaleReceiptTotal" colspan="2"></td>
                            <td id="fillupCertiDateReceiptTotal"></td>
                            <td id="brIdNoReceiptTotal"></td>
                            <td id="deathCntReceiptTotal"></td>
                            <td id=""></td>
                        </tr>
                        <tr>
                            <td colspan="2"  class="left">গ) চলতি মাসে মোট টিকা প্রাপ্তির হার (%)</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td  class="deactive"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2"  class="left">ঘ) চলতি বছরে মোট টিকা প্রাপ্তির সংখ্যা </td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td  class="deactive"></td>
                            <td  class="deactive"></td>
                            <td  class="deactive"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2"  class="left">ঙ) চলতি বছরে মোট টিকা প্রাপ্তির হার (%)</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td class="deactive"></td>
                            <td  class="deactive"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2" rowspan="2"  class="left">মোট ব্যবহৃত ভায়ালের সংখ্যা</td>
                            <td colspan="4">বিসিজি</td>
                            <td colspan="7">পেন্টাভ্যালেন্ট</td>
                            <td colspan="6">পিসিভি</td>
                            <td colspan="4">ওপিভি</td>
                            <td colspan="5">আইপিভি</td>
                            <td colspan="3">এমআর</td>
                            <td colspan="3">হাম</td>
                        </tr>
                        <tr>
                            <td colspan="4">&nbsp;</td>
                            <td colspan="7">&nbsp;</td>
                            <td colspan="6">&nbsp;</td>
                            <td colspan="4">&nbsp;</td>
                            <td colspan="5">&nbsp;</td>
                            <td colspan="3">&nbsp;</td>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="2"  class="left">ইপিআই সেশনে খোলা ভায়ালের ভ্যাকসিন অপচয়ের হার (%)</td>
                            <td colspan="4">&nbsp;</td>
                            <td colspan="7">&nbsp;</td>
                            <td colspan="6">&nbsp;</td>
                            <td colspan="4">&nbsp;</td>
                            <td colspan="5">&nbsp;</td>
                            <td colspan="3">&nbsp;</td>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="2"  class="left">অব্যবহৃত পূর্ণ ভায়ালের অপচয়ের হার(%)</td>
                            <td colspan="4">&nbsp;</td>
                            <td colspan="7">&nbsp;</td>
                            <td colspan="6">&nbsp;</td>
                            <td colspan="4">&nbsp;</td>
                            <td colspan="5">&nbsp;</td>
                            <td colspan="3">&nbsp;</td>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="2"  class="left">মোট টিকা অপচয়ের হার (%)</td>
                            <td colspan="4">&nbsp;</td>
                            <td colspan="7">&nbsp;</td>
                            <td colspan="6">&nbsp;</td>
                            <td colspan="4">&nbsp;</td>
                            <td colspan="5">&nbsp;</td>
                            <td colspan="3">&nbsp;</td>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        </tfoot>
                    </table>
                    
                </div>
            </div>
        </div>
    </div>
 

<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
