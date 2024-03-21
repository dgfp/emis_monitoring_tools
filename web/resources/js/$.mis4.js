var json = null;
$(function () {
    $('select').on('change', function () {
        json = null;
        $.RS.submissionId = 0;
        $("#submitDataButton").fadeOut();
        $("#viewStatus").children().fadeOut();
    });
    $.MIS4 = $.MIS4 || {
        dots: "..........................",
        html: $('#data-table').html(),
        page: {
            1: "#mis4Page1",
            2: "#mis4Page2",
            3: "#mis4Page3",
            4: "#mis4Page4",
            5: "#mis4Page5",
            6: "#mis4Page6",
            7: "#mis4Page7",
            8: "#mis4Page8",
            9: "#mis4Page9",
            10: "#mis4Page10",
//            11: "#mis4Page11",
//            12: "#mis4Page12",
//            13: "#mis4Page13",
//            14: "#mis4Page14",
//            15: "#mis4Page15",
//            16: "#mis4Page16",
//            17: "#mis4Page17",
//            18: "#mis4Page18",
            19: "#mis4Page19",
//            20: "#mis4Page20",
        },
        pageLength: {
            1: 27,
            2: 26,
            3: 35,
            4: 28,
            5: 25,
            6: 26,
            7: 33,
            8: 31,
            9: 27,
            10: 33,
            19: 29
        },
        init: function () {
            $(".r-v").parent().addClass("v-b text-left");
            Template.init(4);
            $.app.hideNextMonths();
            $.MIS4.setArea(this.dots, this.dots, this.dots, this.dots);
            $.MIS4.events.bindEvent();
        },
        events: {
            bindEvent: function () {
                $.MIS4.events.viewMIS4();
                $.MIS4.events.submitMIS4Popup();
                $.MIS4.events.submitMIS4();
            },
            viewMIS4: function () {
                $(document).off('click', '#showdataButton').on('click', '#showdataButton', function (e) {
                    var pairs = Template.pairs();
                    var version = Template.getVersion(pairs.year, pairs.month);
                    Template.reset(version);


                    var data = $.MIS4.getAreaData();
                    data.providerId = $('#district').val() + "0000";

                    if (data.division === "") {
                        toastr["error"]("<b>বিভাগ সিলেক্ট করুন </b>");

                    } else if (data.district === "") {
                        toastr["error"]("<b>জেলা সিলেক্ট করুন </b>");

                    } else if (data.upazila === "") {
                        toastr["error"]("<b>উপজেলা সিলেক্ট করুন</b>");

                    } else {
                        $.MIS4.ajax.viewMIS4(data);
                    }
                    //$.MIS4.ajax.viewMIS4(data);
                });
            },
            submitMIS4Popup: function () {
                $(".r-v").parent().removeClass("text-left");
                var $subBtn = $.RS.submissionButton();
                $('#form-report-response tbody:last-child tr:nth-child(1) input').val(0);
                $('#form-report-response tbody:last-child tr:nth-child(2) input').val(0);
                $($subBtn.context).on('click', $subBtn.selector + ':not(:disabled)', function () {
                    $('#form-report-response').find('button').html('<b><i class="fa fa-paper-plane" aria-hidden="true"></i>  জমা দিন</b>');
                    $('.modal-title').html('<b><i class="fa fa-file-text-o" aria-hidden="true"></i> MIS 4 (Upazila) - জমা দিন</b>');
                    $("input[name='message']").val("");
                    $('#nsv-submit-tbody').html("");
                    //$('#modal-area-title').text(areaTitle);
                    $.loadReviewDataByProvider();
                });
            },
            submitMIS4: function () {
                $('.input-group-approve', '#form-report-response').find('button').click(function (e) {
                    e.preventDefault();
                    var manual_data = $.app.pairs($('#form-report-response'));
                    delete manual_data.message;
                    $.each(manual_data, function (index, object) {
                        if (object == "" && index.split("_")[0] != "stockvacuum") {
                            toastr["error"]("<b>সকল ঘর পূরণ করুন, ডাটা না থাকলে শুন্য লিখুন</b>");
                            isValided = false;
                            $("input[name='" + index + "']").addClass("error");
                        } else {
                            $("input[name='" + index + "']").removeClass("error");
                        }
                    });

                    var isValid = true;
                    var id = +new Date();
                    var data = $.MIS4.getAreaData();
                    data.data = 999;
                    data.data = JSON.stringify(json);
                    data.note = $("input[name='message']").val();
                    data.html = null;//$('#data-table').html();
                    data.submissionId = id;
                    data.reviewLength = $.RS.reviewJson.length;
                    data.mis4_ngo = JSON.stringify($.app.pairs($('#form-report-response tbody:last-child tr:nth-child(1) input')));
                    data.mis4_versatile = JSON.stringify($.app.pairs($('#form-report-response tbody:last-child tr:nth-child(2) input')));

                    console.log(data);

                    if (isValid) {
                        $.ajax({
                            url: "MIS_4?action=submitReport&subType=" + json.status,
                            data: data,
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
                                $("#showdataButton").click();
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                $.toast(data[0].message, data[0].status)();
                            }
                        });
                    }
                });
            }

        },
        ajax: {
            viewMIS4: function (data) {
                $.RS.submissionButton('hide');
                $("#viewStatus").children().fadeOut();
                $.ajax({
                    url: 'MIS_4?action=showdata',
                    data: data,
                    type: 'POST',
                    success: function (result) {
                        var data = JSON.parse(result);
                        var union = data.union;
                        var mis4 = data.mis4;
                        json = data;
                        if (mis4.length === 0) {
                            $.MIS4.clearMIS4();
                            toastr["error"]("<b>কোন ডাটা পাওয়া যায়নি</b>");
                            $('.hide-div').css("display", "none");
                            return;
                        }

                        //Check is this user is FWA or not for submit button
                        $('#isSubmitAccess').val() == '99' ? $.RS.submissionButton('show') : $.RS.submissionButton('hide');

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
                            $("#submitDataButton").hide();
                            $.RS.submissionStatus('submitted');
                            $("#printContent").find(".color1,.color2").removeClass();
                        }
                        $('.hide-div').css("display", "none");
                        mis4.zillaname = mis4[0].zillaname;
                        mis4.upazilaname = mis4[0].upazilaname;
                        $.MIS4.renderMIS4(union, mis4, json);

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        toastr["error"]("<b>Request can't be processed</b>");
                    }
                });//End Ajax
            }
        },
        renderMIS4: function (union, mis4, json) {
            $.MIS4.setArea($.app.monthBangla[parseInt($('#month').val())] + "/ " + e2b($('#year option:selected').text()) + " ইং", mis4.zillaname, mis4.upazilaname);
            $.MIS4.cleanMIS4();
            //render data
            var cal = new Calc(mis4);

            $.each(union, function (unionIndex, union) {
                var isSubmitted = false;
                $.each(mis4, function (mis4Index, mis4) {
                    if (union.unionid == mis4.r_unionid) {
                        isSubmitted = true;
                        $('#mis4Page1').append("<tr>"
                                + "<td>" + (unionIndex + 1) + "</td>"
                                + "<td>" + union.unionname + "</td>"
                                + "<td>" + mis4.r_unit_capable_elco_tot + "</td>"
                                + "<td>" + mis4.r_old_pill_normal + "</td>"
                                + "<td>" + mis4.r_new_pill_normal + "</td>"
                                + "<td>" + mis4.r_curr_month_pill_normal_total + "</td>"
                                + "<td>" + mis4.r_curr_month_left_no_method_pill_normal + "</td>"
                                + "<td>" + mis4.r_curr_m_left_pill_oth_method_normal + "</td>"
                                + "<td>" + mis4.r_old_pill_after_delivery + "</td>"
                                + "<td>" + mis4.r_new_pill_after_delivery + "</td>"
                                + "<td>" + mis4.r_curr_month_pill_after_delivery_total + "</td>"
                                + "<td>" + mis4.r_curr_month_left_no_method_pill_after_delivery + "</td>"
                                + "<td>" + mis4.r_curr_m_left_pill_oth_method_after_delivery + "</td>"
                                + "<td>" + mis4.r_curr_m_left_ppfp_expired_pill_after_delivery + "</td>"
                                + "<td>" + mis4.r_pill_total + "</td>"
                                + "<td>" + mis4.r_old_condom_normal + "</td>"
                                + "<td>" + mis4.r_new_condom_normal + "</td>"
                                + "<td>" + mis4.r_curr_month_condom_normal_total + "</td>"
                                + "<td>" + mis4.r_curr_month_left_no_method_condom_normal + "</td>"
                                + "<td>" + mis4.r_curr_m_left_condom_oth_method_normal + "</td>"
                                + "<td>" + mis4.r_old_condom_after_delivery + "</td>"
                                + "<td>" + mis4.r_new_condom_after_delivery + "</td>"
                                + "<td>" + mis4.r_curr_month_condom_after_delivery_total + "</td>"
                                + "<td>" + mis4.r_curr_month_left_no_method_condom_after_delivery + "</td>"
                                + "<td>" + mis4.r_curr_m_left_condom_oth_method_after_delivery + "</td>"
                                + "<td>" + mis4.r_curr_m_left_ppfp_expired_condom_after_delivery + "</td>"
                                + "<td>" + mis4.r_condom_total + "</td>"
                                + "</tr>");

                        $('#mis4Page2').append("<tr>"
                                + "<td>" + (unionIndex + 1) + "</td>"
                                + "<td>" + union.unionname + "</td>"
                                + "<td>" + mis4.r_old_inject_normal + "</td>"
                                + "<td>" + mis4.r_new_inject_normal + "</td>"
                                + "<td>" + mis4.r_curr_month_inject_normal_total + "</td>"
                                + "<td>" + mis4.r_curr_month_left_no_method_inject_normal + "</td>"
                                + "<td>" + mis4.r_curr_m_left_inj_oth_method_normal + "</td>"
                                + "<td>" + mis4.r_old_inject_after_delivery + "</td>"
                                + "<td>" + mis4.r_new_inject_after_delivery + "</td>"
                                + "<td>" + mis4.r_curr_month_inject_after_delivery_total + "</td>"
                                + "<td>" + mis4.r_curr_month_left_no_method_inject_after_delivery + "</td>"
                                + "<td>" + mis4.r_curr_m_left_inj_oth_method_after_delivery + "</td>"
                                + "<td>" + mis4.r_curr_m_left_ppfp_expired_inject_after_delivery + "</td>"
                                + "<td>" + mis4.r_injectable_total + "</td>"
                                + "<td>" + mis4.r_old_iud_normal + "</td>"
                                + "<td>" + mis4.r_new_iud_normal + "</td>"
                                + "<td>" + mis4.r_curr_month_iud_normal_total + "</td>"
                                + "<td>" + mis4.r_curr_month_left_no_method_iud_normal + "</td>"
                                + "<td>" + mis4.r_curr_m_left_iud_oth_method_normal + "</td>"
                                + "<td>" + mis4.r_old_iud_after_delivery + "</td>"
                                + "<td>" + mis4.r_new_iud_after_delivery + "</td>"
                                + "<td>" + mis4.r_curr_month_iud_after_delivery_total + "</td>"
                                + "<td>" + mis4.r_curr_month_left_no_method_iud_after_delivery + "</td>"
                                + "<td>" + mis4.r_curr_m_left_iud_oth_method_after_delivery + "</td>"
                                + "<td>" + mis4.r_curr_m_left_ppfp_expired_iud_after_delivery + "</td>"
                                + "<td>" + mis4.r_iud_total + "</td>"
                                + "</tr>");

                        $('#mis4Page3').append("<tr>"
                                + "<td>" + (unionIndex + 1) + "</td>"
                                + "<td>" + union.unionname + "</td>"
                                + "<td>" + mis4.r_old_implant_normal + "</td>"
                                + "<td>" + mis4.r_new_implant_normal + "</td>"
                                + "<td>" + mis4.r_curr_month_implant_normal_total + "</td>"
                                + "<td>" + mis4.r_curr_month_left_no_method_implant_normal + "</td>"
                                + "<td>" + mis4.r_curr_m_left_implant_oth_method_normal + "</td>"
                                + "<td>" + mis4.r_old_implant_after_delivery + "</td>"
                                + "<td>" + mis4.r_new_implant_after_delivery + "</td>"
                                + "<td>" + mis4.r_curr_month_implant_after_delivery_total + "</td>"
                                + "<td>" + mis4.r_curr_month_left_no_method_implant_after_delivery + "</td>"
                                + "<td>" + mis4.r_curr_m_left_implant_oth_method_after_delivery + "</td>"
                                + "<td>" + mis4.r_curr_m_left_ppfp_expired_implan_after_delivery + "</td>"
                                + "<td>" + mis4.r_implant_total + "</td>"
                                + "<td>" + mis4.r_old_permanent_man_normal + "</td>"
                                + "<td>" + mis4.r_new_permanent_man_normal + "</td>"
                                + "<td>" + mis4.r_curr_month_permanent_normal_man + "</td>"
                                + "<td>" + mis4.r_old_permanent_man_after_delivery + "</td>"
                                + "<td>" + mis4.r_new_permanent_man_after_delivery + "</td>"
                                + "<td>" + mis4.r_curr_month_permanent_after_delivery_man + "</td>"
                                + "<td>" + mis4.r_permanent_method_men_total + "</td>"
                                + "<td>" + mis4.r_old_permanent_woman_normal + "</td>"
                                + "<td>" + mis4.r_new_permanent_woman_normal + "</td>"
                                + "<td>" + mis4.r_curr_month_permanent_normal_woman + "</td>"
                                + "<td>" + mis4.r_old_permanent_woman_after_delivery + "</td>"
                                + "<td>" + mis4.r_new_permanent_woman_after_delivery + "</td>"
                                + "<td>" + mis4.r_curr_month_permanent_after_delivery_woman + "</td>"
                                + "<td>" + mis4.r_permanent_method_woman_total + "</td>"
                                + "<td>" + mis4.r_curr_m_left_ppfp_expired_all_tot + "</td>"
                                + "<td>" + mis4.r_total_permanent_method + "</td>"
                                + "<td>" + mis4.r_curr_month_normal_total + "</td>"
                                + "<td>" + mis4.r_curr_month_after_delivery_total + "</td>"
                                + "<td>" + mis4.r_unit_all_total_tot + "</td>"
                                + "<td>" + mis4.r_car + "</td>"
                                + "<td>" + mis4.r_pac_mr_mrm_after_fp + "</td>"
                                + "</tr>");

                        $('#mis4Page4').append("<tr>"
                                + "<td>" + (unionIndex + 1) + "</td>"
                                + "<td>" + union.unionname + "</td>"
                                + "<td>" + mis4.r_curr_m_v_new_elco_tot + "</td>"
                                + "<td>" + mis4.r_curr_month_preg_new_fwa + "</td>"
                                + "<td>" + mis4.r_curr_month_preg_old_fwa + "</td>"
                                + "<td>" + mis4.r_curr_month_preg_tot_fwa + "</td>"
                                + "<td>" + mis4.r_priv_month_tot_preg_fwa + "</td>"
                                + "<td>" + mis4.r_unit_tot_preg_fwa + "</td>"
                                + "<td class='color" + mis4.r_preg_anc_service_visit1_csba_color + "'>" + mis4.r_preg_anc_service_visit1_csba + "</td>"
                                + "<td class='color" + mis4.r_preg_anc_service_visit2_csba_color + "'>" + mis4.r_preg_anc_service_visit2_csba + "</td>"
                                + "<td class='color" + mis4.r_preg_anc_service_visit3_csba_color + "'>" + mis4.r_preg_anc_service_visit3_csba + "</td>"
                                + "<td class='color" + mis4.r_preg_anc_service_visit4_csba_color + "'>" + mis4.r_preg_anc_service_visit4_csba + "</td>"
                                + "<td class='color" + mis4.r_preg_anc_counselling_after_delivery_csba_color + "'>" + mis4.r_preg_anc_counselling_after_delivery_csba + "</td>"
                                + "<td class='color" + mis4.r_preg_anc_misoprostol_supplied_csba_color + "'>" + mis4.r_preg_anc_misoprostol_supplied_csba + "</td>"
                                + "<td>" + mis4.r_preg_anc_chlorohexidin_supplied_csba + "</td>"
                                + "<td>" + mis4.r_ancadvicecenter_ancadvicesatelite + "</td>"
                                + "<td>" + mis4.r_ancAntinatalKortisatelite + "</td>"
                                + "<td>" + mis4.r_delivary_service_home_trained_fwa + "</td>"
                                + "<td>" + mis4.r_delivary_service_home_untrained_fwa + "</td>"
                                + "<td class='color" + mis4.r_delivary_service_hospital_normal_fwa_color + "'>" + mis4.r_delivary_service_hospital_normal_fwa + "</td>"
                                + "<td class='color" + mis4.r_delivary_service_hospital_operation_fwa_color + "'>" + mis4.r_delivary_service_hospital_operation_fwa + "</td>"
                                + "<td>" + mis4.r_others_forcep_center + "</td>"
                                + "<td>" + mis4.r_amtsl + "</td>"
                                + "<td>" + mis4.r_partograph_using_center + "</td>"
                                + "<td>" + mis4.r_deliveryIPHcenter + "</td>"
                                + "<td>" + mis4.r_one_hundred_eight + "</td>"
                                + "<td>" + mis4.r_pacservicecount + "</td>"
                                + "<td>" + mis4.r_anchighpreeclampsia + "</td>"
                                + "</tr>");

                        $('#mis4Page5').append("<tr>"
                                + "<td>" + (unionIndex + 1) + "</td>"
                                + "<td>" + union.unionname + "</td>"
                                + "<td class='color" + mis4.r_pnc_mother_visit1_csba_color + "'>" + mis4.r_pnc_mother_visit1_csba + "</td>"
                                + "<td class='color" + mis4.r_pnc_mother_visit2_csba_color + "'>" + mis4.r_pnc_mother_visit2_csba + "</td>"
                                + "<td class='color" + mis4.r_pnc_mother_visit3_csba_color + "'>" + mis4.r_pnc_mother_visit3_csba + "</td>"
                                + "<td class='color" + mis4.r_pnc_mother_visit4_csba_color + "'>" + mis4.r_pnc_mother_visit4_csba + "</td>"
                                + "<td>" + mis4.r_pnc_mother_home_delivery_training_csba + "</td>"
                                + "<td class='color" + mis4.r_pnc_mother_family_planning_counselling_csba_color + "'>" + mis4.r_pnc_mother_family_planning_counselling_csba + "</td>"
                                + "<td>" + mis4.r_pncmotherPPH + "</td>"
                                + "<td class='color" + mis4.r_newborn_1min_washed_csba_color + "'>" + mis4.r_newborn_1min_washed_csba + "</td>"
                                + "<td class='color" + mis4.r_newborn_71_chlorohexidin_used_csba_color + "'>" + mis4.r_newborn_71_chlorohexidin_used_csba + "</td>"
                                + "<td class='color" + mis4.r_newborn_with_mother_skin_csba_color + "'>" + mis4.r_newborn_with_mother_skin_csba + "</td>"
                                + "<td class='color" + mis4.r_newborn_1hr_bfeeded_csba_color + "'>" + mis4.r_newborn_1hr_bfeeded_csba + "</td>"
                                + "<td class='color" + mis4.r_newborn_diff_breathing_resassite_csba_color + "'>" + mis4.r_newborn_diff_breathing_resassite_csba + "</td>"
                                + "<td class='color" + mis4.r_pnc_newborn_visit1_csba_color + "'>" + mis4.r_pnc_newborn_visit1_csba + "</td>"
                                + "<td class='color" + mis4.r_pnc_newborn_visit2_csba_color + "'>" + mis4.r_pnc_newborn_visit2_csba + "</td>"
                                + "<td class='color" + mis4.r_pnc_newborn_visit3_csba_color + "'>" + mis4.r_pnc_newborn_visit3_csba + "</td>"
                                + "<td class='color" + mis4.r_pnc_newborn_visit4_csba_color + "'>" + mis4.r_pnc_newborn_visit4_csba + "</td>"
                                + "<td>" + mis4.r_one_hundred_twenty_seven + "</td>"
                                + "<td class='color" + mis4.r_ref_eclampsia_mgso4_inj_refer_csba_color + "'>" + mis4.r_ref_eclampsia_mgso4_inj_refer_csba + "</td>"
                                + "<td>" + mis4.r_deliveryrefer + "</td>"
                                + "<td>" + mis4.r_pncmotherrefer + "</td>"
                                + "<td class='color" + mis4.r_ref_newborn_difficulty_csba_color + "'>" + mis4.r_ref_newborn_difficulty_csba + "</td>"
                                + "<td class='color" + mis4.r_infertile_consultstatus_color + "'>" + mis4.r_infertile_consultstatus + "</td>"
                                + "<td class='color" + mis4.r_infertile_referstatus_color + "'>" + mis4.r_infertile_referstatus + "</td>"
                                + "</tr>");

                        $('#mis4Page6').append("<tr>"
                                + "<td>" + (unionIndex + 1) + "</td>"
                                + "<td>" + union.unionname + "</td>"
                                + "<td>" + mis4.r_tt_women_1st_fwa + "</td>"
                                + "<td>" + mis4.r_tt_women_2nd_fwa + "</td>"
                                + "<td>" + mis4.r_tt_women_3rd_fwa + "</td>"
                                + "<td>" + mis4.r_tt_women_4th_fwa + "</td>"
                                + "<td>" + mis4.r_tt_women_5th_fwa + "</td>"
                                + "<td class='color" + mis4.r_ecp_taken_color + "'>" + mis4.r_ecp_taken_color + "</td>"
                                + "<td class='color" + mis4.r_teen_counseling_adolescent_change_fwa_color + "'>" + mis4.r_teen_counseling_adolescent_change_fwa + "</td>"
                                + "<td class='color" + mis4.r_teen_counseling_child_marriage_preg_effect_fwa_color + "'>" + mis4.r_teen_counseling_child_marriage_preg_effect_fwa + "</td>"
                                + "<td>" + mis4.r_teen_counseling_iron_folic_fwa + "</td>"
                                + "<td>" + mis4.r_teen_counseling_iron_folic_distribution_fwa + "</td>"
                                + "<td class='color" + mis4.r_teen_counseling_sexual_disease_fwa_color + "'>" + mis4.r_teen_counseling_sexual_disease_fwa + "</td>"
                                + "<td>" + mis4.r_one_hundred_fourty_five + "</td>"
                                + "<td class='color" + mis4.r_teen_counseling_healthy_balanced_diet_fwa_color + "'>" + mis4.r_teen_counseling_healthy_balanced_diet_fwa + "</td>"
                                + "<td class='color" + mis4.r_teen_counseling_adolescence_violence_prevention_fwa_color + "'>" + mis4.r_teen_counseling_adolescence_violence_prevention_fwa + "</td>"
                                + "<td class='color" + mis4.r_teen_counseling_mental_prob_drug_addict_prevention_fwa_color + "'>" + mis4.r_teen_counseling_mental_prob_drug_addict_prevention_fwa + "</td>"
                                + "<td class='color" + mis4.r_teen_counseling_cleanliness_sanitary_pad_fwa_color + "'>" + mis4.r_teen_counseling_cleanliness_sanitary_pad_fwa + "</td>"
                                + "<td class='color" + mis4.r_teen_counseling_referred_fwa_color + "'>" + mis4.r_teen_counseling_referred_fwa + "</td>"
                                + "<td>" + mis4.r_gp_rta_sta_all + "</td>"
                                + "<td>" + mis4.r_mr_mva_treatment + "</td>"
                                + "<td>" + mis4.r_mrm_treatment + "</td>"
                                + "<td>" + mis4.r_total_via_positive + "</td>"
                                + "<td>" + mis4.r_total_via_negative + "</td>"
                                + "<td>" + mis4.r_total_cbe_positive + "</td>"
                                + "<td>" + mis4.r_total_cbe_negative + "</td>"
                                + "</tr>");

                        $('#mis4Page7').append("<tr>"
                                + "<td>" + (unionIndex + 1) + "</td>"
                                + "<td>" + union.unionname + "</td>"
                                + "<td>" + mis4.r_kmc_started_child + "</td>"
                                + "<td>" + mis4.r_vaccinated_child_0to15mnths_bcg_fwa + "</td>"
                                + "<td>" + mis4.r_vaccinated_child_0to15mnths_pentavalent_1_fwa + "</td>"
                                + "<td>" + mis4.r_vaccinated_child_0to15mnths_pentavalent_2_fwa + "</td>"
                                + "<td>" + mis4.r_vaccinated_child_0to15mnths_pentavalent_3_fwa + "</td>"
                                + "<td>" + mis4.r_vaccinated_child_0to15mnths_pcv1_fwa + "</td>"
                                + "<td>" + mis4.r_vaccinated_child_0to15mnths_pcv2_fwa + "</td>"
                                + "<td>" + mis4.r_vaccinated_child_0to15mnths_pcv3_fwa + "</td>"
                                + "<td>" + mis4.r_vaccinated_child_0to15mnths_bopv_1_fwa + "</td>"
                                + "<td>" + mis4.r_vaccinated_child_0to15mnths_bopv_2_fwa + "</td>"
                                + "<td>" + mis4.r_vaccinated_child_0to15mnths_bopv_3_fwa + "</td>"
                                + "<td>" + mis4.r_vaccinated_child_0to15mnths_ipv_1_fwa + "</td>"
                                + "<td>" + mis4.r_vaccinated_child_0to15mnths_ipv_2_fwa + "</td>"
                                + "<td>" + mis4.r_vaccinated_child_0to15mnths_mr_1_fwa + "</td>"
                                + "<td>" + mis4.r_vaccinated_child_0to15mnths_mr_2_fwa + "</td>"
                                + "<td>" + mis4.r_referred_child_dangerous_disease_fwa + "</td>"
                                + "<td>" + mis4.r_referred_child_neumonia_fwa + "</td>"
                                + "<td>" + mis4.r_referred_child_diahoea_fwa + "</td>"
                                + "<td>" + mis4.r_tot_live_birth_fwa + "</td>"
                                + "<td>" + mis4.r_less_weight_birth_less_then_2500g_fwa + "</td>"
                                + "<td>" + mis4.r_less_weight_birth_less_then_2000g_fwa + "</td>"
                                + "<td>" + mis4.r_immature_birth_fwa + "</td>"
                                + "<td>" + mis4.r_still_birth_fwa + "</td>"
                                + "<td>" + mis4.r_death_number_less_1yr_0to7days_fwa + "</td>"
                                + "<td>" + mis4.r_death_number_less_1yr_8to28days_fwa + "</td>"
                                + "<td>" + mis4.r_death_number_less_1yr_29dystoless1yr_fwa + "</td>"
                                + "<td>" + mis4.r_death_number_less_1yr_tot_fwa + "</td>"
                                + "<td>" + mis4.r_death_number_1yrto5yr_fwa + "</td>"
                                + "<td>" + mis4.r_death_number_maternal_death_fwa + "</td>"
                                + "<td>" + mis4.r_death_number_other_death_fwa + "</td>"
                                + "<td>" + mis4.r_death_number_all_death_fwa + "</td>"
                                + "</tr>");

                        $('#mis4Page8').append("<tr>"
                                + "<td>" + (unionIndex + 1) + "</td>"
                                + "<td>" + union.unionname + "</td>"
                                + "<td>" + mis4.r_gp_male + "</td>"
                                + "<td>" + mis4.r_gp_female + "</td>"
                                + "<td>" + mis4.r_gp_outdoor_child_0_1 + "</td>"
                                + "<td>" + mis4.r_gp_outdoor_child_1_5 + "</td>"
                                + "<td>" + mis4.r_external_other_patient + "</td>"
                                + "<td>" + mis4.r_total_outdoor_patient + "</td>"
                                + "<td>" + mis4.r_internal_female_patient + "</td>"
                                + "<td>" + mis4.r_internal_oneyear_child_patient + "</td>"
                                + "<td>" + mis4.r_internal_onetofive_child_patient + "</td>"
                                + "<td>" + mis4.r_total_indoor_patient + "</td>"
                                + "<td>" + mis4.r_bcc_done + "</td>"
                                + "<td>" + mis4.r_sacmo_done + "</td>"
                                + "<td>" + mis4.r_nutrition_iycf_counseling + "</td>"
                                + "<td>" + mis4.r_iron_folicacid_distribute_preg_woman + "</td>"
                                + "<td class='color" + mis4.r_iron_folicacid_distribute_child_0to23months_color + "'>" + mis4.r_iron_folicacid_distribute_child_0to23months + "</td>"
                                + "<td>" + mis4.r_child_number_0to6mon + "</td>"
                                + "<td>" + mis4.r_birth_1hr_bfeed_0to6mon + "</td>"
                                + "<td>" + mis4.r_birth_only_bfeed_0to6mon + "</td>"
                                + "<td class='color" + mis4.r_v0_59_child_complementary_food_6to23mon_color + "'>" + mis4.r_v0_59_child_complementary_food_6to23mon + "</td>"
                                + "<td>" + mis4.r_v0_59_child_complementary_food_24to59mon + "</td>"
                                + "<td>" + mis4.r_v6_59_month_child_vitamin_a_given + "</td>"
                                + "<td>" + mis4.r_v24_59_month_child_wormpills_given + "</td>"
                                + "<td>" + mis4.r_v6_59_child_saline_given + "</td>"
                                + "<td>" + mis4.r_v6_59_gmp + "</td>"
                                + "<td class='color" + mis4.r_mnp_given_24toless60mon__mam_child_0to6mon_color + "'>" + mis4.r_mnp_given_24toless60mon__mam_child_0to6mon + "</td>"
                                + "<td class='color" + mis4.r_mam_child_24to60mon__sam_child_0to6mon_color + "'>" + mis4.r_mam_child_24to60mon__sam_child_0to6mon + "</td>"
                                + "<td>" + mis4.r_stunting + "</td>"
                                + "<td>" + mis4.r_wasting + "</td>"
                                + "<td>" + mis4.r_under_weight + "</td>"
                                + "</tr>");

                        $('#mis4Page9').append("<tr>"
                                + "<td>" + (unionIndex + 1) + "</td>"
                                + "<td>" + union.unionname + "</td>"
                                + "<td>" + mis4.r_satelite_clinic_presence + "</td>"
                                + "<td>" + mis4.r_epi_session_presence + "</td>"
                                + "<td>" + mis4.r_community_clinic_presence + "</td>"
                                + "<td>" + mis4.r_yard_meeting_presence + "</td>"
                                + "<td>" + mis4.r_nsv_inspired_fpi + "</td>"
                                + "<td>" + mis4.r_av_van_display_fpi + "</td>"
                                + "<td>" + mis4.r_elco_day_count_fpi + "</td>"
                                + "<td>" + mis4.r_no_of_elco_count_fpi + "</td>"
                                + "<td>" + mis4.r_fwa_register_fpi + "</td>"
                                + "<td>" + mis4.r_yard_meeting_fpi + "</td>"
                                + "<td>" + mis4.r_fortnightly_meeting_fpi + "</td>"
                                + "<td>" + mis4.r_union_fp_committee_fpi + "</td>"
                                + "<td>" + mis4.r_satellite_clinic_presence_fpi + "</td>"
                                + "<td>" + mis4.r_terget_clinic + "</td>"
                                + "<td>" + mis4.r_achieved_clinic + "</td>"
                                + "<td>" + mis4.r_terget_sacmo_nsv_client_refer + "</td>"
                                + "<td>" + mis4.r_achieved_sacmo_nsv_client_refer + "</td>"
                                + "<td>" + mis4.r_delivery_facility + "</td>"
                                + "<td>" + mis4.r_normaldelivery_uhnfwc + "</td>"
                                + "<td>" + mis4.r_normaldelivery_mcwc + "</td>"
                                + "<td>" + mis4.r_csectiondelivery_mcwc + "</td>"
                                + "<td>" + mis4.r_others_forcep_center_mcwc + "</td>"
                                + "<td>" + mis4.r_maternal_child_welfare_total + "</td>"
                                + "<td>" + mis4.r_zero_to_fifty_nine_month_child + "</td>"
                                + "<td>" + mis4.r_two_to_five_years_child + "</td>"
                                + "</tr>");

                        $('#mis4Page10').append("<tr>"
                                + "<td>" + (unionIndex + 1) + "</td>"
                                + "<td>" + union.unionname + "</td>"
                                + "<td>" + mis4.r_preg_anc_service_visit1_csba_ + "</td>"
                                + "<td>" + mis4.r_preg_anc_service_visit2_csba_ + "</td>"
                                + "<td>" + mis4.r_preg_anc_service_visit3_csba_ + "</td>"
                                + "<td>" + mis4.r_preg_anc_service_visit4_csba_ + "</td>"
                                + "<td>" + mis4.r_preg_anc_counselling_after_delivery_csba_ + "</td>"
                                + "<td>" + mis4.r_preg_anc_misoprostol_supplied_csba_ + "</td>"
                                + "<td>" + mis4.r_preg_anc_chlorohexidin_supplied_csba_ + "</td>"
                                + "<td>" + mis4.r_delivary_service_delivery_done_csba_ + "</td>"
                                + "<td>" + mis4.r_delivary_service_3rd_amtsl_csba_ + "</td>"
                                + "<td>" + mis4.r_delivary_service_misoprostol_taken_csba_ + "</td>"
                                + "<td>" + mis4.r_pnc_mother_visit1_csba_ + "</td>"
                                + "<td>" + mis4.r_pnc_mother_visit2_csba_ + "</td>"
                                + "<td>" + mis4.r_pnc_mother_visit3_csba_ + "</td>"
                                + "<td>" + mis4.r_pnc_mother_visit4_csba_ + "</td>"
                                + "<td>" + mis4.r_pnc_mother_home_delivery_training_csba_ + "</td>"
                                + "<td>" + mis4.r_pnc_mother_family_planning_counselling_csba_ + "</td>"
                                + "<td>" + mis4.r_newborn_1min_washed_csba_ + "</td>"
                                + "<td>" + mis4.r_newborn_71_chlorohexidin_used_csba_ + "</td>"
                                + "<td>" + mis4.r_newborn_with_mother_skin_csba_ + "</td>"
                                + "<td>" + mis4.r_newborn_1hr_bfeeded_csba_ + "</td>"
                                + "<td>" + mis4.r_newborn_diff_breathing_resassite_csba_ + "</td>"
                                + "<td>" + mis4.r_pnc_newborn_visit1_csba_ + "</td>"
                                + "<td>" + mis4.r_pnc_newborn_visit2_csba_ + "</td>"
                                + "<td>" + mis4.r_pnc_newborn_visit3_csba_ + "</td>"
                                + "<td>" + mis4.r_pnc_newborn_visit4_csba_ + "</td>"
                                + "<td>" + mis4.r_ref_risky_preg_cnt_csba_ + "</td>"
                                + "<td>" + mis4.r_ref_eclampsia_mgso4_inj_refer_csba_ + "</td>"
                                + "<td>" + mis4.r_ref_newborn_difficulty_csba_ + "</td>"
                                + "<td>" + mis4.r_tot_live_birth_csba_ + "</td>"
                                + "<td>" + mis4.r_immature_birth_csba_ + "</td>"
                                + "<td>" + mis4.r_still_birth_csba_ + "</td>"
                                + "</tr>");

                        $('#mis4Page19').append("<tr>" + getLMISData(unionIndex, union.unionname, mis4) + '</tr>"');
                    }
                });

                if (!isSubmitted) {
                    $.each(Object.keys($.MIS4.page), function (i, o) {
                        $($.MIS4.page[o]).append("<tr class='not-submitted'>\n" + $.MIS4.renderRow($.MIS4.pageLength[o], '&nbsp;', (unionIndex + 1), union.unionname));
                    });
//                    for (var i = 1; i < Object.keys($.MIS4.page).length; i++) {
//                        //(length, text, serial, union)
//                        $($.MIS4.page[i]).append("<tr class='not-submitted'>\n" + $.MIS4.renderRow($.MIS4.pageLength[i], '&nbsp;', (unionIndex + 1), union.unionname));
//                    }
                }
            });
            //End rendering

            //summation rendering    
            var govt_car = e2b(((cal.sum.r_unit_all_total_tot / cal.sum.r_unit_capable_elco_tot) * 100).toFixed(2));
            
            /*$.each(Object.keys($.MIS4.page), function (index, i) {
                $($.MIS4.page[i]).append("<tr>\n" + getTotalCountRow(cal, i, govt_car, "সরকারি সংস্থার মোট") + "</tr>");
                if (json.ngo != undefined) {
                    var final_cal = new Calc([cal.sum, json.ngo[0], json.ngo[1]]);
                    $('#unit_all_total_tot').html(e2b(final_cal.sum.r_unit_all_total_tot));
                    $('#unit_capable_elco_tot').html(e2b(final_cal.sum.r_unit_capable_elco_tot));
                    var car = e2b(((final_cal.sum.r_unit_all_total_tot / final_cal.sum.r_unit_capable_elco_tot) * 100).toFixed(2));
                    $('#car').html(car);
                    $($.MIS4.page[i]).append("<tr>\n" + getTotalCountRow(new Calc([json.ngo[0]]), i, json.ngo[0].r_car, "*অসরকারি সংস্থার মোট") + "</tr>");
                    $($.MIS4.page[i]).append("<tr>\n" + getTotalCountRow(new Calc([json.ngo[1]]), i, json.ngo[1].r_car, "*বহুমূখী সংস্থার মোট") + "</tr>");
                    $($.MIS4.page[i]).append("<tr>\n" + getTotalCountRow(final_cal, i, car, "উপজেলা/থানার মোট") + "</tr>");

                } else {
                    $('#unit_all_total_tot').html(e2b(cal.sum.r_unit_all_total_tot));
                    $('#unit_capable_elco_tot').html(e2b(cal.sum.r_unit_capable_elco_tot));
                    var car = e2b(((cal.sum.r_unit_all_total_tot / cal.sum.r_unit_capable_elco_tot) * 100).toFixed(2));
                    $('#car').html(govt_car);

                    $($.MIS4.page[i]).append(getStaticRow($.MIS4.pageLength[i]));
                    $($.MIS4.page[i]).append("<tr>\n" + getTotalCountRow(cal, i, car, "উপজেলা/থানার মোট") + "</tr>");
                }
            });*/

            for (var i = 1; i < 10; i++) {
                $($.MIS4.page[i]).append("<tr>\n" + getTotalCountRow(cal, i, govt_car, "সরকারি সংস্থার মোট") + "</tr>");

                if (json.ngo != undefined) {
                    var final_cal = new Calc([cal.sum, json.ngo[0], json.ngo[1]]);
                    $('#unit_all_total_tot').html(e2b(final_cal.sum.r_unit_all_total_tot));
                    $('#unit_capable_elco_tot').html(e2b(final_cal.sum.r_unit_capable_elco_tot));
                    var car = e2b(((final_cal.sum.r_unit_all_total_tot / final_cal.sum.r_unit_capable_elco_tot) * 100).toFixed(2));
                    $('#car').html(car);
                    $($.MIS4.page[i]).append("<tr>\n" + getTotalCountRow(new Calc([json.ngo[0]]), i, json.ngo[0].r_car, "*অসরকারি সংস্থার মোট") + "</tr>");
                    $($.MIS4.page[i]).append("<tr>\n" + getTotalCountRow(new Calc([json.ngo[1]]), i, json.ngo[1].r_car, "*বহুমূখী সংস্থার মোট") + "</tr>");
                    $($.MIS4.page[i]).append("<tr>\n" + getTotalCountRow(final_cal, i, car, "উপজেলা/থানার মোট") + "</tr>");

                } else {
                    $('#unit_all_total_tot').html(e2b(cal.sum.r_unit_all_total_tot));
                    $('#unit_capable_elco_tot').html(e2b(cal.sum.r_unit_capable_elco_tot));
                    var car = e2b(((cal.sum.r_unit_all_total_tot / cal.sum.r_unit_capable_elco_tot) * 100).toFixed(2));
                    $('#car').html(govt_car);

                    $($.MIS4.page[i]).append(getStaticRow($.MIS4.pageLength[i]));
                    $($.MIS4.page[i]).append("<tr>\n" + getTotalCountRow(cal, i, car, "উপজেলা/থানার মোট") + "</tr>");
                }
            }
            $("#mis4Page10").append("<tr>\n" + getTotalCountRow(cal, i, govt_car, "উপজেলা/থানার মোট") + "</tr>");
            $("#mis4Page19").append("<tr>\n" + getTotalCountRow(cal, 19, govt_car, "উপজেলা/থানার মোট") + "</tr>");

            //Replace undefine keyword
            $.each($.MIS4.page, function (index, val) {
                $('table').find(val).find('tr').find('td').text(function () {
                    if ($(this).text() == "undefined" || $(this).text() == "null" || $(this).text() == "0" || $(this).text() == "০") {
                        return "-"
                    } else {
                        if ($.isNumeric($(this).text())) {
                            return e2b($(this).text());
                        }
                    }
                });
            });
            //////

        },
        getAreaData: function () {
            var row = {};
            $('#areaPanel').each(function (i, tr) {
                $(this).find('select').each(function () {
                    row[$(this).attr('id')] = $(this).val();
                });
            });
            return row;
        },
        setArea: function (monthyear, upazilaValue, districtValue) {
            $('#monthyear').html(" <b>" + monthyear + "</b>");
            $('#upazilaValue').html(" <b>" + upazilaValue + "</b>");
            $('#districtValue').html(" <b>" + districtValue + "</b>");
        },
        cleanMIS4: function () {
            $.each(Object.keys($.MIS4.page), function (i, o) {
                $('#mis4Page' + o).html("");
            });
        },
        clearMIS4: function () {
            $.MIS4.setArea(this.dots, this.dots, this.dots, this.dots);
            //clean mis4 loaded table
            $('#data-table').html($.MIS4.html);
            $(".r-v").parent().addClass("v-b text-left");
        },
        renderRow: function (length, text, serial, union) {
            var row = "<td>" + serial + "</td>\n";
            row += "<td>" + union + "</td>\n";
            for (var j = 2; j < length; j++) {
                row += "<td>" + text + "</td>\n";
            }
            return row;
        },
    };
    $.MIS4.init();
});








