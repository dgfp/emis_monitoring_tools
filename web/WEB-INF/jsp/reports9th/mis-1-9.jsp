<%-- 
    Document   : mis1-9
    Created on : Jan 05, 2018, 11:40:22 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla.js"></script>
<link href="resources/css/newStyle.css" rel="stylesheet" type="text/css"/>
<script src="resources/js/mis1.js" type="text/javascript"></script>
<script src="resources/js/TemplateMIS.js" type="text/javascript"></script>
<style>
    .submitButton{
        display: block;
    }
    .callout.callout-success, .callout.callout-danger, .callout.callout-warning {
        border:none!important;
    }
    .callout {
        border-radius: 50px!important;
    }
    .table-responsive {
        border: 1px solid #6aa9f2;
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
    .insert-lmis-data {
        max-width: 100%;
        overflow-x: auto;
    }
    .insert-lmis-data-table{
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
        /*        background: #87bbf9!important;*/
        background: #6aa9f2!important;
    }
    table.mis_form1_ka_new tbody tr td:not([rowspan="3"])+td{ text-align: center !important; }
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
    $('.insert-lmis-data').css('width', 760);
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


    $(document).ready(function () {
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
            console.log("target",$target);
            value = value.replace(/(?!^\-)[^\d]/gi, '');
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
            }

            var relations = {
                "current_month_stock": ["openingbalance", "receiveqty"],
                "total": ["current_month_stock", "adjustment_plus", "adjustment_minus"],
                "closingbalance": ["total", "distribution"]
            };
            var storage = {};
            var $table = $target.closest('table');
            $table.find('.row-input').each(function (i, tr) {
                var key = $(tr).attr('id'), data = getValues($(tr));
                if ($(tr).is('.row-minus')) {
                    data = negativeValues(data);
                }
                storage[key] = data;
            });
            var calc = new Calc([]);
            $.each(relations, function (key, rel) {
                var data = rel.reduce(function (p, n) {
                    p.push(storage[n]);
                    return p;
                }, [])
                storage[key] = calc.Sum(data);
                var $tr = $table.find('.row-sum#' + key);
                setValues($tr, storage[key]);
            });
            console.log('storage', storage);
        }



        $('.input-group-approve', '#form-report-response').find('button').click(function (e) {
            e.preventDefault();
            //First time submission
            var id = +new Date();
            var isValided = true;
            var lmisJon = $.app.pairs($('#form-report-response'));
            delete lmisJon.message;
            $.each(lmisJon, function (index, object) {
                console.log();
                if (object == "" && index.split("_")[0] != "stockvacuum") {
                    //if (index != "message") {
                    toastr["error"]("<b>সকল ঘর পূরণ করুন, ডাটা না থাকলে শুন্য লিখুন</b>");
                    isValided = false;
                    $("input[name='" + index + "']").addClass("error");
                    //$('select[name="' + index + '"]').addClass("error");
                    //}
                } else {
                    $("input[name='" + index + "']").removeClass("error");
                    //$('select[name="' + index + '"]').removeClass("error");
                }
            });
            json.LMIS = lmisJon;
            console.log("lmis", lmisJon);
            console.log("main", json);

            //isValided = false;
            if (isValided) {

                //json.LMIS = lmisJon;
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
                        year: $("select#year").val(),
                        date: getCurrentPreviousDate($("select#month").val(), $("#year").val()),
                        data: JSON.stringify(json),
                        note: $("input[name='message']").val(),
                        html: $('#data-table').html(),
                        submissionId: id,
                        reviewLength: $.RS.reviewJson.length,
                        lmis: JSON.stringify(lmisJon)
                    },
                    type: 'POST',
                    success: function (result) {
                        var data = JSON.parse(result);
                        console.log("Get ID:" + id);
                        $.RS.submissionId = id;
                        console.log("Get ID var:" + id);
                        $.RS.conversationModal('hide');

                        console.log(data[0].message, data[0].status);

                        if (json.status == 2)
                            $.RS.submissionStatus('rePending');
                        else
                            $.RS.submissionStatus('pending');

                        if (data[0].message == "Somthing went wrong")
                            $.RS.submissionStatus('notSubmitted');


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


        Template.init(1);
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
            } else {
                if ($("#reportType:checked").val() == "dateWise") {
                    if ($("#sDate").val() == "") {
                        toastr["error"]("<b>শুরুর তারিখ সিলেক্ট করুন</b>");
                        return;
                    } else if ($("#eDate").val() == "") {
                        toastr["error"]("<b>শেষের তারিখ সিলেক্ট করুন</b>");
                        return;
                    }
//                    else if (parseInt($("#sDate").val().replace(regExp, "$3$2$1")) > parseInt($("#eDate").val().replace(regExp, "$3$2$1"))) {
//                        toastr["error"]("<b>শুরুর তারিখ শেষের তারিখ থেকে বেশি হবে না</b>");
//                        return;
//                    }
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
                        startDate: $("#sDate").val(),
                        endDate: $("#eDate").val()
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
                        //Check is this user is FWA or not for submit button
                        if ($.app.getDate['day'] >= 25 && $.app.getDate['day'] <= 30) {
                            console.log("Eligible for submission");
                        }
                        $('#isSubmitAccess').val() == '99' ? $.RS.submissionButton('show') : $.RS.submissionButton('hide');
                        //$.RS.submissionButton('show');

                        //if($('#month').val() == $.app.date().month && $.app.date().day<$.app.date().lastDay){
                        if ($('#month').val() == $.app.date().month && $.app.date().day < $.app.date().lastDay)
                            $("#submitDataButton").attr("disabled", true);

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
                            $.RS.submissionStatus('rePending')
                            $("#submitDataButton").attr("disabled", true);

                            //Otherwise is submitted
                        } else {
                            $("#submitDataButton").hide();
                            $.RS.submissionStatus('submitted');
                            $('.dateWiseLevel').fadeOut(300);
                            $('.dateRange').fadeOut(300);
                            $('.monthWise').prop('checked', true);
                        }

                        //Top area part
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
                        //Data rendering into table
//                        var $table1 = $('table.mis_form1_ka_new');
//                        var $table2 = $('table.table-car1');
//                        var $table3 = $('table.table-car2');
//                        var $tableKha1 = $('table.table-kha1'), $tableKha2 = $('table.table-kha2'), $tableKha3 = $('table.table-kha3');
//                        var $ga = $('table.table-ga');
//                        var $gha = $('table.table-gha');
//                        var $tableUma1 = $('table.table-uma1'), $tableUma2 = $('table.table-uma2'), $tableUma3 = $('table.table-uma3');
//                        var filter='.mis_form1_ka_new,table-car1,.table-car2,.table-kha1,.table-kha2,.table-ga,.table-gha,table-uma1,table-uma2,table-uma3';
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

//                            $table1.find(_k).html(_v).addClass("center");
//                            $table2.find(_k).html(_v);
//                            $table3.find(_k).html(_v);
//                            $tableKha1.find(_k).html(_v);
//                            $tableKha2.find(_k).html(_v);
//                            $tableKha3.find(_k).html(_v);
//                            $ga.find(_k).html(_v);
//                            $gha.find(_k).html(_v);
//                            $tableUma1.find(_k).html(_v);
//                            $tableUma2.find(_k).html(_v);
//                            $tableUma3.find(_k).html(_v);
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
            <!--            <small>৯ম সংস্করণ</small>-->
            <span id="submitStatus" class="pull-right"></span>
        </h1>
        <!--      <ol class="breadcrumb">
                <a class="btn btn-flat btn-info btn-sm" href="mis-form-1"><b>৯ম সংস্করণ</b></a>
                <a class="btn btn-flat btn-primary btn-sm" href="mis-form-1"><b>৮ম সংস্করণ</b></a>
              </ol>-->
    </section>
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
            <div class="box-body mis-template" id="data-table">
                <%@include file="/WEB-INF/jspf/mis1-9-template-view.jspf" %>
                <%@include file="/WEB-INF/jspf/mis1-8-template-view.jspf" %>
            </div>
        </div>
    </section>
    <!-------------------------------------------------------------------------------- edit User Modal -------------------------------------------------------------------------------->  
    <!-------- Start Report Modal 
    <%--<%@include file="/WEB-INF/jspf/modal-report-submit.jspf" %>  
    <%@include file="/WEB-INF/jspf/modal-report-response.jspf" %>
    <%@include file="/WEB-INF/jspf/modal-report-view.jspf" %>--%>
    ----------->
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
    <div id="modal-report-response" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg report-response">
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
                                <p><span class="bold">মাসিক মওজুদ ও বিতরণের হিসাব</span> - এর তথ্য নিচের ছকে লিখুন</p>
                                <div class="insert-lmis-data">
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
                                </div>
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