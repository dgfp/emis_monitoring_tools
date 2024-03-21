<%-- 
Document   : mis-form-1
Created on : Feb 18, 2017, 11:40:22 AM
Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla.js"></script>
<link href="resources/css/newStyle.css" rel="stylesheet" type="text/css"/>
<script src="resources/js/mis1.js" type="text/javascript"></script>
<script src="http://urbanhealthatlas.com/lib/jquery.formParams.js" type="text/javascript"></script>
<style>
    .callout.callout-success, .callout.callout-danger, .callout.callout-warning {
        border:none!important;
        font-size: 12px!important;
    }
    .callout {
        border-radius: 28px!important;
    }
    .mis-form-1{
        background:#87bbf9;
    }
    .table-responsive {
        border: 1px solid #87bbf9;
    }
    table, th, td {
        padding: 3px;
    }
    table.table-bordered{
        border:1px solid yellow;
    }
    table.table-bordered{
        border:1px solid #000!important;
    }
    table.table-bordered > thead > tr > th{
        border:1px solid #000!important;
    }
    table.table-bordered > tbody > tr > td{
        border:1px solid #000!important;
    }
    #slogan{
        border: 1px solid #000000;
        text-align: center;
        padding: 2px;
        margin-top: 45px;
        word-wrap: break-word;
        font-size: 13px;
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
    @font-face {
        font-family: NikoshBAN;
        src: url('resources/fonts/NikoshBAN.ttf');
    }
    .v_field{
        font-family: NikoshBAN;
        font-size: 17px;
    }
    textarea {
        resize: vertical; /* user can resize vertically, but width is fixed */
    }

    @media print {
        .box, .carTable{
            border: 0!important;
        }
        #areaPanel, #back-to-top, .box-header, .main-footer, #viewStatus{
            display: none !important;
        }
        .mis1   { display: block; page-break-before: always; }

        .table-responsive {
            border: 1px solid #fff;
        }
    }
    #month option.current~option{ display:none }
