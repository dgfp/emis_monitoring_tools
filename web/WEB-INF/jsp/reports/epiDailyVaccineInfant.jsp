<%-- 
    Document   : epiDailyVaccineChild
    Created on : Sep 19, 2017, 5:25:09 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_epi_bangla.js"></script>
<!--<script src="resources/js/mis1TabResponsive.js" type="text/javascript"></script>-->
<!--<script src="resources/js/HATabResponsive-EPI.js" type="text/javascript"></script> c-->
<style>
        .tg  {border-collapse:collapse;border-spacing:0;}
        .tg td{font-family:Arial, sans-serif;font-size:12px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:keep-all;}
        .tg th{font-family:Arial, sans-serif;font-size:12px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:keep-all;}
        .tg .tg-0e45{font-size:12px}
        .tg .tg-q19q{font-size:12px;vertical-align:top}
        .tg .tg-yw4l{vertical-align:top}
    .center{
        text-align: center;
    }
    [class*="col"] { margin-bottom: 10px; }
</style>
<script>
    $(document).ready(function () {
        
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
            frameDoc.document.write('<html><head><title>eMIS Initiative</title>');
            frameDoc.document.write('</head><body>');
            frameDoc.document.write('<style>table, th, td{border:1px solid black; border-collapse: collapse;padding:10px;}th{vertical-align: text-center} td{text-align:center;} .left{text-align:left;}</style>');
            //frameDoc.document.write('<link href="style.css" rel="stylesheet" type="text/css" />');
            frameDoc.document.write(contents);
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 500);
        });

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
                        url: "EPIDailyVaccineInfant",
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
                                $('#epiDate').html(convertE2B(convertDateFrontFormat(scheduleDate)));
    //                            $('#timeOfMRCombination').html("..");
    //                            $('#timeOfBCGCombination').html("..");

                                var tableBody = $('#tableBody');
                                tableBody.empty();

    //===============================calculation variables==========================================
                                var bcgTargetTotal=0;
                                var bcgReceivedTotal=0;
                                var bcgExternalTotal=0;

                                var penta1TargetTotal=0;
                                var penta2TargetTotal=0;
                                var penta3TargetTotal=0;
                                var penta1ReceivedTotal=0;
                                var penta2ReceivedTotal=0;
                                var penta3ReceivedTotal=0;
                                var penta1ExternalTotal=0;
                                var penta2ExternalTotal=0;
                                var penta3ExternalTotal=0;

                                var pcv1TargetTotal=0;
                                var pcv2TargetTotal=0;
                                var pcv3TargetTotal=0;
                                var pcv1ReceivedTotal=0;
                                var pcv2ReceivedTotal=0;
                                var pcv3ReceivedTotal=0;
                                var pcv1ExternalTotal=0;
                                var pcv2ExternalTotal=0;
                                var pcv3ExternalTotal=0;
                                
                                var opv0TargetTotal=0;
                                var opv1TargetTotal=0;
                                var opv2TargetTotal=0;
                                var opv3TargetTotal=0;
                                var opv0ReceivedTotal=0;
                                var opv1ReceivedTotal=0;
                                var opv2ReceivedTotal=0;
                                var opv3ReceivedTotal=0;
                                var opv0ExternalTotal=0;
                                var opv1ExternalTotal=0;
                                var opv2ExternalTotal=0;
                                var opv3ExternalTotal=0;
                                
                                var ipv1TargetTotal=0;
                                var ipv2TargetTotal=0;
                                var ipv1ReceivedTotal=0;
                                var ipv2ReceivedTotal=0;
                                var ipv1ExternalTotal=0;
                                var ipv2ExternalTotal=0;

                                var mrdate1TargetTotal=0;
                                var mrdate2TargetTotal=0;
                                var mrdate1ReceivedTotal=0;
                                var mrdate2ReceivedTotal=0;
                                var mrdate1ExternalTotal=0;
                                var mrdate2ExternalTotal=0;

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
                                    var hyphen="<span style='font-size:15px;'>-</span>";
                                    var zero="<span style='font-size:15px;'>০</span>";
                                    var emptySet="<b style='font-size:15px;'>∅</b>";

                                    //Initially value is hyphen
                                    var bcgStatus=hyphen;
                                    var penta1Status=hyphen;
                                    var penta2Status=hyphen;
                                    var penta3Status=hyphen;
                                    var pcv1Status=hyphen;
                                    var pcv2Status=hyphen;
                                    var pcv3Status=hyphen;
                                    var opv0Status=hyphen;
                                    var opv1Status=hyphen;
                                    var opv2Status=hyphen;
                                    var opv3Status=hyphen;
                                    var ipv1Status=hyphen;
                                    var ipv2Status=hyphen;
                                    var mrdate1Status=hyphen;
                                    var mrdate2Status=hyphen;


                                    if(json[i].sex==="1"){
                                        gender="ছেলে";
                                    }//gender ----------------------------------------------------------------------------------------------------------

                                    if(json[i].bcg=="1"){
                                        bcgStatus=emptySet;
                                        bcgTargetTotal++;
                                        //Check vaccine receiver internal or external 
                                        if(json[i].outsider==null || json[i].outsider==""){
                                            bcgReceivedTotal++;
                                        }else{
                                            bcgExternalTotal++;
                                        }
                                    }else if(json[i].bcg=="0"){
                                        bcgStatus=zero;
                                        bcgTargetTotal++;
                                    }//bcg ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                    if(json[i].penta1=="1"){
                                        penta1Status=emptySet;
                                        penta1TargetTotal++;
                                        //Check vaccine receiver internal or external 
                                        if(json[i].outsider==null || json[i].outsider==""){
                                            penta1ReceivedTotal++;
                                        }else{
                                            penta1ExternalTotal++;
                                        }
                                    }else if(json[i].penta1=="0"){
                                        penta1Status=zero;
                                        penta1TargetTotal++;
                                    }
                                    
                                    if(json[i].penta2=="1"){
                                        penta2Status=emptySet;
                                        penta2TargetTotal++;
                                        //Check vaccine receiver internal or external 
                                        if(json[i].outsider==null || json[i].outsider==""){
                                            penta2ReceivedTotal++;
                                        }else{
                                            penta2ExternalTotal++;
                                        }
                                    }else if(json[i].penta2=="0"){
                                        penta2Status=zero;
                                        penta2TargetTotal++;
                                    }
                                    
                                    if(json[i].penta3=="1"){
                                        penta3Status=emptySet;
                                        penta3TargetTotal++;
                                        //Check vaccine receiver internal or external 
                                        if(json[i].outsider==null || json[i].outsider==""){
                                            penta3ReceivedTotal++;
                                        }else{
                                            penta3ExternalTotal++;
                                        }

                                        if(json[i].sex==="1"){
                                            penta3TotalReceivedBoy++;
                                        }else{
                                            penta3TotalReceivedGirl++;
                                        }
                                    }else if(json[i].penta3=="0"){
                                        penta3Status=zero;
                                        penta3TargetTotal++;
                                    }//penta 1 2 3 --------------------------------------------------------------------------------------------------------------------------------------------------------------

                                    if(json[i].pcv1=="1"){
                                        pcv1Status=emptySet;
                                        pcv1TargetTotal++;
                                        //Check vaccine receiver internal or external 
                                        if(json[i].outsider==null || json[i].outsider==""){
                                            pcv1ReceivedTotal++;
                                        }else{
                                            pcv1ExternalTotal++;
                                        }
                                    }else if(json[i].pcv1=="0"){
                                        pcv1Status=zero;
                                        pcv1TargetTotal++;
                                    }
                                    //======
                                    if(json[i].pcv2=="1"){
                                        pcv2Status=emptySet;
                                        pcv2TargetTotal++;
                                        //Check vaccine receiver internal or external 
                                        if(json[i].outsider==null || json[i].outsider==""){
                                            pcv2ReceivedTotal++;
                                        }else{
                                            pcv2ExternalTotal++;
                                        }
                                    }else if(json[i].pcv2=="0"){
                                        pcv2Status=zero;
                                        pcv2TargetTotal++;
                                    }
                                    //======
                                    if(json[i].pcv3=="1"){
                                        pcv3Status=emptySet;
                                        pcv3TargetTotal++;
                                        //Check vaccine receiver internal or external 
                                        if(json[i].outsider==null || json[i].outsider==""){
                                            pcv3ReceivedTotal++;
                                        }else{
                                            pcv3ExternalTotal++;
                                        }
                                    }else if(json[i].pcv3=="0"){
                                        pcv3Status=zero;
                                        pcv3TargetTotal++;
                                    }//pcv 1 2 3 --------------------------------------------------------------------------------------------------------------------------------------------------------------

