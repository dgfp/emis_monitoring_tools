<%-- 
    Document   : mis1-9
    Created on : Jan 05, 2018, 11:40:22 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<!--<script src="resources/js/area_dropdown_control_by_user_mis1_bangla.js"></script>-->
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla_test.js"></script>
<link href="resources/css/newStyle.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/mis.css" rel="stylesheet" type="text/css"/>
<script src="resources/js/mis1.js" type="text/javascript"></script>
<script src="resources/js/TemplateMIS.js" type="text/javascript"></script>
<style>
    #assign-add {
        display: none;
        background-color: #eaf0f7!important;
        border-radius: 10px; 
        padding: 1px;
        margin-left: 10px;
        margin-top: 3px;
    }
    .submitButton{
        display: block;
    }
    .table-responsive {
        border: 1px solid #fce8e5;
    }
    table, th, td {
        padding: 3px;
        padding-left: 5px;
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
        font-family: 'NikoshBAN';
        src: url('resources/fonts/NikoshBAN.ttf');
    }
    textarea {
        resize: vertical; /* user can resize vertically, but width is fixed */
    }

    .p1{
        padding-top: 100px!important;
    }
    .p2{
        padding-top: 75px!important;
    }
    .p3{
        padding-top: 65px!important;
    }
    .p4{
        padding-top: 40px!important;
    }

    table td.disabled-color{
        background-color:#a1afb7!important;  
    }

    .middle {
        height: 90px!important;
        line-height: 90px!important;
        text-align: center!important;
    }
    .middle_ {
        height: 90px!important;
        line-height: 220px!important;
        text-align: center!important;
    }
    .insert-lmis-data, .mis1-manual {
        max-width: 100%;
        overflow-x: auto;
    }
    .insert-lmis-data-table, .mis1-manual-table{
        width: 130%;
    }
    .direct-chat-messages {
        height: 74px!important;
    }
    .error{
        border: 2px solid red;
    }
    .tg-031e > select.input-sm {
        height: 40px!important;
    }

    table {
        height: 1em;
    }
    table table{
        height:100%;
        border:0px !important;
    }
    tr.row-sum td.cell-disabled{ position: relative; }
    tr.row-sum td.cell-disabled:before{ content: ""; display: block; background: rgba(255,255,255,.7);position: absolute; z-index: 1; top:0; right:0;bottom: 0;left:0 }
    .form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control {
        background-color: #f7f7f7!important;
    }
    .mis-form-1 {
        background: #fce8e5!important;
    }
    table.mis_form1_ka_new tbody tr td:not([rowspan="3"])+td{ text-align: center !important; }
    .dateWiseLevel{
        display: none;
    }
</style>
<script>
    $(function () {
        $('tr.row-input').find('input').attr('min', 0);
        $('tr.row-sum').find('input').prop('readonly', 1);
    });
</script>
<style media="print" type="text/css">
    .box, .carTable{
        border: 0!important;
    }
    #areaPanel, #back-to-top, .box-header, .main-footer, #viewStatus{
        display: none !important;
    }
    #viewStatus {
        margin-bottom: 0px!important;
    }

    table td.disabled-color{
        background-color:#aebcc4!important;  
    }

    .mis-template,.print-exact{
        -webkit-print-color-adjust: exact;
    }
    .mis1+.mis1,.page-break+.page-break {
        display: block; page-break-before: always;
    }
    .table-responsive {
        border: 1px solid #fff;
    }
    table, th, td {
        padding: 3px;
        padding-left: 5px;
        font-size: 14px;
    }
    .mis-form-1 {
        background: #fff!important;
    }
</style>
<script>
    //$('.insert-lmis-data').css('width', 760);
    var json = null;

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
    
