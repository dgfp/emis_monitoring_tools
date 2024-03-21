<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeaderWithoutSidebar.jspf" %>
<!--<script src="resources/js/area_dropdown_control_by_user_mis1_bangla.js"></script>-->
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla.js"></script>
<script src="resources/js/mis1TabResponsive.js" type="text/javascript"></script>
<style>

    table, th, td {
        border: 1px solid black;
        border-collapse: collapse;
    }
    th, td {
        padding: 5px;
        text-align: left;
        margin-left: 12px;
    }
    .center{
        text-align:center;
    }
    .rotate{
        -ms-transform:rotate(270deg); 
        -moz-transform:rotate(270deg);  
        -webkit-transform:rotate(270deg);  
        -o-transform:rotate(270deg);  
    }
    @font-face {
        font-family: NikoshBAN;
        src: url('resources/fonts/NikoshBAN.ttf');
    }
    .visited{
        font-weight: bold;
        text-align: center;
        font-family: NikoshBAN;
        font-size: 17px;
    }
    .table-responsive>.row{
        width:1650px;
    }
    .blank{
        font-family: NikoshBAN;
        font-size: 17px;
    }
</style>

<script>
    function getLastDayOfSelectedMonth(month,year){
        var date = new Date(year,month,1);
        var lastDay  = new Date(date.getFullYear(), date.getMonth(), 0);
        /*var currFirst=year+"-"+currMonth+"-"+"01";
        var currLast=year+"-"+currMonth+"-"+currLastDay.getDate();*/
        return lastDay.getDate();
    }

    $(document).ready(function () {

        $('#showdataButton').click(function () {
            
            $('.visited').html("  "); //reset all text value field.
            $('.blank').html("  "); //reset all text value field.
            
            if( $("select#division").val()===""){
	toastr["error"]("<h4><b>বিভাগ সিলেক্ট করুন </b></h4>");
	
            }else if( $("select#district").val()===""){
                    toastr["error"]("<h4><b>জেলা সিলেক্ট করুন </b></h4>");

            }else if( $("select#upazila").val()===""){
                    toastr["error"]("<h4><b>উপজেলা সিলেক্ট করুন</b></h4>");

            }else if( $("select#union").val()===""){
                    toastr["error"]("<h4><b>ইউনিয়ন সিলেক্ট করুন</b></h4>");

            }else if( $("select#unit").val()===""){
                    toastr["error"]("<h4><b>ইউনিট সিলেক্ট করুন</b></h4>");

            }else if( $("select#provCode").val()===""){
                    toastr["error"]("<h4><b>প্রোভাইডার সিলেক্ট করুন</b></h4>");

            }else{
                        var month= $("select#month").val();
                        var year = $("#year").val() ;
                        var lastDayOfSelectedMonth=getLastDayOfSelectedMonth(month,year);
                        var btn = $(this).button('loading');
                        $.ajax({
                        url: "epiperreport",
                        data: {
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            fwaUnit: $("select#unit").val(),
                            provCode: $("select#provCode").val(),
                            month: $("select#month").val(),
                            year: $("#year").val()
                        },
                        type: 'POST',
                        success: function (result) {
                            btn.button('reset');
                            var data = JSON.parse(result);
                            var json=data.First;
                            var jsonBottom=data.Second;
                            
                            if (json.length === 0) {
                                toastr["error"]("<h4><b>কোন ডাটা পাওয়া যায়নি</b></h4>");
                                return;
                            }
                            
 //--------------------First Table - Added initial part------------------------------------------------------------------------------------------------------------------------------
                            $('#visitMonthColumn').html('<td colspan="4" class="center">পরিদর্শনের তারিখ ( দিন ও মাস লিখুন )</td>'); //first
                            //Pill--------------------------------------------------------------------------------------------------
                            $('#r_pill_old').html('<td  rowspan="32">পরিবার পরিকল্পনা পদ্ধতি গ্রহণ সংক্রান্ত তথ্যের হিসাব</td>'
                                                            +'<td rowspan="5" class="rotate center">খাবার বড়ি</td>'
                                                            +'<td colspan="2">পুরাতন</td>');//second
                            $('#r_pill_new').html('<td colspan="2">নতুন</td>');//third
                            $('#r_pill_total').html('<td colspan="2">মোট</td>');//fourth
                            $('#r_pill_left_no_method').html('<td rowspan="2" colspan="1">ছেড়ে দিয়েছে</td>'
                                                                        +'<td colspan="1">কোন পদ্ধতি নেয়নি</td>');//fifth
                            $('#r_pill_left_oth_method').html('<td colspan="1">অন্য পদ্ধতি নিয়েছে</td>');//sixth
                            //Condom--------------------------------------------------------------------------------------------------
                            $('#r_condom_old').html('<td rowspan="5" class="rotate center">কনডম</td>'
                                                                        +'<td colspan="2">পুরাতন</td>');//Seventh
                            $('#r_condom_new').html('<td colspan="2">নতুন</td>');//eighth
                            $('#r_condom_total').html('<td colspan="2">মোট</td>');//ninth
                            $('#r_condom_left_no_method').html('<td rowspan="2" >ছেড়ে দিয়েছে</td>'
                                                                                +'<td>কোন পদ্ধতি নেয়নি</td>');//tenth
                            $('#r_condom_left_oth_method').html('<td>অন্য পদ্ধতি নিয়েছে</td>');//
                            //Injectable--------------------------------------------------------------------------------------------------
                            $('#r_injectable_old').html('<td rowspan="5" class="rotate center">ইনজেকটেবল</td>'
                                                                    +'<td colspan="2">পুরাতন</td>');//twelfth
                            $('#r_injectable_new').html('<td colspan="2">নতুন</td>');//13
                            $('#r_injectable_total').html('<td colspan="2">মোট</td>');//14
                            $('#r_injectable_left_no_method').html('<td rowspan="2" colspan="1">ছেড়ে দিয়েছে</td>'
                                                                            +'<td colspan="1">কোন পদ্ধতি নেয়নি</td>');//15
                            $('#r_injectable_left_oth_method').html('<td>অন্য পদ্ধতি নিয়েছে</td>');//16
                            //iud--------------------------------------------------------------------------------------------------
                            $('#r_iud_old').html('<td rowspan="5" class="rotate center">আই ইউ ডি</td>'
                                                        +'<td colspan="2">পুরাতন</td>'); //17
                            $('#r_iud_new').html('<td colspan="2">নতুন</td>');//18
                            $('#r_iud_total').html('<td colspan="2">মোট</td>');//19
                            $('#r_iud_left_no_method').html('<td rowspan="2" >ছেড়ে দিয়েছে</td>'
                                                                            +'<td>কোন পদ্ধতি নেয়নি</td>');//20
                            $('#r_iud_left_oth_method').html('<td>অন্য পদ্ধতি নিয়েছে</td>');//21
                            //implant--------------------------------------------------------------------------------------------------
                            $('#r_implant_old').html('<td rowspan="5" class="rotate center">ইমপ্ল্যান্ট</td>'
                                                        +'<td colspan="2">পুরাতন</td>'); //17
                            $('#r_implant_new').html('<td colspan="2">নতুন</td>');//18
                            $('#r_implant_total').html('<td colspan="2">মোট</td>');//19
                            $('#r_implant_left_no_method').html('<td rowspan="2" >ছেড়ে দিয়েছে</td>'
                                                                            +'<td>কোন পদ্ধতি নেয়নি</td>');//20
                            $('#r_implant_left_oth_method').html('<td>অন্য পদ্ধতি নিয়েছে</td>');//21
                            //permanent--------------------------------------------------------------------------------------------------
                            $('#r_permanent_man_old').html('<td rowspan="6" class="rotate center">স্থায়ী পদ্ধতি</td>'
                                                                            +'<td rowspan="3">পুরুষ</td>'
                                                                            +'<td >পুরাতন</td>'); 
                            $('#r_permanent_man_new').html('<td>নতুন</td>');
                            $('#r_permanent_man_total').html('<td>মোট</td>');
                            $('#r_permanent_woman_old').html('<td rowspan="3" >মহিলা</td>'
                                                                                    +'<td >পুরাতন</td>');
                            $('#r_permanent_woman_new').html('<td>নতুন</td>');
                            $('#r_permanent_woman_total').html('<td>মোট</td>');
                            //First bottom part---------------------------------------------------------------------------------------------------
                            $('#r_first_total').html('<td colspan="3" class="center">সর্বমোট</td>');
                            $('#r_unit_capable_elco_tot').html('<td colspan="4" class="center">মোট সক্ষম দম্পতির সংখ্যা</td>');
                            
//---------------------Second Table Content goes Here-------------------------------------------------------------------------------
                            //Pregnant Woman
                            $('#r_preg_new_fwa').html('<td colspan="3" rowspan="3" class="center">গর্ভবতী মহিলার সংখ্যা</td>'
                                                                    +'<td>নতুন</td>');
                            $('#r_preg_old_fwa').html('<td>পুরাতন</td>');
                            $('#r_preg_fwa_total').html('<td>মোট</td>');
                            //Send
                            $('#r_ref_risky_preg_cnt_fwa').html('<td  rowspan="3" class="rotate center">প্রেরণ</td>'
                                                                                +'<td colspan="3">রেফারকৃত ঝুঁকিপূর্ণ / জটিল গর্ভবতীর সংখ্যা</td>');
                            $('#r_send_method').html('<td colspan="3">পদ্ধতি নেয়ার জন্য</td>');
                            $('#r_sent_side_effect').html('<td colspan="3">পার্শ্ব-প্রতিক্রিয়ার জন্য</td>');
                            //Nutrition
                            $('#r_mothernutrition').html('<td  rowspan="2" class="rotate center">পুষ্টি</td>'
                                                                        +'<td colspan="3">মা</td>');
                            $('#r_childnutrition').html('<td colspan="3">শিশু</td>');
                            //Other
                            $('#r_child_0_to_less_then_60mon').html('<td colspan="4">শিশু (০-৫) বৎসরের নিচে সেবা (সংখ্যা) </td>');
                            $('#r_teenager_health_care').html('<td  colspan="4"> কিশোর কিশোরীদের স্বাস্থ্য সেবা (সংখ্যা)</td>');
                            
//---------------------LMIS Table Content goes Here----------------------------------------------------------------------------------
                            //Pill
                            $('#r_pill_shukhi').html('<td rowspan="18">বিতরণ</td>'
                                                                +'<td rowspan="3" colspan="2">খাবার  বড়ি (চক্র)</td>'
                                                                +'<td>সুখী</td>');
                            $('#r_pill_apan').html('<td>আপন</td>');
                            //Condom 
                            $('#r_condom').html('<td colspan="3">কনডম (পিস)</td>');
                            //Injectable
                            $('#r_injectable_vial').html('<td rowspan="3" colspan="2">ইনজেকটেবল</td>'
                                                                    +'<td>ভায়াল</td>');
                            $('#r_injectable_syring').html('<td >এডি সিরিঞ্জ</td>');
                            //Other
                            $('#r_ecp').html('<td colspan="3">অন্যান্য/ইসিপি (ডোজ)</td>');
                            $('#r_misoprostol').html('<td colspan="3">মিসোপ্রোস্টল (ডোজ)</td>');
                            $('#r_sasat').html('<td colspan="3">ভিটামিন- মেনারেল পাউডার (স্যারেট)</td>');
                            $('#r_iron_folic_acid').html('<td colspan="3">আয়রন ও ফলিক  এসিড (সংখ্যা)</td>');
                            $('#comments').html('<td colspan="4">এফ পি আই এর মন্তব্য ও স্বাক্ষর </td>');
              
                            //Sum variables------------------------------------------------------------------------------------------------------
                            var r_pill_old_total_=0, r_pill_new_total_=0, r_pill_total_total_=0, r_pill_left_no_method_total_=0, r_pill_left_oth_method_total_=0;
                            var r_condom_old_total_=0, r_condom_new_total_=0, r_condom_total_total_=0, r_condom_left_no_method_total_=0, r_condom_left_oth_method_total_=0;
                            var r_injectable_old_total_=0, r_injectable_new_total_=0, r_injectable_total_total_=0, r_injectable_left_no_method_total_=0, r_injectable_left_oth_method_total_=0;
                            var r_iud_old_total_=0, r_iud_new_total_=0, r_iud_total_total_=0, r_iud_left_no_method_total_=0, r_iud_left_oth_method_total_=0;
                            var r_implant_old_total_=0, r_implant_new_total_=0, r_implant_total_total_=0, r_implant_left_no_method_total_=0, r_implant_left_oth_method_total_=0;
                            var r_permanent_man_old_total_ = 0, r_permanent_man_new_total_ = 0, r_permanent_man_total_total_= 0, r_permanent_woman_old_total_ = 0, r_permanent_woman_new_total_ = 0, r_permanent_woman_total_total_ = 0;  
                            var r_first_total_total_=0, r_unit_capable_elco_tot_total_ = 0;
                            var r_preg_new_fwa_total_ = 0, r_preg_old_fwa_total_ = 0, r_preg_fwa_total_total_ = 0;
                            var r_ref_risky_preg_cnt_fwa_total_ = 0, r_send_method_total_ = 0, r_sent_side_effect_total_ = 0;
                            var r_mothernutrition_total_ = 0, r_childnutrition_total_ = 0;
                            var r_child_0_to_less_then_60mon_total_ = 0, r_teenager_health_care_total_ = 0;
                            var r_pill_shukhi_total_ = 0, r_pill_apan_total_=0, r_condom_total_=0;
                            var r_injectable_vial_total_=0,r_injectable_syring_total_=0;
                            var r_ecp_total_=0, r_misoprostol_total_=0, r_sasat_total_=0, r_iron_folic_acid_total_=0;
                            
                            //Main Data assignment logic into Table
                            for(var i = 1; i <= lastDayOfSelectedMonth; i++){
                                var index=0,allTotal=0; //track json index
                                var hasVisit=false; //retrun is existing date any value
                                
                                for (var j = 0; j < json.length; j++) {
                                    //console.log("index:"+i+" Value "+json[j].r_vdate +"2017-06-"+i);
                                    var day=i;
                                    if(i<10){
                                        day = "0"+i;
                                    }
                                    if(json[j].r_vdate === year+"-"+month+"-"+day ){
                                        hasVisit=true;
                                        index = j;
                                        break;
                                        
                                    }
                                }
                                
                                if(hasVisit){
                                    //Sum------------------------------------------------------------------------------------------------------------
                                    allTotal=json[index].r_pill_old + json[index].r_pill_new + json[index].r_pill_total + json[index].r_pill_left_no_method + json[index].r_pill_left_oth_method + json[index].r_condom_old + json[index].r_condom_new + json[index].r_condom_total + json[index].r_condom_left_no_method + json[index].r_condom_left_oth_method + json[index].r_injectable_old + json[index].r_injectable_new + json[index].r_injectable_total + json[index].r_injectable_left_no_method + json[index].r_injectable_left_oth_method + json[index].r_iud_old + json[index].r_iud_new + json[index].r_iud_total + json[index].r_iud_left_no_method + json[index].r_iud_left_oth_method + json[index].r_implant_old + json[index].r_implant_new + json[index].r_implant_total + json[index].r_implant_left_no_method + json[index].r_implant_left_oth_method + json[index].r_permanent_man_old + json[index].r_permanent_man_new + json[index].r_permanent_man_total + json[index].r_permanent_woman_old + json[index].r_permanent_woman_new + json[index].r_permanent_woman_total;      
                                    //Pill
                                    r_pill_old_total_ = r_pill_old_total_ + json[index].r_pill_old;
                                    r_pill_new_total_ = r_pill_new_total_ + json[index].r_pill_new;
                                    r_pill_total_total_ = r_pill_total_total_ +  json[index].r_pill_total;
                                    r_pill_left_no_method_total_ = r_pill_left_no_method_total_ + json[index].r_pill_left_no_method;
                                    r_pill_left_oth_method_total_ = r_pill_left_oth_method_total_ + json[index].r_pill_left_oth_method;
                                    //Condom
                                    r_condom_old_total_ = r_condom_old_total_ + json[index].r_condom_old;
                                    r_condom_new_total_ = r_condom_new_total_ + json[index].r_condom_new;
                                    r_condom_total_total_ = r_condom_total_total_ +  json[index].r_condom_total;
                                    r_condom_left_no_method_total_ = r_condom_left_no_method_total_ + json[index].r_condom_left_no_method;
                                    r_condom_left_oth_method_total_ = r_condom_left_oth_method_total_ + json[index].r_condom_left_oth_method;
                                    //injectable
                                    r_injectable_old_total_ = r_injectable_old_total_ + json[index].r_injectable_old;
                                    r_injectable_new_total_ = r_injectable_new_total_ + json[index].r_injectable_new;
                                    r_injectable_total_total_ = r_injectable_total_total_ +  json[index].r_injectable_total;
                                    r_injectable_left_no_method_total_ = r_injectable_left_no_method_total_ + json[index].r_injectable_left_no_method;
                                    r_injectable_left_oth_method_total_ = r_injectable_left_oth_method_total_ + json[index].r_injectable_left_oth_method;
                                    //iud
                                    r_iud_old_total_ = r_iud_old_total_ + json[index].r_iud_old;
                                    r_iud_new_total_ = r_iud_new_total_ + json[index].r_iud_new;
                                    r_iud_total_total_ = r_iud_total_total_ +  json[index].r_iud_total;
                                    r_iud_left_no_method_total_ = r_iud_left_no_method_total_ + json[index].r_iud_left_no_method;
                                    r_iud_left_oth_method_total_ = r_iud_left_oth_method_total_ + json[index].r_iud_left_oth_method;
                                    //implant
                                    r_implant_old_total_ = r_implant_old_total_ + json[index].r_implant_old;
                                    r_implant_new_total_ = r_implant_new_total_ + json[index].r_implant_new;
                                    r_implant_total_total_ = r_implant_total_total_ +  json[index].r_implant_total;
                                    r_implant_left_no_method_total_ = r_implant_left_no_method_total_ + json[index].r_implant_left_no_method;
                                    r_implant_left_oth_method_total_ = r_implant_left_oth_method_total_ + json[index].r_implant_left_oth_method;
                                    //permanent
                                    r_permanent_man_old_total_ = r_permanent_man_old_total_ + json[index].r_permanent_man_old;
                                    r_permanent_man_new_total_ = r_permanent_man_new_total_ + json[index].r_permanent_man_new;
                                    r_permanent_man_total_total_ = r_permanent_man_total_total_ + json[index].r_permanent_man_total;
                                    r_permanent_woman_old_total_ = r_permanent_woman_old_total_ + json[index].r_permanent_woman_old;
                                    r_permanent_woman_new_total_ = r_permanent_woman_new_total_ + json[index].r_permanent_woman_new;
                                    r_permanent_woman_total_total_ = r_permanent_woman_total_total_ + json[index].r_permanent_woman_total;
                                    //Bottom Part
                                    r_first_total_total_ = r_first_total_total_ + allTotal;
                                    r_unit_capable_elco_tot_total_ = r_unit_capable_elco_tot_total_ + json[index].r_unit_capable_elco_tot;
                                    //Pregnant woman
                                    r_preg_new_fwa_total_ = r_preg_new_fwa_total_ + json[index].r_preg_new_fwa;
                                    r_preg_old_fwa_total_ = r_preg_old_fwa_total_ + json[index].r_preg_old_fwa;
                                    r_preg_fwa_total_total_ = r_preg_fwa_total_total_ + json[index].r_preg_fwa_total;
                                    //send
                                    r_ref_risky_preg_cnt_fwa_total_ = r_ref_risky_preg_cnt_fwa_total_ + json[index].r_ref_risky_preg_cnt_fwa;
                                    r_send_method_total_ = r_send_method_total_ + json[index].r_send_method;
                                    r_sent_side_effect_total_ = r_sent_side_effect_total_ + json[index].r_sent_side_effect;
                                    //Nutrition
                                    r_mothernutrition_total_ = r_mothernutrition_total_ + json[index].r_mothernutrition;
                                    r_childnutrition_total_ = r_childnutrition_total_ + json[index].r_childnutrition;
                                    //Oher
                                    r_child_0_to_less_then_60mon_total_ = r_child_0_to_less_then_60mon_total_ + json[index].r_child_0_to_less_then_60mon;
                                    r_teenager_health_care_total_ = r_teenager_health_care_total_ + json[index].r_teenager_health_care;   
                                    //Pill
                                    r_pill_shukhi_total_ = r_pill_shukhi_total_ + json[index].r_pill_shukhi;
                                    r_pill_apan_total_ = r_pill_apan_total_ + json[index].r_pill_apan;
                                    //Condom
                                    r_condom_total_ = r_condom_total_ + json[index].r_condom;
                                    //Injectatble
                                    r_injectable_vial_total_ = r_injectable_vial_total_ + json[index].r_injectable_vial;
                                    r_injectable_syring_total_ = r_injectable_syring_total_ + json[index].r_injectable_syring;
                                    //Other
                                    r_ecp_total_ = r_ecp_total_ + json[index].r_ecp;
                                    r_misoprostol_total_ = r_misoprostol_total_ + json[index].r_misoprostol;
                                    r_sasat_total_ = r_sasat_total_ + json[index].r_sasat;
                                    r_iron_folic_acid_total_ = r_iron_folic_acid_total_ + json[index].r_iron_folic_acid;
                                    //End Sumation Part
                                    
                                    //Data assignment here--------------------------------------------------------------------------------------
                                    $('#visitMonthColumn').append('<td class="visited">'+day+'</td>');
                                    //pill--------------------------------------------------------------------------------------------------
                                    $('#r_pill_old').append('<td class="visited">'+json[index].r_pill_old+'</td>');
                                    $('#r_pill_new').append('<td class="visited">'+json[index].r_pill_new+'</td>');
                                    $('#r_pill_total').append('<td class="visited">'+json[index].r_pill_total+'</td>');
                                    $('#r_pill_left_no_method').append('<td class="visited">'+json[index].r_pill_left_no_method+'</td>');
                                    $('#r_pill_left_oth_method').append('<td class="visited">'+json[index].r_pill_left_oth_method+'</td>');
                                    //condom--------------------------------------------------------------------------------------------------
                                    $('#r_condom_old').append('<td class="visited">'+json[index].r_condom_old+'</td>');
                                    $('#r_condom_new').append('<td class="visited">'+json[index].r_condom_new+'</td>');
                                    $('#r_condom_total').append('<td class="visited">'+json[index].r_condom_total+'</td>');
                                    $('#r_condom_left_no_method').append('<td class="visited">'+json[index].r_condom_left_no_method+'</td>');
                                    $('#r_condom_left_oth_method').append('<td class="visited">'+json[index].r_condom_left_oth_method+'</td>');
                                    //injectable--------------------------------------------------------------------------------------------------
                                    $('#r_injectable_old').append('<td class="visited">'+json[index].r_injectable_old+'</td>');
                                    $('#r_injectable_new').append('<td class="visited">'+json[index].r_injectable_new+'</td>');
                                    $('#r_injectable_total').append('<td class="visited">'+json[index].r_injectable_total+'</td>');
                                    $('#r_injectable_left_no_method').append('<td class="visited">'+json[index].r_injectable_left_no_method+'</td>');
                                    $('#r_injectable_left_oth_method').append('<td class="visited">'+json[index].r_injectable_left_oth_method+'</td>');
                                    //iud--------------------------------------------------------------------------------------------------
                                    $('#r_iud_old').append('<td class="visited">'+json[index].r_iud_old+'</td>');
                                    $('#r_iud_new').append('<td class="visited">'+json[index].r_iud_new+'</td>');
                                    $('#r_iud_total').append('<td class="visited">'+json[index].r_iud_total+'</td>');
                                    $('#r_iud_left_no_method').append('<td class="visited">'+json[index].r_iud_left_no_method+'</td>');
                                    $('#r_iud_left_oth_method').append('<td class="visited">'+json[index].r_iud_left_oth_method+'</td>');
                                    //implant--------------------------------------------------------------------------------------------------
                                    $('#r_implant_old').append('<td class="visited">'+json[index].r_implant_old+'</td>');
                                    $('#r_implant_new').append('<td class="visited">'+json[index].r_implant_new+'</td>');
                                    $('#r_implant_total').append('<td class="visited">'+json[index].r_implant_total+'</td>');
                                    $('#r_implant_left_no_method').append('<td class="visited">'+json[index].r_implant_left_no_method+'</td>');
                                    $('#r_implant_left_oth_method').append('<td class="visited">'+json[index].r_implant_left_oth_method+'</td>');
                                    //permanent--------------------------------------------------------------------------------------------------
                                    $('#r_permanent_man_old').append('<td class="visited">'+json[index].r_permanent_man_old+'</td>');
                                    $('#r_permanent_man_new').append('<td class="visited">'+json[index].r_permanent_man_new+'</td>');
                                    $('#r_permanent_man_total').append('<td class="visited">'+json[index].r_permanent_man_total+'</td>');
                                    $('#r_permanent_woman_old').append('<td class="visited">'+json[index].r_permanent_woman_old+'</td>');
                                    $('#r_permanent_woman_new').append('<td class="visited">'+json[index].r_permanent_woman_new+'</td>');
                                    $('#r_permanent_woman_total').append('<td class="visited">'+json[index].r_permanent_woman_total+'</td>');
                                    //First bottom part (Total sum submission)---------------------------------------------------------------------------------------------------
                                    $('#r_first_total').append('<td class="visited">'+allTotal+'</td>');
                                    $('#r_unit_capable_elco_tot').append('<td class="visited">'+json[index].r_unit_capable_elco_tot+'</td>');
                                    //Pregnant Woman---------------------------------------------------------------------------------------------------
                                    $('#r_preg_new_fwa').append('<td class="visited">'+json[index].r_preg_new_fwa+'</td>');
                                    $('#r_preg_old_fwa').append('<td class="visited">'+json[index].r_preg_old_fwa+'</td>');
                                    $('#r_preg_fwa_total').append('<td class="visited">'+json[index].r_preg_fwa_total+'</td>');
                                    //Send------------------------------------------------------------------------------------------------------------------
                                    $('#r_ref_risky_preg_cnt_fwa').append('<td class="visited">'+json[index].r_ref_risky_preg_cnt_fwa+'</td>');
                                    $('#r_send_method').append('<td class="visited">'+json[index].r_send_method+'</td>');
                                    $('#r_sent_side_effect').append('<td class="visited">'+json[index].r_sent_side_effect+'</td>');
                                    //Nutrition---------------------------------------------------------------------------------------------------------------
                                    $('#r_mothernutrition').append('<td class="visited">'+json[index].r_mothernutrition+'</td>');
                                    $('#r_childnutrition').append('<td class="visited">'+json[index].r_childnutrition+'</td>');
                                    //Other------------------------------------------------------------------------------------------------------------------
                                    $('#r_child_0_to_less_then_60mon').append('<td class="visited">'+json[index].r_child_0_to_less_then_60mon+'</td>');
                                    $('#r_teenager_health_care').append('<td class="visited">'+json[index].r_teenager_health_care+'</td>');
                                    //Pill sukhi---------------------------------------------------------------------------------------------------------------
                                    $('#r_pill_shukhi').append('<td class="visited">'+json[index].r_pill_shukhi+'</td>');
                                    $('#r_pill_apan').append('<td class="visited">'+json[index].r_pill_apan+'</td>');
                                    //Condom---------------------------------------------------------------------------------------------------------------
                                    $('#r_condom').append('<td class="visited">'+json[index].r_condom+'</td>');
                                    //Injectable---------------------------------------------------------------------------------------------------------------
                                    $('#r_injectable_vial').append('<td class="visited">'+json[index].r_injectable_vial+'</td>');
                                    $('#r_injectable_syring').append('<td class="visited">'+json[index].r_injectable_syring+'</td>');
                                    //Other---------------------------------------------------------------------------------------------------------------
                                    $('#r_ecp').append('<td class="visited">'+json[index].r_ecp+'</td>');
                                    $('#r_misoprostol').append('<td class="visited">'+json[index].r_misoprostol+'</td>');
                                    $('#r_sasat').append('<td class="visited">'+json[index].r_sasat+'</td>');
                                    $('#r_iron_folic_acid').append('<td class="visited">'+json[index].r_iron_folic_acid+'</td>');
                                    $('#comments').append('<td></td>');
                                    
                                }else{
                                    
                                    $('#visitMonthColumn').append('<td class="center blank">'+day+'</td>');
                                    //pill--------------------------------------------------------------------------------------------------
                                    $('#r_pill_old').append('<td class="center blank">-</td>');
                                    $('#r_pill_new').append('<td class="center blank">-</td>');
                                    $('#r_pill_total').append('<td class="center blank">-</td>');
                                    $('#r_pill_left_no_method').append('<td class="center blank">-</td>');    
                                    $('#r_pill_left_oth_method').append('<td class="center blank">-</td>');
                                    //Condom--------------------------------------------------------------------------------------------------                                   
                                    $('#r_condom_old').append('<td class="center blank">-</td>');
                                    $('#r_condom_new').append('<td class="center blank">-</td>');
                                    $('#r_condom_total').append('<td class="center blank">-</td>');
                                    $('#r_condom_left_no_method').append('<td class="center blank">-</td>');
                                    $('#r_condom_left_oth_method').append('<td class="center blank">-</td>');
                                    //Injectatble--------------------------------------------------------------------------------------------------
                                    $('#r_injectable_old').append('<td class="center blank">-</td>');
                                    $('#r_injectable_new').append('<td class="center blank">-</td>');
                                    $('#r_injectable_total').append('<td class="center blank">-</td>');
                                    $('#r_injectable_left_no_method').append('<td class="center blank">-</td>');
                                    $('#r_injectable_left_oth_method').append('<td class="center blank">-</td>');
                                    //iud--------------------------------------------------------------------------------------------------
                                    $('#r_iud_old').append('<td class="center blank">-</td>');
                                    $('#r_iud_new').append('<td class="center blank">-</td>');
                                    $('#r_iud_total').append('<td class="center blank">-</td>');
                                    $('#r_iud_left_no_method').append('<td class="center blank">-</td>');
                                    $('#r_iud_left_oth_method').append('<td class="center blank">-</td>');
                                    //implant--------------------------------------------------------------------------------------------------
                                    $('#r_implant_old').append('<td class="center blank">-</td>');
                                    $('#r_implant_new').append('<td class="center blank">-</td>');
                                    $('#r_implant_total').append('<td class="center blank">-</td>');
                                    $('#r_implant_left_no_method').append('<td class="center blank">-</td>');
                                    $('#r_implant_left_oth_method').append('<td class="center blank">-</td>');
                                    //permanent--------------------------------------------------------------------------------------------------
                                    $('#r_permanent_man_old').append('<td class="center blank">-</td>');
                                    $('#r_permanent_man_new').append('<td class="center blank">-</td>');
                                    $('#r_permanent_man_total').append('<td class="center blank">-</td>');
                                    $('#r_permanent_woman_old').append('<td class="center blank">-</td>');
                                    $('#r_permanent_woman_new').append('<td class="center blank">-</td>');
                                    $('#r_permanent_woman_total').append('<td class="center blank">-</td>');
                                    //First bottom part---------------------------------------------------------------------------------------------------
                                    $('#r_first_total').append('<td class="center blank">-</td>');
                                    $('#r_unit_capable_elco_tot').append('<td class="center blank">-</td>');
                                    //Pregnant Woman---------------------------------------------------------------------------------------------------
                                    $('#r_preg_new_fwa').append('<td class="center blank">-</td>');
                                    $('#r_preg_old_fwa').append('<td class="center blank">-</td>');
                                    $('#r_preg_fwa_total').append('<td class="center blank">-</td>');
                                    //Send------------------------------------------------------------------------------------------------------------------
                                    $('#r_ref_risky_preg_cnt_fwa').append('<td class="center blank">-</td>');
                                    $('#r_send_method').append('<td class="center blank">-</td>');
                                    $('#r_sent_side_effect').append('<td class="center blank">-</td>');
                                    //Nutrition---------------------------------------------------------------------------------------------------------------
                                    $('#r_mothernutrition').append('<td class="center blank">-</td>');
                                    $('#r_childnutrition').append('<td class="center blank">-</td>');
                                    //Other------------------------------------------------------------------------------------------------------------------
                                    $('#r_child_0_to_less_then_60mon').append('<td class="center blank">-</td>');
                                    $('#r_teenager_health_care').append('<td class="center blank">-</td>');
                                    //Pill------------------------------------------------------------------------------------------------------------------
                                    $('#r_pill_shukhi').append('<td class="center blank">-</td>');
                                    $('#r_pill_apan').append('<td class="center blank">-</td>');
                                    //condom------------------------------------------------------------------------------------------------------------------
                                    $('#r_condom').append('<td class="center blank">-</td>');
                                    //Injectable------------------------------------------------------------------------------------------------------------------
                                    $('#r_injectable_vial').append('<td class="center blank">-</td>');
                                    $('#r_injectable_syring').append('<td class="center blank">-</td>');
                                    //other--------------------------------------------------------------------------------------------------
                                    $('#r_ecp').append('<td class="center blank">-</td>');
                                    $('#r_misoprostol').append('<td class="center blank">-</td>');
                                    $('#r_sasat').append('<td class="center blank">-</td>');
                                    $('#r_iron_folic_acid').append('<td class="center blank">-</td>');
                                    $('#comments').append('<td></td>');
                                }
                                
                            }
                            
                            //Added last column---------------------------------------------------------------------------------------------------------------------------
                            var lastThreeColumn='<td></td>'
                                                                +'<td></td>'
                                                                +'<td></td>';
                            $('#visitMonthColumn').append('<td>সরকারি মোট</td>'
                                                                        +'<td>ক্রয়সূত্র মোট</td>'
                                                                        +'<td>সর্বমোট</td>'); //first
                            //pill--------------------------------------------------------------------------------------------------                                                               
                            $('#r_pill_old').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_pill_old_total_+'</td>'); //second
                            $('#r_pill_new').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_pill_new_total_+'</td>'); //third
                            $('#r_pill_total').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_pill_total_total_+'</td>'); //fourth
                            $('#r_pill_left_no_method').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_pill_left_no_method_total_+'</td>'); //fifth 
                            $('#r_pill_left_oth_method').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_pill_left_oth_method_total_+'</td>'); //sixth 
                            //condom--------------------------------------------------------------------------------------------------
                            $('#r_condom_old').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_condom_old_total_+'</td>'); 
                            $('#r_condom_new').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_condom_new_total_+'</td>'); 
                            $('#r_condom_total').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_condom_total_total_+'</td>'); 
                            $('#r_condom_left_no_method').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_condom_left_no_method_total_+'</td>'); 
                            $('#r_condom_left_oth_method').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_condom_left_oth_method_total_+'</td>'); 
                            //injectable--------------------------------------------------------------------------------------------------
                            $('#r_injectable_old').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_injectable_old_total_+'</td>'); 
                            $('#r_injectable_new').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_injectable_new_total_+'</td>'); 
                            $('#r_injectable_total').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_injectable_total_total_+'</td>'); 
                            $('#r_injectable_left_no_method').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_injectable_left_no_method_total_+'</td>'); 
                            $('#r_injectable_left_oth_method').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_injectable_left_oth_method_total_+'</td>'); 
                            //iud--------------------------------------------------------------------------------------------------
                            $('#r_iud_old').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_iud_old_total_+'</td>'); 
                            $('#r_iud_new').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_iud_new_total_+'</td>'); 
                            $('#r_iud_total').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_iud_total_total_+'</td>'); 
                            $('#r_iud_left_no_method').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_iud_left_no_method_total_+'</td>'); 
                            $('#r_iud_left_oth_method').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_iud_left_oth_method_total_+'</td>'); 
                            //implant--------------------------------------------------------------------------------------------------
                            $('#r_implant_old').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_implant_old_total_+'</td>'); 
                            $('#r_implant_new').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_implant_new_total_+'</td>'); 
                            $('#r_implant_total').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_implant_total_total_+'</td>'); 
                            $('#r_implant_left_no_method').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_implant_left_no_method_total_+'</td>'); 
                            $('#r_implant_left_oth_method').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_implant_left_oth_method_total_+'</td>'); 
                            //permanent--------------------------------------------------------------------------------------------------
                            $('#r_permanent_man_old').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_permanent_man_old_total_+'</td>'); 
                            $('#r_permanent_man_new').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_permanent_man_new_total_+'</td>'); 
                            $('#r_permanent_man_total').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_permanent_man_total_total_+'</td>'); 
                            $('#r_permanent_woman_old').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_permanent_woman_old_total_+'</td>'); 
                            $('#r_permanent_woman_new').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_permanent_woman_new_total_+'</td>'); 
                            $('#r_permanent_woman_total').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_permanent_woman_total_total_+'</td>'); 
                            var sum_unit_total = r_pill_total_total_ + r_condom_total_total_ + r_injectable_total_total_ + r_iud_total_total_+ r_implant_total_total_ + r_permanent_man_total_total_ + r_permanent_woman_total_total_ ;
                            //First bottom part---------------------------------------------------------------------------------------------------
                            $('#r_first_total').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_first_total_total_+'</td>'); 
                            $('#r_unit_capable_elco_tot').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_unit_capable_elco_tot_total_+'</td>');                             
                            //Pregnant Woman---------------------------------------------------------------------------------------------------
                            $('#r_preg_new_fwa').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_preg_new_fwa_total_+'</td>');  
                            $('#r_preg_old_fwa').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_preg_old_fwa_total_+'</td>');  
                            $('#r_preg_fwa_total').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_preg_fwa_total_total_+'</td>');  
                            //Send------------------------------------------------------------------------------------------------------------------
                            $('#r_ref_risky_preg_cnt_fwa').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_ref_risky_preg_cnt_fwa_total_+'</td>');  
                            $('#r_send_method').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_send_method_total_+'</td>');  
                            $('#r_sent_side_effect').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_sent_side_effect_total_+'</td>');  
                            //Nutrition--------------------------------------------------------------------------------------------------------------
                            $('#r_mothernutrition').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_mothernutrition_total_+'</td>');  
                            $('#r_childnutrition').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_childnutrition_total_+'</td>');  
                            //Other-----------------------------------------------------------------------------------------------------------------
                            $('#r_child_0_to_less_then_60mon').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_child_0_to_less_then_60mon_total_+'</td>');  
                            $('#r_teenager_health_care').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_teenager_health_care_total_+'</td>');
                                                        
                            //Pill---------------------------------------------------------------------------------------------------------------------
                            $('#r_pill_shukhi').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_pill_shukhi_total_+'</td>'); 
                                                        
                            $('#r_pill_apan').append('<td></td>'
                                                            +'<td></td>'
                                                            +'<td class="visited">'+r_pill_apan_total_+'</td>');       
                            //Condom-------------------------------------------------------------------------------------------------------------
                            $('#r_injectable_vial').append('<td></td>'
                                                            +'<td></td>'
                                                            +'<td class="visited">'+r_injectable_vial_total_+'</td>');
                            //Injectatble-------------------------------------------------------------------------------------------------------------
                            $('#r_condom').append('<td></td>'
                                                            +'<td></td>'
                                                            +'<td class="visited">'+r_condom_total_+'</td>');
                            $('#r_injectable_syring').append('<td></td>'
                                    +'<td></td>'
                                    +'<td class="visited">'+r_injectable_syring_total_+'</td>');
                            //Other--------------------------------------------------------------------------------------------------
                            $('#r_ecp').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_ecp_total_+'</td>'); 
                            $('#r_misoprostol').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_misoprostol_total_+'</td>'); 
                            $('#r_sasat').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_sasat_total_+'</td>'); 
                            $('#r_iron_folic_acid').append('<td></td>'
                                                                +'<td></td>'
                                                                +'<td class="visited">'+r_iron_folic_acid_total_+'</td>');
                            $('#comments').append('<td></td>'
                                                                    +'<td></td>'
                                                                    +'<td class="visited"></td>');
                                                        
                            //Bottom Part---------------------------------------------------------------------------------------------------------
                            //Count of Birth and Death
                            $('#r_tot_live_birth_fwa').html(jsonBottom[0].r_tot_live_birth_fwa);
                            $('#r_death_number_less_1yr_0to7days').html(jsonBottom[0].r_death_number_less_1yr_0to7days);
                            $('#r_death_number_less_1yr_8to28days').html(jsonBottom[0].r_death_number_less_1yr_8to28days);
                            $('#r_death_number_less_1yr_29dystoless1yr').html(jsonBottom[0].r_death_number_less_1yr_29dystoless1yr);
                            $('#r_death_number_1yrto5yr').html(jsonBottom[0].r_death_number_1yrto5yr);
                            $('#r_death_number_maternal_death').html(jsonBottom[0].r_death_number_maternal_death);
                            $('#r_death_number_other_death_fwa').html(jsonBottom[0].r_death_number_other_death_fwa);
                            $('#no_of_total_death').html(jsonBottom[0].r_death_number_less_1yr_0to7days + jsonBottom[0].r_death_number_less_1yr_8to28days + jsonBottom[0].r_death_number_less_1yr_29dystoless1yr + jsonBottom[0].r_death_number_1yrto5yr + jsonBottom[0].r_death_number_maternal_death + jsonBottom[0].r_death_number_other_death_fwa);
                            //Unit method
                            $('#r_method_curr_month').html(sum_unit_total);
                            $('#r_method_priv_month').html(jsonBottom[0].r_method_priv_month);
                            $('#r_method_unit_all_tot').html((jsonBottom[0].r_method_priv_month + sum_unit_total)); 
                            //$('#r_method_unit_all_tot').html(jsonBottom[0].r_method_unit_all_tot);
                            $('#r_curr_m_shown_capable_elco_tot').html(jsonBottom[0].r_curr_m_shown_capable_elco_tot);
                            $('#r_priv_m_shown_capable_elco_tot').html(jsonBottom[0].r_priv_m_shown_capable_elco_tot);
                            $('#r_unit_capable_elco_tot1').html(jsonBottom[0].r_unit_capable_elco_tot);
                            $('#r_preg_curr_month_fwa').html(jsonBottom[0].r_preg_curr_month_fwa);
                            $('#r_preg_priv_month_fwa').html(jsonBottom[0].r_preg_priv_month_fwa);
                            $('#r_preg_unit_tot_fwa').html(jsonBottom[0].r_preg_unit_tot_fwa); //unit_all_one
                            
                            //Get Car value
                            $('#unit_all_one').html((jsonBottom[0].r_method_priv_month + sum_unit_total)); 
                            //$('#unit_all_one').html(jsonBottom[0].r_method_unit_all_tot); 
                            $('#unit_all_two').html(jsonBottom[0].r_unit_capable_elco_tot);
                            //var car =Math.round(100 - (jsonBottom[0].r_method_unit_all_tot / jsonBottom[0].r_unit_capable_elco_tot) * 100);// ( jsonBottom[0].r_method_unit_all_tot / jsonBottom[0].r_unit_capable_elco_tot ) * 100; //Math.round(100 - (price / listprice) * 100);
                            $('#r_car').html(Number((((jsonBottom[0].r_method_priv_month + sum_unit_total) / jsonBottom[0].r_unit_capable_elco_tot) * 100).toFixed(2))+" %"); 
                            //$('#r_car').html(Number(((jsonBottom[0].r_method_unit_all_tot / jsonBottom[0].r_unit_capable_elco_tot) * 100).toFixed(2))+" %"); 
  
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>অনুরোধটি প্রক্রিয়াধীন করা যাচ্ছে না</b></h4>");
                        }
                    }); //End Ajax
                    
            } //else end
        }); // Show btn end

    });


