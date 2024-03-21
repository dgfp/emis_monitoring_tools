<%-- 
    Document   : mis1-lmis
    Created on : Oct 18, 2017, 11:40:22 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla.js"></script>
<link href="resources/css/style.css" rel="stylesheet" type="text/css"/>
<script src="resources/js/functions.js" type="text/javascript"></script>
<script src="resources/js/mis1.js" type="text/javascript"></script>
<style>
    .table-responsive {
        width: 100%;
        margin-bottom: 15px;
        overflow-y: hidden;
        -ms-overflow-style: -ms-autohiding-scrollbar;
        border: 1px solid #fff;
        border-top-color: #fff;
        border-top-style: solid;
        border-top-width: 1px;
        border-right-color: #fff;
        border-right-style: solid;
        border-right-width: 1px;
        border-bottom-color: #fff;
        border-bottom-style: solid;
        border-bottom-width: 1px;
        border-left-color: #fff;
        border-left-style: solid;
        border-left-width: 1px;
        border-image-source: initial;
        border-image-slice: initial;
        border-image-width: initial;
        border-image-outset: initial;
        border-image-repeat: initial;
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
        padding: 5px;
    }
    #slogan{
        border: 1px solid #000000;
        width: 145px;
        text-align: center;
        padding: 2px;
        margin-top: 45px;
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
    table, th, td {
        padding: 3px;
    }

    @font-face {
        font-family: NikoshBAN;
        src: url('resources/fonts/NikoshBAN.ttf');
    }
    .v_field{
        font-family: NikoshBAN;
        font-size: 18px;
    }
</style>
<style media="print" type="text/css">
    #areaPanel{
        display: none;
    }
    .main-footer{
        display: none;
    }
    .with-border{
        display: none;
    }
    .box.box-primary {
        border-top-color: #fff;
    }