//---------------------------opv 0 1 2 3-----------------------------------------------------------------------------------------------------------------------------------------------------------
                                    if(json[i].opv0=="1"){
                                        opv0Status=emptySet;
                                        opv0TargetTotal++;
                                        //Check vaccine receiver internal or external 
                                        if(json[i].outsider==null || json[i].outsider==""){
                                            opv0ReceivedTotal++;
                                        }else{
                                            opv0ExternalTotal++;
                                        }
                                    }else if(json[i].opv0=="0"){
                                        opv0Status=zero;
                                        opv0TargetTotal++;
                                    }
                                    //======
                                    if(json[i].opv1=="1"){
                                        opv1Status=emptySet;
                                        opv1TargetTotal++;
                                        //Check vaccine receiver internal or external 
                                        if(json[i].outsider==null || json[i].outsider==""){
                                            opv1ReceivedTotal++;
                                        }else{
                                            opv1ExternalTotal++;
                                        }
                                    }else if(json[i].opv1=="0"){
                                        opv1Status=zero;
                                        opv1TargetTotal++;
                                    }
                                    //======
                                    if(json[i].opv2=="1"){
                                        opv2Status=emptySet;
                                        opv2TargetTotal++;
                                        //Check vaccine receiver internal or external 
                                        if(json[i].outsider==null || json[i].outsider==""){
                                            opv2ReceivedTotal++;
                                        }else{
                                            opv2ExternalTotal++;
                                        }
                                    }else if(json[i].opv2=="0"){
                                        opv2Status=zero;
                                        opv2TargetTotal++;
                                    }
                                    //======
                                    if(json[i].opv3=="1"){
                                        opv3Status=emptySet;
                                        opv3TargetTotal++;
                                        //Check vaccine receiver internal or external 
                                        if(json[i].outsider==null || json[i].outsider==""){
                                            opv3ReceivedTotal++;
                                        }else{
                                            opv3ExternalTotal++;
                                        }
                                    }else if(json[i].opv3=="0"){
                                        opv3Status=zero;
                                        opv3TargetTotal++;
                                    }
