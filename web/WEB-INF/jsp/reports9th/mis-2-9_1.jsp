<%-- 
    Document   : mis-2-9
    Created on : Jan 10, 2019, 12:13:50 PM
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
</style>
<script>
    var json = null;

    $(document).ready(function () {

        function setJson(data) {
            console.log("Get MIS2: "+data.submissionId);
            json = data;
        }

        //MIS-2 Submission and resubmission
        $('.input-group-approve', '#form-report-response').find('button').click(function (e) {
            e.preventDefault();
            //First time submission
            var id = +new Date();
            Pace.track(function () {
                $.ajax({
                    url: "MIS_2?action=submitReport&subType=" + json.status,
                    data: {
                        divisionId: $("select#division").val(),
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val(),
                        providerId: $("select#provCode").val(),
                        month: $("select#month").val(),
                        year: $("#year").val(),
                        //date: getCurrentPreviousDate($("select#month").val(), $("#year").val()),
                        data: JSON.stringify(json),
                        note: $("input[name='message']").val(), //$('#note').val(),
                        html: $('#data-table').html(),
                        submissionId: id,
                        reviewLength: $.RS.reviewJson.length
                    },
                    type: 'POST',
                    success: function (result) {
                        var data = JSON.parse(result);
                        $.RS.submissionId = id;
                        $.RS.conversationModal('hide');
                        if (json.status == 2)
                            $.RS.submissionStatus('rePending');
                        else
                            $.RS.submissionStatus('pending');
                        $.toast(data[0].message, data[0].status)();
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $.toast(data[0].message, data[0].status)();
                    }
                });
            });

        });



        //Submission button click
        var $subBtn = $.RS.submissionButton();
        $($subBtn.context).on('click', $subBtn.selector + ':not(:disabled)', function () {
            $("input[name='message']").val("");
            $.loadReviewDataByProvider();
        });

        $('select').on('change', function () {
            setJson(null);
            $.RS.submissionId = 0;
            $("#submitDataButton").fadeOut();
            $("#viewStatus").children().fadeOut();
        });

        $('#showdataButton').on('click', function (event) {
            $.RS.submissionButton('hide');
            $("#viewStatus").children().fadeOut();
            var tableBody = $("#mis2Page1");

//            var divisionId = $("select#division").val();
//            var districtId = $("select#district").val();
//            var upazilaId = $("select#upazila").val();
//            var unionId = $("select#union").val();
//            var month = $("select#month").val();
//            var year = $("select#year").val();
//            var providerType = $("select#providerType").val();
//            var providerId = $("select#provider").val();

            if ($("select#division").val() == "" || $("select#division").val() == 0) {
                toastr["error"]("<h4><b>বিভাগ সিলেক্ট করুন </b></h4>");
                return;
            } else if ($("select#district").val() == "" || $("select#district").val() == 0) {
                toastr["error"]("<h4><b>জেলা সিলেক্ট করুন </b></h4>");
                return;
            } else if ($("select#upazila").val() == "" || $("select#upazila").val() == 0) {
                toastr["error"]("<h4><b>উপজেলা সিলেক্ট করুন</b></h4>");
                return;
            } else if ($("select#union").val() == "" || $("select#union").val() == 0) {
                toastr["error"]("<h4><b>ইউনিয়ন সিলেক্ট করুন</b></h4>");
                return;
            } else {

            //Clear previous table data
            tableBody.empty();

            Pace.track(function () {
                $.ajax({
                    url: "MIS_2?action=showdata",
                    data: {
                        divisionId: $("select#division").val(),
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val(),
                        providerId: $("select#provCode").val(),
                        month: $("select#month").val(),
                        year: $("select#year").val()
                    },
                    type: 'POST',
                    success: function (result) {
                        console.log("Raw: "+result);
                        var data = JSON.parse(result);
                        setJson(data);

                        var providers = data.providers;
                        var json = data.mis2;

                        if (json.length === 0) {
                            $('#mis2Page1').html("");
                            $('#mis2Page2').html("");
                            $('#mis2Page3').html("");
                            $('#mis2Page4').html("");
                            $('#mis2Page5').html("");
                            for (var i = 0; i < 5; i++) {
                                if (i == 0)
                                    loadRow("mis2Page1", 37);
                                if (i == 1)
                                    loadRow("mis2Page2", 36);
                                if (i == 2)
                                    loadRow("mis2Page3", 28);
                                if (i == 3)
                                    loadRow("mis2Page4", 29);
                                if (i == 4)
                                    loadRow("mis2Page5", 27);
                            }
                            toastr["error"]("<h4><b>কোন ডাটা পাওয়া যায়নি</b></h4>");
                            return;
                        }


                        $.RS.submissionButton('show');
                        //For not submitted
                        if (data.isSubmittable && data.status == undefined) {
                            $.RS.submissionStatus('notSubmitted');

                            //For pending
                        } else if (data.status == 0) {
                            //$('#isSubmitAccess').val() == '99' ? $.RS.submissionStatus('pending') : $.RS.submissionStatus('notSubmitted');
                            $.RS.submissionStatus('pending');

                            //For resubmit
                        } else if (data.status == 2) {
                            //$('#isSubmitAccess').val() == '99' ? $.RS.submissionStatus('revised') : $.RS.submissionStatus('notSubmitted');
                            $.RS.submissionStatus('revised')

                            //Re-submitted
                        } else if (data.status == 3) {
                            //$('#isSubmitAccess').val() == '99' ? $.RS.submissionStatus('rePending') : $.RS.submissionStatus('notSubmitted');
                            $.RS.submissionStatus('rePending')

                            //Otherwise is submitted
                        } else {
                            $.RS.submissionStatus('submitted');
                        }
                        
                        console.log(json);
                        $('#monthyear').html(" <b>" + $('#month option:selected').text() + "/ " + convertE2B($('#year option:selected').text()) + " ইং </b>");
                        $('#unionValue').html(" <b>" + $('#union option:selected').text().split("[")[0] + "</b>");
                        $('#upazilaValue').html(" <b>" + $('#upazila option:selected').text().split("[")[0] + "</b>");
                        $('#districtValue').html(" <b>" + $('#district option:selected').text().split("[")[0] + "</b>");

                        $('#mis2Page1').html("");
                        $('#mis2Page2').html("");
                        $('#mis2Page3').html("");
                        $('#mis2Page4').html("");
                        $('#mis2Page5').html("");
                         $('#mis2Page6').html("");
                         $('#mis2Page7').html("");
                         $('#mis2Page8').html("");
                        var cal = new Calc(json);

                        $('#totalWorker').html(convertE2B(providers.length));
                        $('#totalSubmittedWorker').html(convertE2B(json.length));

                       // $('#car').html(convertE2B(cal.avg('r_car').toFixed(2)));
                        $('#r_unit_all_total_tot1').html(convertE2B(cal.sum.r_unit_all_total));
                        $('#r_unit_capable_elco_tot1').html(convertE2B(cal.sum.r_unit_capable_elco_tot_2));
                        var car =  convertE2B((( cal.sum.r_unit_all_total / cal.sum.r_unit_capable_elco_tot_2 ) * 100).toFixed(2));  // 
                        $('#car').html(car);

                        var one = "-";
                        for (var j = 0; j < providers.length; j++) {
                            var isSubmitted = false;
                            for (var i = 0; i < json.length; i++) {
                                if (providers[j].fwaunit == json[i].r_unit_1) {

                                    isSubmitted = true;
                                    var Page1 = "<tr>"
                                            + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_unit_capable_elco_tot_2) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_old_pill_3) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_new_pill_4) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_month_pill_5) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_m_left_pill_no_method_6) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_m_left_pill_oth_method_7) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_old_condom_8) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_new_condom_9) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_month_condom_10) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_m_left_condom_no_method_11) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_m_left_condom_oth_method_12) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_old_injectable) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_new_injectable) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_month_injectable) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_m_left_inj_no_method) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_m_left_inj_oth_method) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_old_iud) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_new_iud) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_month_iud) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_m_left_iud_no_method) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_m_left_iud_oth_method) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_old_implant) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_new_implant) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_month_implant) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_m_left_implant_no_method) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_m_left_implant_oth_method) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_old_permanent_man) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_new_permanent_man) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_month_permanent_man) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_old_permanent_woman) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_new_permanent_woman) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_month_permanent_woman) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_sent_method_all_tot) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_sent_side_effect_all_tot) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_unit_all_total) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_car) + "</td>"
                                            + "</tr>";
                                    $('#mis2Page1').append(Page1);

                                    var Page2 = "<tr>"
                                            + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_month_preg_new_fwa_38) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_month_preg_old_fwa_39) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_curr_month_preg_tot_fwa_40) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_priv_month_preg_tot_fwa_41) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_unit_preg_tot_fwa1_42) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_preg_anc_service_visit1_fwa_43) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_preg_anc_service_visit2_fwa_44) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_preg_anc_service_visit3_fwa_45) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_preg_anc_service_visit4_fwa_46) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_delivary_service_home_trained_fwa_47) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_delivary_service_home_untrained_fwa_48) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_delivary_service_hospital_normal_fwa_49) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_delivary_service_hospital_cesarean_fwa_50) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_pnc_mother_visit1_fwa_51) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_pnc_mother_visit2_fwa_52) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_pnc_mother_visit3_fwa_53) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_pnc_mother_visit4_fwa_54) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_pnc_newborn_visit1_fwa_55) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_pnc_newborn_visit2_fwa_56) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_pnc_newborn_visit3_fwa_57) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_pnc_newborn_visit4_fwa_58) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_ref_risky_preg_cnt_fwa_59) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_childless_couple_adviced_fwa_60) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_childless_couple_refered_fwa_61) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_tt_women_1st_fwa_62) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_tt_women_2nd_fwa_63) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_tt_women_3rd_fwa_64) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_tt_women_4th_fwa_65) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_tt_women_5th_fwa_66) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_ecp_taken_fwa_67) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_misoprostol_taken_fwa_68) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_health_change_adolescent_fwa_69) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_child_marriage_preg_disadvantage_fwa_70) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_iron_folic_acid_fwa_71) + "</td>"
                                                + "<td>" + convertE2B(json[i].r_sexual_disease_fwa_72) + "</td>"
                                            + "</tr>";
                                    $('#mis2Page2').append(Page2);

                                    var Page3 = "<tr>"
                                            + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_satelite_clinic_presence_fwa_73) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_epi_session_presence_fwa_74) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_community_clinic_presence_fwa_75) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_newborn_1min_washed_fwa_76) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_newborn_71_chlorohexidin_used_fwa_77) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_vaccin_child_bcg_fwa_78) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_vaccin_0_18_months_opv_pcv_1_fwa_79) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_vaccin_0_18_months_opv_pcv_2_fwa_80) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_vaccin_0_18_months_opv_3_fwa_81) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_vaccin_0_18_months_pcv3_fwa_82) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_vaccin_0_18_months_mr_opv4_fwa_83) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_vaccin_0_18_ham_fwa_84) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_referred_child_dangerous_disease_fwa_85) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_referred_child_neumonia_fwa_86) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_referred_child_diahoea_fwa_87) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_tot_live_birth_fwa_88) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_less_weight_birth_fwa_89) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_immature_birth_less37weeks_fwa_90) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_still_birth_fwa_91) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_death_less_1yr_0_7days_fwa_92) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_death_less_1yr_8_28days_fwa_93) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_death_less_1yr_29dys_less1yr_fwa_94) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_death_less_1yr_tot_fwa_95) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_death_1yr_less_5yr_fwa_96) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_death_maternal_death_fwa_97) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_death_other_fwa_98) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_death_all_fwa_99) + "</td>"
                                            + "</tr>";
                                    $('#mis2Page3').append(Page3);

                                    var Page4 = "<tr>"
                                            + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_iron_folic_extrafood_counsil_preg_woman_100) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_iron_folic_extrafood_counsil_mother_0to23m_101) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_iron_folic_pill_distribute_preg_woman_102) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_iron_folic_pill_distribute_mother_0to23m_103) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_bfeeding_comp_food_counsil_preg_woman_104) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_bfeeding_comp_food_counsil_mother_0to23m_105) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_child_mnp_feeding_mother_0to23m_106) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_birth_1hr_bfeed_0_less_6mon_107) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_birth_only_bfeed_0_less_6mon_108) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_child_afood_6_less24mon_109) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_child_afood_24_less60mon_110) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_mnp_given_6_less24mon_111) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_mam_child_0_less_6mon_112) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_mam_child_6_less_24mon_113) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_mam_child_24_less_60mon_114) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_sam_child_0_less_6mon_115) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_sam_child_6_less_24mon_116) + "</td>"
                                            + "<td>" + convertE2B(json[i].r_sam_child_24_less_60mon_117) + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "</tr>";
                                    $('#mis2Page4').append(Page4);
                                    
                                    var Page5 = "<tr>"
                                            + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "</tr>";
                                    $('#mis2Page5').append(Page5);
                                    
                                    var Page6 = "<tr>"
                                            + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                            + "<td colspan='10'>" + providers[j].provname + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "</tr>";
                                    $('#mis2Page6').append(Page6);
                                    
                                    var Page7 = "<tr>"
                                            + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                            + "<td colspan='10'>" + providers[j].provname + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "</tr>";
                                    $('#mis2Page7').append(Page7);
                                    
                                    var Page8 = "<tr>"
                                            + "<td>" + $.getUnitName(json[i].r_unit_1, 1) + "</td>"
                                            + "<td colspan='10'>" + providers[j].provname + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "<td>" + one + "</td>"
                                            + "</tr>";
                                    $('#mis2Page8').append(Page8);
                                }
                            }

                            if (!isSubmitted) {
                                $('#mis2Page1').append("<tr class='not-submitted'>\n" + renderRow(37, '&nbsp;', providers[j].fwaunit,"") + "</tr>");
                                $('#mis2Page2').append("<tr class='not-submitted'>\n" + renderRow(36, '&nbsp;', providers[j].fwaunit,"") + "</tr>");
                                $('#mis2Page3').append("<tr class='not-submitted'>\n" + renderRow(28, '&nbsp;', providers[j].fwaunit,"") + "</tr>");
                                $('#mis2Page4').append("<tr class='not-submitted'>\n" + renderRow(29, '&nbsp;', providers[j].fwaunit,"") + "</tr>");
                                
                                $('#mis2Page5').append("<tr class='not-submitted'>\n" + renderRow(27, '&nbsp;', providers[j].fwaunit,"") + "</tr>");
                                $('#mis2Page6').append("<tr class='not-submitted'>\n" + renderRow(28, '&nbsp;', providers[j].fwaunit,providers[j].provname) + "</tr>");
                                $('#mis2Page7').append("<tr class='not-submitted'>\n" + renderRow(28, '&nbsp;', providers[j].fwaunit,providers[j].provname) + "</tr>");
                                $('#mis2Page8').append("<tr class='not-submitted'>\n" + renderRow(28, '&nbsp;', providers[j].fwaunit,providers[j].provname) + "</tr>");
                            }
                        }
                        $('#mis2Page1').append("<tr>\n" + getLastRow(cal, 1, car) + "</tr>");
                        $('#mis2Page2').append("<tr>\n" + getLastRow(cal, 2, car) + "</tr>");
                        $('#mis2Page3').append("<tr>\n" + getLastRow(cal, 3, car) + "</tr>");
                        $('#mis2Page4').append("<tr>\n" + getLastRow(cal, 4, car) + "</tr>");
                        
                        $('#mis2Page5').append("<tr>\n" + getLastRow(cal, 5, car) + "</tr>");
                        $('#mis2Page6').append("<tr>\n" + getLastRow(cal, 6, car) + "</tr>");
                        $('#mis2Page7').append("<tr>\n" + getLastRow(cal, 6, car) + "</tr>");
                        $('#mis2Page8').append("<tr>\n" + getLastRow(cal, 6, car) + "</tr>");
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                    }
                });//End Ajax
            }); //end pace
            }//end validation else
        });

        $(".r-v").parent().addClass("v-b text-left");

        //Load blanlk row in the table initially
        for (var i = 0; i < 8; i++) {
            if (i == 0)
                loadRow("mis2Page1", 37, false);
            if (i == 1)
                loadRow("mis2Page2", 36, false);
            if (i == 2)
                loadRow("mis2Page3", 28, false);
            if (i == 3)
                loadRow("mis2Page4", 29, false);
            if (i == 4)
                loadRow("mis2Page5", 27, false);
            
            if (i == 5)
                loadRow("mis2Page6", 28, true);
            if (i == 6)
                loadRow("mis2Page7", 28, true);
            if (i == 7)
                loadRow("mis2Page8", 28, true);
        }
        function loadRow(page, length, isLMIS) {
            for (var i = 0; i < 10; i++) {
                if(isLMIS )
                    $('#' + page).append("<tr>\n" + getLMISRow(length, i == 9 ? '<span class="r-v">সর্বমোট</span>' : '&nbsp;') + "</tr>");
                else
                    $('#' + page).append("<tr>\n" + getRow(length, i == 9 ? '<span class="r-v">সর্বমোট</span>' : '&nbsp;') + "</tr>");   
            }
        }
        function getRow(length, text) {
            var row = "";
            for (var j = 0; j < length; j++) {
                row += "<td>" + text + "</td>\n";
                text = "&nbsp;";
            }
            return row;
        }
        
        function getLMISRow(length, text) {
            var row = "";
            for (var j = 0; j < length; j++) {
                if(j==1)
                    row += "<td colspan='10'>" + text + "</td>\n";
                
                row += "<td>" + text + "</td>\n";
                text = "&nbsp;";
            }
            return row;
        }

        function renderRow(length, text, unit,haveName) {
            var row = "<td>" + $.getUnitName(unit, 1) + "</td>\n";
             if(haveName!="") row += "<td colspan='10'>"+haveName+"</td>\n";
            for (var j = 1; j < length; j++) {
                row += "<td>" + text + "</td>\n";
                text = "&nbsp;";
            }
            return row;
        }
    });
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle">
        <span style="color:#4fef2f;">
            <i class="fa fa-check-circle" aria-hidden="true"></i>
        </span> <span id="title">MIS 2</span>
        <span id="submitStatus" class="pull-right"></span>
    </h1>
