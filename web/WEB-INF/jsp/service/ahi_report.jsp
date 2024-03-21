<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/header.jspf" %>

<script>
    $(document).ready(function () {
        $.ajax({
            url: "ahi_report",
            data: {},
            type: "POST",
            success: function (result) {
                var json = JSON.parse(result);
                if (json.length > 0) {
                    $("#r_preg_woman_new_w1").html(json[0].r_preg_woman_new_w1);
                    $("#r_preg_woman_new_w2").html(json[0].r_preg_woman_new_w2);
                    $("#r_preg_woman_new_w3").html(json[0].r_preg_woman_new_w3);
                    $("#r_preg_woman_new_tot").html(json[0].r_preg_woman_new_tot);

                    $("#r_preg_woman_old_w1").html(json[0].r_preg_woman_old_w1);
                    $("#r_preg_woman_old_w2").html(json[0].r_preg_woman_old_w2);
                    $("#r_preg_woman_old_w3").html(json[0].r_preg_woman_old_w3);
                    $("#r_preg_woman_old_tot").html(json[0].r_preg_woman_old_tot);

                    $("#r_preg_woman_tot_w1").html(json[0].r_preg_woman_tot_w1);
                    $("#r_preg_woman_tot_w2").html(json[0].r_preg_woman_tot_w2);
                    $("#r_preg_woman_tot_w3").html(json[0].r_preg_woman_tot_w3);
                    $("#r_preg_woman_tot_tot").html(json[0].r_preg_woman_tot_tot);

                    $("#r_pnc_visit1_w1").html(json[0].r_pnc_visit1_w1);
                    $("#r_pnc_visit1_w2").html(json[0].r_pnc_visit1_w2);
                    $("#r_pnc_visit1_w3").html(json[0].r_pnc_visit1_w3);
                    $("#r_pnc_visit1_tot").html(json[0].r_pnc_visit1_tot);

                    $("#r_pnc_visit2_w1").html(json[0].r_pnc_visit2_w1);
                    $("#r_pnc_visit2_w2").html(json[0].r_pnc_visit2_w2);
                    $("#r_pnc_visit2_w3").html(json[0].r_pnc_visit2_w3);
                    $("#r_pnc_visit2_tot").html(json[0].r_pnc_visit2_tot);

                    $("#r_pnc_visit3_w1").html(json[0].r_pnc_visit3_w1);
                    $("#r_pnc_visit3_w2").html(json[0].r_pnc_visit3_w2);
                    $("#r_pnc_visit3_w3").html(json[0].r_pnc_visit3_w3);
                    $("#r_pnc_visit3_tot").html(json[0].r_pnc_visit3_tot);

                    $("#r_pnc_visit4_w1").html(json[0].r_pnc_visit4_w1);
                    $("#r_pnc_visit4_w2").html(json[0].r_pnc_visit4_w2);
                    $("#r_pnc_visit4_w3").html(json[0].r_pnc_visit4_w3);
                    $("#r_pnc_visit4_tot").html(json[0].r_pnc_visit4_tot);

                    $("#r_preg_iron_folic_acid_anc__w1").html(json[0].r_preg_iron_folic_acid_anc__w1);
                    $("#r_preg_iron_folic_acid_anc__w2").html(json[0].r_preg_iron_folic_acid_anc__w2);
                    $("#r_preg_iron_folic_acid_anc__w3").html(json[0].r_preg_iron_folic_acid_anc__w3);
                    $("#r_preg_iron_folic_acid_anc__tot").html(json[0].r_preg_iron_folic_acid_anc__tot);

                    $("#r_delivery_home_expert_w1").html(json[0].r_delivery_home_expert_w1);
                    $("#r_delivery_home_expert_w2").html(json[0].r_delivery_home_expert_w2);
                    $("#r_delivery_home_expert_w3").html(json[0].r_delivery_home_expert_w3);
                    $("#r_delivery_home_expert_tot").html(json[0].r_delivery_home_expert_tot);

                    $("#r_delivery_home_unexpert_w1").html(json[0].r_delivery_home_unexpert_w1);
                    $("#r_delivery_home_unexpert_w2").html(json[0].r_delivery_home_unexpert_w2);
                    $("#r_delivery_home_unexpert_w3").html(json[0].r_delivery_home_unexpert_w3);
                    $("#r_delivery_home_unexpert_tot").html(json[0].r_delivery_home_unexpert_tot);

                    $("#r_delivery_facility_w1").html(json[0].r_delivery_facility_w1);
                    $("#r_delivery_facility_w2").html(json[0].r_delivery_facility_w2);
                    $("#r_delivery_facility_w3").html(json[0].r_delivery_facility_w3);
                    $("#r_delivery_facility_tot").html(json[0].r_delivery_facility_tot);

                    $("#r_misoprostol_eaten_w1").html(json[0].r_misoprostol_eaten_w1);
                    $("#r_misoprostol_eaten_w2").html(json[0].r_misoprostol_eaten_w2);
                    $("#r_misoprostol_eaten_w3").html(json[0].r_misoprostol_eaten_w3);
                    $("#r_misoprostol_eaten_tot").html(json[0].r_misoprostol_eaten_tot);

                    $("#r_delivery_patern_normal_w1").html(json[0].r_delivery_patern_normal_w1);
                    $("#r_delivery_patern_normal_w2").html(json[0].r_delivery_patern_normal_w2);
                    $("#r_delivery_patern_normal_w3").html(json[0].r_delivery_patern_normal_w3);
                    $("#r_delivery_patern_normal_tot").html(json[0].r_delivery_patern_normal_tot);

                    $("#r_delivery_patern_operation_w1").html(json[0].r_delivery_patern_operation_w1);
                    $("#r_delivery_patern_operation_w2").html(json[0].r_delivery_patern_operation_w2);
                    $("#r_delivery_patern_operation_w3").html(json[0].r_delivery_patern_operation_w3);
                    $("#r_delivery_patern_operation_tot").html(json[0].r_delivery_patern_operation_tot);


                    $("#r_live_birth_w1").html(json[0].r_live_birth_w1);
                    $("#r_live_birth_w2").html(json[0].r_live_birth_w2);
                    $("#r_live_birth_w3").html(json[0].r_live_birth_w3);
                    $("#r_live_birth_tot").html(json[0].r_live_birth_tot);

                    $("#r_birth_less_weight_w1").html(json[0].r_birth_less_weight_w1);
                    $("#r_birth_less_weight_w2").html(json[0].r_birth_less_weight_w2);
                    $("#r_birth_less_weight_w3").html(json[0].r_birth_less_weight_w3);
                    $("#r_birth_less_weight_tot").html(json[0].r_birth_less_weight_tot);

                    $("#r_death_birth_w1").html(json[0].r_death_birth_w1);
                    $("#r_death_birth_w2").html(json[0].r_death_birth_w2);
                    $("#r_death_birth_w3").html(json[0].r_death_birth_w3);
                    $("#r_death_birth_tot").html(json[0].r_death_birth_tot);

                    $("#r_preg_service_anc_visit1_w1").html(json[0].r_preg_service_anc_visit1_w1);
                    $("#r_preg_service_anc_visit1_w2").html(json[0].r_preg_service_anc_visit1_w2);
                    $("#r_preg_service_anc_visit1_w3").html(json[0].r_preg_service_anc_visit1_w3);
                    $("#r_preg_service_anc_visit1_tot").html(json[0].r_preg_service_anc_visit1_tot);

                    $("#r_preg_service_anc_visit2_w1").html(json[0].r_preg_service_anc_visit2_w1);
                    $("#r_preg_service_anc_visit2_w2").html(json[0].r_preg_service_anc_visit2_w2);
                    $("#r_preg_service_anc_visit2_w3").html(json[0].r_preg_service_anc_visit2_w3);
                    $("#r_preg_service_anc_visit2_tot").html(json[0].r_preg_service_anc_visit2_tot);

                    $("#r_preg_service_anc_visit3_w1").html(json[0].r_preg_service_anc_visit3_w1);
                    $("#r_preg_service_anc_visit3_w2").html(json[0].r_preg_service_anc_visit3_w2);
                    $("#r_preg_service_anc_visit3_w3").html(json[0].r_preg_service_anc_visit3_w3);
                    $("#r_preg_service_anc_visit3_tot").html(json[0].r_preg_service_anc_visit3_tot);

                    $("#r_preg_service_anc_visit4_w1").html(json[0].r_preg_service_anc_visit4_w1);
                    $("#r_preg_service_anc_visit4_w2").html(json[0].r_preg_service_anc_visit4_w2);
                    $("#r_preg_service_anc_visit4_w3").html(json[0].r_preg_service_anc_visit4_w3);
                    $("#r_preg_service_anc_visit4_tot").html(json[0].r_preg_service_anc_visit4_tot);
                    
                    $("#r_total_death_0_7days_w1").html(json[0].r_total_death_0_7days_w1);
                    $("#r_total_death_0_7days_w2").html(json[0].r_total_death_0_7days_w2);
                    $("#r_total_death_0_7days_w3").html(json[0].r_total_death_0_7days_w3);
                    $("#r_total_death_0_7days_tot").html(json[0].r_total_death_0_7days_tot);
                    
                    $("#r_total_death_8_28days_w1").html(json[0].r_total_death_8_28days_w1);
                    $("#r_total_death_8_28days_w2").html(json[0].r_total_death_8_28days_w2);
                    $("#r_total_death_8_28days_w3").html(json[0].r_total_death_8_28days_w3);
                    $("#r_total_death_8_28days_tot").html(json[0].r_total_death_8_28days_tot);
                    
                    $("#r_total_death_29d_bellow_1year_w1").html(json[0].r_total_death_29d_bellow_1year_w1);
                    $("#r_total_death_29d_bellow_1year_w2").html(json[0].r_total_death_29d_bellow_1year_w2);
                    $("#r_total_death_29d_bellow_1year_w3").html(json[0].r_total_death_29d_bellow_1year_w3);
                    $("#r_total_death_29d_bellow_1year_tot").html(json[0].r_total_death_29d_bellow_1year_tot);
                    
                    $("#r_total_death_1y_bellow_5year_w1").html(json[0].r_total_death_1y_bellow_5year_w1);
                    $("#r_total_death_1y_bellow_5year_w2").html(json[0].r_total_death_1y_bellow_5year_w2);
                    $("#r_total_death_1y_bellow_5year_w3").html(json[0].r_total_death_1y_bellow_5year_w3);
                    $("#r_total_death_1y_bellow_5year_tot").html(json[0].r_total_death_1y_bellow_5year_tot);
                    
                    $("#r_total_death_oth_all_w1").html(json[0].r_total_death_oth_all_w1);
                    $("#r_total_death_oth_all_w2").html(json[0].r_total_death_oth_all_w2);
                    $("#r_total_death_oth_all_w3").html(json[0].r_total_death_oth_all_w3);
                    $("#r_total_death_oth_all_tot").html(json[0].r_total_death_oth_all_tot);
                    
                    $("#r_total_death_maternal_w1").html(json[0].r_total_death_maternal_w1);
                    $("#r_total_death_maternal_w2").html(json[0].r_total_death_maternal_w2);
                    $("#r_total_death_maternal_w3").html(json[0].r_total_death_maternal_w3);
                    $("#r_total_death_maternal_tot").html(json[0].r_total_death_maternal_tot);
                    
                }

            }
        });
    });