//---------------------------ipv 1 2 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------                                  
                                    if(json[i].ipv1=="1"){
                                        ipv1Status=emptySet;
                                        ipv1TargetTotal++;
                                        //Check vaccine receiver internal or external 
                                        if(json[i].outsider==null || json[i].outsider==""){
                                            ipv1ReceivedTotal++;
                                        }else{
                                            ipv1ExternalTotal++;
                                        }

                                        if(json[i].sex==="1"){
                                            ipvTotalReceivedBoy++;
                                        }else{
                                            ipvTotalReceivedGirl++;
                                        }
                                    }else if(json[i].ipv1=="0"){
                                        ipv1Status=zero;
                                        ipv1TargetTotal++;
                                    }
                                    
                                    if(json[i].ipv2=="1"){
                                        ipv2Status=emptySet;
                                        ipv2TargetTotal++;
                                        //Check vaccine receiver internal or external 
                                        if(json[i].outsider==null || json[i].outsider==""){
                                            ipv2ReceivedTotal++;
                                        }else{
                                            ipv2ExternalTotal++;
                                        }
                                        
                                        if(json[i].sex==="1"){
                                            ipvTotalReceivedBoy++;
                                        }else{
                                            ipvTotalReceivedGirl++;
                                        }
                                    }else if(json[i].ipv2=="0"){
                                        ipv2Status=zero;
                                        ipv2TargetTotal++;
                                    }
//---------------------------mrdate 1 2 -----------------------------------------------------------------------------------------------------------------------------------------------------------------
                                    if(json[i].mrdate1=="1"){
                                        mrdate1Status=emptySet;
                                        mrdate1TargetTotal++;
                                        //Check vaccine receiver internal or external 
                                        if(json[i].outsider==null || json[i].outsider==""){
                                            mrdate1ReceivedTotal++;
                                        }else{
                                            mrdate1ExternalTotal++;
                                        }

                                        if(json[i].sex==="1"){
                                            mrTotalReceivedBoy++;
                                        }else{
                                            mrTotalReceivedGirl++;
                                        }
                                    }else if(json[i].mrdate1=="0"){
                                        mrdate1Status=zero;
                                        mrdate1TargetTotal++;
                                    }
                                    
                                    if(json[i].mrdate2=="1"){
                                        mrdate2Status=emptySet;
                                        mrdate2TargetTotal++;
                                        //Check vaccine receiver internal or external 
                                        if(json[i].outsider==null || json[i].outsider==""){
                                            mrdate2ReceivedTotal++;
                                        }else{
                                            mrdate2ExternalTotal++;
                                        }

                                        if(json[i].sex==="1"){
                                            humTotalReceivedBoy++;
                                        }else{
                                            humTotalReceivedGirl++;
                                        }
                                    }else if(json[i].mrdate2=="0"){
                                        mrdate2Status=zero;
                                        mrdate2TargetTotal++;
                                    }