</section>
<!-- Main content -->
<section class="content">
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
                            <label for="provCode">প্রোভাইডার</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="provCode" id="provCode">
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
                                <b><i class="fa fa-bar-chart" aria-hidden="true"></i>&nbsp; ডাটা দেখান</b>
                            </button>
                        </div>
                    </div>
                   
                    
                    <div class="row submitDataButton">
                        <div class="col-md-10">
                        </div>
                        <div class="col-md-2 submitButton">
                            <button type="button" id="submitDataButton" class="btn btn-flat btn-primary btn-block btn-sm">
                                <b><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;  Submission</b>
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
                <div class="col-md-12 mis-form-1" id="printContent"  style="padding: -108px;margin-top:-15px!important;">
                    <div class="mis2">
                        <div class="table-responsive" > 
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
<!--                                    <th style="text-align:center;border:none!important;" id="page" colspan="2">এম আই এস ফরম - ২<br>পৃষ্ঠা-১</th>-->
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
<!--                                    <th style="text-align:center;border:none!important;" id="page" colspan="2">এম আই এস ফরম - ২<br>পৃষ্ঠা-১</th>-->
                                </tr>
                            </table>
                        </div>

                        <div class="table-responsive">
                            <table style=" width: 100%;text-align: left!important" class="page1 mis_table tg">
                                <tr>
                                    <td rowspan="5"><span class="r-v">ইউনিট নম্বর<span></td>
                                    <td rowspan="5"><span class="r-v">ইউনিটের মোট সক্ষম দম্পতির সংখ্যা </span></td>
                                    <td colspan="36" class="center head">পরিবার পরিকল্পনা পদ্ধতি গ্রহনকারী</td>
                                </tr>
                                <tr>
                                    <td colspan="12">খাবার বড়ি</td>
                                    <td colspan="12">কনডম</td>
                                    <td colspan="12">ইনজেকটেবলস</td>
                                </tr>
                                <tr>
                                    <td colspan="5">স্বাভাবিক</td>
                                    <td colspan="6">প্রসব পরবর্তী</td>
                                    <td rowspan="3"><span class="r-v">সর্বমোট খাবার বড়ি</span></td>
                                    <td colspan="5">স্বাভাবিক</td>
                                    <td colspan="6">প্রসব পরবর্তী</td>
                                    <td rowspan="3"><span class="r-v">সর্বমোট কনডম</span></td>
                                    <td colspan="5">স্বাভাবিক</td>
                                    <td colspan="6">প্রসব পরবর্তী</td>
                                    <td rowspan="3"><span class="r-v">সর্বমোট ইনজেকটেবল</span></td>
                                </tr>
                                <tr>
                                    <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                    <td rowspan="2"><span class="r-v">নতুন</span></td>
                                    <td rowspan="2"><span class="r-v">মোট</span></td>
                                    <td colspan="2">ছেড়ে দিয়েছে</td>

                                    <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                    <td rowspan="2"><span class="r-v">নতুন</span></td>
                                    <td rowspan="2"><span class="r-v">মোট</span></td>
                                    <td colspan="3">ছেড়ে দিয়েছে</td>

                                    <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                    <td rowspan="2"><span class="r-v">নতুন</span></td>
                                    <td rowspan="2"><span class="r-v">মোট</span></td>
                                    <td colspan="2">ছেড়ে দিয়েছে</td>

                                    <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                    <td rowspan="2"><span class="r-v">নতুন</span></td>
                                    <td rowspan="2"><span class="r-v">মোট</span></td>
                                    <td colspan="3">ছেড়ে দিয়েছে</td>

                                    <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                    <td rowspan="2"><span class="r-v">নতুন</span></td>
                                    <td rowspan="2"><span class="r-v">মোট</span></td>
                                    <td colspan="2">ছেড়ে দিয়েছে</td>
                                    <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                    <td rowspan="2"><span class="r-v">নতুন</span></td>
                                    <td rowspan="2"><span class="r-v">মোট</span></td>
                                    <td colspan="3">ছেড়ে দিয়েছে</td>
                                </tr>
                                <tr>
                                    <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                    <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                    <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                    <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                    <td><span class="r-v">প্রসব পরবর্তী মেয়াদ উত্তীর্ণ</span></td>
                                    <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                    <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                    <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                    <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                    <td><span class="r-v">প্রসব পরবর্তী মেয়াদ উত্তীর্ণ</span></td>
                                    <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                    <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                    <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                    <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                    <td><span class="r-v">প্রসব পরবর্তী মেয়াদ উত্তীর্ণ</span></td>
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
                                    <td>৩৭</td>
                                    <td>৩৮</td>
                                </tr>
                                <tbody id="mis2Page1_">
                                </tbody>
                            </table>
                            <br/>
                            
                            <!--mmmmmmm-->
                            <table style=" width: 100%;text-align: left!important" class="page1 mis_table tg">
                                <tr>
                                    <th colspan="39" style="text-align:right;border:1px solid #fff!important;border-bottom:1px solid #000!important;">এম আই এস ফরম - ২<br>পৃষ্ঠা-২</b></th>
                                </tr>
                                <tr>
                                    <td rowspan="5"><span class="r-v">ইউনিট নম্বর<span></td>
                                    <td rowspan="5"><span class="r-v">ইউনিটের মোট সক্ষম দম্পতির সংখ্যা </span></td>
                                    <td colspan="36" class="center head">পরিবার পরিকল্পনা পদ্ধতি গ্রহনকারী</td>
                                </tr>
                                <tr>
                                    <td colspan="12" rowspan="2">আইইউডি</td>
                                    <td colspan="12" rowspan="2">ইমপ্ল্যান্ট</td>
                                    <td colspan="12" rowspan="1">স্থায়ী পদ্ধতি</td>
                                </tr>
                                <tr>
                                    
                                </tr>
                                <tr>
                                    <td colspan="5">স্বাভাবিক</td>
                                    <td colspan="6">প্রসব পরবর্তী</td>
                                    <td rowspan="3"><span class="r-v">সর্বমোট আইইউডি</span></td>
                                    <td colspan="5">স্বাভাবিক</td>
                                    <td colspan="6">প্রসব পরবর্তী</td>
                                    <td rowspan="3"><span class="r-v">সর্বমোট ইমপ্ল্যান্ট</span></td>
                                    <td colspan="5">স্বাভাবিক</td>
                                    <td colspan="6">প্রসব পরবর্তী</td>
                                    <td rowspan="3"><span class="r-v">সর্বমোট স্থায়ী পদ্ধতি</span></td>
                                </tr>
                                <tr>
                                    <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                    <td rowspan="2"><span class="r-v">নতুন</span></td>
                                    <td rowspan="2"><span class="r-v">মোট</span></td>
                                    <td colspan="2">ছেড়ে দিয়েছে</td>

                                    <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                    <td rowspan="2"><span class="r-v">নতুন</span></td>
                                    <td rowspan="2"><span class="r-v">মোট</span></td>
                                    <td colspan="3">ছেড়ে দিয়েছে</td>

                                    <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                    <td rowspan="2"><span class="r-v">নতুন</span></td>
                                    <td rowspan="2"><span class="r-v">মোট</span></td>
                                    <td colspan="2">ছেড়ে দিয়েছে</td>

                                    <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                    <td rowspan="2"><span class="r-v">নতুন</span></td>
                                    <td rowspan="2"><span class="r-v">মোট</span></td>
                                    <td colspan="3">ছেড়ে দিয়েছে</td>

                                    <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                    <td rowspan="2"><span class="r-v">নতুন</span></td>
                                    <td rowspan="2"><span class="r-v">মোট</span></td>
                                    <td colspan="2">ছেড়ে দিয়েছে</td>
                                    <td rowspan="2"><span class="r-v">পুরাতন</span></td>
                                    <td rowspan="2"><span class="r-v">নতুন</span></td>
                                    <td rowspan="2"><span class="r-v">মোট</span></td>
                                    <td colspan="3">ছেড়ে দিয়েছে</td>
                                </tr>
                                <tr>
                                    <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                    <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                    <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                    <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                    <td><span class="r-v">প্রসব পরবর্তী মেয়াদ উত্তীর্ণ</span></td>
                                    <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                    <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                    <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                    <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                    <td><span class="r-v">প্রসব পরবর্তী মেয়াদ উত্তীর্ণ</span></td>
                                    <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                    <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                    <td><span class="r-v">কোন পদ্ধতি নেয়নি</span></td>
                                    <td><span class="r-v">অন্য পদ্ধতি নিয়েছে</span></td>
                                    <td><span class="r-v">প্রসব পরবর্তী মেয়াদ উত্তীর্ণ</span></td>
                                </tr>
                                <tr class="serial-color">
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
                                    <td>৭২</td>
                                </tr>
                                <tbody id="mis2Page1_">
                                </tbody>
                            </table>
                            <br/>
                            
                            
                            <table style=" width: 100%;text-align: left!important" class="page1 mis_table tg">
                                <tr>
                                    <td rowspan="5"><span class="r-v">ইউনিট নম্বর<span></td>
                                    <td rowspan="5"><span class="r-v">ইউনিটের মোট সক্ষম দম্পতির সংখ্যা </span></td>
                                    <td colspan="40" class="center head">পরিবার পরিকল্পনা পদ্ধতি গ্রহনকারী</td>
                                </tr>
                                <tr>
                                    <td colspan="10">খাবার বড়ি</td>
                                    <td colspan="10">কনডম</td>
                                    <td colspan="10">ইনজেকটেবলস</td>
                                    <td colspan="10">আইইউডি</td>
                                    <td colspan="10">ইমপ্ল্যান্ট</td>
                                    <td colspan="6">স্থায়ী পদ্ধতি</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td rowspan="3"><span class="r-v">গ্রহনকারীর হার (CAR)</span></td>
                                </tr>
                                <tr>
                                    <td colspan="5">স্বাভাবিক</td>
                                    <td colspan="5">প্রসব পরবর্তী</td>
                                    <td colspan="5">স্বাভাবিক</td>
                                    <td colspan="5">প্রসব পরবর্তী</td>
                                    <td colspan="5">স্বাভাবিক</td>
                                    <td colspan="5">প্রসব পরবর্তী</td>
                                    <td colspan="5">স্বাভাবিক</td>
                                    <td colspan="5">প্রসব পরবর্তী</td>
                                    <td colspan="5">স্বাভাবিক</td>
                                    <td colspan="5">প্রসব পরবর্তী</td>
                                    <td colspan="5">স্বাভাবিক</td>
                                    <td colspan="5">প্রসব পরবর্তী</td>
                                    <td colspan="5">স্বাভাবিক</td>
                                    <td colspan="5">প্রসব পরবর্তী</td>
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

                                    <td rowspan="2"><span class="r-v">পদ্ধতির জন্য প্রেরণ</span></td>
                                    <td rowspan="2"><span class="r-v">পার্শ্বপ্রতিক্রিয়ার জন্য প্রেরণ</span></td>
                                    <td rowspan="2"><span class="r-v">সর্বমোট গ্রহণকারী</span></td>
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
                                    <td>৩৭</td>
                                </tr>
                                <tbody id="mis2Page1">
                                </tbody>
                            </table>
                            <table class="table-bordered mis_table pull-right car-table" style="width: 80%;">
                                <tbody>
                                    <tr>
                                        <td rowspan="2" style="width: 200px;border: 1px solid #fff!important;text-align: right;padding: 3px;">&nbsp;&nbsp;পদ্ধতি গ্রহনকারীর হার (CAR):</td>
                                        <td style="width: 200px;text-align: center;padding: 4px;border:1px solid #fff!important;border-bottom:1px solid #000!important;">ইউনিটের সর্বমোট পদ্ধতি গ্রহণকারী</td>
                                        <td rowspan="2" style="border: 1px solid #fff!important;text-align: left;width: 90px;">&nbsp;✖ ১০০&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= </td>

                                        <td class="v_field" style="width: 60px;text-align: center;padding: 4px;border: 1px solid #fff!important;border-bottom: 1px solid black!important;" id="r_unit_all_total_tot1">-</td>

                                        <td rowspan="2" style="border: 1px solid #fff!important;text-align: left;width: 90px;">&nbsp;&#10006; ১০০&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= </td>
                                        <td class="v_field"  rowspan="2" style="text-align: left;width: 100px;border: 1px solid #fff!important;" id="car"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 200px;text-align: center;padding: 4px;border:1px solid #fff!important;">ইউনিটের সর্বমোট সক্ষম দম্পতি </td>

                                        <td class="v_field"  id="r_unit_capable_elco_tot1" style="border: 1px solid #fff!important;width: 80;text-align: center;padding: 4px;">-</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
