<%-- 
    Document   : epi_report
    Created on : May 25, 2017, 12:20:59 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_epi_monthly_bangla.js"></script>
<%
    if(session.getAttribute("isTabAccess")!=null) {
%>
    <style>
        #areaPanel{
            margin-top: -90px!important;
        }
    </style>
<%
    }
%>
<style>
        .underDevTitle{
            display: block;
        }
        .tg  {border-collapse:collapse;border-spacing:0;}
        .tg td{font-family:Arial, sans-serif;font-size:13px;padding:3px 2px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
        .tg th{font-family:Arial, sans-serif;font-size:13px;font-weight:normal;padding:3px 2px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
        .tg .tg-0e45{font-size:12px}
        .tg .tg-q19q{font-size:12px;vertical-align:top}
        .tg .tg-yw4l{vertical-align:top}
        .center{
            text-align: center;
        }
        .left{
            text-align: left;
        }
        [class*="col"] { margin-bottom: 10px; }
        .export{
            display: none;
        }
</style>

<script>
    $(document).ready(function () {

        //Show data button click
        $('#showdataButton').click(function () {
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
                toastr["warning"]("<h4><b>দুঃখিত! রিপোর্টটি ণির্মানাধীন রয়েছে</b></h4>");
            }
        });
    });
</script>

<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>EPI report (Women)<small>ইপিআই মাসিক টিকাদানের রিপোর্ট (কিশোরী/মহিলা)</small></h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->    
    <%@include file="/WEB-INF/jspf/HAAreaControls_EPI_Monthly.jspf" %>
    
    <div class="col-ld-12">
        <div class="box box-primary">
            <div class="box-header with-border">
                <div class="box-tools pull-right" style="margin-top: -10px;">
<!--                    <button type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print</button>
                    <button type="button" class="btn btn-box-tool"><i class="fa fa-file-pdf-o" aria-hidden="true"></i>&nbsp;PDF</button>-->
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool btn-remove" data-widget="remove"><i class="fa fa-times"></i></button>
                </div>
            </div>
            <div class="box-body">
<!--                <h4 style="text-align: center;margin-top: 0px;;"><b>ইপিআই মাসিক টিকাদানের রিপোর্ট (কিশোরী/মহিলা)</b></h4>
                <h5 style="text-align: center;margin-top: 5px;">রিপোর্ট প্রদানের স্থানঃ ওয়ার্ড/ ইউনিয়ন/ উপজেলা/ পৌরসভা/ জোন/ সিটি করপোরেশন/ জেলাঃ <span id="">..................................</span>    রিপোর্টিং প্রদানের মাসঃ<span id="">..................................</span> সালঃ  <span id="timeOfBCGCombination">..................................</span>  </h5>
                -->
                <div class="table-responsive">
                    <table class="tg" style="table-layout: fixed; width: 1481px;height:50px;text-align: center" >
                        <colgroup>
                        <col style="width: 50px">
                        <col style="width: 215px">
                        <col style="width: 52px">
                        <col style="width: 52px">
                        <col style="width: 52px">
                        <col style="width: 52px">
                        <col style="width: 52px">
                        <col style="width: 52px">
                        <col style="width: 52px">
                        <col style="width: 52px">
                        <col style="width: 52px">
                        <col style="width: 52px">
                        <col style="width: 81px">
                        <col style="width: 91px">
                        <col style="width: 91px">
                        <col style="width: 71px">
                        <col style="width: 61px">
                        <col style="width: 61px">
                        <col style="width: 91px">
                        <col style="width: 81px">
                        <col style="width: 71px">
                        <col style="width: 91px">
                        </colgroup>
                          <tr>
                            <th colspan="17" rowspan="3" class="center" style="border-left: 1px solid #fff;border-top: 1px solid #fff;">
<!--                                <b>ই পি আই মাসিক টিকাদানের রিপোর্ট (কিশোরী/মহিলা)</b>-->
                                <h4 style="text-align: center;margin-top: 0px;;"><b>ইপিআই মাসিক টিকাদানের রিপোর্ট (কিশোরী/মহিলা)</b></h4>
                                <h5 style="text-align: center;margin-top: 5px;">রিপোর্ট প্রদানের স্থানঃ ওয়ার্ড/ ইউনিয়ন/ উপজেলা/ পৌরসভা/ জোন/ সিটি করপোরেশন/ জেলাঃ <span id="">..................................</span>    রিপোর্টিং প্রদানের মাসঃ<span id="">..................................</span> সালঃ  <span id="timeOfBCGCombination">..................................</span>  </h5>
                            </th>
                            <th colspan="3" class="center" >লক্ষমাত্রা</th>
                            <th class="center">১২ মাসের</th>
                            <th class="center">১ মাসের</th>
                          </tr>
                          <tr>
                            <td colspan="3">ক) গর্ভবতী মহিলা</td>
                            <td></td>
                            <td></td>
                          </tr>
                          <tr>
                            <td colspan="3">খ) ১৫-৪৯ বছর বয়সের মহিলা</td>
                            <td></td>
                            <td></td>
                          </tr>
                          <tr>
                            <td rowspan="3">ক্রমিক<br>নং</td>
                            <td rowspan="3"><br><br>সাব-ব্লক/সাইট/ওয়ার্ড/<br>জোন/ইউনিয়ন/<br>উপজেলা/পৌরসভা</td>
                            <td colspan="10">টিটি টিকা প্রদানের হিসাব</td>
                            <td rowspan="3">ভিটামিন-এ<br>(লাল-<br>প্রসবোত্তর<br>মহিলা)</td>
                            <td colspan="2">জরায়ু-মুখ ও স্তন ক্যান্সার স্ক্রিনিং (কিশোরী/মহিলাদের<br>রেজিঃ বই থেকে নিতে হবে)</td>
                            <td colspan="2" rowspan="2">সেশন</td>
                            <td colspan="4" rowspan="2">কর্মীর উপস্থিতি</td>
                            <td rowspan="3">মন্তব্য</td>
                          </tr>
                          <tr>
                            <td colspan="5">গর্ভবতী মহিলা</td>
                            <td colspan="5">অন্যান্য মহিলা</td>
                            <td rowspan="2">মোট ভায়া পরীক্ষা করা হয়েছে (সংখ্যা)</td>
                            <td rowspan="2">মোট সিবিই<br>পরীক্ষা করা হয়েছে<br>(সংখ্যা)</td>
                          </tr>
                          <tr>
                            <td>টিটি ১</td>
                            <td>টিটি ২</td>
                            <td>টিটি ৩</td>
                            <td>টিটি ৪</td>
                            <td>টিটি ৫</td>
                            <td>টিটি ১</td>
                            <td>টিটি ২</td>
                            <td>টিটি ৩</td>
                            <td>টিটি ৪</td>
                            <td>টিটি ৫</td>
                            <td>লক্ষ্যমাত্রা</td>
                            <td>অনুষ্ঠিত</td>
                            <td>এইচ এ</td>
                            <td>এফ ডব্লিউ এ</td>
                            <td>সেচ্ছাসেবী</td>
                            <td>অন্যান্য</td>
                          </tr>
                          <tr>
                            <td>১</td>
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
                          </tr>
                          <tr>
                            <td>২</td>
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
                          </tr>
                          <tr>
                            <td>৩</td>
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
                          </tr>
                          <tr>
                            <td>৪</td>
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
                          </tr>
                          <tr>
                            <td>৫</td>
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
                          </tr>
                          <tr>
                            <td>৬</td>
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
                          </tr>
                          <tr>
                            <td>৭</td>
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
                          </tr>
                          <tr>
                            <td>৮</td>
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
                          </tr>
                          <tr>
                            <td>৯</td>
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
                          </tr>
                          <tr>
                            <td>১০</td>
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
                          </tr>
                          <tr>
                            <td>১১</td>
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
                          </tr>
                          <tr>
                            <td>১২ </td>
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
                          </tr>
                          <tr>
                            <td>১৩</td>
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
                          </tr>
                          <tr>
                            <td>১৪</td>
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
                          </tr>
                          <tr>
                            <td>১৫</td>
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
                          </tr>
                          <tr>
                            <td>১৬</td>
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
                          </tr>
                          <tr>
                            <td>১৭</td>
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
                          </tr>
                          <tr>
                            <td>১৮</td>
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
                          </tr>
                          <tr>
                            <td>১৯</td>
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
                          </tr>
                          <tr>
                              <td colspan="2" class="left">ক) চলতি মাসে মোট টিকা প্রাপ্তির সংখ্যা</td>
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
                          </tr>
                          <tr>
                              <td colspan="2" class="left">খ) চলতি মাসে মোট টিকা প্রাপ্তির হার (%)</td>
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
                          </tr>
                          <tr>
                            <td colspan="2" class="left">গ) চলতি বছরে মোট টিকা প্রাপ্তির সংখ্যা</td>
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
                          </tr>
                          <tr>
                            <td colspan="2" class="left">ঘ) চলতি বছরে মোট টিকা প্রাপ্তির হার (%)</td>
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
                          </tr>
                          <tr>
                              <td colspan="2" class="left">মোট ব্যবহৃত ভায়ালের সংখ্যা</td>
                            <td colspan="2" rowspan="4"><br>টিটি</td>
                            <td colspan="6"></td>
                            <td colspan="2" rowspan="4">ভিটামিন-এ (লাল)</td>
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
                          </tr>
                          <tr>
                              <td colspan="2" class="left">ইপিআই সেশনে খোলা ভায়ালের ভ্যাকসিন অপচয়ের হার (%)</td>
                            <td colspan="6"></td>
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
                          </tr>
                          <tr>
                            <td colspan="2" class="left">অব্যবহৃত পূর্ণ ভায়ালের অপচয়ের হার (%)</td>
                            <td colspan="6"></td>
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
                          </tr>
                          <tr>
                            <td colspan="2" class="left">মোট টিকা অপচয়ের হার (%)</td>
                            <td colspan="6"></td>
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
                          </tr>
                    </table>
                </div>
        </div>
    </div>
