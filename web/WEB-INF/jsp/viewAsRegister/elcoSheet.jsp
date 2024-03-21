<%-- 
    Document   : yearlyPopulationCountVillageWise
    Created on : Sep 14, 2017, 11:33:26 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<!--<script src="resources/js/area_dropdown_control_by_user_mis1_bangla.js"></script>-->
<script src="resources/js/area_dropdown_control_by_user_register_wise_view_elco.js"></script>
<link href="resources/css/newStyle.css" rel="stylesheet" type="text/css"/>
<style>
    table{
        font-family: SolaimanLipi;
        font-size: 11px;
    }
    .pull-right{
        text-align: right!important;
    }

    table, th, td{} .tg  {border-collapse:collapse;border-spacing:0;}
    .tg td{font-family: SolaimanLipi;font-size:11px;padding:1px 6px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
    .tf td{font-family: SolaimanLipi;font-size:11px;padding:0px!important;padding-right: 26px!important;border-width:0px;overflow:hidden;}
    .no-border{
        border: none!important;
    }

    .elcoListTable th, .elcoListTable td{
        border: 1px solid black;
        padding: -5px!important;
        padding-left: 5px!important;
    }
</style>

<script>
    //var globalJson;
    function n2d(v) {
        return (v == "undefined" || v == "null" || !v) ? '-' : v;
    }

    function e2b(v) {
        return v && convertE2B(v) || '-';
    }

    function d2d(v) {
        return v && convertDateFrontFormat2(v) || '-';
    }

    function formatVisitDate(dateString) {
        var parts = dateString && dateString.split("-") || [];
        var year = parts[0];
        var month = parts[1];
        var date = parts[2];
        return date + "/" + month + "<br>/" + year;
    }

    $(document).ready(function () {

        $('#printTableBtn').click(function () {
            $('.perPage').each(function () {
                $(this).css({
                    "page-break-after": "always"
                });
            });
            // window.print();

            var contents = $("#elco").html();
            var frame1 = $('<iframe />');
            frame1[0].name = "frame1";
            frame1.css({"position": "absolute", "top": "-1000000px"});
            $("body").append(frame1);
            var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
            frameDoc.document.open();
            frameDoc.document.write('<html><head><title>eMIS Initiative</title>');
            frameDoc.document.write('</head><body>');
            frameDoc.document.write('<style>.no-border{ border{none}}</style>');
            frameDoc.document.write('<style>table, th, td{} .tg  {border-collapse:collapse;border-spacing:0;}</style>');
            frameDoc.document.write('<style>.tg td{font-family: SolaimanLipi;font-size:12px;padding:2px 9px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}</style>');
            frameDoc.document.write('<style>.tf td{font-family: SolaimanLipi;font-size:12px;padding:0px!important;padding-right: 26px!important;border-width:0px;overflow:hidden;}</style>');
            //frameDoc.document.write('<style>table{width: 1845px;} .caption{margin-top:6px!important;}</style>');

            //frameDoc.document.write('<link href="resources/css/eligibleCoupleListPrint.css" rel="stylesheet" type="text/css" />');
            frameDoc.document.write("<h3><center>৮. দম্পতি ছক</center></h3>");
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
            setDefaultTable();
            /*$("#tableContent").fadeOut("fast");
             var epiMicroPlanTables = $('#epiMicroPlanTables').html();
             epiMicroPlanTables="";
             $('#epiMicroPlanTables').html(epiMicroPlanTables);*/

            var divisionId = $("select#division").val();
            var districtId = $("select#district").val();
            var upazilaId = $("select#upazila").val();
            var unionId = $("select#union").val();
            var unitId = $("select#unit").val();
            var year = $("select#year").val();

            if (divisionId === "") {
                toastr["error"]("<h4><b>বিভাগ সিলেক্ট করুন </b></h4>");

            } else if (districtId === "") {
                toastr["error"]("<h4><b>জেলা সিলেক্ট করুন </b></h4>");

            } else if (upazilaId === "") {
                toastr["error"]("<h4><b>উপজেলা সিলেক্ট করুন</b></h4>");

            } else if (unionId === "") {
                toastr["error"]("<h4><b>ইউনিয়ন সিলেক্ট করুন</b></h4>");

            } else if (unitId === "") {
                toastr["error"]("<h4><b>ইউনিট সিলেক্ট করুন</b></h4>");

            } else {
                var btn = $(this).button('loading');
                Pace.track(function () {
                    $.ajax({
                        url: "ElcoSheet",
                        data: {
                            divisionId: divisionId,
                            districtId: districtId,
                            upazilaId: upazilaId,
                            unionId: unionId,
                            unitId: unitId,
                            year: year
//                        divisionId: 50,
//                        districtId: 69,
//                        upazilaId: 9,
//                        unionId: 57,
//                        unitId: 2,
//                        year: 2018
                        },
                        type: 'POST',
                        success: function (result) {
                            btn.button('reset');
                            var result = JSON.parse(result) || [];
                            console.log(result);
                            if (result.status == "error") {
                                setDefaultTable();
                                toastr["error"]("<h4><b>" + result.message + "</b></h4>");
                                return;
                            }
                            var json = result.data;
                            
                            if (!(json && json.length)) {
                                $("#transparentTextForBlank").fadeIn("slow");
                                toastr["error"]("<h4><b>কোন ডাটা পাওয়া যায়নি</b></h4>");
                                return;
                            }

                            var startingIndex = 0;
                            var runner = Math.ceil(json.length / 5);
                            //var runner=Math.ceil(15/json.length);
                            var elcoMaster = "";

                            console.log("Actual:" + runner);
                            for (var j = 0; j < runner; j++) {
                                //console.log(j+"~"+runner);
                                var pageNo = j + 1;
                                var elcoPerPage = "<div class='perPage'>" + getHeader(json[startingIndex].r_vill_name);


                                // var perPage=0;
                                for (var i = startingIndex; i <= startingIndex + 4; i++) {
                                    // console.log(startingIndex+"~"+(startingIndex+4));
                                    var row = json[i] || {};
                                    if (!json[i])
                                        continue;
                                    //   perPage++; '<td rowspan="2" colspan="3">দম্পতি নং<br>'+e2b(row.r_elcono)+'</td>'+
                                    var visitDate = "", method = "";
                                    var visitData = row.r_method && row.r_method.split(";") || [];

                                    for (var m = 0; m < visitData.length; m++) {
                                        var v = visitData[m].split(",");
                                        visitDate += '<td rowspan="2">' + e2b(formatVisitDate(v[0])) + '</td>';
                                        method += '<td rowspan="2">' + v[1] + '</td>';
                                    }
                                    for (var n = 0; n < 17 - visitData.length; n++) {
                                        visitDate += '<td rowspan="2">&nbsp;&nbsp;</td>';
                                        method += '<td rowspan="2">&nbsp;&nbsp;</td>';
                                    }

                                    var elco = '<tr>' +
                                            '<td rowspan="2" colspan="3">দম্পতি নং<br>' + e2b(row.r_elcono) + '</td>' +
                                            '<td rowspan="2" colspan="2">খানা নং<br>' + e2b(row.r_hahhno) + '</td>' +
                                            '<td colspan="5" style="text-align: left">স্ত্রীঃ ' + n2d(row.r_wife_name) + '</td>' +
                                            '<td style="text-align: left">বয়সঃ ' + e2b(row.r_wife_age) + '</td>' +
                                            '<td rowspan="2">পরিদর্শনের তারিখ</td>' + visitDate + '' +
                                            '<td rowspan="2"></td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td colspan="5" style="text-align: left">স্বাঃ ' + n2d(row.r_husband_name) + '</td>' +
                                            '<td style="text-align: left">বয়সঃ ' + e2b(row.r_husband_age) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td colspan="5">মহিলার টিটি</td>' +
                                            '<td colspan="2">বিবাহের তারিখ</td>' +
                                            '<td rowspan="2">জীবিত</td>' +
                                            '<td style="text-align: left">ছেলে ' + e2b(row.r_son) + '</td>' +
                                            '<td colspan="2">মায়ের শিক্ষাগত যোগ্যতা</td>' +
                                            '<td rowspan="2">জন্ম নিয়ন্ত্রণ ব্যবস্থা <br>/গর্ভাবস্থা /অন্যান্য</td>' + n2d(method) + '' +
                                            '<td rowspan="2"></td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td>' + n2d(row.r_tt1) + '</td>' +
                                            '<td>' + n2d(row.r_tt2) + '</td>' +
                                            '<td>' + n2d(row.r_tt3) + '</td>' +
                                            '<td>' + n2d(row.r_tt4) + '</td>' +
                                            '<td>' + n2d(row.r_tt5) + '</td>' +
                                            '<td colspan="2">' + e2b(d2d(row.r_marrige_date)) + '</td>' +
                                            '<td style="text-align: left">মেয়ে ' + e2b(row.r_daughter) + '</td>' +
                                            '<td colspan="2">' + n2d(row.r_edu_name) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td rowspan="2" colspan="6" style="border-bottom:3px solid #000">জাতীয় পরিচয়পত্র নম্বর<br>' + e2b(row.r_nid) + '</td>' +
                                            '<td rowspan="2" colspan="3" style="border-bottom:3px solid #000">জন্মনিবন্ধন নম্বর<br>' + e2b(row.r_brid) + '</td>' +
                                            '<td rowspan="2" colspan="2" style="border-bottom:3px solid #000">মোবাইল নম্বর<br>' + e2b(row.r_mobileno) + '</td>' +
                                            '<td>মায়ের পুষ্টি সেবা</td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '</tr>' +
                                            '<tr style="border-bottom:3px solid #000">' +
                                            '<td colspan="">শিশুর পুষ্টি সেবা</td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '<td></td>' +
                                            '</tr>';
                                    visitDate = "", visitDate = "";
                                    elcoPerPage += elco;

//                                    if(perPage===5){
//                                        perPage=0;
//                                        startingIndex+=i;
//                                        startingIndex++;
//                                        break;
//                                    }

                                }
                                elcoPerPage += '</table><br>' + getFooter(pageNo) + '<br>';
                                elcoMaster += elcoPerPage;

                                startingIndex += 4;
                                startingIndex++;

                                elcoPerPage = "";
                            }
                            
                            $('#elco').html("");
                            $('#elco').html(elcoMaster);
                            //}
                            //console.log(json);
                            //$("#transparentTextForBlank").css("display","none");
                            //$("#tableContent").fadeIn("slow");
                            //var epiMicroPlanTables=$('#epiMicroPlanTables');
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            setDefaultTable();
                            toastr["error"]("<h4><b>Error while fetching data</b></h4>");
                        }
                    });//end ajax

                });//end pace
            } //end else

        });//end btn click


        setDefaultTable();
        function setDefaultTable() {
            $('#elco').html("");
            var defaultTable = getHeader("");
            for (var i = 0; i < 5; i++) {
                //$('#elcoRow').append();
                defaultTable+='<tr>\
                                    <td rowspan="2" colspan="3">দম্পতি নং</td>\
                                    <td rowspan="2" colspan="2">খানা নং</td>\
                                    <td colspan="5" style="text-align: left">স্ত্রীঃ</td>\
                                    <td style="text-align: left">বয়সঃ</td>\
                                    <td rowspan="2">পরিদর্শনের তারিখ</td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                </tr>\
                                <tr>\
                                    <td colspan="5" style="text-align: left">স্বাঃ</td>\
                                    <td style="text-align: left">বয়সঃ</td>\
                                </tr>\
                                <tr>\
                                    <td colspan="5">মহিলার টিটি</td>\
                                    <td colspan="2">বিবাহের তারিখ</td>\
                                    <td rowspan="2">জীবিত</td>\
                                    <td style="text-align: left">ছেলে&nbsp;&nbsp;&nbsp;</td>\
                                    <td colspan="2">মায়ের শিক্ষাগত যোগ্যতা</td>\
                                    <td rowspan="2">জন্ম নিয়ন্ত্রণ ব্যবস্থা <br>/গর্ভাবস্থা /অন্যান্য</td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                    <td rowspan="2"></td>\
                                </tr>\
                                <tr>\
                                    <td>১</td>\
                                    <td>২</td>\
                                    <td>৩</td>\
                                    <td>৪</td>\
                                    <td>৫</td>\
                                    <td colspan="2"></td>\
                                    <td style="text-align: left">মেয়ে&nbsp;&nbsp;&nbsp;</td>\
                                    <td colspan="2" style="text-align: left"></td>\
                                </tr>\
                                <tr>\
                                    <td rowspan="2" colspan="6" style="border-bottom:3px solid #000">জাতীয় পরিচয়পত্র নম্বর<br>&nbsp</td>\
                                    <td rowspan="2" colspan="3" style="border-bottom:3px solid #000">জন্মনিবন্ধন নম্বর<br>&nbsp</td>\
                                    <td rowspan="2" colspan="2" style="border-bottom:3px solid #000">মোবাইল নম্বর<br>&nbsp</td>\
                                    <td>মায়ের পুষ্টি সেবা</td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                </tr>\
                                <tr style="border-bottom:3px solid #000">\
                                    <td colspan="">শিশুর পুষ্টি সেবা</td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                    <td></td>\
                                </tr>';
            }
            defaultTable += '</table><br>' + getFooter(1) + '<br>';
            //defaultTable += getFooter("");
            $('#elco').html(defaultTable);
        }
    });

    function getHeader(village) {
        var header = '<table class="tg" style="font-family: SolaimanLipi;width: 1445px;height:200px;text-align: center;">' +
                '<colgroup>' +
                '<col style="width: 25px!important">' +
                '<col style="width: 25px!important">' +
                '<col style="width: 25px">' +
                '<col style="width: 25px">' +
                '<col style="width: 25px">' +
                '<col style="width: 35px">' +
                '<col style="width: 35px">' +
                '<col style="width: 50px">' +
                '<col style="width: 55px">' +
                '<col style="width: 50px">' +
                '<col style="width: 80px">' +
                '<col style="width: 120px">' +
                '<col style="width: 20px">' +
                '<col style="width: 20px">' +
                '<col style="width: 20px">' +
                '<col style="width: 20px">' +
                '<col style="width: 20px">' +
                '<col style="width: 20px">' +
                '<col style="width: 20px">' +
                '<col style="width: 20px">' +
                '<col style="width: 20px">' +
                '<col style="width: 20px">' +
                '<col style="width: 20px">' +
                '<col style="width: 20px">' +
                '<col style="width: 20px">' +
                '<col style="width: 20px">' +
                '<col style="width: 20px">' +
                '<col style="width: 20px">' +
                '<col style="width: 20px">' +
                '<col style="width: 20px">' +
                '</colgroup>' +
                '<tr>' +
                '<td colspan="7" style="text-align: left;"><h4><b style="font-family: SolaimanLipi;">দম্পতি ছক</b></h4></td>' +
                '<td colspan="13"></td>' +
                '<td colspan="9" style="text-align: left;"><h5><b style="font-family: SolaimanLipi;">গ্রামের নামঃ ' + village + '</b></h5></td>' +
                '<td><h5><b style="font-family: SolaimanLipi;">মন্তব্য</b></h5></td>' +
                '</tr>';

        return header;
    }
    function getFooter(index) {
        return '<table class="tf" style="border-left: 1px solid #000;border-right: 1px solid #000;border-top: 1px solid #000;border-bottom: 1px solid #000;width: 1445px;">' +
                '<tr>' +
                '<td></td>' +
                '<td>১। খাবার বড়ি <span class="pull-right">ব</span></td>' +
                '<td>৮। ইসিপি <span class="pull-right">ইপি</span></td>' +
                '<td>১৫। অপারেশন করে জরায়ু অপসারন করা <span class="pull-right">হি</span></td>' +
                '<td>২০। ভিটামিন ও মিনারেল পাউডার <span class="pull-right">পুপা</span></td>' +
                '<td>২৫। জন্মের ৬ মাস পর হতে পরিপূরক খাবার <span class="pull-right">প-৬</span></td>' +
                '</tr>' +
                '<tr>' +
                '<td></td>' +
                '<td>২। কনডম <span class="pull-right">ক</span></td>' +
                '<td>৯। মিসোপ্রোস্টোল <span class="pull-right">মিসো</span></td>' +
                '<td>১৬। স্বামী বিদেশ থাকলে <span class="pull-right">বি</span></td>' +
                '<td>২১। মায়ের দুধ ও পরিপূরক খাবার <span class="pull-right">দু</span></td>' +
                '<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;খাওয়ানো হয়েছে/ হচ্ছে</td>' +
                '</tr>' +
                '<tr>' +
                '<td class="center">জন্ম নিয়ন্ত্রণ ব্যবস্থা/</td>' +
                '<td>৩। ইনজেকটেবল <span class="pull-right">ই</span></td>' +
                '<td>১০। পার্শ্ব-প্রতিক্রিয়ার জন্য প্রেরণ <span class="pull-right">পা</span></td>' +
                '<td>১৭। বন্ধ্যাত্ব বিষয়ক তথ্য <span class="pull-right">১ম/২য়</span></td>' +
                '<td>২২। হাত ধোয়া <span class="pull-right">হা</span></td>' +
                '<td>২৬। MAM আক্রান্ত <span class="pull-right">মাম</span></td>' +
                '</tr>' +
                '<tr>' +
                '<td class="center">গর্ভাবস্থা/ পুষ্টি/ অন্যান্য</td>' +
                '<td>৪। আই ইউ ডি <span class="pull-right">টি</span></td>' +
                '<td>১১। পদ্ধতির জন্য প্রেরণ <span class="pull-right">প্রে</span></td>' +
                '<td>১৮। অন্য যে কোন অবস্থা <span class="pull-right">যে</span></td>' +
                '<td>২৩। জন্মের এক ঘন্টার মধ্যে বুকের দুধ <span class="pull-right">দু-১</span></td>' +
                '<td>২৭। SAM আক্রান্ত রেফারকৃত <span class="pull-right">সাম</span></td>' +
                '</tr>' +
                '<tr>' +
                '<td class="center">সংকেত</td>' +
                '<td>৫। ইমপ্ল্যান্ট <span class="pull-right">ইম</span></td>' +
                '<td>১২। গর্ভবতী <span class="pull-right">গ</span></td>' +
                '<td><b>পুষ্টি সেবা :</b></td>' +
                '<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;খাওয়ানো হয়েছে</td>' +
                '<td></td>' +
                '</tr>' +
                '<tr>' +
                '<td></td>' +
                '<td>৬। স্থায়ী পদ্ধতি (পুরুষ) <span class="pull-right">পু</span></td>' +
                '<td>১৩। জীবিত জন্ম <span class="pull-right">জী</span></td>' +
                '<td>১৯। আয়রণ-ফলিক এসিড বড়ি ও বাড়তি <span class="pull-right">আফ</span></td>' +
                '<td>২৪। ৬ মাস পর্যন্ত শুধু বুকের দুধ খাওয়ানো <span class="pull-right">দু-৬</span></td>' +
                '<td></td>' +
                '</tr>' +
                '<tr>' +
                '<td></td>' +
                '<td>৭। স্থায়ী পদ্ধতি (মহিলা) <span class="pull-right">ম</span></td>' +
                '<td>১৪। গর্ভ খালাস(জীবিত জন্ম ছাড়া) <span class="pull-right">খা</span></td>' +
                '<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;খাবার</td>' +
                '<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;হয়েছে/ হচ্ছে</td>' +
                '<td></td>' +
                '</tr>' +
                '<caption style="caption-side:bottom;"><br><b class="pull-right" style="color:#000" class="caption">পৃষ্ঠা নং: ' + e2b(index) + '</b></caption>' +
                '</table>' +
                '</div>';
    }

</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle">ELCO list <small>৮. দম্পতি ছক</small></h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <div class="row" id="areaPanel">
        <div class="col-md-12">
            <div class="box box-primary">
<!--                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool btn-remove" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                </div>-->
                <input type="hidden" value="${userLevel}" id="userLevel">
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <label for="division">বিভাগ</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="division" id="division"> 
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-xs-2">
                            <label for="district">জেলা</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="district" id="district"> 
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="upazila">উপজেলা</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="upazila" id="upazila">
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="union">ইউনিয়ন</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="union" id="union">
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>

                    </div>
                    <div class="row secondRow">

                        <div class="col-md-1 col-xs-2">
                            <label for="unit">ইউনিট</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="unit" id="unit">
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="year">বছর</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="year" id="year"> </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="year"></label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off">
                                <b><i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; রিপোর্ট দেখুন</b>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--------------------------------------------------------------------------------Data Table Goes Here-------------------------------------------------------------------------------->  
    <div class="box box-primary full-screen">
        <div class="box-header with-border">
            <div class="box-tools pull-right" style="margin-top: -10px;">
                <button type="button" class="btn btn-flat btn-default btn-xs bold" id="printTableBtn"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>

        <div class="box-body">
            <div  class="row">
                <div class="col-md-12"><div class="table-responsive" id="elco">
                        <table class="tg elcoListTable">
                            <tr>
                                <td colspan="7" style="text-align: left;"><h4><b style="font-family: SolaimanLipi;">দম্পতি ছক</b></h4></td>
                                <td colspan="13"></td>
                                <td colspan="9" style="text-align: left;"><h5><b style="font-family: SolaimanLipi;">গ্রামের নামঃ........................................</b></h5></td>
                                <td><h5><b style="font-family: SolaimanLipi;">মন্তব্য</b></h5></td>
                            </tr>
                            <tbody id="elcoRow">
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="30">
                                        <table class="no-border">
                                            <tr>
                                                <td></td>
                                                <td>১। খাবার বড়ি <span class="pull-right">ব</span></td>
                                                <td>৮। ইসিপি <span class="pull-right">ইপি</span></td>
                                                <td>১৫। অপারেশন করে জরায়ু অপসারন করা <span class="pull-right">হি</span></td>
                                                <td>২০। ভিটামিন ও মিনারেল পাউডার <span class="pull-right">পুপা</span></td>
                                                <td>২৫। জন্মের ৬ মাস পর হতে পরিপূরক খাবার <span class="pull-right">প-৬</span></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>২। কনডম <span class="pull-right">ক</span></td>
                                                <td>৯। মিসোপ্রোস্টোল <span class="pull-right">মিসো</span></td>
                                                <td>১৬। স্বামী বিদেশ থাকলে <span class="pull-right">বি</span></td>
                                                <td>২১। মায়ের দুধ ও পরিপূরক খাবার <span class="pull-right">দু</span></td>
                                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;খাওয়ানো হয়েছে/ হচ্ছে</td>
                                            </tr>
                                            <tr>
                                                <td class="center">জন্ম নিয়ন্ত্রণ ব্যবস্থা/</td>
                                                <td>৩। ইনজেকটেবল <span class="pull-right">ই</span></td>
                                                <td>১০। পার্শ্ব-প্রতিক্রিয়ার জন্য প্রেরণ <span class="pull-right">পা</span></td>
                                                <td>১৭। বন্ধ্যাত্ব বিষয়ক তথ্য <span class="pull-right">১ম/২য়</span></td>
                                                <td>২২। হাত ধোয়া <span class="pull-right">হা</span></td>
                                                <td>২৬। MAM আক্রান্ত <span class="pull-right">মাম</span></td>
                                            </tr>
                                            <tr>
                                                <td class="center">গর্ভাবস্থা/ পুষ্টি/ অন্যান্য</td>
                                                <td>৪। আই ইউ ডি <span class="pull-right">টি</span></td>
                                                <td>১১। পদ্ধতির জন্য প্রেরণ <span class="pull-right">প্রে</span></td>
                                                <td>১৮। অন্য যে কোন অবস্থা <span class="pull-right">যে</span></td>
                                                <td>২৩। জন্মের এক ঘন্টার মধ্যে বুকের দুধ <span class="pull-right">দু-১</span></td>
                                                <td>২৭। SAM আক্রান্ত রেফারকৃত <span class="pull-right">সাম</span></td>
                                            </tr>
                                            <tr>
                                                <td class="center">সংকেত</td>
                                                <td>৫। ইমপ্ল্যান্ট <span class="pull-right">ইম</span></td>
                                                <td>১২। গর্ভবতী <span class="pull-right">গ</span></td>
                                                <td><b>পুষ্টি সেবা :</b></td>
                                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;খাওয়ানো হয়েছে</td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>৬। স্থায়ী পদ্ধতি (পুরুষ) <span class="pull-right">পু</span></td>
                                                <td>১৩। জীবিত জন্ম <span class="pull-right">জী</span></td>
                                                <td>১৯। আয়রণ-ফলিক এসিড বড়ি ও বাড়তি <span class="pull-right">আফ</span></td>
                                                <td>২৪। ৬ মাস পর্যন্ত শুধু বুকের দুধ খাওয়ানো <span class="pull-right">দু-৬</span></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>৭। স্থায়ী পদ্ধতি (মহিলা) <span class="pull-right">ম</span></td>
                                                <td>১৪। গর্ভ খালাস(জীবিত জন্ম ছাড়া) <span class="pull-right">খা</span></td>
                                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;খাবার</td>
                                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;হয়েছে/ হচ্ছে</td>
                                                <td></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div> 
        </div>
    </div>
</div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>