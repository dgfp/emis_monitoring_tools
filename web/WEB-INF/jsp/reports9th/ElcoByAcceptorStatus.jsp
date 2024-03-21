<%-- 
    Document   : ElcoByAcceptorStatus
    Created on : May 30, 2020, 11:53:07 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla_test.js"></script>
<style>
    .datepicker-days > table, th, td {
        border: none;
    }
    .datepicker-years > table, th, td {
        border: none;
    }
    .datepicker-months > table, th, td {
        border: none;
    }
    table, th, td {
        border: 1px solid black;
    }
    th, td {
        padding: 5px;
        text-align: center;
    }
    th{
        vertical-align: bottom;
    }
    .tableTitle{
        font-family: SolaimanLipi;
        font-size: 20px;
        margin-top: 0px;
    }
    table{
        font-family: SolaimanLipi;
        font-size: 13px;
    }
    [class*="col"] { margin-bottom: 10px; }
    #areaPanel .box { margin-bottom: 0px; }
    #dateDiv{
        display: none;
    }
    .block{
        background-color:#7c868c!important;  
        color: #7c868c;
    }
    @media print {
        .tableTitle{
            display: block;
            margin-top: -2px;
        }
        .reg-fwa-13{
            margin-top: -30px!important;
        }
        .box{ border: 0}
        #areaPanel, #back-to-top, .box-header, .main-footer{
            display: none !important;
        }
    }
