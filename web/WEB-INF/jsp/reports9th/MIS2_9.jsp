<%-- 
    Document   : DeathList
    Created on : Mar 25, 2018, 6:50:25 AM
    Author     : RHIS082
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<!--<script src="resources/js/area_dropdown_control_by_user_register_wise_view.js"></script>-->
<link href="resources/css/registerWiseView.css" rel="stylesheet" type="text/css"/>
<style>
    .tableTitle{
        font-family: SolaimanLipi;
        display: none;
    }
/*    table{
        font-family: SolaimanLipi;
        font-size: 12px;
    }*/
    #name{
        font-size: 11px;
    }

    @media print {
        .tableTitle{
            display: block;
            margin-top: -2px;
        }
        .reg-fwa-13{
            margin-top: -30px!important;
        }
        /*        @page {
                    size: A4 landscape;
                    margin: 10px;
                }*/
        .box{ border: 0}
        #areaPanel, #back-to-top, .box-header, .main-footer{
            display: none !important;
        }
    }
    .middle {
        height: 90px!important;
        line-height: 90px!important;
        text-align: center!important;
    }
    #logo{
        margin-top: 10px;
        margin-left: 5px;
        width:50px;
        height:50px;
    }
</style>
<script>
</script>
<section class="content-header">
    <h1 id="pageTitle">MIS 1 and CSBA report</h1>