<!--                    <br/>-->
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
                                <th colspan="39" style="text-align:right;border:1px solid #fff!important;border-bottom:1px solid #000!important;">এম আই এস ফরম - ২<br>পৃষ্ঠা-২</b></th>
                            </tr>

                            <tr>
                                <td rowspan="4"><span class="r-v">ইউনিট নম্বর<span></td>
                                <td colspan="35" class="center">প্রজনন স্বাস্থ্য সেবা</td>
                            </tr>
                            <tr>
                                <td colspan="3" rowspan="2">চলতি মাসে<br>গর্ভবতীর<br>সংখ্যা</td>
                                <td rowspan="3"><span class="r-v">পূর্ববর্তী  মাসে মোট গর্ভবতীর সংখ্যা</span></td>
                                <td rowspan="3"><span class="r-v">ইউনিটের সর্বমোট গর্ভবতীর সংখ্যা</span></td>
                                <td colspan="4" rowspan="2">গর্ভকালীন সেবার তথ্য</td>
                                <td colspan="4">প্রসব সেবার তথ্য</td>
                                <td colspan="8">প্রসবোত্তর সেবার তথ্য</td>
                                <td rowspan="3"><span class="r-v">রেফারকৃত ঝুকিপূর্ণ/ জটিল গর্ভবতীর সংখ্যা</span></td>
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
                                <td>&nbsp;</td>
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
                                <td>৭২</td>
                            </tr>
                            <tbody id="mis2Page2">
                            </tbody>
                        </table>
                    </div>
                    <br/>
                    <div class="table-responsive mis2" data-mis2="page3">
                        <table style="width: 100%" class="mis_table tg">
                            <colgroup>
                                <col style="width: 57px">
                                <col style="width: 62px">
                                <col style="width: 72px">
                                <col style="width: 67px">
                                <col style="width: 57px">
                                <col style="width: 42px">
                                <col style="width: 41px">
                                <col style="width: 41px">
                                <col style="width: 41px">
                                <col style="width: 31px">
                                <col style="width: 31px">
                                <col style="width: 31px">
                                <col style="width: 41px">
                                <col style="width: 61px">
                                <col style="width: 86px">
                                <col style="width: 61px">
                                <col style="width: 61px">
                                <col style="width: 81px">
                                <col style="width: 81px">
                                <col style="width: 61px">
                                <col style="width: 51px">
                                <col style="width: 51px">
                                <col style="width: 65px">
                                <col style="width: 61px">
                                <col style="width: 51px">
                                <col style="width: 61px">
                                <col style="width: 61px">
                                <col style="width: 66px">
                                <col style="width: 66px">
                                <col style="width: 61px">
                                <col style="width: 61px">
                            </colgroup>
                            <tr>
                                <th colspan="39" style="text-align:right;border:1px solid #fff!important;border-bottom:1px solid #000!important;">এম আই এস ফরম - ২<br>পৃষ্ঠা-৩</b></th>
                            </tr>
                            <tr>
                                <td rowspan="6"><span class="r-v">ইউনিট নম্বর</span></td>
                                <td rowspan="6"><span class="r-v">স্যাটেলাইট ক্লিনিকে উপস্থিতি</span></td>
                                <td rowspan="6"><span class="r-v">ইপিআই সেশনে উপস্থিতি</span></td>
                                <td rowspan="6"><span class="r-v">কমিউনিটি ক্লিনিকে উপস্থিতি</span></td>
                                <td colspan="12" class="center">শিশু (০-৫ বছর) সেবা</td>
                                <td colspan="12" class="center">জন্ম-মৃত্যু</td>
                            </tr>
                            <tr>
                                <td colspan="2" rowspan="2">নবজাতকের সেবার তথ্য</td>
                                <td colspan="7" rowspan="2">টিকাপ্রাপ্ত (০-১ বছর) শিশুর সংখ্যা</td>
                                <td colspan="3" rowspan="2">রেফারকৃত শিশুর সংখ্যা</td>
                                <td rowspan="5"><span class="r-v">মোট জীবিত জন্মের সংখ্যা</span></td>
                                <td rowspan="5"><span class="r-v">কম ওজন (২.৫ কেজির কম) নিয়ে জন্মগ্রহন<br>কারীর সংখ্যা</span></td>
                                <td rowspan="5"><span class="r-v">অপরিনত (৩৭ সপ্তাহ পূর্ণ হওয়ার আগে) <br>জন্ম</span></td>
                                <td rowspan="5"><span class="r-v">মৃত জন্ম ( Still Birth)</span></td>
                                <td colspan="8">মৃতের সংখ্যা</td>
                            </tr>
                            <tr>
                                <td colspan="4" rowspan="2">এক বৎসরের কম মৃত শিশুর সংখ্যা </td>
                                <td rowspan="4"><span class="r-v">১ - <৫ বৎসর মৃত শিশুর সংখ্যা</span></td>
                                <td rowspan="4"><span class="r-v">মাতৃ-মৃত্যুর সংখ্যা </span></td>
                                <td rowspan="4"><span class="r-v">অন্যান্য মৃতের সংখ্যা</span></td>
                                <td rowspan="4"><span class="r-v">সর্বমোট মৃতের সংখ্যা</span></td>
                            </tr>
                            <tr>
                                <td rowspan="3"><span class="r-v">১ মিনিটের মধ্যে মোছানোর সংখ্যা</span></td>
                                <td rowspan="3"><span class="r-v">নাড়ি কাটার পর ৭.১%  <br> ক্লোরোহেক্সিডিন ব্যবহারের সংখ্যা</span></td>
                                <td rowspan="3"><span class="r-v">বিসিজি</span></td>
                                <td colspan="3">ওপিভি প্যান্টাভ্যালেন্ট <br> (ডিপিটি, হেপ-বি, হিব)</td>
                                <td rowspan="3"><span class="r-v">পিসিভি - ৩</span></td>
                                <td rowspan="3"><span class="r-v">এমআর ও ওপিভি-৪</span></td>
                                <td rowspan="3"><span class="r-v">হামের টিকা</span></td>
                                <td rowspan="3"><span class="r-v">খুব মারাত্মক রোগ</span></td>
                                <td rowspan="3"><span class="r-v">নিউমোনিয়া</span></td>
                                <td rowspan="3"><span class="r-v">ডায়রিয়া</span></td>
                            </tr>
                            <tr>
                                <td colspan="2">পিসিভি</td>
                                <td rowspan="2"><span class="r-v">৩</span></td>
                                <td rowspan="2"><span class="r-v">০ -৭ দিন</span></td>
                                <td rowspan="2"><span class="r-v">৮ - ২৮ দিন</span></td>
                                <td rowspan="2"><span class="r-v">২৯ দিন - < ১ বৎসর</span></td>
                                <td rowspan="2"><span class="r-v">মোট</span></td>
                            </tr>
                            <tr>
                                <td><span class="r-v">১</span></td>
                                <td><span class="r-v">২</span></td>
                            </tr>
                            <tr class="serial-color">
                                <td>&nbsp;</td>
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
                            </tr>
                            <tbody id="mis2Page3">
                            </tbody>
                        </table>
                    </div>
                    <br/>
                    
                    <div class="table-responsive mis2" data-mis2="page4">
                        <table style="width: 100%" class="mis_table tg">
                            <colgroup>
                                <col style="width: 56px">
                                <col style="width: 56px">
                                <col style="width: 56px">
                                <col style="width: 66px">
                                <col style="width: 71px">
                                <col style="width: 71px">
                                <col style="width: 61px">
                                <col style="width: 71px">
                                <col style="width: 61px">
                                <col style="width: 71px">
                                <col style="width: 61px">
                                <col style="width: 61px">
                                <col style="width: 71px">
                                <col style="width: 61px">
                                <col style="width: 61px">
                                <col style="width: 71px">
                                <col style="width: 71px">
                                <col style="width: 71px">
                                <col style="width: 71px">
                                <col style="width: 71px">
                                <col style="width: 61px">
                                <col style="width: 61px">
                                <col style="width: 83px">
                                <col style="width: 71px">
                                <col style="width: 61px">
                                <col style="width: 71px">
                                <col style="width: 71px">
                                <col style="width: 71px">
                                <col style="width: 61px">
                                <col style="width: 56px">
                                <col style="width: 71px">
                                <col style="width: 61px">
                                <col style="width: 61px">
                                <col style="width: 77px">
                                <col style="width: 61px">
                            </colgroup>
                            <tr>
                                <th colspan="39" style="text-align:right;border:1px solid #fff!important;border-bottom:1px solid #000!important;">এম আই এস ফরম - ২<br>পৃষ্ঠা-৪</b></th>
                            </tr>
                            <tr>
                                <td rowspan="4"><span class="r-v">ইউনিট নম্বর</span></td>
                                <td colspan="18" class="center">পুষ্টি সেবা</td>
                                <td rowspan="4" ><span class="r-v">চলতি মাসে নবদম্পতির সংখ্যা</span></td>
                                <td colspan="9" class="center">এফপিআই কর্তৃক প্রদত্ত সেবা কার্যক্রম</td>
                            </tr>
                            <tr>
                                <td colspan="7">গর্ভবতী ও ০-২৩ মাস বয়সী শিশুর সংখ্যা</td>
                                <td colspan="11">০-৫৯ মাস বয়সী শিশুর</td>
                                <td rowspan="3"><span class="r-v">কয়েকজনকে NSV সম্পর্কে উদ্বুদ্ধ করা হয়েছে</span></td>
                                <td rowspan="3"><span class="r-v">এভি ভ্যানের মাধ্যমে প্রদর্শনি আয়োজনের সংখ্যা</span></td>
                                <td rowspan="3"><span class="r-v">কতদিন দম্পতির উপাত্ত যাচাই করা হয়েছে</span></td>
                                <td rowspan="3"><span class="r-v">কয়টি দম্পতির উপাত্ত যাচাই করা হয়েছে</span></td>
                                <td rowspan="3"><span class="r-v">কতবার FWA রেজিস্টার যাচাই করা হয়েছে</span></td>
                                <td rowspan="3"><span class="r-v">দলগত সভা</span></td>
                                <td rowspan="3"><span class="r-v">পাক্ষিক সভা</span></td>
                                <td rowspan="3"><span class="r-v">ইউনিয়ন পরিবার পরিকল্পনা কমিটির সভা</span></td>
                                <td rowspan="3"><span class="r-v">স্যাটেলাইট ক্লিনিকে উপস্থিত</span></td>
                            </tr>
                            <tr>
                                <td colspan="2"><span class="r-v">আয়রন ও ফলিক এসিড<br> বড়ি এবং বাড়তি খাবারের<br> উপর কাউন্সেলিং দেয়া<br> হয়েছে</span></td>
                                <td colspan="2"><span class="r-v">আয়রন ও ফলিক এসিড<br> বড়ি বিতরণ করা হয়েছে</span></td>
                                <td colspan="2"><span class="r-v">শিশুকে মায়ের দুধ ও পরিপূরক<br> খাবারের উপর কাউন্সেলিং দেয়া<br> হয়েছে</span></td>
                                <td><span class="r-v">মাল্টিপুল মাইক্রোনিউপ্রিয়েন্ট<br> খাবারের উপর কাউন্সেলিং দেয়া<br> হয়েছে</span></td>
                                <td><span class="r-v">জন্মের ১ ঘণ্টার মধ্যে<br> বুকের দুধ খাওয়ানো <br>হয়েছে</span></td>
                                <td><span class="r-v">৬  মাস পর্যন্ত শুধুমাত্র<br> বুকের দুধ খাওয়ানো<br> হয়েছে </span></td>
                                <td colspan="2"><span class="r-v">জন্মের ৬ মাস পর<br> হতে পরিপূরক খাবার<br> খাওয়ানো হয়েছে <br> /হচ্ছে</span></td>
                                <td rowspan="2"><span class="r-v">৬ - <২৪ মাস বয়সী শিশু এমএনপি পেয়েছে</span></td>
                                <td colspan="3">MAM আক্রান্ত শিশুর সংখ্যা</td>
                                <td colspan="3">SAM আক্রান্ত শিশুর সংখ্যা</td>
                            </tr>
                            <tr>
                                <td><span class="r-v">গর্ববতী মা</span></td>
                                <td><span class="r-v">শিশুর মা</span></td>
                                <td><span class="r-v">গর্ববতী মা</span></td>
                                <td><span class="r-v">শিশুর মা</span></td>
                                <td><span class="r-v">গর্ববতী মা</span></td>
                                <td><span class="r-v">শিশুর মা</span></td>
                                <td><span class="r-v">শিশুর মা</span></td>
                                <td><span class="r-v">০ - <৬ মাস</span></td>
                                <td><span class="r-v">০ - <৬ মাস</span></td>
                                <td><span class="r-v">৬ - <২৪ মাস</span></td>
                                <td><span class="r-v">২৪ - <৬০ মাস</span></td>
                                <td><span class="r-v">০ - <৬ মাস</span></td>
                                <td><span class="r-v">৬ - <২৪ মাস</span></td>
                                <td><span class="r-v">২৪ - <৬০ মাস</span></td>
                                <td><span class="r-v">০ - <৬ মাস</span></td>
                                <td><span class="r-v">৬ - <২৪ মাস</span></td>
                                <td><span class="r-v">২৪ - <৬০ মাস</span></td>
                            </tr>
                            <tr class="serial-color">
                                <td>&nbsp;</td>
                                <td>১০০</td>
                                <td>১০১</td>
                                <td>১০২</td>
                                <td>১০৩</td>
                                <td>১০৪</td>
                                <td>১০৫</td>
                                <td>১০৬</td>
                                <td>১০৭</td>
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
                                <td>১২৬</td>
                                <td>১২৭</td>
                            </tr>
                            <tbody id="mis2Page4">
                            </tbody>
                        </table>
                    </div>
                    <br/>
                    
                    <div class="table-responsive mis2" data-mis2="page5">
                        <table style="width: 100%" class="mis_table tg">
                            <colgroup>
                                <col style="width: 56px">
                                <col style="width: 56px">
                                <col style="width: 56px">
                                <col style="width: 66px">
                                <col style="width: 71px">
                                <col style="width: 71px">
                                <col style="width: 61px">
                                <col style="width: 71px">
                                <col style="width: 61px">
                                <col style="width: 71px">
                                <col style="width: 61px">
                                <col style="width: 61px">
                                <col style="width: 71px">
                                <col style="width: 61px">
                                <col style="width: 61px">
                                <col style="width: 71px">
                                <col style="width: 71px">
                                <col style="width: 71px">
                                <col style="width: 71px">
                                <col style="width: 71px">
                                <col style="width: 61px">
                                <col style="width: 61px">
                                <col style="width: 83px">
                                <col style="width: 71px">
                                <col style="width: 61px">
                                <col style="width: 71px">
                                <col style="width: 71px">
                                <col style="width: 71px">
                                <col style="width: 61px">
                                <col style="width: 56px">
                                <col style="width: 71px">
                                <col style="width: 61px">
                                <col style="width: 61px">
                                <col style="width: 77px">
                                <col style="width: 61px">
                            </colgroup>
                            <tr>
                                <th colspan="39" style="text-align:right;border:1px solid #fff!important;border-bottom:1px solid #000!important;">এম আই এস ফরম - ২<br>পৃষ্ঠা-৫</b></th>
                            </tr>
                            <tr>
                                <td rowspan="4"><span class="r-v">ইউনিট নম্বর</span></td>
                                <td colspan="26" class="center">সিএসবিএ কর্তৃক প্রদত্ত সেবার তথ্য<br>(প্রজনন স্বাস্থ্য সেবা)</td>
                            </tr>
                            <tr>
                                <td colspan="4">গর্ভকালীন সেবার তথ্য</td>
                                <td colspan="3">প্রসব সেবার তথ্য</td>
                                <td colspan="13">প্রসবোত্তর সেবার তথ্য</td>
                                <td colspan="3">রেফারকৃত</td>
                                <td colspan="3" rowspan="2">রেফারকৃত শিশুর সংখ্যা </td>
                            </tr>
                            <tr>
                                <td rowspan="2"><span class="r-v"> পরিদর্শন-১ (৪ মাসের মধ্যে) </span></td>
                                <td rowspan="2"><span class="r-v">পরিদর্শন-২ (৬ মাসের মধ্যে) </span></td>
                                <td rowspan="2"><span class="r-v">পরিদর্শন -৩ (৮ মাসের মধ্যে) </span></td>
                                <td rowspan="2"><span class="r-v">পরিদর্শন-৪ (৯ম মাসে)</span></td>
                                <td rowspan="2"><span class="r-v">প্রসব করানো হয়েছে</span></td>
                                <td rowspan="2"><span class="r-v">প্রসবের তৃতীয় ধাপের সক্রিয় ব্যবস্থাপনা<br>(AMTSL) অনুসরণ করে প্রসব করানো</span></td>
                                <td rowspan="2"><span class="r-v">অক্সিটোসিন না থাকলে মিসোপ্রস্টল বড়ি খাওয়ানো হয়েছে</span></td>
                                <td colspan="5">মা</td>
                                <td colspan="8">নবজাতক</td>
                                <td rowspan="2"><span class="r-v">গর্ভকালীন, প্রসবকালীন ও প্রসবোত্তর জটিলতার<br>সংখ্যা </span></td>
                                <td rowspan="2"><span class="r-v">  একলাম্পসিয়া রোগীকে MgSO<sub>4</sub>ইনজেকশন<br>দিয়ে রেফার করার সংখ্যা  </span></td>
                                <td rowspan="2"><span class="r-v">  নবজাতককে জটিলতার জন্য প্রেরণের সংখ্যা  </span></td>
                            </tr>
                            <tr>
                                <td><span class="r-v"> পরিদর্শন-১ ( ২৪ ঘন্টার মধ্য) </span></td>
                                <td><span class="r-v"> পরিদর্শন-২ (২-৩ দিনের মধ্যে) </span></td>
                                <td><span class="r-v"> পরিদর্শন -৩ (৭-১৪ দিনের মধ্যে) </span></td>
                                <td><span class="r-v"> পরিদর্শন-৪ (৪২- ৪৮ দিনের মধ্যে) </span></td>
                                <td><span class="r-v"> প্রসব পরবর্তী পরিবার পরিকল্পনা পদ্ধতি বিষয়ে <br>কাউন্সেলিং </span></td>
                                <td><span class="r-v"> পরিদর্শন-১ ( ২৪ ঘন্টার মধ্য) </span></td>
                                <td><span class="r-v"> পরিদর্শন-২ (২-৩ দিনের মধ্যে) </span></td>
                                <td><span class="r-v"> পরিদর্শন -৩ (৭-১৪ দিনের মধ্যে) </span></td>
                                <td><span class="r-v"> পরিদর্শন-৪ (৪২- ৪৮ দিনের মধ্যে) </span></td>
                                <td><span class="r-v"> ১ মিনিটের মধ্যে মোছানোর সংখ্যা </span></td>
                                <td><span class="r-v">নাড়ি কাটার পর ৭.১% ক্লোরহেক্সিডিন <br>ব্যবহারের সংখ্যা </span></td>
                                <td><span class="r-v"> জন্মের ১ ঘন্টার মধ্যে বুকের দুধ খাওয়ানো সংখ্যা </span></td>
                                <td><span class="r-v"> জন্মকালীন শ্বাসকষ্টে আক্রান্ত শিশুকে ব্যাগ ও<br>মাস্ক ব্যবহার করে রিসাসসিটেট করার সংখ্যা </span></td>
                                <td><span class="r-v">খুব মারাত্মক রোগ</span></td>
                                <td><span class="r-v">নিউমোনিয়া </span></td>
                                <td><span class="r-v">ডায়রিয়া</span></td>
                            </tr>
                            <tr class="serial-color">
                                <td>&nbsp;</td>
                                <td>১২৮</td>
                                <td>১২৯</td>
                                <td>১৩০</td>
                                <td>১৩১</td>
                                <td>১৩২</td>
                                <td>১৩৩</td>
                                <td>১৩৪</td>
                                <td>১৩৫</td>
                                <td>১৩৬</td>
                                <td>১৩৭</td>
                                <td>১৩৮</td>
                                <td>১৩৯</td>
                                <td>১৪০</td>
                                <td>১৪১</td>
                                <td>১৪২</td>
                                <td>১৪৩</td>
                                <td>১৪৪</td>
                                <td>১৪৫</td>
                                <td>১৪৬</td>
                                <td>১৪৭</td>
                                <td>১৪৮</td>
                                <td>১৪৯</td>
                                <td>১৫০</td>
                                <td>১৫১</td>
                                <td>১৫২</td>
                                <td>১৫৩</td>
                            </tr>
                            <tbody id="mis2Page5">
                            </tbody>
                        </table>
                    </div>
                    <br/>
                    
                    
                    <div>
                        <div class="mis2">
                            <div class="table-responsive" style="margin-bottom: -5px!important;">
                                <table style=" width: 100%;text-align: left!important;border: none!important;margin-bottom: -10px!important" class="mis_table tg">
                                    <tr>
                                        <th colspan="39" style="text-align:right;border:1px solid #fff!important;border-bottom:1px solid #000!important;">এম আই এস ফরম - ২<br>পৃষ্ঠা-৬</b></th>
                                    </tr>
                                </table>
                            </div>
                            <div class="row"><!-- wwww -->
                                <h4 class="center lmis-title">  জন্মনিরোধক সামগ্রী ও অন্যান্য দ্রব্যাদির মাসিক সংকলিত প্রতিবেদন     </h4>
                                <div class="col-md-8 col-md-offset-2 lmis-title-table">
                                    <table border="1" style="font-weight: bold;" class="mis_table tg">
                                        <tr>
                                            <td>মোট কর্মী সংখ্যাঃ</td>
                                            <td><span id="totalWorker">&nbsp;</span></td>
                                            <td>মোট কতজন কর্মী প্রতিবেদন জমা দিয়েছেঃ</td>
                                            <td><span id="totalSubmittedWorker">&nbsp;</span></td>
                                        </tr>
                                    </table><br/>
                                </div>
                            </div>
                            <div class="table-responsive">
                                <table style=" width: 100%;text-align: center!important" class="page1 mis_table tg">
                                    <tr>
                                        <td rowspan="4"><span class="r-v">ইউনিট নম্বর<span></td>
                                        <td rowspan="4" colspan="10" class="center">পরিবার কল্যাণ সহকারীর নাম</td>
                                    </tr>
                                    <tr>
                                        <td colspan="9">খাবারবড়ি (সুখী) (চক্র)</td>
                                        <td colspan="9">খাবারবড়ি (আপন) (চক্র)</td>
                                        <td colspan="9">কনডম (নিরাপদ) (পিস)</td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2"><span class="r-v">পূর্বের মওজুদ</span></td>
                                        <td rowspan="2"><span class="r-v">চল্তিমাসে পাওয়া গেছে (+)</span></td>
                                        <td rowspan="2"><span class="r-v">চল্তিমাসের মোট মওজুদ</span></td>
                                        <td colspan="2">সমন্বয়</td>
                                        <td rowspan="2"><span class="r-v">সর্বমোট</span></td>
                                        <td rowspan="2"><span class="r-v">চল্তিমাসে বিতরণ করা হয়েছে (-)</span></td>
                                        <td rowspan="2"><span class="r-v">অবশিষ্ট</span></td>
                                        <td rowspan="2"><span class="r-v">চল্তিমাসে কখনও মওজুদ <br/>শূন্যতা হয়ে থাকলে সংখ্যা লিখুন</span></td>

                                        <td rowspan="2"><span class="r-v">পূর্বের মওজুদ</span></td>
                                        <td rowspan="2"><span class="r-v">চল্তিমাসে পাওয়া গেছে (+)</span></td>
                                        <td rowspan="2"><span class="r-v">চল্তিমাসের মোট মওজুদ</span></td>
                                        <td colspan="2">সমন্বয়</td>
                                        <td rowspan="2"><span class="r-v">সর্বমোট</span></td>
                                        <td rowspan="2"><span class="r-v">চল্তিমাসে বিতরণ করা হয়েছে (-)</span></td>
                                        <td rowspan="2"><span class="r-v">অবশিষ্ট</span></td>
                                        <td rowspan="2"><span class="r-v">চল্তিমাসে কখনও মওজুদ <br/>শূন্যতা হয়ে থাকলে সংখ্যা লিখুন</span></td>

                                        <td rowspan="2"><span class="r-v">পূর্বের মওজুদ</span></td>
                                        <td rowspan="2"><span class="r-v">চল্তিমাসে পাওয়া গেছে (+)</span></td>
                                        <td rowspan="2"><span class="r-v">চল্তিমাসের মোট মওজুদ</span></td>
                                        <td colspan="2">সমন্বয়</td>
                                        <td rowspan="2"><span class="r-v">সর্বমোট</span></td>
                                        <td rowspan="2"><span class="r-v">চল্তিমাসে বিতরণ করা হয়েছে (-)</span></td>
                                        <td rowspan="2"><span class="r-v">অবশিষ্ট</span></td>
                                        <td rowspan="2"><span class="r-v">চল্তিমাসে কখনও মওজুদ <br/>শূন্যতা হয়ে থাকলে সংখ্যা লিখুন</span></td>
                                    </tr>
                                    <tr>
                                        <td><span> (+) </span></td>
                                        <td><span> (-) </span></td>

                                        <td><span> (+) </span></td>
                                        <td><span> (-) </span></td>

                                        <td><span> (+) </span></td>
                                        <td><span> (-) </span></td>
                                    </tr>
                                    <tr class="serial-color center">
                                        <td>১</td>
                                        <td colspan="10">২</td>
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
                                    </tr>
                                    <tbody id="mis2Page6">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <br/>
                        
                        <div class="table-responsive mis2">
                            <table style=" width: 100%;text-align: center!important" class="page1 mis_table tg">
                                <tr>
                                    <th colspan="39" style="text-align:right;border:1px solid #fff!important;border-bottom:1px solid #000!important;">এম আই এস ফরম - ২<br>পৃষ্ঠা-৭</b></th>
                                </tr>
                                <tr>
                                    <td rowspan="4"><span class="r-v">ইউনিট নম্বর<span></td>
                                        <td rowspan="4" colspan="10" class="center">পরিবার কল্যাণ সহকারীর নাম</td>
                                </tr>
                                <tr>
                                    <td colspan="9">ইনজেকটেবল (ভায়াল)</td>
                                    <td colspan="9">ইনজেকটেবল (সিরিঞ্জ)</td>
                                    <td colspan="9">ইসিপি (ডোজ)</td>
                                </tr>
                                <tr>
                                    <td rowspan="2"><span class="r-v">পূর্বের মওজুদ</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে পাওয়া গেছে (+)</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসের মোট মওজুদ</span></td>
                                    <td colspan="2">সমন্বয়</td>
                                    <td rowspan="2"><span class="r-v">সর্বমোট</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে বিতরণ করা হয়েছে (-)</span></td>
                                    <td rowspan="2"><span class="r-v">অবশিষ্ট</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে কখনও মওজুদ <br/>শূন্যতা হয়ে থাকলে সংখ্যা লিখুন</span></td>

                                    <td rowspan="2"><span class="r-v">পূর্বের মওজুদ</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে পাওয়া গেছে (+)</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসের মোট মওজুদ</span></td>
                                    <td colspan="2">সমন্বয়</td>
                                    <td rowspan="2"><span class="r-v">সর্বমোট</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে বিতরণ করা হয়েছে (-)</span></td>
                                    <td rowspan="2"><span class="r-v">অবশিষ্ট</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে কখনও মওজুদ <br/>শূন্যতা হয়ে থাকলে সংখ্যা লিখুন</span></td>

                                    <td rowspan="2"><span class="r-v">পূর্বের মওজুদ</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে পাওয়া গেছে (+)</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসের মোট মওজুদ</span></td>
                                    <td colspan="2">সমন্বয়</td>
                                    <td rowspan="2"><span class="r-v">সর্বমোট</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে বিতরণ করা হয়েছে (-)</span></td>
                                    <td rowspan="2"><span class="r-v">অবশিষ্ট</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে কখনও মওজুদ <br/>শূন্যতা হয়ে থাকলে সংখ্যা লিখুন</span></td>
                                </tr>
                                <tr>
                                    <td><span> (+) </span></td>
                                    <td><span> (-) </span></td>

                                    <td><span> (+) </span></td>
                                    <td><span> (-) </span></td>

                                    <td><span> (+) </span></td>
                                    <td><span> (-) </span></td>
                                </tr>
                                <tr class="serial-color center">
                                    <td>&nbsp;</td>
                                    <td colspan="10">&nbsp;</td>
                                    <td>৩০</td>
                                    <td>৩১</td>
                                    <td>৩২</td>
                                    <td>৩৩</td>
                                    <td>৩৪</td>
                                    <td>৩৫</td>
                                    <td>৩৬</td>
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
                                </tr>
                                <tbody id="mis2Page7">
                                </tbody>
                            </table>
                        </div>
                        <br/>
                    
                        <div class="table-responsive mis2">
                            <table style=" width: 100%;text-align: center!important" class="page1 mis_table tg">
                                <tr>
                                    <th colspan="39" style="text-align:right;border:1px solid #fff!important;border-bottom:1px solid #000!important;">এম আই এস ফরম - ২<br>পৃষ্ঠা-৮</b></th>
                                </tr>
                                <tr>
                                    <td rowspan="4"><span class="r-v">ইউনিট নম্বর<span></td>
                                    <td rowspan="4" colspan="10" class="center">পরিবার কল্যাণ সহকারীর নাম</td>
                                </tr>
                                <tr>
                                    <td colspan="9">মিসোপ্রোস্টল (ডোজ)</td>
                                    <td colspan="9">এমএনপি (স্যাসেট)</td>
                                    <td colspan="9">আয়রন-ফলিক এসিড বড়ি (সংখ্যা)</td>
                                </tr>
                                <tr>
                                    <td rowspan="2"><span class="r-v">পূর্বের মওজুদ</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে পাওয়া গেছে (+)</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসের মোট মওজুদ</span></td>
                                    <td colspan="2">সমন্বয়</td>
                                    <td rowspan="2"><span class="r-v">সর্বমোট</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে বিতরণ করা হয়েছে (-)</span></td>
                                    <td rowspan="2"><span class="r-v">অবশিষ্ট</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে কখনও মওজুদ <br/>শূন্যতা হয়ে থাকলে সংখ্যা লিখুন</span></td>

                                    <td rowspan="2"><span class="r-v">পূর্বের মওজুদ</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে পাওয়া গেছে (+)</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসের মোট মওজুদ</span></td>
                                    <td colspan="2">সমন্বয়</td>
                                    <td rowspan="2"><span class="r-v">সর্বমোট</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে বিতরণ করা হয়েছে (-)</span></td>
                                    <td rowspan="2"><span class="r-v">অবশিষ্ট</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে কখনও মওজুদ <br/>শূন্যতা হয়ে থাকলে সংখ্যা লিখুন</span></td>

                                    <td rowspan="2"><span class="r-v">পূর্বের মওজুদ</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে পাওয়া গেছে (+)</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসের মোট মওজুদ</span></td>
                                    <td colspan="2">সমন্বয়</td>
                                    <td rowspan="2"><span class="r-v">সর্বমোট</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে বিতরণ করা হয়েছে (-)</span></td>
                                    <td rowspan="2"><span class="r-v">অবশিষ্ট</span></td>
                                    <td rowspan="2"><span class="r-v">চল্তিমাসে কখনও মওজুদ <br/>শূন্যতা হয়ে থাকলে সংখ্যা লিখুন</span></td>
                                </tr>
                                <tr>
                                    <td><span> (+) </span></td>
                                    <td><span> (-) </span></td>

                                    <td><span> (+) </span></td>
                                    <td><span> (-) </span></td>

                                    <td><span> (+) </span></td>
                                    <td><span> (-) </span></td>
                                </tr>
                                <tr class="serial-color center">
                                    <td>&nbsp;</td>
                                    <td colspan="10">&nbsp;</td>
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
                                </tr>
                                <tbody id="mis2Page8">
                                </tbody>
                            </table>
                        </div>
                </div>
            </div>
        </div>              
    </div>
