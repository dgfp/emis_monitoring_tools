<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla.js"></script>
<style>
    table{
        font-family: SolaimanLipi;
        font-size: 12px;
    }
    table, th, td {
        border: 1px solid black;
        border-collapse: collapse;
    }
</style>
<script>
</script>
<section class="content-header">
    <h1 id="pageTitle"><span style="color:#4fef2f;"><i class="fa fa-check-circle" aria-hidden="true"></i></span> Daily tally sheet for FWA</h1>
</section>
<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <%@include file="/WEB-INF/jspf/mis1AreaBangla.jspf" %>
    <!--------------------------------------------------------------------------------Data Table Goes Here-------------------------------------------------------------------------------->  
    <div class="box box-primary full-screen">
        <div class="box-header with-border">
            <div class="box-tools pull-right" style="margin-top: -10px;">
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>

        <div class="box-body">

            <p> <strong> ক) খানা পরিদর্শনে দিনগুলোঃ </strong> </p>


            <div class="table-responsive">
                <div  class="row">

                    <div class="col-md-12">
                        <div  class="row">
                            <div class="col-md-12">
                                <table class="mis_table" style="width: 1620px">
                                    <colgroup>
                                        <col style="width: 70px !important; text-align: left;">
                                        <col style="width: 40px !important;">
                                        <col style="width: 60px !important;">
                                        <col style="width: 560px !important;">


                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">

                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                        <col style="width: 153px !important;">
                                    </colgroup>
                                    <tr id="visitMonthColumn">
                                        <td colspan="4" class="center">পরিদর্শনের তারিখ ( দিন ও মাস লিখুন )</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td class="center">সরকারি মোট</td>
                                        <td class="center">ক্রয়সূত্র মোট</td>
                                        <td class="center">সর্বমোট</td>
                                    </tr>

                                    <!--1st start-->
                                    <tr id="r_pill_old">
                                        <td  rowspan="32" class="center"><span style="width:40px" class="r-v"> পরিবার পরিকল্পনা পদ্ধতি গ্রহণ সংক্রান্ত তথ্যের হিসাব</span></td>
                                        <td rowspan="5" class="rotate center">খাবার বড়ি</td>
                                        <td colspan="2">পুরাতন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="old_pill_govt_total_1"></td>
                                        <td id="old_pill_purchage_1"></td>
                                        <td id="old_pill_total_1"></td>
                                    </tr>
                                    <tr id="r_pill_new">
                                        <td colspan="2">নতুন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="new_pill_govt_total_1"></td>
                                        <td id="new_pill_purchage_1"></td>
                                        <td id="new_pill_total_1"></td>
                                    </tr>
                                    <tr id="r_pill_total">
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
                                        <td id="total_pill_govt_total_1"></td>
                                        <td id="total_pill_purchage_1"></td>
                                        <td id="total_pill_total_1"></td>
                                    </tr>
                                    <tr id="r_pill_left_no_method">
                                        <td rowspan="2" colspan="1">ছেড়ে দিয়েছে</td>
                                        <td colspan="1">কোন পদ্ধতি নেয়নি</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="left_pill_no_method_govt_total_1"></td>
                                        <td id="left_pill_no_method_purchage_1"></td>
                                        <td id="left_pill_no_method_total_1"></td>
                                    </tr>
                                    <tr id="r_pill_left_oth_method">
                                        <td colspan="1">অন্য পদ্ধতি নিয়েছে</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="left_pill_oth_method_govt_total_1"></td>
                                        <td id="left_pill_oth_method_purchage_1"></td>
                                        <td id="left_pill_oth_method_total_1"></td>
                                    </tr>
                                    <!--1st END-->
                                    <!--2nd start-->
                                    <tr id="r_condom_old">
                                        <td rowspan="5" class="rotate center">কনডম</td>
                                        <td colspan="2">পুরাতন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="old_condom_govt_total_1"></td>
                                        <td id="old_condom_purchage_1"></td>
                                        <td id="old_condom_total_1"></td>
                                    </tr>
                                    <tr id="r_condom_new">
                                        <td colspan="2">নতুন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="new_condom_govt_total_1"></td>
                                        <td id="new_condom_purchage_1"></td>
                                        <td id="new_condom_total_1"></td>
                                    </tr>
                                    <tr id="r_condom_total">
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
                                        <td id="total_condom_govt_total_1"></td>
                                        <td id="total_condom_purchage_1"></td>
                                        <td id="total_condom_total_1"></td>
                                    </tr>
                                    <tr id="r_condom_left_no_method">
                                        <td rowspan="2" >ছেড়ে দিয়েছে</td>
                                        <td>কোন পদ্ধতি নেয়নি</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="left_condom_no_method_govt_total_1"></td>
                                        <td id="left_condom_no_method_purchage_1"></td>
                                        <td id="left_condom_no_method_total_1"></td>
                                    </tr>
                                    <tr id="r_condom_left_oth_method">
                                        <td>অন্য পদ্ধতি নিয়েছে</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="left_condom_oth_method_govt_total_1"></td>
                                        <td id="left_condom_oth_method_purchage_1"></td>
                                        <td id="left_condom_oth_method_total_1"></td>
                                    </tr>
                                    <!--2nd END-->

                                    <!--3rd start-->
                                    <tr id="r_injectable_old">
                                        <td rowspan="5" class="rotate center">ইনজেকটেবল</td>
                                        <td colspan="2">পুরাতন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="old_inject_govt_total_1"></td>
                                        <td id="old_inject_purchage_1"></td>
                                        <td id="old_inject_total_1"></td>
                                    </tr>
                                    <tr id="r_injectable_new">
                                        <td colspan="2">নতুন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="new_inject_govt_total_1"></td>
                                        <td id="new_inject_purchage_1"></td>
                                        <td id="new_inject_total_1"></td>
                                    </tr>
                                    <tr id="r_injectable_total">
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
                                        <td id="total_inject_govt_total_1"></td>
                                        <td id="total_inject_purchage_1"></td>
                                        <td id="total_inject_total_1"></td>
                                    </tr>
                                    <tr id="r_injectable_left_no_method">
                                        <td rowspan="2">ছেড়ে দিয়েছে</td>
                                        <td>কোন পদ্ধতি নেয়নি</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="left_inject_no_method_govt_total_1"></td>
                                        <td id="left_inject_no_method_purchage_1"></td>
                                        <td id="left_inject_no_method_total_1"></td>
                                    </tr>
                                    <tr id="r_injectable_left_oth_method">
                                        <td>অন্য পদ্ধতি নিয়েছে</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="left_inject_oth_method_govt_total_1"></td>
                                        <td id="left_inject_oth_method_purchage_1"></td>
                                        <td id="left_inject_oth_method_total_1"></td>
                                    </tr>
                                    <!--3rd END-->

                                    <!--4th iud start-->
                                    <tr id="r_iud_old">
                                        <td rowspan="5" class="rotate center">আই ইউ ডি</td>
                                        <td colspan="2">পুরাতন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="old_iud_govt_total_1"></td>
                                        <td id="old_iud_purchage_1"></td>
                                        <td id="old_iud_total_1"></td>
                                    </tr>
                                    <tr id="r_iud_new">
                                        <td colspan="2">নতুন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="new_iud_govt_total_1"></td>
                                        <td id="new_iud_purchage_1"></td>
                                        <td id="new_iud_total_1"></td>
                                    </tr>
                                    <tr id="r_iud_total">
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
                                        <td id="total_iud_govt_total_1"></td>
                                        <td id="total_iud_purchage_1"></td>
                                        <td id="total_iud_total_1"></td>
                                    </tr>
                                    <tr id="r_iud_left_no_method">
                                        <td rowspan="2" >ছেড়ে দিয়েছে</td>
                                        <td>কোন পদ্ধতি নেয়নি</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="left_iud_no_method_govt_total_1"></td>
                                        <td id="left_iud_no_method_purchage_1"></td>
                                        <td id="left_iud_no_method_total_1"></td>
                                    </tr>
                                    <tr  id="r_iud_left_oth_method">
                                        <td>অন্য পদ্ধতি নিয়েছে</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="left_iud_oth_method_govt_total_1"></td>
                                        <td id="left_iud_oth_method_purchage_1"></td>
                                        <td id="left_iud_oth_method_total_1"></td>
                                    </tr>
                                    <!--4th END-->

                                    <!--5th implant start-->
                                    <tr id="r_implant_old">
                                        <td rowspan="5" class="rotate center">ইমপ্ল্যান্ট</td>
                                        <td colspan="2">পুরাতন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="old_implant_govt_total_1"></td>
                                        <td id="old_implant_purchage_1"></td>
                                        <td id="old_implant_total_1"></td>
                                    </tr>
                                    <tr id="r_implant_new">
                                        <td colspan="2">নতুন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="new_implant_govt_total_1"></td>
                                        <td id="new_implant_purchage_1"></td>
                                        <td id="new_implant_total_1"></td>
                                    </tr>
                                    <tr id="r_implant_total">
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
                                        <td id="total_implant_govt_total_1"></td>
                                        <td id="total_implant_purchage_1"></td>
                                        <td id="total_implant_total_1"></td>
                                    </tr>
                                    <tr id="r_implant_left_no_method">
                                        <td rowspan="2" >ছেড়ে দিয়েছে</td>
                                        <td >কোন পদ্ধতি নেয়নি</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="left_implant_no_method_govt_total_1"></td>
                                        <td id="left_implant_no_method_purchage_1"></td>
                                        <td id="left_implant_no_method_total_1"></td>
                                    </tr>
                                    <tr id="r_implant_left_oth_method">
                                        <td >অন্য পদ্ধতি নিয়েছে</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="left_implant_oth_method_govt_total_1"></td>
                                        <td id="left_implant_oth_method_purchage_1"></td>
                                        <td id="left_implant_oth_method_total_1"></td>
                                    </tr>
                                    <!--5th END-->

                                    <!--6th permanent start-->
                                    <tr id="r_permanent_man_old">
                                        <td rowspan="6" class="rotate center">স্থায়ী পদ্ধতি</td>
                                        <td rowspan="3">পুরুষ</td>
                                        <td >পুরাতন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="old_permanent_man_govt_total_1"></td>
                                        <td id="old_permanent_man_purchage_1"></td>
                                        <td id="old_permanent_man_total_1"></td>
                                    </tr>
                                    <tr id="r_permanent_man_new">
                                        <td >নতুন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="new_permanent_man_govt_total_1"></td>
                                        <td id="new_permanent_man_purchage_1"></td>
                                        <td id="new_permanent_man_total_1"></td>
                                    </tr>
                                    <tr id="r_permanent_man_total">
                                        <td >মোট</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="total_permanent_man_govt_total_1"></td>
                                        <td id="total_permanent_man_purchage_1"></td>
                                        <td id="total_permanent_man_total_1"></td>
                                    </tr>
                                    <tr id="r_permanent_woman_old">
                                        <td rowspan="3" >মহিলা</td>
                                        <td >পুরাতন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="old_permanent_woman_govt_total_1"></td>
                                        <td id="old_permanent_woman_purchage_1"></td>
                                        <td id="old_permanent_woman_total_1"></td>
                                    </tr>
                                    <tr id="r_permanent_woman_new">
                                        <td>নতুন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="new_permanent_woman_govt_total_1"></td>
                                        <td id="new_permanent_woman_purchage_1"></td>
                                        <td id="new_permanent_woman_total_1"></td>
                                    </tr>
                                    <tr id="r_permanent_woman_total"> 
                                        <td>মোট</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="total_permanent_woman_govt_total_1"></td>
                                        <td id="total_permanent_woman_purchage_1"></td>
                                        <td id="total_permanent_woman_total_1"></td>
                                    </tr>
                                    <!--6th END-->

                                    <!--total start-->
                                    <tr id="r_first_total">
                                        <td colspan="3" class="center">সর্বমোট</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="all_total_govt_total_1"></td>
                                        <td id="all_total_purchage_1"></td>
                                        <td id="all_total_total_1"></td>
                                    </tr>

                                    <tr id="r_unit_capable_elco_tot">
                                        <td colspan="4" class="center">মোট সক্ষম দম্পতির সংখ্যা</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td id="total_capable_couple_no_govt_total_1"></td>
                                        <td id="total_capable_couple_no_purchage_1"></td>
                                        <td id="total_capable_couple_no_total_1"></td>
                                    </tr>
                                    <!--------------------------------------------------------Table Break point-------------------------------------------------------------->
                                    <tr>
                                        <td colspan="38" style="border-left-color: #fff!important;border-right-color: #fff!important;">&nbsp;&nbsp;</td>
                                    </tr>
                                    <!--------------------------------------------------------Table Break point END------------------------------------------------------->
                                    <tr id="r_preg_new_fwa">
                                        <td colspan="3" rowspan="3" class="center">গর্ভবতী মহিলার সংখ্যা</td>
                                        <td>নতুন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                    <tr id="r_preg_old_fwa">
                                        <td>পুরাতন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                    <tr id="r_preg_fwa_total">
                                        <td>মোট</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                    <!--END First Row-->
                                    <tr id="r_ref_risky_preg_cnt_fwa">
                                        <td  rowspan="3" class="rotate center">প্রেরণ</td>
                                        <td colspan="3">রেফারকৃত ঝুঁকিপূর্ণ / জটিল গর্ভবতীর সংখ্যা</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                    <tr id="r_send_method">
                                        <td colspan="3">পদ্ধতি নেয়ার জন্য</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                    <tr id="r_sent_side_effect">
                                        <td colspan="3">পার্শ্ব-প্রতিক্রিয়ার জন্য</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                    <tr id="r_mothernutrition">
                                        <td  rowspan="2" class="rotate center">পুষ্টি</td>
                                        <td colspan="3">মা</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                    <tr id="r_childnutrition">
                                        <td colspan="3">শিশু</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                    <tr id="r_child_0_to_less_then_60mon">
                                        <td colspan="4">শিশু (০-৫) বৎসরের নিচে সেবা (সংখ্যা) </td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                    <tr id="r_teenager_health_care">
                                        <td  colspan="4"> কিশোর কিশোরীদের স্বাস্থ্য সেবা (সংখ্যা)</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
                                    <tr id="r_pill_shukhi">
                                        <td rowspan="18" class="rotate center">বিতরণ</td>
                                        <td rowspan="3" colspan="2">খাবার  বড়ি (চক্র)</td>
                                        <td>সুখী</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    <tr>
                                    <tr id="r_pill_apan">
                                        <td colspan="">আপন</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    <tr>
                                    <tr id="r_condom">
                                        <td colspan="3">কনডম (পিস)</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    <tr>
                                    <tr id="r_injectable_vial">
                                        <td rowspan="3" colspan="2">ইনজেকটেবল</td>
                                        <td>ভায়াল</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    <tr>
                                    <tr id="r_injectable_syring">
                                        <td >এডি সিরিঞ্জ</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    <tr>
                                    <tr id="r_ecp">
                                        <td colspan="3">অন্যান্য/ইসিপি (ডোজ)</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    <tr>
                                    <tr id="r_misoprostol">
                                        <td colspan="3">মিসোপ্রোস্টল (ডোজ)</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    <tr>
                                    <tr id="r_sasat">
                                        <td colspan="3">ভিটামিন- মিনারেল পাউডার (স্যাসেট)</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    <tr>
                                    <tr id="r_iron_folic_acid">
                                        <td colspan="3">আয়রন ও ফলিক  এসিড (সংখ্যা)</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    <tr>
                                    <tr id="comments">
                                        <td colspan="4">এফ পি আই এর মন্তব্য ও স্বাক্ষর </td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    <tr>
                                </table><br><br>
                            </div>
                        </div>
                    </div>
                    <!-----------------------------------------------------------------End First Part---------------------------------------------------------->


                    <!-----------------------------------------------------------------Kha---------------------------------------------------------->           
                    <div class="col-md-9">
                        <div class="row">
                            <div class="col-md-4" style="background-color:#f9f9f9;color:#e0e0e0;">
                                <p> <strong> খ) খানা পরিদর্শন ছাড়া  কাজে অন্য ব্যাবহৃত দিনের হিসাবঃ   (তারিখ লিখুন) </strong> </p>
                                <table width="100%" style="height:300px">
                                    <colgroup>
                                        <col style="width: 220px !important; text-align: left;">
                                        <col style="width: 100px !important;">
                                    </colgroup>
                                    <tr>
                                        <td>স্যাটেলাইট ক্লিনিকে গমন</td>
                                        <td id=""></td>
                                    </tr>
                                    <tr>
                                        <td>ইপিআই কেন্দ্রে গমন</td>
                                        <td id=""></td>
                                    </tr>
                                    <tr>
                                        <td id="">কমিউনিটি  ক্লিনিকে গমন</td>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <td>ক্লায়েন্ট নিয়ে গমন</td>
                                        <td id=""></td>
                                    </tr>
                                    <tr>
                                        <td id="">সভায় (মিটিং) গমন</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td id=""> নৈমিত্তিক বা অর্জিত ছুটি ভোগ </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td id="">সরকারী ও সাপ্তাহিক ছুটি ভোগ</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td id="">অন্যান্য</td>
                                        <td></td>
                                    </tr>
                                </table>
                            </div>

                            <!-----------------------------------------------------------------Ga---------------------------------------------------------->                    
                            <div class="col-md-4">   
                                <p><strong>গ) জস্ম ও মৃত্যুর হিসাবঃ <br/> (মাসের শেষে পূরণ করুন)</strong></p>
                                <table width="100%" style="height:300px">
                                    <colgroup>
                                        <col style="width: 60px !important; text-align: left;">
                                        <col style="width: 250px !important;">
                                        <col style="width: 60px !important;">
                                        <col style="width: 60px !important;">

                                    </colgroup>

                                    <tr>
                                        <td colspan="3">মোট জীবিত জন্মের সংখ্যা</td>
                                        <td id="r_tot_live_birth_fwa" class="visited"></td>
                                    </tr>
                                    <tr>
                                        <td rowspan="6">মোট  মৃতের সংখ্যা</td>
                                        <td>০ থেকে ৭ দিন</td>
                                        <td id="r_death_number_less_1yr_0to7days" class="visited"></td>
                                        <td rowspan="6" id="no_of_total_death" class="visited"></td>
                                    </tr>
                                    <tr>
                                        <td>৮ থেকে ২৮ দিন</td>
                                        <td id="r_death_number_less_1yr_8to28days" class="visited"></td>
                                    </tr>
                                    <tr>
                                        <td>২৯ দিন থেকে ১ বৎসর কম</td>
                                        <td id="r_death_number_less_1yr_29dystoless1yr" class="visited"></td>
                                    </tr>
                                    <tr>
                                        <td>১ বৎসর থেকে ৫ বৎসর কম</td>
                                        <td id="r_death_number_1yrto5yr" class="visited"></td>
                                    </tr>
                                    <tr>
                                        <td>মাতৃ মৃত্যু</td>
                                        <td id="r_death_number_maternal_death" class="visited"></td>
                                    </tr>
                                    <tr>
                                        <td>অন্যান্য সকল মৃত্যু</td>
                                        <td id="r_death_number_other_death_fwa" class="visited"></td>
                                    </tr>
                                </table>
                            </div>

                            <!----------------------------------------------------------------Gha--------------------------------------------------------->     
                            <div class="col-md-4" style="background-color:#f9f9f9;color:#e0e0e0;">
                                <p><strong>ঘ) সক্ষম দম্পতি বৃদ্ধি ও হ্রাসের হিসাবঃ<br/> (দম্পতি নম্বর লিখুন)</strong></p>
                                <table width="100%" style="height:300px">
                                    <colgroup>
                                        <col style="width: 60px !important; text-align: left;">
                                        <col style="width: 230px !important;">
                                        <col>

                                    </colgroup>
                                    <tr>
                                        <td rowspan="2">দম্পতি বৃদ্ধির কারণ</td>
                                        <td>বিবাহের কারনে</td>
                                        <td id=""></td>

                                    </tr>
                                    <tr>
                                        <td>অন্য এলাকা থেকে আসার কারণে</td>
                                        <td id=""></td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2">দম্পতি হ্রাসের কারণ</td>
                                        <td>অন্যত্র চলে যাবার কারণে</td>
                                        <td id=""></td>

                                    </tr>
                                    <tr>
                                        <td>বয়স  উত্তীর্ণ / তালাক প্রাপ্ত / মৃত্যু ও অন্যান্য</td>
                                        <td id=""></td>
                                    </tr>

                                </table>
                            </div>
                            <!-----------------------------------------------------------------CAR---------------------------------------------------------->                   
                            <div class="col-md-12">
                                <br/>
                                <table class="table-bordered" style="width: 100%;border:1px solid #000!important;">
                                    <tr>
                                        <td rowspan="2" style="width: 200px;text-align: right;padding: 4px;border-top:1px solid #000!important;border-right:1px solid #fff!important;">&nbsp;&nbsp;ইউনিটে পদ্ধতি গ্রহনকারীর হার (CAR):</td>
                                        <td style="width: 200px;text-align: center;padding: 4px;border-top:1px solid #000!important;border-bottom:1px solid #000!important;border-right:1px solid #fff!important;">ইউনিটের সর্বমোট পদ্ধতি গ্রহণকারী</td>
                                        <td rowspan="2" style="text-align: center;width: 90px;border-top:1px solid #000!important;border-right:1px solid #fff!important;">&nbsp;&#10006; <b>১০০</b>&nbsp;&nbsp;&nbsp;&nbsp;= </td>
                                        <td class="v_field visited" style="width: 60px;text-align: center;padding: 4px;border-top:1px solid #000!important;border-bottom:1px solid #000!important;border-right:1px solid #fff!important;" id="unit_all_one"></td>
                                        <td rowspan="2" style="text-align: left;width: 90px!important;border-top:1px solid #000!important;border-right:1px solid #fff!important;">&nbsp;&#10006; <b>১০০</b>&nbsp;&nbsp;&nbsp;&nbsp;= </td>
                                        <td class="v_field visited"  rowspan="2" style="text-align: left;width: 100px;border-top:1px solid #000!important;" id="r_car"> %</td>
                                    </tr>
                                    <tr>
                                        <td style="width: 200px;text-align: center;padding: 4px;border-right:1px solid #fff!important;">ইউনিটের সর্বমোট সক্ষম দম্পতি</th>
                                        <td class="v_field visited"  id="unit_all_two" style="width: 80;text-align: center;padding: 4px;"></td>
                                    </tr>
                                </table>
                                <br/>
                            </div>
                        </div>
                        <!-----------------------------------------------------------------End First Part---------------------------------------------------------->
                    </div>
                    <div class="col-md-3">
                        <p><strong>ঘ)  ইউনিটে পদ্ধতি গ্রহণকারী, সক্ষম দম্পতি এবং গর্ভবতী মহিলার হিসাবঃ ( মাসের শেষে পূরণ করুন)</strong></p>
                        <table width="100%" style="height:382px">
                            <colgroup>
                                <col style="width: 60px !important; text-align: left;">
                                <col style="width: 80px">
                                <col style="width: 80px">
                            </colgroup>
                            <tr>
                                <td rowspan="3">পদ্ধতি গ্রহণকারীর সংখ্যা</td>
                                <td>চলতি মাসের মোট </td>
                                <td id="r_method_curr_month" class="visited"></td>
                            </tr>
                            <tr>
                                <td>পূর্ববর্তী মাসের মোট</td>
                                <td id="r_method_priv_month" class="visited"></td>
                            </tr>
                            <tr>
                                <td>ইউনিটের সর্বমোট</td>
                                <td id="r_method_unit_all_tot" class="visited"></td>
                            </tr>

                            <tr>
                                <td  rowspan="3"> সক্ষম দম্পতির সংখ্যা</td>
                                <td>চলতি মাসের মোট </td>
                                <td id="r_curr_m_shown_capable_elco_tot" class="visited"></td>
                            </tr>
                            <tr>
                                <td>পূর্ববর্তী মাসের মোট</td>
                                <td id="r_priv_m_shown_capable_elco_tot" class="visited"></td>
                            </tr>
                            <tr>
                                <td>ইউনিটের সর্বমোট</td>
                                <td id="r_unit_capable_elco_tot1" class="visited"></td>
                            </tr>

                            <tr>
                                <td  rowspan="3"> গর্ভবতীর সংখ্যা</td>
                                <td>চলতি মাসের মোট </td>
                                <td id="r_preg_curr_month_fwa" class="visited"></td>
                            </tr>
                            <tr>
                                <td>পূর্ববর্তী মাসের মোট</td>
                                <td id="r_preg_priv_month_fwa" class="visited"></td>
                            </tr>
                            <tr>
                                <td>ইউনিটের সর্বমোট</td>
                                <td id="r_preg_unit_tot_fwa" class="visited"></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

<style type="text/css">
    .tg  {border-collapse:collapse;border-spacing:0;}
    .tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
    .tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
    .tg .tg-glis{font-size:10px}
    .tg .tg-s6z2{text-align:center}
</style>

</div>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>