</style>
<script>

    
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

        /*var currFirst=year+"-"+currMonth+"-"+"01";
         var currLast=year+"-"+currMonth+"-"+currLastDay.getDate();
         var preFirst=preYear+"-"+preMonth+"-"+"01";
         var preLast=preYear+"-"+preMonth+"-"+preLastDay.getDate();*/

        return year + "-" + currMonth + "-" + "01" + "~" + year + "-" + currMonth + "-" + currLastDay.getDate() + "~" + preYear + "-" + preMonth + "-" + "01" + "~" + preYear + "-" + preMonth + "-" + preLastDay.getDate();
    }

    $(document).ready(function () {
        $.app.hideNextMonths();



        $('#showdataButton').click(function () {

            var d = new Date(),
                    m = d.getMonth() + 1,
                    y = d.getFullYear();

            //Reset all lmis Data
            $("#r_pre_storage_1").empty();
            $("#r_curr_m_found_1").empty();
            $("#r_curr_m_total_storage_1").empty();
            $("#r_adjust_plus_1").empty();
            $("#r_adjust_minus_1").empty();
            $("#r_all_total_1").empty();
            $("#r_curr_m_delivered_1").empty();
            $("#r_remaining_1").empty();

            //Remove table data
            clearData(); //from /mis1.js
            //
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
                var btn = $(this).button('loading');
                //alert(getCurrentPreviousDate($("select#month").val(),$("#year").val()));

//Load own server=========================================================================================================
                Pace.track(function () {
                    $.ajax({
                        url: "mis1-lmis",
                        data: {
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            fwaUnit: $("select#unit").val(),
                            provCode: $("select#provCode").val(),
                            month: $("select#month").val(),
                            year: $("#year").val(),
                            date: getCurrentPreviousDate($("select#month").val(), $("#year").val())
                        },
                        type: 'POST',
                        success: function (result) {
                            btn.button('reset');
                            var data = JSON.parse(result);
                            if (data.length === 0) {
                                btn.button('reset');
                                toastr["error"]("<h4><b>No data found</b></h4>");
                                return;
                            }
                            var bottomJson = data.LMIS;
                            for (var i = 0; i < bottomJson.length; i++) {
                                $('#month2').html($('#month').find(":selected").text());
                                $('#year2').html($("#year").val());

                                ////////////////////////////////////////1st FOR সুখী(চক্র)======================================
                                if (bottomJson[i].miscolumnno === 1) {
                                    console.log("Before:" + bottomJson[i].openingbalance);
                                    if (bottomJson[i].openingbalance === 'null' || bottomJson[i].openingbalance === '')
                                        bottomJson[i].openingbalance = 0;
                                    $("#r_pre_storage_1").html(bottomJson[i].openingbalance);
                                    console.log("Before:" + bottomJson[i].openingbalance);
                                    if (bottomJson[i].receiptthismonth === 'null' || bottomJson[i].receiptthismonth === '')
                                        bottomJson[i].receiptthismonth = 0;
                                    $("#r_curr_m_found_1").html(bottomJson[i].receiptthismonth);
                                    $("#r_curr_m_total_storage_1").html((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth));

                                    if (bottomJson[i].adjustmentplus === 'null' || bottomJson[i].adjustmentplus === '' || bottomJson[i].adjustmentplus === '-')
                                        bottomJson[i].adjustmentplus = 0;
                                    $("#r_adjust_plus_1").html(bottomJson[i].adjustmentplus);

                                    if (bottomJson[i].adjustmentminus === 'null' || bottomJson[i].adjustmentminus === '' || bottomJson[i].adjustmentminus === '-')
                                        bottomJson[i].adjustmentminus = 0;
                                    $("#r_adjust_minus_1").html(bottomJson[i].adjustmentminus);

                                    var r_all_total_sum_1 = ((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth + bottomJson[i].adjustmentplus) - bottomJson[i].adjustmentminus);
                                    $("#r_all_total_1").html(r_all_total_sum_1); //totalthisMonth=openingBalance+receiveptThisMonth+AdjPlus-AdjMinus

                                    if (bottomJson[i].distribution === 'null' || bottomJson[i].distribution === '')
                                        bottomJson[i].distribution = 0;
                                    $("#r_curr_m_delivered_1").html(bottomJson[i].distribution);

                                    var r_remaining_sum_1 = (r_all_total_sum_1 - bottomJson[i].distribution);
                                    $("#r_remaining_1").html(r_remaining_sum_1); //cloasingBalance=totalThismonth-distribution                                     
                                }
                                ////////////////////////////////////////2nd FOR আপন(চক্র) =====================================
                                if (bottomJson[i].miscolumnno === 2) {
                                    if (bottomJson[i].openingbalance === 'null' || bottomJson[i].openingbalance === '')
                                        bottomJson[i].openingbalance = 0;
                                    $("#r_pre_storage_2").html(bottomJson[i].openingbalance);

                                    if (bottomJson[i].receiptthismonth === 'null' || bottomJson[i].receiptthismonth === '')
                                        bottomJson[i].receiptthismonth = 0;

                                    $("#r_curr_m_found_2").html(bottomJson[i].receiptthismonth);
                                    $("#r_curr_m_total_storage_2").html((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth));

                                    if (bottomJson[i].adjustmentplus === 'null' || bottomJson[i].adjustmentplus === '' || bottomJson[i].adjustmentplus === '-')
                                        bottomJson[i].adjustmentplus = 0;
                                    $("#r_adjust_plus_2").html(bottomJson[i].adjustmentplus);

                                    if (bottomJson[i].adjustmentminus === 'null' || bottomJson[i].adjustmentminus === '' || bottomJson[i].adjustmentminus === '-')
                                        bottomJson[i].adjustmentminus = 0;
                                    $("#r_adjust_minus_2").html(bottomJson[i].adjustmentminus);

                                    var r_all_total_sum_2 = ((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth + bottomJson[i].adjustmentplus) - bottomJson[i].adjustmentminus);
                                    $("#r_all_total_2").html(r_all_total_sum_2); //totalthisMonth=openingBalance+receiveptThisMonth+AdjPlus-AdjMinus

                                    if (bottomJson[i].distribution === 'null' || bottomJson[i].distribution === '')
                                        bottomJson[i].distribution = 0;
                                    $("#r_curr_m_delivered_2").html(bottomJson[i].distribution);

                                    var r_remaining_sum_2 = (r_all_total_sum_2 - bottomJson[i].distribution);
                                    $("#r_remaining_2").html(r_remaining_sum_2); //cloasingBalance=totalThismonth-distribution  
                                }
                                ////////////////////////////////////////3rd FOR  কনডম(নিরাপদ) (পিস)=====================================
                                if (bottomJson[i].miscolumnno === 3) {

                                    if (bottomJson[i].openingbalance === 'null' || bottomJson[i].openingbalance === '')
                                        bottomJson[i].openingbalance = 0;
                                    $("#r_pre_storage_3").html(bottomJson[i].openingbalance);

                                    if (bottomJson[i].receiptthismonth === 'null' || bottomJson[i].receiptthismonth === '')
                                        bottomJson[i].receiptthismonth = 0;

                                    $("#r_curr_m_found_3").html(bottomJson[i].receiptthismonth);
                                    $("#r_curr_m_total_storage_3").html((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth));

                                    if (bottomJson[i].adjustmentplus === 'null' || bottomJson[i].adjustmentplus === '' || bottomJson[i].adjustmentplus === '-')
                                        bottomJson[i].adjustmentplus = 0;
                                    $("#r_adjust_plus_3").html(bottomJson[i].adjustmentplus);

                                    if (bottomJson[i].adjustmentminus === 'null' || bottomJson[i].adjustmentminus === '' || bottomJson[i].adjustmentminus === '-')
                                        bottomJson[i].adjustmentminus = 0;
                                    $("#r_adjust_minus_3").html(bottomJson[i].adjustmentminus);

                                    var r_all_total_sum_3 = ((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth + bottomJson[i].adjustmentplus) - bottomJson[i].adjustmentminus);
                                    $("#r_all_total_3").html(r_all_total_sum_3); //totalthisMonth=openingBalance+receiveptThisMonth+AdjPlus-AdjMinus

                                    if (bottomJson[i].distribution === 'null' || bottomJson[i].distribution === '')
                                        bottomJson[i].distribution = 0;
                                    $("#r_curr_m_delivered_3").html(bottomJson[i].distribution);

                                    var r_remaining_sum_3 = (r_all_total_sum_3 - bottomJson[i].distribution);
                                    $("#r_remaining_3").html(r_remaining_sum_3); //cloasingBalance=totalThismonth-distribution  
                                }
                                ////////////////////////////////////////4thFOR   vayal =====================================
                                if (bottomJson[i].miscolumnno === 4) {

                                    if (bottomJson[i].openingbalance === 'null' || bottomJson[i].openingbalance === '')
                                        bottomJson[i].openingbalance = 0;
                                    $("#r_pre_storage_4").html(bottomJson[i].openingbalance);


                                    if (bottomJson[i].receiptthismonth === 'null' || bottomJson[i].receiptthismonth === '')
                                        bottomJson[i].receiptthismonth = 0;

                                    $("#r_curr_m_found_4").html(bottomJson[i].receiptthismonth);
                                    $("#r_curr_m_total_storage_4").html((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth));

                                    //                                            if(bottomJson[0].openingbalance==='null' || bottomJson[i].openingbalance==='')bottomJson[i].openingbalance=0;
                                    //                                            $("#r_pre_storage_4").html(bottomJson[i].openingbalance);
                                    //                                            
                                    //                                            if(bottomJson[i].receiptthismonth==='null' || bottomJson[i].receiptthismonth==='')bottomJson[i].receiptthismonth=0;
                                    //                                            $("#r_curr_m_found_4").html(bottomJson[i].receiptthismonth);
                                    //                                            
                                    //                                            if(bottomJson[i].balancethismonth==='null' || bottomJson[i].balancethismonth==='')bottomJson[i].balancethismonth=0;
                                    //                                            $("#r_curr_m_total_storage_4").html(bottomJson[i].balancethismonth);

                                    if (bottomJson[i].adjustmentplus === 'null' || bottomJson[i].adjustmentplus === '')
                                        bottomJson[i].adjustmentplus = 0;
                                    $("#r_adjust_plus_4").html(bottomJson[i].adjustmentplus);

                                    if (bottomJson[i].adjustmentminus === 'null' || bottomJson[i].adjustmentminus === '')
                                        bottomJson[i].adjustmentminus = 0;
                                    $("#r_adjust_minus_4").html(bottomJson[i].adjustmentminus);

                                    var r_all_total_sum_4 = ((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth + bottomJson[i].adjustmentplus) - bottomJson[i].adjustmentminus);
                                    $("#r_all_total_4").html(r_all_total_sum_4); //totalthisMonth=openingBalance+receiveptThisMonth+AdjPlus-AdjMinus

                                    if (bottomJson[i].distribution === 'null' || bottomJson[i].distribution === '')
                                        bottomJson[i].distribution = 0;
                                    $("#r_curr_m_delivered_4").html(bottomJson[i].distribution);

                                    var r_remaining_sum_4 = (r_all_total_sum_4 - bottomJson[i].distribution);
                                    $("#r_remaining_4").html(r_remaining_sum_4); //cloasingBalance=totalThismonth-distribution                                       
                                }

                                ////////////////////////////////////////5th FOR  সিরিঞ্জ= ====================================
                                if (bottomJson[i].miscolumnno === 5) {

                                    if (bottomJson[i].openingbalance === 'null' || bottomJson[i].openingbalance === '')
                                        bottomJson[i].openingbalance = 0;
                                    $("#r_pre_storage_5").html(bottomJson[i].openingbalance);


                                    if (bottomJson[i].receiptthismonth === 'null' || bottomJson[i].receiptthismonth === '')
                                        bottomJson[i].receiptthismonth = 0;

                                    $("#r_curr_m_found_5").html(bottomJson[i].receiptthismonth);
                                    $("#r_curr_m_total_storage_5").html((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth));

                                    if (bottomJson[i].adjustmentplus === 'null' || bottomJson[i].adjustmentplus === '')
                                        bottomJson[i].adjustmentplus = 0;
                                    $("#r_adjust_plus_5").html(bottomJson[i].adjustmentplus);

                                    if (bottomJson[i].adjustmentminus === 'null' || bottomJson[i].adjustmentminus === '')
                                        bottomJson[i].adjustmentminus = 0;
                                    $("#r_adjust_minus_5").html(bottomJson[i].adjustmentminus);

                                    var r_all_total_sum_5 = ((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth + bottomJson[i].adjustmentplus) - bottomJson[i].adjustmentminus);
                                    $("#r_all_total_5").html(r_all_total_sum_5); //totalthisMonth=openingBalance+receiveptThisMonth+AdjPlus-AdjMinus

                                    if (bottomJson[i].distribution === 'null' || bottomJson[i].distribution === '')
                                        bottomJson[i].distribution = 0;
                                    $("#r_curr_m_delivered_5").html(bottomJson[i].distribution);

                                    var r_remaining_sum_5 = (r_all_total_sum_5 - bottomJson[i].distribution);
                                    $("#r_remaining_5").html(r_remaining_sum_5); //cloasingBalance=totalThismonth-distribution                                       
                                }

                                ////////////////////////////////////////6th FOR  ইসিপি(ডোজ)=====================================
                                if (bottomJson[i].miscolumnno === 6) {

                                    if (bottomJson[i].openingbalance === 'null' || bottomJson[i].openingbalance === '')
                                        bottomJson[i].openingbalance = 0;
                                    $("#r_pre_storage_6").html(bottomJson[i].openingbalance);

                                    if (bottomJson[i].receiptthismonth === 'null' || bottomJson[i].receiptthismonth === '')
                                        bottomJson[i].receiptthismonth = 0;

                                    $("#r_curr_m_found_6").html(bottomJson[i].receiptthismonth);
                                    $("#r_curr_m_total_storage_6").html((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth));

                                    if (bottomJson[i].adjustmentplus === 'null' || bottomJson[i].adjustmentplus === '' || bottomJson[i].adjustmentplus === '-')
                                        bottomJson[i].adjustmentplus = 0;
                                    $("#r_adjust_plus_6").html(bottomJson[i].adjustmentplus);

                                    if (bottomJson[i].adjustmentminus === 'null' || bottomJson[i].adjustmentminus === '' || bottomJson[i].adjustmentminus === '-')
                                        bottomJson[i].adjustmentminus = 0;
                                    $("#r_adjust_minus_6").html(bottomJson[i].adjustmentminus);

                                    var r_all_total_sum_6 = ((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth + bottomJson[i].adjustmentplus) - bottomJson[i].adjustmentminus);
                                    $("#r_all_total_6").html(r_all_total_sum_6); //totalthisMonth=openingBalance+receiveptThisMonth+AdjPlus-AdjMinus

                                    if (bottomJson[i].distribution === 'null' || bottomJson[i].distribution === '')
                                        bottomJson[i].distribution = 0;
                                    $("#r_curr_m_delivered_6").html(bottomJson[i].distribution);

                                    var r_remaining_sum_6 = (r_all_total_sum_6 - bottomJson[i].distribution);
                                    $("#r_remaining_6").html(r_remaining_sum_6); //cloasingBalance=totalThismonth-distribution   
                                }

                                ////////////////////////////////////////7th FOR  মিসো-প্রোস্টল(ডোজ) =====================================
                                if (bottomJson[i].miscolumnno === 7) {

                                    if (bottomJson[i].openingbalance === 'null' || bottomJson[i].openingbalance === '')
                                        bottomJson[i].openingbalance = 0;
                                    $("#r_pre_storage_7").html(bottomJson[i].openingbalance);


                                    if (bottomJson[i].receiptthismonth === 'null' || bottomJson[i].receiptthismonth === '')
                                        bottomJson[i].receiptthismonth = 0;

                                    $("#r_curr_m_found_7").html(bottomJson[i].receiptthismonth);
                                    $("#r_curr_m_total_storage_7").html((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth));

                                    if (bottomJson[i].adjustmentplus === 'null' || bottomJson[i].adjustmentplus === '' || bottomJson[i].adjustmentplus === '-')
                                        bottomJson[i].adjustmentplus = 0;
                                    $("#r_adjust_plus_7").html(bottomJson[i].adjustmentplus);

                                    if (bottomJson[i].adjustmentminus === 'null' || bottomJson[i].adjustmentminus === '' || bottomJson[i].adjustmentminus === '-')
                                        bottomJson[i].adjustmentminus = 0;
                                    $("#r_adjust_minus_7").html(bottomJson[i].adjustmentminus);

                                    var r_all_total_sum_7 = ((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth + bottomJson[i].adjustmentplus) - bottomJson[i].adjustmentminus);
                                    $("#r_all_total_7").html(r_all_total_sum_7); //totalthisMonth=openingBalance+receiveptThisMonth+AdjPlus-AdjMinus

                                    if (bottomJson[i].distribution === 'null' || bottomJson[i].distribution === '')
                                        bottomJson[i].distribution = 0;
                                    $("#r_curr_m_delivered_7").html(bottomJson[i].distribution);

                                    var r_remaining_sum_7 = (r_all_total_sum_7 - bottomJson[i].distribution);
                                    $("#r_remaining_7").html(r_remaining_sum_7); //cloasingBalance=totalThismonth-distribution   
                                }

                                ////////////////////////////////////////8thth FOR এমএনপি =====================================
                                if (bottomJson[i].miscolumnno === 8) {
                                    if (bottomJson[i].openingbalance === 'null' || bottomJson[i].openingbalance === '')
                                        bottomJson[i].openingbalance = 0;
                                    $("#r_pre_storage_8").html(bottomJson[i].openingbalance);

                                    if (bottomJson[i].receiptthismonth === 'null' || bottomJson[i].receiptthismonth === '')
                                        bottomJson[i].receiptthismonth = 0;

                                    $("#r_curr_m_found_8").html(bottomJson[i].receiptthismonth);
                                    $("#r_curr_m_total_storage_8").html((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth));

                                    if (bottomJson[i].adjustmentplus === 'null' || bottomJson[i].adjustmentplus === '' || bottomJson[i].adjustmentplus === '-')
                                        bottomJson[i].adjustmentplus = 0;
                                    $("#r_adjust_plus_8").html(bottomJson[i].adjustmentplus);

                                    if (bottomJson[i].adjustmentminus === 'null' || bottomJson[i].adjustmentminus === '' || bottomJson[i].adjustmentminus === '-')
                                        bottomJson[i].adjustmentminus = 0;
                                    $("#r_adjust_minus_8").html(bottomJson[i].adjustmentminus);

                                    var r_all_total_sum_8 = ((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth + bottomJson[i].adjustmentplus) - bottomJson[i].adjustmentminus);
                                    $("#r_all_total_8").html(r_all_total_sum_8); //totalthisMonth=openingBalance+receiveptThisMonth+AdjPlus-AdjMinus

                                    if (bottomJson[i].distribution === 'null' || bottomJson[i].distribution === '')
                                        bottomJson[i].distribution = 0;
                                    $("#r_curr_m_delivered_8").html(bottomJson[i].distribution);

                                    var r_remaining_sum_8 = (r_all_total_sum_8 - bottomJson[i].distribution);
                                    $("#r_remaining_8").html(r_remaining_sum_8); //cloasingBalance=totalThismonth-distribution   
                                }

                                ////////////////////////////////////////9th FOR  আয়রন =====================================
                                if (bottomJson[i].miscolumnno === 9) {
                                    if (bottomJson[i].openingbalance === 'null' || bottomJson[i].openingbalance === '')
                                        bottomJson[i].openingbalance = 0;
                                    $("#r_pre_storage_9").html(bottomJson[i].openingbalance);

                                    if (bottomJson[i].receiptthismonth === 'null' || bottomJson[i].receiptthismonth === '')
                                        bottomJson[i].receiptthismonth = 0;

                                    $("#r_curr_m_found_9").html(bottomJson[i].receiptthismonth);
                                    $("#r_curr_m_total_storage_9").html((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth));

                                    if (bottomJson[i].adjustmentplus === 'null' || bottomJson[i].adjustmentplus === '' || bottomJson[i].adjustmentplus === '-')
                                        bottomJson[i].adjustmentplus = 0;
                                    $("#r_adjust_plus_9").html(bottomJson[i].adjustmentplus);

                                    if (bottomJson[i].adjustmentminus === 'null' || bottomJson[i].adjustmentminus === '' || bottomJson[i].adjustmentminus === '-')
                                        bottomJson[i].adjustmentminus = 0;
                                    $("#r_adjust_minus_9").html(bottomJson[i].adjustmentminus);

                                    var r_all_total_sum_9 = ((bottomJson[i].openingbalance + bottomJson[i].receiptthismonth + bottomJson[i].adjustmentplus) - bottomJson[i].adjustmentminus);
                                    $("#r_all_total_9").html(r_all_total_sum_9); //totalthisMonth=openingBalance+receiveptThisMonth+AdjPlus-AdjMinus

                                    if (bottomJson[i].distribution === 'null' || bottomJson[i].distribution === '')
                                        bottomJson[i].distribution = 0;
                                    $("#r_curr_m_delivered_9").html(bottomJson[i].distribution);

                                    var r_remaining_sum_9 = (r_all_total_sum_9 - bottomJson[i].distribution);
                                    $("#r_remaining_9").html(r_remaining_sum_9); //cloasingBalance=totalThismonth-distribution   
                                }
                            }

                            btn.button('reset');
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            alert.append(getAlert("Request can't be processed", "danger"));
                        }
                    }); //End Ajax Call
                });
                //---------------------End----------------------

            }

        }); //End show data button click

    });


