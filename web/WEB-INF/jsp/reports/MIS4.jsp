<%-- 
    Document   : MIS4
    Created on : Oct 25, 2018, 10:32:12 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_mis2_bangla.js"></script>
<link href="resources/css/newStyle.css" rel="stylesheet" type="text/css"/>
<style>
    .callout.callout-success, .callout.callout-danger, .callout.callout-warning {
        border:none!important;
    }
    .callout {
        border-radius: 50px!important;
    }
    #submitDataButton{
        display: none;
    }
    .rotate {
        filter:  progid:DXImageTransform.Microsoft.BasicImage(rotation=0.083);  /* IE6,IE7 */
        -ms-filter: "progid:DXImageTransform.Microsoft.BasicImage(rotation=0.083)"; /* IE8 */
        -moz-transform: rotate(-90.0deg);  /* FF3.5+ */
        -ms-transform: rotate(-90.0deg);  /* IE9+ */
        -o-transform: rotate(-90.0deg);  /* Opera 10.5 */
        -webkit-transform: rotate(-90.0deg);  /* Safari 3.1+, Chrome */
        transform: rotate(-90.0deg);  /* Standard */
    }    
    #slogan{
        border: 1px solid #000000;
        text-align: center;
        padding: 2px;
        margin-top: 45px;
        word-wrap: break-word;
    }

    #page{
        margin-top: -55px;
    }
    #logo{
        margin-top: 10px;
        margin-left: 5px;
        width:50px;
        height:50px;
    }
    .center{
        text-align: center;
    }
    .left{
        text-align: left;
    }
    #unit{
        display: none;
    }
    .mis_table th, .mis_table td{ 
        border: 1px solid #000;
        padding: 5px;
    }

    .tableTitle{
        font-family: SolaimanLipi;
        display: none;
    }
    table{
        font-family: SolaimanLipi;
        font-size: 13px;
    }

    #name{
        font-size: 11px;
    }

    table th, table td{
        padding: 3px!important;
        padding-left: 5px!important;
        text-align: center;
    }
    .submit{
        display: none;
    }
    .serial-color{
        background-color: #f4f5f7;
    }
    .not-submitted{
        background-color: #fffcfc;
    }
    [class*="col"] { margin-bottom: 10px; }


</style>

<script>
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle">
        <span id="title">MIS 4 (Upazila)</span>
        <span id="submitStatus" class="pull-right"></span>
    </h1>