</script>

<div id="page-wrapper">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <h3> স্বাস্থ্য সেবা কার্যক্রমের মাসিক অগ্রগতির রিপোর্ট </h3>
            </div>
        </div>

        <div class="col-ld-12">
            <div class="table-responsive">

                <table class="mis_table" style="width: 100%">
                    <tr>
                        <th colspan="3">সেবার তথ্য</th>
                        <th>ওয়ার্ড ১</th>
                        <th>ওয়ার্ড ২</th>
                        <th>ওয়ার্ড ৩</th>
                        <th>সর্বমোট</th>
                    </tr>
                    <tr>
                        <td colspan="2" rowspan="3">গর্ভবতী মায়ের সংখ্যা</td>
                        <td>নতুন</td>
                        <td id="r_preg_woman_new_w1"></td>
                        <td id="r_preg_woman_new_w2"></td>
                        <td id="r_preg_woman_new_w3"></td>
                        <td id="r_preg_woman_new_tot"></td>
                    </tr>
                    <tr>
                        <td>পুরাতন </td>
                        <td id="r_preg_woman_old_w1"></td>
                        <td id="r_preg_woman_old_w2"></td>
                        <td id="r_preg_woman_old_w3"></td>
                        <td id="r_preg_woman_old_tot"></td>
                    </tr>
                    <tr>
                        <td>মোট</td>
                        <td id="r_preg_woman_tot_w1"></td>
                        <td id="r_preg_woman_tot_w2"></td>
                        <td id="r_preg_woman_tot_w3"></td>
                        <td id="r_preg_woman_tot_tot"></td>
                    </tr>
                    <tr>
                        <td colspan="2" rowspan="4"><br>গর্ভকালীন সেবা</td>
                        <td>পরিদর্শন ১</td>
                        <td id="r_pnc_visit1_w1"></td>
                        <td id="r_pnc_visit1_w2"></td>
                        <td id="r_pnc_visit1_w3"></td>
                        <td id="r_pnc_visit1_tot"></td>
                    </tr>
                    <tr>
                        <td>পরিদর্শন ২</td>
                        <td id="r_pnc_visit2_w1"></td>
                        <td id="r_pnc_visit2_w2"></td>
                        <td id="r_pnc_visit2_w3"></td>
                        <td id="r_pnc_visit2_tot"></td>
                    </tr>
                    <tr>
                        <td>পরিদর্শন ৩</td>
                        <td id="r_pnc_visit3_w1"></td>
                        <td id="r_pnc_visit3_w2"></td>
                        <td id="r_pnc_visit3_w3"></td>
                        <td id="r_pnc_visit3_tot"></td>
                    </tr>
                    <tr>
                        <td>পরিদর্শন ৪</td>
                        <td id="r_pnc_visit4_w1"></td>
                        <td id="r_pnc_visit4_w2"></td>
                        <td id="r_pnc_visit4_w3"></td>
                        <td id="r_pnc_visit4_tot"></td>
                    </tr>
                    <tr>
                        <td colspan="3">গর্ভকালীন সময়ে আয়রন ও ফলিক এসিড পেয়েছন </td>
                        <td id="r_preg_iron_folic_acid_anc__w1"></td>
                        <td id="r_preg_iron_folic_acid_anc__w2"></td>
                        <td id="r_preg_iron_folic_acid_anc__w3"></td>
                        <td id="r_preg_iron_folic_acid_anc__tot"></td>
                    </tr>
                    <tr>
                        <td rowspan="3"><br><br><br>প্রসব</td>
                        <td rowspan="2"><br>বাড়িতে</td>
                        <td>দক্ষ কর্মী দ্বারা</td>
                        <td id="r_delivery_home_expert_w1"></td>
                        <td id="r_delivery_home_expert_w2"></td>
                        <td id="r_delivery_home_expert_w3"></td>
                        <td id="r_delivery_home_expert_tot"></td>
                    </tr>
                    <tr>
                        <td>অদক্ষ কর্মী দ্বারা</td>
                        <td id="r_delivery_home_unexpert_w1"></td>
                        <td id="r_delivery_home_unexpert_w2"></td>
                        <td id="r_delivery_home_unexpert_w3"></td>
                        <td id="r_delivery_home_unexpert_tot"></td>
                    </tr>
                    <tr>
                        <td colspan="2">ফ্যাসিলিটিতে</td>
                        <td id="r_delivery_facility_w1"></td>
                        <td id="r_delivery_facility_w2"></td>
                        <td id="r_delivery_facility_w3"></td>
                        <td id="r_delivery_facility_tot"></td>
                    </tr>
                    <tr>
                        <td colspan="3">মিসোপ্রস্টল বড়ি খেয়েছেন কি না</td>
                        <td id="r_misoprostol_eaten_w1"></td>
                        <td id="r_misoprostol_eaten_w2"></td>
                        <td id="r_misoprostol_eaten_w3"></td>
                        <td id="r_misoprostol_eaten_tot"></td>
                    </tr>
                    <tr>
                        <td colspan="2" rowspan="2"><br>প্রসবের ধরন</td>
                        <td>স্বাভাবিক</td>
                        <td id="r_delivery_patern_normal_w1"></td>
                        <td id="r_delivery_patern_normal_w2"></td>
                        <td id="r_delivery_patern_normal_w3"></td>
                        <td id="r_delivery_patern_normal_tot"></td>
                    </tr>
                    <tr>
                        <td>সিজোরিয়ান</td>
                        <td id="r_delivery_patern_operation_w1"></td>
                        <td id="r_delivery_patern_operation_w2"></td>
                        <td id="r_delivery_patern_operation_w3"></td>
                        <td id="r_delivery_patern_operation_tot"></td>
                    </tr>
                    <tr>
                        <td colspan="3">জীবিত জন্ম</td>
                        <td id="r_live_birth_w1"></td>
                        <td id="r_live_birth_w2"></td>
                        <td id="r_live_birth_w3"></td>
                        <td id="r_live_birth_tot"></td>
                    </tr>
                    <tr>
                        <td colspan="3">কম ওজন নিয়ে জন্ম নিয়েছে</td>
                        <td id="r_birth_less_weight_w1"></td>
                        <td id="r_birth_less_weight_w2"></td>
                        <td id="r_birth_less_weight_w3"></td>
                        <td id="r_birth_less_weight_tot"></td>
                    </tr>
                    <tr>
                        <td colspan="3">মৃত জন্ম</td>
                        <td id="r_death_birth_w1"></td>
                        <td id="r_death_birth_w2"></td>
                        <td id="r_death_birth_w3"></td>
                        <td id="r_death_birth_tot"></td>
                    </tr>
                    <tr>
                        <td colspan="2" rowspan="4">প্রসবোত্তর সেবা</td>
                        <td>পরিদর্শন ১</td>
                        <td id="r_preg_service_anc_visit1_w1"></td>
                        <td id="r_preg_service_anc_visit1_w2"></td>
                        <td id="r_preg_service_anc_visit1_w3"></td>
                        <td id="r_preg_service_anc_visit1_tot"></td>
                    </tr>
                    <tr>
                        <td>পরিদর্শন ২</td>
                        <td id="r_preg_service_anc_visit2_w1"></td>
                        <td id="r_preg_service_anc_visit2_w2"></td>
                        <td id="r_preg_service_anc_visit2_w3"></td>
                        <td id="r_preg_service_anc_visit2_tot"></td>
                    </tr>
                    <tr>
                        <td>পরিদর্শন ৩</td>
                        <td id="r_preg_service_anc_visit3_w1"></td>
                        <td id="r_preg_service_anc_visit3_w2"></td>
                        <td id="r_preg_service_anc_visit3_w3"></td>
                        <td id="r_preg_service_anc_visit3_tot"></td>
                    </tr>
                    <tr>
                        <td>পরিদর্শন ৪</td>
                        <td id="r_preg_service_anc_visit4_w1"></td>
                        <td id="r_preg_service_anc_visit4_w2"></td>
                        <td id="r_preg_service_anc_visit4_w3"></td>
                        <td id="r_preg_service_anc_visit4_tot"></td>
                    </tr>
                    <tr>
                        <td rowspan="6"><br><br><br><br><br><br><br>মৃতের সংখ্যা</td>
                        <td colspan="2">০ থেকে ৭ দিন </td>
                        <td id="r_total_death_0_7days_w1"></td>
                        <td id="r_total_death_0_7days_w2"></td>
                        <td id="r_total_death_0_7days_w3"></td>
                        <td id="r_total_death_0_7days_tot"></td>
                    </tr>
                    <tr>
                        <td colspan="2">৮ থেকে ২৮ দিন</td>
                        <td id="r_total_death_8_28days_w1"></td>
                        <td id="r_total_death_8_28days_w2"></td>
                        <td id="r_total_death_8_28days_w3"></td>
                        <td id="r_total_death_8_28days_tot"></td>
                    </tr>
                    <tr>
                        <td colspan="2">২৯ দিন থেকে ১ বছরের কম</td>
                        <td id="r_total_death_29d_bellow_1year_w1"></td>
                        <td id="r_total_death_29d_bellow_1year_w2"></td>
                        <td id="r_total_death_29d_bellow_1year_w3"></td>
                        <td id="r_total_death_29d_bellow_1year_tot"></td>
                    </tr>
                    <tr>
                        <td colspan="2">১ বছর থেকে ৫ বছরের কম</td>
                        <td id="r_total_death_1y_bellow_5year_w1"></td>
                        <td id="r_total_death_1y_bellow_5year_w2"></td>
                        <td id="r_total_death_1y_bellow_5year_w3"></td>
                        <td id="r_total_death_1y_bellow_5year_tot"></td>
                    </tr>
                    <tr>
                        <td colspan="2">অন্যান্য সকল মৃত্যু</td>
                        <td id="r_total_death_oth_all_w1"></td>
                        <td id="r_total_death_oth_all_w2"></td>
                        <td id="r_total_death_oth_all_w3"></td>
                        <td id="r_total_death_oth_all_tot"></td>
                    </tr>
                    <tr>
                        <td colspan="2">মাতৃমৃত্যু</td>
                        <td id="r_total_death_maternal_w1"></td>
                        <td id="r_total_death_maternal_w2"></td>
                        <td id="r_total_death_maternal_w3"></td>
                        <td id="r_total_death_maternal_tot"></td>
                    </tr>
                    <tr>
                        <td rowspan="14"><br><br><br>সংক্রামক রোগ</td>
                        <td rowspan="2"><br>ডায়রিয়া</td>
                        <td>পুরুষ</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>মহিলা</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td rowspan="2"><br>যক্ষ্ণ্যা</td>
                        <td>পুরুষ</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>মহিলা</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td rowspan="2"><br>কুষ্ঠ</td>
                        <td>পুরুষ</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>মহিলা</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td rowspan="2"><br>ফাইলেরিয়াসিস</td>
                        <td>পুরুষ</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>মহিলা</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td rowspan="2"><br>কালাজ্বর</td>
                        <td>পুরুষ</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>মহিলা</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td rowspan="2"><br>এ আর আই</td>
                        <td>পুরুষ</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>মহিলা</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td rowspan="2"><br>  অন্যান্য<br>(নির্দিষ্ট করুন)</td>
                        <td>পুরুষ</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>মহিলা</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td rowspan="4"><br><br><br>বিসিসি<br>কার্যক্রম</td>
                        <td colspan="2">পরিকল্পিত স্বাস্থ্য শিক্ষা সেশনের সংখ্যা</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="2">সম্পাদিত স্বাস্থ্য শিক্ষা সেশনের সংখ্যা</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td rowspan="2"><br>উপস্থিতির সংখ্যা</td>
                        <td>পুরুষ</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>মহিলা</td>
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

<%@include file="/WEB-INF/jspf/footer.jspf" %>