</script>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1 id="pageTitle"><span style="color:#4fef2f;"><i class="fa fa-check-circle" aria-hidden="true"></i></span> Daily tally sheet for FWA</h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <%@include file="/WEB-INF/jspf/mis1AreaBangla.jspf" %>
    
     <!--------------------------------------------------------------------------------Data Table Goes Here-------------------------------------------------------------------------------->  
    <div class="box box-primary">
        <div class="box-header with-border">
            <div class="box-tools pull-right" style="margin-top: -10px;">
    <!--                    <button type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print</button>
                <button type="button" class="btn btn-box-tool"><i class="fa fa-file-pdf-o" aria-hidden="true"></i>&nbsp;PDF</button>-->
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                <button type="button" class="btn btn-box-tool btn-remove" data-widget="remove"><i class="fa fa-times"></i></button>
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
<!--                                <td  rowspan="32" class="rotate">পরিবার_পরিকল্পনা_পদ্ধতি_গ্রহণ_সংক্রান্ত_তথ্যের_হিসাব</td>-->
                                <td  rowspan="32" class="">পরিবার পরিকল্পনা পদ্ধতি গ্রহণ সংক্রান্ত তথ্যের হিসাব</td>
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
                        </table><br/>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-----------------------------------------------------------------End First Part---------------------------------------------------------->





        <div class="table-responsive">
<!--        <div  class="row">-->

            
 <!-----------------------------------------------------------------Kha---------------------------------------------------------->           
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-3" style="background-color:#f9f9f9;color:#e0e0e0;">
                        <br/>
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
                    <div class="col-md-3">   
                        <br/>
                        <p><strong>গ) জস্ম ও মৃত্যুর হিসাবঃ<br/> (মাসের শেষে পূরণ করুন)</strong></p>
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
                    <div class="col-md-3" style="background-color:#f9f9f9;color:#e0e0e0;">
                        <br/>
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
                        <div class="col-md-3">
                            <br/>
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
                        </table><br>
                        </div><!--End row-md-3-->
                        
                    </div><!--End Row-->
                    
                    <div class="row">
                        <div class="col-md-12">
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
                        </div>
                    </div>
                    
<!-----------------------------------------------------------------End First Part---------------------------------------------------------->
                    </div><!--End md-12-->
<!--            </div>-->
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