</style>
<script>
    $(document).ready(function () {

        $('input[type=radio][name=reportType]').change(function () {
            if (this.value == 'yearWise') {
                $('#yearDiv').css('display', 'block');
                $('#dateDiv').css('display', 'none');
            } else if (this.value == 'dateWise') {
                $('#dateDiv').css('display', 'block');
                $('#yearDiv').css('display', 'none');
            }
        });
        $('#showdataButton').click(function () {
            $('.v_field').html(""); //reset all text value field.
            if ($("select#division").val() === "") {
                toastr["error"]("<h4><b>বিভাগ সিলেক্ট করুন </b></h4>");

            } else if ($("select#district").val() === "") {
                toastr["error"]("<h4><b>জেলা সিলেক্ট করুন </b></h4>");

            } else if ($("select#upazila").val() === "") {
                toastr["error"]("<h4><b>উপজেলা সিলেক্ট করুন</b></h4>");

            } else if ($("select#union").val() === "" && $.app.user.role == "Union level (DGFP)") {
                toastr["error"]("<h4><b>ইউনিয়ন সিলেক্ট করুন</b></h4>");

            }
//             else if ($("select#unit").val() === "") {
//                toastr["error"]("<h4><b>ইউনিট সিলেক্ট করুন</b></h4>");
//
//            } 
            else {
                $.ajax({
                    url: "elco-by-acceptor-status",
                    data: {
                        district: $("select#district").val(),
                        upazila: $("select#upazila").val(),
                        union: $("select#union").val(),
                        unit: $("select#unit").val(),
                        type: $("input[name='reportType']:checked").val(),
                        year: $("#year").val(),
                        date: $('#endDate').val()
                    },
                    type: 'POST',
                    success: function (json) {
                        json = JSON.parse(json);
                        if (json.length === 0) {
                            toastr["error"]("<h4><b>কোন ডাটা পাওয়া যায়নি</b></h4>");
                            return;
                        }
                        var breakPoint = [{row: 1, break: 3}, {row: 2, break: 7}, {row: 3, break: 11}, {row: 4, break: 15}], total = [], index = 0, allTotal = [0, 1, 2, 3];
                        $.each(json, function (i, o) {
                            renderData(o);
                            total.push(o);
                            if (i == breakPoint[index].break) {
                                renderTotalData(new Calc(total).sum, breakPoint[index].row, 'total');
                                total = [];
                                index++;
                            }
                        });
                        allTotal.forEach(function (i) {
                            total.push(renderTotalData(new Calc(json.filter(d => d.child_cnt == i)).sum, 'total', i));
                        });
                        renderTotalData(new Calc(total).sum, 'total', 'total');
                        $(".table-data table td").each(function () {
                            $(this).text(convertE2B($(this).text()));
                        });
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        toastr["error"]("<h4><b>অনুরোধটি প্রক্রিয়াধীন করা যাচ্ছে না</b></h4>");
                    }
                }); //End Ajax
            }//End else
        });//End Button Click
        function renderTotalData(data, age, child_cnt) {
            data.age = age
            data.child_cnt = child_cnt;
            renderData(data);
            return data;
        }
        function renderData(o) {
            $('#' + o.age + '_' + o.child_cnt + '_pill_normal').html(o.pill_normal);
            $('#' + o.age + '_' + o.child_cnt + '_pill_after_delivery').html(o.pill_after_delivery);
            $('#' + o.age + '_' + o.child_cnt + '_condom_normal').html(o.condom_normal);
            $('#' + o.age + '_' + o.child_cnt + '_condom_after_delivery').html(o.condom_after_delivery);
            $('#' + o.age + '_' + o.child_cnt + '_inject_normal').html(o.inject_normal);
            $('#' + o.age + '_' + o.child_cnt + '_inject_after_delivery').html(o.inject_after_delivery);
            $('#' + o.age + '_' + o.child_cnt + '_iud_normal').html(o.iud_normal);
            $('#' + o.age + '_' + o.child_cnt + '_iud_after_delivery').html(o.iud_after_delivery);
            $('#' + o.age + '_' + o.child_cnt + '_implant_normal').html(o.implant_normal);
            $('#' + o.age + '_' + o.child_cnt + '_implant_after_delivery').html(o.implant_after_delivery);
            $('#' + o.age + '_' + o.child_cnt + '_permanent_man_normal').html(o.permanent_man_normal);
            $('#' + o.age + '_' + o.child_cnt + '_permanent_man_after_delivery').html(o.permanent_man_after_delivery);
            $('#' + o.age + '_' + o.child_cnt + '_permanent_woman_normal').html(o.permanent_woman_normal);
            $('#' + o.age + '_' + o.child_cnt + '_permanent_woman_after_delivery').html(o.permanent_woman_after_delivery);
            $('#' + o.age + '_' + o.child_cnt + '_method_all').html(o.method_all);
            $('#' + o.age + '_' + o.child_cnt + '_method_not_taken').html(o.method_not_taken);
            $('#' + o.age + '_' + o.child_cnt + '_pregnent').html(o.pregnent);
            $('#' + o.age + '_' + o.child_cnt + '_live_birth_tot').html(o.live_birth_tot);
            $('#' + o.age + '_' + o.child_cnt + '_husband_foreign').html(o.husband_foreign);
        }
    });
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle">ELCO by acceptor status</h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <div class="row" id="areaPanel">
        <div class="col-md-12">
            <div class="box box-primary">
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
                            <label for="reportType">রিপোর্টের ধরণ</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <label class="yearWiseLevel"><input type="radio" class="yearWise" id="reportType" name="reportType" value="yearWise" checked=""> বছর ভিত্তিক</label>&nbsp;
                            <label class="dateWiseLevel"><input type="radio" class="dateWise" id="reportType" name="reportType" value="dateWise"> তারিখ ভিত্তিক</label>
                        </div>
                        <div id="yearDiv">
                            <div class="col-md-1 col-xs-2">
                                <label for="year">বছর</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="year" id="year"> </select>
                            </div>
                        </div>
                        <div id="dateDiv">
                            <div class="col-md-1 col-xs-2">
                                <label for="year">তারিখ</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <input type="text" class="input form-control input-sm currentYearDatePicker" placeholder="dd/mm/yyyy" name="endDate" id="endDate" readonly="readonly" style="background-color: rgb(255, 255, 255);">
                            </div>
                        </div>
                        <div class="col-md-1 col-xs-2">
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
                <button type="button" class="btn btn-flat btn-default btn-xs bold" onclick="window.print();"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body">
            <div  class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <h3 class="tableTitle"><center>সন্তান সংখ্যা অনুযায়ী এবং বয়স ভিত্তিক পদ্ধতি প্রহণকারী ও অগ্রহণকারী সক্ষম দম্পতিদের বিন্যাস ছক</center></h3>
                        <div class="table-data">


                            <table>
                                <thead class="center">
                                    <tr>
                                        <!--                                        <th rowspan="4" class="" style="width: 70px;">বয়সের বিন্যাস</th>
                                                                                <th rowspan="4" class="" style="width: 70px;">সন্তান সংখ্যার বিন্যাস</th>-->

                                        <th rowspan="4"><span class="r-v">বয়সের বিন্যাস</span></th>
                                        <th rowspan="4"><span class="r-v">সন্তান সংখ্যার বিন্যাস</span></th>


                                        <th colspan="15"><center>পদ্ধতি প্রহণকারী</center></th>

                                <!--                                <th rowspan="4" class="" style="width: 70px;">অগ্রহণকারী</th>
                                                                <th rowspan="4" class="" style="width: 70px;">গর্ভবতী</th> 
                                                                <th rowspan="4" class="" style="width: 70px;">মোট জীবিত সন্তানের সংখ্যা</th>
                                                                <th rowspan="4" class="" style="width: 70px;">স্বামী বিদেশে</th>-->

                                <th rowspan="4"><span class="r-v">অগ্রহণকারী</span></th>
                                <th rowspan="4"><span class="r-v">গর্ভবতী</span></th>
                                <th rowspan="4"><span class="r-v">মোট জীবিত সন্তানের সংখ্যা</span></th>
                                <th rowspan="4"><span class="r-v">স্বামী বিদেশে</span></th>
                                </tr>
                                <tr>
                                    <th colspan="2" style="width: 60px;">খাবার বড়ি</th>
                                    <th colspan="2" style="width: 60px;">কনডম</th>
                                    <th colspan="2" style="width: 60px;">ইনজেকটেবল</th>
                                    <th colspan="2" style="width: 60px;">আই ইউ ডি</th>
                                    <th colspan="2" style="width: 60px;">ইমপ্ল্যান্ট</th>
                                    <th colspan="4" style="width: 60px;">স্থায়ী পদ্ধতি</th>

                                    <th rowspan="3"><span class="r-v">মোট</span></th>
                                    <!--                                    <th rowspan="3" style="width: 60px;">মোট</th>-->
                                </tr>
                                <tr>
                                    <!--                                    <th rowspan="2"><span>স্বাভাবিক</span></th>-->
                                    <th rowspan="2"><span class="r-v">স্বাভাবিক</span></th>

                                    <th rowspan="2"><span class="r-v">প্রসব পরবর্তী </span></th>
                                    <th rowspan="2"><span class="r-v">স্বাভাবিক</span></th>
                                    <th rowspan="2"><span class="r-v">প্রসব পরবর্তী </span></th>
                                    <th rowspan="2"><span class="r-v">স্বাভাবিক</span></th>
                                    <th rowspan="2"><span class="r-v">প্রসব পরবর্তী </span></th>
                                    <th rowspan="2"><span class="r-v">স্বাভাবিক</span></th>
                                    <th rowspan="2"><span class="r-v">প্রসব পরবর্তী </span></th>
                                    <th rowspan="2"><span class="r-v">স্বাভাবিক</span></th>
                                    <th rowspan="2"><span class="r-v">প্রসব পরবর্তী </span></th>

                                    <th colspan="2"><span class="r-v">পুরুষ</span></th>
                                    <th colspan="2"><span class="r-v">মহিলা</span></th>

                                    <!--                                    <th colspan="2" class="" style="width: 60px;">পুরুষ</th>
                                                                        <th colspan="2" class="" style="width: 60px;">মহিলা</th>-->
                                </tr>
                                <tr>
                                    <th><span class="r-v">স্বাভাবিক</span></th>
                                    <th><span class="r-v">প্রসব পরবর্তী </span></th>
                                    <th><span class="r-v">স্বাভাবিক</span></th>
                                    <th><span class="r-v">প্রসব পরবর্তী </span></th>
                                </tr>
                                </thead>
                                <tbody id="tbody">
                                    <tr>
                                        <td class="t_field rotate" rowspan="5"><২০</td>
                                        <td class="t_field">০</td>
                                        <td class="v_field" id="1_0_pill_normal"></td>
                                        <td class="v_field" id="1_0_pill_after_delivery"></td>
                                        <td class="v_field" id="1_0_condom_normal"></td>
                                        <td class="v_field" id="1_0_condom_after_delivery"></td>
                                        <td class="v_field" id="1_0_inject_normal"></td>
                                        <td class="v_field" id="1_0_inject_after_delivery"></td>
                                        <td class="v_field" id="1_0_iud_normal"></td>
                                        <td class="v_field" id="1_0_iud_after_delivery"></td>
                                        <td class="v_field" id="1_0_implant_normal"></td>
                                        <td class="v_field" id="1_0_implant_after_delivery"></td>
                                        <td class="v_field" id="1_0_permanent_man_normal"></td>
                                        <td class="v_field" id="1_0_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="1_0_permanent_woman_normal"></td>
                                        <td class="v_field" id="1_0_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="1_0_method_all"></td>
                                        <td class="v_field" id="1_0_method_not_taken"></td>
                                        <td class="v_field" id="1_0_pregnent"></td>
                                        <td class="v_field block" id="1_0_live_birth_tot" ></td>
                                        <td class="v_field" id="1_0_husband_foreign"></td> 
                                    </tr>
                                    <tr>
                                        <td class="t_field">১</td>
                                        <td class="v_field" id="1_1_pill_normal"></td>
                                        <td class="v_field" id="1_1_pill_after_delivery"></td>
                                        <td class="v_field" id="1_1_condom_normal"></td>
                                        <td class="v_field" id="1_1_condom_after_delivery"></td>
                                        <td class="v_field" id="1_1_inject_normal"></td>
                                        <td class="v_field" id="1_1_inject_after_delivery"></td>
                                        <td class="v_field" id="1_1_iud_normal"></td>
                                        <td class="v_field" id="1_1_iud_after_delivery"></td>
                                        <td class="v_field" id="1_1_implant_normal"></td>
                                        <td class="v_field" id="1_1_implant_after_delivery"></td>
                                        <td class="v_field" id="1_1_permanent_man_normal"></td>
                                        <td class="v_field" id="1_1_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="1_1_permanent_woman_normal"></td>
                                        <td class="v_field" id="1_1_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="1_1_method_all"></td>
                                        <td class="v_field" id="1_1_method_not_taken"></td>
                                        <td class="v_field" id="1_1_pregnent"></td>
                                        <td class="v_field" id="1_1_live_birth_tot"></td>
                                        <td class="v_field" id="1_1_husband_foreign"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">২</td>
                                        <td class="v_field" id="1_2_pill_normal"></td>
                                        <td class="v_field" id="1_2_pill_after_delivery"></td>
                                        <td class="v_field" id="1_2_condom_normal"></td>
                                        <td class="v_field" id="1_2_condom_after_delivery"></td>
                                        <td class="v_field" id="1_2_inject_normal"></td>
                                        <td class="v_field" id="1_2_inject_after_delivery"></td>
                                        <td class="v_field" id="1_2_iud_normal"></td>
                                        <td class="v_field" id="1_2_iud_after_delivery"></td>
                                        <td class="v_field" id="1_2_implant_normal"></td>
                                        <td class="v_field" id="1_2_implant_after_delivery"></td>
                                        <td class="v_field" id="1_2_permanent_man_normal"></td>
                                        <td class="v_field" id="1_2_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="1_2_permanent_woman_normal"></td>
                                        <td class="v_field" id="1_2_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="1_2_method_all"></td>
                                        <td class="v_field" id="1_2_method_not_taken"></td>
                                        <td class="v_field" id="1_2_pregnent"></td>
                                        <td class="v_field" id="1_2_live_birth_tot"></td>
                                        <td class="v_field" id="1_2_husband_foreign"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">৩+</td>
                                        <td class="v_field" id="1_3_pill_normal"></td>
                                        <td class="v_field" id="1_3_pill_after_delivery"></td>
                                        <td class="v_field" id="1_3_condom_normal"></td>
                                        <td class="v_field" id="1_3_condom_after_delivery"></td>
                                        <td class="v_field" id="1_3_inject_normal"></td>
                                        <td class="v_field" id="1_3_inject_after_delivery"></td>
                                        <td class="v_field" id="1_3_iud_normal"></td>
                                        <td class="v_field" id="1_3_iud_after_delivery"></td>
                                        <td class="v_field" id="1_3_implant_normal"></td>
                                        <td class="v_field" id="1_3_implant_after_delivery"></td>
                                        <td class="v_field" id="1_3_permanent_man_normal"></td>
                                        <td class="v_field" id="1_3_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="1_3_permanent_woman_normal"></td>
                                        <td class="v_field" id="1_3_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="1_3_method_all"></td>
                                        <td class="v_field" id="1_3_method_not_taken"></td>
                                        <td class="v_field" id="1_3_pregnent"></td>
                                        <td class="v_field" id="1_3_live_birth_tot"></td>
                                        <td class="v_field" id="1_3_husband_foreign"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">মোট</td>
                                        <td class="v_field" id="1_total_pill_normal"></td>
                                        <td class="v_field" id="1_total_pill_after_delivery"></td>
                                        <td class="v_field" id="1_total_condom_normal"></td>
                                        <td class="v_field" id="1_total_condom_after_delivery"></td>
                                        <td class="v_field" id="1_total_inject_normal"></td>
                                        <td class="v_field" id="1_total_inject_after_delivery"></td>
                                        <td class="v_field" id="1_total_iud_normal"></td>
                                        <td class="v_field" id="1_total_iud_after_delivery"></td>
                                        <td class="v_field" id="1_total_implant_normal"></td>
                                        <td class="v_field" id="1_total_implant_after_delivery"></td>
                                        <td class="v_field" id="1_total_permanent_man_normal"></td>
                                        <td class="v_field" id="1_total_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="1_total_permanent_woman_normal"></td>
                                        <td class="v_field" id="1_total_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="1_total_method_all"></td>
                                        <td class="v_field" id="1_total_method_not_taken"></td>
                                        <td class="v_field" id="1_total_pregnent"></td>
                                        <td class="v_field" id="1_total_live_birth_tot"></td>
                                        <td class="v_field" id="1_total_husband_foreign"></td>
                                    </tr>

                                    <tr>
                                        <td class="t_field rotate" rowspan="5">২০-২৯</td>
                                        <td class="t_field">০</td>
                                        <td class="v_field" id="2_0_pill_normal"></td>
                                        <td class="v_field" id="2_0_pill_after_delivery"></td>
                                        <td class="v_field" id="2_0_condom_normal"></td>
                                        <td class="v_field" id="2_0_condom_after_delivery"></td>
                                        <td class="v_field" id="2_0_inject_normal"></td>
                                        <td class="v_field" id="2_0_inject_after_delivery"></td>
                                        <td class="v_field" id="2_0_iud_normal"></td>
                                        <td class="v_field" id="2_0_iud_after_delivery"></td>
                                        <td class="v_field" id="2_0_implant_normal"></td>
                                        <td class="v_field" id="2_0_implant_after_delivery"></td>
                                        <td class="v_field" id="2_0_permanent_man_normal"></td>
                                        <td class="v_field" id="2_0_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="2_0_permanent_woman_normal"></td>
                                        <td class="v_field" id="2_0_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="2_0_method_all"></td>
                                        <td class="v_field" id="2_0_method_not_taken"></td>
                                        <td class="v_field" id="2_0_pregnent"></td>
                                        <td class="v_field block" id="2_0_live_birth_tot"></td>
                                        <td class="v_field" id="2_0_husband_foreign"></td> 
                                    </tr>
                                    <tr>
                                        <td class="t_field">১</td>
                                        <td class="v_field" id="2_1_pill_normal"></td>
                                        <td class="v_field" id="2_1_pill_after_delivery"></td>
                                        <td class="v_field" id="2_1_condom_normal"></td>
                                        <td class="v_field" id="2_1_condom_after_delivery"></td>
                                        <td class="v_field" id="2_1_inject_normal"></td>
                                        <td class="v_field" id="2_1_inject_after_delivery"></td>
                                        <td class="v_field" id="2_1_iud_normal"></td>
                                        <td class="v_field" id="2_1_iud_after_delivery"></td>
                                        <td class="v_field" id="2_1_implant_normal"></td>
                                        <td class="v_field" id="2_1_implant_after_delivery"></td>
                                        <td class="v_field" id="2_1_permanent_man_normal"></td>
                                        <td class="v_field" id="2_1_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="2_1_permanent_woman_normal"></td>
                                        <td class="v_field" id="2_1_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="2_1_method_all"></td>
                                        <td class="v_field" id="2_1_method_not_taken"></td>
                                        <td class="v_field" id="2_1_pregnent"></td>
                                        <td class="v_field" id="2_1_live_birth_tot"></td>
                                        <td class="v_field" id="2_1_husband_foreign"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">২</td>
                                        <td class="v_field" id="2_2_pill_normal"></td>
                                        <td class="v_field" id="2_2_pill_after_delivery"></td>
                                        <td class="v_field" id="2_2_condom_normal"></td>
                                        <td class="v_field" id="2_2_condom_after_delivery"></td>
                                        <td class="v_field" id="2_2_inject_normal"></td>
                                        <td class="v_field" id="2_2_inject_after_delivery"></td>
                                        <td class="v_field" id="2_2_iud_normal"></td>
                                        <td class="v_field" id="2_2_iud_after_delivery"></td>
                                        <td class="v_field" id="2_2_implant_normal"></td>
                                        <td class="v_field" id="2_2_implant_after_delivery"></td>
                                        <td class="v_field" id="2_2_permanent_man_normal"></td>
                                        <td class="v_field" id="2_2_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="2_2_permanent_woman_normal"></td>
                                        <td class="v_field" id="2_2_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="2_2_method_all"></td>
                                        <td class="v_field" id="2_2_method_not_taken"></td>
                                        <td class="v_field" id="2_2_pregnent"></td>
                                        <td class="v_field" id="2_2_live_birth_tot"></td>
                                        <td class="v_field" id="2_2_husband_foreign"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">৩+</td>
                                        <td class="v_field" id="2_3_pill_normal"></td>
                                        <td class="v_field" id="2_3_pill_after_delivery"></td>
                                        <td class="v_field" id="2_3_condom_normal"></td>
                                        <td class="v_field" id="2_3_condom_after_delivery"></td>
                                        <td class="v_field" id="2_3_inject_normal"></td>
                                        <td class="v_field" id="2_3_inject_after_delivery"></td>
                                        <td class="v_field" id="2_3_iud_normal"></td>
                                        <td class="v_field" id="2_3_iud_after_delivery"></td>
                                        <td class="v_field" id="2_3_implant_normal"></td>
                                        <td class="v_field" id="2_3_implant_after_delivery"></td>
                                        <td class="v_field" id="2_3_permanent_man_normal"></td>
                                        <td class="v_field" id="2_3_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="2_3_permanent_woman_normal"></td>
                                        <td class="v_field" id="2_3_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="2_3_method_all"></td>
                                        <td class="v_field" id="2_3_method_not_taken"></td>
                                        <td class="v_field" id="2_3_pregnent"></td>
                                        <td class="v_field" id="2_3_live_birth_tot"></td>
                                        <td class="v_field" id="2_3_husband_foreign"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">মোট</td>
                                        <td class="v_field" id="2_total_pill_normal"></td>
                                        <td class="v_field" id="2_total_pill_after_delivery"></td>
                                        <td class="v_field" id="2_total_condom_normal"></td>
                                        <td class="v_field" id="2_total_condom_after_delivery"></td>
                                        <td class="v_field" id="2_total_inject_normal"></td>
                                        <td class="v_field" id="2_total_inject_after_delivery"></td>
                                        <td class="v_field" id="2_total_iud_normal"></td>
                                        <td class="v_field" id="2_total_iud_after_delivery"></td>
                                        <td class="v_field" id="2_total_implant_normal"></td>
                                        <td class="v_field" id="2_total_implant_after_delivery"></td>
                                        <td class="v_field" id="2_total_permanent_man_normal"></td>
                                        <td class="v_field" id="2_total_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="2_total_permanent_woman_normal"></td>
                                        <td class="v_field" id="2_total_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="2_total_method_all"></td>
                                        <td class="v_field" id="2_total_method_not_taken"></td>
                                        <td class="v_field" id="2_total_pregnent"></td>
                                        <td class="v_field" id="2_total_live_birth_tot"></td>
                                        <td class="v_field" id="2_total_husband_foreign"></td>
                                    </tr>

                                    <tr>
                                        <td class="t_field rotate" rowspan="5">৩০-৩৯</td>
                                        <td class="t_field">০</td>
                                        <td class="v_field" id="3_0_pill_normal"></td>
                                        <td class="v_field" id="3_0_pill_after_delivery"></td>
                                        <td class="v_field" id="3_0_condom_normal"></td>
                                        <td class="v_field" id="3_0_condom_after_delivery"></td>
                                        <td class="v_field" id="3_0_inject_normal"></td>
                                        <td class="v_field" id="3_0_inject_after_delivery"></td>
                                        <td class="v_field" id="3_0_iud_normal"></td>
                                        <td class="v_field" id="3_0_iud_after_delivery"></td>
                                        <td class="v_field" id="3_0_implant_normal"></td>
                                        <td class="v_field" id="3_0_implant_after_delivery"></td>
                                        <td class="v_field" id="3_0_permanent_man_normal"></td>
                                        <td class="v_field" id="3_0_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="3_0_permanent_woman_normal"></td>
                                        <td class="v_field" id="3_0_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="3_0_method_all"></td>
                                        <td class="v_field" id="3_0_method_not_taken"></td>
                                        <td class="v_field" id="3_0_pregnent"></td>
                                        <td class="v_field block" id="3_0_live_birth_tot"></td>
                                        <td class="v_field" id="3_0_husband_foreign"></td> 
                                    </tr>
                                    <tr>
                                        <td class="t_field">১</td>
                                        <td class="v_field" id="3_1_pill_normal"></td>
                                        <td class="v_field" id="3_1_pill_after_delivery"></td>
                                        <td class="v_field" id="3_1_condom_normal"></td>
                                        <td class="v_field" id="3_1_condom_after_delivery"></td>
                                        <td class="v_field" id="3_1_inject_normal"></td>
                                        <td class="v_field" id="3_1_inject_after_delivery"></td>
                                        <td class="v_field" id="3_1_iud_normal"></td>
                                        <td class="v_field" id="3_1_iud_after_delivery"></td>
                                        <td class="v_field" id="3_1_implant_normal"></td>
                                        <td class="v_field" id="3_1_implant_after_delivery"></td>
                                        <td class="v_field" id="3_1_permanent_man_normal"></td>
                                        <td class="v_field" id="3_1_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="3_1_permanent_woman_normal"></td>
                                        <td class="v_field" id="3_1_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="3_1_method_all"></td>
                                        <td class="v_field" id="3_1_method_not_taken"></td>
                                        <td class="v_field" id="3_1_pregnent"></td>
                                        <td class="v_field" id="3_1_live_birth_tot"></td>
                                        <td class="v_field" id="3_1_husband_foreign"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">২</td>
                                        <td class="v_field" id="3_2_pill_normal"></td>
                                        <td class="v_field" id="3_2_pill_after_delivery"></td>
                                        <td class="v_field" id="3_2_condom_normal"></td>
                                        <td class="v_field" id="3_2_condom_after_delivery"></td>
                                        <td class="v_field" id="3_2_inject_normal"></td>
                                        <td class="v_field" id="3_2_inject_after_delivery"></td>
                                        <td class="v_field" id="3_2_iud_normal"></td>
                                        <td class="v_field" id="3_2_iud_after_delivery"></td>
                                        <td class="v_field" id="3_2_implant_normal"></td>
                                        <td class="v_field" id="3_2_implant_after_delivery"></td>
                                        <td class="v_field" id="3_2_permanent_man_normal"></td>
                                        <td class="v_field" id="3_2_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="3_2_permanent_woman_normal"></td>
                                        <td class="v_field" id="3_2_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="3_2_method_all"></td>
                                        <td class="v_field" id="3_2_method_not_taken"></td>
                                        <td class="v_field" id="3_2_pregnent"></td>
                                        <td class="v_field" id="3_2_live_birth_tot"></td>
                                        <td class="v_field" id="3_2_husband_foreign"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">৩+</td>
                                        <td class="v_field" id="3_3_pill_normal"></td>
                                        <td class="v_field" id="3_3_pill_after_delivery"></td>
                                        <td class="v_field" id="3_3_condom_normal"></td>
                                        <td class="v_field" id="3_3_condom_after_delivery"></td>
                                        <td class="v_field" id="3_3_inject_normal"></td>
                                        <td class="v_field" id="3_3_inject_after_delivery"></td>
                                        <td class="v_field" id="3_3_iud_normal"></td>
                                        <td class="v_field" id="3_3_iud_after_delivery"></td>
                                        <td class="v_field" id="3_3_implant_normal"></td>
                                        <td class="v_field" id="3_3_implant_after_delivery"></td>
                                        <td class="v_field" id="3_3_permanent_man_normal"></td>
                                        <td class="v_field" id="3_3_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="3_3_permanent_woman_normal"></td>
                                        <td class="v_field" id="3_3_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="3_3_method_all"></td>
                                        <td class="v_field" id="3_3_method_not_taken"></td>
                                        <td class="v_field" id="3_3_pregnent"></td>
                                        <td class="v_field" id="3_3_live_birth_tot"></td>
                                        <td class="v_field" id="3_3_husband_foreign"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">মোট</td>
                                        <td class="v_field" id="3_total_pill_normal"></td>
                                        <td class="v_field" id="3_total_pill_after_delivery"></td>
                                        <td class="v_field" id="3_total_condom_normal"></td>
                                        <td class="v_field" id="3_total_condom_after_delivery"></td>
                                        <td class="v_field" id="3_total_inject_normal"></td>
                                        <td class="v_field" id="3_total_inject_after_delivery"></td>
                                        <td class="v_field" id="3_total_iud_normal"></td>
                                        <td class="v_field" id="3_total_iud_after_delivery"></td>
                                        <td class="v_field" id="3_total_implant_normal"></td>
                                        <td class="v_field" id="3_total_implant_after_delivery"></td>
                                        <td class="v_field" id="3_total_permanent_man_normal"></td>
                                        <td class="v_field" id="3_total_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="3_total_permanent_woman_normal"></td>
                                        <td class="v_field" id="3_total_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="3_total_method_all"></td>
                                        <td class="v_field" id="3_total_method_not_taken"></td>
                                        <td class="v_field" id="3_total_pregnent"></td>
                                        <td class="v_field" id="3_total_live_birth_tot"></td>
                                        <td class="v_field" id="3_total_husband_foreign"></td>
                                    </tr>

                                    <tr>
                                        <td class="t_field rotate" rowspan="5">৪০-৪৯</td>
                                        <td class="t_field">০</td>
                                        <td class="v_field" id="4_0_pill_normal"></td>
                                        <td class="v_field" id="4_0_pill_after_delivery"></td>
                                        <td class="v_field" id="4_0_condom_normal"></td>
                                        <td class="v_field" id="4_0_condom_after_delivery"></td>
                                        <td class="v_field" id="4_0_inject_normal"></td>
                                        <td class="v_field" id="4_0_inject_after_delivery"></td>
                                        <td class="v_field" id="4_0_iud_normal"></td>
                                        <td class="v_field" id="4_0_iud_after_delivery"></td>
                                        <td class="v_field" id="4_0_implant_normal"></td>
                                        <td class="v_field" id="4_0_implant_after_delivery"></td>
                                        <td class="v_field" id="4_0_permanent_man_normal"></td>
                                        <td class="v_field" id="4_0_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="4_0_permanent_woman_normal"></td>
                                        <td class="v_field" id="4_0_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="4_0_method_all"></td>
                                        <td class="v_field" id="4_0_method_not_taken"></td>
                                        <td class="v_field" id="4_0_pregnent"></td>
                                        <td class="v_field block" id="4_0_live_birth_tot"></td>
                                        <td class="v_field" id="4_0_husband_foreign"></td> 
                                    </tr>
                                    <tr>
                                        <td class="t_field">১</td>
                                        <td class="v_field" id="4_1_pill_normal"></td>
                                        <td class="v_field" id="4_1_pill_after_delivery"></td>
                                        <td class="v_field" id="4_1_condom_normal"></td>
                                        <td class="v_field" id="4_1_condom_after_delivery"></td>
                                        <td class="v_field" id="4_1_inject_normal"></td>
                                        <td class="v_field" id="4_1_inject_after_delivery"></td>
                                        <td class="v_field" id="4_1_iud_normal"></td>
                                        <td class="v_field" id="4_1_iud_after_delivery"></td>
                                        <td class="v_field" id="4_1_implant_normal"></td>
                                        <td class="v_field" id="4_1_implant_after_delivery"></td>
                                        <td class="v_field" id="4_1_permanent_man_normal"></td>
                                        <td class="v_field" id="4_1_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="4_1_permanent_woman_normal"></td>
                                        <td class="v_field" id="4_1_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="4_1_method_all"></td>
                                        <td class="v_field" id="4_1_method_not_taken"></td>
                                        <td class="v_field" id="4_1_pregnent"></td>
                                        <td class="v_field" id="4_1_live_birth_tot"></td>
                                        <td class="v_field" id="4_1_husband_foreign"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">২</td>
                                        <td class="v_field" id="4_2_pill_normal"></td>
                                        <td class="v_field" id="4_2_pill_after_delivery"></td>
                                        <td class="v_field" id="4_2_condom_normal"></td>
                                        <td class="v_field" id="4_2_condom_after_delivery"></td>
                                        <td class="v_field" id="4_2_inject_normal"></td>
                                        <td class="v_field" id="4_2_inject_after_delivery"></td>
                                        <td class="v_field" id="4_2_iud_normal"></td>
                                        <td class="v_field" id="4_2_iud_after_delivery"></td>
                                        <td class="v_field" id="4_2_implant_normal"></td>
                                        <td class="v_field" id="4_2_implant_after_delivery"></td>
                                        <td class="v_field" id="4_2_permanent_man_normal"></td>
                                        <td class="v_field" id="4_2_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="4_2_permanent_woman_normal"></td>
                                        <td class="v_field" id="4_2_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="4_2_method_all"></td>
                                        <td class="v_field" id="4_2_method_not_taken"></td>
                                        <td class="v_field" id="4_2_pregnent"></td>
                                        <td class="v_field" id="4_2_live_birth_tot"></td>
                                        <td class="v_field" id="4_2_husband_foreign"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">৩+</td>
                                        <td class="v_field" id="4_3_pill_normal"></td>
                                        <td class="v_field" id="4_3_pill_after_delivery"></td>
                                        <td class="v_field" id="4_3_condom_normal"></td>
                                        <td class="v_field" id="4_3_condom_after_delivery"></td>
                                        <td class="v_field" id="4_3_inject_normal"></td>
                                        <td class="v_field" id="4_3_inject_after_delivery"></td>
                                        <td class="v_field" id="4_3_iud_normal"></td>
                                        <td class="v_field" id="4_3_iud_after_delivery"></td>
                                        <td class="v_field" id="4_3_implant_normal"></td>
                                        <td class="v_field" id="4_3_implant_after_delivery"></td>
                                        <td class="v_field" id="4_3_permanent_man_normal"></td>
                                        <td class="v_field" id="4_3_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="4_3_permanent_woman_normal"></td>
                                        <td class="v_field" id="4_3_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="4_3_method_all"></td>
                                        <td class="v_field" id="4_3_method_not_taken"></td>
                                        <td class="v_field" id="4_3_pregnent"></td>
                                        <td class="v_field" id="4_3_live_birth_tot"></td>
                                        <td class="v_field" id="4_3_husband_foreign"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">মোট</td>
                                        <td class="v_field" id="4_total_pill_normal"></td>
                                        <td class="v_field" id="4_total_pill_after_delivery"></td>
                                        <td class="v_field" id="4_total_condom_normal"></td>
                                        <td class="v_field" id="4_total_condom_after_delivery"></td>
                                        <td class="v_field" id="4_total_inject_normal"></td>
                                        <td class="v_field" id="4_total_inject_after_delivery"></td>
                                        <td class="v_field" id="4_total_iud_normal"></td>
                                        <td class="v_field" id="4_total_iud_after_delivery"></td>
                                        <td class="v_field" id="4_total_implant_normal"></td>
                                        <td class="v_field" id="4_total_implant_after_delivery"></td>
                                        <td class="v_field" id="4_total_permanent_man_normal"></td>
                                        <td class="v_field" id="4_total_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="4_total_permanent_woman_normal"></td>
                                        <td class="v_field" id="4_total_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="4_total_method_all"></td>
                                        <td class="v_field" id="4_total_method_not_taken"></td>
                                        <td class="v_field" id="4_total_pregnent"></td>
                                        <td class="v_field" id="4_total_live_birth_tot"></td>
                                        <td class="v_field" id="4_total_husband_foreign"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field rotate" rowspan="5">সর্বমোট</td>
                                        <td class="t_field">০</td>
                                        <td class="v_field" id="total_0_pill_normal"></td>
                                        <td class="v_field" id="total_0_pill_after_delivery"></td>
                                        <td class="v_field" id="total_0_condom_normal"></td>
                                        <td class="v_field" id="total_0_condom_after_delivery"></td>
                                        <td class="v_field" id="total_0_inject_normal"></td>
                                        <td class="v_field" id="total_0_inject_after_delivery"></td>
                                        <td class="v_field" id="total_0_iud_normal"></td>
                                        <td class="v_field" id="total_0_iud_after_delivery"></td>
                                        <td class="v_field" id="total_0_implant_normal"></td>
                                        <td class="v_field" id="total_0_implant_after_delivery"></td>
                                        <td class="v_field" id="total_0_permanent_man_normal"></td>
                                        <td class="v_field" id="total_0_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="total_0_permanent_woman_normal"></td>
                                        <td class="v_field" id="total_0_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="total_0_method_all"></td>
                                        <td class="v_field" id="total_0_method_not_taken"></td>
                                        <td class="v_field" id="total_0_pregnent"></td>
                                        <td class="v_field block" id="total_0_live_birth_tot"></td>
                                        <td class="v_field" id="total_0_husband_foreign"></td> 
                                    </tr>
                                    <tr>
                                        <td class="t_field">১</td>
                                        <td class="v_field" id="total_1_pill_normal"></td>
                                        <td class="v_field" id="total_1_pill_after_delivery"></td>
                                        <td class="v_field" id="total_1_condom_normal"></td>
                                        <td class="v_field" id="total_1_condom_after_delivery"></td>
                                        <td class="v_field" id="total_1_inject_normal"></td>
                                        <td class="v_field" id="total_1_inject_after_delivery"></td>
                                        <td class="v_field" id="total_1_iud_normal"></td>
                                        <td class="v_field" id="total_1_iud_after_delivery"></td>
                                        <td class="v_field" id="total_1_implant_normal"></td>
                                        <td class="v_field" id="total_1_implant_after_delivery"></td>
                                        <td class="v_field" id="total_1_permanent_man_normal"></td>
                                        <td class="v_field" id="total_1_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="total_1_permanent_woman_normal"></td>
                                        <td class="v_field" id="total_1_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="total_1_method_all"></td>
                                        <td class="v_field" id="total_1_method_not_taken"></td>
                                        <td class="v_field" id="total_1_pregnent"></td>
                                        <td class="v_field" id="total_1_live_birth_tot"></td>
                                        <td class="v_field" id="total_1_husband_foreign"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">২</td>
                                        <td class="v_field" id="total_2_pill_normal"></td>
                                        <td class="v_field" id="total_2_pill_after_delivery"></td>
                                        <td class="v_field" id="total_2_condom_normal"></td>
                                        <td class="v_field" id="total_2_condom_after_delivery"></td>
                                        <td class="v_field" id="total_2_inject_normal"></td>
                                        <td class="v_field" id="total_2_inject_after_delivery"></td>
                                        <td class="v_field" id="total_2_iud_normal"></td>
                                        <td class="v_field" id="total_2_iud_after_delivery"></td>
                                        <td class="v_field" id="total_2_implant_normal"></td>
                                        <td class="v_field" id="total_2_implant_after_delivery"></td>
                                        <td class="v_field" id="total_2_permanent_man_normal"></td>
                                        <td class="v_field" id="total_2_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="total_2_permanent_woman_normal"></td>
                                        <td class="v_field" id="total_2_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="total_2_method_all"></td>
                                        <td class="v_field" id="total_2_method_not_taken"></td>
                                        <td class="v_field" id="total_2_pregnent"></td>
                                        <td class="v_field" id="total_2_live_birth_tot"></td>
                                        <td class="v_field" id="total_2_husband_foreign"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">৩+</td>
                                        <td class="v_field" id="total_3_pill_normal"></td>
                                        <td class="v_field" id="total_3_pill_after_delivery"></td>
                                        <td class="v_field" id="total_3_condom_normal"></td>
                                        <td class="v_field" id="total_3_condom_after_delivery"></td>
                                        <td class="v_field" id="total_3_inject_normal"></td>
                                        <td class="v_field" id="total_3_inject_after_delivery"></td>
                                        <td class="v_field" id="total_3_iud_normal"></td>
                                        <td class="v_field" id="total_3_iud_after_delivery"></td>
                                        <td class="v_field" id="total_3_implant_normal"></td>
                                        <td class="v_field" id="total_3_implant_after_delivery"></td>
                                        <td class="v_field" id="total_3_permanent_man_normal"></td>
                                        <td class="v_field" id="total_3_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="total_3_permanent_woman_normal"></td>
                                        <td class="v_field" id="total_3_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="total_3_method_all"></td>
                                        <td class="v_field" id="total_3_method_not_taken"></td>
                                        <td class="v_field" id="total_3_pregnent"></td>
                                        <td class="v_field" id="total_3_live_birth_tot"></td>
                                        <td class="v_field" id="total_3_husband_foreign"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">মোট</td>
                                        <td class="v_field" id="total_total_pill_normal"></td>
                                        <td class="v_field" id="total_total_pill_after_delivery"></td>
                                        <td class="v_field" id="total_total_condom_normal"></td>
                                        <td class="v_field" id="total_total_condom_after_delivery"></td>
                                        <td class="v_field" id="total_total_inject_normal"></td>
                                        <td class="v_field" id="total_total_inject_after_delivery"></td>
                                        <td class="v_field" id="total_total_iud_normal"></td>
                                        <td class="v_field" id="total_total_iud_after_delivery"></td>
                                        <td class="v_field" id="total_total_implant_normal"></td>
                                        <td class="v_field" id="total_total_implant_after_delivery"></td>
                                        <td class="v_field" id="total_total_permanent_man_normal"></td>
                                        <td class="v_field" id="total_total_permanent_man_after_delivery"></td>
                                        <td class="v_field" id="total_total_permanent_woman_normal"></td>
                                        <td class="v_field" id="total_total_permanent_woman_after_delivery"></td>
                                        <td class="v_field" id="total_total_method_all"></td>
                                        <td class="v_field" id="total_total_method_not_taken"></td>
                                        <td class="v_field" id="total_total_pregnent"></td>
                                        <td class="v_field" id="total_total_live_birth_tot"></td>
                                        <td class="v_field" id="total_total_husband_foreign"></td>
                                    </tr>
                                </tbody>
                            </table>

                        </div>
                    </div> 
                </div><br/>
            </div> 
        </div>
    </div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
