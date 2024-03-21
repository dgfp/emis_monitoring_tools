$(function () {
    $.MIS = $.MIS || {
        init: function () {
            $.MIS.events.bindEvent();
        },
        events: {
            bindEvent: function () {
                $.MIS.events.viewMIS1();
            },
            viewMIS1: function () {
                $(document).off('click', '.mis1-view').on('click', '.mis1-view', function (e) {
                });
            }
        },
        ajax: {
        },
        renderMIS1: function (data) {
            var json = data.MIS, csbaJson = data.CSBA, lmis = data.LMIS;
            //=========================================Begin TOP Part==================================================================
            function setHeaderArea(row) {
                var d = {r_unit_name: 'aaa', r_ward_name: 'bbbb', r_un_name: 'ccc', r_upz_name: 'ddd', r_dist_name: 'eee'};
                if (row) {
                    d = row;
                }
                $("#unitValue").html("&nbsp;<b>" + d.r_unit_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                $("#wardValue").html("&nbsp;<b>" + d.r_ward_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                $("#unionValue").html("&nbsp;<b>" + d.r_un_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                $("#upazilaValue").html("&nbsp;<b>" + d.r_upz_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                $("#districtValue").html("&nbsp;<b>" + d.r_dist_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                $("#yearValue").html("<b>" + convertE2B($("#year :selected").text()) + "&nbsp;&nbsp;&nbsp;&nbsp;</b>");
                $("#monthValue").html("<b>" + $.app.monthBangla[$('#month').val()] + "</b>");
            }
            setHeaderArea(json[0]);
            var pdvr = $("#provCode :selected").text();
            var provider = pdvr.substr(0, pdvr.length - 8);
            $("#providerName").html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>" + provider + "</b>");
            //=========================================END TOP Part==================================================================
            var car = Number(((json[0].r_unit_all_total_tot / json[0].r_unit_capable_elco_tot) * 100).toFixed(2));
            //=========================================== Begin (Ka) Family Planing method ==================================================
            //-------------------Row-No-one-1  colum-No-one-1     ( old - Puraton )------------------------------------ 
            $("#r_old_pill").html(json[0].r_old_pill);
            $("#r_old_condom").html(json[0].r_old_condom);
            $("#r_old_inject").html(json[0].r_old_inject);
            $("#r_old_iud").html(json[0].r_old_iud);
            $("#r_old_implant").html(json[0].r_old_implant);
            $("#r_old_permanent_man").html(json[0].r_old_permanent_man);
            $("#r_old_permanent_woman").html(json[0].r_old_permanent_woman);
            $("#r_old_all_total").html(json[0].r_old_all_total);

            //-------------------Row-No-one-1  colum-No-two-2     ( new - noton )--------------------------------------
            $("#r_new_pill").html(json[0].r_new_pill);
            $("#r_new_condom").html(json[0].r_new_condom);
            $("#r_new_inject").html(json[0].r_new_inject);
            $("#r_new_iud").html(json[0].r_new_iud);
            $("#r_new_implant").html(json[0].r_new_implant);
            $("#r_new_permanent_man").html(json[0].r_new_permanent_man);
            $("#r_new_permanent_woman").html(json[0].r_new_permanent_woman);
            $("#r_new_all_total").html(json[0].r_new_all_total);

            //-------------------Row-No-one-1  colum-No-three-3     ( current_month - Cholti_maser)------------------------------------
            $("#r_curr_month_pill_total").html(json[0].r_curr_month_pill_total);
            $("#r_curr_month_condom_total").html(json[0].r_curr_month_condom_total);
            $("#r_curr_month_inject_total").html(json[0].r_curr_month_inject_total);
            $("#r_curr_month_iud_total").html(json[0].r_curr_month_iud_total);
            $("#r_curr_month_implant_total").html(json[0].r_curr_month_implant_total);
            $("#r_curr_month_permanent_man").html(json[0].r_curr_month_permanent_man);
            $("#r_curr_month_permanent_woman").html(json[0].r_curr_month_permanent_woman);
            $("#r_curr_month_all_total").html(json[0].r_curr_month_all_total);

            //-------------------Row-No-one-1  colum-No-four-4     ( Previous_month - purboborti_maser mot)-------------------------------------
            if (json[0].r_priv_month_pill_total === 'null')
                json[0].r_priv_month_pill_total = 0;
            if (json[0].r_priv_month_condom_total === 'null')
                json[0].r_priv_month_condom_total = 0;
            if (json[0].r_priv_month_inject_total === 'null')
                json[0].r_priv_month_inject_total = 0;
            if (json[0].r_priv_month_iud_total === 'null')
                json[0].r_priv_month_iud_total = 0;
            if (json[0].r_priv_month_implant_total === 'null')
                json[0].r_priv_month_implant_total = 0;
            if (json[0].r_priv_month_permanent_man === 'null')
                json[0].r_priv_month_permanent_man = 0;
            if (json[0].r_priv_month_permanent_woman === 'null')
                json[0].r_priv_month_permanent_woman = 0;
            if (json[0].r_priv_month_all_total === 'null')
                json[0].r_priv_month_all_total = 0;

            //Calculate Total
            json[0].r_priv_month_all_total = ((json[0].r_priv_month_pill_total) + (json[0].r_priv_month_condom_total) + (json[0].r_priv_month_inject_total) + (json[0].r_priv_month_iud_total) + (json[0].r_priv_month_implant_total) + (json[0].r_priv_month_permanent_man) + (json[0].r_priv_month_permanent_woman));

            $("#r_priv_month_pill_total").html(json[0].r_priv_month_pill_total);
            $("#r_priv_month_condom_total").html(json[0].r_priv_month_condom_total);
            $("#r_priv_month_inject_total").html(json[0].r_priv_month_inject_total);
            $("#r_priv_month_iud_total").html(json[0].r_priv_month_iud_total);
            $("#r_priv_month_implant_total").html(json[0].r_priv_month_implant_total);
            $("#r_priv_month_permanent_man").html(json[0].r_priv_month_permanent_man);
            $("#r_priv_month_permanent_woman").html(json[0].r_priv_month_permanent_woman);

            $("#r_priv_month_all_total").html(json[0].r_priv_month_all_total);

            //-------------------Row-No-one-1  colum-No-five-5     ( Unit_total - Uniter_sorbomot )--------------------------------------
            if (json[0].r_unit_pill_tot === 'null' || json[0].r_unit_pill_tot === 0)
                json[0].r_unit_pill_tot = ((json[0].r_curr_month_pill_total) + (json[0].r_priv_month_pill_total));

            if (json[0].r_unit_condom_tot === 'null' || json[0].r_unit_condom_tot === 0)
                json[0].r_unit_condom_tot = ((json[0].r_curr_month_condom_total) + (json[0].r_priv_month_condom_total));

            if (json[0].r_unit_inject_tot === 'null' || json[0].r_unit_inject_tot === 0)
                json[0].r_unit_inject_tot = ((json[0].r_curr_month_inject_total) + (json[0].r_priv_month_inject_total));

            if (json[0].r_unit_iud_tot === 'null' || json[0].r_unit_iud_tot === 0)
                json[0].r_unit_iud_tot = ((json[0].r_curr_month_iud_total) + (json[0].r_priv_month_iud_total));

            if (json[0].r_unit_implant_tot === 'null' || json[0].r_unit_implant_tot === 0)
                json[0].r_unit_implant_tot = ((json[0].r_curr_month_implant_total) + (json[0].r_priv_month_implant_total));

            if (json[0].r_unit_permanent_man_tot === 'null' || json[0].r_unit_permanent_man_tot === 0)
                json[0].r_unit_permanent_man_tot = ((json[0].r_curr_month_permanent_man) + (json[0].r_priv_month_permanent_man));

            if (json[0].r_unit_permanent_woman_tot === 'null' || json[0].r_unit_permanent_woman_tot === 0)
                json[0].r_unit_permanent_woman_tot = ((json[0].r_curr_month_permanent_woman) + (json[0].r_priv_month_permanent_woman));

            if (json[0].r_unit_all_total_tot === 'null' || json[0].r_unit_all_total_tot === 0)
                json[0].r_unit_all_total_tot = ((json[0].r_curr_month_all_total) + (json[0].r_priv_month_all_total));

            $("#r_unit_pill_tot").html(json[0].r_unit_pill_tot);
            $("#r_unit_condom_tot").html(json[0].r_unit_condom_tot);
            $("#r_unit_inject_tot").html(json[0].r_unit_inject_tot);
            $("#r_unit_iud_tot").html(json[0].r_unit_iud_tot);
            $("#r_unit_implant_tot").html(json[0].r_unit_implant_tot);
            $("#r_unit_permanent_man_tot").html(json[0].r_unit_permanent_man_tot);
            $("#r_unit_permanent_woman_tot").html(json[0].r_unit_permanent_woman_tot);
            $("#r_unit_all_total_tot").html(json[0].r_unit_all_total_tot);
            $("#r_unit_all_total_tot1").html(json[0].r_unit_all_total_tot);

            //-------------------Row-No-one-1  colum-No-six-6     ( current_month_left_no_method - choltimase_chere_diyese_kono_podhoti_Neini )---------------------------------------
            if (json[0].r_curr_m_left_pill_no_method === 'null')
                json[0].r_curr_m_left_pill_no_method = 0;
            if (json[0].r_curr_m_left_condom_no_method === 'null')
                json[0].r_curr_m_left_condom_no_method = 0;
            if (json[0].r_curr_m_left_inj_no_method === 'null')
                json[0].r_curr_m_left_inj_no_method = 0;
            if (json[0].r_curr_m_left_iud_no_method === 'null')
                json[0].r_curr_m_left_iud_no_method = 0;
            if (json[0].r_curr_m_left_implant_no_method === 'null')
                json[0].r_curr_m_left_implant_no_method = 0;
            if (json[0].r_curr_m_left_no_method_all_tot === 'null')
                json[0].r_curr_m_left_no_method_all_tot = 0;

            //Calculate Total
            json[0].r_curr_m_left_no_method_all_tot = ((json[0].r_curr_m_left_pill_no_method) + (json[0].r_curr_m_left_condom_no_method) + (json[0].r_curr_m_left_inj_no_method) + (json[0].r_curr_m_left_iud_no_method) + (json[0].r_curr_m_left_implant_no_method));
            $("#r_curr_m_left_pill_no_method").html(json[0].r_curr_m_left_pill_no_method);
            $("#r_curr_m_left_condom_no_method").html(json[0].r_curr_m_left_condom_no_method);
            $("#r_curr_m_left_inj_no_method").html(json[0].r_curr_m_left_inj_no_method);
            $("#r_curr_m_left_iud_no_method").html(json[0].r_curr_m_left_iud_no_method);
            $("#r_curr_m_left_implant_no_method").html(json[0].r_curr_m_left_implant_no_method);
            // $("#r_curr_m_left_per_man_no_method").html(json[0].r_curr_m_left_per_man_no_method);
            // $("#r_curr_m_left_per_woman_no_method").html(json[0].r_curr_m_left_per_woman_no_method);
            $("#r_curr_m_left_no_method_all_tot").html(json[0].r_curr_m_left_no_method_all_tot);
            //-------------------Row-No-one-1  colum-No-seven-7     ( current_month_left_other_method - choltimase_chere_diyese_ommo_podhoti_Neyeche )----------------------------------
            if (json[0].r_curr_m_left_pill_oth_method === 'null')
                json[0].r_curr_m_left_pill_oth_method = 0;
            if (json[0].r_curr_m_left_condom_oth_method === 'null')
                json[0].r_curr_m_left_condom_oth_method = 0;
            if (json[0].r_curr_m_left_inj_oth_method === 'null')
                json[0].r_curr_m_left_inj_oth_method = 0;
            if (json[0].r_curr_m_left_iud_oth_method === 'null')
                json[0].r_curr_m_left_iud_oth_method = 0;
            if (json[0].r_curr_m_left_implant_oth_method === 'null')
                json[0].r_curr_m_left_implant_oth_method = 0;
            if (json[0].r_curr_m_left_oth_method_all_tot === 'null')
                json[0].r_curr_m_left_oth_method_all_tot = 0;

            //Calculate Total
            json[0].r_curr_m_left_oth_method_all_tot = ((json[0].r_curr_m_left_pill_oth_method) + (json[0].r_curr_m_left_condom_oth_method) + (json[0].r_curr_m_left_inj_oth_method) + (json[0].r_curr_m_left_iud_oth_method) + (json[0].r_curr_m_left_implant_oth_method));
            $("#r_curr_m_left_pill_oth_method").html(json[0].r_curr_m_left_pill_oth_method);
            $("#r_curr_m_left_condom_oth_method").html(json[0].r_curr_m_left_condom_oth_method);
            $("#r_curr_m_left_inj_oth_method").html(json[0].r_curr_m_left_inj_oth_method);
            $("#r_curr_m_left_iud_oth_method").html(json[0].r_curr_m_left_iud_oth_method);
            $("#r_curr_m_left_implant_oth_method").html(json[0].r_curr_m_left_implant_oth_method);
            //$("#r_curr_m_left_per_man_oth_method").html(json[0].r_curr_m_left_per_man_oth_method);
            //$("#r_curr_m_left_per_woman_oth_mthd").html(json[0].r_curr_m_left_per_woman_oth_mthd);
            $("#r_curr_m_left_oth_method_all_tot").html(json[0].r_curr_m_left_oth_method_all_tot);
            //-------------------Row-No-one-1  colum-No-eight-8     ( sent_for_method - podhotir_jonno_preron )-----------------------------------------------------------------------------
            if (json[0].r_sent_method_inj === 'null')
                json[0].r_sent_method_inj = 0;
            if (json[0].r_sent_method_iud === 'null')
                json[0].r_sent_method_iud = 0;
            if (json[0].r_sent_method_implant === 'null')
                json[0].r_sent_method_implant = 0;
            if (json[0].r_sent_method_per_man === 'null')
                json[0].r_sent_method_per_man = 0;
            if (json[0].r_sent_method_per_woman === 'null')
                json[0].r_sent_method_per_woman = 0;
            if (json[0].r_sent_method_all_tot === 'null')
                json[0].r_sent_method_all_tot = 0;
            //Calculate Total
            json[0].r_sent_method_all_tot = ((json[0].r_sent_method_inj) + (json[0].r_sent_method_iud) + (json[0].r_sent_method_implant) + (json[0].r_sent_method_per_man) + (json[0].r_sent_method_per_woman));
            $("#r_sent_method_inj").html(json[0].r_sent_method_inj);
            $("#r_sent_method_iud").html(json[0].r_sent_method_iud);
            $("#r_sent_method_implant").html(json[0].r_sent_method_implant);
            $("#r_sent_method_per_man").html(json[0].r_sent_method_per_man);
            $("#r_sent_method_per_woman").html(json[0].r_sent_method_per_woman);
            $("#r_sent_method_all_tot").html(json[0].r_sent_method_all_tot);
            //-------------------Row-No-one-1  colum-No-nine-9     ( sent_side_effect - parsoprotikkriyar jonno preron)------------------------------------
            if (json[0].r_sent_side_effect_pill === 'null')
                json[0].r_sent_side_effect_pill = 0;
            if (json[0].r_sent_side_effect_condom === 'null')
                json[0].r_sent_side_effect_condom = 0;
            if (json[0].r_sent_side_effect_inj === 'null')
                json[0].r_sent_side_effect_inj = 0;
            if (json[0].r_sent_side_effect_iud === 'null')
                json[0].r_sent_side_effect_iud = 0;
            if (json[0].r_sent_side_effect_implant === 'null')
                json[0].r_sent_side_effect_implant = 0;
            if (json[0].r_sent_side_effect_per_man === 'null')
                json[0].r_sent_side_effect_per_man = 0;
            if (json[0].r_sent_side_effect_per_woman === 'null')
                json[0].r_sent_side_effect_per_woman = 0;
            if (json[0].r_sent_side_effect_all_tot === 'null')
                json[0].r_sent_side_effect_all_tot = 0;
            //Calculate Total
            json[0].r_sent_side_effect_all_tot = ((json[0].r_sent_side_effect_pill) + (json[0].r_sent_side_effect_condom) + (json[0].r_sent_side_effect_inj) + (json[0].r_sent_side_effect_iud) + (json[0].r_sent_side_effect_implant) + (json[0].r_sent_side_effect_per_man) + (json[0].r_sent_side_effect_per_woman));
            $("#r_sent_side_effect_pill").html(json[0].r_sent_side_effect_pill);
            $("#r_sent_side_effect_condoms").html(json[0].r_sent_side_effect_condom);
            $("#r_sent_side_effect_inj").html(json[0].r_sent_side_effect_inj);
            $("#r_sent_side_effect_iud").html(json[0].r_sent_side_effect_iud);
            $("#r_sent_side_effect_implant").html(json[0].r_sent_side_effect_implant);
            $("#r_sent_side_effect_per_man").html(json[0].r_sent_side_effect_per_man);
            $("#r_sent_side_effect_per_woman").html(json[0].r_sent_side_effect_per_woman);
            $("#r_sent_side_effect_all_tot").html(json[0].r_sent_side_effect_all_tot);
            //----------------------------------------------------Bottom Part-----------------------------------------------------
            $("#r_curr_m_shown_capable_elco_tot").html(json[0].r_curr_m_shown_capable_elco_tot);
            $("#r_priv_m_shown_capable_elco_tot").html(json[0].r_priv_m_shown_capable_elco_tot);
            $("#r_unit_capable_elco_tot").html(json[0].r_unit_capable_elco_tot);
            $("#r_unit_capable_elco_tot1").html(json[0].r_unit_capable_elco_tot);
            $("#r_curr_m_v_new_elco_tot").html(json[0].r_curr_m_v_new_elco_tot);

            var car = Number(((json[0].r_unit_all_total_tot / json[0].r_unit_capable_elco_tot) * 100).toFixed(2));
            if (car === 'null' || car === '' || !car) {
                car = 0;
            }
            $("#r_car").html(car + "%");
            //=========================================== END (Ka) Family Planing method ==================================================
            $("#curr_month_preg_old_fwa").html(json[0].r_curr_month_preg_old_fwa);
            $("#curr_month_preg_new_fwa").html(json[0].r_curr_month_preg_new_fwa);
            $("#curr_month_preg_tot_fwa").html(json[0].r_curr_month_preg_tot_fwa);

            $("#prir_month_tot_preg_fwa").html(json[0].r_prir_month_tot_preg_fwa);
            $("#unit_tot_preg_fwa").html(json[0].r_unit_tot_preg_fwa);












            //================================================CSBA part Begin=============================================
            $("#preg_anc_service_visit1_fwa").html(json[0].r_preg_anc_service_visit1_fwa);
            //$("#preg_anc_service_visit1_csba").html(csbaJson["preg_anc_service_visit1_csba"]); //CSBA
            $("#preg_anc_service_visit1_csba").html(json[0].r_preg_anc_service_visit1_csba);

            $("#preg_anc_service_visit2_fwa").html(json[0].r_preg_anc_service_visit2_fwa);
            //$("#preg_anc_service_visit2_csba").html(csbaJson["preg_anc_service_visit2_csba"]); //CSBA
            $("#preg_anc_service_visit2_csba").html(json[0].r_preg_anc_service_visit2_csba);

            $("#preg_anc_service_visit3_fwa").html(json[0].r_preg_anc_service_visit3_fwa);
            //$("#preg_anc_service_visit3_csba").html(csbaJson["preg_anc_service_visit3_csba"]); //CSBA
            $("#preg_anc_service_visit3_csba").html(json[0].r_preg_anc_service_visit3_csba);

            $("#preg_anc_service_visit4_fwa").html(json[0].r_preg_anc_service_visit4_fwa);
            //$("#preg_anc_service_visit4_csba").html(csbaJson["preg_anc_service_visit4_csba"]); //CSBA
            $("#preg_anc_service_visit4_csba").html(json[0].r_preg_anc_service_visit4_csba);

            $("#delivary_service_home_trained_fwa").html(json[0].r_delivary_service_home_trained_fwa);
            $("#delivary_service_home_untrained_fwa").html(json[0].r_delivary_service_home_untrained_fwa);

            $("#delivary_service_hospital_normal_fwa").html(json[0].r_delivary_service_hospital_normal_fwa);
            $("#delivary_service_hospital_operation_fwa").html(json[0].r_delivary_service_hospital_operation_fwa);

            //$("#delivary_service_delivery_done_csba").html(csbaJson["delivary_service_delivery_done_csba"]); //CSBA
            $("#delivary_service_delivery_done_csba").html(json[0].r_delivary_service_delivery_done_csba); //CSBA

            //$("#delivary_service_3rd_amts1_csba").html(csbaJson["delivary_service_3rd_amts1_csba"]); //CSBA
            $("#delivary_service_3rd_amts1_csba").html(json[0].r_delivary_service_3rd_amts1_csba); //CSBA

            //$("#delivary_service_misoprostol_taken_csba").html(csbaJson["delivary_service_misoprostol_taken_csba"]); //CSBA
            $("#delivary_service_misoprostol_taken_csba").html(json[0].r_delivary_service_misoprostol_taken_csba); //CSBA

            $("#pnc_mother_visit1_fwa").html(json[0].r_pnc_mother_visit1_fwa);

            //$("#pnc_mother_visit1_csba").html(csbaJson["pnc_mother_visit1_csba"]);//CSBA
            $("#pnc_mother_visit1_csba").html(json[0].r_pnc_mother_visit1_csba);//CSBA

            $("#pnc_mother_visit2_fwa").html(json[0].r_pnc_mother_visit2_fwa);

            //$("#pnc_mother_visit2_csba").html(csbaJson["pnc_mother_visit2_csba"]);//CSBA
            $("#pnc_mother_visit2_csba").html(json[0].r_pnc_mother_visit2_csba);//CSBA

            $("#pnc_mother_visit3_fwa").html(json[0].r_pnc_mother_visit3_fwa);

            //$("#pnc_mother_visit3_csba").html(csbaJson["pnc_mother_visit3_csba"]);//CSBA
            $("#pnc_mother_visit3_csba").html(json[0].r_pnc_mother_visit3_csba);//CSBA

            $("#pnc_mother_visit4_fwa").html(json[0].r_pnc_mother_visit4_fwa);
            //$("#pnc_mother_visit4_csba").html(csbaJson["pnc_mother_visit4_csba"]);//CSBA
            $("#pnc_mother_visit4_csba").html(json[0].r_pnc_mother_visit4_csba);//CSBA

            //$("#pnc_mother_family_planning_csba").html(csbaJson["pnc_mother_family_planning_csba"]);//CSBA
            $("#pnc_mother_family_planning_csba").html(json[0].r_pnc_mother_family_planning_csba);//CSBA

            $("#pnc_child_visit1_fwa").html(json[0].r_pnc_newborn_visit1_fwa);










            //$("#pnc_child_visit1_csba").html(csbaJson["pnc_child_visit1_csba"]);//CSBA
            $("#pnc_child_visit1_csba").html(json[0].r_pnc_newborn_visit1_csba);//CSBA

            $("#pnc_child_visit2_fwa").html(json[0].r_pnc_newborn_visit2_fwa);

            //$("#pnc_child_visit2_csba").html(csbaJson["pnc_child_visit2_csba"]);//CSBA
            $("#pnc_child_visit2_csba").html(json[0].r_pnc_newborn_visit2_csba);//CSBA

            $("#pnc_child_visit3_fwa").html(json[0].r_pnc_newborn_visit3_fwa);

            //$("#pnc_child_visit3_csba").html(csbaJson["pnc_child_visit3_csba"]);//CSBA
            $("#pnc_child_visit3_csba").html(json[0].r_pnc_newborn_visit3_csba);//CSBA

            $("#pnc_child_visit4_fwa").html(json[0].v_pnc_newborn_visit4_fwa);

            //$("#pnc_child_visit4_csba").html(csbaJson["pnc_child_visit4_csba"]);//CSBA
            $("#pnc_child_visit4_csba").html(json[0].r_pnc_newborn_visit4_csba);//CSBA

            $("#ref_risky_preg_cnt_fwa").html(json[0].v_ref_risky_preg_cnt_fwa);


            //CSBA Part for 2nd column=================================
            //$("#ref_preg_delivery_pnc_diff_refer_csba").html(csbaJson["ref_preg_delivery_pnc_diff_refer_csba"]); //For - ref_preg_delivery_pnc_diff_refer_csba
            $("#ref_preg_delivery_pnc_diff_refer_csba").html(json[0].v_ref_preg_delivery_pnc_diff_refer_csba); //For - ref_preg_delivery_pnc_diff_refer_csba

            //$("#ref_eclampsia_mgso4_inj_refer_csba").html(csbaJson["ref_eclampsia_mgso4_inj_refer_csba"]);//CSBA
            $("#ref_eclampsia_mgso4_inj_refer_csba").html(json[0].v_ref_eclampsia_mgso4_inj_refer_csba);//CSBA

            //$("#ref_newborn_difficulty_csba").html(csbaJson["ref_newborn_difficulty_csba"]);//CSBA
            $("#ref_newborn_difficulty_csba").html(json[0].v_ref_newborn_difficulty_csba);//CSBA
            //
//======================================== END CSBA part ======================================================















            $("#tt_women_1st_fwa").html(json[0].r_tt_women_1st_fwa);
            $("#tt_women_2nd_fwa").html(json[0].r_tt_women_2nd_fwa);
            $("#tt_women_3rd_fwa").html(json[0].r_tt_women_3rd_fwa);
            $("#tt_women_4th_fwa").html(json[0].r_tt_women_4th_fwa);
            $("#tt_women_5th_fwa").html(json[0].r_tt_women_5th_fwa);


            $("#ecp_taken").html(json[0].r_ecp_taken);
            $("#misoprostol_taken").html(json[0].r_misoprostol_taken);

            $("#childless_couple_adviced_fwa").html(json[0].v_childless_couple_adviced_fwa);
            $("#childless_couple_refered_fwa").html(json[0].v_childless_couple_refered_fwa);

            $("#teenager_counsiling_referred").html(json[0].r_teenager_counsiling_referred);
            $("#teenager_counsiling_child_marriage_child_preg_disadvantage").html(json[0].r_teenager_counsiling_child_marriage_child_preg_disadvantage);

            $("#teenager_counsiling_healthy_balanced_diet").html(json[0].r_teenager_counsiling_healthy_balanced_diet);
            $("#teenager_counsiling_sexual_disease").html(json[0].r_teenager_counsiling_sexual_disease);

            $("#satelite_clinic_presence").html(json[0].r_satelite_clinic_presence);
            $("#epi_session_presence").html(json[0].r_epi_session_presence);
            $("#community_clinic_presence").html(json[0].r_community_clinic_presence);

            $("#newborn_1min_washed_fwa").html(json[0].r_newborn_1min_washed_fwa);
            //$("#newborn_1min_washed_csba").html(json[0].r_newborn_1min_washed_csba); //CSBA
            $("#newborn_1min_washed_csba").html(json[0].r_newborn_1min_washed_csba); //CSBA real


            $("#newborn_71_chlorohexidin_used_fwa").html(json[0].r_newborn_71_chlorohexidin_used_fwa);
            // $("#newborn_71_chlorohexidin_used_csba").html(json[0].r_newborn_71_chlorohexidin_used_csba); //CSBA
            $("#newborn_71_chlorohexidin_used_csba").html(json[0].r_newborn_71_chlorohexidin_used_csba); //CSBA real

//                        $("#newborn_1hr_bfeeded_csba").html(json[0].r_newborn_1hr_bfeeded_csba); //CSBA real
//                        $("#newborn_diff_breathing_resassite_csba").html(json[0].r_newborn_diff_breathing_resassite_csba); //CSBA real
            $("#newborn_1hr_bfeeded_csba").html(json[0].r_newborn_1hr_bfeeded_csba); //CSBA real
            $("#newborn_diff_breathing_resassite_csba").html(json[0].r_newborn_diff_breathing_resassite_csba); //CSBA real

            //-------=============================Variabl name change==================================
            $("#r_vaccinated_child_0to18mnths_bcg_fwa").html(json[0].r_vaccinated_child_0to18mnths_bcg_fwa);

            $("#r_vaccinated_child_0to18mnths_pcv1_fwa").html(json[0].r_vaccinated_child_0to18mnths_pcv1_fwa);
            $("#r_vaccinated_child_0to18mnths_pcv2_fwa").html(json[0].r_vaccinated_child_0to18mnths_pcv2_fwa);
            $("#r_vaccinated_child_0to18mnths_dpt_hepb_hib_fwa").html(json[0].r_vaccinated_child_0to18mnths_dpt_hepb_hib_fwa);
            $("#r_vaccinated_child_0to18mnths_pcv3_fwa").html(json[0].r_vaccinated_child_0to18mnths_pcv3_fwa);

            $("#r_vaccinated_child_0to18mnths_mr_opv4_fwa").html(json[0].r_vaccinated_child_0to18mnths_mr_opv4_fwa);
            $("#r_vaccinated_child_0to18mnths_ham_fwa").html(json[0].r_vaccinated_child_0to18mnths_ham_fwa);

            $("#referred_child_dangerous_disease_fwa").html(json[0].r_referred_child_dangerous_disease_fwa);
            $("#referred_child_neumonia_fwa").html(json[0].r_referred_child_neumonia_fwa);
            $("#referred_child_diahoea_fwa").html(json[0].r_referred_child_diahoea_fwa);

            $("#tot_live_birth_fwa").html(json[0].r_tot_live_birth_fwa);
            //$("#tot_live_birth_csba").html(json[0].r_tot_live_birth_csba);

            $("#less_weight_birth_fwa").html(json[0].r_less_weight_birth_fwa);
            //$("#less_weight_birth_csba").html(json[0].r_less_weight_birth_csba);

            $("#immature_birth_fwa").html(json[0].r_immature_birth_fwa);
            //$("#immature_birth_csba").html(json[0].r_immature_birth_csba);

            $("#death_birth_fwa").html(json[0].r_death_birth_fwa);
            // $("#death_birth_csba").html(json[0].r_death_birth_csba);

            $("#death_number_less_1yr_0to7days_fwa").html(json[0].r_death_number_less_1yr_0to7days_fwa);
            //$("#death_number_less_1yr_0to7days_csba").html(json[0].r_death_number_less_1yr_0to7days_csba);

            $("#death_number_less_1yr_8to28days_fwa").html(json[0].r_death_number_less_1yr_8to28days_fwa);
            //$("#death_number_less_1yr_8to28days_csba").html(json[0].r_death_number_less_1yr_8to28days_csba);

            $("#death_number_less_1yr_29dystoless1yr_fwa").html(json[0].r_death_number_less_1yr_29dystoless1yr_fwa);

            $("#death_number_less_1yr_tot_fwa").html(json[0].r_death_number_less_1yr_tot_fwa);

            $("#death_number_1yrto5yr_fwa").html(json[0].r_death_number_1yrto5yr_fwa);

            $("#death_number_maternal_death_fwa").html(json[0].r_death_number_maternal_death_fwa);
            //$("#death_number_maternal_death_csba").html(json[0].r_death_number_maternal_death_csba);

            $("#death_number_other_death_fwa").html(json[0].r_death_number_other_death_fwa);

            $("#death_number_all_death_fwa").html(json[0].r_death_number_all_death_fwa);

            $("#iron_folicacid_extrafood_counsiling_preg_woman").html(json[0].r_iron_folicacid_extrafood_counsiling_preg_woman);
            $("#iron_folicacid_extrafood_counsiling_child_0to23months").html(json[0].r_iron_folicacid_extrafood_counsiling_child_0to23months);

            //=============04-03-2017================
            $("#r_iron_folicacid_distribute_preg_woman").html(json[0].r_iron_folicacid_distribute_preg_woman);
            $("#r_iron_folicacid_distribute_child_0to23months").html(json[0].r_iron_folicacid_distribute_child_0to23months);
            $("#r_mnp_ounsiling_child_0to23months").html(json[0].r_mnp_ounsiling_child_0to23months);
            //======================================

            $("#bfeeding_complementary_food_counsiling_preg_woman").html(json[0].r_bfeeding_complementary_food_counsiling_preg_woman);
            $("#bfeeding_complementary_food_counsiling_child_0to23months").html(json[0].r_bfeeding_complementary_food_counsiling_child_0to23months);

            $("#birth_1hr_bfeed_0to6mon").html(json[0].r_birth_1hr_bfeed_0to6mon);

            $("#birth_only_bfeed_0to6mon").html(json[0].r_birth_only_bfeed_0to6mon);

            //=============04-03-2017================
            $("#r_0_59_child_complementary_food_6to23mon").html(json[0].r_0_59_child_complementary_food_6to23mon);
            $("#r_0_59_child_complementary_food_24to59mon").html(json[0].r_0_59_child_complementary_food_24to59mon);
            //======================================

            $("#mnp_given_6to23mon").html(json[0].r_mnp_given_6to23mon);
            //$("#mnp_given_24toless60mon").html(json[0].r_mnp_given_24toless60mon);
            $("#sam_child_0to6mon").html(json[0].r_sam_child_0to6mon);
            $("#sam_child_6to23mon").html(json[0].r_sam_child_6to23mon);
            $("#sam_child_24toless60mon").html(json[0].r_sam_child_24toless60mon);
            $("#mam_child_0to6mon").html(json[0].r_mam_child_0to6mon);
            $("#mam_child_6to23mon").html(json[0].r_mam_child_6to23mon);
            $("#mam_child_24toless60mon").html(json[0].r_mam_child_24to60mon);
            $("#curr_month_preg_old_fwa").html(json[0].r_curr_month_preg_old_fwa);
            $("#curr_month_preg_new_fwa").html(json[0].r_curr_month_preg_new_fwa);
            $("#curr_month_preg_tot_fwa").html(json[0].r_curr_month_preg_tot_fwa);

            $("#prir_month_tot_preg_fwa").html(json[0].r_prir_month_tot_preg_fwa);
            $("#unit_tot_preg_fwa").html(json[0].r_unit_tot_preg_fwa);












            //================================================CSBA part Begin=============================================
            $("#preg_anc_service_visit1_fwa").html(json[0].r_preg_anc_service_visit1_fwa);
            //$("#preg_anc_service_visit1_csba").html(csbaJson["preg_anc_service_visit1_csba"]); //CSBA
            $("#preg_anc_service_visit1_csba").html(json[0].r_preg_anc_service_visit1_csba);

            $("#preg_anc_service_visit2_fwa").html(json[0].r_preg_anc_service_visit2_fwa);
            //$("#preg_anc_service_visit2_csba").html(csbaJson["preg_anc_service_visit2_csba"]); //CSBA
            $("#preg_anc_service_visit2_csba").html(json[0].r_preg_anc_service_visit2_csba);

            $("#preg_anc_service_visit3_fwa").html(json[0].r_preg_anc_service_visit3_fwa);
            //$("#preg_anc_service_visit3_csba").html(csbaJson["preg_anc_service_visit3_csba"]); //CSBA
            $("#preg_anc_service_visit3_csba").html(json[0].r_preg_anc_service_visit3_csba);

            $("#preg_anc_service_visit4_fwa").html(json[0].r_preg_anc_service_visit4_fwa);
            //$("#preg_anc_service_visit4_csba").html(csbaJson["preg_anc_service_visit4_csba"]); //CSBA
            $("#preg_anc_service_visit4_csba").html(json[0].r_preg_anc_service_visit4_csba);

            $("#delivary_service_home_trained_fwa").html(json[0].r_delivary_service_home_trained_fwa);
            $("#delivary_service_home_untrained_fwa").html(json[0].r_delivary_service_home_untrained_fwa);

            $("#delivary_service_hospital_normal_fwa").html(json[0].r_delivary_service_hospital_normal_fwa);
            $("#delivary_service_hospital_operation_fwa").html(json[0].r_delivary_service_hospital_operation_fwa);

            //$("#delivary_service_delivery_done_csba").html(csbaJson["delivary_service_delivery_done_csba"]); //CSBA
            $("#delivary_service_delivery_done_csba").html(json[0].r_delivary_service_delivery_done_csba); //CSBA

            //$("#delivary_service_3rd_amts1_csba").html(csbaJson["delivary_service_3rd_amts1_csba"]); //CSBA
            $("#delivary_service_3rd_amts1_csba").html(json[0].r_delivary_service_3rd_amts1_csba); //CSBA

            //$("#delivary_service_misoprostol_taken_csba").html(csbaJson["delivary_service_misoprostol_taken_csba"]); //CSBA
            $("#delivary_service_misoprostol_taken_csba").html(json[0].r_delivary_service_misoprostol_taken_csba); //CSBA

            $("#pnc_mother_visit1_fwa").html(json[0].r_pnc_mother_visit1_fwa);

            //$("#pnc_mother_visit1_csba").html(csbaJson["pnc_mother_visit1_csba"]);//CSBA
            $("#pnc_mother_visit1_csba").html(json[0].r_pnc_mother_visit1_csba);//CSBA

            $("#pnc_mother_visit2_fwa").html(json[0].r_pnc_mother_visit2_fwa);

            //$("#pnc_mother_visit2_csba").html(csbaJson["pnc_mother_visit2_csba"]);//CSBA
            $("#pnc_mother_visit2_csba").html(json[0].r_pnc_mother_visit2_csba);//CSBA

            $("#pnc_mother_visit3_fwa").html(json[0].r_pnc_mother_visit3_fwa);

            //$("#pnc_mother_visit3_csba").html(csbaJson["pnc_mother_visit3_csba"]);//CSBA
            $("#pnc_mother_visit3_csba").html(json[0].r_pnc_mother_visit3_csba);//CSBA

            $("#pnc_mother_visit4_fwa").html(json[0].r_pnc_mother_visit4_fwa);
            //$("#pnc_mother_visit4_csba").html(csbaJson["pnc_mother_visit4_csba"]);//CSBA
            $("#pnc_mother_visit4_csba").html(json[0].r_pnc_mother_visit4_csba);//CSBA

            //$("#pnc_mother_family_planning_csba").html(csbaJson["pnc_mother_family_planning_csba"]);//CSBA
            $("#pnc_mother_family_planning_csba").html(json[0].r_pnc_mother_family_planning_csba);//CSBA

            $("#pnc_child_visit1_fwa").html(json[0].r_pnc_newborn_visit1_fwa);










            //$("#pnc_child_visit1_csba").html(csbaJson["pnc_child_visit1_csba"]);//CSBA
            $("#pnc_child_visit1_csba").html(json[0].r_pnc_newborn_visit1_csba);//CSBA

            $("#pnc_child_visit2_fwa").html(json[0].r_pnc_newborn_visit2_fwa);

            //$("#pnc_child_visit2_csba").html(csbaJson["pnc_child_visit2_csba"]);//CSBA
            $("#pnc_child_visit2_csba").html(json[0].r_pnc_newborn_visit2_csba);//CSBA

            $("#pnc_child_visit3_fwa").html(json[0].r_pnc_newborn_visit3_fwa);

            //$("#pnc_child_visit3_csba").html(csbaJson["pnc_child_visit3_csba"]);//CSBA
            $("#pnc_child_visit3_csba").html(json[0].r_pnc_newborn_visit3_csba);//CSBA

            $("#pnc_child_visit4_fwa").html(json[0].v_pnc_newborn_visit4_fwa);

            //$("#pnc_child_visit4_csba").html(csbaJson["pnc_child_visit4_csba"]);//CSBA
            $("#pnc_child_visit4_csba").html(json[0].r_pnc_newborn_visit4_csba);//CSBA

            $("#ref_risky_preg_cnt_fwa").html(json[0].v_ref_risky_preg_cnt_fwa);


            //CSBA Part for 2nd column=================================
            //$("#ref_preg_delivery_pnc_diff_refer_csba").html(csbaJson["ref_preg_delivery_pnc_diff_refer_csba"]); //For - ref_preg_delivery_pnc_diff_refer_csba
            $("#ref_preg_delivery_pnc_diff_refer_csba").html(json[0].v_ref_preg_delivery_pnc_diff_refer_csba); //For - ref_preg_delivery_pnc_diff_refer_csba

            //$("#ref_eclampsia_mgso4_inj_refer_csba").html(csbaJson["ref_eclampsia_mgso4_inj_refer_csba"]);//CSBA
            $("#ref_eclampsia_mgso4_inj_refer_csba").html(json[0].v_ref_eclampsia_mgso4_inj_refer_csba);//CSBA

            //$("#ref_newborn_difficulty_csba").html(csbaJson["ref_newborn_difficulty_csba"]);//CSBA
            $("#ref_newborn_difficulty_csba").html(json[0].v_ref_newborn_difficulty_csba);//CSBA
            //
//======================================== END CSBA part ======================================================















            $("#tt_women_1st_fwa").html(json[0].r_tt_women_1st_fwa);
            $("#tt_women_2nd_fwa").html(json[0].r_tt_women_2nd_fwa);
            $("#tt_women_3rd_fwa").html(json[0].r_tt_women_3rd_fwa);
            $("#tt_women_4th_fwa").html(json[0].r_tt_women_4th_fwa);
            $("#tt_women_5th_fwa").html(json[0].r_tt_women_5th_fwa);


            $("#ecp_taken").html(json[0].r_ecp_taken);
            $("#misoprostol_taken").html(json[0].r_misoprostol_taken);

            $("#childless_couple_adviced_fwa").html(json[0].v_childless_couple_adviced_fwa);
            $("#childless_couple_refered_fwa").html(json[0].v_childless_couple_refered_fwa);

            $("#teenager_counsiling_referred").html(json[0].r_teenager_counsiling_referred);
            $("#teenager_counsiling_child_marriage_child_preg_disadvantage").html(json[0].r_teenager_counsiling_child_marriage_child_preg_disadvantage);

            $("#teenager_counsiling_healthy_balanced_diet").html(json[0].r_teenager_counsiling_healthy_balanced_diet);
            $("#teenager_counsiling_sexual_disease").html(json[0].r_teenager_counsiling_sexual_disease);

            $("#satelite_clinic_presence").html(json[0].r_satelite_clinic_presence);
            $("#epi_session_presence").html(json[0].r_epi_session_presence);
            $("#community_clinic_presence").html(json[0].r_community_clinic_presence);

            $("#newborn_1min_washed_fwa").html(json[0].r_newborn_1min_washed_fwa);
            //$("#newborn_1min_washed_csba").html(json[0].r_newborn_1min_washed_csba); //CSBA
            $("#newborn_1min_washed_csba").html(json[0].r_newborn_1min_washed_csba); //CSBA real


            $("#newborn_71_chlorohexidin_used_fwa").html(json[0].r_newborn_71_chlorohexidin_used_fwa);
            // $("#newborn_71_chlorohexidin_used_csba").html(json[0].r_newborn_71_chlorohexidin_used_csba); //CSBA
            $("#newborn_71_chlorohexidin_used_csba").html(json[0].r_newborn_71_chlorohexidin_used_csba); //CSBA real

//                        $("#newborn_1hr_bfeeded_csba").html(json[0].r_newborn_1hr_bfeeded_csba); //CSBA real
//                        $("#newborn_diff_breathing_resassite_csba").html(json[0].r_newborn_diff_breathing_resassite_csba); //CSBA real
            $("#newborn_1hr_bfeeded_csba").html(json[0].r_newborn_1hr_bfeeded_csba); //CSBA real
            $("#newborn_diff_breathing_resassite_csba").html(json[0].r_newborn_diff_breathing_resassite_csba); //CSBA real

            //-------=============================Variabl name change==================================
            $("#r_vaccinated_child_0to18mnths_bcg_fwa").html(json[0].r_vaccinated_child_0to18mnths_bcg_fwa);

            $("#r_vaccinated_child_0to18mnths_pcv1_fwa").html(json[0].r_vaccinated_child_0to18mnths_pcv1_fwa);
            $("#r_vaccinated_child_0to18mnths_pcv2_fwa").html(json[0].r_vaccinated_child_0to18mnths_pcv2_fwa);
            $("#r_vaccinated_child_0to18mnths_dpt_hepb_hib_fwa").html(json[0].r_vaccinated_child_0to18mnths_dpt_hepb_hib_fwa);
            $("#r_vaccinated_child_0to18mnths_pcv3_fwa").html(json[0].r_vaccinated_child_0to18mnths_pcv3_fwa);

            $("#r_vaccinated_child_0to18mnths_mr_opv4_fwa").html(json[0].r_vaccinated_child_0to18mnths_mr_opv4_fwa);
            $("#r_vaccinated_child_0to18mnths_ham_fwa").html(json[0].r_vaccinated_child_0to18mnths_ham_fwa);

            $("#referred_child_dangerous_disease_fwa").html(json[0].r_referred_child_dangerous_disease_fwa);
            $("#referred_child_neumonia_fwa").html(json[0].r_referred_child_neumonia_fwa);
            $("#referred_child_diahoea_fwa").html(json[0].r_referred_child_diahoea_fwa);

            $("#tot_live_birth_fwa").html(json[0].r_tot_live_birth_fwa);
            //$("#tot_live_birth_csba").html(json[0].r_tot_live_birth_csba);

            $("#less_weight_birth_fwa").html(json[0].r_less_weight_birth_fwa);
            //$("#less_weight_birth_csba").html(json[0].r_less_weight_birth_csba);

            $("#immature_birth_fwa").html(json[0].r_immature_birth_fwa);
            //$("#immature_birth_csba").html(json[0].r_immature_birth_csba);

            $("#death_birth_fwa").html(json[0].r_death_birth_fwa);
            // $("#death_birth_csba").html(json[0].r_death_birth_csba);

            $("#death_number_less_1yr_0to7days_fwa").html(json[0].r_death_number_less_1yr_0to7days_fwa);
            //$("#death_number_less_1yr_0to7days_csba").html(json[0].r_death_number_less_1yr_0to7days_csba);

            $("#death_number_less_1yr_8to28days_fwa").html(json[0].r_death_number_less_1yr_8to28days_fwa);
            //$("#death_number_less_1yr_8to28days_csba").html(json[0].r_death_number_less_1yr_8to28days_csba);

            $("#death_number_less_1yr_29dystoless1yr_fwa").html(json[0].r_death_number_less_1yr_29dystoless1yr_fwa);

            $("#death_number_less_1yr_tot_fwa").html(json[0].r_death_number_less_1yr_tot_fwa);

            $("#death_number_1yrto5yr_fwa").html(json[0].r_death_number_1yrto5yr_fwa);

            $("#death_number_maternal_death_fwa").html(json[0].r_death_number_maternal_death_fwa);
            //$("#death_number_maternal_death_csba").html(json[0].r_death_number_maternal_death_csba);

            $("#death_number_other_death_fwa").html(json[0].r_death_number_other_death_fwa);

            $("#death_number_all_death_fwa").html(json[0].r_death_number_all_death_fwa);

            $("#iron_folicacid_extrafood_counsiling_preg_woman").html(json[0].r_iron_folicacid_extrafood_counsiling_preg_woman);
            $("#iron_folicacid_extrafood_counsiling_child_0to23months").html(json[0].r_iron_folicacid_extrafood_counsiling_child_0to23months);

            //=============04-03-2017================
            $("#r_iron_folicacid_distribute_preg_woman").html(json[0].r_iron_folicacid_distribute_preg_woman);
            $("#r_iron_folicacid_distribute_child_0to23months").html(json[0].r_iron_folicacid_distribute_child_0to23months);
            $("#r_mnp_ounsiling_child_0to23months").html(json[0].r_mnp_ounsiling_child_0to23months);
            //======================================

            $("#bfeeding_complementary_food_counsiling_preg_woman").html(json[0].r_bfeeding_complementary_food_counsiling_preg_woman);
            $("#bfeeding_complementary_food_counsiling_child_0to23months").html(json[0].r_bfeeding_complementary_food_counsiling_child_0to23months);

            $("#birth_1hr_bfeed_0to6mon").html(json[0].r_birth_1hr_bfeed_0to6mon);

            $("#birth_only_bfeed_0to6mon").html(json[0].r_birth_only_bfeed_0to6mon);

            //=============04-03-2017================
            $("#r_0_59_child_complementary_food_6to23mon").html(json[0].r_0_59_child_complementary_food_6to23mon);
            $("#r_0_59_child_complementary_food_24to59mon").html(json[0].r_0_59_child_complementary_food_24to59mon);
            //======================================

            $("#mnp_given_6to23mon").html(json[0].r_mnp_given_6to23mon);
            //$("#mnp_given_24toless60mon").html(json[0].r_mnp_given_24toless60mon);
            $("#sam_child_0to6mon").html(json[0].r_sam_child_0to6mon);
            $("#sam_child_6to23mon").html(json[0].r_sam_child_6to23mon);
            $("#sam_child_24toless60mon").html(json[0].r_sam_child_24toless60mon);
            $("#mam_child_0to6mon").html(json[0].r_mam_child_0to6mon);
            $("#mam_child_6to23mon").html(json[0].r_mam_child_6to23mon);
            $("#mam_child_24toless60mon").html(json[0].r_mam_child_24to60mon);

            //LMIS
            $.each(lmis, (i, o) => {
                var item = o.itemcode
                $("#openingbalance" + item).text(o.openingbalance);
                $("#receiveqty" + item).text(o.receiveqty);
                $("#current_month_stock" + item).text(o.current_month_stock);
                $("#adjustment_plus" + item).text(o.adjustment_plus);
                $("#adjustment_minus" + item).text(o.adjustment_minus);
                $("#total" + item).text(o.total);
                $("#distribution" + item).text(o.distribution);
                $("#closingbalance" + item).text(o.closingbalance);
            });

            $(".e2b table td").each(function () {
                $(this).text(convertE2B($(this).text()));
            });
        }
    };
    $.MIS.init();
});