</script>
${sessionScope.designation=='FWA'  && sessionScope.userLevel=='7'? 
  "<input type='hidden' id='isSubmitAccess' value='99'>" : "<input type='hidden' id='isSubmitAccess' value='66'>"}
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle"> FWA stock-distribution<small id="isCSBA"></small></h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <%@include file="/WEB-INF/jspf/reportsArea.jspf" %>

    <!--------------------------------------------------------------------------------Data Table Goes Here-------------------------------------------------------------------------------->  
    <div class="box box-primary full-screen">
        <div class="box-header with-border">
            <div class="box-tools pull-right" style="margin-top: -10px;">
                <button type="button" class="btn btn-flat btn-default btn-xs bold" onclick="window.print();"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body">
            <div class="row">
                <div class="col-md-12">
                    <h4 style="font-weight:bold;text-align: center">মাসিক মওজুদ ও বিতরণের হিসাব বিষয়কঃ</h4>
                </div>
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table class="table-bordered mis_table" style="table-layout: fixed; width: 100%">
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
                                <col style="width: 91px">
                                <col style="width: 93px">
                            </colgroup>
                            <tr>
                                <td class="tg-glis" style="text-align: left;" colspan="5">মাসের নামঃ&nbsp;<b id="month2"></b><br></td>
                                <td class="tg-glis" style="text-align: left;" colspan="6">সালঃ&nbsp;<b id="year2"></b><br></td>
                            </tr>
                            <tr>
                                <td class="tg-glis" style="text-align: left;">ইস্যু ভাউচার নং<br></td>
                                <td class="tg-031e"></td>
                                <td class="tg-s6z2" colspan="2" style="text-align: center">খাবার বড়ি <br> (চক্র)<br></td>
                                <td class="tg-s6z2" rowspan="2" style="text-align: center">কনডম<br>(নিরাপদ)<br>(পিস)<br></td>
                                <td class="tg-s6z2" colspan="2" style="text-align: center">ইনজেকটেবল</td>
                                <td class="tg-s6z2" rowspan="2" style="text-align: center">ইসিপি<br>(ডোজ)<br></td>
                                <td class="tg-s6z2" rowspan="2" style="text-align: center">মিসো-<br>প্রোস্টল<br>(ডোজ)<br></td>
                                <td class="tg-s6z2" rowspan="2" style="text-align: center">এমএনপি<br>(স্যাসেট)<br></td>
                                <td class="tg-s6z2" rowspan="2" style="text-align: center">আয়রন<br>ফলিক<br>এসিড<br>(সংখ্যা)<br></td>
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
                                <td class="tg-031e v_field" id="r_pre_storage_1"></td>
                                <td class="tg-031e v_field" id="r_pre_storage_2"></td>
                                <td class="tg-031e v_field" id="r_pre_storage_3"></td>
                                <td class="tg-031e v_field" id="r_pre_storage_4"></td>
                                <td class="tg-031e v_field" id="r_pre_storage_5"></td>
                                <td class="tg-031e v_field" id="r_pre_storage_6"></td>
                                <td class="tg-031e v_field" id="r_pre_storage_7"></td>
                                <td class="tg-031e v_field" id="r_pre_storage_8"></td>
                                <td class="tg-031e v_field" id="r_pre_storage_9"></td>
                            </tr>
                            <tr style="text-align: center;">
                                <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসে পাওয়া গেছে (+)<br></td>
                                <td class="tg-031e v_field" id="r_curr_m_found_1"></td>
                                <td class="tg-031e v_field" id="r_curr_m_found_2"></td>
                                <td class="tg-031e v_field" id="r_curr_m_found_3"></td>
                                <td class="tg-031e v_field" id="r_curr_m_found_4"></td>
                                <td class="tg-031e v_field" id="r_curr_m_found_5"></td>
                                <td class="tg-031e v_field" id="r_curr_m_found_6"></td>
                                <td class="tg-031e v_field" id="r_curr_m_found_7"></td>
                                <td class="tg-031e v_field" id="r_curr_m_found_8"></td>
                                <td class="tg-031e v_field" id="r_curr_m_found_9"></td>
                            </tr>
                            <tr style="text-align: center;">
                                <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসের মোট মওজুদ<br></td>
                                <td class="tg-031e v_field" id="r_curr_m_total_storage_1"></td>
                                <td class="tg-031e v_field" id="r_curr_m_total_storage_2"></td>
                                <td class="tg-031e v_field" id="r_curr_m_total_storage_3"></td>
                                <td class="tg-031e v_field" id="r_curr_m_total_storage_4"></td>
                                <td class="tg-031e v_field" id="r_curr_m_total_storage_5"></td>
                                <td class="tg-031e v_field" id="r_curr_m_total_storage_6"></td>
                                <td class="tg-031e v_field" id="r_curr_m_total_storage_7"></td>
                                <td class="tg-031e v_field" id="r_curr_m_total_storage_8"></td>
                                <td class="tg-031e v_field" id="r_curr_m_total_storage_9"></td>
                            </tr>
                            <tr style="text-align: center;">
                                <td class="tg-031e" rowspan="2" style="text-align: left;">সমন্বয়</td>
                                <td class="tg-031e v_field" style="text-align: left;">(+)</td>
                                <td class="tg-031e v_field" id="r_adjust_plus_1"></td>
                                <td class="tg-031e v_field" id="r_adjust_plus_2"></td>    
                                <td class="tg-031e v_field" id="r_adjust_plus_3"></td>
                                <td class="tg-031e v_field" id="r_adjust_plus_4"></td>
                                <td class="tg-031e v_field" id="r_adjust_plus_5"></td>
                                <td class="tg-031e v_field"  id="r_adjust_plus_6"></td>
                                <td class="tg-031e v_field"  id="r_adjust_plus_7"></td>
                                <td class="tg-031e v_field"  id="r_adjust_plus_8"></td>
                                <td class="tg-031e v_field"  id="r_adjust_plus_9"></td>
                            </tr>
                            <tr style="text-align: center;">
                                <td class="tg-031e" style="text-align: left;">(-)</td>
                                <td class="tg-031e v_field" id="r_adjust_minus_1"></td>
                                <td class="tg-031e v_field" id="r_adjust_minus_2"></td>
                                <td class="tg-031e v_field" id="r_adjust_minus_3"></td>
                                <td class="tg-031e v_field" id="r_adjust_minus_4"></td>
                                <td class="tg-031e v_field" id="r_adjust_minus_5"></td>
                                <td class="tg-031e v_field" id="r_adjust_minus_6"></td>
                                <td class="tg-031e v_field" id="r_adjust_minus_7"></td>
                                <td class="tg-031e v_field" id="r_adjust_minus_8"></td>
                                <td class="tg-031e v_field" id="r_adjust_minus_9"></td>
                            </tr>
                            <tr style="text-align: center;">
                                <td class="tg-031e" colspan="2" style="text-align: left;">সর্বমোট</td>
                                <td class="tg-031e v_field" id="r_all_total_1"></td>
                                <td class="tg-031e v_field" id="r_all_total_2"></td>
                                <td class="tg-031e v_field" id="r_all_total_3"></td>
                                <td class="tg-031e v_field" id="r_all_total_4"></td>
                                <td class="tg-031e v_field" id="r_all_total_5"></td>
                                <td class="tg-031e v_field" id="r_all_total_6"></td>
                                <td class="tg-031e v_field" id="r_all_total_7"></td>
                                <td class="tg-031e v_field" id="r_all_total_8"></td>
                                <td class="tg-031e v_field" id="r_all_total_9"></td>
                            </tr>
                            <tr style="text-align: center;">
                                <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসে বিতরণ করা হয়েছে(-)</td>
                                <td class="tg-031e v_field" id="r_curr_m_delivered_1"></td>
                                <td class="tg-031e v_field" id="r_curr_m_delivered_2"></td>
                                <td class="tg-031e v_field" id="r_curr_m_delivered_3"></td>
                                <td class="tg-031e v_field" id="r_curr_m_delivered_4"></td>
                                <td class="tg-031e v_field" id="r_curr_m_delivered_5"></td>
                                <td class="tg-031e v_field" id="r_curr_m_delivered_6"></td>
                                <td class="tg-031e v_field" id="r_curr_m_delivered_7"></td>
                                <td class="tg-031e v_field" id="r_curr_m_delivered_8"></td>
                                <td class="tg-031e v_field" id="r_curr_m_delivered_9"></td>
                            </tr>
                            <tr  style="text-align: center;">
                                <td class="tg-031e" colspan="2" style="text-align: left;">অবশিষ্ট<br></td>
                                <td class="tg-031e v_field" id="r_remaining_1"></td>
                                <td class="tg-031e v_field" id="r_remaining_2"></td>
                                <td class="tg-031e v_field" id="r_remaining_3"></td>
                                <td class="tg-031e v_field" id="r_remaining_4"></td>
                                <td class="tg-031e v_field" id="r_remaining_5"></td>
                                <td class="tg-031e v_field" id="r_remaining_6"></td>
                                <td class="tg-031e v_field" id="r_remaining_7"></td>
                                <td class="tg-031e v_field" id="r_remaining_8"></td>
                                <td class="tg-031e v_field" id="r_remaining_9"></td>
                            </tr>
                            <tr style="text-align: center;">
                                <td class="tg-031e" colspan="2" style="text-align: left;">চলতি মাসে কখনও মওজুদ শূণ্যতা হয়ে থাকলে কারণ (কোড) লিখুন <br></td>
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
                    </div> <!--End Table Responsive(LMIS)-->

                    <div class="table-responsive">
                        <table border="0"  style="table-layout: fixed; width: 100%;border:0px solid white!important;" class="table-responsive">
                            <tr>
                                <td style="text-align:center;border:none!important;"><br>
                                    মওজুদ শূন্যতার কোডঃ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    <span style="border: 1px solid black;padding-left: 5px;padding-right: 5px;">ক</span>&nbsp;সরবরাহ পাওয়া যায়নি<span id=''></span>    
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <span style="border: 1px solid black;padding-left: 5px;padding-right: 5px;">খ</span>&nbsp;অপর্যাপ্ত সরবরাহ<span id=''></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;  <span style="border: 1px solid black;padding-left: 5px;padding-right: 5px;">গ</span>&nbsp;হঠাৎ চাহিদা বৃদ্ধি পাওয়া<span id=''></span> 
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <span style="border: 1px solid black;padding-left: 5px;padding-right: 5px;">ঘ</span>&nbsp;অন্যান্য<span id=''></span>
                                </td>
                            </tr>
                        </table>
                    </div>


                </div>
            </div>    
        </div>
    </div>        
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>