//---------------------------End------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                                   
                                    json[i].totalimmunization_="";
                                    
                                    //প্রাপ্যতা অনুযায়ী সকল টিকা নেয়া শেষ হয়েছে (হ্যা/না)
                                    var totalimmunization="না";
                                    if(json[i].totalimmunization=="15"){
                                        totalimmunization="হ্যা";
                                    }
                                    //বহিরাগত শিশু হলে লিখুন "বহিরাগত" 
                                    var outsider="বহিরাগত";
                                    if(json[i].outsider==null || json[i].outsider==""){
                                        outsider="";
                                    }
                                    //শিশুটির জন্ম নিবন্ধন ফর্ম পূরণ করা হয়েছে (হ্যা/না)
                                    var bridno="হ্যা";
                                    if(json[i].bridno==null || json[i].bridno==""){
                                        bridno="না";
                                    }
                                    //শিশুটির জন্ম নিবন্ধন সার্টিফিকেট বিতরন করা হয়েছে(হ্যা/না)
                                    var fillupcertidate="হ্যা";
                                    if(json[i].fillupcertidate==null || json[i].fillupcertidate==""){
                                        fillupcertidate="না";
                                    }
                                    
                                    var parsedData = "<tr>"
                                        +"<td class='tg-031e center'>"+  convertE2B((i+1)) +"</td>"
                                        +"<td class='tg-031e center'>"+ convertE2B(json[i].regno)+"</td>"
                                        +"<td class='tg-031e center'>"+ convertE2B(convertDateFrontFormat(json[i].regdate))+"</td>"
                                        +"<td class='tg-031e center'>"+json[i].nameeng+"</td>"
                                        +"<td class='tg-031e center'>"+gender+"</td>"
                                        +"<td class='tg-031e center'>"+convertE2B(convertDateFrontFormat(json[i].dob))+"</td>"
                                        +"<td class='tg-031e center' colspan='4'>"+json[i].fathername+"</td>"
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
                                        +"<td class='tg-031e center'>"+opv3Status+"</td>"
                                        +"<td class='tg-031e center'></td>"
                                        +"<td class='tg-031e center'>"+ipv1Status+"</td>"
                                        +"<td class='tg-031e center'>"+ipv2Status+"</td>"
                                        +"<td class='tg-031e center'>"+mrdate1Status+"</td>"
                                        +"<td class='tg-031e center'>"+mrdate2Status+"</td>"
                                        +"<td class='tg-031e center'></td>"
                                        +"<td class='tg-031e center'>"+totalimmunization+"</td>"
                                        +"<td class='tg-yw4l center'>"+ outsider +"</td>" //outsider
                                        +"<td class='tg-yw4l center'>"+ bridno +"</td>" //defult no otherwise yes if not null
                                        +"<td class='tg-yw4l center'>"+ fillupcertidate +"</td>" //defult no otherwise yes if not null
                                    +"</tr>";
                                    tableBody.append(parsedData);
                                }

    //=================================Calculation part============================================

                                //BCG pcv1ReceivedTotal
                                $('#sessionTargetBCG').html(convertE2B(bcgTargetTotal));
                                $('#sessionReceivedBCG').html(convertE2B(bcgReceivedTotal));
                                $('#sessionExceptBCG').html(convertE2B(bcgTargetTotal-bcgReceivedTotal));
                                $('#sessionExternalReceivedBCG').html(convertE2B(bcgExternalTotal));
                                $('#sessionTotalReceivedBCG').html(convertE2B(bcgReceivedTotal+bcgExternalTotal));

                                //Penta1
                                $('#sessionTargetPenta1').html(convertE2B(penta1TargetTotal));
                                $('#sessionReceivedPenta1').html(convertE2B(penta1ReceivedTotal));
                                $('#sessionExceptPenta1').html(convertE2B(penta1TargetTotal-penta1ReceivedTotal));
                                $('#sessionExternalReceivedPenta1').html(convertE2B(penta1ExternalTotal));
                                $('#sessionTotalReceivedPenta1').html(convertE2B(penta1ReceivedTotal+penta1ExternalTotal));

                                //Penta2
                                $('#sessionTargetPenta2').html(convertE2B(penta2TargetTotal));
                                $('#sessionReceivedPenta2').html(convertE2B(penta2ReceivedTotal));
                                $('#sessionExceptPenta2').html(convertE2B(penta2TargetTotal-penta2ReceivedTotal));
                                $('#sessionExternalReceivedPenta2').html(convertE2B(penta2ExternalTotal));
                                $('#sessionTotalReceivedPenta2').html(convertE2B(penta2ReceivedTotal+penta2ExternalTotal));

                                //Penta3
                                $('#sessionTargetPenta3').html(convertE2B(penta3TargetTotal));
                                $('#sessionReceivedPenta3').html(convertE2B(penta3ReceivedTotal));
                                $('#sessionExceptPenta3').html(convertE2B(penta3TargetTotal-penta3ReceivedTotal));
                                $('#sessionExternalReceivedPenta3').html(convertE2B(penta3ExternalTotal));
                                $('#sessionTotalReceivedPenta3').html(convertE2B(penta3ReceivedTotal+penta3ExternalTotal));

                                //Pcv1
                                $('#sessionTargetPcv1').html(convertE2B(pcv1TargetTotal));
                                $('#sessionReceivedPcv1').html(convertE2B(pcv1ReceivedTotal));
                                $('#sessionExceptPcv1').html(convertE2B(pcv1TargetTotal-pcv1ReceivedTotal));
                                $('#sessionExternalReceivedPcv1').html(convertE2B(pcv1ExternalTotal));
                                $('#sessionTotalReceivedPcv1').html(convertE2B(pcv1ReceivedTotal+pcv1ExternalTotal));

                                //Pcv2
                                $('#sessionTargetPcv2').html(convertE2B(pcv2TargetTotal));
                                $('#sessionReceivedPcv2').html(convertE2B(pcv2ReceivedTotal));
                                $('#sessionExceptPcv2').html(convertE2B(pcv2TargetTotal-pcv2ReceivedTotal));
                                $('#sessionExternalReceivedPcv2').html(convertE2B(pcv2ExternalTotal));
                                $('#sessionTotalReceivedPcv2').html(convertE2B(pcv2ReceivedTotal+pcv2ExternalTotal));

                                //Pcv3 opv0ReceivedTotal
                                $('#sessionTargetPcv3').html(convertE2B(pcv3TargetTotal));
                                $('#sessionReceivedPcv3').html(convertE2B(pcv3ReceivedTotal));
                                $('#sessionExceptPcv3').html(convertE2B(pcv3TargetTotal-pcv3ReceivedTotal));
                                $('#sessionExternalReceivedPcv3').html(convertE2B(pcv3ExternalTotal));
                                $('#sessionTotalReceivedPcv3').html(convertE2B(pcv3ReceivedTotal+pcv3ExternalTotal));

                                //Opv0
                                $('#sessionTargetOpv0').html(convertE2B(opv0TargetTotal));
                                $('#sessionReceivedOpv0').html(convertE2B(opv0ReceivedTotal));
                                $('#sessionExceptOpv0').html(convertE2B(opv0TargetTotal-opv0ReceivedTotal));
                                $('#sessionExternalReceivedOpv0').html(convertE2B(opv0ExternalTotal));
                                $('#sessionTotalReceivedOpv0').html(convertE2B(opv0ReceivedTotal+opv0ExternalTotal));

                                //Opv1
                                $('#sessionTargetOpv1').html(convertE2B(opv1TargetTotal));
                                $('#sessionReceivedOpv1').html(convertE2B(opv1ReceivedTotal));
                                $('#sessionExceptOpv1').html(convertE2B(opv1TargetTotal-opv1ReceivedTotal));
                                $('#sessionExternalReceivedOpv1').html(convertE2B(opv1ExternalTotal));
                                $('#sessionTotalReceivedOpv1').html(convertE2B(opv1ReceivedTotal+opv1ExternalTotal));

                                //Opv2
                                $('#sessionTargetOpv2').html(convertE2B(opv2TargetTotal));
                                $('#sessionReceivedOpv2').html(convertE2B(opv2ReceivedTotal));
                                $('#sessionExceptOpv2').html(convertE2B(opv2TargetTotal-opv2ReceivedTotal));
                                $('#sessionExternalReceivedOpv2').html(convertE2B(opv2ExternalTotal));
                                $('#sessionTotalReceivedOpv2').html(convertE2B(opv2ReceivedTotal+opv2ExternalTotal));
                                
                                //Opv3
                                $('#sessionTargetOpv3').html(convertE2B(opv3TargetTotal));
                                $('#sessionReceivedOpv3').html(convertE2B(opv3ReceivedTotal));
                                $('#sessionExceptOpv3').html(convertE2B(opv3TargetTotal-opv3ReceivedTotal));
                                $('#sessionExternalReceivedOpv3').html(convertE2B(opv3ExternalTotal));
                                $('#sessionTotalReceivedOpv3').html(convertE2B(opv3ReceivedTotal+opv3ExternalTotal));

                                //IPV1
                                $('#sessionTargetIpv1').html(convertE2B(ipv1TargetTotal));
                                $('#sessionReceivedIpv1').html(convertE2B(ipv1ReceivedTotal));
                                $('#sessionExceptIpv1').html(convertE2B(ipv1TargetTotal-ipv1ReceivedTotal));
                                $('#sessionExternalReceivedIpv1').html(convertE2B(ipv1ExternalTotal));
                                $('#sessionTotalReceivedIpv1').html(convertE2B(ipv1ReceivedTotal+ipv1ExternalTotal));
                                
                                //IPV2
                                $('#sessionTargetIpv2').html(convertE2B(ipv2TargetTotal));
                                $('#sessionReceivedIpv2').html(convertE2B(ipv2ReceivedTotal));
                                $('#sessionExceptIpv2').html(convertE2B(ipv2TargetTotal-ipv2ReceivedTotal));
                                $('#sessionExternalReceivedIpv2').html(convertE2B(ipv2ExternalTotal));
                                $('#sessionTotalReceivedIpv2').html(convertE2B(ipv2ReceivedTotal+ipv2ExternalTotal));

                                //mrdate1  
                                $('#sessionTargetMrdate1').html(convertE2B(mrdate1TargetTotal));
                                $('#sessionReceivedMrdate1').html(convertE2B(mrdate1ReceivedTotal));
                                $('#sessionExceptMrdate1').html(convertE2B(mrdate1TargetTotal-mrdate1ReceivedTotal));
                                $('#sessionExternalReceivedMrdate1').html(convertE2B(mrdate1ExternalTotal));
                                $('#sessionTotalReceivedMrdate1').html(convertE2B(mrdate1ReceivedTotal+mrdate1ExternalTotal));

                                //mrdate2
                                $('#sessionTargetMrdate2').html(convertE2B(mrdate2TargetTotal));
                                $('#sessionReceivedMrdate2').html(convertE2B(mrdate2ReceivedTotal));
                                $('#sessionExceptMrdate2').html(convertE2B(mrdate2TargetTotal-mrdate2ReceivedTotal));
                                $('#sessionExternalReceivedMrdate2').html(convertE2B(mrdate2ExternalTotal));
                                $('#sessionTotalReceivedMrdate2').html(convertE2B(mrdate2ReceivedTotal+mrdate2ExternalTotal));

                                //Boy Girl Calculation
                                $('#penta_male').html(convertE2B(penta3TotalReceivedBoy));
                                $('#penta_female').html(convertE2B(penta3TotalReceivedGirl));

                                $('#ipv_male').html(convertE2B(ipvTotalReceivedBoy));
                                $('#ipv_female').html(convertE2B(ipvTotalReceivedGirl));

                                $('#mr_male').html(convertE2B(mrTotalReceivedBoy));
                                $('#mr_female').html(convertE2B(mrTotalReceivedGirl));

                                $('#hum_male').html(convertE2B(humTotalReceivedBoy));
                                $('#hum_female').html(convertE2B(humTotalReceivedGirl));
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
                +"<td class='tg-031e' colspan='4'></td>"
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
                +"<td class='tg-031e'></td>"
                +"<td class='tg-yw4l'></td>"
                +"<td class='tg-yw4l'></td>"
                +"<td class='tg-yw4l'></td>"
            +"</tr>";
                tableBody.append(parsedData);
            }
            
            //Reset Calculation Part
            //BCG pcv1ReceivedTotal
            $('#sessionTargetBCG').html("");
            $('#sessionReceivedBCG').html("");
            $('#sessionExceptBCG').html("");
            $('#sessionExternalReceivedBCG').html("");
            $('#sessionTotalReceivedBCG').html("");

            //Penta1
            $('#sessionTargetPenta1').html("");
            $('#sessionReceivedPenta1').html("");
            $('#sessionExceptPenta1').html("");
            $('#sessionExternalReceivedPenta1').html("");
            $('#sessionTotalReceivedPenta1').html("");

            //Penta2
            $('#sessionTargetPenta2').html("");
            $('#sessionReceivedPenta2').html("");
            $('#sessionExceptPenta2').html("");
            $('#sessionExternalReceivedPenta2').html("");
            $('#sessionTotalReceivedPenta2').html("");

            //Penta3
            $('#sessionTargetPenta3').html("");
            $('#sessionReceivedPenta3').html("");
            $('#sessionExceptPenta3').html("");
            $('#sessionExternalReceivedPenta3').html("");
            $('#sessionTotalReceivedPenta3').html("");

            //Pcv1
            $('#sessionTargetPcv1').html("");
            $('#sessionReceivedPcv1').html("");
            $('#sessionExceptPcv1').html("");
            $('#sessionExternalReceivedPcv1').html("");
            $('#sessionTotalReceivedPcv1').html("");

            //Pcv2
            $('#sessionTargetPcv2').html("");
            $('#sessionReceivedPcv2').html("");
            $('#sessionExceptPcv2').html("");
            $('#sessionExternalReceivedPcv2').html("");
            $('#sessionTotalReceivedPcv2').html("");

            //Pcv3 opv0ReceivedTotal
            $('#sessionTargetPcv3').html("");
            $('#sessionReceivedPcv3').html("");
            $('#sessionExceptPcv3').html("");
            $('#sessionExternalReceivedPcv3').html("");
            $('#sessionTotalReceivedPcv3').html("");

            //Opv0
            $('#sessionTargetOpv0').html("");
            $('#sessionReceivedOpv0').html("");
            $('#sessionExceptOpv0').html("");
            $('#sessionExternalReceivedOpv0').html("");
            $('#sessionTotalReceivedOpv0').html("");

            //Opv1
            $('#sessionTargetOpv1').html("");
            $('#sessionReceivedOpv1').html("");
            $('#sessionExceptOpv1').html("");
            $('#sessionExternalReceivedOpv1').html("");
            $('#sessionTotalReceivedOpv1').html("");

            //Opv2
            $('#sessionTargetOpv2').html("");
            $('#sessionReceivedOpv2').html("");
            $('#sessionExceptOpv2').html("");
            $('#sessionExternalReceivedOpv2').html(""); 
            $('#sessionTotalReceivedOpv2').html("");
            
            //Opv3
            $('#sessionTargetOpv3').html("");
            $('#sessionReceivedOpv3').html("");
            $('#sessionExceptOpv3').html("");
            $('#sessionExternalReceivedOpv3').html("");
            $('#sessionTotalReceivedOpv3').html("");

            //IPV 
            $('#sessionTargetIpv1').html("");
            $('#sessionReceivedIpv1').html("");
            $('#sessionExceptIpv1').html("");
            $('#sessionExternalReceivedIpv1').html("");
            $('#sessionTotalReceivedIpv1').html("");
            
            $('#sessionTargetIpv2').html("");
            $('#sessionReceivedIpv2').html("");
            $('#sessionExceptIpv2').html("");
            $('#sessionExternalReceivedIpv2').html("");
            $('#sessionTotalReceivedIpv2').html("");

            //mrdate1  
            $('#sessionTargetMrdate1').html("");
            $('#sessionReceivedMrdate1').html("");
            $('#sessionExceptMrdate1').html("");
            $('#sessionExternalReceivedMrdate1').html("");
            $('#sessionTotalReceivedMrdate1').html("");

            //mrdate2
            $('#sessionTargetMrdate2').html("");
            $('#sessionReceivedMrdate2').html("");
            $('#sessionExceptMrdate2').html("");
            $('#sessionExternalReceivedMrdate2').html("");
            $('#sessionTotalReceivedMrdate2').html("");

            //Boy Girl Calculation
            $('#penta_male').html("");
            $('#penta_female').html("");

            $('#ipv_male').html("");
            $('#ipv_female').html("");

            $('#mr_male').html("");
            $('#mr_female').html("");

            $('#hum_male').html("");
            $('#hum_female').html("");
    }
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>EPI tally sheet (Infant) <small> দৈনিক টিকা ও অন্যান্য সেবা রিপোর্ট (শিশু) </small></h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <%@include file="/WEB-INF/jspf/HAAreaControls-EPI.jspf" %>
<!--    <div class="row">
      <div class="col-md-12">
        <div class="box box-primary">
          <div class="box-header with-border">
              <div class="box-tools pull-right" style="margin-top: -10px;">
              <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
              </button>
              <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
            </div>
          </div>
           /.box-header 
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
                
                <div class="col-md-1">
                    গ্রাম/মহল্লার নামঃ
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="village" id="village" disabled="">
                        <option value="">-সিল্টেক্ট করুন-</option>
                    </select>
                </div>
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
            <div class="box-body" id="printTable">
                <h4 style="text-align: center;margin-top: 0px;;"><b>দৈনিক টিকা ও অন্যান্য সেবা রিপোর্ট (শিশু)</b></h4>
                <h5 style="text-align: left;margin-top: 5px;">
                    সাব-ব্লকঃ <span id="subBlock">..................................</span>
                    টিকাদান কেন্দ্রের নামঃ <span id="epiCenterName">..................................</span>
                    গ্রাম/ মহল্লার নামঃ <span id="epiCenterName">..................................</span>
                    ওয়ার্ডঃ <span id="epiCenterName">..................................</span>
                    ইউনিয়ন/ জোনঃ <span id="epiCenterName">..................................</span>
                </h5>
                <h5 style="text-align: left;margin-top: 5px;">
                    উপজেলা/ পৌরসভা/ জোনঃ <span id="epiCenterName">.................................</span>
                    জেলা/ সিটি কর্পোরেশনঃ<span id="epiCenterName">................................</span>
                    টিকাদানের বারঃ <span id="epiDay">................................</span> 
                    বিসিজি টিকা সংমিশ্রণের সময়ঃ <span id="timeOfBCGCombination">................................</span>
                </h5>
                <h5 style="text-align: left;margin-top: 5px;">
                    
                    এমআর টিকা সংমিশ্রণের সময়ঃ <span id="timeOfMRCombination">..................................</span>  
                </h5>
                <div class="table-responsive">
                    <table class="tg" style="width: 1981px;">
                        <colgroup>
                            <col style="width: 10px!important;">
                            <col style="width: 50px">
                            <col style="width: 85px">
                            <col style="width: 150px">
                            <col style="width: 45px">
                            <col style="width: 85px">
                            <col style="width: 85px">
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
                            <col style="width: 45px">
                            <col style="width: 45px">
                            <col style="width: 45px">
                            <col style="width: 45px">
                            <col style="width: 45px">
                            <col style="width: 75px">
                            <col style="width: 75px">
                            <col style="width: 80px">
                            <col style="width: 80px">
                            <col style="width: 250px!important">
                            <col style="width: 80px">
                            <col style="width: 80px">
                            
