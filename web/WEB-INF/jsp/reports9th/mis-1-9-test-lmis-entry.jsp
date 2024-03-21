<%-- 
    Document   : mis1-9
    Created on : Jan 05, 2018, 11:40:22 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla_test.js"></script>
<link href="resources/css/newStyle.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/mis.css" rel="stylesheet" type="text/css"/>
<script src="resources/js/mis1.js" type="text/javascript"></script>
<script src="resources/js/TemplateMIS.js" type="text/javascript"></script>
<script src="resources/js/utility.js" type="text/javascript"></script>
<style>
    /*    .callout.callout-success, .callout.callout-danger, .callout.callout-warning {
            background-color: #fff !important;
            border-radius: 35px!important;
        }
        .callout.callout-success {
            border: 3px solid #00A65A!important;
            color: #00A65A!important;
            box-shadow: inset 0 0 6px #00A65A!important;
        }
        .callout.callout-danger {
            border: 3px solid #DD4B39!important;
            color: #DD4B39!important;
            box-shadow: inset 0 0 6px #DD4B39!important;
        }
        .callout.callout-warning {
            border: 3px solid #F39C12!important;
            color: #F39C12!important;
            box-shadow: inset 0 0 6px #F39C12!important;
        }*/

    #assign-main, #assign-add {
        display: none;
        background-color: #eaf0f7!important;
        border-radius: 10px;
        padding: 1px;
        margin-left: 10px;
        margin-top: 3px;
    }
    .label {
        border-radius: 11px!important;
    }
    .submitButton{
        display: block;
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
    tr.row-sum td.cell-disabled{
        position: relative;
    }
    tr.row-sum td.cell-disabled:before{
        content: "";
        display: block;
        background: rgba(255,255,255,.7);
        position: absolute;
        z-index: 1;
        top:0;
        right:0;
        bottom: 0;
        left:0
    }
    .form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control {
        background-color: #f7f7f7!important;
    }
    .mis-form-1 {
        /*        background: #87bbf9!important;*/
        background: #6aa9f2!important;
    }
    table.mis_form1_ka_new tbody tr td:not([rowspan="3"])+td{
        text-align: center !important;
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
        background-color:#838a8e!important;
    }

    .mis-template,.print-exact{
        -webkit-print-color-adjust: exact;
    }
    .mis1+.mis1,.page-break+.page-break {
        display: block;
        page-break-before: always;
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
    var TrainingInfoTable = null;
    function generateLmisDt(resp) {
        console.log(resp);
        if (resp.length == 0) {
            resp = null;
        }
        var config = {
            scrollX: true,
            data: resp,
            dom: "rt",
            columns: [
                {data: "serial", render: function (data, type, row) {
                        return convertE2B(data);
                    }
                },
                {data: null, render: function (data, type, row) {
                        console.log(data, type, row);
                        return '<button class="btn btn-flat btn-primary btn-sm btn-block lmis-data-edit" data-id=' + row
                                + '>'
                                + '<i class="fa fa-table" aria-hidden="true"></i> সম্পাদন'
                                + '</button>'
                                + '<button class="btn btn-flat btn-danger btn-sm btn-block lmis-data-delete" data-id=' + row
                                + '>'
                                + '<i class="fa fa-trash" aria-hidden="true"></i> মুছে ফেলুন '
                                + '</button>';
                    }
                }
            ]
        };
        if (TrainingInfoTable) {
            TrainingInfoTable.clear();
            TrainingInfoTable.destroy();
        }
        TrainingInfoTable = $("#data-table-lmis-status").DataTable(config);
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

//    var appFwa = {
//        appPrintReport: function () {
//            console.log("Print Called");
//            window.print();
//        }
//    };

    $(document).ready(function () {
        $('#lmis-btn-show-modal').on('click', function (e) {
            $('#form-report-response input').val(0);
            $('#form-report-response #entry_id').prop("disabled", true);
            $('#modal-lmis-report-submit').modal('show');
        });
//      Lmis data edit
        $('#data-table-lmis-status').on('click', '.lmis-data-edit', function () {
            var row = TrainingInfoTable.row($(this).closest('tr')).data();
            console.log(row);
            $('#form-report-response #entry_id').prop("disabled", false);
            $('#form-report-response input').each(function (i, v) {
                var name = $(v).attr('name');
                $(v).val(row[name]);
                $('#modal-lmis-report-submit').modal('show');
            });
        });
//        Lmis data delete
        $('#data-table-lmis-status').on('click', '.lmis-data-delete', function () {
            var row = TrainingInfoTable.row($(this).closest('tr')).data();
            console.log(row);
            $('#deleteModalLmis').modal('show');
            $('#btnConfirmDeleteLmis').off().on('click', function () {
                UTIL.request('mis-form-1-test-lmis-entry?action=deleteData', {
                    lmis: JSON.stringify(row)
                }, "POST").then(function (resp) {
                    console.log(resp);
                    if (resp["rowcount"] == 1) {
                        alert("Successfully delete");
                        $('#deleteModalLmis').modal('hide');
                    }
                    generateLmisDt(resp["dataLmis"]);
                });
            });
        });

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


        //LMIS data entry form submit
        $('#form-report-response').on('submit', function (e) {
//        $('.input-group-approve', '#form-report-response').find('button').click(function (e) {
            e.preventDefault();
            //First time submission
            var id = +new Date();
            var isValided = true;
            var lmisJson = $.app.pairs($('#form-report-response'));
            delete lmisJson.message;
            $.each(lmisJson, function (index, object) {
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
//            json.LMIS = lmisJon;
//            console.log("lmis", lmisJon);
//            console.log("main", json);
//            console.log("main", json.bbsunionid);
            console.log(lmisJson);

            //isValided = false;
            if (isValided) {

                //json.LMIS = lmisJon;
                $.ajax({
                    url: "mis-form-1-test-lmis-entry?action=insertData",
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
                        lmis: JSON.stringify(lmisJson)
                    },
                    type: 'POST',
                    success: function (result) {
                        console.log(result);
                        var result = JSON.parse(result);
                        if (result["rowCount"] == 1) {
                            toastr["success"]("<b>প্রক্রিয়া সম্পন্ন হয়েছে </b>");
                            $('#modal-lmis-report-submit').modal('hide');
                        } else {
                            toastr["error"]("<b>অনুরোধ প্রক্রিয়া করা যাচ্ছে না</b>");
                        }
                        generateLmisDt(result["dataLmis"]);
//                        var data = JSON.parse(result);
//                        console.log("Get ID:" + id);
//                        $.RS.submissionId = id;
//                        console.log("Get ID var:" + id);
//                        $.RS.conversationModal('hide');
//
//                        console.log(data[0].message, data[0].status);
//
//                        if (json.status == 2) {
//                            $.RS.submissionStatus('rePending');
//                            $("#submitDataButton").attr("disabled", true);
//                        } else {
//                            $.RS.submissionStatus('pending');
//                            $("#submitDataButton").attr("disabled", true);
//                        }
//
//                        if (data[0].message == "Somthing went wrong")
//                            $.RS.submissionStatus('notSubmitted');
//
//
//                        $.toast(data[0].message, data[0].status)();
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
            $("#assign-add, #assign-main").css("display", "none");
            //$('.dateWiseLevel').fadeIn(300);
        });


        Template.init(11);
        $('#showdataButton').click(function () {
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
            } else if ($("select#provCode").val() === "" || $("select#provCode").val() == null) {
                toastr["error"]("<b>প্রোভাইডার সিলেক্ট করুন</b>");
            } else {
                $.ajax({
                    url: "mis-form-1-test-lmis-entry?action=showdata",
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
                        $('#lmis-data-status').removeClass('hide');
                        result = JSON.parse(result);
                        console.log(result);
                        if ($.app.date().month - parseInt($('select#month').val()) == 0 && 
                                $.app.date().year - parseInt($('select#year').val()) == 0){
                            $("#form-report-response input").prop("disabled", false);
                        }
                        else{
                            $("#form-report-response input").prop("disabled", true);
                        }
                            
                        if (result.length > 0) {
                            $('#form-report-response input').each(function (i, v) {
                                var name = $(v).attr('name');
                                $(v).val(result[0][name]);
                            });
                        }
                        else{
                            $('#form-report-response input').val(0);
                        }
//                        generateLmisDt(result);
                        return false;
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
                    <a class="btn btn-flat btn-warning btn-sm bold" href="mis-form-1-additional">অতিরিক্ত ইউনিট</a>
                </ol>-->
    </section>
    <section class="content">
        <!------------------------------Load Area----------------------------------->
        <%@include file="/WEB-INF/jspf/mis1AreaBanglaLmis.jspf" %>
        <div id="viewStatus">
        </div>
        <!--Add Button-->
        <!--        <div class="box box-primary" style="margin-bottom: 5px !important;">
                    <div class="box-header with-border" style="padding: 0px;">
                        <p class="box-title" style="">
                        </p>
                        <div class="box-tools pull-right" style="margin-top: -10px;">
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <button id="lmis-btn-show-modal" class="btn btn-primary pull-right">
                                    মওজুদ ও বিতরণের হিসাব - এর তথ্য এন্ট্রি 
                                </button>
                            </div>
                        </div>
                    </div>
                </div>-->
        <!--LMIS data table status-->
        <div class="box box-primary">
            <div class="box-header with-border" style="padding: 0px;">
                <p class="box-title" style="">
                </p>
                <div class="box-tools pull-right" style="margin-top: -10px;">
                </div>
            </div>
            <div class="box-body hide" id="lmis-data-status">
                <div class="row">
                    <div class="col-md-12">
                        <form action="/" method="post" id="form-report-response" class="overlay-relative">
                            <!--<p><span class="bold">মাসিক মওজুদ ও বিতরণের হিসাব</span> - এর তথ্য নিচের ছকে লিখুন</p>-->
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
                                    <!--                                    <tr class="text-center row-input row-openingbalance" id="openingbalance">
                                                                            <td class="tg-031e" colspan="2" style="text-align: left;">পূর্বের মওজুদ<br></td>
                                                                            <td class="tg-031e "><input type="number" class="form-control" name="openingbalance_sukhi" readonly /></td>
                                                                            <td class="tg-031e "><input type="number" class="form-control"  name="openingbalance_apon" readonly /></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="openingbalance_condom" readonly /></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="openingbalance_inject_vayal" readonly /></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="openingbalance_inject_syringe" readonly /></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="openingbalance_ecp" readonly /></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="openingbalance_misoprostol" readonly /></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="openingbalance_chlorhexidine" readonly /></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="openingbalance_mnp" readonly /></td>
                                                                            <td class="tg-031e " ><input type="number" class="form-control"  name="openingbalance_iron" readonly /></td>
                                                                        </tr>-->
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
                                    <tr class="text-center row-sum row-current_month_stock hide" id="current_month_stock">
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
                                    <!--                                        <tr  class="text-center row-sum row-total" id="total">
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
                                                                            </tr>-->

                                </table>
                            </div>
                            <div class="overlay hidden"></div>
                            <div class="input-group pull-right">
                                <!--                                    <span class="input-group-btn input-group-return">
                                                                        <button type="submit" class="btn btn-warning btn-flat" data-status="2" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading"><b><i class="fa fa-reply-all" aria-hidden="true"></i> Return</b></button>
                                                                    </span>-->
                                <!--<input type="text" name="message" placeholder="" class="form-control">-->
                                <button type="submit" class="btn btn-flat btn-primary btn-block btn-sm"  data-status="1" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading"><b><i class="fa fa-check-square-o" aria-hidden="true"></i> সাবমিট করুন  </b></button>
                                <!--                                    <span class="input-group-btn input-group-approve">
                                                                        <button type="submit" class="btn btn-warning btn-flat"  data-status="1" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading"><b><i class="fa fa-check-square-o" aria-hidden="true"></i> Approve</b></button>
                                                                    </span>-->
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
        <!--------------------------------------------------------------------------------Data Table Goes Here-------------------------------------------------------------------------------->  
        <div class="box box-primary full-screen hide">
            <!--            <div class="box-header with-border">-->
            <div class="box-header with-border" style="padding: 0px;">
                <p class="box-title" style="">
                    <span class="text-green bold " id="assign-main">মূল ইউনিট</span>
                    <span class="text-yellow bold" id="assign-add">অতিরিক্ত ইউনিট</span>
                </p>
                <div class="box-tools pull-right" style="margin-top: -10px;">
                    <!--window.print() | appFwa.appPrintReport-->
<!--                    <button type="button" class="btn btn-flat btn-default btn-xs bold" onclick="${sessionScope.isTabAccess?'appFwa.appPrintReport();':'window.print()'}"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                    <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>-->
                </div>
            </div>

        </div>
    </section>
    <!--Lmis data entry-->
    <div id="modal-lmis-report-submit" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header label-info">
                    <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                    <h4 class="modal-title"><b><i class="fa fa-question-circle" aria-hidden="true"></i><span> মাসিক মওজুদ ও বিতরণের হিসাব</span></b></h4>
                </div>
                <div class="modal-body">
                    <div class="box-body mis-template" id="data-table">
                        <%--<%@include file="/WEB-INF/jspf/mis1-9-template-view.jspf" %>--%>
                        <%--<%@include file="/WEB-INF/jspf/mis1-8-template-view.jspf" %>--%>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Data delete-->
    <!--Delete modal-->
    <div class="modal fade" id="deleteModalLmis" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">

                <!--            <div class="modal-header label-danger">
                                <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                                <h4 class="modal-title"><b><i class="fa fa-trash" aria-hidden="true"></i><span> Are you sure to delete?</span></b></h4>
                            </div>-->

                <div class="modal-header">
                    <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                    <h4 class="modal-title bold">নিশ্চিত করুন </h4>
                </div>

                <div class="modal-body">
                    <h4 class="center bold"><i class="fa fa-question-circle" aria-hidden="true"></i>&nbsp; আপনি আপনার এন্ট্রি মুছে ফেলতে চান ?</h4>
                    <p id="deleteReportingUnitName" style="font-size: 16px;text-align: center"></p>
                    <!--                <button type="button" id="btnConfirm-deleteVillage" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger">Confirm</button>&nbsp;&nbsp;-->
                    <!--                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Cancel</button>-->
                </div>

                <div class="modal-footer">
                    <button type="button" id="btnConfirmDeleteLmis" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger bold"><i class="fa fa-check-square-o" aria-hidden="true"></i>&nbsp; মুছুন </button>&nbsp;&nbsp;
                    <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal"><i class="fa fa-window-close-o" aria-hidden="true"></i>&nbsp; বাতিল</button>
                </div>
            </div>
        </div>
    </div>
    <%@include file="/WEB-INF/jspf/templateFooter.jspf" %>