</style>
<script>
    var json = null;
    var mis1 = {
        auto: 0,
        submit: function (param) {
            mis1.auto = 1;
            param = param || {"division": "30", "district": "93", "upazila": "66", "union": "63", "unit": "2", "provCode": "93087", "month": "03", "year": "2019"};
            var $panel = $('#areaPanel .box-body'), $clone = $panel.clone().find('button').remove().end(), $input = $clone.find(':input');
            $clone.insertBefore($panel);
            $input.each(function (i, o) {
                $(o).val('')
            });

            $input.each(function (i, o) {
                var name = $(o).attr('name'), value = param[$(o).attr('name')];
                $(o).val(value);
                if ($(o).is('select') && !$(o).val()) {
                    $(o).Select([{id: value, text: value}], {placeholder: null});
                }
                console.log('panel value', name, value, $(o).val());
            });

            $('#showdataButton').trigger('click');
            $clone.remove();
            mis1.auto = 0;
        },
        approve: function () {
            $('.overlay').remove();
            console.log('approve');
        }
    }


    function getCurrentPreviousDate(currMonth, year) {
        var preMonth = Number(currMonth) - 1;
        var preYear = year;

        if (preMonth.toString().length == 1)
            preMonth = "0" + preMonth;
        if (currMonth == "01") {
            preMonth = "12";
            preYear = Number(preYear) - 1;
        }

        var current = new Date(year, currMonth, 1);
        var previous = new Date(preYear, preMonth, 1);
        var currLastDay = new Date(current.getFullYear(), current.getMonth(), 0);
        var preLastDay = new Date(previous.getFullYear(), previous.getMonth(), 0);

        return year + "-" + currMonth + "-" + "01" + "~" + year + "-" + currMonth + "-" + currLastDay.getDate() + "~" + preYear + "-" + preMonth + "-" + "01" + "~" + preYear + "-" + preMonth + "-" + preLastDay.getDate();
    }

    $(document).ready(function () {
       $.app.hideNextMonths();
       
        function setJson(data) {
            json = data;
        }

        //Mis-1 Submission and resubmission
        $('.input-group-approve', '#form-report-response').find('button').click(function (e) {
            e.preventDefault();
            //First time submission
            var id = +new Date();
            var isValided = true;
            /*
             var masterJson = {};
             var obj = {
             1: ["openingbalance"],
             2: ["receiveqty"],
             3: ["current_month_stock"],
             4: ["adjustment_plus"],
             5: ["adjustment_minus"],
             6: ["total"],
             7: ["distribution"],
             8: ["closingbalance"]
             };
             var item = {
             1: ["sukhi", "1"],
             2: ["apon", "10"],
             3: ["condom", "2"],
             4: ["inject_vayal", "3"],
             5: ["inject_syringe", "5"],
             6: ["ecp", "4"],
             7: ["misoprostol", "9"],
             8: ["mnp", "20"],
             9: ["iron", "19"]
             };
             
             $.each(item, (i, o) => {
             $.each(obj, (index, object) => {
             var context = $("input[name="+ object +"" + o[1]+"]");
             if(context.val()==""){
             toastr["error"]("<b>সকল ঘর পূরণ করুন, ডাটা না থাকলে শুন্য লিখুন</b>");
             isValided =  false
             context.css('border', '2px solid red');
             }else{
             //make lmis model json
             $.each(item, (i, o) => {
             $.each(obj, (index, object) => {
             var key =  object + "_" + o[0];
             var value = $("input[name="+ object +"" + o[1]+"]").val();
             var tempJson = {};
             tempJson[key] = value;
             $.extend( masterJson, tempJson );
             });
             });
             context.css('border', 'none');
             }
             });
             });
             */

            if (isValided) {
                $.ajax({
                    url: "mis-form-1?action=submitReport&subType=" + json.status,
                    data: {
                        divisionId: $("select#division").val(),
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val(),
                        fwaUnit: $("select#unit").val(),
                        provCode: $("select#provCode").val(),
                        month: $("select#month").val(),
                        year: $("#year").val(),
                        date: getCurrentPreviousDate($("select#month").val(), $("#year").val()),
                        data: JSON.stringify(json),
                        note: $("input[name='message']").val(), //$('#note').val(),
                        html: $('#data-table').html(),
                        submissionId: id,
                        reviewLength: $.RS.reviewJson.length
                                // lmis : JSON.stringify(masterJson)
                    },
                    type: 'POST',
                    success: function (result) {
                        var data = JSON.parse(result);
                        console.log("Get ID:" + id);
                        $.RS.submissionId = id;
                        console.log("Get ID var:" + id);

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
            }
        });

        //Submission button click
        var $subBtn = $.RS.submissionButton();
        $($subBtn.context).on('click', $subBtn.selector + ':not(:disabled)', function () {
            $('#form-report-response').find('button').html('<b><i class="fa fa-paper-plane" aria-hidden="true"></i>  জমা দিন</b>');
            $('.modal-title').html('<b><i class="fa fa-file-text-o" aria-hidden="true"></i> MIS 1 (FWA) - জমা দিন</b>');
            $("input[name='message']").val("");
            $.loadReviewDataByProvider();
        });

        $('select').on('change', function () {
            setJson(null);
            $.RS.submissionId = 0;
            $("#submitDataButton").fadeOut();
            $("#viewStatus").children().fadeOut();
        });

        $('#showdataButton').click(function () {
            $.RS.submissionButton('hide');
            $("#viewStatus").children().fadeOut();
            var d = new Date(), m = d.getMonth() + 1, y = d.getFullYear();
            //Remove table data
            clearData();
            clearLMIS();
            //Report Validation---------------------------------------------------------------------------------------------------------------
            if ($("select#division").val() === "") {
                toastr["error"]("<h4><b>বিভাগ সিলেক্ট করুন </b></h4>");
            } else if ($("select#district").val() === "") {
                toastr["error"]("<h4><b>জেলা সিলেক্ট করুন </b></h4>");
            } else if ($("select#upazila").val() === "") {
                toastr["error"]("<h4><b>উপজেলা সিলেক্ট করুন</b></h4>");
            } else if ($("select#union").val() === "") {
                toastr["error"]("<h4><b>ইউনিয়ন সিলেক্ট করুন</b></h4>");
            } else if ($("select#unit").val() === "") {
                toastr["error"]("<h4><b>ইউনিট সিলেক্ট করুন</b></h4>");
            } else if ($("select#provCode").val() === "") {
                toastr["error"]("<h4><b>প্রোভাইডার সিলেক্ট করুন</b></h4>");
            } else {
                $.ajax({
                    url: "mis-form-1?action=showdata",
                    data: {
                        divisionId: $("select#division").val(),
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val(),
                        fwaUnit: $("select#unit").val(),
                        provCode: $("select#provCode").val(),
                        month: $("select#month").val(),
                        year: $("#year").val(),
                        date: getCurrentPreviousDate($("select#month").val(), $("#year").val())
                                //lmis : JSON.stringify(makeLMISJson())
                    },
                    type: 'POST',
                    success: function (result) {
                        var data = JSON.parse(result);
                        setJson(data);
                        json = data;
                        if (data.length === 0) {
                            toastr["error"]("<h4><b>কোন ডাটা পাওয়া যায়নি</b></h4>");
                            return;
                        }
                        console.log(data);
                        var json = data.MIS, csbaJson = data.CSBA; //, lmis = data.LMIS;

                        //Check is this user is FWA or not for submit button
                        if ($.app.getDate['day'] >= 25 && $.app.getDate['day'] <= 30) {
                            console.log("Eligible for submission");
                        }
                        $('#isSubmitAccess').val() == '99' ? $.RS.submissionButton('show') : $.RS.submissionButton('hide');
                        //$.RS.submissionButton('show');

                        //For not submitted
                        if (data.isSubmittable && data.status == undefined) {
                            $.RS.submissionStatus('notSubmitted');

                            //For pending
                        } else if (data.status == 0) {
                            //$("#viewStatus").html($.app.workplanStatus.pending);
                            //$('#isSubmitAccess').val() == '99' ? $.RS.submissionStatus('pending') : $.RS.submissionStatus('notSubmitted');
                            $.RS.submissionStatus('pending');

                            //For resubmit
                        } else if (data.status == 2) {
                            //$('#isSubmitAccess').val() == '99' ? $.RS.submissionStatus('revised') : $.RS.submissionStatus('notSubmitted');
                            $.RS.submissionStatus('revised');

                            //Re-submitted
                        } else if (data.status == 3) {
                            //$('#isSubmitAccess').val() == '99' ? $.RS.submissionStatus('rePending') : $.RS.submissionStatus('notSubmitted');
                            $.RS.submissionStatus('rePending')

                            //Otherwise is submitted
                        } else {
                            $.RS.submissionStatus('submitted');
                        }

                        //=========================================Begin TOP Part==================================================================

                        /*if(json[0].r_csba===0){
                         console.log("In"+ csbaJson["preg_anc_service_visit1_csba"]);
                         csbaJson["preg_anc_service_visit1_csba"]="";
                         csbaJson["preg_anc_service_visit2_csba"]="";
                         csbaJson["preg_anc_service_visit3_csba"]="";
                         csbaJson["delivary_service_delivery_done_csba"]="";
                         csbaJson["delivary_service_3rd_amts1_csba"]="";
                         csbaJson["delivary_service_misoprostol_taken_csba"]="";
                         csbaJson["pnc_mother_visit1_csba"]="";
                         csbaJson["pnc_mother_visit2_csba"]="";
                         csbaJson["pnc_mother_visit3_csba"]="";
                         csbaJson["pnc_mother_visit4_csba"]="";
                         csbaJson["preg_anc_service_visit4_csba"]="";
                         csbaJson["pnc_mother_family_planning_csba"]="";
                         csbaJson["pnc_child_visit1_csba"]="";
                         csbaJson["pnc_child_visit2_csba"]="";
                         csbaJson["pnc_child_visit3_csba"]="";
                         csbaJson["pnc_child_visit4_csba"]="";
                         csbaJson["ref_preg_delivery_pnc_diff_refer_csba"]="";
                         csbaJson["ref_eclampsia_mgso4_inj_refer_csba"]="";
                         csbaJson["ref_newborn_difficulty_csba"]="";
                         }*/

                        //if (json[0].r_unit_name === 'null' || json[0].r_unit_name === '')
                        //json[0].r_unit_name = '';
                        function setHeaderArea(row) {
                            var d = {r_unit_name: 'aaa', r_ward_name: 'bbbb', r_un_name: 'ccc', r_upz_name: 'ddd', r_dist_name: 'eee'};
                            if (row) {
                                d = row;
                            }
                            $("#unitValue").html("&nbsp;<b>" + d.r_unit_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                            //if (json[0].r_ward_name === 'null' || json[0].r_ward_name === '')
                            //json[0].r_ward_name = '';
                            $("#wardValue").html("&nbsp;<b>" + d.r_ward_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

                            $("#unionValue").html("&nbsp;<b>" + d.r_un_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                            $("#upazilaValue").html("&nbsp;<b>" + d.r_upz_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                            $("#districtValue").html("&nbsp;<b>" + d.r_dist_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                            $("#yearValue").html("<b>" + convertE2B($("#year :selected").text()) + "&nbsp;&nbsp;&nbsp;&nbsp;</b>");
                            $("#monthValue").html("<b>" + $("#month :selected").text() + "</b>");
                        }
                        setHeaderArea(json[0]);
                        var pdvr = $("#provCode :selected").text();
                        var provider = pdvr.substr(0, pdvr.length - 8);
                        $("#providerName").html("&nbsp;&nbsp;<b>" + provider + "</b>");
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
                        //                        $("#r_curr_m_left_per_man_no_method").html(json[0].r_curr_m_left_per_man_no_method);
                        //                        $("#r_curr_m_left_per_woman_no_method").html(json[0].r_curr_m_left_per_woman_no_method);
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
                        //                        $("#r_curr_m_left_per_man_oth_method").html(json[0].r_curr_m_left_per_man_oth_method);
                        //                        $("#r_curr_m_left_per_woman_oth_mthd").html(json[0].r_curr_m_left_per_woman_oth_mthd);
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

                        //                        $("#r_sent_method_pill").html(json[0].r_sent_method_pill);
                        //                        $("#r_sent_method_condom").html(json[0].r_sent_method_condom);
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
                        $("#preg_anc_service_visit1_csba").html(finiteFilter(json[0].r_preg_anc_service_visit1_csba))

                        $("#preg_anc_service_visit2_fwa").html(json[0].r_preg_anc_service_visit2_fwa);
                        //$("#preg_anc_service_visit2_csba").html(csbaJson["preg_anc_service_visit2_csba"]); //CSBA
                        $("#preg_anc_service_visit2_csba").html(finiteFilter(json[0].r_preg_anc_service_visit2_csba));

                        $("#preg_anc_service_visit3_fwa").html(json[0].r_preg_anc_service_visit3_fwa);
                        //$("#preg_anc_service_visit3_csba").html(csbaJson["preg_anc_service_visit3_csba"]); //CSBA
                        $("#preg_anc_service_visit3_csba").html(finiteFilter(json[0].r_preg_anc_service_visit3_csba));

                        $("#preg_anc_service_visit4_fwa").html(json[0].r_preg_anc_service_visit4_fwa);
                        //$("#preg_anc_service_visit4_csba").html(csbaJson["preg_anc_service_visit4_csba"]); //CSBA
                        $("#preg_anc_service_visit4_csba").html(finiteFilter(json[0].r_preg_anc_service_visit4_csba));

                        $("#delivary_service_home_trained_fwa").html(json[0].r_delivary_service_home_trained_fwa);
                        $("#delivary_service_home_untrained_fwa").html(json[0].r_delivary_service_home_untrained_fwa);

                        $("#delivary_service_hospital_normal_fwa").html(json[0].r_delivary_service_hospital_normal_fwa);
                        $("#delivary_service_hospital_operation_fwa").html(json[0].r_delivary_service_hospital_operation_fwa);

                        //$("#delivary_service_delivery_done_csba").html(csbaJson["delivary_service_delivery_done_csba"]); //CSBA
                        $("#delivary_service_delivery_done_csba").html(finiteFilter(json[0].r_delivary_service_delivery_done_csba));

                        //$("#delivary_service_3rd_amts1_csba").html(csbaJson["delivary_service_3rd_amts1_csba"]); //CSBA
                        $("#delivary_service_3rd_amts1_csba").html(finiteFilter(json[0].r_delivary_service_3rd_amts1_csba));

                        //$("#delivary_service_misoprostol_taken_csba").html(csbaJson["delivary_service_misoprostol_taken_csba"]); //CSBA
                        $("#delivary_service_misoprostol_taken_csba").html(finiteFilter(json[0].r_delivary_service_misoprostol_taken_csba)); //CSBA

                        $("#pnc_mother_visit1_fwa").html(json[0].r_pnc_mother_visit1_fwa);

                        //$("#pnc_mother_visit1_csba").html(csbaJson["pnc_mother_visit1_csba"]);//CSBA
                        $("#pnc_mother_visit1_csba").html(finiteFilter(json[0].r_pnc_mother_visit1_csba));//CSBA

                        $("#pnc_mother_visit2_fwa").html(json[0].r_pnc_mother_visit2_fwa);

                        //$("#pnc_mother_visit2_csba").html(csbaJson["pnc_mother_visit2_csba"]);//CSBA
                        $("#pnc_mother_visit2_csba").html(finiteFilter(json[0].r_pnc_mother_visit2_csba));//CSBA

                        $("#pnc_mother_visit3_fwa").html(json[0].r_pnc_mother_visit3_fwa);

                        //$("#pnc_mother_visit3_csba").html(csbaJson["pnc_mother_visit3_csba"]);//CSBA
                        $("#pnc_mother_visit3_csba").html(finiteFilter(json[0].r_pnc_mother_visit3_csba));//CSBA

                        $("#pnc_mother_visit4_fwa").html(json[0].r_pnc_mother_visit4_fwa);
                        //$("#pnc_mother_visit4_csba").html(csbaJson["pnc_mother_visit4_csba"]);//CSBA
                        $("#pnc_mother_visit4_csba").html(finiteFilter(json[0].r_pnc_mother_visit4_csba));//CSBA

                        //$("#pnc_mother_family_planning_csba").html(csbaJson["pnc_mother_family_planning_csba"]);//CSBA
                        $("#pnc_mother_family_planning_csba").html(finiteFilter(json[0].r_pnc_mother_family_planning_csba));//CSBA

                        $("#pnc_child_visit1_fwa").html(json[0].r_pnc_newborn_visit1_fwa);




                        //$("#pnc_child_visit1_csba").html(csbaJson["pnc_child_visit1_csba"]);//CSBA
                        $("#pnc_child_visit1_csba").html(isNaN(json[0].r_pnc_newborn_visit1_csba)? 0: json[0].r_pnc_newborn_visit1_csba);//CSBA

                        $("#pnc_child_visit2_fwa").html(json[0].r_pnc_newborn_visit2_fwa);

                        //$("#pnc_child_visit2_csba").html(csbaJson["pnc_child_visit2_csba"]);//CSBA
                        $("#pnc_child_visit2_csba").html(isNaN(json[0].r_pnc_newborn_visit2_csba)? 0: json[0].r_pnc_newborn_visit2_csba);//CSBA

                        $("#pnc_child_visit3_fwa").html(json[0].r_pnc_newborn_visit3_fwa);

                        //$("#pnc_child_visit3_csba").html(csbaJson["pnc_child_visit3_csba"]);//CSBA
                        $("#pnc_child_visit3_csba").html(isNaN(json[0].r_pnc_newborn_visit3_csba)? 0: json[0].r_pnc_newborn_visit3_csba);//CSBA

                        $("#pnc_child_visit4_fwa").html(json[0].v_pnc_newborn_visit4_fwa);

                        //$("#pnc_child_visit4_csba").html(csbaJson["pnc_child_visit4_csba"]);//CSBA
                        $("#pnc_child_visit4_csba").html(isNaN(json[0].r_pnc_newborn_visit4_csba)? 0: json[0].r_pnc_newborn_visit4_csba);//CSBA

                        $("#ref_risky_preg_cnt_fwa").html(json[0].v_ref_risky_preg_cnt_fwa);


                        //CSBA Part for 2nd column=================================
                        //$("#ref_preg_delivery_pnc_diff_refer_csba").html(csbaJson["ref_preg_delivery_pnc_diff_refer_csba"]); //For - ref_preg_delivery_pnc_diff_refer_csba
                        $("#ref_preg_delivery_pnc_diff_refer_csba").html(finiteFilter(json[0].v_ref_preg_delivery_pnc_diff_refer_csba)); //For - ref_preg_delivery_pnc_diff_refer_csba

                        //$("#ref_eclampsia_mgso4_inj_refer_csba").html(csbaJson["ref_eclampsia_mgso4_inj_refer_csba"]);//CSBA
                        $("#ref_eclampsia_mgso4_inj_refer_csba").html(finiteFilter(json[0].v_ref_eclampsia_mgso4_inj_refer_csba));//CSBA

                        //$("#ref_newborn_difficulty_csba").html(csbaJson["ref_newborn_difficulty_csba"]);//CSBA
                        $("#ref_newborn_difficulty_csba").html(finiteFilter(json[0].v_ref_newborn_difficulty_csba));//CSBA
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
                        $("#newborn_1min_washed_csba").html(finiteFilter(json[0].r_newborn_1min_washed_csba)); //CSBA real


                        $("#newborn_71_chlorohexidin_used_fwa").html(json[0].r_newborn_71_chlorohexidin_used_fwa);
                        // $("#newborn_71_chlorohexidin_used_csba").html(json[0].r_newborn_71_chlorohexidin_used_csba); //CSBA
                        $("#newborn_71_chlorohexidin_used_csba").html(finiteFilter(json[0].r_newborn_71_chlorohexidin_used_csba)); //CSBA real

//                        $("#newborn_1hr_bfeeded_csba").html(json[0].r_newborn_1hr_bfeeded_csba); //CSBA real
//                        $("#newborn_diff_breathing_resassite_csba").html(json[0].r_newborn_diff_breathing_resassite_csba); //CSBA real
                        $("#newborn_1hr_bfeeded_csba").html(finiteFilter(json[0].r_newborn_1hr_bfeeded_csba)); //CSBA real
                        $("#newborn_diff_breathing_resassite_csba").html(finiteFilter(json[0].r_newborn_diff_breathing_resassite_csba)); //CSBA real

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
                        /*$.each(lmis, (i, o) => {
                         var item = o.itemcode
                         $("#openingbalance"+ item).text(o.openingbalance);
                         $("#receiveqty"+ item).text(o.receiveqty);
                         $("#current_month_stock"+ item).text(o.current_month_stock);
                         $("#adjustment_plus"+ item).text(o.adjustment_plus);
                         $("#adjustment_minus"+ item).text(o.adjustment_minus);
                         $("#total"+ item).text(o.total);
                         $("#distribution"+ item).text(o.distribution);
                         $("#closingbalance"+ item).text(o.closingbalance);
                         });*/

                        $(".e2b table td").each(function () {
                            $(this).text(convertE2B($(this).text()));
                        });

                        if (mis1.auto) {
                            mis1.approve();
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        toastr["error"]("<h4><b>অনুরোধটি প্রক্রিয়াধীন করা যাচ্ছে না</b></h4>");
                    }
                }); //End Ajax Call
            }
        }); //End show data button click
    });
</script>
${sessionScope.designation=='FWA'  || sessionScope.role=='Super admin'?
  "<input type='hidden' id='isSubmitAccess' value='99'>" : "<input type='hidden' id='isSubmitAccess' value='66'>"}
<section class="content-header">
    <h1 id="pageTitle">
        <span id="title">MIS 1 (FWA)</span>
        <small>৮ম সংস্করণ</small>
        <span id="submitStatus" class="pull-right"></span>
    </h1>
<!--    <ol class="breadcrumb">
        <a class="btn btn-flat btn-primary btn-sm" href="mis1-9"><b>৯ম সংস্করণ</b></a>
        <a class="btn btn-flat btn-info btn-sm" href="mis-form-1"><b>৮ম সংস্করণ</b></a>
    </ol>-->
</section>
<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <%@include file="/WEB-INF/jspf/mis1AreaBangla.jspf" %>
    <div id="viewStatus">
    </div>
    <!--------------------------------------------------------------------------------Data Table Goes Here-------------------------------------------------------------------------------->  
    <div class="box box-primary full-screen">
        <div class="box-header with-border">
            <div class="box-tools pull-right" style="margin-top: -10px;">
                <button type="button" class="btn btn-flat btn-default btn-xs bold" onclick="window.print();"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body" id="data-table">
            <div class="col-ld-12 mis1">
                <div class="col-md-12 mis-form-1"  style="padding: -100px;">
                    <div class="table-responsive" >
                        <table  style="text-align: left; width: 100%;border: 0!important;" id="topHeader">
                            <tr>
                                <th style="border:none!important;">
                                    <div id='slogan'>ছেলে হোক, মেয়ে হোক,<br>দু’টি সন্তানই যথেষ্ট</div>
                                    <img id='logo' src="resources/logo/Fpi_logo.png"  alt=""/>
                                </th>
                                <th style="text-align:center;border:none!important;" colspan="2">
                                    <small>গনপ্রজাতন্ত্রী বাংলাদেশ সরকার<br>পরিবার পরিকল্পনা অধিদপ্তর</small>
                                    <br>পরিবার পরিকল্পনা, মা ও শিশু স্বাস্থ্য কার্যক্রমের মাসিক অগ্রগতির প্রতিবেদন
                                    <!--                            <br>(পরিবার কল্যান সহকারী কর্তৃক পূরণীয়)-->
                                    <br>মাসঃ <span id='monthValue'>...............................</span> সালঃ <span id="yearValue">...............................</span>
                                </th>
                                <th style="text-align:right;border:none!important;" id="page">এম আই এস ফরম - ১<br>পৃষ্ঠা-১</th>
                            </tr>
                            <tr>
                                <td colspan="4" style="text-align:center;border:none!important;"><br>
                                    ইউনিট নম্বরঃ<span id='unitValue'> ..........................</span>     &nbsp;&nbsp;&nbsp;&nbsp;
                                    ওয়ার্ড নম্বরঃ<span id='wardValue'> ..........................</span>    &nbsp;&nbsp;&nbsp;&nbsp;
                                    ইউনিয়নঃ<span id='unionValue'> ..........................</span>     &nbsp;&nbsp;&nbsp;&nbsp;
                                    উপজেলা/থানাঃ<span id='upazilaValue'> ..........................</span>     &nbsp;&nbsp;&nbsp;&nbsp;
                                    জেলাঃ<span id='districtValue'> ..........................</span>   
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="e2b">
                        <p> <strong> ক) পরিবার পরিকল্পনা পদ্ধতিঃ </strong> </p>
                        <div class="table-responsive" >
                            <table class="table table-bordered  mis_table" style="width: 100%;">
                                <tr>
                                    <td colspan="2" rowspan="3" style="border: 1px solid black;border-color:#000000;"></td>
                                    <td colspan="18" style="padding: 7px;">পদ্ধতি গ্রহনকারী</td>
                                </tr>
                                <tr >
                                    <td rowspan="2" style="text-align: center">খাবার বড়ি</td>
                                    <td rowspan="2" style="border: 1px solid black;border-color:#000000;text-align: center">কনডম</td>
                                    <td rowspan="2" style="border: 1px solid black;border-color:#000000;text-align: center">ইনজেকটেবল</td>
                                    <td rowspan="2" style="border: 1px solid black;border-color:#000000;text-align: center">আইইউডি</td>
                                    <td rowspan="2" style="border: 1px solid black;border-color:#000000;text-align: center">ইমপ্ল্যান্ট</td>
                                    <td colspan="2" style="border: 1px solid black;border-color:#000000;text-align: center;padding: 2px;">স্থায়ী পদ্ধতি</td>
                                    <td rowspan="2" style="border: 1px solid black;border-color:#000000;text-align: center">সর্বমোট</td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid black;border-color:#000000;text-align: center;padding: 2px;">পুরুষ</td>
                                    <td style="border: 1px solid black;border-color:#000000;text-align: center;padding: 2px;">মহিলা</td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="border: 1px solid black;border-color:#000000;text-align: left;padding: 3px;">&nbsp;&nbsp;পুরাতন </td>
                                    <td class="v_field" id="r_old_pill" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_old_condom" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_old_inject" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_old_iud" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_old_implant" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_old_permanent_man" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_old_permanent_woman" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_old_all_total" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                </tr>

                                <tr>
                                    <td colspan="2" style="border: 1px solid black;border-color:#000000;text-align: left;padding: 3px;">&nbsp;&nbsp;নতুন</td>
                                    <td class="v_field" id="r_new_pill" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_new_condom" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_new_inject" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_new_iud" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_new_implant" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_new_permanent_man" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_new_permanent_woman" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_new_all_total" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                </tr>

                                <tr>
                                    <td colspan="2" style="border: 1px solid black;border-color:#000000;text-align: left;padding: 3px;">&nbsp;&nbsp;চলতি মাসের মোট</td>
                                    <td class="v_field" id="r_curr_month_pill_total" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_curr_month_condom_total" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_curr_month_inject_total" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_curr_month_iud_total" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_curr_month_implant_total" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_curr_month_permanent_man" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_curr_month_permanent_woman" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_curr_month_all_total" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                </tr>

                                <tr>
                                    <td colspan="2" style="border: 1px solid black;border-color:#000000;text-align: left;padding: 3px;">&nbsp;&nbsp;পূর্ববর্তী মাসের মোট</td>
                                    <td class="v_field" id="r_priv_month_pill_total" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_priv_month_condom_total" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_priv_month_inject_total" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_priv_month_iud_total" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_priv_month_implant_total" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_priv_month_permanent_man" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_priv_month_permanent_woman" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_priv_month_all_total" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                </tr>


                                <tr>
                                    <td colspan="2" style="border: 1px solid black;border-color:#000000;text-align: left;padding: 3px;">&nbsp;&nbsp;ইউনিটের সর্বমোট</td>
                                    <td class="v_field" id="r_unit_pill_tot" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_unit_condom_tot" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_unit_inject_tot" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_unit_iud_tot" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_unit_implant_tot" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_unit_permanent_man_tot" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_unit_permanent_woman_tot" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_unit_all_total_tot" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                </tr>

                                <tr>
                                    <td rowspan="2" style="border: 1px solid black;border-color:#000000;text-align: left;padding: 3px;">&nbsp;&nbsp;চলতি মাসে<br>&nbsp;&nbsp;ছেড়ে <br>&nbsp;&nbsp;দিয়েছে</td>
                                    <td style="border: 1px solid black;border-color:#000000;text-align: left;">&nbsp;&nbsp;কোন পদ্ধতি নেয়নি </td>
                                    <td class="v_field" id="r_curr_m_left_pill_no_method" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_curr_m_left_condom_no_method" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_curr_m_left_inj_no_method" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_curr_m_left_iud_no_method" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_curr_m_left_implant_no_method" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_curr_m_left_per_man_no_method"  style="border: 1px solid black;border-color:#000000;text-align: center;background-color:#aebcc4"></td>
                                    <td class="v_field" id="r_curr_m_left_per_woman_no_method"  style="background-color:#aebcc4"></td>
                                    <td class="v_field" id="r_curr_m_left_no_method_all_tot" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                </tr>


                                <tr>
                                    <td style="border: 1px solid black;border-color:#000000;text-align: left;">&nbsp;&nbsp;অন্য পদ্ধতি নিয়েছে </td>
                                    <td class="v_field" id="r_curr_m_left_pill_oth_method" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_curr_m_left_condom_oth_method" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_curr_m_left_inj_oth_method" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_curr_m_left_iud_oth_method" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_curr_m_left_implant_oth_method" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_curr_m_left_per_man_oth_method"  style="background-color:#aebcc4"></td>
                                    <td class="v_field" id="r_curr_m_left_per_woman_oth_mthd"  style="background-color:#aebcc4"></td>
                                    <td class="v_field" id="r_curr_m_left_oth_method_all_tot" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                </tr>

                                <tr>
                                    <td colspan="2" style="border: 1px solid black;border-color:#000000;text-align: left;padding: 3px;">&nbsp;&nbsp;পদ্ধতির জন্য প্রেরণ</td>
                                    <td class="v_field" id="r_sent_method_pill"  style="border: 1px solid black;border-color:#000000;text-align: center;background-color:#aebcc4"></td>
                                    <td class="v_field" id="r_sent_method_condom"  style="background-color:#aebcc4"></td>
                                    <td class="v_field" id="r_sent_method_inj" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_sent_method_iud" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_sent_method_implant" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_sent_method_per_man" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_sent_method_per_woman" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_sent_method_all_tot" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                </tr>

                                <tr>
                                    <td colspan="2" style="border: 1px solid black;border-color:#000000;text-align: left;padding: 3px;">&nbsp;&nbsp;পার্শ্ব প্রতিক্রিয়ার জন্য প্রেরণ</td>
                                    <td class="v_field" id="r_sent_side_effect_pill" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_sent_side_effect_condoms" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_sent_side_effect_inj" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_sent_side_effect_iud" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_sent_side_effect_implant" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_sent_side_effect_per_man" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_sent_side_effect_per_woman" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td class="v_field" id="r_sent_side_effect_all_tot" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                </tr>
                            </table>
                        </div>


                        <div class="table-responsive">
                            <table class="table-bordered mis_table" style="width: 100%">
                                <colgroup>
                                    <col style="width: 301px">
                                    <col style="width: 101px">
                                    <col style="width: 301px">
                                    <col style="width: 101px">
                                </colgroup>
                                <tr>
                                    <td style="border: 1px solid black;border-color:#000000;text-align: left;padding: 3px;">&nbsp;&nbsp;চলতি মাসে পরিদর্শিত সক্ষম দম্পতির সংখ্যা</td>
                                    <td class="v_field" id="r_curr_m_shown_capable_elco_tot" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td style="border: 1px solid black;border-color:#000000;text-align: left;padding: 3px;">&nbsp;&nbsp;ইউনিটের মোট সক্ষম দম্পতির সংখ্যা</td>
                                    <td class="v_field" id="r_unit_capable_elco_tot" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid black;border-color:#000000;text-align: left;padding: 3px;">&nbsp;&nbsp;পূর্ববর্তী মাসে পরিদর্শিত সক্ষম দম্পতির সংখ্যা</td>
                                    <td class="v_field" id="r_priv_m_shown_capable_elco_tot" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                    <td style="border: 1px solid black;border-color:#000000;text-align: left;padding: 3px;">&nbsp;&nbsp;চলতি মাসে নবদম্পতির সংখ্যা</td>
                                    <td class="v_field" id="r_curr_m_v_new_elco_tot" style="border: 1px solid black;border-color:#000000;text-align: center"></td>
                                </tr>
                            </table>
                        </div><br>
                        <!--=======End ka - Family Planning Method==================================================================================-->
                        <!--Car Table-->
                        <div class="table-responsive1">
                            <table class="no-border" style="width: 100%;">
                                <tr>
                                    <td rowspan="2" style="width: 200px;text-align: center;padding: 3px;">&nbsp;&nbsp;পদ্ধতি গ্রহনকারীর হার (CAR):</td>
                                    <td style="width: 200px;text-align: center;padding: 4px;border-bottom: 1px solid black!important;">ইউনিটের সর্বমোট পদ্ধতি গ্রহণকারী</td>
                                    <td rowspan="2" style="text-align: left;width: 90px;">&nbsp;&#10006; ১০০&nbsp;&nbsp;&nbsp;&nbsp;= </td>

                                    <td class="v_field" style="width: 60px;text-align: center;padding: 4px;border-bottom: 1px solid black!important;" id="r_unit_all_total_tot1"></td>
                                    <td rowspan="2" style="text-align: left;width: 90px;">&nbsp;&#10006; ১০০&nbsp;&nbsp;&nbsp;&nbsp;= </td>
                                    <td class="v_field"  rowspan="2" style="text-align: left;width: 100px;" id="r_car"></td>
                                </tr>
                                <tr>
                                    <td style="width: 200px;text-align: center;padding: 4px;">ইউনিটের সর্বমোট সক্ষম দম্পতি</th>
                                    <td class="v_field"  id="r_unit_capable_elco_tot1" style="width: 80;text-align: center;padding: 4px;"></td>
                                </tr>
                            </table>
                        </div>
                        <br>

                        <p> <strong>খ) প্রজনন স্বাস্থ্য সেবাঃ </strong> </p>
                        <div class="row">
                            <div class="col-md-7">
                                <div class="table-responsive">
                                    <table class="table-bordered mis_table" style="width: 100%">
                                        <!--                            <table class="table-bordered mis_table" style="table-layout: fixed; width: 100%;height:627px">-->
                                        <colgroup>
                                            <col style="width: 80px">
                                            <col style="width: 80px">
                                            <col style="width: 230px">
                                            <col style="width: 50px">
                                            <col style="width: 50px">
                                        </colgroup>
                                        <tr style="text-align: center;">
                                            <td colspan="3" style="text-align: left;">&nbsp;&nbsp;&nbsp;সেবার ধরণ<br></td>
                                            <td style="text-align: center">তথ্য</td>
                                            <td style="text-align: center">সেবা<br></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="2" rowspan="3">চলতি মাসে গর্ভবতীর সংখ্যা<br></td>
                                            <td style="text-align: left;">নতুন<br></td>
                                            <td class="v_field" id="curr_month_preg_new_fwa"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td style="text-align: left;">পুরাতন</td>
                                            <td class="v_field" id="curr_month_preg_old_fwa"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td style="text-align: left;">মোট</td>
                                            <td class="v_field" id="curr_month_preg_tot_fwa"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="3" style="text-align: left;">পূর্ববতী মাসে মোট গর্ভবতীর সংখ্যা<br></td>
                                            <td class="v_field" id="prir_month_tot_preg_fwa"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="3" style="text-align: left;">ইউনিটের সর্বমোট গর্ভবতীর সংখ্যা<br></td>
                                            <td class="v_field" id="unit_tot_preg_fwa"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td rowspan="4" class="rotate">গর্ভবতী সেবার  তথ্য<br></td>
                                            <td colspan="2" style="text-align: left;">পরিদর্শন-১ (৪ মাসের মধ্যে)<br></td>
                                            <td class="v_field" id="preg_anc_service_visit1_fwa"></td>
                                            <td class="v_field" id="preg_anc_service_visit1_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="2" style="text-align: left;">পরিদর্শন-২ (৬ মাসের মধ্যে)<br></td>
                                            <td class="v_field" id="preg_anc_service_visit2_fwa"></td>
                                            <td class="v_field" id="preg_anc_service_visit2_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="2" style="text-align: left;">পরিদর্শন-৩ (৮ মাসের মধ্যে)<br></td>
                                            <td class="v_field" id="preg_anc_service_visit3_fwa"></td>
                                            <td class="v_field" id="preg_anc_service_visit3_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="2" style="text-align: left;">পরিদর্শন-৪ (৯ম মাসে)<br></td>
                                            <td class="v_field" id="preg_anc_service_visit4_fwa"></td>
                                            <td class="v_field" id="preg_anc_service_visit4_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td rowspan="7" class="rotate">প্রসব সেবার তথ্য<br></td>
                                            <td rowspan="2" style="text-align: left;"><br>বাড়ী</td>
                                            <td style="text-align: left;">প্রশিক্ষণপ্রাপ্ত ব্যাক্তি দ্বারা<br></td>
                                            <td class="v_field" id="delivary_service_home_trained_fwa"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td style="text-align: left;">প্রশিক্ষণবিহীন ব্যক্তি দ্বারা<br></td>
                                            <td class="v_field" id="delivary_service_home_untrained_fwa"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td rowspan="2" style="text-align: left;">হাসপাতাল/ক্লিনিক</td>
                                            <td style="text-align: left;">স্বাভাবিক</td>
                                            <td class="v_field" id="delivary_service_hospital_normal_fwa"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td style="text-align: left;">সিজারিয়ান<br></td>
                                            <td class="v_field" id="delivary_service_hospital_operation_fwa"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="2" style="text-align: left;">প্রসব করানো হয়েছে<br></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                            <td class="v_field" id="delivary_service_delivery_done_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="2" style="text-align: left;">প্রসবের তৃতীয় ধাপের সক্রিয় ব্যবস্থাপনা (AMTSL) অনুসরণ করে প্রসব করানোর সংখ্যা<br></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                            <td class="v_field" id="delivary_service_3rd_amts1_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="2" style="text-align: left;">অক্সিটোসিন না থাকলে মিসোপ্রোস্টল বড়ি খাওয়ানো হয়েছে<br></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                            <td class="v_field" id="delivary_service_misoprostol_taken_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td rowspan="9" class="rotate">প্রসবোত্তর সেবার তথ্য<br></td>
                                            <td rowspan="5" class="rotate">মা</td>
                                            <td style="text-align: left;">পরিদর্শন-১ (২৪ ঘণ্টার মধ্যে)<br></td>
                                            <td class="v_field" id="pnc_mother_visit1_fwa"></td>
                                            <td class="v_field" id="pnc_mother_visit1_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td style="text-align: left;">পরিদর্শন-২ (২-৩ দিনের মধ্যে)<br></td>
                                            <td class="v_field" id="pnc_mother_visit2_fwa"></td>
                                            <td class="v_field" id="pnc_mother_visit2_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td style="text-align: left;">পরিদর্শন-৩ (৭-১৪ দিনের মধ্যে)<br></td>
                                            <td class="v_field" id="pnc_mother_visit3_fwa"></td>
                                            <td class="v_field" id="pnc_mother_visit3_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td style="text-align: left;">পরিদর্শন-৪ (৪২-৪৮ দিনের মধ্যে)<br></td>
                                            <td class="v_field" id="pnc_mother_visit4_fwa"></td>
                                            <td class="v_field" id="pnc_mother_visit4_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td style="text-align: left;">প্রসব পরবর্তী পরিবার পরিকল্পনা পদ্ধতি বিষয়ে <br>কাউন্সিলিং</td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                            <td class="v_field" id="pnc_mother_family_planning_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td rowspan="4" class="rotate">নবজাতক<br></td>
                                            <td style="text-align: left;">পরিদর্শন-১ (২৪ ঘণ্টার মধ্যে)<br></td>
                                            <td class="v_field" id="pnc_child_visit1_fwa"></td>
                                            <td class="v_field" id="pnc_child_visit1_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td style="text-align: left;">পরিদর্শন-২ (২-৩ দিনের দিনের মধ্যে)<br></td>
                                            <td class="v_field" id="pnc_child_visit2_fwa"></td>
                                            <td class="v_field" id="pnc_child_visit2_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td style="text-align: left;">পরিদর্শন-৩ (৭-১৪ দিনের মধ্যে)<br></td>
                                            <td class="v_field" id="pnc_child_visit3_fwa"></td>
                                            <td class="v_field" id="pnc_child_visit3_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td style="text-align: left;">পরিদর্শন-৪ (৪২-৪৮ দিনের মধ্যে)<br></td>
                                            <td class="v_field" id="pnc_child_visit4_fwa"></td>
                                            <td class="v_field" id="pnc_child_visit4_csba"></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>

                            <div class="col-md-5">
                                <div class="table-responsive">
                                    <table class="table-bordered mis_table" style="width: 100%">
                                        <!--                            <table class="table-bordered mis_table" style="table-layout: fixed; width: 100%;height:647px">-->
                                        <colgroup>
                                            <col style="width: 80px">
                                            <col style="width: 60px">
                                            <col>
                                            <col style="width: 50px">
                                            <col style="width: 50px">
                                        </colgroup>
                                        <tr style="text-align: center;">
                                            <td colspan="3" style="text-align: left;">&nbsp;&nbsp;&nbsp;সেবার ধরণ<br></td>
                                            <td style="text-align: center">তথ্য</td>
                                            <td style="text-align: center">সেবা<br></td>
                                        </tr>

                                        <tr style="text-align: center;">
                                            <td rowspan="4" class="">রেফারকৃত</td>
                                            <td colspan="2" style="text-align: left;">ঝুকিপূর্ণ/জটিল গর্ভবতীর সংখ্যা <br></td>
                                            <td class="v_field" id="ref_risky_preg_cnt_fwa"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="2" style="text-align: left;">গর্ভকালীন, প্রসবকালীন ও প্রসবোত্তর জটিলতার সংখ্যা<br></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                            <td class="v_field" id="ref_preg_delivery_pnc_diff_refer_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="2" style="text-align: left;">একলাম্পসিয়া রোগীকে MgSO4 ইনজেকশন দিয়ে রেফার করার সংখ্যা<br></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"> </td>
                                            <td class="v_field" id="ref_eclampsia_mgso4_inj_refer_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="2" style="text-align: left;">নবজাতককে জটিলতার জন্য প্রেরণের সংখ্যা<br></td>
                                            <td class="ka_table_inactive_field"  style="background-color:#aebcc4"></td>
                                            <td class="v_field" id="ref_newborn_difficulty_csba"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="2" rowspan="5">টি টি প্রাপ্ত মহিলার সংখ্যা<br></td>
                                            <td style="text-align: left;">১ম</td>
                                            <td class="v_field" id="tt_women_1st_fwa"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td style="text-align: left;">২য়</td>
                                            <td class="v_field" id="tt_women_2nd_fwa"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td style="text-align: left;">৩য়</td>
                                            <td class="v_field" id="tt_women_3rd_fwa"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td style="text-align: left;">৪র্থ</td>
                                            <td class="v_field" id="tt_women_4th_fwa"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td style="text-align: left;">৫ম<br></td>
                                            <td class="v_field" id="tt_women_5th_fwa"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="3" style="text-align: left;">ইসিপি গ্রহনকারীর সংখ্যা <br></td>
                                            <td class="v_field" id="ecp_taken"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="3" style="text-align: left;">মিসোপ্রোস্টল বড়ি গ্রহণকারীর সংখ্যা<br></td>
                                            <td class="v_field" id="misoprostol_taken"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="2" rowspan="2">বন্ধ্যা দম্পতির তথ্য<br></td>
                                            <td style="text-align: left;">পরামর্শ প্রাপ্ত</td>
                                            <td class="v_field" id="childless_couple_adviced_fwa"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td style="text-align: left;">রেফারকৃত</td>
                                            <td class="v_field" id="childless_couple_refered_fwa"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td rowspan="4">কিশোর-কিশোরীর <br>সেবা(১০-১৯ বছর)<br>কাউন্সিলিং<br></td>
                                            <td colspan="2" style="text-align: left;">কিশোর-কিশোরীকে বয়োসন্ধিকালীন পরিবর্তন বিষয়ে <br></td>
                                            <td class="v_field" id="teenager_counsiling_referred"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="2" style="text-align: left;">বাল্য-বিবাহ ও কিশোরী মাতৃত্বের কুফল বিষয়ে<br></td>
                                            <td class="v_field" id="teenager_counsiling_child_marriage_child_preg_disadvantage"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="2" style="text-align: left;">কিশোরীকে আয়রন ও ফলিক এসিড বড়ি খাবার বিষয়ে<br></td>
                                            <td class="v_field" id="teenager_counsiling_healthy_balanced_diet"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="2" style="text-align: left;">প্রজননতন্ত্রের সংক্রমন ও যৌনবাহিত রোগ বিষয়ে<br></td>
                                            <td class="v_field" id="teenager_counsiling_sexual_disease"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="3" style="text-align: left;">স্যাটেলাইট ক্লিনিকে উপস্থিতি <br></td>
                                            <td class="v_field" id="satelite_clinic_presence"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="3" style="text-align: left;">ইপিআই সেশনে উপস্থিতি<br></td>
                                            <td class="v_field" id="epi_session_presence"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td colspan="3" style="text-align: left;">কমিউনিট ক্লিনিকে উপস্থিতি<br></td>
                                            <td class="v_field" id="community_clinic_presence"></td>
                                            <td class="ka_table_inactive_field" style="background-color:#aebcc4"> </td>
                                        </tr>
                                    </table><br>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <br/>

            <div>&nbsp;&nbsp;</div>

            <!---------------------------------------------------------------------------Page 2------------------------------------------------------------------------->
            <div class="col-ld-12 mis1">
                <div class="col-md-12 mis-form-1"><br><br>
                    <p style='text-align: right'><b> পৃষ্ঠা-২ </b></p>
                    <div class="row">
                        <div class="col-md-7 e2b">
                            <div class="table-responsive">
                                <table class="table-bordered mis_table" style="width: 100%">
                                    <!--                            <table class="table-bordered mis_table" style="table-layout: fixed; width: 100%;height:358px">-->
                                    <colgroup>
                                        <col style="width: 81px">
                                        <col style="width: 91px">
                                        <col style="width: 121px">
                                        <col style="width: 70px">
                                        <col style="width: 50px">
                                        <col style="width: 50px">
                                    </colgroup>

                                    <tr>
                                    <p style="font-weight:600;">গ) শিশু (০-৫ বৎসর) সেবাঃ</p>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td colspan="4" style="text-align: left;">&nbsp;&nbsp;&nbsp;সেবার ধরণ<br></td>
                                        <td style="text-align: center">তথ্য</td>
                                        <td style="text-align: center">সেবা</td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td rowspan="4" class="rotate" style="padding: 5px;text-align: center;">নবজাতকের সেবা সংক্রান্ত তথ্য<br></td>
                                        <td colspan="3" style="text-align: left;">১ মিনিটের মধ্যে মোছানোর সংখ্যা<br></td>
                                        <td class="v_field" id="newborn_1min_washed_fwa"></td>
                                        <td class="v_field" id="newborn_1min_washed_csba"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td colspan="3" style="text-align: left;">নাড়ি কাটার পর ৭.১% ক্লোরহেক্সিডিন ব্যবহারের সংখ্যা<br></td>
                                        <td class="v_field" id="newborn_71_chlorohexidin_used_fwa"></td>
                                        <td class="v_field" id="newborn_71_chlorohexidin_used_csba"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td colspan="3" style="text-align: left;">জন্মের এক ঘণ্টার মধ্যে বুকের দুধ খাওয়ানোর সংখ্যা<br></td>
                                        <td class="v_field" id="newborn_1hr_bfeeded_fwa" style="background-color:#aebcc4"></td>
                                        <td class="v_field" id="newborn_1hr_bfeeded_csba"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td colspan="3" style="text-align: left;">জন্মকালীন শ্বাসকষ্টে আক্রান্ত শিশুকে ব্যাগ ও মাস্ক ব্যবহার করে রিসাসসিটেট  করার সংখ্যা<br></td>
                                        <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        <td class="v_field" id="newborn_diff_breathing_resassite_csba"></td>
                                    </tr>
                                    <!---==============Variable name change (07-03-2017) ============-->
                                    <tr style="text-align: center;">
                                        <td rowspan="7">টিকা প্রাপ্ত (০-১৮ মাস বয়সী) শিশুর সংখ্যা<br></td>
                                        <td colspan="3" style="text-align: left;">বিসিজি</td>
                                        <!--                                    <td id="vaccinated_child_bcg_fwa"></td>-->
                                        <td class="v_field" id="r_vaccinated_child_0to18mnths_bcg_fwa"></td>
                                        <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td rowspan="3" style="text-align: left;">ওপিভি ও প্যান্টাভেলেন্ট<br>(ডিপিটি, হেপ-বি, হিব)<br></td>
                                        <td rowspan="2" style="text-align: left;">পিসিভি</td>
                                        <td style="text-align: left;">১</td>
                                        <!--                                    <td id="vaccinated_0t01yrs_child_pcv_pentavalent_1_fwa"></td>-->
                                        <td class="v_field" id="r_vaccinated_child_0to18mnths_pcv1_fwa"></td>
                                        <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td style="text-align: left;">২</td>
                                        <!--                                    <td id="vaccinated_0t01yrs_child_pcv_pentavalent_2_fwa"></td>-->
                                        <td class="v_field" id="r_vaccinated_child_0to18mnths_pcv2_fwa"></td>
                                        <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td colspan="2" style="text-align:center !important">৩</td>
                                        <!--                                    <td id="vaccinated_0t01yrs_child_pcv_pentavalent_3_fwa"></td>-->
                                        <td class="v_field" id="r_vaccinated_child_0to18mnths_dpt_hepb_hib_fwa"></td>
                                        <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td colspan="3" style="text-align: left;">পিসিভি-৩<br></td>
                                        <!--                                    <td id="vaccinated_0t01yrs_child_pcv_pentavalent_4_fwa"></td>-->
                                        <td class="v_field" id="r_vaccinated_child_0to18mnths_pcv3_fwa"></td>
                                        <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td colspan="3" style="text-align: left;">এমআর ও ওপিভি-৪<br></td>
                                        <!--                                    <td id="vaccinated_0t01yrs_child_opv3_fwa"></td>-->
                                        <td class="v_field" id="r_vaccinated_child_0to18mnths_mr_opv4_fwa"></td>
                                        <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td colspan="3" style="text-align: left;">হামের টিকা<br></td>
                                        <!--                                    <td id="vaccinated_child_ham_fwa"></td>-->
                                        <td class="v_field" id="r_vaccinated_child_0to18mnths_ham_fwa"></td>
                                        <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                    </tr>
                                    <!--==========END Changes===========-->
                                    <tr style="text-align: center;">
                                        <td colspan="2" rowspan="3" style="text-align: left;">রেফারকৃত শিশুর সংখ্যা<br></td>
                                        <td colspan="2" style="text-align: left;">খুব মারাত্বক রোগ<br></td>
                                        <td class="v_field" id="referred_child_dangerous_disease_fwa"></td>
                                        <td class="ka_table_inactive_field" id="referred_child_dangerous_disease_csba"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td colspan="2" style="text-align: left;">নিউমোনিয়া</td>
                                        <td class="v_field" id="referred_child_neumonia_fwa"></td>
                                        <td class="ka_table_inactive_field" id="referred_child_neumonia_csba"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td colspan="2" style="text-align: left;">ডায়রিয়া</td>
                                        <td class="v_field" id="referred_child_diahoea_fwa"></td>
                                        <td class="ka_table_inactive_field"></td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                        <div class="col-md-5 e2b">
                            <table class="table-bordered mis_table" style="width: 100%">
                                <colgroup>
                                    <col style="width: 91px">
                                    <col style="width: 91px">
                                    <col style="width: 121px">
                                    <col style="width: 60px">
                                    <col style="width: 60px">
                                </colgroup>
                                <tr>
                                <p style="font-weight:600;">ঘ) জন্ম-মৃত্যুঃ </p>
                                </tr>
                                <tr style="text-align: center;">
                                    <td colspan="3" style="text-align: left;">&nbsp;&nbsp;&nbsp;সেবার ধরণ<br></td>
                                    <td style="text-align: center">তথ্য</td>
                                    <td style="text-align: center">সেবা</td>
                                </tr>
                                <tr style="text-align: center;">
                                    <td colspan="3" style="text-align: left;">মোট জীবিত জন্মের সংখ্যা<br></td>
                                    <td class="v_field" id="tot_live_birth_fwa"></td>
                                    <td id="tot_live_birth_csba" style="background-color:#aebcc4"></td>
                                </tr>
                                <tr style="text-align: center;">
                                    <td colspan="3" style="text-align: left;">কম জন্ম ওজনে (জন্ম ওজন&lt;২.৫ কেজি) জন্মগ্রহনকারী নবজাতকের সংখ্যা<br></td>
                                    <td class="v_field" id="less_weight_birth_fwa"></td>
                                    <td id="less_weight_birth_csba" style="background-color:#aebcc4"></td>
                                </tr>
                                <tr style="text-align: center;">
                                    <td colspan="3" style="text-align: left;">অপরিণত (৩৭ সপ্তাহের পূর্বে জন্ম) নবজাতকের সংখ্যা<br></td>
                                    <td class="v_field" id="immature_birth_fwa"></td>
                                    <td id="immature_birth_csba" style="background-color:#aebcc4"></td>
                                </tr>
                                <tr style="text-align: center;">
                                    <td colspan="3" style="text-align: left;">মৃত জন্ম (Still Birth)<br></td>
                                    <td class="v_field" id="death_birth_fwa"></td>
                                    <td id="death_birth_csba" style="background-color:#aebcc4"></td>
                                </tr>
                                <tr style="text-align: center;border-bottom: 1px solid black!important;">
                                    <td rowspan="9" style="text-align: center;">মৃতের সংখ্যা</td>
                                    <td rowspan="4" >এক বৎরের কম মৃত শিশুর সংখ্য</td>
                                    <td style="text-align: left;">০-৭ দিন<br></td>
                                    <td class="v_field" id="death_number_less_1yr_0to7days_fwa"></td> <!--  1  one-->
                                    <td class="v_field" id="death_number_less_1yr_0to7days_csba" style="background-color:#aebcc4"></td>
                                </tr>
                                <tr style="text-align: center;">
                                    <td style="text-align: left;">৮-২৮ দিন<br></td>
                                    <td class="v_field" id="death_number_less_1yr_8to28days_fwa"></td>
                                    <td class="v_field" id="death_number_less_1yr_8to28days_csba" style="background-color:#aebcc4"></td>
                                </tr>
                                <tr style="text-align: center;">
                                    <td style="text-align: left;">২৯ দিন -&lt;১ বছর<br></td>
                                    <td class="v_field" id="death_number_less_1yr_29dystoless1yr_fwa"></td>
                                    <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                </tr>
                                <tr style="text-align: center;">
                                    <td style="text-align: left;">মোট</td>
                                    <td class="v_field" id="death_number_less_1yr_tot_fwa"></td> <!--  l  one-->
                                    <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                </tr>
                                <tr style="text-align: center;">
                                    <td colspan="2" style="text-align: left;">১-&lt;৫ বছর মৃত শিশুর সংখ্যা<br></td>
                                    <td class="v_field" id="death_number_1yrto5yr_fwa"></td>
                                    <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                </tr>
                                <tr style="text-align: center;">
                                    <td colspan="2" style="text-align: left;">মাতৃ মৃত্যুর সংখ্যা<br></td>
                                    <td class="v_field" id="death_number_maternal_death_fwa"></td>
                                    <td class="v_field" id="death_number_maternal_death_csba" style="background-color:#aebcc4"></td>
                                </tr>
                                <tr style="text-align: center;">
                                    <td colspan="2" style="text-align: left;">অন্যান্য মৃতের সংখ্যা<br></td>
                                    <td class="v_field" id="death_number_other_death_fwa"></td>
                                    <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                </tr>
                                <tr style="text-align: center;">
                                    <td colspan="2" style="text-align: left;">সর্বমোট মৃতের সংখ্যা<br></td>
                                    <td class="v_field" id="death_number_all_death_fwa"></td>
                                    <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                </tr>
                            </table>
                        </div>

                        <div class="col-md-12"> <br><p style="font-weight:600;">ঙ) পুষ্টি সেবাঃ</p> গর্ভবতী ও ০-২৩ মাস বয়সী শিশুর মা  <span class="pull-right" style="text-align:right;">০ - ৫৯ মাস বয়সী শিশু</span></div>
                        <div class="col-md-6 e2b">
                            <div class="table-responsive">
                                <table class="table-bordered mis_table" style="width: 100%">
                                    <tr style="text-align: center;">
                                        <td style="text-align: left;">সেবার ধরণ</td>
                                        <td style="text-align: center">গর্ভবতী মা</td>
                                        <td style="text-align: center"> শিশুর মা <br>০-২৩ মাস</td>
                                    </tr>
                                    <tr style="text-align: center;"> 
                                        <td style="text-align: left;">আয়রন ও ফলিক এসিড বড়ি এবং বাড়তি খাবারের <br> উপর কাউন্সেলিং দেয়া হয়েছে</td>
                                        <td class="v_field" id="iron_folicacid_extrafood_counsiling_preg_woman"></td>
                                        <td class="v_field" id="iron_folicacid_extrafood_counsiling_child_0to23months"></td>
                                    </tr>
                                    <tr style="text-align: center;"> 
                                        <td style="text-align: left;">আয়রন ও ফলিক এসিড বড়ি বিতরণ করা হয়েছে<br></td>
                                        <td class="v_field" id="r_iron_folicacid_distribute_preg_woman"></td>
                                        <td class="v_field" id="r_iron_folicacid_distribute_child_0to23months"></td>
                                    </tr>
                                    <tr style="text-align: center;"> 
                                        <td style="text-align: left;">মায়ের দুধ ও পরিপূরক খাবারের উপর কাউন্সেলিং <br> দেয়া হয়েছে</td>
                                        <td class="v_field" id="bfeeding_complementary_food_counsiling_preg_woman" ></td>
                                        <td class="v_field" id="bfeeding_complementary_food_counsiling_child_0to23months"></td>
                                    </tr
                                    <tr style="text-align: center;"> 
                                        <td style="text-align: left;">শিশুকে মাল্টিপল মাইক্রোনিউট্রিয়েন্ট পাউডার <br> (এমএনপি) খাওয়ানো বিষয়ে কাউন্সেলিং দেয়া হয়েছে</td>
                                        <td style="background-color:#aebcc4"></td>
                                        <!--                                        <td id="counseling_of_multiple_micronewtrend_powder_feeding_to_child"></td>-->
                                        <td class="v_field" id="r_mnp_ounsiling_child_0to23months" style="text-align: center;"></td>
                                    </tr>
                                    </tr>
                                    </tr>
                                </table><!--No break need-->
                            </div>        
                        </div>
                        <div class="col-md-6 e2b">
                            <div class="table-responsive">
                                <table class="table-bordered mis_table" style="width: 100%">
                                    <colgroup>
                                        <col style="width: 301px">
                                        <col style="width: 50px">
                                        <col style="width: 50px">
                                        <col style="width: 50px">
                                    </colgroup>
                                    <tr style="text-align: center;">
                                        <td style="text-align: left;">সেবার ধরণ<br></td>
                                        <td style="text-align: center">০-৬ মাস<br></td>
                                        <td style="text-align: center">৬-২৪ মাস<br></td>
                                        <td style="text-align: center">২৪-৬০ মাস<br></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td style="text-align: left;">জন্মের ১ ঘণ্টার মধ্যে বুকের দুধ খাওয়ানো হয়েছে<br></td>
                                        <td class="v_field" id="birth_1hr_bfeed_0to6mon"></td>
                                        <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td style="text-align: left;">৬ মাস পর্যন্ত শুধুমাত্র বুকের দুধ খাওয়ানো হয়েছে/হচ্ছে<br></td>
                                        <td class="v_field" id="birth_only_bfeed_0to6mon"></td>
                                        <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td style="text-align: left;">জন্মের ৬ মাস পর থেকে পরিপূরক খাবার খাওয়ানো হয়েছে/হচ্ছে<br></td>
                                        <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        <td class="v_field" id="r_0_59_child_complementary_food_6to23mon"></td>
                                        <td class="v_field" id="r_0_59_child_complementary_food_24to59mon"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td style="text-align: left;">মাল্টিপল মাইক্রোনিউট্রিয়েন্ট পাউডার (এম এনপি) পেয়েছে<br></td>
                                        <td class="ka_table_inactive_field" style="background-color:#aebcc4"></td>
                                        <td class="v_field" id="mnp_given_6to23mon"></td>
                                        <td class="v_field" id="mnp_given_24toless60mon" style="background-color:#aebcc4"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td style="text-align: left;">MAM আক্রান্ত শিশুর সংখ্যা <br></td>
                                        <td class="v_field" id="mam_child_0to6mon"></td>
                                        <td class="v_field" id="mam_child_6to23mon"></td>
                                        <td class="v_field" id="mam_child_24toless60mon"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td style="text-align: left;">SAM আক্রান্ত রেফারকৃত শিশুর সংখ্যা <br></td>
                                        <td class="v_field" id="sam_child_0to6mon"></td>
                                        <td class="v_field" id="sam_child_6to23mon"></td>
                                        <td class="v_field" id="sam_child_24toless60mon"></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <br><h5 style="font-weight:bold;text-align: center">মাসিক মওজুদ ও বিতরণের হিসাব বিষয়কঃ</h5>
                        </div>
                        <div class="col-md-12">
                            <div class="table-responsive e2b">
                                <table class="table-bordered mis_table" style="width: 100%">
                                    <colgroup>
                                        <col style="width: 120px">
                                        <col style="width: 120px">
                                        <col style="width: 91px">
                                        <col style="width: 91px">
                                        <col style="width: 91px">
                                        <col style="width: 91px">
                                        <col style="width: 91px">
                                        <col style="width: 91px">
                                        <col style="width: 91px">
                                        <col style="width: 91px">
                                        <col style="width: 93px">
                                    </colgroup>
                                    <tr>
                                        <td class="tg-glis" style="text-align: left;">*ইস্যু ভাউচার নং<br></td>
                                        <td class="tg-031e"></td>
                                        <td class="tg-s6z2" colspan="2" style="text-align: center">খাবার বড়ি <br> (চক্র)<br></td>
                                        <td class="tg-s6z2" rowspan="2" style="text-align: center">কনডম<br>(নিরাপদ)<br>(পিস)<br></td>
                                        <td class="tg-s6z2" colspan="2" style="text-align: center">ইনজেকটেবল</td>
                                        <td class="tg-s6z2" rowspan="2" style="text-align: center">ইসিপি<br>(ডোজ)<br></td>
                                        <td class="tg-s6z2" rowspan="2" style="text-align: center">মিসো-<br>প্রোস্টল<br>(ডোজ)<br></td>
                                        <td class="tg-s6z2" rowspan="2" style="text-align: center">এমএনপি<br/>(স্যাসেট)</td>
                                        <td class="tg-s6z2" rowspan="2" style="text-align: center">আয়রন<br/>ফলিক<br/>এসিড<br/>(সংখ্যা)</td>
                                    </tr>
                                    <tr>
                                        <td class="tg-glis" style="text-align: left;">তারিখ</td>
                                        <td class="tg-031e"></td>
                                        <td class="tg-s6z2">সুখী<br></td>
                                        <td class="tg-s6z2">আপন<br></td>
                                        <td class="tg-s6z2" style="text-align: center">ভায়াল</td>
                                        <td class="tg-s6z2" style="text-align: center">সিরিঞ্জ</td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td class="tg-031e" colspan="2" style="text-align: left;">পূর্বের মওজুদ<br></td>
                                        <td class="tg-031e v_field" id="openingbalance1"></td>
                                        <td class="tg-031e v_field" id="openingbalance10"></td>
                                        <td class="tg-031e v_field" id="openingbalance2"></td>
                                        <td class="tg-031e v_field" id="openingbalance3"></td>
                                        <td class="tg-031e v_field" id="openingbalance5"></td>
                                        <td class="tg-031e v_field" id="openingbalance4"></td>
                                        <td class="tg-031e v_field" id="openingbalance9"></td>
                                        <td class="tg-031e v_field" id="openingbalance20"></td>
                                        <td class="tg-031e v_field" id="openingbalance19"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসে পাওয়া গেছে* (+)<br></td>
                                        <td class="tg-031e v_field" id="receiveqty1"></td>
                                        <td class="tg-031e v_field" id="receiveqty10"></td>
                                        <td class="tg-031e v_field" id="receiveqty2"></td>
                                        <td class="tg-031e v_field" id="receiveqty3"></td>
                                        <td class="tg-031e v_field" id="receiveqty5"></td>
                                        <td class="tg-031e v_field" id="receiveqty4"></td>
                                        <td class="tg-031e v_field" id="receiveqty9"></td>
                                        <td class="tg-031e v_field" id="receiveqty20"></td>
                                        <td class="tg-031e v_field" id="receiveqty19"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসের মোট মওজুদ<br></td>
                                        <td class="tg-031e v_field" id="current_month_stock1"></td>
                                        <td class="tg-031e v_field" id="current_month_stock10"></td>
                                        <td class="tg-031e v_field" id="current_month_stock2"></td>
                                        <td class="tg-031e v_field" id="current_month_stock3"></td>
                                        <td class="tg-031e v_field" id="current_month_stock5"></td>
                                        <td class="tg-031e v_field" id="current_month_stock4"></td>
                                        <td class="tg-031e v_field" id="current_month_stock9"></td>
                                        <td class="tg-031e v_field" id="current_month_stock20"></td>
                                        <td class="tg-031e v_field" id="current_month_stock19"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td class="tg-031e" rowspan="2" style="text-align: left;">সমন্বয়</td>
                                        <td class="tg-031e v_field" style="text-align: left;">(+)</td>
                                        <td class="tg-031e v_field" id="adjustment_plus1"></td>
                                        <td class="tg-031e v_field" id="adjustment_plus10"></td>    
                                        <td class="tg-031e v_field" id="adjustment_plus2"></td>
                                        <td class="tg-031e v_field" id="adjustment_plus3"></td>
                                        <td class="tg-031e v_field" id="adjustment_plus5"></td>
                                        <td class="tg-031e v_field"  id="adjustment_plus4"></td>
                                        <td class="tg-031e v_field"  id="adjustment_plus9"></td>
                                        <td class="tg-031e v_field"  id="adjustment_plus20"></td>
                                        <td class="tg-031e v_field"  id="adjustment_plus19"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td class="tg-031e" style="text-align: left;">(-)</td>
                                        <td class="tg-031e v_field" id="adjustment_minus1"></td>
                                        <td class="tg-031e v_field" id="adjustment_minus10"></td>    
                                        <td class="tg-031e v_field" id="adjustment_minus2"></td>
                                        <td class="tg-031e v_field" id="adjustment_minus3"></td>
                                        <td class="tg-031e v_field" id="adjustment_minus5"></td>
                                        <td class="tg-031e v_field"  id="adjustment_minus4"></td>
                                        <td class="tg-031e v_field"  id="adjustment_minus9"></td>
                                        <td class="tg-031e v_field"  id="adjustment_minus20"></td>
                                        <td class="tg-031e v_field"  id="adjustment_minus19"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td class="tg-031e" colspan="2" style="text-align: left;">সর্বমোট</td>
                                        <td class="tg-031e v_field" id="total1"></td>
                                        <td class="tg-031e v_field" id="total10"></td>    
                                        <td class="tg-031e v_field" id="total2"></td>
                                        <td class="tg-031e v_field" id="total3"></td>
                                        <td class="tg-031e v_field" id="total5"></td>
                                        <td class="tg-031e v_field"  id="total4"></td>
                                        <td class="tg-031e v_field"  id="total9"></td>
                                        <td class="tg-031e v_field"  id="total20"></td>
                                        <td class="tg-031e v_field"  id="total19"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসে বিতরণ করা হয়েছে(-)</td>
                                        <td class="tg-031e v_field" id="distribution1"></td>
                                        <td class="tg-031e v_field" id="distribution10"></td>    
                                        <td class="tg-031e v_field" id="distribution2"></td>
                                        <td class="tg-031e v_field" id="distribution3"></td>
                                        <td class="tg-031e v_field" id="distribution5"></td>
                                        <td class="tg-031e v_field"  id="distribution4"></td>
                                        <td class="tg-031e v_field"  id="distribution9"></td>
                                        <td class="tg-031e v_field"  id="distribution20"></td>
                                        <td class="tg-031e v_field"  id="distribution19"></td>
                                    </tr>
                                    <tr  style="text-align: center;">
                                        <td class="tg-031e" colspan="2" style="text-align: left;">অবশিষ্ট</td>
                                        <td class="tg-031e v_field" id="closingbalance1"></td>
                                        <td class="tg-031e v_field" id="closingbalance10"></td>    
                                        <td class="tg-031e v_field" id="closingbalance2"></td>
                                        <td class="tg-031e v_field" id="closingbalance3"></td>
                                        <td class="tg-031e v_field" id="closingbalance5"></td>
                                        <td class="tg-031e v_field"  id="closingbalance4"></td>
                                        <td class="tg-031e v_field"  id="closingbalance9"></td>
                                        <td class="tg-031e v_field"  id="closingbalance20"></td>
                                        <td class="tg-031e v_field"  id="closingbalance19"></td>
                                    </tr>
                                    <tr style="text-align: center;">
                                        <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসে কখনও মওজুদ শূণ্যতা<br/> হয়ে থাকলে কারণ (কোড) লিখুন <br></td>
                                        <td class="tg-031e v_field"></td>
                                        <td class="tg-031e v_field"></td>
                                        <td class="tg-031e v_field"></td>
                                        <td class="tg-031e v_field"></td>
                                        <td class="tg-031e v_field"></td>
                                        <td class="tg-031e v_field"></td>
                                        <td class="tg-031e v_field"></td>
                                        <td class="tg-031e v_field"></td>
                                        <td class="tg-031e v_field"></td>
                                    </tr>
                                </table>

                            </div> <!--End Table Responsive-->

                            <div class="table-responsive">
                                <table border="0"  style="table-layout: fixed; width: 100%;border:0px solid white!important;" class="table-responsive">
                                    <tr>
                                        <td style="text-align:center;border:none!important;"><br>
                                            মওজুদ শূন্যতার কোডঃ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    <span style="border: 1px solid black;padding-left: 5px;padding-right: 5px;">ক</span>&nbsp;সরবরাহ পাওয়া যায়নি<span id=''></span>    
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <span style="border: 1px solid black;padding-left: 5px;padding-right: 5px;">খ</span>&nbsp;অপর্যাপ্ত সরবরাহ<span id=''></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;  <span style="border: 1px solid black;padding-left: 5px;padding-right: 5px;">গ</span>&nbsp;হঠাৎ চাহিদা বৃদ্ধি পাওয়া<span id=''></span> 
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <span style="border: 1px solid black;padding-left: 5px;padding-right: 5px;">ঘ</span>&nbsp;অন্যান্য<span id=''></span>
                                        </td><br><br>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;border:none!important;"><br>
                                            পরিবার  কল্যাণ সহকারীর নামঃ<span id='providerName'>........................................</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                                            স্বাক্ষরঃ<span id=''>........................................</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            তারিখঃ<span id=''>........................................</span>
                                        </td>
                                    </tr>
                                </table>
                            </div> <br/>
                        </div>
                        <br/> 
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-------------------------------------------------------------------------------- edit User Modal -------------------------------------------------------------------------------->  
<!-------- Start Report Modal 
<%--<%@include file="/WEB-INF/jspf/modal-report-submit.jspf" %>  
<%@include file="/WEB-INF/jspf/modal-report-response.jspf" %>
<%@include file="/WEB-INF/jspf/modal-report-view.jspf" %>--%>
----------->
<!--Submit-->
<div id="modal-report-submit" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header label-info">
                <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                <h4 class="modal-title"><b><i class="fa fa-question-circle" aria-hidden="true"></i><span> আপনি কি নিশ্চিত ?</span></b></h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="note">মন্তব্য</label>
                    <textarea class="form-control" rows="4" id="note"></textarea>
                </div>
                <div class="form-group">
                    <button type="button"  id="btnConfirmToSubmit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Submitting" class="btn btn-flat btn-info"><b><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp; Submit</b></button>&nbsp;&nbsp;
                    <button type="button" class="btn btn-flat btn-default" data-dismiss="modal"><b><i class="fa fa-window-close"></i>&nbsp; Close</b></button>
                </div>
            </div>
        </div>
    </div>
</div>
<!--Response-->
<div id="modal-report-response" class="modal modal-center fade" role="dialog">
    <div class="modal-dialog modal-dialog-center modal-lg report-response">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header label-warning">
                <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                <h4 class="modal-title"><b><i class="fa fa-edit" aria-hidden="true"></i>&nbsp; <span id="responseViewTitle"></span></b></h4>
            </div>
            <div class="modal-body" >
                <div class="box box-chat box-default  direct-chat direct-chat-warning">
                    <div class="box-body">
                        <div class="direct-chat-messages">
                            <div class="direct-chat-msg">
                                <div class="direct-chat-info clearfix">
                                    <span class="direct-chat-name pull-left">Asma Akter</span>
                                    <span class="direct-chat-timestamp pull-right">23 Jan 2:00 pm</span>
                                </div>
                                <img class="direct-chat-img" src="https://metaclinician.com/assets/avatar_Dummy.png" alt="message user image">
                                <div class="direct-chat-text">
                                    এম আই এস রিপোর্ট টি জমা দেয়া হলো 
                                </div>
                            </div>
                            <div class="direct-chat-msg right">
                                <div class="direct-chat-info clearfix">
                                    <span class="direct-chat-name pull-right">Helal Khan</span>
                                    <span class="direct-chat-timestamp pull-left">23 Jan 2:05 pm</span>
                                </div>
                                <img class="direct-chat-img" src="https://metaclinician.com/assets/avatar_Dummy.png" alt="message user image">
                                <div class="direct-chat-text">
                                    আপনার রিপোর্ট কি অনুমোদন করা হলো
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box-footer">
                        <form action="-ReportSubmission?action=actionOnResponse" method="post" id="form-report-response" class="overlay-relative">

                            <!--                            <p><span class="bold">এল এম আই এস,</span> এর তথ্য নিচের ছক এ লিখুন</p>            
                                                        <table class="table-bordered lmis-table">
                                                                <colgroup>
                                                                    <col style="width: 130px">
                                                                    <col style="width: 120px">
                                                                    <col style="width: 91px">
                                                                    <col style="width: 91px">
                                                                    <col style="width: 91px">
                                                                    <col style="width: 91px">
                                                                    <col style="width: 91px">
                                                                    <col style="width: 91px">
                                                                    <col style="width: 91px">
                                                                    <col style="width: 91px">
                                                                    <col style="width: 93px">
                                                                </colgroup>
                                                                <tr>
                                                                    <td class="tg-glis" style="text-align: left;">*ইস্যু ভাউচার নং<br></td>
                                                                    <td class="tg-031e"></td>
                                                                    <td class="tg-s6z2" colspan="2" style="text-align: center">খাবার বড়ি <br> (চক্র)<br></td>
                                                                    <td class="tg-s6z2" rowspan="2" style="text-align: center">কনডম<br>(নিরাপদ)<br>(পিস)<br></td>
                                                                    <td class="tg-s6z2" colspan="2" style="text-align: center">ইনজেকটেবল</td>
                                                                    <td class="tg-s6z2" rowspan="2" style="text-align: center">ইসিপি<br>(ডোজ)<br></td>
                                                                    <td class="tg-s6z2" rowspan="2" style="text-align: center">মিসো-<br>প্রোস্টল<br>(ডোজ)<br></td>
                                                                    <td class="tg-s6z2" rowspan="2" style="text-align: center">এমএনপি<br/>(স্যাসেট)</td>
                                                                    <td class="tg-s6z2" rowspan="2" style="text-align: center">আয়রন<br/>ফলিক<br/>এসিড<br/>(সংখ্যা)</td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="tg-glis" style="text-align: left;">তারিখ</td>
                                                                    <td class="tg-031e"></td>
                                                                    <td class="tg-s6z2">সুখী<br></td>
                                                                    <td class="tg-s6z2">আপন<br></td>
                                                                    <td class="tg-s6z2" style="text-align: center">ভায়াল</td>
                                                                    <td class="tg-s6z2" style="text-align: center">সিরিঞ্জ</td>
                                                                </tr>
                                                                <tr style="text-align: center;">
                                                                    <td class="tg-031e" colspan="2" style="text-align: left;">পূর্বের মওজুদ<br></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control" name="openingbalance1"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="openingbalance10"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="openingbalance2"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="openingbalance3"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="openingbalance5"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="openingbalance4"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="openingbalance9"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="openingbalance20"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="openingbalance19"/></td>
                                                                </tr>
                                                                <tr style="text-align: center;">
                                                                    <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসে পাওয়া গেছে* (+)<br></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="receiveqty1"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="receiveqty10"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="receiveqty2"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="receiveqty3"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="receiveqty5"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="receiveqty4"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="receiveqty9"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="receiveqty20"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="receiveqty19"/></td>
                                                                </tr>
                                                                <tr style="text-align: center;">
                                                                    <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসের মোট মওজুদ<br></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="current_month_stock1"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="current_month_stock10"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="current_month_stock2"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="current_month_stock3"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="current_month_stock5"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="current_month_stock4"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="current_month_stock9"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="current_month_stock20"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="current_month_stock19"/></td>
                                                                </tr>
                                                                <tr style="text-align: center;">
                                                                    <td class="tg-031e" rowspan="2" style="text-align: left;">সমন্বয়</td>
                                                                    <td class="tg-031e v_field" style="text-align: left;">(+)</td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="adjustment_plus1"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="adjustment_plus10"/></td>    
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="adjustment_plus2"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="adjustment_plus3"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="adjustment_plus5"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="adjustment_plus4"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="adjustment_plus9"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="adjustment_plus20"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="adjustment_plus19"/></td>
                                                                </tr>
                                                                <tr style="text-align: center;">
                                                                    <td class="tg-031e" style="text-align: left;">(-)</td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="adjustment_minus1"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="adjustment_minus10"/></td>    
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="adjustment_minus2"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="adjustment_minus3"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="adjustment_minus5"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="adjustment_minus4"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="adjustment_minus9"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="adjustment_minus20"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="adjustment_minus19"/></td>
                                                                </tr>
                                                                <tr style="text-align: center;">
                                                                    <td class="tg-031e" colspan="2" style="text-align: left;">সর্বমোট</td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="total1"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="total10"/></td>    
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="total2"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="total3"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="total5"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="total4"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="total9"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="total20"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="total19"/></td>
                                                                </tr>
                                                                <tr style="text-align: center;">
                                                                    <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসে বিতরণ করা হয়েছে(-)</td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="distribution1"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="distribution10"/></td>    
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="distribution2"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="distribution3"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="distribution5"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="distribution4"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="distribution9"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="distribution20"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="distribution19"/></td>
                                                                </tr>
                                                                <tr  style="text-align: center;">
                                                                    <td class="tg-031e" colspan="2" style="text-align: left;">অবশিষ্ট</td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="closingbalance1"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="closingbalance10"/></td>    
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="closingbalance2"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="closingbalance3"/></td>
                                                                    <td class="tg-031e v_field"><input type="number" class="form-control"  name="closingbalance5"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="closingbalance4"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="closingbalance9"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="closingbalance20"/></td>
                                                                    <td class="tg-031e v_field" ><input type="number" class="form-control"  name="closingbalance19"/></td>
                                                                </tr>
                                                                <tr style="text-align: center;">
                                                                    <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসে কখনও মওজুদ শূণ্যতা<br/> হয়ে থাকলে কারণ (কোড) লিখুন <br></td>
                                                                    <td class="tg-031e v_field">
                                                                        <select class="form-control input-sm">
                                                                                <option>সরবরাহ পাওয়া যায়নি</option>
                                                                                <option>অপর্যাপ্ত সরবরাহ </option>
                                                                                <option>হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                                <option>অন্যান্য</option>
                                                                        </select>
                                                                    </td>
                                                                    <td class="tg-031e v_field"></td>
                                                                    <td class="tg-031e v_field"></td>
                                                                    <td class="tg-031e v_field"></td>
                                                                    <td class="tg-031e v_field"></td>
                                                                    <td class="tg-031e v_field"></td>
                                                                    <td class="tg-031e v_field"></td>
                                                                    <td class="tg-031e v_field"></td>
                                                                    <td class="tg-031e v_field"></td>
                                                                </tr>
                                                            </table>
                                                        <br/>-->

                            <div class="overlay hidden"></div>
                            <div class="input-group">
                                <span class="input-group-btn input-group-return">
                                    <button type="submit" class="btn btn-warning btn-flat" data-status="2" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading"><b><i class="fa fa-reply-all" aria-hidden="true"></i> Return</b></button>
                                </span>
                                <input type="text" name="message" placeholder="" class="form-control">
                                <span class="input-group-btn input-group-approve">
                                    <button type="submit" class="btn btn-warning btn-flat"  data-status="1" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading"><b><i class="fa fa-check-square-o" aria-hidden="true"></i> Approve</b></button>
                                </span>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--View-->
<div id="modal-report-view" class="modal fade" role="dialog">
    <div class="modal-dialog report-view">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header label-primary">
                <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                <h4 class="modal-title"><b><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp; <span id="reportViewTitle">Loading ...</span></b></h4>
            </div>

            <div class="modal-body" id="report">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>