<!--                            <col style="width: 121px">
                            <col style="width: 81px">
                            <col style="width: 90px">-->
                        </colgroup>
                        <thead id="tableHeader">
                            <tr>
                                <th class="tg-031e center" rowspan="3">ক্রমিক নং</th>
                                <th class="tg-031e center" rowspan="3">রেজিঃ নং</th>
                                <th class="tg-031e center" rowspan="3">রেজিঃ<br>তারিখ</th>
                                <th class="tg-031e center" rowspan="3">শিশুর নাম</th>
                                <th class="tg-031e center" rowspan="3">ছেলে/মেয়ে</th>
                                <th class="tg-031e center" rowspan="3">জন্ম<br>তারিখ</th>
                                <th class="tg-0e45" rowspan="3" colspan="4">মাতা/পিতা/অভিভাবকেরঃ<br>ক) নাম<br>খ) মোবাইল নম্বর<br>গ) ঠিকানা</th>
                                <th class="tg-0e45 center" rowspan="3">বিসিজি</th>
                                <th class="tg-0e45 center" colspan="11">শিশুটি কোন টিকার কোন ডোজ পাবে তা "০" চিহ্ন দিয়ে পূরণ করুন এবং টিকা দেয়ার পর "০" চিহ্নটি আড়াআড়ি &#8709; ভাবে কেটে দিন</th>
                                <th class="tg-031e" colspan="2"></th>
                                <th class="tg-031e"></th>
                                <th class="tg-031e"></th>
                                <th class="tg-0e45 center" rowspan="3">১২-২৩ মাস হলে টিক চিহ্ন দিন<br>(হামের ২য় ডোজ ব্যতিত)</th>
                                <th class="tg-0e45 center" rowspan="3">প্রাপ্যতা অনুযায়ী সকল টিকা নেয়া শেষ হয়েছে (হ্যা/না)</th>
                                <th class="tg-0e45" rowspan="3">ক) শিশুকে টিকা দেওয়া সম্ভব না হলে তার কারণ লিখুন ।<br>খ) বহিরাগত শিশু হলে <br>লিখুন "বহিরাগত"<br>গ) মন্তব্য (যদি থাকে ) লিখুন</th>
                                <th class="tg-q19q center" rowspan="3">শিশুটির জন্ম নিবন্ধন ফর্ম পূরণ করা হয়েছে (হ্যা/না)</th>
                                <th class="tg-q19q center" rowspan="3">শিশুটির জন্ম নিবন্ধন সার্টিফিকেট বিতরন করা হয়েছে<br>(হ্যা/না)</th>
                            </tr>
                            <tr>
                                <td class="tg-0e45 center" colspan="3">পেন্টাভ্যালেন্ট <br> (ডিপিটি, হেপ-বি, হিব)</td>
                                <td class="tg-0e45 center" colspan="3">পিসিভি</td>
                                <td class="tg-0e45 center" colspan="5">ওপিভি</td>
                                <td class="tg-0e45 center" colspan="2">আই পিভি<br>টিকা</td>
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
                                <td class="tg-0e45 center">১ম</td>
                                <td class="tg-0e45 center">২য়</td>
                            </tr>
                        </thead>
                        <tbody id="tableBody">
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e" colspan="4"></td>
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
                            <td class="tg-031e" colspan="4"></td>
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
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e" colspan="4"></td>
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
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e" colspan="4"></td>
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
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e" colspan="4"></td>
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
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e" colspan="4"></td>
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
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e" colspan=4"></td>
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
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e" colspan="4"></td>
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
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e" colspan="4"></td>
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
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e" colspan="4"></td>
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
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e" colspan="4"></td>
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
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e" colspan="4"></td>
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
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e" colspan="4"></td>
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
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e" colspan="4"></td>
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
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e" colspan="4"></td>
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
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e" colspan="4"></td>
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
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e" colspan="4"></td>
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
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e" colspan="4"></td>
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
                            <td class="tg-yw4l"></td>
                        </tr>
                        </tbody>
                        <tr>
                            <td class="tg-0e45" colspan="10">ক) (০) চিহ্ন যোগ করে আজকের সেশনের লক্ষমাত্রা লিখুন</td>
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
                            <td class="tg-031e center" id="sessionTargetIpv1"></td>
                            <td class="tg-031e center" id="sessionTargetIpv2"></td>
                            <td class="tg-031e center" id="sessionTargetMrdate1"></td>
                            <td class="tg-031e center" id="sessionTargetMrdate2"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-0e45 center" rowspan="2">মোট হ্যাঁ</td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                        </tr>
                        <tr>
                            <td class="tg-0e45" colspan="10">খ) (&#8709;) চিহ্ন যোগ করে আজকের সেশনের টিকা পাওয়া উদ্দিষ্ট শিশুর মোট সংখ্যা লিখুন</td>
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
                            <td class="tg-031e center" id="sessionReceivedIpv1"></td>
                            <td class="tg-031e center" id="sessionReceivedIpv2"></td>
                            <td class="tg-031e center" id="sessionReceivedMrdate1"></td>
                            <td class="tg-031e center" id="sessionReceivedMrdate2"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-031e"></td>
                        </tr>
                        <tr>
                            <td class="tg-0e45" colspan="10">গ) আজকের সেশনে বাদপড়া শিশুর (উদ্দিষ্ট) মোট সংখ্যা (ক-খ)</td>
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
                            <td class="tg-031e center" id="sessionExceptIpv1"></td>
                            <td class="tg-031e center" id="sessionExceptIpv2"></td>
                            <td class="tg-031e center" id="sessionExceptMrdate1"></td>
                            <td class="tg-031e center" id="sessionExceptMrdate2"></td>
                            <td class="tg-031e"></td>
                            <td class="tg-0e45 center" colspan="4" rowspan="2">আজকের সেশনের টিকাপ্রাপ্ত শিশুদের মধ্যে প্রাপ্যতা অনুযায়ী সকল টিকা নেওয়া শেষ হয়েছেঃ (রেজিঃ বই শেষ হয়েছে)</td>
                        </tr>
                        <tr>
                            <td class="tg-0e45" colspan="10">ঘ) (&#8709;) চিহ্ন যোগ করে আজকের সেশনের বহিরাগত টিকা পাওয়া শিশুর মোট সংখ্যা লিখুন</td>
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
                            <td class="tg-031e center" id="sessionExternalReceivedIpv1"></td>
                            <td class="tg-031e center" id="sessionExternalReceivedIpv2"></td>
                            <td class="tg-031e center" id="sessionExternalReceivedMrdate1"></td>
                            <td class="tg-031e center" id="sessionExternalReceivedMrdate2"></td>
                            <td class="tg-031e"></td>
                        </tr>
                        <tr>
                            <td class="tg-0e45" colspan="10">ঙ) (&#8709;) চিহ্ন যোগ করে আজকের সেশনের সর্বমোট টিকা পাওয়া শিশুর সংখ্যা লিখুন (খ+ঘ)</td>
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
                            <td class="tg-031e center" id="sessionTotalReceivedIpv1"></td>
                            <td class="tg-031e center" id="sessionTotalReceivedIpv2"></td>
                            <td class="tg-031e center" id="sessionTotalReceivedMrdate1"></td>
                            <td class="tg-031e center" id="sessionTotalReceivedMrdate2"></td>
                            <td class="tg-031e center" id=""></td>
                            <td class="tg-0e45 center" colspan="4"> ছেলের সংখ্যাঃ                   মেয়ের সংখ্যাঃ</td>
                        </tr>
                        <tr>
                            <td class="tg-0e45 center" colspan="4">টিকা পাওয়া ছেলে এবং মেয়ের সংখ্যা</td>
                            <td class="tg-0e45" colspan="7">পেন্টা ৩ঃ    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ছেলে - <span id="penta_male"></span>    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                মেয়ে - <span id="penta_female"></span></td>
                            
                            <td class="tg-0e45" colspan="8">আইপিভিঃ    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ছেলে - <span id="ipv_male"></span>    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                মেয়ে - <span id="ipv_female"></span></td>
                            
                            <td class="tg-q19q" colspan="7">এমআরঃ    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ছেলে - <span id="mr_male"></span>    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                মেয়ে - <span id="mr_female"></span></td>
                            
                            <td class="tg-0e45" colspan="5">হামঃ    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ছেলে - <span id="hum_male"></span>    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                মেয়ে - <span id="hum_female"></span></td>
                        </tr>
                        
                        
                        <tr>
                            <td class="tg-q19q" colspan="2" rowspan="3">প্রাপ্ত ভ্যাকসিন ভায়ালের <br>হিসাব</td>
                            <td class="tg-q19q" colspan="5">বিসিজি ও ডাইলুয়েন্ট</td>
                            <td class="" colspan="3">পেন্টা (ডিপিটি,হেপ-বি,হিব)</td>
                            <td class="tg-q19q" colspan="3">&nbsp;&nbsp;&nbsp;পিসিভি</td>
                            <td class="tg-q19q" colspan="4">&nbsp;&nbsp;&nbsp;ওপিভি</td>
                            <td class="tg-q19q" colspan="3">&nbsp;&nbsp;&nbsp;আইপিভি</td>
                            <td class="tg-q19q" colspan="7">&nbsp;&nbsp;&nbsp;এমআর টিকা ও ডাইলুয়েন্ট </td>
                            <td class="tg-q19q" colspan="4">&nbsp;&nbsp;&nbsp;হাম টিকা ও ডাইলুয়েন্ট</td>
                        </tr>
                        <tr style="text-align: center!important;">
                            <td class="">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q">ভ্যাকসিন প্রস্তুত কারকের নাম</td>
                            <td class="tg-q19q" colspan="2">ডাইলুয়েন্ট প্রস্তুতকারকের নাম</td>
                            <td class="tg-q19q">ব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q">ব্যবহৃত</td>
                            <td class="tg-q19q">অব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q">ব্যবহৃত</td>
                            <td class="tg-q19q">অব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q">পূর্ণ ব্যবহৃত</td>
                            <td class="tg-q19q">আংশিক ব্যবহৃত</td>
                            <td class="tg-q19q">অব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q">ব্যবহৃত</td>
                            <td class="tg-q19q">অব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q" colspan="3">ভ্যাকসিন প্রস্তুতকারকের নাম</td>
                            <td class="tg-q19q" colspan="2">ডাইলুয়েন্ট প্রস্তুতকারকের নাম</td>
                            <td class="tg-q19q">ব্যবহৃত</td>
                            <td class="tg-q19q">প্রাপ্ত সংখ্যা</td>
                            <td class="tg-q19q">ভ্যাকসিন প্রস্তুতকারকের নাম</td>
                            <td class="tg-q19q">ডাইলুয়েন্ট প্রস্তুতকারকের নাম</td>
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
                            <td class="tg-yw4l" colspan="3"></td>
                            <td class="tg-yw4l" colspan="2"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                            <td class="tg-yw4l"></td>
                        </tr>
                        <tr>
                            <td class="tg-q19q left" colspan="15">স্বাস্থ্য সহকারী/ টিকাদানকারীর নাম ও স্বাক্ষরঃ</td>
                            <td class="tg-q19q left" colspan="18">পঃ কঃ সহকারী/ টিকাদানকারীর নাম ও স্বাক্ষরঃ</td>
                        </tr>
                        <tr>
                            <td class="tg-q19q left" colspan="15">স্বাঃ পরিঃ/ সহ স্বাঃ পরিঃ/সহঃ পঃ পঃ পরিঃ- এর নাম, পদবী ও স্বাক্ষরঃ</td>
                            <td class="tg-q19q left" colspan="18">মন্তব্যঃ</td>
                        </tr>
                        <tr>
                            <td class="tg-q19q left" colspan="15">উপঃ স্বাঃ ও পঃ পঃ কর্মকর্তা/ সি সি / পৌরসভা কর্তৃপক্ষ/ অন্যান্য সুপারভাইজারের নাম, পদবী, মোবাইল নং ও স্বাক্ষরঃ</td>
                            <td class="tg-q19q left" colspan="18">মন্তব্যঃ</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
            <!-- End tally sheet -->
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>