</section>
<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <%@include file="/WEB-INF/jspf/registerViewBangla.jspf" %>
    <!--------------------------------------------------------------------------------Data Table Goes Here-------------------------------------------------------------------------------->  
    <div class="box box-primary full-screen">
        <div class="box-header with-border">
            <div class="box-tools pull-right" style="margin-top: -10px;">
                <button type="button" class="btn btn-flat btn-default btn-xs bold" onclick="window.print();"><i class="fa fa-print" aria-hidden="true"></i>Print / PDF</button>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>

        <div class="box-body">
            <div  class="row">
                <div class="col-md-12">

                    <div class="table-responsive">
                        <h3 class="tableTitle"><center>১৩. মৃত্যু তালিকা ছক</center></h3>
                        <div class="reg-fwa-13_ table-data">
                            <div class="table-responsive">
                                <table  style="text-align: left; width: 100%;border: 0!important;" id="topHeader" id="topHeader">
                                    <tr>
                                        <th style="vertical-align: text-top;border:none!important;" colspan="2">
                                            <p id="slogan">ছেলে হোক, মেয়ে হোক,<br>দু’টি সন্তানই যথেষ্ট</p>
                                        </th>
                                        <th style="text-align:center;vertical-align: text-top;border:none!important;" colspan="2">
                                            <p>গনপ্রজাতন্ত্রী বাংলাদেশ সরকার
                                            <br>পরিবার পরিকল্পনা অধিদপ্তর
                                            <br>পরিবার পরিকল্পনা, মা ও শিশু স্বাস্থ্য কার্যক্রমের মাসিক অগ্রগতির প্রতিবেদন</p>
                                        </th>
                                        <th style="text-align:right;vertical-align: text-top;border:none!important;" colspan="2">
                                            <p>এম আই এস ফরম - ২<br>পৃষ্ঠা-১</p>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th style="border:none!important;" colspan="2">
                                            <img id="logo" src="resources/logo/Fpi_logo.png" class="pull-left"  alt=""/>
                                        </th>
                                        <th style="border:none!important;" colspan="2">
                                            মাসঃ<span id="monthyear"> ..........................</span>     &nbsp;&nbsp;&nbsp;&nbsp;ইউনিয়নঃ<span id="unionValue"> ..........................</span>     &nbsp;&nbsp;&nbsp;&nbsp;উপজেলা/থানাঃ<span id="upazilaValue"> ..........................</span>     &nbsp;&nbsp;&nbsp;&nbsp;জেলাঃ<span id="districtValue"> ..........................</span>   
                                        </th>
                                        <th style="text-align:right;vertical-align: text-top;border:none!important;" colspan="2">
                                        </th>
                                    </tr>
                                </table>
                                <table width="99%" style="text-align: left">
                                    <tbody>
                                        <tr>
                                            <td rowspan="5" class="v-b">
                                                <span class="r-v">&nbsp;&nbsp;&nbsp;ইউনিট নম্বর</span>
                                            </td>
                                            <td rowspan="5" class="v-b">
                                                <span class="r-v">&nbsp;&nbsp;&nbsp;ইউনিটের মোট সক্ষম দম্পতির সংখ্যা</span>
                                            </td>
                                            <td colspan="36" >
                                                <p class="center">পরিবার পরিকল্পনা পদ্ধতি গ্রহণকারী</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="12" >
                                                <p class="center">খাবার বড়ি</p>
                                            </td>
                                            <td colspan="12" >
                                                <p class="center">কনডম</p>
                                            </td>
                                            <td colspan="12" width="28%">
                                                <p class="center">ইনজেকটেবল</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <p class="center">স্বাভাবিক</p>
                                            </td>
                                            <td colspan="6" width="15%">
                                                <p class="center">প্রসব পরবর্তী</p>
                                            </td>
                                            <td rowspan="3" class="v-b">
                                                <p class="r-v">সর্বমোট খাবার বড়ি</p>
                                            </td>
                                            <td colspan="5">
                                                <p class="center">স্বাভাবিক</p>
                                            </td>
                                            <td colspan="6">
                                                <p class="center">প্রসব পরবর্তী</p>
                                            </td>
                                            <td rowspan="3" class="v-b">
                                                <p class="r-v">সর্বমোট কনডম</p>
                                            </td>
                                            <td colspan="5">
                                                <p class="center">স্বাভাবিক</p>
                                            </td>
                                            <td colspan="6" >
                                                <p class="center">প্রসব পরবর্তী</p>
                                            </td>
                                            <td rowspan="3" class="v-b">
                                                <p class="r-v">সর্বমোট ইনজেকটেবল</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">পুরাতন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">নতুন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">মোট</p>
                                            </td>
                                            <td colspan="2">
                                                <p class="center">ছেড়ে দিয়েছে</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">পুরাতন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">নতুন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">মোট</p>
                                            </td>
                                            <td colspan="3" >
                                                <p class="center">ছেড়ে দিয়েছে</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">পুরাতন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">নতুন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">মোট</p>
                                            </td>
                                            <td colspan="2">
                                                <p class="center">ছেড়ে দিয়েছে</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">পুরাতন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">নতুন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">মোট</p>
                                            </td>
                                            <td colspan="3" >
                                                <p class="center">ছেড়ে দিয়েছে</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">পুরাতন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">নতুন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">মোট</p>
                                            </td>
                                            <td colspan="2">
                                                <p class="center">ছেড়ে দিয়েছে</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">পুরাতন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">নতুন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">মোট</p>
                                            </td>
                                            <td colspan="3" >
                                                <p class="center">ছেড়ে দিয়েছে</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="v-b">
                                                <p class="r-v">কোন পদ্ধতি নেয়নি</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">অন্য পদ্ধতি নিয়েছে</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">কোন পদ্ধতি নেয়নি</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">অন্য পদ্ধতি নিয়েছে</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">প্রসব পরবর্তী মেয়াদ উত্তীর্ণ</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">কোন পদ্ধতি নেয়নি</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">অন্য পদ্ধতি নিয়েছে</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">কোন পদ্ধতি নেয়নি</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">অন্য পদ্ধতি নিয়েছে</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">প্রসব পরবর্তী মেয়াদ উত্তীর্ণ</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">কোন পদ্ধতি নেয়নি</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">অন্য পদ্ধতি নিয়েছে</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">কোন পদ্ধতি নেয়নি</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">অন্য পদ্ধতি নিয়েছে</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">প্রসব পরবর্তী মেয়াদ উত্তীর্ণ</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <p>১</p>
                                            </td>
                                            <td>
                                                <p>২</p>
                                            </td>
                                            <td >
                                                <p>৩</p>
                                            </td>
                                            <td >
                                                <p>৪</p>
                                            </td>
                                            <td>
                                                <p>৫</p>
                                            </td>
                                            <td >
                                                <p>৬</p>
                                            </td>
                                            <td >
                                                <p>৭</p>
                                            </td>
                                            <td>
                                                <p>৮</p>
                                            </td>
                                            <td >
                                                <p>৯</p>
                                            </td>
                                            <td>
                                                <p>১০</p>
                                            </td>
                                            <td >
                                                <p>১১</p>
                                            </td>
                                            <td >
                                                <p>১২</p>
                                            </td>
                                            <td >
                                                <p>১৩</p>
                                            </td>
                                            <td>
                                                <p>১৪</p>
                                            </td>
                                            <td>
                                                <p>১৫</p>
                                            </td>
                                            <td >
                                                <p>১৬</p>
                                            </td>
                                            <td>
                                                <p>১৭</p>
                                            </td>
                                            <td >
                                                <p>১৮</p>
                                            </td>
                                            <td >
                                                <p>১৯</p>
                                            </td>
                                            <td>
                                                <p>২০</p>
                                            </td>
                                            <td >
                                                <p>২১</p>
                                            </td>
                                            <td>
                                                <p>২২</p>
                                            </td>
                                            <td >
                                                <p>২৩</p>
                                            </td>
                                            <td>
                                                <p>২৪</p>
                                            </td>
                                            <td>
                                                <p>২৫</p>
                                            </td>
                                            <td >
                                                <p>২৬</p>
                                            </td>
                                            <td >
                                                <p>২৭</p>
                                            </td>
                                            <td >
                                                <p>২৮</p>
                                            </td>
                                            <td >
                                                <p>২৯</p>
                                            </td>
                                            <td >
                                                <p>৩০</p>
                                            </td>
                                            <td >
                                                <p>৩১</p>
                                            </td>
                                            <td >
                                                <p>৩২</p>
                                            </td>
                                            <td >
                                                <p>৩৩</p>
                                            </td>
                                            <td >
                                                <p>৩৪</p>
                                            </td>
                                            <td >
                                                <p>৩৫</p>
                                            </td>
                                            <td>
                                                <p>৩৬</p>
                                            </td>
                                            <td >
                                                <p>৩৭</p>
                                            </td>
                                            <td >
                                                <p>৩৮</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <p></p>
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <p>সর্বমোট</p>
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <br/>
                                <table width="99%" style="text-align: left">
                                    <tbody>
                                        <tr>
                                            <th colspan="39" style="text-align:right;border:1px solid #fff!important;border-bottom:1px solid #000!important;">এম আই এস ফরম - ২<br>পৃষ্ঠা-২</b></th>
                                        </tr>
                                        <tr>
                                            <td rowspan="5" class="v-b">
                                                <span class="r-v">&nbsp;&nbsp;&nbsp;ইউনিট নম্বর</span>
                                            </td>
                                            <td colspan="36" >
                                                <p class="center">পরিবার পরিকল্পনা পদ্ধতি গ্রহণকারী</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="12" >
                                                <p class="center">আইইউডি</p>
                                            </td>
                                            <td colspan="12" >
                                                <p class="center">ইমপ্ল্যান্ট</p>
                                            </td>
                                            <td colspan="12" width="28%">
                                                <p class="center">স্থায়ী পদ্ধতি</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <p class="center">স্বাভাবিক</p>
                                            </td>
                                            <td colspan="6" width="15%">
                                                <p class="center">প্রসব পরবর্তী</p>
                                            </td>
                                            <td rowspan="3" class="v-b">
                                                <p class="r-v">সর্বমোট আইইউডি</p>
                                            </td>
                                            <td colspan="5">
                                                <p class="center">স্বাভাবিক</p>
                                            </td>
                                            <td colspan="6">
                                                <p class="center">প্রসব পরবর্তী</p>
                                            </td>
                                            <td rowspan="3" class="v-b">
                                                <p class="r-v">সর্বমোট ইমপ্ল্যান্ট</p>
                                            </td>
                                            <td colspan="5">
                                                <p class="center">স্বাভাবিক</p>
                                            </td>
                                            <td colspan="6" >
                                                <p class="center">প্রসব পরবর্তী</p>
                                            </td>
                                            <td rowspan="3" class="v-b">
                                                <p class="r-v">সর্বমোট স্থায়ী পদ্ধতি</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">পুরাতন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">নতুন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">মোট</p>
                                            </td>
                                            <td colspan="2">
                                                <p class="center">ছেড়ে দিয়েছে</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">পুরাতন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">নতুন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">মোট</p>
                                            </td>
                                            <td colspan="3" >
                                                <p class="center">ছেড়ে দিয়েছে</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">পুরাতন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">নতুন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">মোট</p>
                                            </td>
                                            <td colspan="2">
                                                <p class="center">ছেড়ে দিয়েছে</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">পুরাতন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">নতুন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">মোট</p>
                                            </td>
                                            <td colspan="3" >
                                                <p class="center">ছেড়ে দিয়েছে</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">পুরাতন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">নতুন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">মোট</p>
                                            </td>
                                            <td colspan="2">
                                                <p class="center">ছেড়ে দিয়েছে</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">পুরাতন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">নতুন</p>
                                            </td>
                                            <td rowspan="2" class="v-b">
                                                <p class="r-v">মোট</p>
                                            </td>
                                            <td colspan="3" >
                                                <p class="center">ছেড়ে দিয়েছে</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="v-b">
                                                <p class="r-v">কোন পদ্ধতি নেয়নি</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">অন্য পদ্ধতি নিয়েছে</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">কোন পদ্ধতি নেয়নি</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">অন্য পদ্ধতি নিয়েছে</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">প্রসব পরবর্তী মেয়াদ উত্তীর্ণ</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">কোন পদ্ধতি নেয়নি</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">অন্য পদ্ধতি নিয়েছে</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">কোন পদ্ধতি নেয়নি</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">অন্য পদ্ধতি নিয়েছে</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">প্রসব পরবর্তী মেয়াদ উত্তীর্ণ</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">কোন পদ্ধতি নেয়নি</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">অন্য পদ্ধতি নিয়েছে</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">কোন পদ্ধতি নেয়নি</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">অন্য পদ্ধতি নিয়েছে</p>
                                            </td>
                                            <td class="v-b">
                                                <p class="r-v">প্রসব পরবর্তী মেয়াদ উত্তীর্ণ</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <p>১</p>
                                            </td>
                                            <td>
                                                <p>২</p>
                                            </td>
                                            <td >
                                                <p>৩</p>
                                            </td>
                                            <td >
                                                <p>৪</p>
                                            </td>
                                            <td>
                                                <p>৫</p>
                                            </td>
                                            <td >
                                                <p>৬</p>
                                            </td>
                                            <td >
                                                <p>৭</p>
                                            </td>
                                            <td>
                                                <p>৮</p>
                                            </td>
                                            <td >
                                                <p>৯</p>
                                            </td>
                                            <td>
                                                <p>১০</p>
                                            </td>
                                            <td >
                                                <p>১১</p>
                                            </td>
                                            <td >
                                                <p>১২</p>
                                            </td>
                                            <td >
                                                <p>১৩</p>
                                            </td>
                                            <td>
                                                <p>১৪</p>
                                            </td>
                                            <td>
                                                <p>১৫</p>
                                            </td>
                                            <td >
                                                <p>১৬</p>
                                            </td>
                                            <td>
                                                <p>১৭</p>
                                            </td>
                                            <td >
                                                <p>১৮</p>
                                            </td>
                                            <td >
                                                <p>১৯</p>
                                            </td>
                                            <td>
                                                <p>২০</p>
                                            </td>
                                            <td >
                                                <p>২১</p>
                                            </td>
                                            <td>
                                                <p>২২</p>
                                            </td>
                                            <td >
                                                <p>২৩</p>
                                            </td>
                                            <td>
                                                <p>২৪</p>
                                            </td>
                                            <td>
                                                <p>২৫</p>
                                            </td>
                                            <td >
                                                <p>২৬</p>
                                            </td>
                                            <td >
                                                <p>২৭</p>
                                            </td>
                                            <td >
                                                <p>২৮</p>
                                            </td>
                                            <td >
                                                <p>২৯</p>
                                            </td>
                                            <td >
                                                <p>৩০</p>
                                            </td>
                                            <td >
                                                <p>৩১</p>
                                            </td>
                                            <td >
                                                <p>৩২</p>
                                            </td>
                                            <td >
                                                <p>৩৩</p>
                                            </td>
                                            <td >
                                                <p>৩৪</p>
                                            </td>
                                            <td >
                                                <p>৩৫</p>
                                            </td>
                                            <td>
                                                <p>৩৬</p>
                                            </td>
                                            <td >
                                                <p>৩৭</p>
                                            </td>
                                            <td >
                                                <p>৩৮</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <p></p>
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <p>সর্বমোট</p>
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td>
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                            <td >
                                                <p></p>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
    </div>
</div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>