</section>
<script>
    $(document).ready(function () {
        
        $('#printTableBtn').click(function () {
            $('.mis2').each(function () {
                $(this).css({
                    "page-break-after": "always"
                });
            });
            // window.print();
            var contents = $("#printContent").html();
            var frame1 = $('<iframe />');
            frame1[0].name = "frame1";
            frame1.css({"position": "absolute", "top": "-1000000px"});
            $("body").append(frame1);
            var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
            frameDoc.document.open();
            frameDoc.document.write('<html><head><title>eMIS Initiative</title>');
            frameDoc.document.write('</head><body>');                  
            frameDoc.document.write('<style>.r-v {white-space: nowrap;writing-mode: vertical-rl;transform: rotate(180deg);vertical-align: bottom!important;}   #logo{margin-top: 10px;margin-left: 5px;width:65px;height:65px;}</style>');   
            frameDoc.document.write('<style>table, th{font-weight:normal} , td{} .tg  {border-collapse:collapse;border-spacing:0;} #topheader{border: none; margin-bottom:10px;}</style>');
            frameDoc.document.write('<style>.tg td{font-family: SolaimanLipi;font-size:12px;padding:7px 9px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}</style>');
            frameDoc.document.write('<style>.tf td{font-family: SolaimanLipi;font-size:12px;padding:0px!important;padding-right: 26px!important;border-width:0px;overflow:hidden;}</style>');
            frameDoc.document.write('<style>table, th, td{border:1px solid black; border-collapse: collapse;text-align: center;vertical-align: bottom!important} .head{ font-weight:normal!important;text-align:center}</style>');
            frameDoc.document.write('<style>#slogan{text-align:center;border: 1px solid #000!important;width: 180px;text-align: center;padding: 2px;}</style>');
            frameDoc.document.write('<style>.lmis-title{ text-align:center!important;} .lmis-title-table{margin: auto!important;width: 60%!important;padding: 20px!important;} .car-table{float: right!important;}</style>');
            frameDoc.document.write(contents);
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 500);
        });
        
        
    });
    

    function getLastRow(json, page, car) {
        console.log(car);
        var row = "", one = "";
        if (page == 1) {
            row = "<td><span class='r-v'>সর্বমোট</span></td>"
                    + "<td>" + convertE2B(json.sum.r_unit_capable_elco_tot_2) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_old_pill_3) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_new_pill_4) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_month_pill_5) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_m_left_pill_no_method_6) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_m_left_pill_oth_method_7) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_old_condom_8) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_new_condom_9) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_month_condom_10) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_m_left_condom_no_method_11) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_m_left_condom_oth_method_12) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_old_injectable) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_new_injectable) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_month_injectable) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_m_left_inj_no_method) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_m_left_inj_oth_method) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_old_iud) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_new_iud) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_month_iud) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_m_left_iud_no_method) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_m_left_iud_oth_method) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_old_implant) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_new_implant) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_month_implant) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_m_left_implant_no_method) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_m_left_implant_oth_method) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_old_permanent_man) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_new_permanent_man) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_month_permanent_man) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_old_permanent_woman) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_new_permanent_woman) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_month_permanent_woman) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_sent_method_all_tot) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_sent_side_effect_all_tot) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_unit_all_total) + "</td>"