</div>
</section>












<!--<div id="page-wrapper">
   
   ------------------------------------------------------------------------------Alert message------------------------------------------------------------------------------
   <div class="alertMsg" id="alert">
   </div>
        
    <div class="row">
        <div class="col-lg-12">
            <h3><b><center>ইপিআই মাসিক টিকাদানের রিপোর্ট (কিশোরী/মহিলা)</center></b></h3>
        </div>
    </div>
    
    ------------------------------------------------------------------------form controllers-------------------------------------------------------------------------------------
        <div class="well well-sm">
            
            <div class="row">
                <div class="col-md-1">
                    <label for="district">জেলা</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="district" id="district"> </select>
                </div>

                <div class="col-md-1">
                    <label for="upazila">উপজেলা</label>
                </div>

                <div class="col-md-2">
                    <select class="form-control input-sm" name="upazila" id="upazila">
                        <option value="">-সিল্টেক্ট করুন-</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="union">ইউনিয়ন</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="union" id="union">
                        <option value="">-সিল্টেক্ট করুন-</option>
                    </select>
                </div>
                
                  <div class="col-md-1">
                    <label for="union">ওয়ার্ড </label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="union" id="ward">
                        <option value="">সবগুলো</option>
                    </select>
                </div>
            </div><br>
            
            <div class="row">
                <div class="col-md-1">
                    <label for="month">শুরুর তারিখমাস</label>
                </div>
                <div class="col-md-2">
                    <input type="text" class="input form-control input-sm datepicker" placeholder="dd/mm/yyyy" name="startDate" id="startDate"/>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="month" id="month">
                        <option value="1">জানুয়ারী</option>
                        <option value="2">ফেব্রুয়ারি</option>
                        <option value="3">মার্চ </option>
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
                    <label for="year">শেষের তারিখসন</label>
                </div>
                <div class="col-md-2">
                    <input type="text" class="input form-control input-sm datepicker" placeholder="dd/mm/yyyy" name="endDate" id="endDate"/>
                </div>

                <div class="col-md-2">
                    <select class="form-control input-sm" name="year" id="year"> </select>
                </div>
                
                 <div class="col-md-2 col-md-offset-1">
                                <div class="col-md-2 col-md-offset-1">
                    <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-sm btn-info btn-block" autocomplete="off">
                        <i class="fa fa-database" aria-hidden="true"></i> <b>ডাটা দেখান</b>
                    </button>
                </div>
            </div>
        </div>
        
    
    
     --------------------------------------------------------------------------------Table goes here------------------------------------------------------------------
    <div class="container-fluid">
        <div class="table-responsive">
            <table style="width: 100%" class="daily_service_table">
                <colgroup>
                <col style="width: 61px">
                <col style="width: 141px">
                <col style="width: 51px">
                <col style="width: 51px">
                <col style="width: 51px">
                <col style="width: 51px">
                <col style="width: 51px">
                <col style="width: 51px">
                <col style="width: 51px">
                <col style="width: 51px">
                <col style="width: 51px">
                <col style="width: 51px">
                <col style="width: 81px">
                <col style="width: 91px">
                <col style="width: 91px">
                <col style="width: 71px">
                <col style="width: 61px">
                <col style="width: 61px">
                <col style="width: 91px">
                <col style="width: 81px">
                <col style="width: 71px">
                <col style="width: 91px">
                </colgroup>
                  <tr>
                    <th colspan="17" rowspan="3">ইপিআই<br>মাসিক টিকাদানের রিপোর্ট (কিশোরী/মহিলা)</th>
                    <th colspan="3">লক্ষমাত্রা</th>
                    <th>১২ মাসের</th>
                    <th>১ মাসের</th>
                  </tr>
                  <tr>
                    <td colspan="3">ক) গর্ভবতী মহিলা</td>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td colspan="3">খ) ১৫-৪৯ বছর বয়সের মহিলা</td>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td rowspan="3">ক্রমিক<br>নং</td>
                    <td rowspan="3"><br><br><br>সাব-ব্লক/সাইট/ওয়ার্ড/<br>জোন/ইউনিয়ন/<br>উপজেলা/পৌরসভা</td>
                    <td colspan="10">টিটি টিকা প্রদানের হিসাব</td>
                    <td rowspan="3">ভিটামিন-এ<br>(লাল-<br>প্রসবোত্তর<br>মহিলা)</td>
                    <td colspan="2">জরায়ু-মুখ ও স্তন ক্যান্সার স্ক্রিনিং (কিশোরী/মহিলাদের<br>রেজিঃ বই থেকে নিতে হবে)</td>
                    <td colspan="2" rowspan="2">সেশন</td>
                    <td colspan="4" rowspan="2">কর্মীর উপস্থিতি</td>
                    <td rowspan="3">মন্তব্য</td>
                  </tr>
                  <tr>
                    <td colspan="5">গর্ভবতী মহিলা</td>
                    <td colspan="5">অন্যান্য মহিলা</td>
                    <td rowspan="2">মোট ভায়া পরীক্ষা করা হয়েছে (সংখ্যা)</td>
                    <td rowspan="2">মোট সিবিই<br>পরীক্ষা করা হয়েছে<br>(সংখ্যা)</td>
                  </tr>
                  <tr>
                    <td>টিটি১</td>
                    <td>টিটি২</td>
                    <td>টিটি৩</td>
                    <td>টিটি৪</td>
                    <td>টিটি৫</td>
                    <td>টিটি১</td>
                    <td>টিটি২</td>
                    <td>টিটি৩</td>
                    <td>টিটি৪</td>
                    <td>টিটি৫</td>
                    <td>লক্ষ্যমাত্রা</td>
                    <td>অনুষ্ঠিত</td>
                    <td>এইচ এ</td>
                    <td>এফ ডব্লিউ এ</td>
                    <td>সেচ্ছাসেবী</td>
                    <td>অন্যান্য</td>
                  </tr>
                  <tr>
                    <td>১</td>
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
                  </tr>
                  <tr>
                    <td>২</td>
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
                  </tr>
                  <tr>
                    <td>৩</td>
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
                  </tr>
                  <tr>
                    <td>৪</td>
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
                  </tr>
                  <tr>
                    <td>৫</td>
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
                  </tr>
                  <tr>
                    <td>৬</td>
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
                  </tr>
                  <tr>
                    <td>৭</td>
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
                  </tr>
                  <tr>
                    <td>৮</td>
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
                  </tr>
                  <tr>
                    <td>৯</td>
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
                  </tr>
                  <tr>
                    <td>১০</td>
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
                  </tr>
                  <tr>
                    <td>১১</td>
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
                  </tr>
                  <tr>
                    <td>১২ </td>
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
                  </tr>
                  <tr>
                    <td>১৩</td>
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
                  </tr>
                  <tr>
                    <td>১৪</td>
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
                  </tr>
                  <tr>
                    <td>১৫</td>
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
                  </tr>
                  <tr>
                    <td>১৬</td>
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
                  </tr>
                  <tr>
                    <td>১৭</td>
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
                  </tr>
                  <tr>
                    <td>১৮</td>
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
                  </tr>
                  <tr>
                    <td>১৯</td>
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
                  </tr>
                  <tr>
                    <td colspan="2">ক) চলতি মাসে মোট টিকা প্রাপ্তির সংখ্যা</td>
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
                  </tr>
                  <tr>
                    <td colspan="2">খ) চলতি মাসে মোট টিকা প্রাপ্তির হার (%)</td>
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
                  </tr>
                  <tr>
                    <td colspan="2">গ) চলতি মাসে মোট টিকা প্রাপ্তির সংখ্যা</td>
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
                  </tr>
                  <tr>
                    <td colspan="2">ঘ) চলতি মাসে মোট টিকা প্রাপ্তির হার (%)</td>
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
                  </tr>
                  <tr>
                    <td colspan="2">মোট ভায়ালের সংখ্যা</td>
                    <td colspan="2" rowspan="4"><br><br><br><br><br>টিটি</td>
                    <td colspan="6"></td>
                    <td colspan="2" rowspan="4">ভিটামিন-এ (লাল)</td>
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
                  </tr>
                  <tr>
                    <td colspan="2">ইপিআই সেশনে খোলা ভায়ালের ভ্যাকসিন অপচয়ের হার</td>
                    <td colspan="6"></td>
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
                  </tr>
                  <tr>
                    <td colspan="2">অব্যবহৃত পূর্ণ ভায়ালের অপচয়ের হার (%)</td>
                    <td colspan="6"></td>
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
                  </tr>
                  <tr>
                    <td colspan="2">মোট টিকা অপচয়ের হার (%)</td>
                    <td colspan="6"></td>
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
                  </tr>
            </table>
        </div>
    </div>
</div>-->

<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