function getTotalCountRow(json, page, car, title) {
    var row = "", one = "";
    if (page == 1) {
        row = "<td colspan='2' rowspan='1' class='left''>" + title + "</td>"
                + "<td>" + json.sum.r_unit_capable_elco_tot + "</td>"
                + "<td>" + json.sum.r_old_pill_normal + "</td>"
                + "<td>" + json.sum.r_new_pill_normal + "</td>"
                + "<td>" + json.sum.r_curr_month_pill_normal_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_pill_normal + "</td>"
                + "<td>" + json.sum.r_curr_m_left_pill_oth_method_normal + "</td>"
                + "<td>" + json.sum.r_old_pill_after_delivery + "</td>"
                + "<td>" + json.sum.r_new_pill_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_month_pill_after_delivery_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_pill_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_pill_oth_method_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_ppfp_expired_pill_after_delivery + "</td>"
                + "<td>" + json.sum.r_pill_total + "</td>"
                + "<td>" + json.sum.r_old_condom_normal + "</td>"
                + "<td>" + json.sum.r_new_condom_normal + "</td>"
                + "<td>" + json.sum.r_curr_month_condom_normal_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_condom_normal + "</td>"
                + "<td>" + json.sum.r_curr_m_left_condom_oth_method_normal + "</td>"
                + "<td>" + json.sum.r_old_condom_after_delivery + "</td>"
                + "<td>" + json.sum.r_new_condom_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_month_condom_after_delivery_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_condom_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_condom_oth_method_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_ppfp_expired_condom_after_delivery + "</td>"
                + "<td>" + json.sum.r_condom_total + "</td>";

    } else if (page == 2) {
        row = "<td colspan='2' rowspan='1' class='left''>" + title + "</td>"
                + "<td>" + json.sum.r_old_inject_normal + "</td>"
                + "<td>" + json.sum.r_new_inject_normal + "</td>"
                + "<td>" + json.sum.r_curr_month_inject_normal_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_inject_normal + "</td>"
                + "<td>" + json.sum.r_curr_m_left_inj_oth_method_normal + "</td>"
                + "<td>" + json.sum.r_old_inject_after_delivery + "</td>"
                + "<td>" + json.sum.r_new_inject_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_month_inject_after_delivery_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_inject_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_inj_oth_method_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_ppfp_expired_inject_after_delivery + "</td>"
                + "<td>" + json.sum.r_injectable_total + "</td>"
                + "<td>" + json.sum.r_old_iud_normal + "</td>"
                + "<td>" + json.sum.r_new_iud_normal + "</td>"
                + "<td>" + json.sum.r_curr_month_iud_normal_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_iud_normal + "</td>"
                + "<td>" + json.sum.r_curr_m_left_iud_oth_method_normal + "</td>"
                + "<td>" + json.sum.r_old_iud_after_delivery + "</td>"
                + "<td>" + json.sum.r_new_iud_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_month_iud_after_delivery_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_iud_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_iud_oth_method_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_ppfp_expired_iud_after_delivery + "</td>"
                + "<td>" + json.sum.r_iud_total + "</td>";

    } else if (page == 3) {
        row = "<td colspan='2' rowspan='1' class='left''>" + title + "</td>"
                + "<td>" + json.sum.r_old_implant_normal + "</td>"
                + "<td>" + json.sum.r_new_implant_normal + "</td>"
                + "<td>" + json.sum.r_curr_month_implant_normal_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_implant_normal + "</td>"
                + "<td>" + json.sum.r_curr_m_left_implant_oth_method_normal + "</td>"
                + "<td>" + json.sum.r_old_implant_after_delivery + "</td>"
                + "<td>" + json.sum.r_new_implant_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_month_implant_after_delivery_total + "</td>"
                + "<td>" + json.sum.r_curr_month_left_no_method_implant_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_implant_oth_method_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_m_left_ppfp_expired_implan_after_delivery + "</td>"
                + "<td>" + json.sum.r_implant_total + "</td>"
                + "<td>" + json.sum.r_old_permanent_man_normal + "</td>"
                + "<td>" + json.sum.r_new_permanent_man_normal + "</td>"
                + "<td>" + json.sum.r_curr_month_permanent_normal_man + "</td>"
                + "<td>" + json.sum.r_old_permanent_man_after_delivery + "</td>"
                + "<td>" + json.sum.r_new_permanent_man_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_month_permanent_after_delivery_man + "</td>"
                + "<td>" + json.sum.r_permanent_method_men_total + "</td>"
                + "<td>" + json.sum.r_old_permanent_woman_normal + "</td>"
                + "<td>" + json.sum.r_new_permanent_woman_normal + "</td>"
                + "<td>" + json.sum.r_curr_month_permanent_normal_woman + "</td>"
                + "<td>" + json.sum.r_old_permanent_woman_after_delivery + "</td>"
                + "<td>" + json.sum.r_new_permanent_woman_after_delivery + "</td>"
                + "<td>" + json.sum.r_curr_month_permanent_after_delivery_woman + "</td>"
                + "<td>" + json.sum.r_permanent_method_woman_total + "</td>"
                + "<td>" + json.sum.r_curr_m_left_ppfp_expired_all_tot + "</td>"
                + "<td>" + json.sum.r_total_permanent_method + "</td>"
                + "<td>" + json.sum.r_curr_month_normal_total + "</td>"
                + "<td>" + json.sum.r_curr_month_after_delivery_total + "</td>"
                + "<td>" + json.sum.r_unit_all_total_tot + "</td>"
                + "<td>" + car + "</td>"
                + "<td>" + json.sum.r_pac_mr_mrm_after_fp + "</td>";

    } else if (page == 4) {
        row = "<td colspan='2' rowspan='1' class='left''>" + title + "</td>"
                + "<td>" + json.sum.r_curr_m_v_new_elco_tot + "</td>"
                + "<td>" + json.sum.r_curr_month_preg_new_fwa + "</td>"
                + "<td>" + json.sum.r_curr_month_preg_old_fwa + "</td>"
                + "<td>" + json.sum.r_curr_month_preg_tot_fwa + "</td>"
                + "<td>" + json.sum.r_priv_month_tot_preg_fwa + "</td>"
                + "<td>" + json.sum.r_unit_tot_preg_fwa + "</td>"
                + "<td>" + json.sum.r_preg_anc_service_visit1_csba + "</td>"
                + "<td>" + json.sum.r_preg_anc_service_visit2_csba + "</td>"
                + "<td>" + json.sum.r_preg_anc_service_visit3_csba + "</td>"
                + "<td>" + json.sum.r_preg_anc_service_visit4_csba + "</td>"
                + "<td>" + json.sum.r_preg_anc_counselling_after_delivery_csba + "</td>"
                + "<td>" + json.sum.r_preg_anc_misoprostol_supplied_csba + "</td>"
                + "<td>" + json.sum.r_preg_anc_chlorohexidin_supplied_csba + "</td>"
                + "<td>" + json.sum.r_ancadvicecenter_ancadvicesatelite + "</td>"
                + "<td>" + json.sum.r_ancAntinatalKortisatelite + "</td>"
                + "<td>" + json.sum.r_delivary_service_home_trained_fwa + "</td>"
                + "<td>" + json.sum.r_delivary_service_home_untrained_fwa + "</td>"
                + "<td>" + json.sum.r_delivary_service_hospital_normal_fwa + "</td>"
                + "<td>" + json.sum.r_delivary_service_hospital_operation_fwa + "</td>"
                + "<td>" + json.sum.r_others_forcep_center + "</td>"
                + "<td>" + json.sum.r_amtsl + "</td>"
                + "<td>" + json.sum.r_partograph_using_center + "</td>"
                + "<td>" + json.sum.r_deliveryIPHcenter + "</td>"
                + "<td>" + json.sum.r_one_hundred_eight + "</td>"
                + "<td>" + json.sum.r_pacservicecount + "</td>"
                + "<td>" + json.sum.r_anchighpreeclampsia + "</td>";

    } else if (page == 5) {
        row = "<td colspan='2' rowspan='1' class='left''>" + title + "</td>"
                + "<td>" + json.sum.r_pnc_mother_visit1_csba + "</td>"
                + "<td>" + json.sum.r_pnc_mother_visit2_csba + "</td>"
                + "<td>" + json.sum.r_pnc_mother_visit3_csba + "</td>"
                + "<td>" + json.sum.r_pnc_mother_visit4_csba + "</td>"
                + "<td>" + json.sum.r_pnc_mother_home_delivery_training_csba + "</td>"
                + "<td>" + json.sum.r_pnc_mother_family_planning_counselling_csba + "</td>"
                + "<td>" + json.sum.r_pncmotherPPH + "</td>"
                + "<td>" + json.sum.r_newborn_1min_washed_csba + "</td>"
                + "<td>" + json.sum.r_newborn_71_chlorohexidin_used_csba + "</td>"
                + "<td>" + json.sum.r_newborn_with_mother_skin_csba + "</td>"
                + "<td>" + json.sum.r_newborn_1hr_bfeeded_csba + "</td>"
                + "<td>" + json.sum.r_newborn_diff_breathing_resassite_csba + "</td>"
                + "<td>" + json.sum.r_pnc_newborn_visit1_csba + "</td>"
                + "<td>" + json.sum.r_pnc_newborn_visit2_csba + "</td>"
                + "<td>" + json.sum.r_pnc_newborn_visit3_csba + "</td>"
                + "<td>" + json.sum.r_pnc_newborn_visit4_csba + "</td>"
                + "<td>" + json.sum.r_one_hundred_twenty_seven + "</td>"
                + "<td>" + json.sum.r_ref_eclampsia_mgso4_inj_refer_csba + "</td>"
                + "<td>" + json.sum.r_deliveryrefer + "</td>"
                + "<td>" + json.sum.r_pncmotherrefer + "</td>"
                + "<td>" + json.sum.r_ref_newborn_difficulty_csba + "</td>"
                + "<td>" + json.sum.r_infertile_consultstatus + "</td>"
                + "<td>" + json.sum.r_infertile_referstatus + "</td>";

    } else if (page == 6) {
        row = "<td colspan='2' rowspan='1' class='left''>" + title + "</td>"
                + "<td>" + json.sum.r_tt_women_1st_fwa + "</td>"
                + "<td>" + json.sum.r_tt_women_2nd_fwa + "</td>"
                + "<td>" + json.sum.r_tt_women_3rd_fwa + "</td>"
                + "<td>" + json.sum.r_tt_women_4th_fwa + "</td>"
                + "<td>" + json.sum.r_tt_women_5th_fwa + "</td>"
                + "<td>" + json.sum.r_ecp_taken + "</td>"
                + "<td>" + json.sum.r_teen_counseling_adolescent_change_fwa + "</td>"
                + "<td>" + json.sum.r_teen_counseling_child_marriage_preg_effect_fwa + "</td>"
                + "<td>" + json.sum.r_teen_counseling_iron_folic_fwa + "</td>"
                + "<td>" + json.sum.r_teen_counseling_iron_folic_distribution_fwa + "</td>"
                + "<td>" + json.sum.r_teen_counseling_sexual_disease_fwa + "</td>"
                + "<td>" + json.sum.r_one_hundred_fourty_five + "</td>"
                + "<td>" + json.sum.r_teen_counseling_healthy_balanced_diet_fwa + "</td>"
                + "<td>" + json.sum.r_teen_counseling_adolescence_violence_prevention_fwa + "</td>"
                + "<td>" + json.sum.r_teen_counseling_mental_prob_drug_addict_prevention_fwa + "</td>"
                + "<td>" + json.sum.r_teen_counseling_cleanliness_sanitary_pad_fwa + "</td>"
                + "<td>" + json.sum.r_teen_counseling_referred_fwa + "</td>"
                + "<td>" + json.sum.r_gp_rta_sta_all + "</td>"
                + "<td>" + json.sum.r_mr_mva_treatment + "</td>"
                + "<td>" + json.sum.r_mrm_treatment + "</td>"
                + "<td>" + json.sum.r_total_via_positive + "</td>"
                + "<td>" + json.sum.r_total_via_negative + "</td>"
                + "<td>" + json.sum.r_total_cbe_positive + "</td>"
                + "<td>" + json.sum.r_total_cbe_negative + "</td>";

    } else if (page == 7) {
        row = "<td colspan='2' rowspan='1' class='left''>" + title + "</td>"
                + "<td>" + json.sum.r_kmc_started_child + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_bcg_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_pentavalent_1_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_pentavalent_2_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_pentavalent_3_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_pcv1_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_pcv2_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_pcv3_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_bopv_1_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_bopv_2_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_bopv_3_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_ipv_1_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_ipv_2_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_mr_1_fwa + "</td>"
                + "<td>" + json.sum.r_vaccinated_child_0to15mnths_mr_2_fwa + "</td>"
                + "<td>" + json.sum.r_referred_child_dangerous_disease_fwa + "</td>"
                + "<td>" + json.sum.r_referred_child_neumonia_fwa + "</td>"
                + "<td>" + json.sum.r_referred_child_diahoea_fwa + "</td>"
                + "<td>" + json.sum.r_tot_live_birth_fwa + "</td>"
                + "<td>" + json.sum.r_less_weight_birth_less_then_2500g_fwa + "</td>"
                + "<td>" + json.sum.r_less_weight_birth_less_then_2000g_fwa + "</td>"
                + "<td>" + json.sum.r_immature_birth_fwa + "</td>"
                + "<td>" + json.sum.r_still_birth_fwa + "</td>"
                + "<td>" + json.sum.r_death_number_less_1yr_0to7days_fwa + "</td>"
                + "<td>" + json.sum.r_death_number_less_1yr_8to28days_fwa + "</td>"
                + "<td>" + json.sum.r_death_number_less_1yr_29dystoless1yr_fwa + "</td>"
                + "<td>" + json.sum.r_death_number_less_1yr_tot_fwa + "</td>"
                + "<td>" + json.sum.r_death_number_1yrto5yr_fwa + "</td>"
                + "<td>" + json.sum.r_death_number_maternal_death_fwa + "</td>"
                + "<td>" + json.sum.r_death_number_other_death_fwa + "</td>"
                + "<td>" + json.sum.r_death_number_all_death_fwa + "</td>";

    } else if (page == 8) {
        row = "<td colspan='2' rowspan='1' class='left''>" + title + "</td>"
                + "<td>" + json.sum.r_gp_male + "</td>"
                + "<td>" + json.sum.r_gp_female + "</td>"
                + "<td>" + json.sum.r_gp_outdoor_child_0_1 + "</td>"
                + "<td>" + json.sum.r_gp_outdoor_child_1_5 + "</td>"
                + "<td>" + json.sum.r_external_other_patient + "</td>"
                + "<td>" + json.sum.r_total_outdoor_patient + "</td>"
                + "<td>" + json.sum.r_internal_female_patient + "</td>"
                + "<td>" + json.sum.r_internal_oneyear_child_patient + "</td>"
                + "<td>" + json.sum.r_internal_onetofive_child_patient + "</td>"
                + "<td>" + json.sum.r_total_indoor_patient + "</td>"
                + "<td>" + json.sum.r_bcc_done + "</td>"
                + "<td>" + json.sum.r_sacmo_done + "</td>"
                + "<td>" + json.sum.r_nutrition_iycf_counseling + "</td>"
                + "<td>" + json.sum.r_iron_folicacid_distribute_preg_woman + "</td>"
                + "<td>" + json.sum.r_iron_folicacid_distribute_child_0to23months + "</td>"
                + "<td>" + json.sum.r_child_number_0to6mon + "</td>"
                + "<td>" + json.sum.r_birth_1hr_bfeed_0to6mon + "</td>"
                + "<td>" + json.sum.r_birth_only_bfeed_0to6mon + "</td>"
                + "<td>" + json.sum.r_v0_59_child_complementary_food_6to23mon + "</td>"
                + "<td>" + json.sum.r_v0_59_child_complementary_food_24to59mon + "</td>"
                + "<td>" + json.sum.r_v6_59_month_child_vitamin_a_given + "</td>"
                + "<td>" + json.sum.r_v24_59_month_child_wormpills_given + "</td>"
                + "<td>" + json.sum.r_v6_59_child_saline_given + "</td>"
                + "<td>" + json.sum.r_v6_59_gmp + "</td>"
                + "<td>" + json.sum.r_mnp_given_24toless60mon__mam_child_0to6mon + "</td>"
                + "<td>" + json.sum.r_mam_child_24to60mon__sam_child_0to6mon + "</td>"
                + "<td>" + json.sum.r_stunting + "</td>"
                + "<td>" + json.sum.r_wasting + "</td>"
                + "<td>" + json.sum.r_under_weight + "</td>";

    } else if (page == 9) {
        row = "<td colspan='2' rowspan='1' class='left''>" + title + "</td>"
                + "<td>" + json.sum.r_satelite_clinic_presence + "</td>"
                + "<td>" + json.sum.r_epi_session_presence + "</td>"
                + "<td>" + json.sum.r_community_clinic_presence + "</td>"
                + "<td>" + json.sum.r_yard_meeting_presence + "</td>"
                + "<td>" + json.sum.r_nsv_inspired_fpi + "</td>"
                + "<td>" + json.sum.r_av_van_display_fpi + "</td>"
                + "<td>" + json.sum.r_elco_day_count_fpi + "</td>"
                + "<td>" + json.sum.r_no_of_elco_count_fpi + "</td>"
                + "<td>" + json.sum.r_fwa_register_fpi + "</td>"
                + "<td>" + json.sum.r_yard_meeting_fpi + "</td>"
                + "<td>" + json.sum.r_fortnightly_meeting_fpi + "</td>"
                + "<td>" + json.sum.r_union_fp_committee_fpi + "</td>"
                + "<td>" + json.sum.r_satellite_clinic_presence_fpi + "</td>"
                + "<td>" + json.sum.r_terget_clinic + "</td>"
                + "<td>" + json.sum.r_achieved_clinic + "</td>"
                + "<td>" + json.sum.r_terget_sacmo_nsv_client_refer + "</td>"
                + "<td>" + json.sum.r_achieved_sacmo_nsv_client_refer + "</td>"
                + "<td>" + json.sum.r_delivery_facility + "</td>"
                + "<td>" + json.sum.r_normaldelivery_uhnfwc + "</td>"
                + "<td>" + json.sum.r_normaldelivery_mcwc + "</td>"
                + "<td>" + json.sum.r_csectiondelivery_mcwc + "</td>"
                + "<td>" + json.sum.r_others_forcep_center_mcwc + "</td>"
                + "<td>" + json.sum.r_maternal_child_welfare_total + "</td>"
                + "<td>" + json.sum.r_zero_to_fifty_nine_month_child + "</td>"
                + "<td>" + json.sum.r_two_to_five_years_child + "</td>";

    } else if (page == 10) {
        row = "<td colspan='2' rowspan='1' class='left''>" + title + "</td>"
                + "<td>" + json.sum.r_preg_anc_service_visit1_csba_ + "</td>"
                + "<td>" + json.sum.r_preg_anc_service_visit2_csba_ + "</td>"
                + "<td>" + json.sum.r_preg_anc_service_visit3_csba_ + "</td>"
                + "<td>" + json.sum.r_preg_anc_service_visit4_csba_ + "</td>"
                + "<td>" + json.sum.r_preg_anc_counselling_after_delivery_csba_ + "</td>"
                + "<td>" + json.sum.r_preg_anc_misoprostol_supplied_csba_ + "</td>"
                + "<td>" + json.sum.r_preg_anc_chlorohexidin_supplied_csba_ + "</td>"
                + "<td>" + json.sum.r_delivary_service_delivery_done_csba_ + "</td>"
                + "<td>" + json.sum.r_delivary_service_3rd_amtsl_csba_ + "</td>"
                + "<td>" + json.sum.r_delivary_service_misoprostol_taken_csba_ + "</td>"
                + "<td>" + json.sum.r_pnc_mother_visit1_csba_ + "</td>"
                + "<td>" + json.sum.r_pnc_mother_visit2_csba_ + "</td>"
                + "<td>" + json.sum.r_pnc_mother_visit3_csba_ + "</td>"
                + "<td>" + json.sum.r_pnc_mother_visit4_csba_ + "</td>"
                + "<td>" + json.sum.r_pnc_mother_home_delivery_training_csba_ + "</td>"
                + "<td>" + json.sum.r_pnc_mother_family_planning_counselling_csba_ + "</td>"
                + "<td>" + json.sum.r_newborn_1min_washed_csba_ + "</td>"
                + "<td>" + json.sum.r_newborn_71_chlorohexidin_used_csba_ + "</td>"
                + "<td>" + json.sum.r_newborn_with_mother_skin_csba_ + "</td>"
                + "<td>" + json.sum.r_newborn_1hr_bfeeded_csba_ + "</td>"
                + "<td>" + json.sum.r_newborn_diff_breathing_resassite_csba_ + "</td>"
                + "<td>" + json.sum.r_pnc_newborn_visit1_csba_ + "</td>"
                + "<td>" + json.sum.r_pnc_newborn_visit2_csba_ + "</td>"
                + "<td>" + json.sum.r_pnc_newborn_visit3_csba_ + "</td>"
                + "<td>" + json.sum.r_pnc_newborn_visit4_csba_ + "</td>"
                + "<td>" + json.sum.r_ref_risky_preg_cnt_csba_ + "</td>"
                + "<td>" + json.sum.r_ref_eclampsia_mgso4_inj_refer_csba_ + "</td>"
                + "<td>" + json.sum.r_ref_newborn_difficulty_csba_ + "</td>"
                + "<td>" + json.sum.r_tot_live_birth_csba_ + "</td>"
                + "<td>" + json.sum.r_immature_birth_csba_ + "</td>"
                + "<td>" + json.sum.r_still_birth_csba_ + "</td>";
    } else if (page === 19) {
        var total = getLMISData("", title, json.sum);
        row = total;
    }
    return row;
}