//                    + "<td>" + convertE2B(json.avg('r_car').toFixed(2)) + "</td>";
                    + "<td>" + car + "</td>";

        } else if (page == 2) {
            row = "<td><span class='r-v'>সর্বমোট</span></td>"
                    + "<td>" + convertE2B(json.sum.r_curr_month_preg_new_fwa_38) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_month_preg_old_fwa_39) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_curr_month_preg_tot_fwa_40) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_priv_month_preg_tot_fwa_41) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_unit_preg_tot_fwa1_42) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_preg_anc_service_visit1_fwa_43) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_preg_anc_service_visit2_fwa_44) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_preg_anc_service_visit3_fwa_45) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_preg_anc_service_visit4_fwa_46) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_delivary_service_home_trained_fwa_47) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_delivary_service_home_untrained_fwa_48) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_delivary_service_hospital_normal_fwa_49) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_delivary_service_hospital_cesarean_fwa_50) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_pnc_mother_visit1_fwa_51) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_pnc_mother_visit2_fwa_52) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_pnc_mother_visit3_fwa_53) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_pnc_mother_visit4_fwa_54) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_pnc_newborn_visit1_fwa_55) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_pnc_newborn_visit2_fwa_56) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_pnc_newborn_visit3_fwa_57) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_pnc_newborn_visit4_fwa_58) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_ref_risky_preg_cnt_fwa_59) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_childless_couple_adviced_fwa_60) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_childless_couple_refered_fwa_61) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_tt_women_1st_fwa_62) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_tt_women_2nd_fwa_63) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_tt_women_3rd_fwa_64) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_tt_women_4th_fwa_65) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_tt_women_5th_fwa_66) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_ecp_taken_fwa_67) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_misoprostol_taken_fwa_68) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_health_change_adolescent_fwa_69) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_child_marriage_preg_disadvantage_fwa_70) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_iron_folic_acid_fwa_71) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_sexual_disease_fwa_72) + "</td>";
        } else if (page == 3) {
            row = "<td><span class='r-v'>সর্বমোট</span></td>"
                    + "<td>" + convertE2B(json.sum.r_satelite_clinic_presence_fwa_73) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_epi_session_presence_fwa_74) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_community_clinic_presence_fwa_75) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_newborn_1min_washed_fwa_76) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_newborn_71_chlorohexidin_used_fwa_77) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_vaccin_child_bcg_fwa_78) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_vaccin_0_18_months_opv_pcv_1_fwa_79) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_vaccin_0_18_months_opv_pcv_2_fwa_80) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_vaccin_0_18_months_opv_3_fwa_81) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_vaccin_0_18_months_pcv3_fwa_82) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_vaccin_0_18_months_mr_opv4_fwa_83) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_vaccin_0_18_ham_fwa_84) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_referred_child_dangerous_disease_fwa_85) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_referred_child_neumonia_fwa_86) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_referred_child_diahoea_fwa_87) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_tot_live_birth_fwa_88) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_less_weight_birth_fwa_89) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_immature_birth_less37weeks_fwa_90) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_still_birth_fwa_91) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_death_less_1yr_0_7days_fwa_92) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_death_less_1yr_8_28days_fwa_93) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_death_less_1yr_29dys_less1yr_fwa_94) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_death_less_1yr_tot_fwa_95) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_death_1yr_less_5yr_fwa_96) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_death_maternal_death_fwa_97) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_death_other_fwa_98) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_death_all_fwa_99) + "</td>";
        } else if (page == 4) {
            row = "<td><span class='r-v'>সর্বমোট</span></td>"
                    + "<td>" + convertE2B(json.sum.r_iron_folic_extrafood_counsil_preg_woman_100) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_iron_folic_extrafood_counsil_mother_0to23m_101) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_iron_folic_pill_distribute_preg_woman_102) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_iron_folic_pill_distribute_mother_0to23m_103) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_bfeeding_comp_food_counsil_preg_woman_104) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_bfeeding_comp_food_counsil_mother_0to23m_105) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_child_mnp_feeding_mother_0to23m_106) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_birth_1hr_bfeed_0_less_6mon_107) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_birth_only_bfeed_0_less_6mon_108) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_child_afood_6_less24mon_109) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_child_afood_24_less60mon_110) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_mnp_given_6_less24mon_111) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_mam_child_0_less_6mon_112) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_mam_child_6_less_24mon_113) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_mam_child_24_less_60mon_114) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_sam_child_0_less_6mon_115) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_sam_child_6_less_24mon_116) + "</td>"
                    + "<td>" + convertE2B(json.sum.r_sam_child_24_less_60mon_117) + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>";
        }else if (page == 5) {
            row = "<td><span class='r-v'>সর্বমোট</span></td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>";
        }else if (page == 6) {
            row = "<td colspan='11'>সর্বমোট</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>"
                    + "<td>" + one + "</td>";
        }

        return row;
    }
</script>
<!-------- Start Report Modal ----------->
<%@include file="/WEB-INF/jspf/modal-report-submit.jspf" %>  
<%@include file="/WEB-INF/jspf/modal-report-response.jspf" %>
<%@include file="/WEB-INF/jspf/modal-report-view.jspf" %>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