//    var appFwa = {
//        appPrintReport: function(){
//            console.log("Print Called");
//            window.print();
//        }
//    };

    $(document).ready(function () {
        $(".dateWiseLevel").remove();
        $.app.hideNextMonths();

        function setJson(data) {
            json = data;
        }
        //Mis-1 Submission and resubmission
        //--------------------------------------------------------------
        // auto calculation of LMIS
        //--------------------------------------------------------------
        $('tr.row-input').find('input').attr('min', 0);
        $('tr.row-sum').find('input').prop('readonly', 1);
        $('body').on('input', '[type=number]', function (e) {
            var $target = $(e.target), value = $target.val();
            value = value.replace(/(?!^\-)[^\d]/gi, '');
            console.log("TARGET", $target);
            $target.val(value);
            if (value) {
                $target.removeClass('error');
            } else {
                $target.addClass('error');
            }
            //$('#modal-report-response').modal('show');//test
            autoCalcLMIS($target);
        });
        function autoCalcLMIS($target) {
            console.log('------autoSum-------');
            var negativeValues = function (values) {
                return $.map(values, function (d) {
                    return -1 * d;
                });
            };
            var carCalculation = function () {
                var unitTotalRecipient = +fpRowsStorage['fp-row-sum-unit'][Object.keys(fpRowsStorage['fp-row-sum-unit']).length - 1];
                var unitEligibleCouple = +$('input[type=number][name=unit_capable_elco_tot]').val();
                var perc = ((unitTotalRecipient / unitEligibleCouple) * 100).toFixed(2);
                var carId = '#modal-report-response #r_car', unitTotalRecipientId = '#modal-report-response #r_unit_all_total_tot'
                        , unitEligibleCoupleId = '#modal-report-response #r_unit_capable_elco_tot';
                $(carId).html("").html(perc);
                $(unitTotalRecipientId).html(unitTotalRecipient);
                $(unitEligibleCoupleId).html(unitEligibleCouple);

                //Pregnancy
                var pregnantTotal = +$('#modal-report-response input[type=number][name=curr_month_preg_new_fwa]').val()
                        + (+$('#modal-report-response input[type=number][name=curr_month_preg_old_fwa]').val())
                $('#modal-report-response input[type=number][name=curr_month_preg_tot_fwa]').val(pregnantTotal);

                //Death
                var d_child_total = +$('#modal-report-response input[type=number][name=death_number_less_1yr_0to7days_fwa]').val()
                        + (+$('#modal-report-response input[type=number][name=death_number_less_1yr_8to28days_fwa]').val())
                        + (+$('#modal-report-response input[type=number][name=death_number_less_1yr_29dystoless1yr_fwa]').val());

                $('#modal-report-response input[type=number][name=death_number_less_1yr_tot_fwa]').val(d_child_total);

                var d_all = +$('#modal-report-response input[type=number][name=death_number_less_1yr_0to7days_fwa]').val()
                        + (+$('#modal-report-response input[type=number][name=death_number_less_1yr_8to28days_fwa]').val())
                        + (+$('#modal-report-response input[type=number][name=death_number_less_1yr_29dystoless1yr_fwa]').val())
                        + (+$('#modal-report-response input[type=number][name=death_number_1yrto5yr_fwa]').val())
                        + (+$('#modal-report-response input[type=number][name=death_number_maternal_death_fwa]').val())
                        + (+$('#modal-report-response input[type=number][name=death_number_other_death_fwa]').val());
                $('#modal-report-response input[type=number][name=death_number_all_death_fwa]').val(d_all);
            };
            var getValues = function ($parent) {
                var pairs = {};
                $parent.find('input[type=number]').each(function (k, o) {
                    pairs[k] = +finiteFilter($(o).val());
                });
                return pairs;
            };
            var setValues = function ($parent, values) {
                $parent.find('input[type=number]').each(function (k, o) {
                    $(o).val(values[k]);
                });
            };
            var setFPValuesRowTotal = function ($table, $p, arrayValues) {
                $.each(arrayValues, function (key, value) {
                    var e = $($p).find("input[type=number][id$=" + key + "]");
                    e.val(value);
                });
                //console.log($p,$($p).find("input[type=number][name$=_total]").toArray());
            };
            var getFPRowCalc = function (elementArray) {
                var d = /\_normal$/, ad = /\_after_delivery$/,
                        totalNormal = 0, totalAfterDelivery = 0;
                elementArray.toArray().forEach(function (v, i) {
                    var n = $(v).attr('id'), value = +$(v).val();
                    totalNormal += n.match(d) ? (value ? value : 0) : 0;
                    totalAfterDelivery += n.match(ad) ? (value ? value : 0) : 0;
                });
                var allTotal = +(totalNormal) + +(totalAfterDelivery);
                return {
                    '_normal_total': totalNormal,
                    '_after_delivery_total': totalAfterDelivery,
                    'all_total': allTotal
                };
            };

            var relations = {
                "current_month_stock": ["openingbalance", "receiveqty"],
                "total": ["current_month_stock", "adjustment_plus", "adjustment_minus"],
                "closingbalance": ["total", "distribution"]
            };
            var $table = $target.closest('table');
            //CALCULATION FOR METHODS
            var fpRef = ['fp-row-sum-current-month', 'fp-row-sum-unit'];
            var fpRowsStorage = {
                'fp-row-sum-current-month': {},
                'fp-row-sum-unit': {}
            };
            var fpRows = [
                ".fpm_old", ".fpm_new", ".fpm_previous_month"
                        , ".fpm_no_method", ".fpm_different_method"
                        , ".fpm_method_referred", ".fpm_method_sideeffect"
            ];
            $.each(fpRows, function (i, v) {
                var $fpTable = $("#modal-report-response #mis_form1_ka_new_9v");
                var $input = $fpTable.find($(v + " input[type=number]"));
                var rowTotal = getFPRowCalc($input);
                setFPValuesRowTotal($fpTable, v, rowTotal);
                if (v === ".fpm_old" || v === ".fpm_new") {
                    var sumCurrentMonth = getValues($(v));
                    $.each(sumCurrentMonth, function (k, value) {
                        fpRowsStorage['fp-row-sum-current-month'][k] = !fpRowsStorage['fp-row-sum-current-month'].hasOwnProperty(k) ? value : (fpRowsStorage["fp-row-sum-current-month"][k] + value);
                    });
                }
                if (v === ".fpm_previous_month") {
                    var sumUnit = getValues($(v));
                    $.each(sumUnit, function (k, value) {
                        fpRowsStorage['fp-row-sum-unit'][k] = !fpRowsStorage['fp-row-sum-unit'].hasOwnProperty(k)
                                ? (fpRowsStorage["fp-row-sum-current-month"][k] + value)
                                : (fpRowsStorage["fp-row-sum-current-month"][k] + value);
                    });
                }
            });
            console.log(fpRowsStorage['fp-row-sum-unit']);
            fpRef.forEach(function (item, index) {
                $('#' + item + '>td:not(:first-child)>input[type=number]').each(function (index, element) {
                    $(element).val(fpRowsStorage[item][index]);
                });
            });
            carCalculation();
            
            //CALCULATION FOR LMIS
            var storage = {};

            $table.find('.row-input').each(function (i, tr) {
                var key = $(tr).attr('id'), data = getValues($(tr));
                if ($(tr).is('.row-minus')) {
                    data = negativeValues(data);
                }
                storage[key] = data;
                console.log("row-input", data, storage);
            });
            var calc = new Calc([]);
            $.each(relations, function (key, rel) {
                var data = rel.reduce(function (p, n) {
                    p.push(storage[n]);
                    return p;
                }, []);
                storage[key] = calc.Sum(data);
                var $tr = $table.find('.row-sum#' + key);
                setValues($tr, storage[key]);
            });
        }

        $('.input-group-approve', '#form-report-response').find('button').click(function (e) {
            e.preventDefault();
            var id = +new Date();
            var isValided = true;
            var mis1Json = $.app.pairs($('#form-report-response'));
            delete mis1Json.message;

            $.each(mis1Json, function (index, object) {
                if (object == "" && index.split("_")[0] != "stockvacuum") {
                    toastr["error"]("<b>সকল ঘর পূরণ করুন, ডাটা না থাকলে শুন্য লিখুন</b>");
                    isValided = false;
                    $("input[name='" + index + "']").addClass("error");
                } else {
                    $("input[name='" + index + "']").removeClass("error");
                }
            });

            var lmisJson = {};
            $('#lmis-data :input').map(function (i, e) {
                var n = $(e).attr('name');
                var v = $(e).val();
                lmisJson[n] = v;
                delete mis1Json[n];
            });
            //console.log(json);
            //var mis1JsonData = Object.assign({}, mis1Json);
            //const eventData = $.extend({}, eventItem);
            var mis1JsonData = $.extend({}, mis1Json);
            
            mis1JsonData.r_car = $.app.percentage(mis1Json.unit_all_total_tot, mis1Json.unit_capable_elco_tot, 2).toString();
            mis1JsonData.r_dist_name = json.MIS[0].r_dist_name
            mis1JsonData.r_upz_name = json.MIS[0].r_upz_name;
            mis1JsonData.r_un_name = json.MIS[0].r_un_name;
            mis1JsonData.r_unit_name = json.MIS[0].r_unit_name;
            mis1JsonData.r_ward_name = json.MIS[0].r_ward_name;

            json.MIS = [mis1JsonData];
            json.LMIS = lmisJson;
            mis1Json.car = $.app.percentage(mis1Json.unit_all_total_tot, mis1Json.unit_capable_elco_tot, 2).toString();

            console.log(json);
            console.log(mis1Json);
            console.log(mis1JsonData);
            console.log(lmisJson);


            //isValided = false;

            if (isValided) {
                //json.LMIS = mis1Json;
                $.ajax({
                    url: "mis-form-1-additional?action=submitReport&subType=" + json.status,
                    data: {
                        divisionId: $("select#division").val(),
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val(),
                        fwaUnit: $("select#unit").val(),
                        provCode: $("select#provCode").val(),
                        month: $("select#month").val(),
                        year: $("select#year").val(),
                        date: getCurrentPreviousDate($("select#month").val(), $("#year").val()),
                        data: JSON.stringify(json),
                        note: $("input[name='message']").val(),
                        html: $('#data-table').html(),
                        submissionId: id,
                        reviewLength: $.RS.reviewJson.length,
                        mis1: JSON.stringify(mis1Json),
                        lmis: JSON.stringify(lmisJson)
                    },
                    type: 'POST',
                    success: function (result) {
                        var data = JSON.parse(result);
                        console.log("Get ID:" + id);
                        $.RS.submissionId = id;
                        console.log("Get ID var:" + id);
                        $.RS.conversationModal('hide');

                        console.log(data[0].message, data[0].status);

//                        if (json.status == 2)
//                            $.RS.submissionStatus('rePending');
//                        else
//                            $.RS.submissionStatus('pending');
                        
                        
                        if (json.status == 2){
                            $.RS.submissionStatus('rePending');
                            $("#submitDataButton").attr("disabled", true);
                        }else{
                            $.RS.submissionStatus('pending');
                            $("#submitDataButton").attr("disabled", true);
                        }

                        if (data[0].message == "Somthing went wrong")
                            $.RS.submissionStatus('notSubmitted');


                        $.toast(data[0].message, data[0].status)();
                        $('#showdataButton').click();
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

            $('#form-report-response input').val(0);


            $('#form-report-response').find('button').html('<b><i class="fa fa-paper-plane" aria-hidden="true"></i>  জমা দিন</b>');
            $('.modal-title').html('<b><i class="fa fa-file-text-o" aria-hidden="true"></i> MIS 1 (FWA) - জমা দিন</b>');
            $.each(json.LMIS, function (k, v) {
                $("[name=" + k + "]").val(v);
            });
            $("input[name='message']").val("");
            $.loadReviewDataByProvider();
        });
        $('select#division, select#district, select#upazila, select#union, select#unit, select#provCode, select#month , select#year').on('change', function () {
            setJson(null);
            $.RS.submissionId = 0;
            $("#submitDataButton").fadeOut();
            $("#viewStatus").children().fadeOut();
            //$('.dateWiseLevel').fadeIn(300);
        });


        Template.init(111);
        $('#showdataButton').click(function () {
            var regExp = /(\d{1,2})\/(\d{1,2})\/(\d{2,4})/; //for date compare
            //Reset MIS1/////////////////////////////
            var pairs = Template.pairs();
            var version = Template.getVersion(pairs.year, pairs.month);
            Template.reset(version);
            /////////////////////////////////////////////

            $.RS.submissionButton('hide');
            $("#viewStatus").children().fadeOut();
            var d = new Date(), m = d.getMonth() + 1, y = d.getFullYear();
            var $form = $('#form-report-response');
            if ($form.length) {
                $form.get(0).reset();
                $form.find(".form-control").removeClass("error");
            }
            //Report Validation---------------------------------------------------------------------------------------------------------------
            if ($("select#division").val() === "") {
                toastr["error"]("<b>বিভাগ সিলেক্ট করুন </b>");
            } else if ($("select#district").val() === "") {
                toastr["error"]("<b>জেলা সিলেক্ট করুন </b>");
            } else if ($("select#upazila").val() === "") {
                toastr["error"]("<b>উপজেলা সিলেক্ট করুন</b>");
            } else if ($("select#union").val() === "") {
                toastr["error"]("<b>ইউনিয়ন সিলেক্ট করুন</b>");
            } else if ($("select#unit").val() === "") {
                toastr["error"]("<b>ইউনিট সিলেক্ট করুন</b>");
            } else if ($("select#provCode").val() === "") {
                toastr["error"]("<b>প্রোভাইডার সিলেক্ট করুন</b>");
            }
//            else if (parseInt($("#sDate").val().replace(regExp, "$3$2$1")) > parseInt($("#eDate").val().replace(regExp, "$3$2$1"))) {
//                toastr["error"]("<b>শুরুর তারিখ শেষের তারিখ থেকে বেশি হবে না</b>");
//            } 
            else {
                if ($("#reportType:checked").val() == "dateWise") {
                    if ($("#sDate").val() == "") {
                        toastr["error"]("<b>শুরুর তারিখ সিলেক্ট করুন</b>");
                        return;
                    } else if ($("#eDate").val() == "") {
                        toastr["error"]("<b>শেষের তারিখ সিলেক্ট করুন</b>");
                        return;
                    }
                }

                $.ajax({
                    url: Template.viewURL,
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
                        reportType: $("#reportType:checked").val(),
                    },
                    type: 'POST',
                    success: function (result) {
                        var data = JSON.parse(result);
                        console.log(data);
                        setJson(data);
                        json = data;
                        if (data.length === 0) {
                            toastr["error"]("<h4><b>কোন ডাটা পাওয়া যায়নি</b></h4>");
                            return;
                        }
                        var json = data.MIS, mis = data.MIS, csbaJson = data.CSBA, lmis = data.LMIS, submissionDate = data.submissionDate;

                        $('#isSubmitAccess').val() == '99' ? $.RS.submissionButton('show') : $.RS.submissionButton('hide');
                        $("#assign-add").css("display", "block")


                        //Set status here
                        //For not submitted
                        if (data.isSubmittable && data.status == undefined) {
                            $.RS.submissionStatus('notSubmitted');
                            $("#submitDataButton").attr("disabled", false);

                            //For pending
                        } else if (data.status == 0) {
                            $.RS.submissionStatus('pending');
                            $("#submitDataButton").attr("disabled", true);

                            //For resubmit
                        } else if (data.status == 2) {
                            $.RS.submissionStatus('revised');
                            $("#submitDataButton").attr("disabled", false);

                            //Re-submitted
                        } else if (data.status == 3) {
                            $.RS.submissionStatus('rePending');
                            $("#submitDataButton").attr("disabled", true);

                            //Otherwise is submitted
                        } else {
                            $("#submitDataButton").hide();
                            $.RS.submissionStatus('submitted');
                            $('.dateWiseLevel').fadeOut(300);
                            $('.dateRange').fadeOut(300);
                            $('.monthWise').prop('checked', true);
                        }

//                        if ($('#month').val() == $.app.date().month && $.app.date().day < $.app.date().lastDay && $.app.user.role!="Super admin")
//                            $("#submitDataButton").attr("disabled", true);
//                        TEST FOLLOWING PROPERLY
//                        if ($('#year').val() >= $.app.date().year && $('#month').val() >= $.app.date().month && $.app.date().day < $.app.date().lastDay && $.app.user.role!="Super admin")
//                            $("#submitDataButton").attr("disabled", true);

                        if ($.app.date().month - parseInt($('#month').val()) <= 0 && $.app.date().year - parseInt($('#year').val()) <= 0 && $.app.user.role!="Super admin")
                            $("#submitDataButton").attr("disabled", true);

                        //Top area part
                        function setHeaderArea(row) {
                            var d = {r_unit_name: 'aaa', r_ward_name: 'bbbb', r_un_name: 'ccc', r_upz_name: 'ddd', r_dist_name: 'eee'};
                            if (row) {
                                d = row;
                            }
                            $("#unitValue").html("&nbsp;<b>" + d.r_unit_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                            $("#wardValue").html("&nbsp;<b>" + e2b(d.r_ward_name) + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                            $("#unionValue").html("&nbsp;<b>" + d.r_un_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                            $("#upazilaValue").html("&nbsp;<b>" + d.r_upz_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                            $("#districtValue").html("&nbsp;<b>" + d.r_dist_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                            $("#yearValue").html("<b>" + convertE2B($("#year :selected").text()) + "&nbsp;&nbsp;&nbsp;&nbsp;</b>");
                            $("#monthValue").html("<b>" + $("#month :selected").text() + "</b>");
                        }
                        setHeaderArea(json[0]);
                        var providerName = $("#provCode :selected").text().replace(/\s?[\[\d\]]/g, '');
                        $("#providerName").html("&nbsp;&nbsp;<b>" + providerName + "</b>");
                        if (submissionDate === undefined) {
                            submissionDate = "........................................";
                        } else {
                            submissionDate = e2b(convertToUserDate(submissionDate));
                        }
                        $("#submissionDate").html("&nbsp;&nbsp;<b>" + submissionDate + "</b>");
                        var $tables = $('table', Template.context);

                        //Data rendering into table
                        var mis_data = mis[0] || {};
                        if (!mis_data.r_car && mis_data.r_unit_capable_elco_tot) {
                            var r_car = 0;
                            console.log('recalculating>> r_car', r_car);
                            r_car = $.app.percentage(mis_data.r_unit_all_total_tot, mis_data.r_unit_capable_elco_tot, 2);
                            console.log('recalculated>> r_car', r_car);
                            mis_data.r_car = r_car;
                        }
                        var NA = [], SKIP = ['r_car', 'r_unit_all_total_tot', 'r_unit_capable_elco_tot'];
                        $.each(mis_data, function (k, v) {
                            var _k = '[id$=' + k.replace(/^(r|v)_/, '') + ']', _v = Template.reportValue(v, ~SKIP.indexOf(k));
                            var $k = $tables.find(_k);
                            if ($k.length) {
                                $k.html(_v);
                            } else {
                                NA.push(_k);
                                console.log('mis', k, $k.length, _v);
                            }
                        });

                        console.log("Missing variables (NA):", NA);
                        //LMIS
                        var $stockvacuum = {
                            0: '-',
                            1: 'ক',
                            1: 'ক',
                            2: 'খ',
                            3: 'গ',
                            4: 'ঘ'
                        }
                        $.each(lmis, function (k, v) {
                            $row = e2b(finiteFilter(v));
                            if (k.split("_")[0] == "stockvacuum")
                                $row = $stockvacuum[v];
                            $('.mis_table').find('#' + k).html($row);
                        });
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        toastr["error"]("<h4><b>অনুরোধটি প্রক্রিয়াধীন করা যাচ্ছে না</b></h4>");
                    }
                }); //End Ajax Call
            }
        }); //End show data button click
    });</script>
    ${sessionScope.designation=='FWA'  || sessionScope.role=='Super admin'?
      "<input type='hidden' id='isSubmitAccess' value='99'>" : "<input type='hidden' id='isSubmitAccess' value='66'>"}
      ${sessionScope.designation=='FWA' || sessionScope.designation=='FPI' || sessionScope.designation=='UFPO' || sessionScope.designation=='M & E Officer' ? 
        "<input type='hidden' id='isAccessToViewRealData' value='99'>" : "<input type='hidden' id='isAccessToViewRealData' value='66'>"}
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1 id="pageTitle">
            <span id="title">MIS 1 and CSBA report</span>
            <span id="submitStatus" class="pull-right"></span>
        </h1>
        <!--        <ol class="breadcrumb">
                    <a class="btn btn-flat btn-warning btn-sm bold" style="width: 115px" href="mis-form-1-test">মূল ইউনিট</a>
                </ol>-->
    </section>
    <section class="content">
        <!------------------------------Load Area----------------------------------->
        <%@include file="/WEB-INF/jspf/mis1AreaBanglaAdditional.jspf" %>
        <div id="viewStatus">
        </div>
        <!--------------------------------------------------------------------------------Data Table Goes Here-------------------------------------------------------------------------------->  
        <div class="box box-primary full-screen">
            <div class="box-header with-border" style="padding: 0px;">
                <p class="box-title" style="">
                    <span class="text-yellow bold" id="assign-add">অতিরিক্ত ইউনিট</span>
                </p>

                <div class="box-tools pull-right" style="margin-top: -10px;">
                    <!--window.print();-->
                    <button type="button" class="btn btn-flat btn-default btn-xs bold" onclick="appFwa.appPrintReport()"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                    <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                </div>
            </div>
            <div class="box-body mis-template" id="data-table">
                <%@include file="/WEB-INF/jspf/mis1-9-template-view.jspf" %>
                <%@include file="/WEB-INF/jspf/mis1-8-template-view.jspf" %>
            </div>
        </div>
    </section>

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
    <style>
        /*        .report-response {
                    width: 98%;
                }*/
        .mis1 input{
            background-color: #fff1ef;
            border: 1px solid #fff1ef;
            font-weight: bold;
        }
        .mis1 select{
            background-color: #fff1ef;
            border: 1px solid #fff1ef;
        }
        .mis1 .form-control {
            padding: 0px 0px;
            height: 25px;
            color: #000;
        }
        /*         Chrome, Safari, Edge, Opera 
                .mis1 input::-webkit-outer-spin-button,
                .mis1 input::-webkit-inner-spin-button {
                    -webkit-appearance: none;
                    margin: 0;
                }
                 Firefox 
                .mis1 input[type=number] {
                    -moz-appearance:textfield;
                }*/
        .direct-chat-messages {
            height: 10px!important;
        }
        .box-footer {
            padding: 0px;
            margin-top: -35px;
        }
        .mis1-margin-bottom {
            margin-bottom: 10px;
        }
    </style>
    <div id="modal-report-response" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg report-response">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                    <h4 class="modal-title bold"><span id="responseViewTitle"></span></h4>
                </div>
                <div class="modal-body" >
                    <div class="box box-chat box-default  direct-chat direct-chat-warning">
                        <div class="box-body">
                            <div class="direct-chat-messages">
                                <div class="direct-chat-msg">
                                    <div class="direct-chat-info clearfix">
                                        <span class="direct-chat-name pull-left">Rahen Rahgan</span>
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
                        <div class="box-footer mis1-submission">
                            <form action="-ReportSubmission?action=actionOnResponse" method="post" id="form-report-response" class="overlay-relative">
                                <div class="col-ld-12 mis1">
                                    <div class="col-md-12 mis-form-1"  style="padding: -100px;">
                                        <div class="table-responsive" >
                                            <table  style="text-align: left; width: 100%;border: 0!important;" id="topHeader">
                                                <tr>
                                                    <th style="border:none!important;">
                                                        <div id='slogan' class="slogan">দুটি সন্তানের বেশি নয়<br/>একটি হলে ভাল হয়</div>
                                                        <img id='logo' src="resources/logo/Fpi_logo.png"  alt="9th"/>
                                                    </th>
                                                    <th style="text-align:center;border:none!important;" colspan="2">
                                                        <small>গণপ্রজাতন্ত্রী বাংলাদেশ সরকার<br>পরিবার পরিকল্পনা অধিদপ্তর</small>
                                                        <br>পরিবার পরিকল্পনা, মা ও শিশু স্বাস্থ্য কার্যক্রমের মাসিক অগ্রগতির প্রতিবেদন
                                                        <br>মাসঃ <span id='month_no'>...............................</span> সালঃ <span id="year_no">...............................</span>
                                                    </th>
                                                    <th style="text-align:right;border:none!important;" id="page">এম আই এস ফরম - ১<br>পৃষ্ঠা-১</th>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="text-align:center;border:none!important;"><br>
                                                        ইউনিট নম্বরঃ<span id='r_unit_name' class="bold"> .......................</span>     &nbsp;&nbsp;&nbsp;&nbsp;
                                                        ওয়ার্ড নম্বরঃ<span id='r_ward_name' class="bold"> .......................</span>    &nbsp;&nbsp;&nbsp;&nbsp;
                                                        ইউনিয়নঃ<span id='r_un_name' class="bold"> .......................</span>     &nbsp;&nbsp;&nbsp;&nbsp;
                                                        উপজেলা/থানাঃ<span id='r_upz_name' class="bold"> .......................</span>     &nbsp;&nbsp;&nbsp;&nbsp;
                                                        জেলাঃ<span id='r_dist_name' class="bold"> .......................</span>   
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <p> <strong> ক) পরিবার পরিকল্পনা পদ্ধতিঃ </strong> </p>
                                        <div class="mis1-manual mis1-margin-bottom">
                                            <table class="table-bordered mis_form1_ka_new mis1-manual-table" id="mis_form1_ka_new_9v" style="table-layout: fixed;padding-left: 5px!important">
                                                <colgroup>
                                                    <col style="width: 90px">
                                                    <col style="width: 130px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 52px">
                                                </colgroup>
                                                <tr>
                                                    <td colspan="2" rowspan="4"></td>
                                                    <td colspan="17" class="center">পদ্ধতি গ্রহনকারী</td>
                                                </tr>
                                                <tr>
                                                    <td rowspan="1" colspan="2" class="center">খাবার বড়ি</td>
                                                    <td rowspan="1" colspan="2" >কনডম</td>
                                                    <td rowspan="1" colspan="2" class="center">ইনজেকটেবল</td>
                                                    <td rowspan="1" colspan="2" >আইইউডি</td>
                                                    <td rowspan="1" colspan="2" >ইমপ্ল্যান্ট</td>
                                                    <td colspan="4" class="center">স্থায়ী পদ্ধতি</td>
                                                    <td rowspan="2" colspan="2" class="middle">মোট</td>
                                                    <td rowspan="3"  class="middle_ center">সর্বমোট</td>
                                                </tr>
                                                <tr>
                                                    <td rowspan="2" class="p1"><span class="r-v">স্বাভাবিক</span></td>
                                                    <td rowspan="2" class="p2"><span class="r-v">*প্রসব পরবর্তী </span></td>
                                                    <td rowspan="2" class="p1"><span class="r-v">স্বাভাবিক</span></td>
                                                    <td rowspan="2" class="p2"><span class="r-v">*প্রসব পরবর্তী </span></td>
                                                    <td rowspan="2" class="p1"><span class="r-v">স্বাভাবিক</span></td>
                                                    <td rowspan="2" class="p2"><span class="r-v">*প্রসব পরবর্তী </span></td>
                                                    <td rowspan="2" class="p1"><span class="r-v">স্বাভাবিক</span></td>
                                                    <td rowspan="2" class="p2"><span class="r-v">*প্রসব পরবর্তী </span></td>
                                                    <td rowspan="2" class="p1"><span class="r-v">স্বাভাবিক</span></td>
                                                    <td rowspan="2" class="p2"><span class="r-v">*প্রসব পরবর্তী </span></td>
                                                    <td colspan="2">পুরুষ</td>
                                                    <td colspan="2">মহিলা</td>
                                                </tr>
                                                <tr>
                                                    <td class="p3"><span class="r-v">স্বাভাবিক</span></td>
                                                    <td class="p4"><span class="r-v">*প্রসব পরবর্তী </span></td>
                                                    <td class="p3"><span class="r-v">স্বাভাবিক</span></td>
                                                    <td class="p4"><span class="r-v">*প্রসব পরবর্তী </span></td>
                                                    <td class="p3"><span class="r-v">স্বাভাবিক</span></td>
                                                    <td class="p4"><span class="r-v">*প্রসব পরবর্তী </span></td>
                                                </tr>
                                                <tr class="fpm_old">
                                                    <td colspan="2">পুরাতন </td>
                                                    <td><input type="number" min="0" class="form-control" id="old_pill_normal" name="old_pill_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="old_pill_after_delivery" name="old_pill_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="old_condom_normal" name="old_condom_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="old_condom_after_delivery" name="old_condom_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="old_inject_normal" name="old_inject_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="old_inject_after_delivery" name="old_inject_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="old_iud_normal" name="old_iud_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="old_iud_after_delivery" name="old_iud_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="old_implant_normal" name="old_implant_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="old_implant_after_delivery" name="old_implant_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="old_permanent_man_normal" name="old_permanent_man_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="old_permanent_man_after_delivery" name="old_permanent_man_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="old_permanent_woman_normal" name="old_permanent_woman_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="old_permanent_woman_after_delivery" name="old_permanent_woman_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="old_normal_total" name="old_normal_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="old_after_delivery_total" name="old_after_delivery_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="old_all_total" name="old_all_total"/></td>
                                                </tr>
                                                <tr class="fpm_new">
                                                    <td colspan="2">নতুন</td>
                                                    <td><input type="number" min="0" class="form-control" id="new_pill_normal" name="new_pill_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="new_pill_after_delivery" name="new_pill_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="new_condom_normal" name="new_condom_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="new_condom_after_delivery" name="new_condom_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="new_inject_normal" name="new_inject_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="new_inject_after_delivery" name="new_inject_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="new_iud_normal" name="new_iud_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="new_iud_after_delivery" name="new_iud_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="new_implant_normal" name="new_implant_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="new_implant_after_delivery" name="new_implant_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="new_permanent_man_normal" name="new_permanent_man_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="new_permanent_man_after_delivery" name="new_permanent_man_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="new_permanent_woman_normal" name="new_permanent_woman_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="new_permanent_woman_after_delivery" name="new_permanent_woman_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="new_normal_total" name="new_normal_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="new_after_delivery_total" name="new_after_delivery_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="new_all_total" name="new_all_total"/></td>
                                                </tr>
                                                <tr class="fp-row-sum" id="fp-row-sum-current-month">
                                                    <td colspan="2">চলতি মাসের মোট</td>
                                                    <td><input type="number" read-only class="form-control" name="curr_month_pill_normal_total"/></td>
                                                    <td><input type="number" read-only class="form-control" name="curr_month_pill_after_delivery_total"/></td>
                                                    <td><input type="number" read-only class="form-control" name="curr_month_condom_normal_total"/></td>
                                                    <td><input type="number" read-only class="form-control" name="curr_month_condom_after_delivery_total"/></td>
                                                    <td><input type="number" read-only class="form-control" name="curr_month_inject_normal_total"/></td>
                                                    <td><input type="number" read-only class="form-control" name="curr_month_inject_after_delivery_total"/></td>
                                                    <td><input type="number" read-only class="form-control" name="curr_month_iud_normal_total"/></td>
                                                    <td><input type="number" read-only class="form-control" name="curr_month_iud_after_delivery_total"/></td>
                                                    <td><input type="number" read-only class="form-control" name="curr_month_implant_normal_total"/></td>
                                                    <td><input type="number" read-only class="form-control" name="curr_month_implant_after_delivery_total"/></td>
                                                    <td><input type="number" read-only class="form-control" name="curr_month_permanent_normal_man"/></td>
                                                    <td><input type="number" read-only class="form-control" name="curr_month_permanent_after_delivery_man"/></td>
                                                    <td><input type="number" read-only class="form-control" name="curr_month_permanent_normal_woman"/></td>
                                                    <td><input type="number" read-only class="form-control" name="curr_month_permanent_after_delivery_woman"/></td>
                                                    <td><input type="number" read-only class="form-control" name="curr_month_normal_total"/></td>
                                                    <td><input type="number" read-only class="form-control" name="curr_month_after_delivery_total"/></td>
                                                    <td><input type="number" read-only class="form-control" name="curr_month_all_total"/></td>
                                                </tr>
                                                <tr class="fpm_previous_month">
                                                    <td colspan="2">পূর্ববর্তী মাসের মোট</td>
                                                    <td><input type="number" min="0" class="form-control" id="prev_month_pill_total_normal" name="prev_month_pill_normal_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="prev_month_pill_total_after_delivery" name="prev_month_pill_after_delivery_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="prev_month_condom_total_normal" name="prev_month_condom_normal_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="prev_month_condom_total__after_delivery" name="prev_month_condom__after_delivery_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="prev_month_inject_total_normal" name="prev_month_inject_normal_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="prev_month_inject_total_after_delivery" name="prev_month_inject_after_delivery_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="prev_month_iud_total_normal" name="prev_month_iud_normal_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="prev_month_iud_total_after_delivery" name="prev_month_iud_after_delivery_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="prev_month_implant_total_normal" name="prev_month_implant_normal_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="prev_month_implant_total_after_delivery" name="prev_month_implant_after_delivery_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="prev_month_permanent_man_normal" name="prev_month_permanent_normal_man"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="prev_month_permanent_man_after_delivery" name="prev_month_permanent_after_delivery_man"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="prev_month_permanent_woman_normal" name="prev_month_permanent_normal_woman"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="prev_month_permanent_woman_after_delivery" name="prev_month_permanent_after_delivery_woman"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="prev_month_all_normal_total" name="prev_month_all_normal_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="prev_month_all_after_delivery_total" name="prev_month_all_after_delivery_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="prev_month_all_total" name="prev_month_all_total"/></td>
                                                </tr>
                                                <tr class="fp-row-sum" id="fp-row-sum-unit">
                                                    <td colspan="2">ইউনিটের সর্বমোট</td>
                                                    <td><input type="number" class="form-control" name="unit_pill_tot_normal"/></td>
                                                    <td><input type="number" class="form-control" name="unit_pill_tot_after_delivery"/></td>
                                                    <td><input type="number" class="form-control" name="unit_condom_tot_normal"/></td>
                                                    <td><input type="number" class="form-control" name="unit_condom_tot_after_delivery"/></td>
                                                    <td><input type="number" class="form-control" name="unit_inject_tot_normal"/></td>
                                                    <td><input type="number" class="form-control" name="unit_inject_tot_after_delivery"/></td>
                                                    <td><input type="number" class="form-control" name="unit_iud_tot_normal"/></td>
                                                    <td><input type="number" class="form-control" name="unit_iud_tot_after_delivery"/></td>
                                                    <td><input type="number" class="form-control" name="unit_implant_tot_normal"/></td>
                                                    <td><input type="number" class="form-control" name="unit_implant_tot_after_delivery"/></td>
                                                    <td><input type="number" class="form-control" name="unit_permanent_man_tot_normal"/></td>
                                                    <td><input type="number" class="form-control" name="unit_permanent_man_tot_after_delivery"/></td>
                                                    <td><input type="number" class="form-control" name="unit_permanent_woman_tot_normal"/></td>
                                                    <td><input type="number" class="form-control" name="unit_permanent_woman_tot_after_delivery"/></td>
                                                    <td><input type="number" class="form-control" name="unit_all_normal_total"/></td>
                                                    <td><input type="number" class="form-control" name="unit_all_after_delivery_total"/></td>
                                                    <td><input type="number" class="form-control" name="unit_all_total_tot"/></td>
                                                </tr>
                                                <tr class="fpm_no_method">
                                                    <td rowspan="3" class="center"><span class="r-v">চলতি মাসে<br/>ছেড়ে দিয়েছে <br/>/পরিবর্তন<br/>হয়েছে</span></td>
                                                    <td>কোন পদ্ধতি নেয়নি </td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_month_left_no_method_pill_normal" name="curr_month_left_no_method_pill_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_month_left_no_method_pill_after_delivery" name="curr_month_left_no_method_pill_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_month_left_no_method_condom_normal" name="curr_month_left_no_method_condom_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_month_left_no_method_condom_after_delivery" name="curr_month_left_no_method_condom_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_month_left_no_method_inject_normal" name="curr_month_left_no_method_inject_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_month_left_no_method_inject_after_delivery" name="curr_month_left_no_method_inject_after_delivery"></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_month_left_no_method_iud_normal" name="curr_month_left_no_method_iud_normal"></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_month_left_no_method_iud_after_delivery" name="curr_month_left_no_method_iud_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_month_left_no_method_implant_normal" name="curr_month_left_no_method_implant_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_month_left_no_method_implant_after_delivery" name="curr_month_left_no_method_implant_after_delivery"/></td>
                                                    <td  id="" class="disabled-color">&nbsp;</td>
                                                    <td  id="" class="disabled-color">&nbsp;</td>
                                                    <td  id="" class="disabled-color">&nbsp;</td>
                                                    <td  id="" class="disabled-color">&nbsp;</td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_month_left_no_method_normal_total" name="curr_month_left_no_method_normal_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_month_left_no_method_after_delivery_total" name="curr_month_left_no_method_after_delivery_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_month_left_no_method_all_total" name="curr_month_left_no_method_all_tot"/></td>
                                                </tr>
                                                <tr class="fpm_different_method">
                                                    <td>অন্য পদ্ধতি নিয়েছে </td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_m_left_pill_oth_method_normal" name="curr_m_left_pill_oth_method_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_m_left_pill_oth_method_after_delivery" name="curr_m_left_pill_oth_method_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_m_left_condom_oth_method_normal" name="curr_m_left_condom_oth_method_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_m_left_condom_oth_method_after_delivery" name="curr_m_left_condom_oth_method_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_m_left_inj_oth_method_normal" name="curr_m_left_inj_oth_method_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_m_left_inj_oth_method_after_delivery" name="curr_m_left_inj_oth_method_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_m_left_iud_oth_method_normal" name="curr_m_left_iud_oth_method_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_m_left_iud_oth_method_after_delivery" name="curr_m_left_iud_oth_method_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_m_left_implant_oth_method_normal" name="curr_m_left_implant_oth_method_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_m_left_implant_oth_method_after_delivery" name="curr_m_left_implant_oth_method_after_delivery"/></td>
                                                    <td  id="" class="disabled-color">&nbsp;</td>
                                                    <td  id="" class="disabled-color">&nbsp;</td>
                                                    <td  id="" class="disabled-color">&nbsp;</td>
                                                    <td  id="" class="disabled-color">&nbsp;</td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_m_left_oth_method_normal_total" name="curr_m_left_oth_method_normal_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_m_left_oth_method_after_delivery_total" name="curr_m_left_oth_method_after_delivery_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="curr_m_left_oth_method_all_total" name="curr_m_left_oth_method_all_tot"/></td>
                                                </tr>
                                                <tr>
                                                    <td>প্রসব পরবর্তী মেয়াদ<br/>উত্তীর্ণ </td>
                                                    <td  >0</td>
                                                    <td  id="r_curr_m_left_ppfp_expired_pill_after_delivery" ></td>
                                                    <td>0</td>
                                                    <td  id="r_curr_m_left_ppfp_expired_condom_after_delivery" ></td>
                                                    <td >0</td>
                                                    <td  id="r_curr_m_left_ppfp_expired_inject_after_delivery" ></td>
                                                    <td >0</td>
                                                    <td  id="r_curr_m_left_ppfp_expired_iud_after_delivery" ></td>
                                                    <td >0</td>
                                                    <td  id="r_curr_m_left_ppfp_expired_implan_after_delivery" ></td>
                                                    <td >0</td>
                                                    <td  id="r_curr_m_left_ppfp_expired_perm_men_after_delivery" ></td>
                                                    <td >0</td>
                                                    <td  id="r_curr_m_left_ppfp_expired_perm_women_after_delivery"></td>
                                                    <td >0</td>
                                                    <td  id="r_curr_m_left_ppfp_expired_after_delivery_tot"></td>
                                                    <td  id="r_curr_m_left_ppfp_expired_all_tot" ></td>
                                                </tr>
                                                <tr class="fpm_method_referred">
                                                    <td colspan="2">পদ্ধতির জন্য প্রেরণ</td>
                                                    <td class="disabled-color">&nbsp;</td>
                                                    <td class="disabled-color">&nbsp;</td>
                                                    <td class="disabled-color">&nbsp;</td>
                                                    <td class="disabled-color">&nbsp;</td>
                                                    <td><input type="number" min="0" min="0" class="form-control" id="sent_method_inj_normal" name="sent_method_inj_normal"/></td>
                                                    <td><input type="number" min="0" min="0" class="form-control" id="sent_method_inj_after_delivery" name="sent_method_inj_after_delivery"/></td>
                                                    <td><input type="number" min="0" min="0" class="form-control" id="sent_method_iud_normal" name="sent_method_iud_normal"/></td>
                                                    <td><input type="number" min="0" min="0" class="form-control" id="sent_method_iud_after_delivery" name="sent_method_iud_after_delivery"/></td>
                                                    <td><input type="number" min="0" min="0" class="form-control" id="sent_method_implant_normal" name="sent_method_implant_normal"/></td>
                                                    <td><input type="number" min="0" min="0" class="form-control" id="sent_method_implant_after_delivery" name="sent_method_implant_after_delivery"/></td>
                                                    <td><input type="number" min="0" min="0" class="form-control" id="sent_method_per_man_normal" name="sent_method_per_man_normal"/></td>
                                                    <td><input type="number" min="0" min="0" class="form-control" id="sent_method_per_man_after_delivery" name="sent_method_per_man_after_delivery"/></td>
                                                    <td><input type="number" min="0" min="0" class="form-control" id="sent_method_per_woman_normal" name="sent_method_per_woman_normal"/></td>
                                                    <td><input type="number" min="0" min="0" class="form-control" id="sent_method_per_woman_after_delivery" name="sent_method_per_woman_after_delivery"/></td>
                                                    <td><input type="number" min="0" min="0" class="form-control" id="sent_method_normal_total" name="sent_method_normal_total"/></td>
                                                    <td><input type="number" min="0" min="0" class="form-control" id="sent_method_after_delivery_total" name="sent_method_after_delivery_total"/></td>
                                                    <td><input type="number" min="0" min="0" class="form-control" id="sent_method_all_total" name="sent_method_all_tot"/></td>
                                                </tr>
                                                <tr class="fpm_method_sideeffect">
                                                    <td colspan="2">পার্শ্ব প্রতিক্রিয়ার জন্য প্রেরণ /জটিলতার জন্য প্রেরণ</td>
                                                    <td><input type="number" min="0" class="form-control" id="sent_side_effect_pill_normal" name="sent_side_effect_pill_normal"/></td>
                                                    <td><input type="number"min="0" class="form-control" id="sent_side_effect_pill_after_delivery" name="sent_side_effect_pill_after_delivery"/></td>
                                                    <td  class="disabled-color">&nbsp;</td>
                                                    <td  class="disabled-color">&nbsp;</td>
                                                    <td><input type="number" min="0" class="form-control" id="sent_side_effect_inj_normal" name="sent_side_effect_inj_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="sent_side_effect_inj_after_delivery" name="sent_side_effect_inj_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="sent_side_effect_iud_normal" name="sent_side_effect_iud_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="sent_side_effect_iud_after_delivery" name="sent_side_effect_iud_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="sent_side_effect_implant_normal" name="sent_side_effect_implant_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="sent_side_effect_implant_after_delivery" name="sent_side_effect_implant_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="sent_side_effect_per_man_normal" name="sent_side_effect_per_man_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="sent_side_effect_per_man_after_delivery" name="sent_side_effect_per_man_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="sent_side_effect_per_woman_normal" name="sent_side_effect_per_woman_normal"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="sent_side_effect_per_woman_after_delivery" name="sent_side_effect_per_woman_after_delivery"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="sent_side_effect_normal_total" name="sent_side_effect_normal_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="sent_side_effect_after_delivery_total" name="sent_side_effect_after_delivery_total"/></td>
                                                    <td><input type="number" min="0" class="form-control" id="sent_side_effect_all_tot" name="sent_side_effect_all_tot"/></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="table-responsive mis1-margin-bottom">
                                            <table class="table-bordered table-car1" style="width: 100%">
                                                <colgroup>
                                                    <col style="width: 300px">
                                                    <col style="width: 55px">
                                                    <col style="width: 300px">
                                                    <col style="width: 55px">
                                                </colgroup>
                                                <tr>
                                                    <td>চলতি মাসে পরিদর্শিত সক্ষম দম্পতির সংখ্যা</td>
                                                    <td class="center"><input type="number" class="form-control" name="curr_m_shown_capable_elco_tot"/></td>
                                                    <td>ইউনিটের মোট সক্ষম দম্পতির সংখ্যা</td>
                                                    <td class="center"><input type="number" class="form-control" name="unit_capable_elco_tot"/></td>
                                                </tr>
                                                <tr>
                                                    <td>পূর্ববর্তী মাসে পরিদর্শিত সক্ষম দম্পতির সংখ্যা</td>
                                                    <td class="center"><input type="number" class="form-control" name="priv_m_shown_capable_elco_tot"/></td>
                                                    <td>চলতি মাসে নবদম্পতির সংখ্যা</td>
                                                    <td class="center"><input type="number" class="form-control" name="curr_m_v_new_elco_tot"/></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <!--Car Table-->
                                        <div class="table-responsive1 mis1-margin-bottom">
                                            <table class="table-car2" style="width: 100%;">
                                                <tr>
                                                    <td rowspan="2" style="width: 200px;text-align: center;padding: 3px;">পদ্ধতি গ্রহনকারীর হার (CAR):</td>
                                                    <td class="center" style="border-bottom: 1px solid black!important;">ইউনিটের সর্বমোট পদ্ধতি গ্রহণকারী</td>
                                                    <td rowspan="2" style="text-align: left;width: 90px;">&nbsp;&#10006; 100= </td>
                                                    <td style="width: 60px;text-align: center;padding: 4px;border-bottom: 1px solid black!important;" id="r_unit_all_total_tot">&nbsp;</td>
                                                    <td rowspan="2" style="text-align: left;width: 90px;">&nbsp;&#10006; 100= </td>
                                                    <td  rowspan="2" style="text-align: left;width: 100px;"><span id="r_car"></span>%</td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px;text-align: center;padding: 4px;">ইউনিটের সর্বমোট সক্ষম দম্পতি</th>
                                                    <td  id="r_unit_capable_elco_tot" style="width: 80;text-align: center;padding: 4px;">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <p> <strong>খ) প্রজনন স্বাস্থ্য সেবাঃ </strong> </p>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="table-responsive">
                                                    <table class="table-bordered mis_table table-kha1" style="width: 100%">
                                                        <colgroup>
                                                            <col style="width: 30px">
                                                            <col style="width: 30px">
                                                            <col style="width: 160px">
                                                            <col style="width: 40px">
                                                            <col style="width: 40px">
                                                        </colgroup>
                                                        <tr class="center">
                                                            <td colspan="3" class="left">সেবার ধরণ</td>
                                                            <td >তথ্য</td>
                                                            <td >সেবা<br></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" rowspan="3">চলতি মাসে গর্ভবতীর সংখ্যা<br></td>
                                                            <td class="left">পুরাতন</td>
                                                            <td><input type="number" class="form-control" name="curr_month_preg_old_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td class="left">নতুন</td>
                                                            <td><input type="number" class="form-control" name="curr_month_preg_new_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td class="left">মোট</td>
                                                            <td><input type="number" class="form-control" name="curr_month_preg_tot_fwa"/></td>
                                                            <td class="ka_table_inactive_field disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="3" class="left">পূর্ববতী মাসে মোট গর্ভবতীর সংখ্যা<br></td>
                                                            <td><input type="number" class="form-control" name="priv_month_tot_preg_fwa"/></td>
                                                            <td class="ka_table_inactive_field disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="3" class="left">গর্ভপাত/মিসক্যারেজ এর  সংখ্যা</td>
                                                            <td><input type="number" class="form-control" name="abortion_or_miscarriage"/></td>
                                                            <td class="ka_table_inactive_field disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="3" class="left">ইউনিটের সর্বমোট গর্ভবতীর সংখ্যা<br></td>
                                                            <td><input type="number" class="form-control" name="unit_tot_preg_fwa"/></td>
                                                            <td class="ka_table_inactive_field disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td rowspan="7"><span class="r-v">গর্ভকালীন  সেবা</span></td>
                                                            <td colspan="2" class="left">পরিদর্শন-১</td>
                                                            <td><input type="number" class="form-control" name="preg_anc_service_visit1_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="preg_anc_service_visit1_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">পরিদর্শন-২</td>
                                                            <td><input type="number" class="form-control" name="preg_anc_service_visit2_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="preg_anc_service_visit2_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">পরিদর্শন-৩</td>
                                                            <td><input type="number" class="form-control" name="preg_anc_service_visit3_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="preg_anc_service_visit3_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">পরিদর্শন-৪</td>
                                                            <td><input type="number" class="form-control" name="preg_anc_service_visit4_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="preg_anc_service_visit4_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">প্রসব পরবর্তী পরিবার পরিকল্পনা পদ্ধতি বিষয়ে কাউন্সেলিং</td>
                                                            <td><input type="number" class="form-control" name="preg_anc_counselling_after_delivery_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="preg_anc_counselling_after_delivery_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">মিসোপ্রোস্টল বড়ি সরবরাহ প্রাপ্ত গর্ভবতী</td>
                                                            <td><input type="number" class="form-control" name="preg_anc_misoprostol_supplied_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="preg_anc_misoprostol_supplied_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">৭.১% ক্লোরোহেক্সিডিন সরবরাহ প্রাপ্ত গর্ভবতী</td>
                                                            <td><input type="number" class="form-control" name="preg_anc_chlorohexidin_supplied_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="preg_anc_chlorohexidin_supplied_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td rowspan="7"><span class="r-v">প্রসব  সেবা</span></td>
                                                            <td rowspan="2" class="left">বাড়ী</td>
                                                            <td class="left"> প্রশিক্ষণ প্রাপ্ত ব্যাক্তি দ্বারা</td>
                                                            <td><input type="number" class="form-control" name="delivary_service_home_trained_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td class="left"> প্রশিক্ষণ বিহীন ব্যক্তি দ্বারা</td>
                                                            <td><input type="number" class="form-control" name="delivary_service_home_untrained_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td rowspan="2" class="left">হাসপাতাল/ক্লিনিক</td>
                                                            <td class="left">স্বাভাবিক</td>
                                                            <td><input type="number" class="form-control" name="delivary_service_hospital_normal_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td class="left">সিজারিয়ান</td>
                                                            <td><input type="number" class="form-control" name="delivary_service_hospital_operation_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">বাড়ীতে প্রসব করানো হয়েছে</td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                            <td><input type="number" class="form-control" name="delivary_service_delivery_done_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">প্রসবের তৃতীয় ধাপের সক্রিয় ব্যবস্থাপনা (AMTSL) অনুসরণ করে প্রসব করানো হয়েছে</td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                            <td><input type="number" class="form-control" name="delivary_service_3rd_amtsl_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">মিসোপ্রোস্টল বড়ি খাওয়ানো হয়েছে</td>
                                                            <td><input type="number" class="form-control" name="delivary_service_misoprostol_taken"/></td>
                                                            <td><input type="number" class="form-control" name="delivary_service_misoprostol_taken_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td rowspan="6"><span class="r-v">প্রসবোত্তর সেবা</span></td>
                                                            <td rowspan="6"><span class="r-v" style="width: 10px!important;">মা</span></td>
                                                            <td class="left">পরিদর্শন-১</td>
                                                            <td><input type="number" class="form-control" name="pnc_mother_visit1_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="pnc_mother_visit1_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td class="left">পরিদর্শন-২</td>
                                                            <td><input type="number" class="form-control" name="pnc_mother_visit2_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="pnc_mother_visit2_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td class="left">পরিদর্শন-৩</td>
                                                            <td><input type="number" class="form-control" name="pnc_mother_visit3_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="pnc_mother_visit3_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td class="left">পরিদর্শন-৪</td>
                                                            <td><input type="number" class="form-control" name="pnc_mother_visit4_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="pnc_mother_visit4_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td class="left">বাড়ীতে ডেলিভারীর ক্ষেত্রে প্রশিক্ষণ প্রাপ্ত ব্যক্তি দ্বারা ২ দিনের মধ্যে প্রসবোত্তর সেবা গ্রহণকারী</td>
                                                            <td><input type="number" class="form-control" name="pnc_mother_home_delivery_training_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="pnc_mother_home_delivery_training_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td class="left">প্রসব পরবর্তী পরিবার পরিকল্পনা পদ্ধতি বিষয়ে কাউন্সেলিং</td>
                                                            <td><input type="number" class="form-control" name="pnc_mother_family_planning_counselling_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="pnc_mother_family_planning_counselling_csba"/></td>
                                                        </tr>
                                                    </table>
                                                    <p>*প্রসব পরবর্তী > প্রসবের পর হতে ১ বছরের মধ্যে।</p>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="table-responsive">
                                                    <table class="table-bordered mis_table table-kha2" style="width: 100%">
                                                        <colgroup>
                                                            <col style="width: 30px">
                                                            <col style="width: 30px">
                                                            <col style="width: 180px">
                                                            <col style="width: 35px">
                                                            <col style="width: 35px">
                                                        </colgroup>
                                                        <tr class="center">
                                                            <td colspan="3" class="left">সেবার ধরণ<br></td>
                                                            <td >তথ্য</td>
                                                            <td >সেবা<br></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td rowspan="9"><span class="r-v">প্রসবোত্তর সেবা</span></td>
                                                            <td rowspan="9"><span class="r-v">নবজাতক</span></td>
                                                            <td class="left">১ মিনিটের মধ্যে মোছানোর সংখ্যা</td>
                                                            <td><input type="number" class="form-control" name="newborn_1min_washed_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="newborn_1min_washed_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td class="left">নাড়ি কাটার পর ৭.১% ক্লোরোহেক্সিডিন ব্যবহারের সংখ্যা</td>
                                                            <td><input type="number" class="form-control" name="newborn_71_chlorohexidin_used_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="newborn_71_chlorohexidin_used_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td class="left">নাড়ি কাটার পর মায়ের ত্বকে-ত্বক স্পর্শ প্রাপ্ত নবজাতকের সংখ্যা</td>
                                                            <td><input type="number" class="form-control" name="newborn_with_mother_skin_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="newborn_with_mother_skin_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td class="left">জন্মের ১ ঘন্টার মধ্যে বুকের দুধ খাওয়ানোর সংখ্যা</td>
                                                            <td><input type="number" class="form-control" name="newborn_1hr_bfeeded_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="newborn_1hr_bfeeded_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td class="left">জন্মকালীন শ্বাসকষ্টে আক্রান্ত  শিশুকে ব্যাগ ও মাস্ক ব্যবহার করে রিসাসিটেইট করার সংখ্যা  </td>
                                                            <td><input type="number" class="form-control" name="newborn_diff_breathing_resassite_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="newborn_diff_breathing_resassite_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td class="left">পরিদর্শন-১</td>
                                                            <td><input type="number" class="form-control" name="pnc_newborn_visit1_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="pnc_newborn_visit1_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td class="left">পরিদর্শন-২</td>
                                                            <td><input type="number" class="form-control" name="pnc_newborn_visit2_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="pnc_newborn_visit2_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td class="left">পরিদর্শন-৩</td>
                                                            <td><input type="number" class="form-control" name="pnc_newborn_visit3_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="pnc_newborn_visit3_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td class="left">পরিদর্শন-৪</td>
                                                            <td><input type="number" class="form-control" name="pnc_newborn_visit4_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="pnc_newborn_visit4_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td rowspan="3" class=""><span class="r-v">সরেফারকৃত</span></td>
                                                            <td colspan="2" class="left">ঝুঁকিপূর্ণ/জটিল গর্ভবতীর সংখ্যা</td>
                                                            <td><input type="number" class="form-control" name="ref_risky_preg_cnt_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="ref_risky_preg_cnt_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">একলাম্পসিয়া রোগীকে লোডিং ডোজ MgSO4 ইনজেকশন দিয়ে রেফার সংখ্যা<br></td>
                                                            <td><input type="number" class="form-control" name="ref_eclampsia_mgso4_inj_refer_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="ref_eclampsia_mgso4_inj_refer_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">নবজাতককে জটিলতার জন্য রেফার সংখ্যা</td>
                                                            <td><input type="number" class="form-control" name="ref_newborn_difficulty_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="ref_newborn_difficulty_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td rowspan="9"><span class="r-v">কিশোর কিশোরীর সেবা (১০-১৯ বছর) কাউন্সেলিং</span></td>
                                                            <td colspan="2" class="left">বয়ঃসন্ধিকালীন পরিবর্তন</td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_adolescent_change_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_adolescent_change_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">বাল্যবিবাহ ও কিশোরী মাতৃত্বের কুফল</td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_child_marriage_preg_effect_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_child_marriage_preg_effect_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">কিশোরীকে আয়রন ও ফলিক এসিড বড়ি</td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_iron_folic_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_iron_folic_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">প্রজননতন্ত্রের সংক্রমন ও যৌনবাহিত রোগ</td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_sexual_disease_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_sexual_disease_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">বিভিন্ন ধরণের পুষ্টিকর ও সুষম খাবার</td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_healthy_balanced_diet_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_healthy_balanced_diet_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">কৈশোর সহিংসতা প্রতিরোধ</td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_adolescence_violence_prevention_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_adolescence_violence_prevention_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">মানসিক সমস্যা এবং মাদকাসক্তি প্রতিরোধ ও নিরাময়</td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_mental_prob_drug_addict_prevention_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_mental_prob_drug_addict_prevention_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">কিশোর-কিশোরীর পরিষ্কার-পরিচ্ছন্নতা ও কিশোরীর স্যানিটারি প্যাড ব্যবহার </td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_cleanliness_sanitary_pad_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_cleanliness_sanitary_pad_csba"/></td>
                                                        </tr>
                                                        <tr class="center">
                                                            <td colspan="2" class="left">রেফার</td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_referred_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="teen_counseling_referred_csba"/></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>            
                                    </div>
                                </div>
















                                <!--Page: 2-->
                                <div class="col-ld-12 mis1">
                                    <div class="col-md-12 mis-form-1"><br/>
                                        <p class="bold right">এম আই এস ফরম - ১<br>পৃষ্ঠা-২</p>
                                        <div class="table-responsive">
                                            <table class="table-bordered center table-kha3" style="width: 100%">
                                                <colgroup>
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 40px">
                                                    <col style="width: 90px">
                                                    <col style="width: 70px">
                                                    <col style="width: 70px">
                                                </colgroup>
                                                <tr>
                                                    <td colspan="8" class="bold left">খ) প্রজনন স্বাস্থ্য সেবাঃ</td>
                                                </tr>
                                                <tr>
                                                    <td colspan="5">টি টি প্রাপ্ত মহিলার সংখ্যা (তথ্য)</td>
                                                    <td rowspan="2">ইসিপি গ্রহণকারীার সংখ্যা (তথ্য)</td>
                                                    <td colspan="2">বন্ধ্যা দম্পতির তথ্য</td>
                                                </tr>
                                                <tr>
                                                    <td>১ম</td>
                                                    <td>২য়</td>
                                                    <td>৩য়</td>
                                                    <td>৪র্থ</td>
                                                    <td>৫ম</td>
                                                    <td>পরামর্শ প্রাপ্ত</td>
                                                    <td>রেফারকৃত</td>
                                                </tr>
                                                <tr>
                                                    <td><input type="number" class="form-control" name="tt_women_1st_fwa"/></td>
                                                    <td><input type="number" class="form-control" name="tt_women_2nd_fwa"/></td>
                                                    <td><input type="number" class="form-control" name="tt_women_3rd_fwa"/></td>
                                                    <td><input type="number" class="form-control" name="tt_women_4th_fwa"/></td>
                                                    <td><input type="number" class="form-control" name="tt_women_5th_fwa"/></td>
                                                    <td><input type="number" class="form-control" name="ecp_taken"/></td>
                                                    <td><input type="number" class="form-control" name="infertile_consultstatus"/></td>
                                                    <td><input type="number" class="form-control" name="infertile_referstatus"/></td>
                                                </tr>
                                            </table>
                                        </div>






                                        <div class="row">
                                            <div class="col-md-6">
                                                <p><strong>গ) শিশু (০-৫ বছর) সেবাঃ </strong></p>
                                                <div class="table-responsive">
                                                    <table class="table-bordered mis_table table-ga" style="width: 100%;">
                                                        <colgroup>
                                                            <!--                                                            <col style="width: 40px">
                                                                                                                        <col style="width: 40px">
                                                                                                                        <col style="width: 130px">
                                                                                                                        <col style="width: 45px">
                                                                                                                        <col style="width: 45px">-->


                                                            <col style="width: 30px">
                                                            <col style="width: 30px">
                                                            <col style="width: 140px">
                                                            <col style="width: 45px">
                                                            <col style="width: 45px">
                                                        </colgroup>
                                                        <tr>
                                                            <td colspan="3" class="left">সেবার ধরণ</td>
                                                            <td>তথ্য</td>
                                                            <td>সেবা<br></td>
                                                        </tr>
                                                        <tr >
                                                            <td rowspan="14"><span class="r-v">টিকা প্রাপ্ত (০- ১৫ মাস বয়সী) শিশুর সংখ্যা</span></td>
                                                            <td colspan="2" class="left">বিসিজি</td>
                                                            <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_bcg_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td rowspan="3">পেন্টাভ্যালেন্ট (ডিপিটি, হেপ-বি, হিব)</td>
                                                            <td class="left">১</td>
                                                            <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_pentavalent_1_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">২</td>
                                                            <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_pentavalent_2_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">৩</td>
                                                            <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_pentavalent_3_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td rowspan="3" class="left">পিসিভি টিকা</td>
                                                            <td class="left">১</td>
                                                            <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_pcv1_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">২</td>
                                                            <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_pcv2_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">৩</td>
                                                            <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_pcv3_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td rowspan="3" class="left">বিওপিভি</td>
                                                            <td class="left">১</td>
                                                            <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_bopv_1_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">২</td>
                                                            <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_bopv_2_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">৩</td>
                                                            <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_bopv_3_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td rowspan="2" class="left">আইপিভি(ফ্রাকশনাল)</td>
                                                            <td class="left">১</td>
                                                            <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_ipv_1_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">২</td>
                                                            <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_ipv_2_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td rowspan="2" class="left">এমআর টিকা</td>
                                                            <td class="left">১</td>
                                                            <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_mr_1_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">২</td>
                                                            <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_mr_2_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td rowspan="3" colspan="2">রেফারকৃত শিশুর সংখ্যা</td>
                                                            <td class="left">খুব মারাত্মক রোগ</td>
                                                            <td><input type="number" class="form-control" name="referred_child_dangerous_disease_fwa"/></td>
                                                            <td><input type="number" class="form-control" name=""/></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">নিউমোনিয়া</td>
                                                            <td><input type="number" class="form-control" name="referred_child_neumonia_fwa"/></td>
                                                            <td><input type="number" class="form-control" name=""/></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">ডায়রিয়া</td>
                                                            <td><input type="number" class="form-control" name="referred_child_diahoea_fwa"/></td>
                                                            <td><input type="number" class="form-control" name=""/></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <p><strong>ঘ) জন্ম-মৃত্যুঃ</strong></p>
                                                <div class="table-responsive">
                                                    <table class="table-bordered mis_table table-gha" style="width: 100%">
                                                        <colgroup>
                                                            <!--                                                            <col style="width: 40px">
                                                                                                                        <col style="width: 40px">
                                                                                                                        <col style="width: 140px">
                                                                                                                        <col style="width: 40px">
                                                                                                                        <col style="width: 40px">-->
                                                            <col style="width: 30px">
                                                            <col style="width: 30px">
                                                            <col style="width: 180px">
                                                            <col style="width: 38px">
                                                            <col style="width: 38px">
                                                        </colgroup>
                                                        <tr>
                                                            <td colspan="3" class="left">সেবার ধরণ</td>
                                                            <td >তথ্য</td>
                                                            <td >সেবা<br></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" class="left">মোট জীবিত জন্মের সংখ্যা</td>
                                                            <td><input type="number" class="form-control" name="tot_live_birth_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="tot_live_birth_csba"/></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" class="left">কম জন্ম ওজনে (জন্ম ওজন ২৫০০ গ্রামের কম) জন্মগ্রহণকারী নবজাতক এর সংখ্যা</td>
                                                            <td><input type="number" class="form-control" name="less_weight_birth_less_then_2500g_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" class="left">কম জন্ম ওজনে (জন্ম ওজন ২০০০ গ্রামের কম) জন্মগ্রহণকারী নবজাতক এর সংখ্যা</td>
                                                            <td><input type="number" class="form-control" name="less_weight_birth_less_then_2000g_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" class="left">অপরিণত (৩৭ সপ্তাহের পূর্বে জন্ম) নবজাতক এর সংখ্যা</td>
                                                            <td><input type="number" class="form-control" name="immature_birth_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="immature_birth_csba"/></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" class="left">মৃত জন্ম (Still Birth)</td>
                                                            <td><input type="number" class="form-control" name="still_birth_fwa"/></td>
                                                            <td><input type="number" class="form-control" name="still_birth_csba"/></td>
                                                        </tr>
                                                        <tr >
                                                            <td rowspan="8"><span class="r-v">মৃতের সংখ্যা</span></td>
                                                            <td class="left"  rowspan="4"><span class="r-v">এক বছরের কম মৃত <br/>শিশুর সংখ্যা</span></td>
                                                            <td class="left">০-৭ দিন</td>
                                                            <td><input type="number" class="form-control" name="death_number_less_1yr_0to7days_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">৮-২৮ দিন</td>
                                                            <td><input type="number" class="form-control" name="death_number_less_1yr_8to28days_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">২৯ দিন-<১ বছর</td>
                                                            <td><input type="number" class="form-control" name="death_number_less_1yr_29dystoless1yr_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">মোট</td>
                                                            <td><input type="number" class="form-control" name="death_number_less_1yr_tot_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left" colspan="2">১-<৫ বছর মৃত শিশুর সংখ্যা</td>
                                                            <td><input type="number" class="form-control" name="death_number_1yrto5yr_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left" colspan="2">মাতৃ মৃত্যুর সংখ্যা</td>
                                                            <td><input type="number" class="form-control" name="death_number_maternal_death_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left" colspan="2">অন্যান্য মৃতের সংখ্যা</td>
                                                            <td><input type="number" class="form-control" name="death_number_other_death_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left" colspan="2">সর্বমোট মৃতের সংখ্যা</td>
                                                            <td><input type="number" class="form-control" name="death_number_all_death_fwa"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>













                                        <!--                                        <div class="table-responsive">
                                                                                    <table class="table-bordered center" style="width: 100%;">
                                                                                        <colgroup>
                                                                                            <col style="width: 50%">
                                                                                            <col style="width: 50%">
                                                                                        </colgroup>
                                                                                        <tr>
                                                                                            <td class="left bold">গ) শিশু (০-৫ বছর) সেবাঃ</td>
                                                                                            <td class="left bold">ঘ) জন্ম-মৃত্যুঃ</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <table class="table-bordered mis_table table-ga" style="width: 100%;">
                                                                                                    <colgroup>
                                                                                                        <col style="width: 40px">
                                                                                                        <col style="width: 40px">
                                                                                                        <col style="width: 140px">
                                                                                                        <col style="width: 40px">
                                                                                                        <col style="width: 40px">
                                                                                                    </colgroup>
                                                                                                    <tr>
                                                                                                        <td colspan="3" class="left">সেবার ধরণ</td>
                                                                                                        <td>তথ্য</td>
                                                                                                        <td>সেবা<br></td>
                                                                                                    </tr>
                                                                                                    <tr >
                                                                                                        <td rowspan="14"><span class="r-v">টিকা প্রাপ্ত (০- ১৫ মাস বয়সী) শিশুর সংখ্যা</span></td>
                                                                                                        <td colspan="2" class="left">বিসিজি</td>
                                                                                                        <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_bcg_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td rowspan="3">পেন্টাভ্যালেন্ট<br/>(ডিপিটি, হেপ-বি,<br/> হিব)</td>
                                                                                                        <td class="left">১</td>
                                                                                                        <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_pentavalent_1_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="left">২</td>
                                                                                                        <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_pentavalent_2_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="left">৩</td>
                                                                                                        <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_pentavalent_3_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td rowspan="3" class="left">পিসিভি টিকা</td>
                                                                                                        <td class="left">১</td>
                                                                                                        <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_pcv1_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="left">২</td>
                                                                                                        <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_pcv2_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="left">৩</td>
                                                                                                        <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_pcv3_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td rowspan="3" class="left">বিওপিভি</td>
                                                                                                        <td class="left">১</td>
                                                                                                        <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_bopv_1_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="left">২</td>
                                                                                                        <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_bopv_2_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="left">৩</td>
                                                                                                        <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_bopv_3_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td rowspan="2" class="left">আইপিভি(ফ্রাকশনাল)</td>
                                                                                                        <td class="left">১</td>
                                                                                                        <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_ipv_1_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="left">২</td>
                                                                                                        <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_ipv_2_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td rowspan="2" class="left">এমআর টিকা</td>
                                                                                                        <td class="left">১</td>
                                                                                                        <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_mr_1_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="left">২</td>
                                                                                                        <td><input type="number" class="form-control" name="vaccinated_child_0to15mnths_mr_2_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td rowspan="3" colspan="2">রেফারকৃত শিশুর সংখ্যা</td>
                                                                                                        <td class="left">খুব মারাত্মক রোগ</td>
                                                                                                        <td><input type="number" class="form-control" name="referred_child_dangerous_disease_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="left">নিউমোনিয়া</td>
                                                                                                        <td><input type="number" class="form-control" name="referred_child_neumonia_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="left">ডায়রিয়া</td>
                                                                                                        <td><input type="number" class="form-control" name="referred_child_diahoea_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                            <td>
                                                                                                <table class="table-bordered mis_table table-gha" style="width: 100%">
                                                                                                    <colgroup>
                                                                                                        <col style="width: 40px">
                                                                                                        <col style="width: 40px">
                                                                                                        <col style="width: 140px">
                                                                                                        <col style="width: 40px">
                                                                                                        <col style="width: 40px">
                                                                                                    </colgroup>
                                                                                                    <tr>
                                                                                                        <td colspan="3" class="left">সেবার ধরণ</td>
                                                                                                        <td >তথ্য</td>
                                                                                                        <td >সেবা<br></td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td colspan="3" class="left">মোট জীবিত জন্মের সংখ্যা</td>
                                                                                                        <td><input type="number" class="form-control" name="tot_live_birth_fwa"/></td>
                                                                                                        <td><input type="number" class="form-control" name="tot_live_birth_csba"/></td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td colspan="3" class="left">কম জন্ম ওজনে (জন্ম ওজন ২৫০০ গ্রামের কম) <br/>জন্মগ্রহণকারী নবজাতক এর সংখ্যা</td>
                                                                                                        <td><input type="number" class="form-control" name="less_weight_birth_less_then_2500g_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td colspan="3" class="left">কম জন্ম ওজনে (জন্ম ওজন ২০০০ গ্রামের কম) <br/>জন্মগ্রহণকারী নবজাতক এর সংখ্যা</td>
                                                                                                        <td><input type="number" class="form-control" name="less_weight_birth_less_then_2000g_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td colspan="3" class="left">অপরিণত (৩৭ সপ্তাহের পূর্বে জন্ম) নবজাতক<br/>এর সংখ্যা</td>
                                                                                                        <td><input type="number" class="form-control" name="immature_birth_fwa"/></td>
                                                                                                        <td><input type="number" class="form-control" name="immature_birth_csba"/></td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td colspan="3" class="left">মৃত জন্ম (Still Birth)</td>
                                                                                                        <td><input type="number" class="form-control" name="still_birth_fwa"/></td>
                                                                                                        <td><input type="number" class="form-control" name="still_birth_csba"/></td>
                                                                                                    </tr>
                                                                                                    <tr >
                                                                                                        <td rowspan="8"><span class="r-v">মৃতের সংখ্যা</span></td>
                                                                                                        <td class="left"  rowspan="4"><span class="r-v">এক বছরের কম <br/>মৃত শিশুর সংখ্যা</span></td>
                                                                                                        <td class="left">০-৭ দিন</td>
                                                                                                        <td><input type="number" class="form-control" name="death_number_less_1yr_0to7days_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="left">৮-২৮ দিন</td>
                                                                                                        <td><input type="number" class="form-control" name="death_number_less_1yr_8to28days_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="left">২৯ দিন-<১ বছর</td>
                                                                                                        <td><input type="number" class="form-control" name="death_number_less_1yr_29dystoless1yr_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="left">মোট</td>
                                                                                                        <td><input type="number" class="form-control" name="death_number_less_1yr_tot_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="left" colspan="2">১-<৫ বছর মৃত শিশুর সংখ্যা</td>
                                                                                                        <td><input type="number" class="form-control" name="death_number_1yrto5yr_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="left" colspan="2">মাতৃ মৃত্যুর সংখ্যা</td>
                                                                                                        <td><input type="number" class="form-control" name="death_number_maternal_death_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="left" colspan="2">অন্যান্য মৃতের সংখ্যা</td>
                                                                                                        <td><input type="number" class="form-control" name="death_number_other_death_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="left" colspan="2">সর্বমোট মৃতের সংখ্যা</td>
                                                                                                        <td><input type="number" class="form-control" name="death_number_all_death_fwa"/></td>
                                                                                                        <td class="disabled-color">&nbsp;</td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>-->

                                        <p class="left"><strong>ঙ) পুষ্টি সেবাঃ</strong></p>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="table-responsive">
                                                    <table class="table-bordered center table-uma1" style="width: 100%">
                                                        <colgroup>
                                                            <col style="width: 260px">
                                                            <col style="width: 10px">
                                                            <col style="width: 45px">
                                                        </colgroup>
                                                        <tr><td colspan="3" class="left">গর্ভবতী ও ০-২৩ মাস বয়সী শিশুর মা</td></tr>
                                                        <tr>
                                                            <td class="left">সেবার ধরণ</td>
                                                            <td >গর্ভবতী মা</td>
                                                            <td > শিশুর মা ০-২৩ মাস</td>
                                                        </tr>
                                                        <tr> 
                                                            <td class="left">আয়রন ফলিক এসিড বড়ি এবং বাড়তি খাবারের উপর কাউন্সেলিং</td>
                                                            <td><input type="number" class="form-control" name="iron_folicacid_extrafood_counsiling_preg_woman"/></td>
                                                            <td><input type="number" class="form-control" name="iron_folicacid_extrafood_counsiling_child_0to23months"/></td>
                                                        </tr>
                                                        <tr> 
                                                            <td class="left">আয়রন ফলিক এসিড বড়ি বিতরণ করা হয়েছে</td>
                                                            <td><input type="number" class="form-control" name="iron_folicacid_distribute_preg_woman"/></td>
                                                            <td><input type="number" class="form-control" name="iron_folicacid_distribute_child_0to23months"/></td>
                                                        </tr>
                                                        <tr> 
                                                            <td class="left">মায়ের দুধ ও পরিপূরক খাবারের উপর কাউন্সেলিং</td>
                                                            <td><input type="number" class="form-control" name="bfeeding_complementary_food_counsiling_preg_woman"/></td>
                                                            <td><input type="number" class="form-control" name="bfeeding_complementary_food_counsiling_child_0to23months"/></td>
                                                        </tr>
                                                        <tr> 
                                                            <td class="left">শিশুকে মাল্টিপল মাইক্রোনিউট্রিয়েন্ট পাউডার (এমএনপি) খাওয়ানো বিষয়ে কাউন্সেলিং</td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                            <td><input type="number" class="form-control" name="mnp_ounsiling_child_0to23months"/></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="table-responsive">
                                                    <table class="table-bordered mis_table table-uma2" style="width: 100%">
                                                        <colgroup>
                                                            <col style="width: 260px">
                                                            <col style="width: 50px">
                                                            <col style="width: 50px">
                                                            <col style="width: 25px">
                                                        </colgroup>
                                                        <tr><td colspan="4" class="left">০-৫৯ মাস বয়সী শিশু</td></tr>
                                                        <tr >
                                                            <td class="left">সেবার ধরণ<br></td>
                                                            <td>০-৫ মাস</td>
                                                            <td>৬-২৩ মাস</td>
                                                            <td>২৪-৫৯ <br/>মাস</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">৬ মাস পর্যন্ত শুধু মাত্র বুকের দুধ খাওয়ানো হয়েছে/হচ্ছে</td>
                                                            <td><input type="number" class="form-control" name="birth_only_bfeed_0to6mon"/></td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">জন্মের ৬ মাস পর হতে পরিপূরক খাবার খাওয়ানো হয়েছে/হচ্ছে</td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                            <td><input type="number" class="form-control" name="v0_59_child_complementary_food_6to23mon"/></td>
                                                            <td><input type="number" class="form-control" name="v0_59_child_complementary_food_24to59mon"/></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">মাল্টিপল মাইক্রোনিউট্রিয়েন্ট পাউডার (এমএনপি) পেয়েছে</td>
                                                            <td class="disabled-color">&nbsp;</td>
                                                            <td><input type="number" class="form-control" name="mnp_given_6to23mon"/></td>
                                                            <td><input type="number" class="form-control" name="mnp_given_24toless60mon"/></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">MAM আক্রান্ত শিশুর সংখ্যা</td>
                                                            <td><input type="number" class="form-control" name="mam_child_0to6mon"/></td>
                                                            <td><input type="number" class="form-control" name="mam_child_6to23mon"/></td>
                                                            <td><input type="number" class="form-control" name="mam_child_24to60mon"/></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="left">SAM আক্রান্ত রেফারকৃত শিশুর সংখ্যা</td>
                                                            <td><input type="number" class="form-control" name="sam_child_0to6mon"/></td>
                                                            <td><input type="number" class="form-control" name="sam_child_6to23mon"/></td>
                                                            <td><input type="number" class="form-control" name="sam_child_24toless60mon"/></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="table-responsive">
                                                    <table class="table-uma3" style="width: 100%;padding: 10px!important;">
                                                        <colgroup>
                                                            <col style="width: 301px">
                                                            <col style="width: 101px">
                                                            <col style="width: 301px">
                                                            <col style="width: 101px">
                                                        </colgroup>
                                                        <tr>
                                                            <td>স্যাটেলাইট ক্লিনিকে উপস্থিতির সংখ্যা</td>
                                                            <td class="center" style="border: 1px solid #000;"><input type="number" class="form-control" name="satelite_clinic_presence"/></td>
                                                            <td> &nbsp;&nbsp;ইপিআই সেশনে উপস্থিতির সংখ্যা</td>
                                                            <td class="center" style="border: 1px solid #000;"><input type="number" class="form-control" name="epi_session_presence"/></td>
                                                        </tr>
                                                        <tr>
                                                            <td>কমিউনিটি ক্লিনিকে উপস্থিতির সংখ্যা</td>
                                                            <td class="center" style="border: 1px solid #000;"><input type="number" class="form-control" name="community_clinic_presence"/></td>
                                                            <td> &nbsp;&nbsp;অনুষ্ঠিত উঠান বৈঠকে উপস্থিতির সংখ্যা</td>
                                                            <td class="center" style="border: 1px solid #000;"><input type="number" class="form-control" name="yard_meeting_presence"/></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-12">
                                                <br><h5 style="font-weight:bold;text-align: center">মাসিক মওজুদ ও বিতরণের হিসাব বিষয়কঃ</h5>
                                            </div>
                                            <div class="col-md-12" id="lmis-data">
                                                <div class="table-responsive e2b">
                                                    <table class="table-bordered mis_table" style="table-layout: fixed; width: 100%;">
                                                        <colgroup>
                                                            <col style="width: 93px">
                                                            <col style="width: 120px">
                                                            <col style="width: 91px">
                                                            <col style="width: 91px">
                                                            <col style="width: 91px">
                                                            <col style="width: 91px">
                                                            <col style="width: 91px">
                                                            <col style="width: 91px">
                                                            <col style="width: 91px">
                                                            <col style="width: 100px">
                                                            <col style="width: 91px">
                                                            <col style="width: 93px">
                                                        </colgroup>
                                                        <tr class="center">
                                                            <td class="tg-glis" style="text-align: left;">ইস্যু ভাউচার নং</td>
                                                            <td class="tg-031e"></td>
                                                            <td class="tg-s6z2" colspan="2">খাবার বড়ি <br/> (চক্র)</td>
                                                            <td class="tg-s6z2" rowspan="2" >কনডম<br>(নিরাপদ)<br>(পিস)<br></td>
                                                            <td class="tg-s6z2" colspan="2" >ইনজেকটেবল</td>
                                                            <td class="tg-s6z2" rowspan="2" >ইসিপি<br>(ডোজ)<br></td>
                                                            <td class="tg-s6z2" rowspan="2" >মিসো-<br>প্রোস্টল<br>(ডোজ)<br></td>
                                                            <td class="tg-s6z2" rowspan="2" >৭.১% ক্লোরোহেক্সিডিন  (বোতল)</td>
                                                            <td class="tg-s6z2" rowspan="2" >এমএনপি<br>(স্যাসেট)<br></td>
                                                            <td class="tg-s6z2" rowspan="2" >আয়রন<br>ফলিক<br>এসিড<br>(সংখ্যা)<br></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="tg-glis" style="text-align: left;">তারিখ</td>
                                                            <td class="tg-031e"></td>
                                                            <td class="tg-s6z2 center">সুখী<br></td>
                                                            <td class="tg-s6z2 center">আপন<br></td>
                                                            <td class="tg-s6z2 center" >ভায়াল</td>
                                                            <td class="tg-s6z2 center" >সিরিঞ্জ</td>
                                                        </tr>
                                                        <tr class="center row-input row-openingbalance" id="openingbalance">
                                                            <td class="tg-031e" colspan="2" style="text-align: left;">পূর্বের মওজুদ<br></td>
                                                            <td><input type="number" class="form-control" name="openingbalance_sukhi"/></td>
                                                            <td><input type="number" class="form-control" name="openingbalance_apon"/></td>
                                                            <td><input type="number" class="form-control" name="openingbalance_condom"/></td>
                                                            <td><input type="number" class="form-control" name="openingbalance_inject_vayal"/></td>
                                                            <td><input type="number" class="form-control" name="openingbalance_inject_syringe"/></td>
                                                            <td><input type="number" class="form-control" name="openingbalance_ecp"/></td>
                                                            <td><input type="number" class="form-control" name="openingbalance_misoprostol"/></td>
                                                            <td><input type="number" class="form-control" name="openingbalance_chlorhexidine"/></td>
                                                            <td><input type="number" class="form-control" name="openingbalance_mnp"/></td>
                                                            <td><input type="number" class="form-control" name="openingbalance_iron"/></td>
                                                        </tr>
                                                        <tr class="center row-input row-receiveqty" id="receiveqty">
                                                            <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসে পাওয়া গেছে (+)<br></td>
                                                            <td><input type="number" class="form-control" name="receiveqty_sukhi"/></td>
                                                            <td><input type="number" class="form-control" name="receiveqty_apon"/></td>
                                                            <td><input type="number" class="form-control" name="receiveqty_condom"/></td>
                                                            <td><input type="number" class="form-control" name="receiveqty_inject_vayal"/></td>
                                                            <td><input type="number" class="form-control" name="receiveqty_inject_syringe"/></td>
                                                            <td><input type="number" class="form-control" name="receiveqty_ecp"/></td>
                                                            <td><input type="number" class="form-control" name="receiveqty_misoprostol"/></td>
                                                            <td><input type="number" class="form-control" name="receiveqty_chlorhexidine"/></td>
                                                            <td><input type="number" class="form-control" name="receiveqty_mnp"/></td>
                                                            <td><input type="number" class="form-control" name="receiveqty_iron"/></td>
                                                        </tr>
                                                        <tr class="text-center row-sum row-current_month_stock" id="current_month_stock">
                                                            <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসের মোট মওজুদ<br></td>
                                                            <td><input type="number" class="form-control" name="current_month_stock_sukhi"/></td>
                                                            <td><input type="number" class="form-control" name="current_month_stock_apon"/></td>
                                                            <td><input type="number" class="form-control" name="current_month_stock_condom"/></td>
                                                            <td><input type="number" class="form-control" name="current_month_stock_inject_vayal"/></td>
                                                            <td><input type="number" class="form-control" name="current_month_stock_inject_syringe"/></td>
                                                            <td><input type="number" class="form-control" name="current_month_stock_ecp"/></td>
                                                            <td><input type="number" class="form-control" name="current_month_stock_misoprostol"/></td>
                                                            <td><input type="number" class="form-control" name="current_month_stock_chlorhexidine"/></td>
                                                            <td><input type="number" class="form-control" name="current_month_stock_mnp"/></td>
                                                            <td><input type="number" class="form-control" name="current_month_stock_iron"/></td>
                                                        </tr>
                                                        <tr class="text-center row-input row-adjustment_plus" id="adjustment_plus">
                                                            <td class="tg-031e" rowspan="2" style="text-align: left;">সমন্বয়</td>
                                                            <td class="tg-031e " style="text-align: left;">(+)</td>
                                                            <td><input type="number" class="form-control" name="adjustment_plus_sukhi"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_plus_apon"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_plus_condom"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_plus_inject_vayal"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_plus_inject_syringe"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_plus_ecp"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_plus_misoprostol"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_plus_chlorhexidine"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_plus_mnp"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_plus_iron"/></td>
                                                        </tr>
                                                        <tr class="text-center row-input row-minus row-adjustment_minus" id="adjustment_minus">
                                                            <td class="tg-031e" style="text-align: left;">(-)</td>
                                                            <td><input type="number" class="form-control" name="adjustment_minus_sukhi"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_minus_apon"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_minus_condom"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_minus_inject_vayal"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_minus_inject_syringe"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_minus_ecp"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_minus_misoprostol"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_minus_chlorhexidine"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_minus_mnp"/></td>
                                                            <td><input type="number" class="form-control" name="adjustment_minus_iron"/></td>
                                                        </tr>
                                                        <tr class="text-center row-sum row-total" id="total">
                                                            <td class="tg-031e" colspan="2" style="text-align: left;">সর্বমোট</td>
                                                            <td><input type="number" class="form-control" name="total_sukhi"/></td>
                                                            <td><input type="number" class="form-control" name="total_apon"/></td>
                                                            <td><input type="number" class="form-control" name="total_condom"/></td>
                                                            <td><input type="number" class="form-control" name="total_inject_vayal"/></td>
                                                            <td><input type="number" class="form-control" name="total_inject_syringe"/></td>
                                                            <td><input type="number" class="form-control" name="total_ecp"/></td>
                                                            <td><input type="number" class="form-control" name="total_misoprostol"/></td>
                                                            <td><input type="number" class="form-control" name="total_chlorhexidine"/></td>
                                                            <td><input type="number" class="form-control" name="total_mnp"/></td>
                                                            <td><input type="number" class="form-control" name="total_iron"/></td>
                                                        </tr>
                                                        <tr class="text-center row-input row-minus row-distribution" id="distribution">
                                                            <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসে বিতরণ করা হয়েছে(-)</td>
                                                            <td><input type="number" class="form-control" name="distribution_sukhi"/></td>
                                                            <td><input type="number" class="form-control" name="distribution_apon"/></td>
                                                            <td><input type="number" class="form-control" name="distribution_condom"/></td>
                                                            <td><input type="number" class="form-control" name="distribution_inject_vayal"/></td>
                                                            <td><input type="number" class="form-control" name="distribution_inject_syringe"/></td>
                                                            <td><input type="number" class="form-control" name="distribution_ecp"/></td>
                                                            <td><input type="number" class="form-control" name="distribution_misoprostol"/></td>
                                                            <td><input type="number" class="form-control" name="distribution_chlorhexidine"/></td>
                                                            <td><input type="number" class="form-control" name="distribution_mnp"/></td>
                                                            <td><input type="number" class="form-control" name="distribution_iron"/></td>
                                                        </tr>
                                                        <tr  class="text-center row-sum row-closingbalance" id="closingbalance">
                                                            <td class="tg-031e" colspan="2" style="text-align: left;">অবশিষ্ট<br></td>
                                                            <td><input type="number" class="form-control" name="closingbalance_sukhi"/></td>
                                                            <td><input type="number" class="form-control" name="closingbalance_apon"/></td>
                                                            <td><input type="number" class="form-control" name="closingbalance_condom"/></td>
                                                            <td><input type="number" class="form-control" name="closingbalance_inject_vayal"/></td>
                                                            <td><input type="number" class="form-control" name="closingbalance_inject_syringe"/></td>
                                                            <td><input type="number" class="form-control" name="closingbalance_ecp"/></td>
                                                            <td><input type="number" class="form-control" name="closingbalance_misoprostol"/></td>
                                                            <td><input type="number" class="form-control" name="closingbalance_chlorhexidine"/></td>
                                                            <td><input type="number" class="form-control" name="closingbalance_mnp"/></td>
                                                            <td><input type="number" class="form-control" name="closingbalance_iron"/></td>
                                                        </tr>
                                                        <tr style="text-align: center;">
                                                            <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসে কখনও মওজুদ শূন্যতা হয়ে থাকলে কারণ (কোড) লিখুন <br></td>
                                                            <td class="tg-031e ">
                                                                <select class="form-control input-sm" name="stockvacuum_sukhi">
                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                    <option value="4">অন্যান্য</option>
                                                                </select>
                                                            </td>
                                                            <td class="tg-031e ">
                                                                <select class="form-control input-sm" name="stockvacuum_apon">
                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                    <option value="4">অন্যান্য</option>
                                                                </select>
                                                            </td>
                                                            <td class="tg-031e ">
                                                                <select class="form-control input-sm" name="stockvacuum_condom">
                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                    <option value="4">অন্যান্য</option>
                                                                </select>
                                                            </td>
                                                            <td class="tg-031e ">
                                                                <select class="form-control input-sm" name="stockvacuum_inject_vayal">
                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                    <option value="4">অন্যান্য</option>
                                                                </select>
                                                            </td>
                                                            <td class="tg-031e ">
                                                                <select class="form-control input-sm" name="stockvacuum_inject_syringe">
                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                    <option value="4">অন্যান্য</option>
                                                                </select>
                                                            </td>
                                                            <td class="tg-031e ">
                                                                <select class="form-control input-sm" name="stockvacuum_ecp">
                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                    <option value="4">অন্যান্য</option>
                                                                </select>
                                                            </td>
                                                            <td class="tg-031e ">
                                                                <select class="form-control input-sm" name="stockvacuum_misoprostol">
                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                    <option value="4">অন্যান্য</option>
                                                                </select>
                                                            </td>
                                                            <td class="tg-031e ">
                                                                <select class="form-control input-sm" name="stockvacuum_chlorhexidine">
                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                    <option value="4">অন্যান্য</option>
                                                                </select>
                                                            </td>
                                                            <td class="tg-031e ">
                                                                <select class="form-control input-sm" name="stockvacuum_mnp">
                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                    <option value="4">অন্যান্য</option>
                                                                </select>
                                                            </td>
                                                            <td class="tg-031e ">
                                                                <select class="form-control input-sm" name="stockvacuum_iron">
                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                    <option value="4">অন্যান্য</option>
                                                                </select>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div> 



                                                <div class="row" style="font-size: 13px; margin-top:-10px;">
                                                    <div class="col-md-2">
                                                        <p>
                                                        <div class="row">
                                                            <div class="col-xs-12" style="margin-bottom: 0px;">
                                                                মওজুদ শূন্যতার কোডঃ
                                                            </div>
                                                        </div>
                                                        </p>
                                                    </div>
                                                    <div class="col-md-5">
                                                        <p style="margin-left: 0px">
                                                        <div class="row">
                                                            <div class="col-xs-6" style="margin-bottom: 0px;">
                                                                <span style="border: 1px solid black;padding-left: 5px;padding-right: 5px;">ক</span>&nbsp;সরবরাহ পাওয়া যায়নি &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            </div>
                                                            <div class="col-xs-6" style="margin-bottom: 0px;">
                                                                <span style="border: 1px solid black;padding-left: 5px;padding-right: 5px;margin-left: 15px;">খ</span>&nbsp;অপর্যাপ্ত সরবরাহ
                                                            </div>
                                                        </div>
                                                        </p>
                                                    </div>
                                                    <div class="col-md-5">
                                                        <p>
                                                        <div class="row">
                                                            <div class="col-xs-6">
                                                                <span style="border: 1px solid black;padding-left: 5px;padding-right: 5px;">গ</span>&nbsp;হঠাৎ চাহিদা বৃদ্ধি পাওয়া &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            </div>
                                                            <div class="col-xs-6" style="padding-left: 30px;">
                                                                <span style="border: 1px solid black;padding-left: 5px;padding-right: 5px;">ঘ</span>&nbsp;অন্যান্য
                                                            </div>
                                                        </div>
                                                        </p>
                                                    </div>
                                                </div>

                                                <!--                                                <div class="row" style="font-size: 13px;">
                                                                                                    <div class="col-md-6">
                                                                                                        পরিবার  কল্যাণ সহকারীর নামঃ<span id='providerName'>........................................</span>
                                                                                                    </div>
                                                                                                    <div class="col-md-3 col-xs-6">
                                                                                                        স্বাক্ষরঃ<span id=''>........................................</span>
                                                                                                    </div>
                                                                                                    <div class="col-md-3 col-xs-6">
                                                                                                        তারিখঃ<span id='submissionDate'>........................................</span>
                                                                                                    </div>
                                                                                                </div>-->
                                            </div>
                                            <br/> 
                                        </div>
                                    </div>
                                </div>



                                <!--                                <p><span class="bold">মাসিক মওজুদ ও বিতরণের হিসাব</span> - এর তথ্য নিচের ছকে লিখুন</p>-->
                                <!--                                <div class="insert-lmis-data">
                                                                    <table class="table-bordered insert-lmis-data-table" style="table-layout: fixed;padding-left: 5px!important">
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
                                                                            <col style="width: 100px">
                                                                            <col style="width: 91px">
                                                                            <col style="width: 91px">
                                                                        </colgroup>
                                                                        <tr>
                                                                            <td class="tg-glis" style="text-align: left;">ইস্যু ভাউচার নং<br></td>
                                                                            <td class="tg-031e"></td>
                                                                            <td class="tg-s6z2" colspan="2" style="text-align: center">খাবার বড়ি <br> (চক্র)<br></td>
                                                                            <td class="tg-s6z2" rowspan="2" style="text-align: center">কনডম<br>(নিরাপদ)<br>(পিস)<br></td>
                                                                            <td class="tg-s6z2" colspan="2" style="text-align: center">ইনজেকটেবল</td>
                                                                            <td class="tg-s6z2" rowspan="2" style="text-align: center">ইসিপি<br>(ডোজ)<br></td>
                                                                            <td class="tg-s6z2" rowspan="2" style="text-align: center">মিসো-<br>প্রোস্টল<br>(ডোজ)<br></td>
                                                                            <td class="tg-s6z2" rowspan="2" style="text-align: center">৭.১% ক্লোরোহেক্সিডিন  (বোতল)</td>
                                                                            <td class="tg-s6z2" rowspan="2" style="text-align: center">এমএনপি<br/>(স্যাসেট)</td>
                                                                            <td class="tg-s6z2" rowspan="2" style="text-align: center">আয়রন<br/>ফলিক<br/>এসিড<br/>(সংখ্যা)</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="tg-glis" style="text-align: left;">তারিখ</td>
                                                                            <td class="tg-031e"></td>
                                                                            <td class="tg-s6z2 center">সুখী<br></td>
                                                                            <td class="tg-s6z2 center">আপন<br></td>
                                                                            <td class="tg-s6z2" style="text-align: center">ভায়াল</td>
                                                                            <td class="tg-s6z2" style="text-align: center">সিরিঞ্জ</td>
                                                                        </tr>
                                                                        <tr class="text-center row-input row-openingbalance" id="openingbalance">
                                                                            <td class="tg-031e" colspan="2" style="text-align: left;">পূর্বের মওজুদ<br></td>
                                                                            <td class="tg-031e "><input type="number" class="form-control" name="openingbalance_sukhi"/></td>
                                                                            <td class="tg-031e "><input type="number" class="form-control"  name="openingbalance_apon"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="openingbalance_condom"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="openingbalance_inject_vayal"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="openingbalance_inject_syringe"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="openingbalance_ecp"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="openingbalance_misoprostol"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="openingbalance_chlorhexidine"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="openingbalance_mnp"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="openingbalance_iron"/></td>
                                                                        </tr>
                                                                        <tr class="text-center row-input row-receiveqty" id="receiveqty">
                                                                            <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসে পাওয়া গেছে (+)<br></td>
                                                                            <td class="tg-031e "><input type="number" class="form-control" name="receiveqty_sukhi"/></td>
                                                                            <td class="tg-031e "><input type="number" class="form-control"  name="receiveqty_apon"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="receiveqty_condom"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="receiveqty_inject_vayal"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="receiveqty_inject_syringe"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="receiveqty_ecp"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="receiveqty_misoprostol"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="receiveqty_chlorhexidine"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="receiveqty_mnp"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="receiveqty_iron"/></td>
                                                                        </tr>
                                                                        <tr class="text-center row-sum row-current_month_stock" id="current_month_stock">
                                                                            <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসের মোট মওজুদ<br></td>
                                                                            <td class="tg-031e "><input type="number" class="form-control" name="current_month_stock_sukhi"/></td>
                                                                            <td class="tg-031e "><input type="number" class="form-control"  name="current_month_stock_apon"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="current_month_stock_condom"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="current_month_stock_inject_vayal"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="current_month_stock_inject_syringe"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="current_month_stock_ecp"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="current_month_stock_misoprostol"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="current_month_stock_chlorhexidine"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="current_month_stock_mnp"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="current_month_stock_iron"/></td>
                                                                        </tr>
                                                                        <tr class="text-center row-input row-adjustment_plus" id="adjustment_plus">
                                                                            <td class="tg-031e" rowspan="2" style="text-align: left;">সমন্বয়</td>
                                                                            <td class="tg-031e " style="text-align: left;">(+)</td>
                                                                            <td class="tg-031e "><input type="number" class="form-control" name="adjustment_plus_sukhi"/></td>
                                                                            <td class="tg-031e "><input type="number" class="form-control"  name="adjustment_plus_apon"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="adjustment_plus_condom"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="adjustment_plus_inject_vayal"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="adjustment_plus_inject_syringe"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="adjustment_plus_ecp"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="adjustment_plus_misoprostol"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="adjustment_plus_chlorhexidine"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="adjustment_plus_mnp"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="adjustment_plus_iron"/></td>
                                                                        </tr>
                                                                        <tr  class="text-center row-input row-minus row-adjustment_minus" id="adjustment_minus">
                                                                            <td class="tg-031e" style="text-align: left;">(-)</td>
                                                                            <td class="tg-031e "><input type="number" class="form-control" name="adjustment_minus_sukhi"/></td>
                                                                            <td class="tg-031e "><input type="number" class="form-control"  name="adjustment_minus_apon"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="adjustment_minus_condom"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="adjustment_minus_inject_vayal"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="adjustment_minus_inject_syringe"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="adjustment_minus_ecp"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="adjustment_minus_misoprostol"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="adjustment_minus_chlorhexidine"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="adjustment_minus_mnp"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="adjustment_minus_iron"/></td>
                                                                        </tr>
                                                                        <tr  class="text-center row-sum row-total" id="total">
                                                                            <td class="tg-031e" colspan="2" style="text-align: left;">সর্বমোট</td>
                                                                            <td class="tg-031e "><input type="number" class="form-control" name="total_sukhi"/></td>
                                                                            <td class="tg-031e "><input type="number" class="form-control"  name="total_apon"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="total_condom"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="total_inject_vayal"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="total_inject_syringe"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="total_ecp"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="total_misoprostol"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="total_chlorhexidine"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="total_mnp"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="total_iron"/></td>
                                                                        </tr>
                                                                        <tr class="text-center row-input row-minus row-distribution" id="distribution">
                                                                            <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসে বিতরণ করা হয়েছে(-)</td>
                                                                            <td class="tg-031e "><input type="number" class="form-control" name="distribution_sukhi"/></td>
                                                                            <td class="tg-031e "><input type="number" class="form-control"  name="distribution_apon"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="distribution_condom"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="distribution_inject_vayal"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="distribution_inject_syringe"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="distribution_ecp"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="distribution_misoprostol"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="distribution_chlorhexidine"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="distribution_mnp"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="distribution_iron"/></td>
                                                                        </tr>
                                                                        <tr   class="text-center row-sum row-closingbalance" id="closingbalance">
                                                                            <td class="tg-031e" colspan="2" style="text-align: left;">অবশিষ্ট</td>
                                                                            <td class="tg-031e "><input type="number" class="form-control" name="closingbalance_sukhi"/></td>
                                                                            <td class="tg-031e "><input type="number" class="form-control"  name="closingbalance_apon"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="closingbalance_condom"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="closingbalance_inject_vayal"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="closingbalance_inject_syringe"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="closingbalance_ecp"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="closingbalance_misoprostol"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="closingbalance_chlorhexidine"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="closingbalance_mnp"/></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="closingbalance_iron"/></td>
                                                                        </tr>
                                                                        <tr style="text-align: center;">
                                                                            <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসে কখনও মওজুদ শূণ্যতা<br/> হয়ে থাকলে কারণ (কোড) লিখুন <br></td>
                                                                            <td class="tg-031e ">
                                                                                <select class="form-control input-sm" name="stockvacuum_sukhi">
                                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                                    <option value="4">অন্যান্য</option>
                                                                                </select>
                                                                            </td>
                                                                            <td class="tg-031e ">
                                                                                <select class="form-control input-sm" name="stockvacuum_apon">
                                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                                    <option value="4">অন্যান্য</option>
                                                                                </select>
                                                                            </td>
                                                                            <td class="tg-031e ">
                                                                                <select class="form-control input-sm" name="stockvacuum_condom">
                                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                                    <option value="4">অন্যান্য</option>
                                                                                </select>
                                                                            </td>
                                                                            <td class="tg-031e ">
                                                                                <select class="form-control input-sm" name="stockvacuum_inject_vayal">
                                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                                    <option value="4">অন্যান্য</option>
                                                                                </select>
                                                                            </td>
                                                                            <td class="tg-031e ">
                                                                                <select class="form-control input-sm" name="stockvacuum_inject_syringe">
                                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                                    <option value="4">অন্যান্য</option>
                                                                                </select>
                                                                            </td>
                                                                            <td class="tg-031e ">
                                                                                <select class="form-control input-sm" name="stockvacuum_ecp">
                                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                                    <option value="4">অন্যান্য</option>
                                                                                </select>
                                                                            </td>
                                                                            <td class="tg-031e ">
                                                                                <select class="form-control input-sm" name="stockvacuum_misoprostol">
                                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                                    <option value="4">অন্যান্য</option>
                                                                                </select>
                                                                            </td>
                                                                            <td class="tg-031e ">
                                                                                <select class="form-control input-sm" name="stockvacuum_chlorhexidine">
                                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                                    <option value="4">অন্যান্য</option>
                                                                                </select>
                                                                            </td>
                                                                            <td class="tg-031e ">
                                                                                <select class="form-control input-sm" name="stockvacuum_mnp">
                                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                                    <option value="4">অন্যান্য</option>
                                                                                </select>
                                                                            </td>
                                                                            <td class="tg-031e ">
                                                                                <select class="form-control input-sm" name="stockvacuum_iron">
                                                                                    <option value="0">- সিলেক্ট করুন -</option>
                                                                                    <option value="1">সরবরাহ পাওয়া যায়নি</option>
                                                                                    <option value="2">অপর্যাপ্ত সরবরাহ </option>
                                                                                    <option value="3">হঠাৎ চাহিদা বৃদ্ধি পাওয়া  </option>
                                                                                    <option value="4">অন্যান্য</option>
                                                                                </select>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>-->
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