</section>
<!-- Main content -->
<section class="content">
    <div class="row" id="areaPanel">
        <div class="col-md-12">
            <div class="box box-primary">
                <!-- /.box-header -->
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
                        <div class="col-md-2 col-xs-4 border-success">
                            <select class="form-control input-sm" name="district" id="district"> 
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>
                        <span id="break1"></span>
                        <div class="col-md-1 col-xs-2">
                            <label for="upazila">উপজেলা</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="upazila" id="upazila">
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="month">মাস</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="month" id="month">
                                <option value="01">জানুয়ারি</option>
                                <option value="02">ফেব্রুয়ারি</option>
                                <option value="03">মার্চ</option>
                                <option value="04">এপ্রিল</option>
                                <option value="05">মে</option>
                                <option value="06">জুন</option>
                                <option value="07">জুলাই</option>
                                <option value="08">আগষ্ট</option>
                                <option value="09">সেপ্টেম্বর</option>
                                <option value="10">অক্টোবর</option>
                                <option value="11">নভেম্বর</option>
                                <option value="12">ডিসেম্বর</option>
                            </select>
                        </div>
                    </div>

                    <div class="row secondRow">
                        <span id="break2"></span>
                        <div class="col-md-1 col-xs-2">
                            <label for="year">বছর</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="year" id="year"> </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            &nbsp;
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

    <div id="viewStatus">
    </div>

    <!--------------------------------------------------------------------------------MIS 2 Table Goes Here-------------------------------------------------------------------------------->  
    <div class="box box-primary full-screen">
        <div class="box-header with-border">
            <div class="box-tools pull-right" style="margin-top: -10px;">
                <button type="button" class="btn btn-flat btn-default btn-xs bold" id="printTableBtn"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>

        <div class="box-body" id="data-table">
                    <div class="col-ld-12 ">
                        <div class="col-md-12" id="printContent" style="padding: -30px;">
                            <div class="mis2">
                                <div class="table-responsive">
                                    <table style="text-align: left; width: 100%;border: 0!important;" id="topHeader"
                                           id="topHeader">
                                        <tr>
                                            <th style="vertical-align: text-top;border:none!important;" colspan="2">
                                                <p id="slogan">দুটি সন্তানের বেশি নয়<br>একটি হলে ভালো হয়</p>
                                            </th>
                                            <th style="text-align:center;vertical-align: text-top;border:none!important;"
                                                colspan="2">
                                                <p>গনপ্রজাতন্ত্রী বাংলাদেশ সরকার
                                                    <br>পরিবার পরিকল্পনা অধিদপ্তর
                                                    <br>পরিবার পরিকল্পনা, মা ও শিশু স্বাস্থ্য কার্যক্রমের মাসিক অগ্রগতির
                                                    প্রতিবেদন</p>
                                            </th>
                                            <th style="text-align:right;vertical-align: text-top;border:none!important;"
                                                colspan="2">
                                                <p>এম আই এস ফরম - ৪<br>পৃষ্ঠা-১</p>
                                            </th>
                                        </tr>

                                        <tr>
                                            <th style="border:none!important;" colspan="2">
                                                <img id="logo"
                                                     src="http://emis.icddrb.org:8080/emis-monitoringtools/resources/logo/Fpi_logo.png"
                                                     class="pull-left" alt=""/>
                                            </th>
                                            <th style="border:none!important;" colspan="2">
                                                মাসঃ<span id="monthyear"> ..........................</span> &nbsp;&nbsp;&nbsp;&nbsp;উপজেলা/থানাঃ<span
                                                    id="upazilaValue"> ..........................</span> &nbsp;&nbsp;&nbsp;&nbsp;জেলাঃ<span
                                                    id="districtValue"> ..........................</span>
                                            </th>
                                            <th style="text-align:right;vertical-align: text-top;border:none!important;"
                                                colspan="2">
                                            </th>
                                        </tr>
                                    </table>
                                </div>

                                <div class="table-responsive">
                                    <table style=" width: 100%;text-align: left!important" class="page1 mis_table tg">
                                        <tr>
                                            <td rowspan="4"><span class="r-v">ক্রমিক নং</span></td>
                                            <td rowspan="4" style="width:100px;">ইউনিয়নের নাম</td>
                                            <td rowspan="4"><span class="r-v">মোট দম্পতির সংখ্যা </span></td>
                                            <td colspan="33" class="center head">পরিবার পরিকল্পনা পদ্ধতি গ্রহনকারী</td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">খাবার বড়ি</td>
                                            <td colspan="5">কনডম</td>
                                            <td colspan="5">ইনজেকটেবলস</td>
                                            <td colspan="5">আইইউডি</td>
                                            <td colspan="5">ইমপ্ল্যান্ট</td>
                                            <td colspan="6">স্থায়ী পদ্ধতি</td>
                                            <td rowspan="3"><span class="r-v">সর্বমোট গ্রহণকারী</span></td>
                                            <td rowspan="3"><span class="r-v">গ্রহনকারীর হার (CAR)</span></td>
                                        </tr>
                                        <tr>
                                            <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                            <td rowspan="2"><span class="r-v">নতুন</span></td>
                                            <td rowspan="2"><span class="r-v">মোট</span></td>
                                            <td colspan="2">ছেড়ে দিয়েছে</td>

                                            <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                            <td rowspan="2"><span class="r-v">নতুন</span></td>
                                            <td rowspan="2"><span class="r-v">মোট</span></td>
                                            <td colspan="2">ছেড়ে দিয়েছে</td>

                                            <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                            <td rowspan="2"><span class="r-v">নতুন</span></td>
                                            <td rowspan="2"><span class="r-v">মোট</span></td>
                                            <td colspan="2">ছেড়ে দিয়েছে</td>

                                            <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                            <td rowspan="2"><span class="r-v">নতুন</span></td>
                                            <td rowspan="2"><span class="r-v">মোট</span></td>
                                            <td colspan="2">ছেড়ে দিয়েছে</td>

                                            <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                            <td rowspan="2"><span class="r-v">নতুন</span></td>
                                            <td rowspan="2"><span class="r-v">মোট</span></td>
                                            <td colspan="2">ছেড়ে দিয়েছে</td>

                                            <td colspan="3">পুরুষ</td>
                                            <td colspan="3">মহিলা</td>
                                        </tr>
                                        <tr>
                                            <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                            <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                            <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                            <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                            <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                            <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                            <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                            <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                            <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                            <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>

                                            <td><span class="r-v">পুরাতন</span></td>
                                            <td><span class="r-v">নতুন</span></td>
                                            <td><span class="r-v">মোট</span></td>

                                            <td><span class="r-v">পুরাতন</span></td>
                                            <td><span class="r-v">নতুন</span></td>
                                            <td><span class="r-v">মোট</span></td>
                                        </tr>
                                        <tr class="serial-color">
                                            <td>১</td>
                                            <td>২</td>
                                            <td>৩</td>
                                            <td>৪</td>
                                            <td>৫</td>
                                            <td>৬</td>
                                            <td>৭</td>
                                            <td>৮</td>
                                            <td>৯</td>
                                            <td>১০</td>
                                            <td>১১</td>
                                            <td>১২</td>
                                            <td>১৩</td>
                                            <td>১৪</td>
                                            <td>১৫</td>
                                            <td>১৬</td>
                                            <td>১৭</td>
                                            <td>১৮</td>
                                            <td>১৯</td>
                                            <td>২০</td>
                                            <td>২১</td>
                                            <td>২২</td>
                                            <td>২৩</td>
                                            <td>২৪</td>
                                            <td>২৫</td>
                                            <td>২৬</td>
                                            <td>২৭</td>
                                            <td>২৮</td>
                                            <td>২৯</td>
                                            <td>৩০</td>
                                            <td>৩১</td>
                                            <td>৩২</td>
                                            <td>৩৩</td>
                                            <td>৩৪</td>
                                            <td>৩৫</td>
                                            <td>৩৬</td>
                                        </tr>
                                        <tbody id="mis4Page1">
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
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
                                            <td colspan="2">সরকারী সংস্থার মোট</td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
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
                                            <td colspan="2">*অসরকারী সংস্থার মোট</td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
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
                                            <td colspan="2">*বহুমুখী সংস্থার মোট</td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
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
                                            <td colspan="2">উপজেলা/ থানার মোট</td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
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
                                            <td colspan="2">সিটি কর্পোরেশন</td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
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
                                        </tbody>
                                    </table>

                                    <table class="table-bordered mis_table pull-right car-table" style="width: 80%;">
                                        <tbody>
                                        <tr>
                                            <td rowspan="2"
                                                style="width: 200px;border: 1px solid #fff!important;text-align: right;padding: 3px;">
                                                &nbsp;&nbsp;পদ্ধতি গ্রহনকারীর হার (CAR):
                                            </td>
                                            <td style="width: 200px;text-align: center;padding: 4px;border:1px solid #fff!important;border-bottom:1px solid #000!important;">
                                                ইউনিটের সর্বমোট পদ্ধতি গ্রহণকারী
                                            </td>
                                            <td rowspan="2"
                                                style="border: 1px solid #fff!important;text-align: left;width: 90px;">
                                                &nbsp;✖ ১০০&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
                                            </td>

                                            <td class="v_field"
                                                style="width: 60px;text-align: center;padding: 4px;border: 1px solid #fff!important;border-bottom: 1px solid black!important;"
                                                id="r_unit_all_total_tot1">-
                                            </td>

                                            <td rowspan="2"
                                                style="border: 1px solid #fff!important;text-align: left;width: 90px;">
                                                &nbsp;&#10006; ১০০&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
                                            </td>
                                            <td class="v_field" rowspan="2"
                                                style="text-align: left;width: 100px;border: 1px solid #fff!important;"
                                                id="car"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 200px;text-align: center;padding: 4px;border:1px solid #fff!important;">
                                                ইউনিটের সর্বমোট সক্ষম দম্পতি
                                            </td>

                                            <td class="v_field" id="r_unit_capable_elco_tot1"
                                                style="border: 1px solid #fff!important;width: 80;text-align: center;padding: 4px;">
                                                -
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <br/>

                            <div class="table-responsive mis2" data-mis2="page2">
                                <table style="width: 100%" class="mis_table tg">
                                    <colgroup>
                                        <col style="width: 56px">
                                        <col style="width: 61px">
                                        <col style="width: 61px">
                                        <col style="width: 61px">
                                        <col style="width: 81px">
                                        <col style="width: 66px">
                                        <col style="width: 66px">
                                        <col style="width: 68px">
                                        <col style="width: 66px">
                                        <col style="width: 81px">
                                        <col style="width: 81px">
                                        <col style="width: 66px">
                                        <col style="width: 73px">
                                        <col style="width: 76px">
                                        <col style="width: 76px">
                                        <col style="width: 76px">
                                        <col style="width: 76px">
                                        <col style="width: 76px">
                                        <col style="width: 76px">
                                        <col style="width: 76px">
                                        <col style="width: 76px">
                                        <col style="width: 81px">
                                        <col style="width: 61px">
                                        <col style="width: 61px">
                                        <col style="width: 76px">
                                        <col style="width: 76px">
                                        <col style="width: 76px">
                                        <col style="width: 76px">
                                        <col style="width: 76px">
                                        <col style="width: 71px">
                                        <col style="width: 81px">
                                        <col style="width: 86px">
                                        <col style="width: 41px">
                                        <col style="width: 41px">
                                        <col style="width: 41px">
                                        <col style="width: 41px">
                                        <col style="width: 41px">
                                    </colgroup>
                                    <tr>
                                        <th colspan="39"
                                            style="text-align:right;border:1px solid #fff!important;border-bottom:1px solid #000!important;">
                                            এম আই এস ফরম - ৪<br>পৃষ্ঠা-২</b></th>
                                    </tr>
                                    <tr>
                                        <td rowspan="4"><span class="r-v">ক্রমিক নং<span></td>
                                        <td rowspan="4" style="width:200px!important">ইউনিয়নের নাম</td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" rowspan="2">চলতি মাসে<br>গর্ভবতীর<br>সংখ্যা</td>
                                        <td rowspan="3"><span class="r-v">পূর্ববর্তী  মাসে মোট গর্ভবতীর সংখ্যা</span>
                                        </td>
                                        <td rowspan="3"><span class="r-v">ইউনিটের সর্বমোট গর্ভবতীর সংখ্যা</span></td>
                                        <td colspan="4" rowspan="2">গর্ভকালীন সেবার তথ্য</td>
                                        <td colspan="4">প্রসব সেবার তথ্য</td>
                                        <td colspan="8">প্রসবোত্তর সেবার তথ্য</td>
                                        <td rowspan="3"><span
                                                class="r-v">রেফারকৃত ঝুকিপূর্ণ/ জটিল গর্ভবতীর সংখ্যা</span></td>
                                        <td colspan="2" rowspan="2">বন্ধ্যা<br>দম্পতি</td>
                                        <td colspan="5">টিটি প্রাপ্ত মহিলার সংখ্যা</td>
                                        <td rowspan="3"><span class="r-v">ইসিপি গ্রহনকারীর সংখ্যা</span></td>
                                        <td rowspan="3"><span class="r-v">মিসোপ্রস্টোল গ্রহনকারীর সংখ্যা</span></td>
                                        <td colspan="4" rowspan="2">কিশোর-কিশোরীর সেবা<br>(১০-১৯ বছর) কাউন্সেলিং</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">বাড়ি</td>
                                        <td colspan="2">হাসপাতাল/ ক্লিনিক</td>
                                        <td colspan="4">মা</td>
                                        <td colspan="4">নবজাতক</td>
                                        <td rowspan="2"><span class="r-v">১ম</span></td>
                                        <td rowspan="2"><span class="r-v">২য়</span></td>
                                        <td rowspan="2"><span class="r-v">৩য়</span></td>
                                        <td rowspan="2"><span class="r-v">৪র্থ</span></td>
                                        <td rowspan="2"><span class="r-v">৫ম</span></td>
                                    </tr>
                                    <tr>
                                        <td><span class="r-v">নতুন</span></td>
                                        <td><span class="r-v">পুরাতন</span></td>
                                        <td><span class="r-v">মোট</span></td>
                                        <td><span class="r-v">পরিদর্শন - ১ (৪ মাসের মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন - ২ (৬ মাসের মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন - ৩ (৮ মাসের মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন - ৪ (৯ মাসে)</span></td>
                                        <td><span class="r-v">প্রশিক্ষণপ্রাপ্ত ব্যক্তি দ্বারা</span></td>
                                        <td><span class="r-v">প্রশিক্ষণ বিহীন ব্যক্তি দ্বারা</span></td>
                                        <td><span class="r-v">স্বাভাবিক</span></td>
                                        <td><span class="r-v">সিজারিয়ান</span></td>
                                        <td><span class="r-v">পরিদর্শন - ১ (২৪ ঘণ্টার মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন - ২ (২-৩ দিনের মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন - ৩ (৭-১৪ দিনের মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন - ৪ (৪২-৪৮ দিনের মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন - ১ (২৪ ঘণ্টার মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন - ২ (২-৭ দিনের মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন - ৩ (৭-১৪ দিনের মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন - ৪ (৪২-৪৮ দিনের মধ্যে)</span></td>
                                        <td><span class="r-v">পরামর্শ কৃত</span></td>
                                        <td><span class="r-v">রেফার কৃত</span></td>
                                        <td><span class="r-v">কিশোর কিশোরীকে বয়ঃসন্ধি পরিবর্তন বিষয়ে</span></td>
                                        <td><span class="r-v">বাল্য-বিবাহ এবং কিশোরী মাতৃত্বের কুফল বিষয়ে</span></td>
                                        <td><span class="r-v">কিশোরীকে আয়রন ও ফলিক এসিড বড়ি খাবার বিষয়ে</span></td>
                                        <td><span class="r-v">প্রজনন তন্ত্রের সংক্রমন যৌনবাহিত রোগ বিষয়ে</span></td>
                                    </tr>
                                    <tr class="serial-color">
                                        <td colspan="2">&nbsp;</td>
                                        <td>৩৭</td>
                                        <td>৩৮</td>
                                        <td>৩৯</td>
                                        <td>৪০</td>
                                        <td>৪১</td>
                                        <td>৪২</td>
                                        <td>৪৩</td>
                                        <td>৪৪</td>
                                        <td>৪৫</td>
                                        <td>৪৬</td>
                                        <td>৪৭</td>
                                        <td>৪৮</td>
                                        <td>৪৯</td>
                                        <td>৫০</td>
                                        <td>৫১</td>
                                        <td>৫২</td>
                                        <td>৫৩</td>
                                        <td>৫৪</td>
                                        <td>৫৫</td>
                                        <td>৫৬</td>
                                        <td>৫৭</td>
                                        <td>৫৮</td>
                                        <td>৫৯</td>
                                        <td>৬০</td>
                                        <td>৬১</td>
                                        <td>৬২</td>
                                        <td>৬৩</td>
                                        <td>৬৪</td>
                                        <td>৬৫</td>
                                        <td>৬৬</td>
                                        <td>৬৭</td>
                                        <td>৬৮</td>
                                        <td>৬৯</td>
                                        <td>৭০</td>
                                        <td>৭১</td>
                                    </tr>
                                    <tbody id="mis4Page2">
                                    <tr>
                                        <td colspan="2"></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                        <td colspan="2">সরকারী সংস্থার মোট</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                        <td colspan="2">*অসরকারী সংস্থার মোট</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                        <td colspan="2">*বহুমুখী সংস্থার মোট</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                        <td colspan="2">উপজেলা/ থানার মোট</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                        <td colspan="2">সিটি কর্পোরেশন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                    </tbody>
                                </table>
                            </div>
                            <br/>
                            <div class="table-responsive">
                                <table style=" width: 100%;text-align: left!important" class="page1 mis_table tg">
                                    <tbody>
                                    <tr>
                                        <td rowspan="5"><span class="r-v">ক্রমিক নম্বর</span></td>
                                        <td rowspan="5"><span class="r-v"></span>ইউনিয়নের নাম</td>
                                        <td colspan="8">প্রজনন স্বাস্থ্য সেবা</td>
                                        <td colspan="9">শিশু সেবা (০-৫৯ মাস)</td>
                                        <td colspan="11">জন্ম-মৃত্যু</td>
                                        <td rowspan="5"><span class="r-v">চলতি মাসে নব দম্পতির সংখ্যা</span></td>
                                        <td colspan="2">সাধারণ রোগী&nbsp;</td>
                                        <td colspan="5">এফপিআই কর্তৃক প্রদত্ত সেবা কার্যক্রম</td>
                                    </tr>
                                    <tr>
                                        <td rowspan="4"><span class="r-v">ইসিপি গ্রহণকারীর সংখ্যা</span></td>
                                        <td rowspan="4"><span class="r-v">মিসোপ্রস্টাল বড়ি গ্রহণকারীর সংখ্যা</span></td>
                                        <td rowspan="4"><span class="r-v">এমআর (এমভিএ) সেবা প্রদানের সংখ্যা</span></td>
                                        <td rowspan="4"><span class="r-v">এমআরএম (ঔষধের মাধ্যমে এমআর) সেবা প্রদানের সংখ্যা</span>
                                        </td>
                                        <td rowspan="4"><span class="r-v">প্রজননতন্ত্রের সংক্রমণ ও যৌনবাহিত রোগ নিরাময়ে চিকিৎসা</span>
                                        </td>
                                        <td rowspan="4"><span
                                                class="r-v">আয়রন ফলিক এসিড বড়ি গ্রহণকারী কিশোরীর সংখ্যা</span></td>
                                        <td rowspan="4"><span
                                                class="r-v">স্যানিটারি প্যাড গ্রহণকারী কিশোরীর সংখ্যা</span></td>
                                        <td rowspan="4"><span class="r-v">RTI/STI সংক্রান্ত চিকিৎসা প্রদানকৃত রোগীর সংখ্যা</span>
                                        </td>
                                        <td rowspan="4"><span class="r-v">নাড়ি কাটার পর ৭.১% ক্লোরোহক্সিডিন ব্যবহারের সংখ্যা</span>
                                        </td>
                                        <td rowspan="4"><span class="r-v">জন্মের ১ ঘন্টার মধ্যে বুকের দুধ খাওয়ানোর সংখ্যা</span>
                                        </td>
                                        <td colspan="7">টিকা প্রাপ্ত শিশুর সংখ্যা</td>
                                        <td rowspan="4"><span class="r-v">মোট জীবিত জন্মের সংখ্যা</span></td>
                                        <td rowspan="4"><span class="r-v">কম জন্ম ওজনের নবজাতক(২. ৫ কেজি এর কম)</span>
                                        </td>
                                        <td rowspan="4"><span class="r-v">অপরিণত (৩৭ সপ্তাহের পূর্বে জন্ম) নবজাতক এর সংখ্যা</span>
                                        </td>
                                        <td rowspan="4"><span class="r-v">মৃত জন্ম (Still Birth)</span></td>
                                        <td colspan="7" rowspan="2">মৃত্যুর সংখ্যা</td>
                                        <td rowspan="4"><span class="r-v">পুরুষ</span></td>
                                        <td rowspan="4"><span class="r-v">মহিলা</span></td>
                                        <td rowspan="4"><span class="r-v">কতজনকে NSV সম্পর্কে উদ্বুদ্ধ করা হয়েছে</span>
                                        </td>
                                        <td rowspan="4"><span
                                                class="r-v">এভি ভ্যানের মাধ্যমে প্রদর্শনির আয়োজনের সংখ্যা</span></td>
                                        <td rowspan="4"><span class="r-v">দলগত সভা</span></td>
                                        <td rowspan="4"><span class="r-v">ইউনিয়ন পরিবার পরিকল্পনা কমিটির সভা</span></td>
                                        <td rowspan="4"><span class="r-v">স্যাটেলাইট ক্লিনিকে উপস্থিতি</span></td>
                                    </tr>
                                    <tr>
                                        <td rowspan="3"><span class="r-v">বিসিজি</span></td>
                                        <td colspan="3">পেন্টাভ্যালেন্ট <br>(ডিপিটি ,হেপবি, হিব)</td>
                                        <td rowspan="3"><span class="r-v">পিসিভি-৩</span></td>
                                        <td rowspan="3"><span class="r-v">এম আর ও ওপিভি-৪</span></td>
                                        <td rowspan="3"><span class="r-v">হামের টিকা</span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">পিসিভি</td>
                                        <td rowspan="2"><span class="r-v">৩</span></td>
                                        <td colspan="3">এক বৎসরের কম <br> মৃত শিশুর সংখ্যা</td>
                                        <td rowspan="2"><span class="r-v">১-&lt;৫ বৎসর মৃত শিশুর সংখ্যা</span></td>
                                        <td rowspan="2"><span class="r-v">মাতৃ মৃত্যুর সংখ্যা</span></td>
                                        <td rowspan="2"><span class="r-v">অন্যান্য মৃত্যুসংখ্যা</span></td>
                                        <td rowspan="2"><span class="r-v">সর্বমোট মৃত্যুর সংখ্যা</span></td>
                                    </tr>
                                    <tr>
                                        <td><span class="r-v">১</span></td>
                                        <td><span class="r-v">২</span></td>
                                        <td><span class="r-v">০-২৮ দিন</span></td>
                                        <td><span class="r-v">২৯ দিন-&lt;১ বৎসর</span></td>
                                        <td><span class="r-v">মোট</span></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>৭২</td>
                                        <td>৭৩</td>
                                        <td>৭৪</td>
                                        <td>৭৫</td>
                                        <td>৭৬</td>
                                        <td>৭৭</td>
                                        <td>৭৮</td>
                                        <td>৭৯</td>
                                        <td>৮০</td>
                                        <td>৮১</td>
                                        <td>৮২</td>
                                        <td>৮৩</td>
                                        <td>৮৪</td>
                                        <td>৮৫</td>
                                        <td>৮৬</td>
                                        <td>৮৭</td>
                                        <td>৮৮</td>
                                        <td>৮৯</td>
                                        <td>৯০</td>
                                        <td>৯১</td>
                                        <td>৯২</td>
                                        <td>৯৩</td>
                                        <td>৯৪</td>
                                        <td>৯৫</td>
                                        <td>৯৬</td>
                                        <td>৯৭</td>
                                        <td>৯৮</td>
                                        <td>৯৯</td>
                                        <td>১০০</td>
                                        <td>১০১</td>
                                        <td>১০২</td>
                                        <td>১০৩</td>
                                        <td>১০৪</td>
                                        <td>১০৫</td>
                                        <td>১০৬</td>
                                        <td>১০৭</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">সরকারী সংস্থার মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" rowspan="1">*অসরকারী সংস্থার মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">*বহুমুখী সংস্থার মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">উপজেলা/ থানার মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <br/>

                            <div class="table-responsive">
                                <table style=" width: 100%;text-align: left!important" class="page1 mis_table tg">
                                    <tbody>
                                    <tr>
                                        <td rowspan="2"><span class="r-v">ক্রমিক নম্বর</span></td>
                                        <td rowspan="2">ইউনিয়নের নাম</td>
                                        <td rowspan="2"><span class="r-v">অন্ত বিভাগে ভর্তি মহিলা রোগীর সংখ্যা</span>
                                        </td>
                                        <td rowspan="2"><span class="r-v">অন্ত বিভাগে ভর্তি শিশু রোগীর সংখ্যা</span>
                                        </td>
                                        <td rowspan="2"><span
                                                class="r-v">কেন্দ্রে স্বাস্থ্য শিক্ষা প্রদানের সংখ্যা</span></td>
                                        <td rowspan="2"><span class="r-v">এসএসিএমও (SACMO) কর্তৃক স্কুলে শিক্ষা প্রদানের সংখ্যা</span>
                                        </td>
                                        <td colspan="14">পুষ্টি সেবা(গর্ভবতী ও ০-২৩ মাস বয়সী শিশুর মা এবং ০-৫৯ মাস বয়সী
                                            শিশু)
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><span class="r-v">আইওয়াইসিএফ, আইএফএ, ভিটামিন-এ, হাত ধোয়া, মায়ের পুষ্টি <br> বিষয়ক কাউন্সেলিং</span>
                                        </td>
                                        <td><span
                                                class="r-v">গর্ভবতী মা ও শিশুর মাকে আয়রন ও ফলিক এসিড বড়ি দেয়া হয়েছে</span>
                                        </td>
                                        <td><span class="r-v">৬-২৩ মাস বয়সী শিশু এমএনপি পেয়েছে</span></td>
                                        <td><span
                                                class="r-v">০-৬মাসের কম বয়সী শিশুকে জন্মের ১ ঘন্টার মধ্যে বুকের দুধ <br> খাওয়ানো হয়েছে</span>
                                        </td>
                                        <td><span class="r-v">৬ মাস পর্যন্ত শুধু বুকের দুধ খাওয়ানো হয়েছে</span></td>
                                        <td><span class="r-v">৬ মাসের পর থেকে পরিপূরক খাবার খাওয়ানো হচ্ছে/হয়েছে</span>
                                        </td>
                                        <td><span class="r-v">৬-৫৯ মাস বয়সী শিশুকে ভিটামিন-এ দেয়া হয়েছে</span></td>
                                        <td><span class="r-v">২৪-৫৯ মাস বয়সী শিশুকে কৃমিনাশক বড়ি দেয়া হয়েছে</span></td>
                                        <td><span class="r-v">কতজন ৬-৫৯ মাস বয়সী ডায়রিয়া আক্রান্ত শিশুকে খাবার স্যালাইনের <br> সাথে জিংক বড়ি</span>
                                        </td>
                                        <td><span class="r-v">MAM (মাঝারি তীব্র অপুষ্টি) আক্রান্ত শিশুকে সনাক্ত এবং চিকিৎসা</span>
                                        </td>
                                        <td><span class="r-v">SAM (মারাত্বক তীব্র অপুষ্টি) আক্রান্ত শিশুকে সনাক্ত করা হয়েছে</span>
                                        </td>
                                        <td><span
                                                class="r-v">শিশুর Stunting (বয়সের তুলনায় কম উচ্চতা সম্পন্ন) সনাক্ত <br> করা হয়েছে</span>
                                        </td>
                                        <td><span class="r-v">শিশুর Wasting (উচ্চতার তুলনায় কম ওজন সম্পন্ন) সনাক্ত <br> করা হয়েছে</span>
                                        </td>
                                        <td><span class="r-v">শিশুর Under weight (বয়সের তুলনায় কম ওজন সম্পন্ন) <br> সনাক্ত করা হয়েছে</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>১০৮</td>
                                        <td>১০৯</td>
                                        <td>১১০</td>
                                        <td>১১১</td>
                                        <td>১১২</td>
                                        <td>১১৩</td>
                                        <td>১১৪</td>
                                        <td>১১৫</td>
                                        <td>১১৬</td>
                                        <td>১১৭</td>
                                        <td>১১৮</td>
                                        <td>১১৯</td>
                                        <td>১২০</td>
                                        <td>১২১</td>
                                        <td>১২২</td>
                                        <td>১২৩</td>
                                        <td>১২৪</td>
                                        <td>১২৫</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" rowspan="1">সরকারী সংস্থার মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">*অসরকারী সংস্থার মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">*বহুমুখী সংস্থার মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">উপজেলা/ থানার মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <br/>

                            <div class="table-responsive">
                                <table style=" width: 100%;text-align: left!important" class="page1 mis_table tg">
                                    <tbody>
                                    <tr>
                                        <td rowspan="2"><span class="r-v">ক্রমিক নম্বর</span></td>
                                        <td rowspan="2">রোগের শ্রেণী বিভাগ</td>
                                        <td colspan="2">০-২৮ দিন</td>
                                        <td colspan="2">২৯-৫৯ দিন</td>
                                        <td colspan="2">২ মাস -১ বছর&nbsp;</td>
                                        <td colspan="2">১ - ৫ বছর&nbsp;</td>
                                        <td colspan="2">মোট</td>
                                    </tr>
                                    <tr>
                                        <td>ছেলে&nbsp;</td>
                                        <td>মেয়ে&nbsp;</td>
                                        <td>ছেলে&nbsp;</td>
                                        <td>মেয়ে&nbsp;</td>
                                        <td>ছেলে&nbsp;</td>
                                        <td>মেয়ে&nbsp;</td>
                                        <td>ছেলে&nbsp;</td>
                                        <td>মেয়ে&nbsp;</td>
                                        <td>ছেলে&nbsp;</td>
                                        <td>মেয়ে&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>১</td>
                                        <td>২</td>
                                        <td>৩</td>
                                        <td>৪</td>
                                        <td>৫</td>
                                        <td>৬</td>
                                        <td>৭</td>
                                        <td>৮</td>
                                        <td>৯</td>
                                        <td>১০</td>
                                        <td>১১</td>
                                        <td>১২</td>
                                    </tr>
                                    <tr>
                                        <td>১</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>২</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>৩</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>৪</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>৫</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>৬</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>৭</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>৮</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>৯</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>১০</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>১১</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <br/>

                            <div class="table-responsive">
                                <table style=" width: 100%;text-align: left!important" class="page1 mis_table tg">
                                    <tbody>
                                    <tr>
                                        <td rowspan="4"><span class="r-v">ক্রমিক নম্বর</span></td>
                                        <td rowspan="4">ইউনিয়নের নাম</td>
                                        <td colspan="23">
                                            <p align="center" style="text-align:center">সিএসবিএ কর্তৃক প্রদত্ত সেবার
                                                তথ্য(প্রজনন স্বাস্থ্য সেবা)</p>
                                        </td>
                                        <td colspan="3">প্রাতিষ্ঠানিক প্রসব সেবার তথ্য</td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">গর্ভকালীন&nbsp; সেবার তথ্য</td>
                                        <td colspan="3">প্রসব&nbsp; সেবার তথ্য</td>
                                        <td colspan="13">প্রসবোত্তর সেবার তথ্য</td>
                                        <td rowspan="3"><span class="r-v">ঝুঁকিপূর্ণ/জটিল গর্ভবতীর সংখ্যা</span></td>
                                        <td rowspan="3"><span class="r-v">একলামপসিয়া রোগীকে লোডিং ডোজ MgSO4
                                            ইনজেকশন <br> দিয়ে রেফার করার সংখ্যা</span>
                                        </td>
                                        <td rowspan="3"><span class="r-v">নবজাতককে জটিলতার জন্য রেফার সংখ্যা</span></td>
                                        <td><span class="r-v">ইউনিয়ন স্বাস্থ্য ও পঃ কঃ কেন্দ্র</span></td>
                                        <td colspan="2"><span class="r-v">মা ও শিশু কল্যাণ কেন্দ্র</span></td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2"><span class="r-v">পরিদর্শন-১(৪ মাসের মধ্যে)</span></td>
                                        <td rowspan="2"><span class="r-v">পরিদর্শন-২(৬ মাসের মধ্যে)</span></td>
                                        <td rowspan="2"><span class="r-v">পরিদর্শন-৩(৮ মাসের মধ্যে)</span></td>
                                        <td rowspan="2"><span class="r-v">পরিদর্শন-৪(৯ মাসের মধ্যে)</span></td>
                                        <td rowspan="2"><span class="r-v">প্রসব করানো হয়েছে</span></td>
                                        <td rowspan="2"><span class="r-v">প্রসবের তৃতীয় ধাপের সক্রিয় ব্যবস্থাপনা (AMTSL) অনুসরণ <br> করে প্রসব
                                            করানোর সংখ্যা</span>
                                        </td>
                                        <td rowspan="2"><span class="r-v">অক্সিটোসিন না থাকলে মিসোপ্রস্টল বড়ি খাওয়ানো হয়েছে</span>
                                        </td>
                                        <td colspan="5">মা</td>
                                        <td colspan="8">নবজাতক</td>
                                        <td rowspan="2"><span class="r-v">স্বাভাবিক প্রসব</span></td>
                                        <td rowspan="2"><span class="r-v">স্বাভাবিক প্রসব</span></td>
                                        <td rowspan="2"><span class="r-v">সিজারিয়ান</span></td>
                                    </tr>
                                    <tr>
                                        <td><span class="r-v">পরিদর্শন-১ (২৪ ঘণ্টার মধ্যে)</span></td>
                                        <td>
                                            <p><span class="r-v">পরিদর্শন-২ (২-৩ দিনের মধ্যে)</span></p>
                                        </td>
                                        <td><span class="r-v">পরিদর্শন-৩ (৭-১৪ দিনের মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন-৪(৪২-৪৮ দিনের মধ্যে)</span></td>
                                        <td><span
                                                class="r-v">প্রসব পরবর্তী পরিবার পরিকল্পনা পদ্ধতি বিষয়ে কাউন্সেলিং</span>
                                        </td>
                                        <td><span class="r-v">পরিদর্শন-১ (২৪ ঘণ্টার মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন-২ (২-৩ দিনের মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন-৩ (৭-১৪ দিনের মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন-৪(৪২-৪৮ দিনের মধ্যে)</span></td>
                                        <td><span class="r-v">১ মিনিটের মধ্যে মোছানোর সংখ্যা</span></td>
                                        <td><span class="r-v">নাড়ি কাটার পর ৭.১% ক্লোরহেক্সিডিন ব্যবহারের সংখ্যা</span>
                                        </td>
                                        <td><span class="r-v">জন্মের ১ ঘন্টার মধ্যে বুকের দুধ খাওয়ানোর সংখ্যা</span>
                                        </td>
                                        <td><span class="r-v">জন্মকালীন শ্বাসকষ্টে আক্রান্ত শিশুকে ব্যাগ ও মাস্ক ব্যবহার <br> করে রিসাসিটেট করার সংখ্যা</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>১</td>
                                        <td>২</td>
                                        <td>৩</td>
                                        <td>৪</td>
                                        <td>৫</td>
                                        <td>৬</td>
                                        <td>৭</td>
                                        <td>৮</td>
                                        <td>৯</td>
                                        <td>১০</td>
                                        <td>১১</td>
                                        <td>১২</td>
                                        <td>১৩</td>
                                        <td>১৪</td>
                                        <td>১৫</td>
                                        <td>১৬</td>
                                        <td>১৭</td>
                                        <td>১৮</td>
                                        <td>১৯</td>
                                        <td>২০</td>
                                        <td>২১</td>
                                        <td>২২</td>
                                        <td>২৩</td>
                                        <td>২৪</td>
                                        <td>২৫</td>
                                        <td>২৬</td>
                                        <td>২৭</td>
                                        <td>২৮</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" rowspan="1">সরকারী সংস্থার মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">*অসরকারী সংস্থার মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">*বহুমুখী সংস্থার মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">উপজেলা/ থানার মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <br>
                            <div class="table-responsive">
                                <table style=" width: 100%;text-align: left!important" class="page1 mis_table tg">
                                    <tbody>
                                    <tr>
                                        <td rowspan="4">ক্রমিক নম্বর</td>
                                        <td rowspan="4">ইউনিয়নের নাম</td>
                                        <td colspan="19">বিতরণ</td>
                                        <td colspan="4">সম্পাদন</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">খাবার বড়ি (চক্র)</td>
                                        <td rowspan="3">কনডম (নিরাপদ) পিস</td>
                                        <td colspan="2">ইনজেকটেবল</td>
                                        <td colspan="4">আইইউডি</td>
                                        <td colspan="3">ইমপ্ল্যান্ট</td>
                                        <td rowspan="3"><span class="r-v">ইসিপি</span></td>
                                        <td rowspan="3"><span class="r-v">মিসো-প্রোস্টল (ডোজ)</span></td>
                                        <td rowspan="3"><span class="r-v">এমআরএম (প্যাক)</span></td>
                                        <td rowspan="3"><span class="r-v">ইনজেকশন MgSO4</span></td>
                                        <td rowspan="3"><span class="r-v">এমএনপি (স্যাসেট)</span></td>
                                        <td rowspan="3"><span class="r-v">আয়রন ফলিক এসিড&nbsp;(সংখ্যা)&nbsp;</span></td>
                                        <td rowspan="3"><span class="r-v">স্যানিটারী প্যাড (সংখ্যা)</span></td>
                                        <td colspan="4">স্থায়ী পদ্ধতি</td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2">সুখী</td>
                                        <td rowspan="2">আপন</td>
                                        <td rowspan="2">ভায়াল</td>
                                        <td rowspan="2">সিরিঞ্জ</td>
                                        <td colspan="3">নতুন</td>
                                        <td rowspan="2">খুলে ফেলা</td>
                                        <td colspan="2">নতুন</td>
                                        <td colspan="1" rowspan="2"><span class="r-v">খুলে ফেলা</span></td>
                                        <td rowspan="2"><span class="r-v">পুুরুষ (সংখ্যা)</span></td>
                                        <td colspan="3">মহিলা (সংখ্যা)</td>
                                    </tr>
                                    <tr>
                                        <td><span class="r-v">স্বাভাবিক</span></td>
                                        <td><span class="r-v">প্রসব পরবর্তী</span></td>
                                        <td><span class="r-v">মোট</span></td>
                                        <td><span class="r-v">ইমপ্ল্যানন</span></td>
                                        <td><span class="r-v">জেডেল</span></td>
                                        <td><span class="r-v">স্বাভাবিক</span></td>
                                        <td><span class="r-v">প্রসব পরবর্তী</span></td>
                                        <td><span class="r-v">মোট</span></td>
                                    </tr>
                                    <tr>
                                        <td>১</td>
                                        <td>২</td>
                                        <td>৩</td>
                                        <td>৪</td>
                                        <td>৫</td>
                                        <td>৬</td>
                                        <td>৭</td>
                                        <td>৮</td>
                                        <td>৯</td>
                                        <td>১০</td>
                                        <td>১১</td>
                                        <td>১২</td>
                                        <td>১৩</td>
                                        <td>১৪</td>
                                        <td>১৫</td>
                                        <td>১৬</td>
                                        <td>১৭</td>
                                        <td>১৮</td>
                                        <td>১৯</td>
                                        <td>২০</td>
                                        <td>২১</td>
                                        <td>২২</td>
                                        <td>২৩</td>
                                        <td>২৪</td>
                                        <td colspan="2">২৫</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" rowspan="1">সরকারী সংস্থার মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">*অসরকারী সংস্থার মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">*বহুমুখী সংস্থার মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">উপজেলা/ থানার মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <br>
                            <div class="table-responsive">
                                <table style="text-align: left; width: 100%;border: 0!important;" id="topHeader">
                                    <tr>
                                        <th style="vertical-align: text-top;border:none!important;" colspan="2">
                                            <p id="slogan">দুটি সন্তানের বেশি নয়<br>একটি হলে ভালো হয়</p>
                                        </th>
                                        <th style="text-align:center;vertical-align: text-top;border:none!important;"
                                            colspan="2">
                                            <p>গনপ্রজাতন্ত্রী বাংলাদেশ সরকার
                                                <br>পরিবার পরিকল্পনা অধিদপ্তর
                                                <br>পরিবার পরিকল্পনা, মা ও শিশু স্বাস্থ্য কার্যক্রমের মাসিক অগ্রগতির
                                                প্রতিবেদন</p>
                                        </th>
                                        <th style="text-align:right;vertical-align: text-top;border:none!important;"
                                            colspan="2">
                                            <p>এম আই এস ফরম - ৪</p>
                                        </th>
                                    </tr>

                                    <tr>
                                        <th style="border:none!important;" colspan="2">
                                            <img id="logo"
                                                 src="http://emis.icddrb.org:8080/emis-monitoringtools/resources/logo/Fpi_logo.png"
                                                 class="pull-left" alt=""/>
                                        </th>
                                        <th style="border:none!important;" colspan="2">
                                            মাসঃ<span id="monthyear"> ..........................</span> &nbsp;&nbsp;&nbsp;&nbsp;উপজেলা/থানাঃ<span
                                                id="upazilaValue"> ..........................</span> &nbsp;&nbsp;&nbsp;&nbsp;জেলাঃ<span
                                                id="districtValue"> ..........................</span>
                                        </th>
                                        <th style="text-align:right;vertical-align: text-top;border:none!important;"
                                            colspan="2">
                                        </th>
                                    </tr>
                                </table>
                            </div>
                            <br>
                            <br>
                            <div class="table-responsive">
                                <table style=" width: 100%;text-align: left!important" class="page1 mis_table tg">
                                    <tr>
                                        <td rowspan="4"><span class="r-v">ক্রমিক নং</span></td>
                                        <td rowspan="4" style="width:100px;">ইউনিয়নের নাম</td>
                                        <td rowspan="4"><span class="r-v">মোট দম্পতির সংখ্যা </span></td>
                                        <td colspan="33" class="center head">পরিবার পরিকল্পনা পদ্ধতি গ্রহনকারী</td>
                                    </tr>
                                    <tr>
                                        <td colspan="5">খাবার বড়ি</td>
                                        <td colspan="5">কনডম</td>
                                        <td colspan="5">ইনজেকটেবলস</td>
                                        <td colspan="5">আইইউডি</td>
                                        <td colspan="5">ইমপ্ল্যান্ট</td>
                                        <td colspan="6">স্থায়ী পদ্ধতি</td>
                                        <td rowspan="3"><span class="r-v">সর্বমোট গ্রহণকারী</span></td>
                                        <td rowspan="3"><span class="r-v">গ্রহনকারীর হার (CAR)</span></td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                        <td rowspan="2"><span class="r-v">নতুন</span></td>
                                        <td rowspan="2"><span class="r-v">মোট</span></td>
                                        <td colspan="2">ছেড়ে দিয়েছে</td>

                                        <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                        <td rowspan="2"><span class="r-v">নতুন</span></td>
                                        <td rowspan="2"><span class="r-v">মোট</span></td>
                                        <td colspan="2">ছেড়ে দিয়েছে</td>

                                        <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                        <td rowspan="2"><span class="r-v">নতুন</span></td>
                                        <td rowspan="2"><span class="r-v">মোট</span></td>
                                        <td colspan="2">ছেড়ে দিয়েছে</td>

                                        <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                        <td rowspan="2"><span class="r-v">নতুন</span></td>
                                        <td rowspan="2"><span class="r-v">মোট</span></td>
                                        <td colspan="2">ছেড়ে দিয়েছে</td>

                                        <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                        <td rowspan="2"><span class="r-v">নতুন</span></td>
                                        <td rowspan="2"><span class="r-v">মোট</span></td>
                                        <td colspan="2">ছেড়ে দিয়েছে</td>

                                        <td colspan="3">পুরুষ</td>
                                        <td colspan="3">মহিলা</td>
                                    </tr>
                                    <tr>
                                        <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                        <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                        <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                        <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                        <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                        <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                        <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                        <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                        <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                        <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>

                                        <td><span class="r-v">পুরাতন</span></td>
                                        <td><span class="r-v">নতুন</span></td>
                                        <td><span class="r-v">মোট</span></td>

                                        <td><span class="r-v">পুরাতন</span></td>
                                        <td><span class="r-v">নতুন</span></td>
                                        <td><span class="r-v">মোট</span></td>
                                    </tr>
                                    <tr class="serial-color">
                                        <td>১</td>
                                        <td>২</td>
                                        <td>৩</td>
                                        <td>৪</td>
                                        <td>৫</td>
                                        <td>৬</td>
                                        <td>৭</td>
                                        <td>৮</td>
                                        <td>৯</td>
                                        <td>১০</td>
                                        <td>১১</td>
                                        <td>১২</td>
                                        <td>১৩</td>
                                        <td>১৪</td>
                                        <td>১৫</td>
                                        <td>১৬</td>
                                        <td>১৭</td>
                                        <td>১৮</td>
                                        <td>১৯</td>
                                        <td>২০</td>
                                        <td>২১</td>
                                        <td>২২</td>
                                        <td>২৩</td>
                                        <td>২৪</td>
                                        <td>২৫</td>
                                        <td>২৬</td>
                                        <td>২৭</td>
                                        <td>২৮</td>
                                        <td>২৯</td>
                                        <td>৩০</td>
                                        <td>৩১</td>
                                        <td>৩২</td>
                                        <td>৩৩</td>
                                        <td>৩৪</td>
                                        <td>৩৫</td>
                                        <td>৩৬</td>
                                    </tr>
                                    <tbody id="mis4Page1">
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                        <td colspan="2">মোট</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                        <td colspan="2">বহুমুখী সংস্থার</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                        <td colspan="2">সর্বমোট</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                    </tbody>
                                </table>

                                <table class="table-bordered mis_table pull-right car-table" style="width: 80%;">
                                    <tbody>
                                    <tr>
                                        <td rowspan="2"
                                            style="width: 200px;border: 1px solid #fff!important;text-align: right;padding: 3px;">
                                            &nbsp;&nbsp;পদ্ধতি গ্রহনকারীর হার (CAR):
                                        </td>
                                        <td style="width: 200px;text-align: center;padding: 4px;border:1px solid #fff!important;border-bottom:1px solid #000!important;">
                                            ইউনিটের সর্বমোট পদ্ধতি গ্রহণকারী
                                        </td>
                                        <td rowspan="2"
                                            style="border: 1px solid #fff!important;text-align: left;width: 90px;">
                                            &nbsp;✖ ১০০&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
                                        </td>

                                        <td class="v_field"
                                            style="width: 60px;text-align: center;padding: 4px;border: 1px solid #fff!important;border-bottom: 1px solid black!important;"
                                            id="r_unit_all_total_tot1">-
                                        </td>

                                        <td rowspan="2"
                                            style="border: 1px solid #fff!important;text-align: left;width: 90px;">
                                            &nbsp;&#10006; ১০০&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
                                        </td>
                                        <td class="v_field" rowspan="2"
                                            style="text-align: left;width: 100px;border: 1px solid #fff!important;"
                                            id="car"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 200px;text-align: center;padding: 4px;border:1px solid #fff!important;">
                                            ইউনিটের সর্বমোট সক্ষম দম্পতি
                                        </td>

                                        <td class="v_field" id="r_unit_capable_elco_tot1"
                                            style="border: 1px solid #fff!important;width: 80;text-align: center;padding: 4px;">
                                            -
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <br>
                            <div class="table-responsive">
                                <table style=" width: 100%;text-align: left!important" class="page1 mis_table tg">
                                    <tbody>
                                    <tr>
                                        <td rowspan="4"><span class="r-v">ক্রমিক নম্বর</span></td>
                                        <td rowspan="4">ইউনিয়নের নাম</td>
                                        <td colspan="23">
                                            <p align="center" style="text-align:center">সিএসবিএ কর্তৃক প্রদত্ত সেবার
                                                তথ্য(প্রজনন স্বাস্থ্য সেবা)</p>
                                        </td>
                                        <td colspan="3">প্রাতিষ্ঠানিক প্রসব সেবার তথ্য</td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">গর্ভকালীন&nbsp; সেবার তথ্য</td>
                                        <td colspan="3">প্রসব&nbsp; সেবার তথ্য</td>
                                        <td colspan="13">প্রসবোত্তর সেবার তথ্য</td>
                                        <td rowspan="3"><span class="r-v">ঝুঁকিপূর্ণ/জটিল গর্ভবতীর সংখ্যা</span></td>
                                        <td rowspan="3"><span class="r-v">একলামপসিয়া রোগীকে লোডিং ডোজ MgSO4
                                            ইনজেকশন <br> দিয়ে রেফার করার সংখ্যা</span>
                                        </td>
                                        <td rowspan="3"><span class="r-v">নবজাতককে জটিলতার জন্য রেফার সংখ্যা</span></td>
                                        <td><span class="r-v">ইউনিয়ন স্বাস্থ্য ও পঃ কঃ কেন্দ্র</span></td>
                                        <td colspan="2"><span class="r-v">মা ও শিশু কল্যাণ কেন্দ্র</span></td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2"><span class="r-v">পরিদর্শন-১(৪ মাসের মধ্যে)</span></td>
                                        <td rowspan="2"><span class="r-v">পরিদর্শন-২(৬ মাসের মধ্যে)</span></td>
                                        <td rowspan="2"><span class="r-v">পরিদর্শন-৩(৮ মাসের মধ্যে)</span></td>
                                        <td rowspan="2"><span class="r-v">পরিদর্শন-৪(৯ মাসের মধ্যে)</span></td>
                                        <td rowspan="2"><span class="r-v">প্রসব করানো হয়েছে</span></td>
                                        <td rowspan="2"><span class="r-v">প্রসবের তৃতীয় ধাপের সক্রিয় ব্যবস্থাপনা (AMTSL) অনুসরণ <br> করে প্রসব
                                            করানোর সংখ্যা</span>
                                        </td>
                                        <td rowspan="2"><span class="r-v">অক্সিটোসিন না থাকলে মিসোপ্রস্টল বড়ি খাওয়ানো হয়েছে</span>
                                        </td>
                                        <td colspan="5">মা</td>
                                        <td colspan="8">নবজাতক</td>
                                        <td rowspan="2"><span class="r-v">স্বাভাবিক প্রসব</span></td>
                                        <td rowspan="2"><span class="r-v">স্বাভাবিক প্রসব</span></td>
                                        <td rowspan="2"><span class="r-v">সিজারিয়ান</span></td>
                                    </tr>
                                    <tr>
                                        <td><span class="r-v">পরিদর্শন-১ (২৪ ঘণ্টার মধ্যে)</span></td>
                                        <td>
                                            <p><span class="r-v">পরিদর্শন-২ (২-৩ দিনের মধ্যে)</span></p>
                                        </td>
                                        <td><span class="r-v">পরিদর্শন-৩ (৭-১৪ দিনের মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন-৪(৪২-৪৮ দিনের মধ্যে)</span></td>
                                        <td><span
                                                class="r-v">প্রসব পরবর্তী পরিবার পরিকল্পনা পদ্ধতি বিষয়ে কাউন্সেলিং</span>
                                        </td>
                                        <td><span class="r-v">পরিদর্শন-১ (২৪ ঘণ্টার মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন-২ (২-৩ দিনের মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন-৩ (৭-১৪ দিনের মধ্যে)</span></td>
                                        <td><span class="r-v">পরিদর্শন-৪(৪২-৪৮ দিনের মধ্যে)</span></td>
                                        <td><span class="r-v">১ মিনিটের মধ্যে মোছানোর সংখ্যা</span></td>
                                        <td><span class="r-v">নাড়ি কাটার পর ৭.১% ক্লোরহেক্সিডিন ব্যবহারের সংখ্যা</span>
                                        </td>
                                        <td><span class="r-v">জন্মের ১ ঘন্টার মধ্যে বুকের দুধ খাওয়ানোর সংখ্যা</span>
                                        </td>
                                        <td><span class="r-v">জন্মকালীন শ্বাসকষ্টে আক্রান্ত শিশুকে ব্যাগ ও মাস্ক ব্যবহার <br> করে রিসাসিটেট করার সংখ্যা</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>১</td>
                                        <td>২</td>
                                        <td>৩</td>
                                        <td>৪</td>
                                        <td>৫</td>
                                        <td>৬</td>
                                        <td>৭</td>
                                        <td>৮</td>
                                        <td>৯</td>
                                        <td>১০</td>
                                        <td>১১</td>
                                        <td>১২</td>
                                        <td>১৩</td>
                                        <td>১৪</td>
                                        <td>১৫</td>
                                        <td>১৬</td>
                                        <td>১৭</td>
                                        <td>১৮</td>
                                        <td>১৯</td>
                                        <td>২০</td>
                                        <td>২১</td>
                                        <td>২২</td>
                                        <td>২৩</td>
                                        <td>২৪</td>
                                        <td>২৫</td>
                                        <td>২৬</td>
                                        <td>২৭</td>
                                        <td>২৮</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" rowspan="1">মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">বহুমুখী সংস্থার মোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">সর্বমোট</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </section>      
            <!-------- Start Report Modal ----------->
            <%@include file="/WEB-INF/jspf/modal-report-submit.jspf" %>  
            <%@include file="/WEB-INF/jspf/modal-report-response.jspf" %>
            <%@include file="/WEB-INF/jspf/modal-report-view.jspf" %>
            <%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