function getStaticRow(pageLength) {
    var blankColumn = getBlankColumn(pageLength);
    return '<tr>' +
            '<td colspan="2" class="left">*অসরকারি সংস্থার মোট</td>' +
            blankColumn +
            '</tr>' +
            '<tr>' +
            '<td colspan="2" class="left">*বহুমূখী সংস্থার মোট</td>' +
            blankColumn +
            '</tr>';
}
function getBlankColumn(pageLength) {
    var row = "";
    for (var j = 0; j < pageLength - 2; j++) {
        row += "<td>&nbsp;</td>\n";
    }
    return row;
}

function getLMISData(unionIndex, unionname, mis4) {
    var regex = /^lmis_/;
    var lmis_column = typeof (unionIndex) === 'number' ? ("<td>" + (unionIndex + 1) + "</td>" + "<td>" + unionname + "</td>") : ("<td colspan='2'>" + unionname + "</td>");
    console.log(lmis_column);
    var lmis = $.map(Object.keys(mis4), function (n, i) {
        var bool = regex.test(n);
        if (bool) {
            return n;
        }
    });
    $.map(lmis.sort(), function (n, i) {
        lmis_column += "<td" + " lmis_name_tag='" + n + "'" + ">" + mis4[n] + "</td>";
    });
    return lmis_column;
}











$(function () {
    $('#printTableBtn').click(function () {
        $('.mis4').each(function () {
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
        frameDoc.document.write('<style>.r-v {white-space: nowrap;writing-mode: vertical-rl;transform: rotate(180deg);vertical-align: bottom!important;}   #logo{margin-top: 10px;margin-right: 5px!important;width:65px;height:65px;}</style>');
        frameDoc.document.write('<style>table, th{font-weight:normal} , td{} .tg  {border-collapse:collapse;border-spacing:0;} #topheader{border: none; margin-bottom:10px;}</style>');
        frameDoc.document.write('<style>.tg td{font-family: SolaimanLipi;font-size:14px;padding:6px 8px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}</style>');
        frameDoc.document.write('<style>.tf td{font-family: SolaimanLipi;font-size:14px;padding:0px!important;padding-right: 26px!important;border-width:0px;overflow:hidden;}</style>');
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
})