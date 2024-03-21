<%-- 
    Document   : elcoCountChildAndAgeWise
    Created on : Sep 16, 2017, 11:53:07 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla.js"></script>
<style>
    .v-t {
            transform: rotate(270deg);
    }
    table, th, td {
        border: 1px solid black;
    }
    th, td {
        padding: 5px;
        text-align: center;
        
    }
    .tableTitle{
        font-family: SolaimanLipi;
        font-size: 20px;
    }
    table{
        font-family: SolaimanLipi;
        font-size: 13px;
    }

    @media print {
        .tableTitle{
            display: block;
            margin-top: -2px;
        }
        .reg-fwa-13{
            margin-top: -30px!important;
        }
        /*        @page {
                    size: A4 landscape;
                    margin: 10px;
                }*/
        .box{ border: 0}
        #areaPanel, #back-to-top, .box-header, .main-footer{
            display: none !important;
        }
    }
    [class*="col"] { margin-bottom: 10px; }
</style>

<script>
    $(document).ready(function () {
        
        $('#showdataButton').click(function () {
            //ElcoCountChildAndAgeWiseSetBlank();
            $('.v_field').html(""); //reset all text value field.
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
                var btn = $(this).button('loading');
                $.ajax({
                    url: "ElcoCountChildAndAgeWise",
                    data: {
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val(),
                        fwaUnit: $("select#unit").val(),
                        provCode: $("select#provCode").val(),
                        year: $("#year").val()
                    },
                    type: 'POST',
                    success: function (result) {
                        btn.button('reset');
                        var json = JSON.parse(result);

                        if (json.length === 0) {
                            toastr["error"]("<h4><b>কোন ডাটা পাওয়া যায়নি</b></h4>");
                            return;
                        }
                        //ElcoCountChildAndAgeWiseSetDash();
                        //Variabls for sum
                        //For Specific row total r_lessThan20_total_pill
                        var r_lessThan20_total_pill=0,r_20to29_total_pill=0,r_30to39_total_pill=0,r_40to49_total_pill=0; //For pill sum
                        var r_lessThan20_total_condom=0,r_20to29_total_condom=0,r_30to39_total_condom=0,r_40to49_total_condom=0; //For condom sum
                        var r_lessThan20_total_inject=0,r_20to29_total_inject=0,r_30to39_total_inject=0,r_40to49_total_inject=0; //For inject sum
                        var r_lessThan20_total_iud=0,r_20to29_total_iud=0,r_30to39_total_iud=0,r_40to49_total_iud=0; //For iud sum
                        var r_lessThan20_total_implant=0,r_20to29_total_implant=0,r_30to39_total_implant=0,r_40to49_total_implant=0; 
                        var r_lessThan20_total_permanent_man=0,r_20to29_total_permanent_man=0,r_30to39_total_permanent_man=0,r_40to49_total_permanent_man=0;
                        var r_lessThan20_total_permanent_woman=0,r_20to29_total_permanent_woman=0,r_30to39_total_permanent_woman=0,r_40to49_total_permanent_woman=0; 
                        
                        var r_lessThan20_total_notTaken=0, r_20to29_total_notTaken=0, r_30to39_total_notTaken=0, r_40to49_total_notTaken=0;
                        var r_lessThan20_total_pregnant=0, r_20to29_total_pregnant=0, r_30to39_total_pregnant=0, r_40to49_total_pregnant=0;
                        var r_lessThan20_total_totalNoOfChild=0, r_20to29_total_totalNoOfChild=0, r_30to39_total_totalNoOfChild=0, r_40to49_total_totalNoOfChild=0;
                        var r_lessThan20_total_husbandAbroad=0, r_20to29_total_husbandAbroad=0, r_30to39_total_husbandAbroad=0, r_40to49_total_husbandAbroad=0;
                         
                        //For Total full column
                        var r_lessThan20_zero_total=0, r_lessThan20_one_total=0, r_lessThan20_two_total=0, r_lessThan20_three_total=0;
                        var r_20to29_zero_total=0, r_20to29_one_total=0, r_20to29_two_total=0, r_20to29_three_total=0;
                        var r_30to39_zero_total=0, r_30to39_one_total=0, r_30to39_two_total=0, r_30to39_three_total=0;
                        var r_40to49_zero_total=0, r_40to49_one_total=0, r_40to49_two_total=0, r_40to49_three_total=0;
                        //For bottom all total
                        var r_allTotal_zero_pill=0, r_allTotal_one_pill=0, r_allTotal_two_pill=0, r_allTotal_three_pill=0; //Pill all total sum
                        var r_allTotal_zero_condom=0, r_allTotal_one_condom=0, r_allTotal_two_condom=0, r_allTotal_three_condom=0; //Condom all total sum
                        var r_allTotal_zero_inject=0, r_allTotal_one_inject=0, r_allTotal_two_inject=0, r_allTotal_three_inject=0; //Inject all total sum
                        var r_allTotal_zero_iud=0, r_allTotal_one_iud=0, r_allTotal_two_iud=0, r_allTotal_three_iud=0; //iud all total sum
                        var r_allTotal_zero_implant=0, r_allTotal_one_implant=0, r_allTotal_two_implant=0, r_allTotal_three_implant=0;
                        var r_allTotal_zero_permanent_man=0, r_allTotal_one_permanent_man=0, r_allTotal_two_permanent_man=0, r_allTotal_three_permanent_man=0;
                        var r_allTotal_zero_permanent_woman=0, r_allTotal_one_permanent_woman=0, r_allTotal_two_permanent_woman=0, r_allTotal_three_permanent_woman=0;
                        
                        var r_allTotal_zero_notTaken=0, r_allTotal_one_notTaken=0, r_allTotal_two_notTaken=0, r_allTotal_three_notTaken=0;
                        var r_allTotal_zero_pregnant=0, r_allTotal_one_pregnant=0, r_allTotal_two_pregnant=0, r_allTotal_three_pregnant=0;
                        var r_allTotal_zero_totalNoOfChild=0, r_allTotal_one_totalNoOfChild=0, r_allTotal_two_totalNoOfChild=0, r_allTotal_three_totalNoOfChild=0;
                        var r_allTotal_zero_husbandAbroad=0, r_allTotal_one_husbandAbroad=0, r_allTotal_two_husbandAbroad=0, r_allTotal_three_husbandAbroad=0;
                        
                        for (var i = 0; i < json.length; i++) {
                            //For age range <20
                            if(json[i].r_age===1){
                                //For 0 child
                                if(json[i].r_child===0){
                                    //set data to table
                                    $('#r_lessThan20_zero_pill').html(json[i].r_pill); //pill
                                    $('#r_lessThan20_zero_condom').html(json[i].r_condom); //condom
                                    $('#r_lessThan20_zero_inject').html(json[i].r_injectable);
                                    $('#r_lessThan20_zero_iud').html(json[i].r_iud);
                                    $('#r_lessThan20_zero_implant').html(json[i].r_implant);
                                    $('#r_lessThan20_zero_permanent_man').html(json[i].r_fm_man);
                                    $('#r_lessThan20_zero_permanent_woman').html(json[i].r_fm_woman);
                                    $('#r_lessThan20_zero_notTaken').html(json[i].r_method_not_taken);
                                    $('#r_lessThan20_zero_pregnant').html(json[i].r_pregnet);
                                    $('#r_lessThan20_zero_totalNoOfChild').html(json[i].r_tot_child);
                                    $('#r_lessThan20_zero_husbandAbroad').html(json[i].r_husband_foreign);
                                    //Null checking 
                                    if(json[i].r_pill=="-"){json[i].r_pill = 0;} //pill
                                    if(json[i].r_condom=="-"){json[i].r_condom = 0;} //condom
                                    if(json[i].r_injectable=="-"){json[i].r_injectable = 0;}
                                    if(json[i].r_iud=="-"){json[i].r_iud = 0;}
                                    if(json[i].r_implant=="-"){json[i].r_implant = 0;}
                                    if(json[i].r_fm_man=="-"){json[i].r_fm_man = 0;} 
                                    if(json[i].r_fm_woman=="-"){json[i].r_fm_woman = 0;} 
                                    if(json[i].r_method_not_taken=="-"){json[i].r_method_not_taken = 0;} 
                                    if(json[i].r_pregnet=="-"){json[i].r_pregnet = 0;} 
                                    if(json[i].r_tot_child=="-"){json[i].r_tot_child = 0;} 
                                    if(json[i].r_husband_foreign=="-"){json[i].r_husband_foreign = 0;} 
                                    //Sum Calculation
                                    r_lessThan20_total_pill = r_lessThan20_total_pill + json[i].r_pill ; //pill
                                    r_lessThan20_total_condom = r_lessThan20_total_condom + json[i].r_condom ; //condom
                                    r_lessThan20_total_inject = r_lessThan20_total_inject + json[i].r_injectable ; //inject
                                    r_lessThan20_total_iud = r_lessThan20_total_iud + json[i].r_iud ;
                                    r_lessThan20_total_implant = r_lessThan20_total_implant + json[i].r_implant ;
                                    r_lessThan20_total_permanent_man = r_lessThan20_total_permanent_man + json[i].r_fm_man ;
                                    r_lessThan20_total_permanent_woman = r_lessThan20_total_permanent_woman + json[i].r_fm_woman ;
                                    r_lessThan20_total_notTaken = r_lessThan20_total_notTaken + json[i].r_method_not_taken ;
                                    r_lessThan20_total_pregnant = r_lessThan20_total_pregnant + json[i].r_pregnet ;
                                    r_lessThan20_total_totalNoOfChild = r_lessThan20_total_totalNoOfChild + json[i].r_tot_child ;
                                    r_lessThan20_total_husbandAbroad = r_lessThan20_total_husbandAbroad + json[i].r_husband_foreign ;
                                    
                                    //sum for (total) column
                                    r_lessThan20_zero_total =  json[i].r_pill + json[i].r_condom + json[i].r_injectable + json[i].r_iud + json[i].r_implant + json[i].r_fm_man + json[i].r_fm_woman ;
                                    
                                    //Bottom total sum calculation
                                    r_allTotal_zero_pill = r_allTotal_zero_pill +  json[i].r_pill ; //pill
                                    r_allTotal_zero_condom = r_allTotal_zero_condom +  json[i].r_condom ; //condom
                                    r_allTotal_zero_inject = r_allTotal_zero_inject +  json[i].r_injectable ; //inject
                                    r_allTotal_zero_iud = r_allTotal_zero_iud +  json[i].r_iud ;
                                    r_allTotal_zero_implant = r_allTotal_zero_implant +  json[i].r_implant ;
                                    r_allTotal_zero_permanent_man = r_allTotal_zero_permanent_man +  json[i].r_fm_man ;
                                    r_allTotal_zero_permanent_woman = r_allTotal_zero_permanent_woman +  json[i].r_fm_woman ;
                                    r_allTotal_zero_notTaken = r_allTotal_zero_notTaken +  json[i].r_method_not_taken ;
                                    r_allTotal_zero_pregnant = r_allTotal_zero_pregnant +  json[i].r_pregnet ;
                                    r_allTotal_zero_totalNoOfChild = r_allTotal_zero_totalNoOfChild +  json[i].r_tot_child ;
                                    r_allTotal_zero_husbandAbroad = r_allTotal_zero_husbandAbroad +  json[i].r_husband_foreign ;
                                }
                                //For 1 child
                                if(json[i].r_child===1){
                                    //set data to table
                                    $('#r_lessThan20_one_pill').html(json[i].r_pill);
                                    $('#r_lessThan20_one_condom').html(json[i].r_condom);
                                    $('#r_lessThan20_one_inject').html(json[i].r_injectable);
                                    $('#r_lessThan20_one_iud').html(json[i].r_iud);
                                    $('#r_lessThan20_one_implant').html(json[i].r_implant);
                                    $('#r_lessThan20_one_permanent_man').html(json[i].r_fm_man);
                                    $('#r_lessThan20_one_permanent_woman').html(json[i].r_fm_woman);
                                    $('#r_lessThan20_one_notTaken').html(json[i].r_method_not_taken);
                                    $('#r_lessThan20_one_pregnant').html(json[i].r_pregnet);
                                    $('#r_lessThan20_one_totalNoOfChild').html(json[i].r_tot_child);
                                    $('#r_lessThan20_one_husbandAbroad').html(json[i].r_husband_foreign);
                                    //Null checking
                                    if(json[i].r_pill=="-"){json[i].r_pill = 0;}
                                    if(json[i].r_condom=="-"){json[i].r_condom = 0;}
                                    if(json[i].r_injectable=="-"){json[i].r_injectable = 0;}
                                    if(json[i].r_iud=="-"){json[i].r_iud = 0;}
                                    if(json[i].r_implant=="-"){json[i].r_implant = 0;}
                                    if(json[i].r_fm_man=="-"){json[i].r_fm_man = 0;}
                                    if(json[i].r_fm_woman=="-"){json[i].r_fm_woman = 0;}
                                    if(json[i].r_method_not_taken=="-"){json[i].r_method_not_taken = 0;} 
                                    if(json[i].r_pregnet=="-"){json[i].r_pregnet = 0;} 
                                    if(json[i].r_tot_child=="-"){json[i].r_tot_child = 0;} 
                                    if(json[i].r_husband_foreign=="-"){json[i].r_husband_foreign = 0;} 
                                    //Sum Calculation
                                    r_lessThan20_total_pill = r_lessThan20_total_pill + json[i].r_pill ;
                                    r_lessThan20_total_condom = r_lessThan20_total_condom + json[i].r_condom ;
                                    r_lessThan20_total_inject = r_lessThan20_total_inject + json[i].r_injectable ;
                                    r_lessThan20_total_iud = r_lessThan20_total_iud + json[i].r_iud ;
                                    r_lessThan20_total_implant = r_lessThan20_total_implant + json[i].r_implant ;
                                    r_lessThan20_total_permanent_man = r_lessThan20_total_permanent_man + json[i].r_fm_man ;
                                    r_lessThan20_total_permanent_woman = r_lessThan20_total_permanent_woman + json[i].r_fm_woman ;
                                    r_lessThan20_total_notTaken = r_lessThan20_total_notTaken + json[i].r_method_not_taken ;
                                    r_lessThan20_total_pregnant = r_lessThan20_total_pregnant + json[i].r_pregnet ;
                                    r_lessThan20_total_totalNoOfChild = r_lessThan20_total_totalNoOfChild + json[i].r_tot_child ;
                                    r_lessThan20_total_husbandAbroad = r_lessThan20_total_husbandAbroad + json[i].r_husband_foreign ;
                                    
                                    //sum for (total) column
                                    r_lessThan20_one_total =  json[i].r_pill + json[i].r_condom + json[i].r_injectable + json[i].r_iud + json[i].r_implant + json[i].r_fm_man + json[i].r_fm_woman ;
                                    
                                    //Bottom total sum
                                    r_allTotal_one_pill = r_allTotal_one_pill + json[i].r_pill ;
                                    r_allTotal_one_condom = r_allTotal_one_condom + json[i].r_condom ;
                                    r_allTotal_one_inject = r_allTotal_one_inject + json[i].r_injectable ;
                                    r_allTotal_one_iud = r_allTotal_one_iud + json[i].r_iud ;
                                    r_allTotal_one_implant = r_allTotal_one_implant + json[i].r_implant ;
                                    r_allTotal_one_permanent_man = r_allTotal_one_permanent_man + json[i].r_fm_man ;
                                    r_allTotal_one_permanent_woman = r_allTotal_one_permanent_woman + json[i].r_fm_woman ;
                                    r_allTotal_one_notTaken = r_allTotal_one_notTaken +  json[i].r_method_not_taken ;
                                    r_allTotal_one_pregnant = r_allTotal_one_pregnant +  json[i].r_pregnet ;
                                    r_allTotal_one_totalNoOfChild = r_allTotal_one_totalNoOfChild +  json[i].r_tot_child ;
                                    r_allTotal_one_husbandAbroad = r_allTotal_one_husbandAbroad +  json[i].r_husband_foreign ;
                                }
                                //For 2 child
                                if(json[i].r_child===2){
                                    //set data to table
                                    $('#r_lessThan20_two_pill').html(json[i].r_pill);
                                    $('#r_lessThan20_two_condom').html(json[i].r_condom);
                                    $('#r_lessThan20_two_inject').html(json[i].r_injectable);
                                    $('#r_lessThan20_two_iud').html(json[i].r_iud);
                                    $('#r_lessThan20_two_implant').html(json[i].r_implant);
                                    $('#r_lessThan20_two_permanent_man').html(json[i].r_fm_man);
                                    $('#r_lessThan20_two_permanent_woman').html(json[i].r_fm_woman);
                                    $('#r_lessThan20_two_notTaken').html(json[i].r_method_not_taken);
                                    $('#r_lessThan20_two_pregnant').html(json[i].r_pregnet);
                                    $('#r_lessThan20_two_totalNoOfChild').html(json[i].r_tot_child);
                                    $('#r_lessThan20_two_husbandAbroad').html(json[i].r_husband_foreign);
                                    //Null checking 
                                    if(json[i].r_pill=="-"){json[i].r_pill = 0;}
                                    if(json[i].r_condom=="-"){json[i].r_condom = 0;}
                                    if(json[i].r_injectable=="-"){json[i].r_injectable = 0;}
                                    if(json[i].r_iud=="-"){json[i].r_iud = 0;}
                                    if(json[i].r_implant=="-"){json[i].r_implant = 0;}
                                    if(json[i].r_fm_man=="-"){json[i].r_fm_man = 0;}
                                    if(json[i].r_fm_woman=="-"){json[i].r_fm_woman = 0;}
                                    if(json[i].r_method_not_taken=="-"){json[i].r_method_not_taken = 0;} 
                                    if(json[i].r_pregnet=="-"){json[i].r_pregnet = 0;} 
                                    if(json[i].r_tot_child=="-"){json[i].r_tot_child = 0;} 
                                    if(json[i].r_husband_foreign=="-"){json[i].r_husband_foreign = 0;} 
                                    //Sum Calculation
                                    r_lessThan20_total_pill = r_lessThan20_total_pill + json[i].r_pill ;
                                    r_lessThan20_total_condom = r_lessThan20_total_condom + json[i].r_condom ;
                                    r_lessThan20_total_inject = r_lessThan20_total_inject + json[i].r_injectable ;
                                    r_lessThan20_total_iud = r_lessThan20_total_iud + json[i].r_iud ;
                                    r_lessThan20_total_implant = r_lessThan20_total_implant + json[i].r_implant ;
                                    r_lessThan20_total_permanent_man = r_lessThan20_total_permanent_man + json[i].r_fm_man ;
                                    r_lessThan20_total_permanent_woman = r_lessThan20_total_permanent_woman + json[i].r_fm_woman ;
                                    r_lessThan20_total_notTaken = r_lessThan20_total_notTaken + json[i].r_method_not_taken ;
                                    r_lessThan20_total_pregnant = r_lessThan20_total_pregnant + json[i].r_pregnet ;
                                    r_lessThan20_total_totalNoOfChild = r_lessThan20_total_totalNoOfChild + json[i].r_tot_child ;
                                    r_lessThan20_total_husbandAbroad = r_lessThan20_total_husbandAbroad + json[i].r_husband_foreign ;
                                    
                                    //sum for (total) column
                                    r_lessThan20_two_total =  json[i].r_pill + json[i].r_condom + json[i].r_injectable + json[i].r_iud + json[i].r_implant + json[i].r_fm_man + json[i].r_fm_woman ;
                                    
                                    //Bottom total sum
                                    r_allTotal_two_pill = r_allTotal_two_pill + json[i].r_pill ;
                                    r_allTotal_two_condom = r_allTotal_two_condom + json[i].r_condom ;
                                    r_allTotal_two_inject = r_allTotal_two_inject + json[i].r_injectable ;
                                    r_allTotal_two_iud = r_allTotal_two_iud + json[i].r_iud ;
                                    r_allTotal_two_implant = r_allTotal_two_implant + json[i].r_implant ;
                                    r_allTotal_two_permanent_man = r_allTotal_two_permanent_man + json[i].r_fm_man ;
                                    r_allTotal_two_permanent_woman = r_allTotal_two_permanent_woman + json[i].r_fm_woman ;
                                    r_allTotal_two_notTaken = r_allTotal_two_notTaken +  json[i].r_method_not_taken ;
                                    r_allTotal_two_pregnant = r_allTotal_two_pregnant +  json[i].r_pregnet ;
                                    r_allTotal_two_totalNoOfChild = r_allTotal_two_totalNoOfChild +  json[i].r_tot_child ;
                                    r_allTotal_two_husbandAbroad = r_allTotal_two_husbandAbroad +  json[i].r_husband_foreign ;
                                    
                                }
                                //For 3+ child
                                if(json[i].r_child===3){
                                    //set data to table
                                    $('#r_lessThan20_three_pill').html(json[i].r_pill);                                    
                                    $('#r_lessThan20_three_condom').html(json[i].r_condom);
                                    $('#r_lessThan20_three_inject').html(json[i].r_injectable);
                                    $('#r_lessThan20_three_iud').html(json[i].r_iud);
                                    $('#r_lessThan20_three_implant').html(json[i].r_implant);
                                    $('#r_lessThan20_three_permanent_man').html(json[i].r_fm_man);
                                    $('#r_lessThan20_three_permanent_woman').html(json[i].r_fm_woman);
                                    $('#r_lessThan20_three_notTaken').html(json[i].r_method_not_taken);
                                    $('#r_lessThan20_three_pregnant').html(json[i].r_pregnet);
                                    $('#r_lessThan20_three_totalNoOfChild').html(json[i].r_tot_child);
                                    $('#r_lessThan20_three_husbandAbroad').html(json[i].r_husband_foreign);
                                    //Null checking 
                                    if(json[i].r_pill=="-"){json[i].r_pill = 0;}
                                    if(json[i].r_condom=="-"){json[i].r_condom = 0;}
                                    if(json[i].r_injectable=="-"){json[i].r_injectable = 0;}
                                    if(json[i].r_iud=="-"){json[i].r_iud = 0;}
                                    if(json[i].r_implant=="-"){json[i].r_implant = 0;}
                                    if(json[i].r_fm_man=="-"){json[i].r_fm_man = 0;}
                                    if(json[i].r_fm_woman=="-"){json[i].r_fm_woman = 0;}
                                    if(json[i].r_method_not_taken=="-"){json[i].r_method_not_taken = 0;} 
                                    if(json[i].r_pregnet=="-"){json[i].r_pregnet = 0;} 
                                    if(json[i].r_tot_child=="-"){json[i].r_tot_child = 0;} 
                                    if(json[i].r_husband_foreign=="-"){json[i].r_husband_foreign = 0;} 
                                    //Sum Calculation
                                    r_lessThan20_total_pill = r_lessThan20_total_pill + json[i].r_pill ;
                                    r_lessThan20_total_condom = r_lessThan20_total_condom + json[i].r_condom ;
                                    r_lessThan20_total_inject = r_lessThan20_total_inject + json[i].r_injectable ;
                                    r_lessThan20_total_iud = r_lessThan20_total_iud + json[i].r_iud ;
                                    r_lessThan20_total_implant = r_lessThan20_total_implant + json[i].r_implant ;
                                    r_lessThan20_total_permanent_man = r_lessThan20_total_permanent_man + json[i].r_pill ;
                                    r_lessThan20_total_permanent_woman = r_lessThan20_total_permanent_woman + json[i].r_fm_woman ;
                                    r_lessThan20_total_notTaken = r_lessThan20_total_notTaken + json[i].r_method_not_taken ;
                                    r_lessThan20_total_pregnant = r_lessThan20_total_pregnant + json[i].r_pregnet ;
                                    r_lessThan20_total_totalNoOfChild = r_lessThan20_total_totalNoOfChild + json[i].r_tot_child ;
                                    r_lessThan20_total_husbandAbroad = r_lessThan20_total_husbandAbroad + json[i].r_husband_foreign ;
                                    
                                    //sum for (total) column
                                    r_lessThan20_three_total =  json[i].r_pill + json[i].r_condom + json[i].r_injectable + json[i].r_iud + json[i].r_implant + json[i].r_fm_man + json[i].r_fm_woman ;
                                    
                                    //Bottom total sum
                                    r_allTotal_three_pill = r_allTotal_three_pill + json[i].r_pill ;
                                    r_allTotal_three_condom = r_allTotal_three_condom + json[i].r_condom ;
                                    r_allTotal_three_inject = r_allTotal_three_inject + json[i].r_injectable ;
                                    r_allTotal_three_iud = r_allTotal_three_iud + json[i].r_iud ;
                                    r_allTotal_three_implant = r_allTotal_three_implant + json[i].r_implant ;
                                    r_allTotal_three_permanent_man = r_allTotal_three_permanent_man + json[i].r_fm_man ;
                                    r_allTotal_three_permanent_woman = r_allTotal_three_permanent_woman + json[i].r_fm_woman ;
                                    r_allTotal_three_notTaken = r_allTotal_three_notTaken +  json[i].r_method_not_taken ;
                                    r_allTotal_three_pregnant = r_allTotal_three_pregnant +  json[i].r_pregnet ;
                                    r_allTotal_three_totalNoOfChild = r_allTotal_three_totalNoOfChild +  json[i].r_tot_child ;
                                    r_allTotal_three_husbandAbroad = r_allTotal_three_husbandAbroad +  json[i].r_husband_foreign ;
                                    
                                }
                            }
                            
                            //For age range 20-29
                            if(json[i].r_age===2){
                                //For 0 child
                                if(json[i].r_child===0){
                                    //set data to table
                                    $('#r_20to29_zero_pill').html(json[i].r_pill);
                                    $('#r_20to29_zero_condom').html(json[i].r_condom);
                                    $('#r_20to29_zero_inject').html(json[i].r_injectable);
                                    $('#r_20to29_zero_iud').html(json[i].r_iud);
                                    $('#r_20to29_zero_implant').html(json[i].r_implant);
                                    $('#r_20to29_zero_permanent_man').html(json[i].r_fm_man);
                                    $('#r_20to29_zero_permanent_woman').html(json[i].r_fm_woman);
                                    $('#r_20to29_zero_notTaken').html(json[i].r_method_not_taken);
                                    $('#r_20to29_zero_pregnant').html(json[i].r_pregnet);
                                    $('#r_20to29_zero_totalNoOfChild').html(json[i].r_tot_child);
                                    $('#r_20to29_zero_husbandAbroad').html(json[i].r_husband_foreign);
                                    //Null checking 
                                    if(json[i].r_pill=="-"){json[i].r_pill = 0;}
                                    if(json[i].r_condom=="-"){json[i].r_condom = 0;}
                                    if(json[i].r_injectable=="-"){json[i].r_injectable = 0;}
                                    if(json[i].r_iud=="-"){json[i].r_iud = 0;}
                                    if(json[i].r_implant=="-"){json[i].r_implant = 0;}
                                    if(json[i].r_fm_man=="-"){json[i].r_fm_man = 0;}
                                    if(json[i].r_fm_woman=="-"){json[i].r_fm_woman = 0;}
                                    if(json[i].r_method_not_taken=="-"){json[i].r_method_not_taken = 0;} 
                                    if(json[i].r_pregnet=="-"){json[i].r_pregnet = 0;} 
                                    if(json[i].r_tot_child=="-"){json[i].r_tot_child = 0;} 
                                    if(json[i].r_husband_foreign=="-"){json[i].r_husband_foreign = 0;} 
                                    //Sum Calculation
                                    r_20to29_total_pill = r_20to29_total_pill + json[i].r_pill ;
                                    r_20to29_total_condom = r_20to29_total_condom + json[i].r_condom ;
                                    r_20to29_total_inject = r_20to29_total_inject + json[i].r_injectable ;
                                    r_20to29_total_iud = r_20to29_total_iud + json[i].r_iud ;
                                    r_20to29_total_implant = r_20to29_total_implant + json[i].r_implant ;
                                    r_20to29_total_permanent_man = r_20to29_total_permanent_man + json[i].r_fm_man ;
                                    r_20to29_total_permanent_woman = r_20to29_total_permanent_woman + json[i].r_fm_woman ;
                                    r_20to29_total_notTaken = r_20to29_total_notTaken + json[i].r_method_not_taken ;
                                    r_20to29_total_pregnant = r_20to29_total_pregnant + json[i].r_pregnet ;
                                    r_20to29_total_totalNoOfChild = r_20to29_total_totalNoOfChild + json[i].r_tot_child ;
                                    r_20to29_total_husbandAbroad = r_20to29_total_husbandAbroad + json[i].r_husband_foreign ;
                                    
                                    //sum for (total) column
                                    r_20to29_zero_total =  json[i].r_pill + json[i].r_condom + json[i].r_injectable + json[i].r_iud + json[i].r_implant + json[i].r_fm_man + json[i].r_fm_woman ;                                 
                                    
                                    //Bottom total sum
                                    r_allTotal_zero_pill = r_allTotal_zero_pill +  json[i].r_pill ;
                                    r_allTotal_zero_condom = r_allTotal_zero_condom +  json[i].r_condom ;
                                    r_allTotal_zero_inject = r_allTotal_zero_inject +  json[i].r_injectable ;
                                    r_allTotal_zero_iud = r_allTotal_zero_iud +  json[i].r_iud ;
                                    r_allTotal_zero_implant = r_allTotal_zero_implant +  json[i].r_implant ;
                                    r_allTotal_zero_permanent_man = r_allTotal_zero_permanent_man +  json[i].r_fm_man ;
                                    r_allTotal_zero_permanent_woman = r_allTotal_zero_permanent_woman +  json[i].r_fm_woman ;
                                    r_allTotal_zero_notTaken = r_allTotal_zero_notTaken +  json[i].r_method_not_taken ;
                                    r_allTotal_zero_pregnant = r_allTotal_zero_pregnant +  json[i].r_pregnet ;
                                    r_allTotal_zero_totalNoOfChild = r_allTotal_zero_totalNoOfChild +  json[i].r_tot_child ;
                                    r_allTotal_zero_husbandAbroad = r_allTotal_zero_husbandAbroad +  json[i].r_husband_foreign ;
                                    
                                }
                                //For 1 child
                                if(json[i].r_child===1){
                                    //set data to table
                                    $('#r_20to29_one_pill').html(json[i].r_pill);
                                    $('#r_20to29_one_condom').html(json[i].r_condom);
                                    $('#r_20to29_one_inject').html(json[i].r_injectable);
                                    $('#r_20to29_one_iud').html(json[i].r_iud);
                                    $('#r_20to29_one_implant').html(json[i].r_implant);
                                    $('#r_20to29_one_permanent_man').html(json[i].r_fm_man);
                                    $('#r_20to29_one_permanent_woman').html(json[i].r_fm_woman);
                                    $('#r_20to29_one_notTaken').html(json[i].r_method_not_taken);
                                    $('#r_20to29_one_pregnant').html(json[i].r_pregnet);
                                    $('#r_20to29_one_totalNoOfChild').html(json[i].r_tot_child);
                                    $('#r_20to29_one_husbandAbroad').html(json[i].r_husband_foreign);
                                    //Null checking 
                                    if(json[i].r_pill=="-"){json[i].r_pill = 0;}
                                    if(json[i].r_condom=="-"){json[i].r_condom = 0;}
                                    if(json[i].r_injectable=="-"){json[i].r_injectable = 0;}
                                    if(json[i].r_iud=="-"){json[i].r_iud = 0;}
                                    if(json[i].r_implant=="-"){json[i].r_implant = 0;}
                                    if(json[i].r_fm_man=="-"){json[i].r_fm_man = 0;}
                                    if(json[i].r_fm_woman=="-"){json[i].r_fm_woman = 0;}
                                    if(json[i].r_method_not_taken=="-"){json[i].r_method_not_taken = 0;} 
                                    if(json[i].r_pregnet=="-"){json[i].r_pregnet = 0;} 
                                    if(json[i].r_tot_child=="-"){json[i].r_tot_child = 0;} 
                                    if(json[i].r_husband_foreign=="-"){json[i].r_husband_foreign = 0;} 
                                    //Sum Calculation
                                    r_20to29_total_pill = r_20to29_total_pill + json[i].r_pill ;
                                    r_20to29_total_condom = r_20to29_total_condom + json[i].r_condom ;
                                    r_20to29_total_inject = r_20to29_total_inject + json[i].r_injectable ;
                                    r_20to29_total_iud = r_20to29_total_iud + json[i].r_iud ;
                                    r_20to29_total_implant = r_20to29_total_implant + json[i].r_implant ;
                                    r_20to29_total_permanent_man = r_20to29_total_permanent_man + json[i].r_fm_man ;
                                    r_20to29_total_permanent_woman = r_20to29_total_permanent_woman + json[i].r_fm_woman ;
                                    r_20to29_total_notTaken = r_20to29_total_notTaken + json[i].r_method_not_taken ;
                                    r_20to29_total_pregnant = r_20to29_total_pregnant + json[i].r_pregnet ;
                                    r_20to29_total_totalNoOfChild = r_20to29_total_totalNoOfChild + json[i].r_tot_child ;
                                    r_20to29_total_husbandAbroad = r_20to29_total_husbandAbroad + json[i].r_husband_foreign ;
                                     
                                    //sum for (total) column
                                    r_20to29_one_total =  json[i].r_pill + json[i].r_condom + json[i].r_injectable + json[i].r_iud + json[i].r_implant + json[i].r_fm_man + json[i].r_fm_woman ;
                                    
                                    //Bottom total sum
                                    r_allTotal_one_pill = r_allTotal_one_pill + json[i].r_pill ;
                                    r_allTotal_one_condom = r_allTotal_one_condom + json[i].r_condom ;
                                    r_allTotal_one_inject = r_allTotal_one_inject + json[i].r_injectable ;
                                    r_allTotal_one_iud = r_allTotal_one_iud + json[i].r_iud ;
                                    r_allTotal_one_implant = r_allTotal_one_implant + json[i].r_implant ;
                                    r_allTotal_one_permanent_man = r_allTotal_one_permanent_man + json[i].r_fm_man ;
                                    r_allTotal_one_permanent_woman = r_allTotal_one_permanent_woman + json[i].r_fm_woman ;
                                    r_allTotal_one_notTaken = r_allTotal_one_notTaken +  json[i].r_method_not_taken ;
                                    r_allTotal_one_pregnant = r_allTotal_one_pregnant +  json[i].r_pregnet ;
                                    r_allTotal_one_totalNoOfChild = r_allTotal_one_totalNoOfChild +  json[i].r_tot_child ;
                                    r_allTotal_one_husbandAbroad = r_allTotal_one_husbandAbroad +  json[i].r_husband_foreign ;
                                }
                                //For 2 child
                                if(json[i].r_child===2){
                                    //set data to table
                                    $('#r_20to29_two_pill').html(json[i].r_pill);
                                    $('#r_20to29_two_condom').html(json[i].r_condom);
                                    $('#r_20to29_two_inject').html(json[i].r_injectable);
                                    $('#r_20to29_two_iud').html(json[i].r_iud);
                                    $('#r_20to29_two_implant').html(json[i].r_implant);
                                    $('#r_20to29_two_permanent_man').html(json[i].r_fm_man);
                                    $('#r_20to29_two_permanent_woman').html(json[i].r_fm_woman);
                                    $('#r_20to29_two_notTaken').html(json[i].r_method_not_taken);
                                    $('#r_20to29_two_pregnant').html(json[i].r_pregnet);
                                    $('#r_20to29_two_totalNoOfChild').html(json[i].r_tot_child);
                                    $('#r_20to29_two_husbandAbroad').html(json[i].r_husband_foreign);
                                    //Null checking 
                                    if(json[i].r_pill=="-"){json[i].r_pill = 0;}
                                    if(json[i].r_condom=="-"){json[i].r_condom = 0;}
                                    if(json[i].r_injectable=="-"){json[i].r_injectable = 0;}
                                    if(json[i].r_iud=="-"){json[i].r_iud = 0;}
                                    if(json[i].r_implant=="-"){json[i].r_implant = 0;}
                                    if(json[i].r_fm_man=="-"){json[i].r_fm_man = 0;}
                                    if(json[i].r_fm_woman=="-"){json[i].r_fm_woman = 0;}
                                    if(json[i].r_method_not_taken=="-"){json[i].r_method_not_taken = 0;} 
                                    if(json[i].r_pregnet=="-"){json[i].r_pregnet = 0;} 
                                    if(json[i].r_tot_child=="-"){json[i].r_tot_child = 0;} 
                                    if(json[i].r_husband_foreign=="-"){json[i].r_husband_foreign = 0;} 
                                    //Sum Calculation
                                    r_20to29_total_pill = r_20to29_total_pill + json[i].r_pill ;
                                    r_20to29_total_condom = r_20to29_total_condom + json[i].r_condom ;
                                    r_20to29_total_inject = r_20to29_total_inject + json[i].r_injectable ;
                                    r_20to29_total_iud = r_20to29_total_iud + json[i].r_iud ;
                                    r_20to29_total_implant = r_20to29_total_implant + json[i].r_implant ;
                                    r_20to29_total_permanent_man = r_20to29_total_permanent_man + json[i].r_fm_man ;
                                    r_20to29_total_permanent_woman = r_20to29_total_permanent_woman + json[i].r_fm_woman ;
                                    r_20to29_total_notTaken = r_20to29_total_notTaken + json[i].r_method_not_taken ;
                                    r_20to29_total_pregnant = r_20to29_total_pregnant + json[i].r_pregnet ;
                                    r_20to29_total_totalNoOfChild = r_20to29_total_totalNoOfChild + json[i].r_tot_child ;
                                    r_20to29_total_husbandAbroad = r_20to29_total_husbandAbroad + json[i].r_husband_foreign ;

                                    //sum for (total) column
                                    r_20to29_two_total =  json[i].r_pill + json[i].r_condom + json[i].r_injectable + json[i].r_iud + json[i].r_implant + json[i].r_fm_man + json[i].r_fm_woman ;
                                    
                                    //Bottom total sum
                                    r_allTotal_two_pill = r_allTotal_two_pill + json[i].r_pill ;
                                    r_allTotal_two_condom = r_allTotal_two_condom + json[i].r_condom ;
                                    r_allTotal_two_inject = r_allTotal_two_inject + json[i].r_injectable ;
                                    r_allTotal_two_iud = r_allTotal_two_iud + json[i].r_iud ;
                                    r_allTotal_two_implant = r_allTotal_two_implant + json[i].r_implant ;
                                    r_allTotal_two_permanent_man = r_allTotal_two_permanent_man + json[i].r_fm_man ;
                                    r_allTotal_two_permanent_woman = r_allTotal_two_permanent_woman + json[i].r_fm_woman ;
                                    r_allTotal_two_notTaken = r_allTotal_two_notTaken +  json[i].r_method_not_taken ;
                                    r_allTotal_two_pregnant = r_allTotal_two_pregnant +  json[i].r_pregnet ;
                                    r_allTotal_two_totalNoOfChild = r_allTotal_two_totalNoOfChild +  json[i].r_tot_child ;
                                    r_allTotal_two_husbandAbroad = r_allTotal_two_husbandAbroad +  json[i].r_husband_foreign ;
                                }
                                //For 3+ child
                                if(json[i].r_child===3){
                                    //set data to table
                                    $('#r_20to29_three_pill').html(json[i].r_pill);
                                    $('#r_20to29_three_condom').html(json[i].r_condom);
                                    $('#r_20to29_three_inject').html(json[i].r_injectable);
                                    $('#r_20to29_three_iud').html(json[i].r_iud);
                                    $('#r_20to29_three_implant').html(json[i].r_implant);
                                    $('#r_20to29_three_permanent_man').html(json[i].r_fm_man);
                                    $('#r_20to29_three_permanent_woman').html(json[i].r_fm_woman);
                                    $('#r_20to29_three_notTaken').html(json[i].r_method_not_taken);
                                    $('#r_20to29_three_pregnant').html(json[i].r_pregnet);
                                    $('#r_20to29_three_totalNoOfChild').html(json[i].r_tot_child);
                                    $('#r_20to29_three_husbandAbroad').html(json[i].r_husband_foreign);
                                    //Null checking 
                                    if(json[i].r_pill=="-"){json[i].r_pill = 0;}
                                    if(json[i].r_condom=="-"){json[i].r_condom = 0;}
                                    if(json[i].r_injectable=="-"){json[i].r_injectable = 0;}
                                    if(json[i].r_iud=="-"){json[i].r_iud = 0;}
                                    if(json[i].r_implant=="-"){json[i].r_implant = 0;}
                                    if(json[i].r_fm_man=="-"){json[i].r_fm_man = 0;}
                                    if(json[i].r_fm_woman=="-"){json[i].r_fm_woman = 0;}
                                    if(json[i].r_method_not_taken=="-"){json[i].r_method_not_taken = 0;} 
                                    if(json[i].r_pregnet=="-"){json[i].r_pregnet = 0;} 
                                    if(json[i].r_tot_child=="-"){json[i].r_tot_child = 0;} 
                                    if(json[i].r_husband_foreign=="-"){json[i].r_husband_foreign = 0;} 
                                    //Sum Calculation
                                    r_20to29_total_pill = r_20to29_total_pill + json[i].r_pill ;
                                    r_20to29_total_condom = r_20to29_total_condom + json[i].r_condom ;
                                    r_20to29_total_inject = r_20to29_total_inject + json[i].r_injectable ;
                                    r_20to29_total_iud = r_20to29_total_iud + json[i].r_iud ;
                                    r_20to29_total_implant = r_20to29_total_implant + json[i].r_implant ;
                                    r_20to29_total_permanent_man = r_20to29_total_permanent_man + json[i].r_fm_man ;
                                    r_20to29_total_permanent_woman = r_20to29_total_permanent_woman + json[i].r_fm_woman ;
                                    r_20to29_total_notTaken = r_20to29_total_notTaken + json[i].r_method_not_taken ;
                                    r_20to29_total_pregnant = r_20to29_total_pregnant + json[i].r_pregnet ;
                                    r_20to29_total_totalNoOfChild = r_20to29_total_totalNoOfChild + json[i].r_tot_child ;
                                    r_20to29_total_husbandAbroad = r_20to29_total_husbandAbroad + json[i].r_husband_foreign ;
                                    
                                    //sum for (total) column
                                    r_20to29_three_total =  json[i].r_pill + json[i].r_condom + json[i].r_injectable + json[i].r_iud + json[i].r_implant + json[i].r_fm_man + json[i].r_fm_woman ;
                                    
                                    //Bottom total sum
                                    r_allTotal_three_pill = r_allTotal_three_pill + json[i].r_pill ;
                                    r_allTotal_three_condom = r_allTotal_three_condom + json[i].r_condom ;
                                    r_allTotal_three_inject = r_allTotal_three_inject + json[i].r_injectable ;
                                    r_allTotal_three_iud = r_allTotal_three_iud + json[i].r_iud ;
                                    r_allTotal_three_implant = r_allTotal_three_implant + json[i].r_implant ;
                                    r_allTotal_three_permanent_man = r_allTotal_three_permanent_man + json[i].r_fm_man ;
                                    r_allTotal_three_permanent_woman = r_allTotal_three_permanent_woman + json[i].r_fm_woman ;
                                    r_allTotal_three_notTaken = r_allTotal_three_notTaken +  json[i].r_method_not_taken ;
                                    r_allTotal_three_pregnant = r_allTotal_three_pregnant +  json[i].r_pregnet ;
                                    r_allTotal_three_totalNoOfChild = r_allTotal_three_totalNoOfChild +  json[i].r_tot_child ;
                                    r_allTotal_three_husbandAbroad = r_allTotal_three_husbandAbroad +  json[i].r_husband_foreign ;
                                }
                            }
                            
                            //For age range 30-39
                            if(json[i].r_age===3){
                                //For 0 child
                                if(json[i].r_child===0){
                                    //set data to table
                                    $('#r_30to39_zero_pill').html(json[i].r_pill);
                                     $('#r_30to39_zero_condom').html(json[i].r_condom);
                                     $('#r_30to39_zero_inject').html(json[i].r_injectable);
                                     $('#r_30to39_zero_iud').html(json[i].r_iud);
                                     $('#r_30to39_zero_implant').html(json[i].r_implant);
                                     $('#r_30to39_zero_permanent_man').html(json[i].r_fm_man);
                                     $('#r_30to39_zero_permanent_woman').html(json[i].r_fm_woman);
                                     $('#r_30to39_zero_notTaken').html(json[i].r_method_not_taken);
                                     $('#r_30to39_zero_pregnant').html(json[i].r_pregnet);
                                     $('#r_30to39_zero_totalNoOfChild').html(json[i].r_tot_child);
                                     $('#r_30to39_zero_husbandAbroad').html(json[i].r_husband_foreign);
                                    //Null checking 
                                    if(json[i].r_pill=="-"){json[i].r_pill = 0;}
                                    if(json[i].r_condom=="-"){json[i].r_condom = 0;}
                                    if(json[i].r_injectable=="-"){json[i].r_injectable = 0;}
                                    if(json[i].r_iud=="-"){json[i].r_iud = 0;}
                                    if(json[i].r_implant=="-"){json[i].r_implant = 0;}
                                    if(json[i].r_fm_man=="-"){json[i].r_fm_man = 0;}
                                    if(json[i].r_fm_woman=="-"){json[i].r_fm_woman = 0;}
                                    if(json[i].r_method_not_taken=="-"){json[i].r_method_not_taken = 0;} 
                                    if(json[i].r_pregnet=="-"){json[i].r_pregnet = 0;} 
                                    if(json[i].r_tot_child=="-"){json[i].r_tot_child = 0;} 
                                    if(json[i].r_husband_foreign=="-"){json[i].r_husband_foreign = 0;} 
                                    //Sum Calculation
                                    r_30to39_total_pill = r_30to39_total_pill + json[i].r_pill ;
                                    r_30to39_total_condom = r_30to39_total_condom + json[i].r_condom ;
                                    r_30to39_total_inject = r_30to39_total_inject + json[i].r_injectable ;
                                    r_30to39_total_iud = r_30to39_total_iud + json[i].r_iud ;
                                    r_30to39_total_implant = r_30to39_total_implant + json[i].r_implant ;
                                    r_30to39_total_permanent_man = r_30to39_total_permanent_man + json[i].r_fm_man ;
                                    r_30to39_total_permanent_woman = r_30to39_total_permanent_woman + json[i].r_fm_woman ;
                                    r_30to39_total_notTaken = r_30to39_total_notTaken + json[i].r_method_not_taken ;
                                    r_30to39_total_pregnant = r_30to39_total_pregnant + json[i].r_pregnet ;
                                    r_30to39_total_totalNoOfChild = r_30to39_total_totalNoOfChild + json[i].r_tot_child ;
                                    r_30to39_total_husbandAbroad = r_30to39_total_husbandAbroad + json[i].r_husband_foreign ;
                                    
                                    //sum for (total) column
                                    r_30to39_zero_total =  json[i].r_pill + json[i].r_condom + json[i].r_injectable + json[i].r_iud + json[i].r_implant + json[i].r_fm_man + json[i].r_fm_woman ;
                                    
                                    //Bottom total sum
                                    r_allTotal_zero_pill = r_allTotal_zero_pill +  json[i].r_pill ;
                                    r_allTotal_zero_condom = r_allTotal_zero_condom +  json[i].r_condom ;
                                    r_allTotal_zero_inject = r_allTotal_zero_inject +  json[i].r_injectable ;
                                    r_allTotal_zero_iud = r_allTotal_zero_iud +  json[i].r_iud ;
                                    r_allTotal_zero_implant = r_allTotal_zero_implant +  json[i].r_implant ;
                                    r_allTotal_zero_permanent_man = r_allTotal_zero_permanent_man +  json[i].r_fm_man ;
                                    r_allTotal_zero_permanent_woman = r_allTotal_zero_permanent_woman +  json[i].r_fm_woman ;
                                    r_allTotal_zero_notTaken = r_allTotal_zero_notTaken +  json[i].r_method_not_taken ;
                                    r_allTotal_zero_pregnant = r_allTotal_zero_pregnant +  json[i].r_pregnet ;
                                    r_allTotal_zero_totalNoOfChild = r_allTotal_zero_totalNoOfChild +  json[i].r_tot_child ;
                                    r_allTotal_zero_husbandAbroad = r_allTotal_zero_husbandAbroad +  json[i].r_husband_foreign ;
                                }
                                //For 1 child
                                if(json[i].r_child===1){
                                    //set data to table
                                    $('#r_30to39_one_pill').html(json[i].r_pill);
                                     $('#r_30to39_one_condom').html(json[i].r_condom); 
                                     $('#r_30to39_one_inject').html(json[i].r_injectable);
                                     $('#r_30to39_one_iud').html(json[i].r_iud);
                                     $('#r_30to39_one_implant').html(json[i].r_implant);
                                     $('#r_30to39_one_permanent_man').html(json[i].r_fm_man);
                                     $('#r_30to39_one_permanent_woman').html(json[i].r_fm_woman);
                                     $('#r_30to39_one_notTaken').html(json[i].r_method_not_taken);
                                    $('#r_30to39_one_pregnant').html(json[i].r_pregnet);
                                    $('#r_30to39_one_totalNoOfChild').html(json[i].r_tot_child);
                                    $('#r_30to39_one_husbandAbroad').html(json[i].r_husband_foreign);
                                    //Null checking 
                                    if(json[i].r_pill=="-"){json[i].r_pill = 0;}
                                    if(json[i].r_condom=="-"){json[i].r_condom = 0;}
                                    if(json[i].r_injectable=="-"){json[i].r_injectable = 0;}
                                    if(json[i].r_iud=="-"){json[i].r_iud = 0;}
                                    if(json[i].r_implant=="-"){json[i].r_implant = 0;}
                                    if(json[i].r_fm_man=="-"){json[i].r_fm_man = 0;}
                                    if(json[i].r_fm_woman=="-"){json[i].r_fm_woman = 0;}
                                    if(json[i].r_method_not_taken=="-"){json[i].r_method_not_taken = 0;} 
                                    if(json[i].r_pregnet=="-"){json[i].r_pregnet = 0;} 
                                    if(json[i].r_tot_child=="-"){json[i].r_tot_child = 0;} 
                                    if(json[i].r_husband_foreign=="-"){json[i].r_husband_foreign = 0;} 
                                    //Sum Calculation
                                    r_30to39_total_pill = r_30to39_total_pill + json[i].r_pill ;
                                    r_30to39_total_condom = r_30to39_total_condom + json[i].r_condom ;
                                    r_30to39_total_inject = r_30to39_total_inject + json[i].r_injectable ;
                                    r_30to39_total_iud = r_30to39_total_iud + json[i].r_iud ;
                                    r_30to39_total_implant = r_30to39_total_implant + json[i].r_implant ;
                                    r_30to39_total_permanent_man = r_30to39_total_permanent_man + json[i].r_fm_man ;
                                    r_30to39_total_permanent_woman = r_30to39_total_permanent_woman + json[i].r_fm_woman ;
                                    r_30to39_total_notTaken = r_30to39_total_notTaken + json[i].r_method_not_taken ;
                                    r_30to39_total_pregnant = r_30to39_total_pregnant + json[i].r_pregnet ;
                                    r_30to39_total_totalNoOfChild = r_30to39_total_totalNoOfChild + json[i].r_tot_child ;
                                    r_30to39_total_husbandAbroad = r_30to39_total_husbandAbroad + json[i].r_husband_foreign ;
                                    
                                    //sum for (total) column
                                    r_30to39_one_total =  json[i].r_pill + json[i].r_condom + json[i].r_injectable + json[i].r_iud + json[i].r_implant + json[i].r_fm_man + json[i].r_fm_woman ;
                                    
                                    //Bottom total sum
                                    r_allTotal_one_pill = r_allTotal_one_pill + json[i].r_pill ;
                                    r_allTotal_one_condom = r_allTotal_one_condom + json[i].r_condom ;
                                    r_allTotal_one_inject = r_allTotal_one_inject + json[i].r_injectable ;
                                    r_allTotal_one_iud = r_allTotal_one_iud + json[i].r_iud ;
                                    r_allTotal_one_implant = r_allTotal_one_implant + json[i].r_implant ;
                                    r_allTotal_one_permanent_man = r_allTotal_one_permanent_man + json[i].r_fm_man ;
                                    r_allTotal_one_permanent_woman = r_allTotal_one_permanent_woman + json[i].r_fm_woman ;
                                    r_allTotal_one_notTaken = r_allTotal_one_notTaken +  json[i].r_method_not_taken ;
                                    r_allTotal_one_pregnant = r_allTotal_one_pregnant +  json[i].r_pregnet ;
                                    r_allTotal_one_totalNoOfChild = r_allTotal_one_totalNoOfChild +  json[i].r_tot_child ;
                                    r_allTotal_one_husbandAbroad = r_allTotal_one_husbandAbroad +  json[i].r_husband_foreign ;
                                }
                                //For 2 child
                                if(json[i].r_child===2){
                                    //set data to table
                                    $('#r_30to39_two_pill').html(json[i].r_pill);
                                    $('#r_30to39_two_condom').html(json[i].r_condom);
                                    $('#r_30to39_two_inject').html(json[i].r_injectable);
                                    $('#r_30to39_two_iud').html(json[i].r_iud);
                                    $('#r_30to39_two_implant').html(json[i].r_implant);
                                    $('#r_30to39_two_permanent_man').html(json[i].r_fm_man);
                                    $('#r_30to39_two_permanent_woman').html(json[i].r_fm_woman);
                                    $('#r_30to39_two_notTaken').html(json[i].r_method_not_taken);
                                    $('#r_30to39_two_pregnant').html(json[i].r_pregnet);
                                    $('#r_30to39_two_totalNoOfChild').html(json[i].r_tot_child);
                                    $('#r_30to39_two_husbandAbroad').html(json[i].r_husband_foreign);
                                    //Null checking 
                                    if(json[i].r_pill=="-"){json[i].r_pill = 0;}
                                    if(json[i].r_condom=="-"){json[i].r_condom = 0;}
                                    if(json[i].r_injectable=="-"){json[i].r_injectable = 0;}
                                    if(json[i].r_iud=="-"){json[i].r_iud = 0;}
                                    if(json[i].r_implant=="-"){json[i].r_implant = 0;}
                                    if(json[i].r_fm_man=="-"){json[i].r_fm_man = 0;}
                                    if(json[i].r_fm_woman=="-"){json[i].r_fm_woman = 0;}
                                    if(json[i].r_method_not_taken=="-"){json[i].r_method_not_taken = 0;} 
                                    if(json[i].r_pregnet=="-"){json[i].r_pregnet = 0;} 
                                    if(json[i].r_tot_child=="-"){json[i].r_tot_child = 0;} 
                                    if(json[i].r_husband_foreign=="-"){json[i].r_husband_foreign = 0;} 
                                    //Sum Calculation
                                    r_30to39_total_pill = r_30to39_total_pill + json[i].r_pill ;
                                    r_30to39_total_condom = r_30to39_total_condom + json[i].r_condom ;
                                    r_30to39_total_inject = r_30to39_total_inject + json[i].r_injectable ;
                                    r_30to39_total_iud = r_30to39_total_iud + json[i].r_iud ;
                                    r_30to39_total_implant = r_30to39_total_implant + json[i].r_implant ;
                                    r_30to39_total_permanent_man = r_30to39_total_permanent_man + json[i].r_fm_man ;
                                    r_30to39_total_permanent_woman = r_30to39_total_permanent_woman + json[i].r_fm_woman ;
                                    r_30to39_total_notTaken = r_30to39_total_notTaken + json[i].r_method_not_taken ;
                                    r_30to39_total_pregnant = r_30to39_total_pregnant + json[i].r_pregnet ;
                                    r_30to39_total_totalNoOfChild = r_30to39_total_totalNoOfChild + json[i].r_tot_child ;
                                    r_30to39_total_husbandAbroad = r_30to39_total_husbandAbroad + json[i].r_husband_foreign ;
                                    
                                    //sum for (total) column
                                    r_30to39_two_total =  json[i].r_pill + json[i].r_condom + json[i].r_injectable + json[i].r_iud + json[i].r_implant + json[i].r_fm_man + json[i].r_fm_woman ;
                                    
                                    //Bottom total sum
                                    r_allTotal_two_pill = r_allTotal_two_pill + json[i].r_pill ;
                                    r_allTotal_two_condom = r_allTotal_two_condom + json[i].r_condom ;
                                    r_allTotal_two_inject = r_allTotal_two_inject + json[i].r_injectable ;
                                    r_allTotal_two_iud = r_allTotal_two_iud + json[i].r_iud ;
                                    r_allTotal_two_implant = r_allTotal_two_implant + json[i].r_implant ;
                                    r_allTotal_two_permanent_man = r_allTotal_two_permanent_man + json[i].r_fm_man ;
                                    r_allTotal_two_permanent_woman = r_allTotal_two_permanent_woman + json[i].r_fm_woman ;
                                    r_allTotal_two_notTaken = r_allTotal_two_notTaken +  json[i].r_method_not_taken ;
                                    r_allTotal_two_pregnant = r_allTotal_two_pregnant +  json[i].r_pregnet ;
                                    r_allTotal_two_totalNoOfChild = r_allTotal_two_totalNoOfChild +  json[i].r_tot_child ;
                                    r_allTotal_two_husbandAbroad = r_allTotal_two_husbandAbroad +  json[i].r_husband_foreign ;
                                }
                                //For 3+ child
                                if(json[i].r_child===3){
                                    //set data to table
                                    $('#r_30to39_three_pill').html(json[i].r_pill);
                                    $('#r_30to39_three_condom').html(json[i].r_condom);
                                    $('#r_30to39_three_inject').html(json[i].r_injectable);
                                    $('#r_30to39_three_iud').html(json[i].r_iud);
                                    $('#r_30to39_three_implant').html(json[i].r_implant);
                                    $('#r_30to39_three_permanent_man').html(json[i].r_fm_man);
                                    $('#r_30to39_three_permanent_woman').html(json[i].r_fm_woman);
                                    $('#r_30to39_three_notTaken').html(json[i].r_method_not_taken);
                                    $('#r_30to39_three_pregnant').html(json[i].r_pregnet);
                                    $('#r_30to39_three_totalNoOfChild').html(json[i].r_tot_child);
                                    $('#r_30to39_three_husbandAbroad').html(json[i].r_husband_foreign);
                                    //Null checking 
                                    if(json[i].r_pill=="-"){json[i].r_pill = 0;}
                                    if(json[i].r_condom=="-"){json[i].r_condom = 0;}
                                    if(json[i].r_injectable=="-"){json[i].r_injectable = 0;}
                                    if(json[i].r_iud=="-"){json[i].r_iud = 0;}
                                    if(json[i].r_implant=="-"){json[i].r_implant = 0;}
                                    if(json[i].r_fm_man=="-"){json[i].r_fm_man = 0;}
                                    if(json[i].r_fm_woman=="-"){json[i].r_fm_woman = 0;}
                                    if(json[i].r_method_not_taken=="-"){json[i].r_method_not_taken = 0;} 
                                    if(json[i].r_pregnet=="-"){json[i].r_pregnet = 0;} 
                                    if(json[i].r_tot_child=="-"){json[i].r_tot_child = 0;} 
                                    if(json[i].r_husband_foreign=="-"){json[i].r_husband_foreign = 0;} 
                                    //Sum Calculation
                                    r_30to39_total_pill = r_30to39_total_pill + json[i].r_pill ;
                                    r_30to39_total_condom = r_30to39_total_condom + json[i].r_condom ;
                                    r_30to39_total_inject = r_30to39_total_inject + json[i].r_injectable ;
                                    r_30to39_total_iud = r_30to39_total_iud + json[i].r_iud ;
                                    r_30to39_total_implant = r_30to39_total_implant + json[i].r_implant ;
                                    r_30to39_total_permanent_man = r_30to39_total_permanent_man + json[i].r_fm_man ;
                                    r_30to39_total_permanent_woman = r_30to39_total_permanent_woman + json[i].r_fm_woman ;
                                    r_30to39_total_notTaken = r_30to39_total_notTaken + json[i].r_method_not_taken ;
                                    r_30to39_total_pregnant = r_30to39_total_pregnant + json[i].r_pregnet ;
                                    r_30to39_total_totalNoOfChild = r_30to39_total_totalNoOfChild + json[i].r_tot_child ;
                                    r_30to39_total_husbandAbroad = r_30to39_total_husbandAbroad + json[i].r_husband_foreign ;
                                    
                                    //sum for (total) column
                                    r_30to39_three_total =  json[i].r_pill + json[i].r_condom + json[i].r_injectable + json[i].r_iud + json[i].r_implant + json[i].r_fm_man + json[i].r_fm_woman ;
                                    
                                    //Bottom total sum
                                    r_allTotal_three_pill = r_allTotal_three_pill + json[i].r_pill ;
                                    r_allTotal_three_condom = r_allTotal_three_condom + json[i].r_condom ;
                                    r_allTotal_three_inject = r_allTotal_three_inject + json[i].r_injectable ;
                                    r_allTotal_three_iud = r_allTotal_three_iud + json[i].r_iud ;
                                    r_allTotal_three_implant = r_allTotal_three_implant + json[i].r_implant ;
                                    r_allTotal_three_permanent_man = r_allTotal_three_permanent_man + json[i].r_fm_man ;
                                    r_allTotal_three_permanent_woman = r_allTotal_three_permanent_woman + json[i].r_fm_woman ;
                                    r_allTotal_three_notTaken = r_allTotal_three_notTaken +  json[i].r_method_not_taken ;
                                    r_allTotal_three_pregnant = r_allTotal_three_pregnant +  json[i].r_pregnet ;
                                    r_allTotal_three_totalNoOfChild = r_allTotal_three_totalNoOfChild +  json[i].r_tot_child ;
                                    r_allTotal_three_husbandAbroad = r_allTotal_three_husbandAbroad +  json[i].r_husband_foreign ;
                                }
                            }
                            
                            //For age range 40-49
                            if(json[i].r_age===4){
                                //For 0 child
                                if(json[i].r_child===0){
                                    //set data to table
                                    $('#r_40to49_zero_pill').html(json[i].r_pill);
                                    $('#r_40to49_zero_condom').html(json[i].r_condom);
                                    $('#r_40to49_zero_inject').html(json[i].r_injectable);
                                    $('#r_40to49_zero_iud').html(json[i].r_iud);
                                    $('#r_40to49_zero_implant').html(json[i].r_implant);
                                    $('#r_40to49_zero_permanent_man').html(json[i].r_fm_man);
                                    $('#r_40to49_zero_permanent_woman').html(json[i].r_fm_woman);
                                    $('#r_40to49_zero_notTaken').html(json[i].r_method_not_taken);
                                    $('#r_40to49_zero_pregnant').html(json[i].r_pregnet);
                                    $('#r_40to49_zero_totalNoOfChild').html(json[i].r_tot_child);
                                    $('#r_40to49_zero_husbandAbroad').html(json[i].r_husband_foreign);
                                    //Null checking 
                                    if(json[i].r_pill=="-"){json[i].r_pill = 0;}
                                    if(json[i].r_condom=="-"){json[i].r_condom = 0;}
                                    if(json[i].r_injectable=="-"){json[i].r_injectable = 0;}
                                    if(json[i].r_iud=="-"){json[i].r_iud = 0;}
                                    if(json[i].r_implant=="-"){json[i].r_implant = 0;}
                                    if(json[i].r_fm_man=="-"){json[i].r_fm_man = 0;}
                                    if(json[i].r_fm_woman=="-"){json[i].r_fm_woman = 0;}
                                    if(json[i].r_method_not_taken=="-"){json[i].r_method_not_taken = 0;} 
                                    if(json[i].r_pregnet=="-"){json[i].r_pregnet = 0;} 
                                    if(json[i].r_tot_child=="-"){json[i].r_tot_child = 0;} 
                                    if(json[i].r_husband_foreign=="-"){json[i].r_husband_foreign = 0;} 
                                    //Sum Calculation
                                    r_40to49_total_pill = r_40to49_total_pill + json[i].r_pill ;
                                    r_40to49_total_condom = r_40to49_total_condom + json[i].r_condom ;
                                    r_40to49_total_inject = r_40to49_total_inject + json[i].r_injectable ;
                                    r_40to49_total_iud = r_40to49_total_iud + json[i].r_iud ;
                                    r_40to49_total_implant = r_40to49_total_implant + json[i].r_implant ;
                                    r_40to49_total_permanent_man = r_40to49_total_permanent_man + json[i].r_fm_man ;
                                    r_40to49_total_permanent_woman = r_40to49_total_permanent_woman + json[i].r_fm_woman ;
                                    r_40to49_total_notTaken = r_40to49_total_notTaken + json[i].r_method_not_taken ;
                                    r_40to49_total_pregnant = r_40to49_total_pregnant + json[i].r_pregnet ;
                                    r_40to49_total_totalNoOfChild = r_40to49_total_totalNoOfChild + json[i].r_tot_child ;
                                    r_40to49_total_husbandAbroad = r_40to49_total_husbandAbroad + json[i].r_husband_foreign ;
                                    
                                    //sum for (total) column
                                    r_40to49_zero_total =  json[i].r_pill + json[i].r_condom + json[i].r_injectable + json[i].r_iud + json[i].r_implant + json[i].r_fm_man + json[i].r_fm_woman ;
                                    
                                    //Bottom total sum
                                    r_allTotal_zero_pill = r_allTotal_zero_pill +  json[i].r_pill ;
                                    r_allTotal_zero_condom = r_allTotal_zero_condom +  json[i].r_condom ;
                                    r_allTotal_zero_inject = r_allTotal_zero_inject +  json[i].r_injectable ;
                                    r_allTotal_zero_iud = r_allTotal_zero_iud +  json[i].r_iud ;
                                    r_allTotal_zero_implant = r_allTotal_zero_implant +  json[i].r_implant ;
                                    r_allTotal_zero_permanent_man = r_allTotal_zero_permanent_man +  json[i].r_fm_man ;
                                    r_allTotal_zero_permanent_woman = r_allTotal_zero_permanent_woman +  json[i].r_fm_woman ;
                                    r_allTotal_zero_notTaken = r_allTotal_zero_notTaken +  json[i].r_method_not_taken ;
                                    r_allTotal_zero_pregnant = r_allTotal_zero_pregnant +  json[i].r_pregnet ;
                                    r_allTotal_zero_totalNoOfChild = r_allTotal_zero_totalNoOfChild +  json[i].r_tot_child ;
                                    r_allTotal_zero_husbandAbroad = r_allTotal_zero_husbandAbroad +  json[i].r_husband_foreign ;
                                }
                                //For 1 child
                                if(json[i].r_child===1){
                                    //set data to table
                                    $('#r_40to49_one_pill').html(json[i].r_pill);    
                                    $('#r_40to49_one_condom').html(json[i].r_condom); 
                                    $('#r_40to49_one_inject').html(json[i].r_injectable);
                                    $('#r_40to49_one_iud').html(json[i].r_iud);
                                    $('#r_40to49_one_implant').html(json[i].r_implant);
                                    $('#r_40to49_one_permanent_man').html(json[i].r_fm_man);
                                    $('#r_40to49_one_permanent_woman').html(json[i].r_fm_woman);
                                    $('#r_40to49_one_notTaken').html(json[i].r_method_not_taken);
                                    $('#r_40to49_one_pregnant').html(json[i].r_pregnet);
                                    $('#r_40to49_one_totalNoOfChild').html(json[i].r_tot_child);
                                    $('#r_40to49_one_husbandAbroad').html(json[i].r_husband_foreign);
                                    //Null checking 
                                    if(json[i].r_pill=="-"){json[i].r_pill = 0;}
                                    if(json[i].r_condom=="-"){json[i].r_condom = 0;}
                                    if(json[i].r_injectable=="-"){json[i].r_injectable = 0;}
                                    if(json[i].r_iud=="-"){json[i].r_iud = 0;}
                                    if(json[i].r_implant=="-"){json[i].r_implant = 0;}
                                    if(json[i].r_fm_man=="-"){json[i].r_fm_man = 0;}
                                    if(json[i].r_fm_woman=="-"){json[i].r_fm_woman = 0;}
                                    if(json[i].r_method_not_taken=="-"){json[i].r_method_not_taken = 0;} 
                                    if(json[i].r_pregnet=="-"){json[i].r_pregnet = 0;} 
                                    if(json[i].r_tot_child=="-"){json[i].r_tot_child = 0;} 
                                    if(json[i].r_husband_foreign=="-"){json[i].r_husband_foreign = 0;} 
                                    //Sum Calculation
                                    r_40to49_total_pill = r_40to49_total_pill + json[i].r_pill ;
                                    r_40to49_total_condom = r_40to49_total_condom + json[i].r_condom ;
                                    r_40to49_total_inject = r_40to49_total_inject + json[i].r_injectable ;
                                    r_40to49_total_iud = r_40to49_total_iud + json[i].r_iud ;
                                    r_40to49_total_implant = r_40to49_total_implant + json[i].r_implant ;
                                    r_40to49_total_permanent_man = r_40to49_total_permanent_man + json[i].r_fm_man ;
                                    r_40to49_total_permanent_woman = r_40to49_total_permanent_woman + json[i].r_fm_woman ;
                                    r_40to49_total_notTaken = r_40to49_total_notTaken + json[i].r_method_not_taken ;
                                    r_40to49_total_pregnant = r_40to49_total_pregnant + json[i].r_pregnet ;
                                    r_40to49_total_totalNoOfChild = r_40to49_total_totalNoOfChild + json[i].r_tot_child ;
                                    r_40to49_total_husbandAbroad = r_40to49_total_husbandAbroad + json[i].r_husband_foreign ;
                                    
                                    //sum for (total) column
                                    r_40to49_one_total =  json[i].r_pill + json[i].r_condom + json[i].r_injectable + json[i].r_iud + json[i].r_implant + json[i].r_fm_man + json[i].r_fm_woman ;
                                    
                                    //Bottom total sum
                                    r_allTotal_one_pill = r_allTotal_one_pill + json[i].r_pill ;
                                    r_allTotal_one_condom = r_allTotal_one_condom + json[i].r_condom ;
                                    r_allTotal_one_inject = r_allTotal_one_inject + json[i].r_injectable ;
                                    r_allTotal_one_iud = r_allTotal_one_iud + json[i].r_iud ;
                                    r_allTotal_one_implant = r_allTotal_one_implant + json[i].r_implant ;
                                    r_allTotal_one_permanent_man = r_allTotal_one_permanent_man + json[i].r_fm_man ;
                                    r_allTotal_one_permanent_woman = r_allTotal_one_permanent_woman + json[i].r_fm_woman ;
                                    r_allTotal_one_notTaken = r_allTotal_one_notTaken +  json[i].r_method_not_taken ;
                                    r_allTotal_one_pregnant = r_allTotal_one_pregnant +  json[i].r_pregnet ;
                                    r_allTotal_one_totalNoOfChild = r_allTotal_one_totalNoOfChild +  json[i].r_tot_child ;
                                    r_allTotal_one_husbandAbroad = r_allTotal_one_husbandAbroad +  json[i].r_husband_foreign ;
                                }
                                //For 2 child
                                if(json[i].r_child===2){
                                    //set data to table
                                    $('#r_40to49_two_pill').html(json[i].r_pill);
                                    $('#r_40to49_two_condom').html(json[i].r_condom);
                                    $('#r_40to49_two_inject').html(json[i].r_injectable);
                                    $('#r_40to49_two_iud').html(json[i].r_iud);
                                    $('#r_40to49_two_implant').html(json[i].r_implant);
                                    $('#r_40to49_two_permanent_man').html(json[i].r_fm_man);
                                    $('#r_40to49_two_permanent_woman').html(json[i].r_fm_woman);
                                    $('#r_40to49_two_notTaken').html(json[i].r_method_not_taken);
                                    $('#r_40to49_two_pregnant').html(json[i].r_pregnet);
                                    $('#r_40to49_two_totalNoOfChild').html(json[i].r_tot_child);
                                    $('#r_40to49_two_husbandAbroad').html(json[i].r_husband_foreign);
                                    //Null checking 
                                    if(json[i].r_pill=="-"){json[i].r_pill = 0;}
                                    if(json[i].r_condom=="-"){json[i].r_condom = 0;}
                                    if(json[i].r_injectable=="-"){json[i].r_injectable = 0;}
                                    if(json[i].r_iud=="-"){json[i].r_iud = 0;}
                                    if(json[i].r_implant=="-"){json[i].r_implant = 0;}
                                    if(json[i].r_fm_man=="-"){json[i].r_fm_man = 0;}
                                    if(json[i].r_fm_woman=="-"){json[i].r_fm_woman = 0;}
                                    if(json[i].r_method_not_taken=="-"){json[i].r_method_not_taken = 0;} 
                                    if(json[i].r_pregnet=="-"){json[i].r_pregnet = 0;} 
                                    if(json[i].r_tot_child=="-"){json[i].r_tot_child = 0;} 
                                    if(json[i].r_husband_foreign=="-"){json[i].r_husband_foreign = 0;} 
                                    //Sum Calculation
                                    r_40to49_total_pill = r_40to49_total_pill + json[i].r_pill ;
                                    r_40to49_total_condom = r_40to49_total_condom + json[i].r_condom ;
                                    r_40to49_total_inject = r_40to49_total_inject + json[i].r_injectable ;
                                    r_40to49_total_iud = r_40to49_total_iud + json[i].r_iud ;
                                    r_40to49_total_implant = r_40to49_total_implant + json[i].r_implant ;
                                    r_40to49_total_permanent_man = r_40to49_total_permanent_man + json[i].r_fm_man ;
                                    r_40to49_total_permanent_woman = r_40to49_total_permanent_woman + json[i].r_fm_woman ;
                                    r_40to49_total_notTaken = r_40to49_total_notTaken + json[i].r_method_not_taken ;
                                    r_40to49_total_pregnant = r_40to49_total_pregnant + json[i].r_pregnet ;
                                    r_40to49_total_totalNoOfChild = r_40to49_total_totalNoOfChild + json[i].r_tot_child ;
                                    r_40to49_total_husbandAbroad = r_40to49_total_husbandAbroad + json[i].r_husband_foreign ;
                                    
                                    //sum for (total) column
                                    r_40to49_two_total =  json[i].r_pill + json[i].r_condom + json[i].r_injectable + json[i].r_iud + json[i].r_implant + json[i].r_fm_man + json[i].r_fm_woman ;
                                    
                                    //Bottom total sum
                                    r_allTotal_two_pill = r_allTotal_two_pill + json[i].r_pill ;
                                    r_allTotal_two_condom = r_allTotal_two_condom + json[i].r_condom ;
                                    r_allTotal_two_inject = r_allTotal_two_inject + json[i].r_injectable ;
                                    r_allTotal_two_iud = r_allTotal_two_iud + json[i].r_iud ;
                                    r_allTotal_two_implant = r_allTotal_two_implant + json[i].r_implant ;
                                    r_allTotal_two_permanent_man = r_allTotal_two_permanent_man + json[i].r_fm_man ;
                                    r_allTotal_two_permanent_woman = r_allTotal_two_permanent_woman + json[i].r_fm_woman ;
                                    r_allTotal_two_notTaken = r_allTotal_two_notTaken +  json[i].r_method_not_taken ;
                                    r_allTotal_two_pregnant = r_allTotal_two_pregnant +  json[i].r_pregnet ;
                                    r_allTotal_two_totalNoOfChild = r_allTotal_two_totalNoOfChild +  json[i].r_tot_child ;
                                    r_allTotal_two_husbandAbroad = r_allTotal_two_husbandAbroad +  json[i].r_husband_foreign ;
                                }
                                //For 3+ child
                                if(json[i].r_child===3){
                                    //set data to table
                                    $('#r_40to49_three_pill').html(json[i].r_pill);
                                    $('#r_40to49_three_condom').html(json[i].r_condom);
                                    $('#r_40to49_three_inject').html(json[i].r_injectable);
                                    $('#r_40to49_three_iud').html(json[i].r_iud);
                                    $('#r_40to49_three_implant').html(json[i].r_implant);
                                    $('#r_40to49_three_permanent_man').html(json[i].r_fm_man);
                                    $('#r_40to49_three_permanent_woman').html(json[i].r_fm_woman);
                                    $('#r_40to49_three_notTaken').html(json[i].r_method_not_taken);
                                    $('#r_40to49_three_pregnant').html(json[i].r_pregnet);
                                    $('#r_40to49_three_totalNoOfChild').html(json[i].r_tot_child);
                                    $('#r_40to49_three_husbandAbroad').html(json[i].r_husband_foreign);
                                    //Null checking 
                                    if(json[i].r_pill=="-"){json[i].r_pill = 0;}
                                    if(json[i].r_condom=="-"){json[i].r_condom = 0;}
                                    if(json[i].r_injectable=="-"){json[i].r_injectable = 0;}
                                    if(json[i].r_iud=="-"){json[i].r_iud = 0;}
                                    if(json[i].r_implant=="-"){json[i].r_implant = 0;}
                                    if(json[i].r_fm_man=="-"){json[i].r_fm_man = 0;}
                                    if(json[i].r_fm_woman=="-"){json[i].r_fm_woman = 0;}
                                    if(json[i].r_method_not_taken=="-"){json[i].r_method_not_taken = 0;} 
                                    if(json[i].r_pregnet=="-"){json[i].r_pregnet = 0;} 
                                    if(json[i].r_tot_child=="-"){json[i].r_tot_child = 0;} 
                                    if(json[i].r_husband_foreign=="-"){json[i].r_husband_foreign = 0;} 
                                    //Sum Calculation
                                    r_40to49_total_pill = r_40to49_total_pill + json[i].r_pill ;
                                    r_40to49_total_condom = r_40to49_total_condom + json[i].r_condom ;
                                    r_40to49_total_inject = r_40to49_total_inject + json[i].r_injectable ;
                                    r_40to49_total_iud = r_40to49_total_iud + json[i].r_iud ;
                                    r_40to49_total_implant = r_40to49_total_implant + json[i].r_implant ;
                                    r_40to49_total_permanent_man = r_40to49_total_permanent_man + json[i].r_fm_man ;
                                    r_40to49_total_permanent_woman = r_40to49_total_permanent_woman + json[i].r_fm_woman ;
                                    r_40to49_total_notTaken = r_40to49_total_notTaken + json[i].r_method_not_taken ;
                                    r_40to49_total_pregnant = r_40to49_total_pregnant + json[i].r_pregnet ;
                                    r_40to49_total_totalNoOfChild = r_40to49_total_totalNoOfChild + json[i].r_tot_child ;
                                    r_40to49_total_husbandAbroad = r_40to49_total_husbandAbroad + json[i].r_husband_foreign ;
                                    
                                    //sum for (total) column
                                    r_40to49_three_total =  json[i].r_pill + json[i].r_condom + json[i].r_injectable + json[i].r_iud + json[i].r_implant + json[i].r_fm_man + json[i].r_fm_woman ;
                                    
                                    //Bottom total sum
                                    r_allTotal_three_pill = r_allTotal_three_pill + json[i].r_pill ;
                                    r_allTotal_three_condom = r_allTotal_three_condom + json[i].r_condom ;
                                    r_allTotal_three_inject = r_allTotal_three_inject + json[i].r_injectable ;
                                    r_allTotal_three_iud = r_allTotal_three_iud + json[i].r_iud ;
                                    r_allTotal_three_implant = r_allTotal_three_implant + json[i].r_implant ;
                                    r_allTotal_three_permanent_man = r_allTotal_three_permanent_man + json[i].r_fm_man ;
                                    r_allTotal_three_permanent_woman = r_allTotal_three_permanent_woman + json[i].r_fm_woman ;
                                    r_allTotal_three_notTaken = r_allTotal_three_notTaken +  json[i].r_method_not_taken ;
                                    r_allTotal_three_pregnant = r_allTotal_three_pregnant +  json[i].r_pregnet ;
                                    r_allTotal_three_totalNoOfChild = r_allTotal_three_totalNoOfChild +  json[i].r_tot_child ;
                                    r_allTotal_three_husbandAbroad = r_allTotal_three_husbandAbroad +  json[i].r_husband_foreign ;
                                }
                            }
                            
                            
                            
                            
                        }//End json loop
                        //Sum ror row total portion
                        //Pill
                        $('#r_lessThan20_total_pill').html(r_lessThan20_total_pill==0?'-':'<b>'+r_lessThan20_total_pill+'<b>');
                        $('#r_20to29_total_pill').html(r_20to29_total_pill==0?'-':'<b>'+r_20to29_total_pill+'<b>');
                        $('#r_30to39_total_pill').html(r_30to39_total_pill==0?'-':'<b>'+r_30to39_total_pill+'<b>');
                        $('#r_40to49_total_pill').html(r_40to49_total_pill==0?'-':'<b>'+r_40to49_total_pill+'<b>');
                        //Condom
                        $('#r_lessThan20_total_condom').html(r_lessThan20_total_condom==0?'-':'<b>'+r_lessThan20_total_condom+'<b>');
                        $('#r_20to29_total_condom').html(r_20to29_total_condom==0?'-':'<b>'+r_20to29_total_condom+'<b>');
                        $('#r_30to39_total_condom').html(r_30to39_total_condom==0?'-':'<b>'+r_30to39_total_condom+'<b>');
                        $('#r_40to49_total_condom').html(r_40to49_total_condom==0?'-':'<b>'+r_40to49_total_condom+'<b>');
                        //injectable
                        $('#r_lessThan20_total_inject').html(r_lessThan20_total_inject==0?'-':'<b>'+r_lessThan20_total_inject+'<b>');
                        $('#r_20to29_total_inject').html(r_20to29_total_inject==0?'-':'<b>'+r_20to29_total_inject+'<b>');
                        $('#r_30to39_total_inject').html(r_30to39_total_inject==0?'-':'<b>'+r_30to39_total_inject+'<b>');
                        $('#r_40to49_total_inject').html(r_40to49_total_inject==0?'-':'<b>'+r_40to49_total_inject+'<b>');
                        //Iud
                        $('#r_lessThan20_total_iud').html(r_lessThan20_total_iud==0?'-':'<b>'+r_lessThan20_total_iud+'<b>');
                        $('#r_20to29_total_iud').html(r_20to29_total_iud==0?'-':'<b>'+r_20to29_total_iud+'<b>');
                        $('#r_30to39_total_iud').html(r_30to39_total_iud==0?'-':'<b>'+r_30to39_total_iud+'<b>');
                        $('#r_40to49_total_iud').html(r_40to49_total_iud==0?'-':'<b>'+r_40to49_total_iud+'<b>');
                        //Implant
                        $('#r_lessThan20_total_implant').html(r_lessThan20_total_implant==0?'-':'<b>'+r_lessThan20_total_implant+'<b>');
                        $('#r_20to29_total_implant').html(r_20to29_total_implant==0?'-':'<b>'+r_20to29_total_implant+'<b>');
                        $('#r_30to39_total_implant').html(r_30to39_total_implant==0?'-':'<b>'+r_30to39_total_implant+'<b>');
                        $('#r_40to49_total_implant').html(r_40to49_total_implant==0?'-':'<b>'+r_40to49_total_implant+'<b>');
                        //permanent_man
                        $('#r_lessThan20_total_permanent_man').html(r_lessThan20_total_permanent_man==0?'-':'<b>'+r_lessThan20_total_permanent_man+'<b>');
                        $('#r_20to29_total_permanent_man').html(r_20to29_total_permanent_man==0?'-':'<b>'+r_20to29_total_permanent_man+'<b>');
                        $('#r_30to39_total_permanent_man').html(r_30to39_total_permanent_man==0?'-':'<b>'+r_30to39_total_permanent_man+'<b>');
                        $('#r_40to49_total_permanent_man').html(r_40to49_total_permanent_man==0?'-':'<b>'+r_40to49_total_permanent_man+'<b>');
                        //permanent_woman
                        $('#r_lessThan20_total_permanent_woman').html(r_lessThan20_total_permanent_woman==0?'-':'<b>'+r_lessThan20_total_permanent_woman+'<b>');
                        $('#r_20to29_total_permanent_woman').html(r_20to29_total_permanent_woman==0?'-':'<b>'+r_20to29_total_permanent_woman+'<b>');
                        $('#r_30to39_total_permanent_woman').html(r_30to39_total_permanent_woman==0?'-':'<b>'+r_30to39_total_permanent_woman+'<b>');
                        $('#r_40to49_total_permanent_woman').html(r_40to49_total_permanent_woman==0?'-':'<b>'+r_40to49_total_permanent_woman+'<b>');
                        //Method not taken
                        $('#r_lessThan20_total_notTaken').html(r_lessThan20_total_notTaken==0?'-':'<b>'+r_lessThan20_total_notTaken+'<b>');
                        $('#r_20to29_total_notTaken').html(r_20to29_total_notTaken==0?'-':'<b>'+r_20to29_total_notTaken+'<b>');
                        $('#r_30to39_total_notTaken').html(r_30to39_total_notTaken==0?'-':'<b>'+r_30to39_total_notTaken+'<b>');
                        $('#r_40to49_total_notTaken').html(r_40to49_total_notTaken==0?'-':'<b>'+r_40to49_total_notTaken+'<b>');
                        //Pregnant
                        $('#r_lessThan20_total_pregnant').html(r_lessThan20_total_pregnant==0?'-':'<b>'+r_lessThan20_total_pregnant+'<b>');
                        $('#r_20to29_total_pregnant').html(r_20to29_total_pregnant==0?'-':'<b>'+r_20to29_total_pregnant+'<b>');
                        $('#r_30to39_total_pregnant').html(r_30to39_total_pregnant==0?'-':'<b>'+r_30to39_total_pregnant+'<b>');
                        $('#r_40to49_total_pregnant').html(r_40to49_total_pregnant==0?'-':'<b>'+r_40to49_total_pregnant+'<b>');
                        //No of total child
                        $('#r_lessThan20_total_totalNoOfChild').html(r_lessThan20_total_totalNoOfChild==0?'-':'<b>'+r_lessThan20_total_totalNoOfChild+'<b>');
                        $('#r_20to29_total_totalNoOfChild').html(r_20to29_total_totalNoOfChild==0?'-':'<b>'+r_20to29_total_totalNoOfChild+'<b>');
                        $('#r_30to39_total_totalNoOfChild').html(r_30to39_total_totalNoOfChild==0?'-':'<b>'+r_30to39_total_totalNoOfChild+'<b>');
                        $('#r_40to49_total_totalNoOfChild').html(r_40to49_total_totalNoOfChild==0?'-':'<b>'+r_40to49_total_totalNoOfChild+'<b>');
                        //Husband in Abroad
                        $('#r_lessThan20_total_husbandAbroad').html(r_lessThan20_total_husbandAbroad==0?'-':'<b>'+r_lessThan20_total_husbandAbroad+'<b>');
                        $('#r_20to29_total_husbandAbroad').html(r_20to29_total_husbandAbroad==0?'-':'<b>'+r_20to29_total_husbandAbroad+'<b>');
                        $('#r_30to39_total_husbandAbroad').html(r_30to39_total_husbandAbroad==0?'-':'<b>'+r_30to39_total_husbandAbroad+'<b>');
                        $('#r_40to49_total_husbandAbroad').html(r_40to49_total_husbandAbroad==0?'-':'<b>'+r_40to49_total_husbandAbroad+'<b>');
                        
                        
                        
                        //For total column
                        //Less than 20 sum
                        $('#r_lessThan20_zero_total').html(r_lessThan20_zero_total);
                        $('#r_lessThan20_one_total').html(r_lessThan20_one_total);
                        $('#r_lessThan20_two_total').html(r_lessThan20_two_total);
                        $('#r_lessThan20_three_total').html(r_lessThan20_three_total);
                        $('#r_lessThan20_total_total').html('<b>'+(r_lessThan20_total_pill + r_lessThan20_total_condom + r_lessThan20_total_inject + r_lessThan20_total_iud + r_lessThan20_total_implant + r_lessThan20_total_permanent_man + r_lessThan20_total_permanent_woman)+'</b>');
                        //20-29 sum
                        $('#r_20to29_zero_total').html(r_20to29_zero_total);
                        $('#r_20to29_one_total').html(r_20to29_one_total);
                        $('#r_20to29_two_total').html(r_20to29_two_total);
                        $('#r_20to29_three_total').html(r_20to29_three_total);
                        $('#r_20to29_total_total').html('<b>'+(r_20to29_total_pill + r_20to29_total_condom + r_20to29_total_inject + r_20to29_total_iud + r_20to29_total_implant + r_20to29_total_permanent_man + r_20to29_total_permanent_woman)+'</b>');
                        //30-39 sum
                        $('#r_30to39_zero_total').html(r_30to39_zero_total);
                        $('#r_30to39_one_total').html(r_30to39_one_total);
                        $('#r_30to39_two_total').html(r_30to39_two_total);
                        $('#r_30to39_three_total').html(r_30to39_three_total);
                        $('#r_30to39_total_total').html('<b>'+(r_30to39_total_pill + r_30to39_total_condom + r_30to39_total_inject + r_30to39_total_iud + r_30to39_total_implant + r_30to39_total_permanent_man + r_30to39_total_permanent_woman)+'</b>');
                        //40-49 sum
                        $('#r_40to49_zero_total').html(r_40to49_zero_total);
                        $('#r_40to49_one_total').html(r_40to49_one_total);
                        $('#r_40to49_two_total').html(r_40to49_two_total);
                        $('#r_40to49_three_total').html(r_40to49_three_total);
                        $('#r_40to49_total_total').html('<b>'+(r_40to49_total_pill + r_40to49_total_condom + r_40to49_total_inject + r_40to49_total_iud + r_40to49_total_implant + r_40to49_total_permanent_man + r_40to49_total_permanent_woman)+'</b>');
                        //40-49 sum
                        $('#r_40to49_zero_total').html(r_40to49_zero_total);
                        $('#r_40to49_one_total').html(r_40to49_one_total);
                        $('#r_40to49_two_total').html(r_40to49_two_total);
                        $('#r_40to49_three_total').html(r_40to49_three_total);
                        $('#r_40to49_total_total').html('<b>'+(r_40to49_total_pill + r_40to49_total_condom + r_40to49_total_inject + r_40to49_total_iud + r_40to49_total_implant + r_40to49_total_permanent_man + r_40to49_total_permanent_woman)+'</b>');
                        //All total sum
                        $('#r_allTotal_zero_total').html((r_allTotal_zero_pill + r_allTotal_zero_condom + r_allTotal_zero_inject + r_allTotal_zero_iud + r_allTotal_zero_implant + r_allTotal_zero_permanent_man + r_allTotal_zero_permanent_woman));
                        $('#r_allTotal_one_total').html((r_allTotal_one_pill + r_allTotal_one_condom + r_allTotal_one_inject + r_allTotal_one_iud + r_allTotal_one_implant + r_allTotal_one_permanent_man + r_allTotal_one_permanent_woman));
                        $('#r_allTotal_two_total').html((r_allTotal_two_pill + r_allTotal_two_condom + r_allTotal_two_inject + r_allTotal_two_iud + r_allTotal_two_implant + r_allTotal_two_permanent_man + r_allTotal_two_permanent_woman));
                        $('#r_allTotal_three_total').html((r_allTotal_three_pill + r_allTotal_three_condom + r_allTotal_three_inject + r_allTotal_three_iud + r_allTotal_three_implant + r_allTotal_three_permanent_man + r_allTotal_three_permanent_woman));
                        $('#r_allTotal_total_total').html('<b>'+((r_allTotal_zero_pill + r_allTotal_one_pill + r_allTotal_two_pill + r_allTotal_three_pill) + (r_allTotal_zero_condom + r_allTotal_one_condom + r_allTotal_two_condom + r_allTotal_three_condom) + (r_allTotal_zero_inject + r_allTotal_one_inject + r_allTotal_two_inject + r_allTotal_three_inject) + (r_allTotal_zero_iud + r_allTotal_one_iud + r_allTotal_two_iud + r_allTotal_three_iud) + (r_allTotal_zero_implant + r_allTotal_one_implant + r_allTotal_two_implant + r_allTotal_three_implant) + (r_allTotal_zero_permanent_man + r_allTotal_one_permanent_man + r_allTotal_two_permanent_man + r_allTotal_three_permanent_man) + (r_allTotal_zero_permanent_woman + r_allTotal_one_permanent_woman + r_allTotal_two_permanent_woman + r_allTotal_three_permanent_woman)));
                        
                        //Bottom all total portion
                        //Pill
                        $('#r_allTotal_zero_pill').html(r_allTotal_zero_pill==0?'-':r_allTotal_zero_pill);
                        $('#r_allTotal_one_pill').html(r_allTotal_one_pill==0?'-':r_allTotal_one_pill);
                        $('#r_allTotal_two_pill').html(r_allTotal_two_pill==0?'-':r_allTotal_two_pill);    
                        $('#r_allTotal_three_pill').html(r_allTotal_three_pill==0?'-':r_allTotal_two_pill);
                        $('#r_allTotal_total_pill').html((r_allTotal_zero_pill + r_allTotal_one_pill + r_allTotal_two_pill + r_allTotal_three_pill)==0?'-': '<b>'+(r_allTotal_zero_pill + r_allTotal_one_pill + r_allTotal_two_pill + r_allTotal_three_pill) +'</b>');
                        //Condom
                        $('#r_allTotal_zero_condom').html(r_allTotal_zero_condom==0?'-':r_allTotal_zero_condom);
                        $('#r_allTotal_one_condom').html(r_allTotal_one_condom==0?'-':r_allTotal_one_condom);  
                        $('#r_allTotal_two_condom').html(r_allTotal_two_condom==0?'-':r_allTotal_two_condom);    
                        $('#r_allTotal_three_condom').html(r_allTotal_three_condom==0?'-':r_allTotal_three_condom);
                        $('#r_allTotal_total_condom').html((r_allTotal_zero_condom + r_allTotal_one_condom + r_allTotal_two_condom + r_allTotal_three_condom)==0? '-' : '<b>'+(r_allTotal_zero_condom + r_allTotal_one_condom + r_allTotal_two_condom + r_allTotal_three_condom)+'</b>');
                        //Injectable
                        $('#r_allTotal_zero_inject').html(r_allTotal_zero_inject==0?'-':r_allTotal_zero_inject);
                        $('#r_allTotal_one_inject').html(r_allTotal_one_inject==0?'-':r_allTotal_one_inject);  
                        $('#r_allTotal_two_inject').html(r_allTotal_two_inject==0?'-':r_allTotal_two_inject);    
                        $('#r_allTotal_three_inject').html(r_allTotal_three_inject==0?'-':r_allTotal_three_inject);
                        $('#r_allTotal_total_inject').html((r_allTotal_zero_inject + r_allTotal_one_inject + r_allTotal_two_inject + r_allTotal_three_inject)==0?'-': '<b>'+(r_allTotal_zero_inject + r_allTotal_one_inject + r_allTotal_two_inject + r_allTotal_three_inject)+'</b>');
                        //Iud
                        $('#r_allTotal_zero_iud').html(r_allTotal_zero_iud==0?'-':r_allTotal_zero_iud);
                        $('#r_allTotal_one_iud').html(r_allTotal_one_iud==0?'-':r_allTotal_one_iud);  
                        $('#r_allTotal_two_iud').html(r_allTotal_two_iud==0?'-':r_allTotal_two_iud);    
                        $('#r_allTotal_three_iud').html(r_allTotal_three_iud==0?'-':r_allTotal_three_iud);
                        $('#r_allTotal_total_iud').html((r_allTotal_zero_iud + r_allTotal_one_iud + r_allTotal_two_iud + r_allTotal_three_iud)==0?'-': '<b>'+(r_allTotal_zero_iud + r_allTotal_one_iud + r_allTotal_two_iud + r_allTotal_three_iud)+'</b>');
                        //Implant
                        $('#r_allTotal_zero_implant').html(r_allTotal_zero_implant==0?'-':r_allTotal_zero_implant);
                        $('#r_allTotal_one_implant').html(r_allTotal_one_implant==0?'-':r_allTotal_one_implant);  
                        $('#r_allTotal_two_implant').html(r_allTotal_two_implant==0?'-':r_allTotal_two_implant);    
                        $('#r_allTotal_three_implant').html(r_allTotal_three_implant==0?'-':r_allTotal_three_implant);
                        $('#r_allTotal_total_implant').html((r_allTotal_zero_implant + r_allTotal_one_implant + r_allTotal_two_implant + r_allTotal_three_implant)==0?'-': '<b>'+(r_allTotal_zero_implant + r_allTotal_one_implant + r_allTotal_two_implant + r_allTotal_three_implant)+'</b>');
                        //permanent_man
                        $('#r_allTotal_zero_permanent_man').html(r_allTotal_zero_permanent_man==0?'-':r_allTotal_zero_permanent_man);
                        $('#r_allTotal_one_permanent_man').html(r_allTotal_one_permanent_man==0?'-':r_allTotal_one_permanent_man);  
                        $('#r_allTotal_two_permanent_man').html(r_allTotal_two_permanent_man==0?'-':r_allTotal_two_permanent_man);    
                        $('#r_allTotal_three_permanent_man').html(r_allTotal_three_permanent_man==0?'-':r_allTotal_three_permanent_man);
                        $('#r_allTotal_total_permanent_man').html((r_allTotal_zero_permanent_man + r_allTotal_one_permanent_man + r_allTotal_two_permanent_man + r_allTotal_three_permanent_man)==0?'-' : '<b>'+(r_allTotal_zero_permanent_man + r_allTotal_one_permanent_man + r_allTotal_two_permanent_man + r_allTotal_three_permanent_man)+'</b>');
                        //permanent_woman
                        $('#r_allTotal_zero_permanent_woman').html(r_allTotal_zero_permanent_woman==0?'-':r_allTotal_zero_permanent_woman);
                        $('#r_allTotal_one_permanent_woman').html(r_allTotal_one_permanent_woman==0?'-':r_allTotal_one_permanent_woman);  
                        $('#r_allTotal_two_permanent_woman').html(r_allTotal_two_permanent_woman==0?'-':r_allTotal_two_permanent_woman);    
                        $('#r_allTotal_three_permanent_woman').html(r_allTotal_three_permanent_woman==0?'-':r_allTotal_three_permanent_woman);
                        $('#r_allTotal_total_permanent_woman').html((r_allTotal_zero_permanent_woman + r_allTotal_one_permanent_woman + r_allTotal_two_permanent_woman + r_allTotal_three_permanent_woman)==0?'-': '<b>'+(r_allTotal_zero_permanent_woman + r_allTotal_one_permanent_woman + r_allTotal_two_permanent_woman + r_allTotal_three_permanent_woman)+'</b>');
                        //method not taken
                        $('#r_allTotal_zero_notTaken').html(r_allTotal_zero_notTaken==0?'-':r_allTotal_zero_notTaken);
                        $('#r_allTotal_one_notTaken').html(r_allTotal_one_notTaken==0?'-':r_allTotal_one_notTaken);
                        $('#r_allTotal_two_notTaken').html(r_allTotal_two_notTaken==0?'-':r_allTotal_two_notTaken);  
                        $('#r_allTotal_three_notTaken').html(r_allTotal_three_notTaken==0?'-':r_allTotal_three_notTaken);    
                        $('#r_allTotal_total_notTaken').html((r_allTotal_zero_notTaken + r_allTotal_one_notTaken + r_allTotal_two_notTaken + r_allTotal_three_notTaken)==0?'-': '<b>'+(r_allTotal_zero_notTaken + r_allTotal_one_notTaken + r_allTotal_two_notTaken + r_allTotal_three_notTaken)+'</b>');
                        //pregnant
                        $('#r_allTotal_zero_pregnant').html(r_allTotal_zero_pregnant==0?'-':r_allTotal_zero_pregnant);
                        $('#r_allTotal_one_pregnant').html(r_allTotal_one_pregnant==0?'-':r_allTotal_one_pregnant);
                        $('#r_allTotal_two_pregnant').html(r_allTotal_two_pregnant==0?'-':r_allTotal_two_pregnant);  
                        $('#r_allTotal_three_pregnant').html(r_allTotal_three_pregnant==0?'-':r_allTotal_three_pregnant);    
                        $('#r_allTotal_total_pregnant').html((r_allTotal_zero_pregnant + r_allTotal_one_pregnant + r_allTotal_two_pregnant + r_allTotal_three_pregnant)==0?'-':'<b>'+(r_allTotal_zero_pregnant + r_allTotal_one_pregnant + r_allTotal_two_pregnant + r_allTotal_three_pregnant)+'</b>');
                        //total No Of Child
                        $('#r_allTotal_zero_totalNoOfChild').html(r_allTotal_zero_totalNoOfChild==0?'-':r_allTotal_zero_totalNoOfChild);
                        $('#r_allTotal_one_totalNoOfChild').html(r_allTotal_one_totalNoOfChild==0?'-':r_allTotal_one_totalNoOfChild);
                        $('#r_allTotal_two_totalNoOfChild').html(r_allTotal_two_totalNoOfChild==0?'-':r_allTotal_two_totalNoOfChild);  
                        $('#r_allTotal_three_totalNoOfChild').html(r_allTotal_three_totalNoOfChild==0?'-':r_allTotal_three_totalNoOfChild);    
                        $('#r_allTotal_total_totalNoOfChild').html((r_allTotal_zero_totalNoOfChild + r_allTotal_one_totalNoOfChild + r_allTotal_two_totalNoOfChild + r_allTotal_three_totalNoOfChild)==0?'-':'<b>'+(r_allTotal_zero_totalNoOfChild + r_allTotal_one_totalNoOfChild + r_allTotal_two_totalNoOfChild + r_allTotal_three_totalNoOfChild)+'</b>');
                        //husband Abroad
                        $('#r_allTotal_zero_husbandAbroad').html(r_allTotal_zero_husbandAbroad==0?'-':r_allTotal_zero_husbandAbroad);
                        $('#r_allTotal_one_husbandAbroad').html(r_allTotal_one_husbandAbroad==0?'-':r_allTotal_one_husbandAbroad);
                        $('#r_allTotal_two_husbandAbroad').html(r_allTotal_two_husbandAbroad==0?'-':r_allTotal_two_husbandAbroad);  
                        $('#r_allTotal_three_husbandAbroad').html(r_allTotal_three_husbandAbroad==0?'-':r_allTotal_three_husbandAbroad);    
                        $('#r_allTotal_total_husbandAbroad').html((r_allTotal_zero_husbandAbroad + r_allTotal_one_husbandAbroad + r_allTotal_two_husbandAbroad + r_allTotal_three_husbandAbroad)==0?'-':'<b>'+(r_allTotal_zero_husbandAbroad + r_allTotal_one_husbandAbroad + r_allTotal_two_husbandAbroad + r_allTotal_three_husbandAbroad)+'</b>');
                    
                        $(".table-data table td").each(function () {
                            $(this).text(convertE2B($(this).text()));
                        });
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        btn.button('reset');
                        toastr["error"]("<h4><b>অনুরোধটি প্রক্রিয়াধীন করা যাচ্ছে না</b></h4>");
                    }
                }); //End Ajax
            }//End else
        });//End Button Click
        


    });
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1 id="pageTitle">ELCO by acceptor status</h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <%@include file="/WEB-INF/jspf/mis1AreaWithoutMonthBangla.jspf" %>
     <!--------------------------------------------------------------------------------Data Table Goes Here-------------------------------------------------------------------------------->  
    <div class="box box-primary full-screen">
            <div class="box-header with-border">
                <div class="box-tools pull-right" style="margin-top: -10px;">
                    <button type="button" class="btn btn-flat btn-default btn-xs bold" onclick="window.print();"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                    <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                </div>
            </div>
        <div class="box-body">
            <div  class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <h3 class="tableTitle"><center>সন্তান সংখ্যা অনুযায়ী এবং বয়স ভিত্তিক পদ্ধতি প্রহণকারী ও অগ্রহণকারী সক্ষম দম্পতিদের বিন্যাস ছক</center></h3>
                        <div class="table-data">
                            <table>
                                <thead class="center">
                                    <tr>
                                        <td rowspan="3" class="" style="width: 70px;">বয়সের বিন্যাস</td>
                                        <td rowspan="3" class="" style="width: 70px;">সন্তান সংখ্যার বিন্যাস</td>
                                        <td rowspan="1" colspan="8"><center>পদ্ধতি প্রহণকারী</center></td>
                                        <td rowspan="3" class="" style="width: 70px;">অগ্রহণকারী</td>
                                        <td rowspan="3" class="" style="width: 70px;">গর্ভবতী</td> 
                                        <td rowspan="3" class="" style="width: 70px;">মোট সন্তানের সংখ্যা</td>
                                        <td rowspan="3" class="" style="width: 70px;">স্বামী বিদেশে</td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2" style="width: 60px;">খাবার বড়ি</td>
                                        <td rowspan="2" style="width: 60px;">কনডম</td>
                                        <td rowspan="2" style="width: 60px;">ইনজেকটেবল</td>
                                        <td rowspan="2" style="width: 60px;">আই ইউ ডি</td>
                                        <td rowspan="2" style="width: 60px;">ইমপ্ল্যান্ট</td>
                                        <td colspan="2" style="width: 60px;">স্থায়ী পদ্ধতি</td>
                                        <td rowspan="2" style="width: 60px;">মোট</td>
                                    </tr>
                                    <tr>
                                        <td class="" style="width: 60px;">পুরুষ</td>
                                        <td class="" style="width: 60px;">মহিলা</td>
                                    </tr>
                                </thead>
                                <tbody id="tbody">
                                    <!--Firts Portion (<20)-->
                                    <tr>
                                        <td class="t_field rotate" rowspan="5"><২০</td>
                                        <td class="t_field">০</td>
                                        <td id="r_lessThan20_zero_pill" class="v_field"></td>
                                        <td id="r_lessThan20_zero_condom" class="v_field"></td>
                                        <td id="r_lessThan20_zero_inject" class="v_field"></td>
                                        <td id="r_lessThan20_zero_iud" class="v_field"></td>
                                        <td id="r_lessThan20_zero_implant" class="v_field"></td>
                                        <td id="r_lessThan20_zero_permanent_man" class="v_field"></td>
                                        <td id="r_lessThan20_zero_permanent_woman" class="v_field"></td>
                                        <td id="r_lessThan20_zero_total" class="v_field"></td>
                                        <td id="r_lessThan20_zero_notTaken" class="v_field"></td>
                                        <td id="r_lessThan20_zero_pregnant" class="v_field"></td>
                                        <td id="r_lessThan20_zero_totalNoOfChild" class="v_field"></td>
                                        <td id="r_lessThan20_zero_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">১</td>
                                        <td id="r_lessThan20_one_pill" class="v_field"></td>
                                        <td id="r_lessThan20_one_condom" class="v_field"></td>
                                        <td id="r_lessThan20_one_inject" class="v_field"></td>
                                        <td id="r_lessThan20_one_iud" class="v_field"></td>
                                        <td id="r_lessThan20_one_implant" class="v_field"></td>
                                        <td id="r_lessThan20_one_permanent_man" class="v_field"></td>
                                        <td id="r_lessThan20_one_permanent_woman" class="v_field"></td>
                                        <td id="r_lessThan20_one_total" class="v_field"></td>
                                        <td id="r_lessThan20_one_notTaken" class="v_field"></td>
                                        <td id="r_lessThan20_one_pregnant" class="v_field"></td>
                                        <td id="r_lessThan20_one_totalNoOfChild" class="v_field"></td>
                                        <td id="r_lessThan20_one_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">২</td>
                                        <td id="r_lessThan20_two_pill" class="v_field"></td>
                                        <td id="r_lessThan20_two_condom" class="v_field"></td>
                                        <td id="r_lessThan20_two_inject" class="v_field"></td>
                                        <td id="r_lessThan20_two_iud" class="v_field"></td>
                                        <td id="r_lessThan20_two_implant" class="v_field"></td>
                                        <td id="r_lessThan20_two_permanent_man" class="v_field"></td>
                                        <td id="r_lessThan20_two_permanent_woman" class="v_field"></td>
                                        <td id="r_lessThan20_two_total" class="v_field"></td>
                                        <td id="r_lessThan20_two_notTaken" class="v_field"></td>
                                        <td id="r_lessThan20_two_pregnant" class="v_field"></td>
                                        <td id="r_lessThan20_two_totalNoOfChild" class="v_field"></td>
                                        <td id="r_lessThan20_two_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">৩+</td>
                                        <td id="r_lessThan20_three_pill" class="v_field"></td>
                                        <td id="r_lessThan20_three_condom" class="v_field"></td>
                                        <td id="r_lessThan20_three_inject" class="v_field"></td>
                                        <td id="r_lessThan20_three_iud" class="v_field"></td>
                                        <td id="r_lessThan20_three_implant" class="v_field"></td>
                                        <td id="r_lessThan20_three_permanent_man" class="v_field"></td>
                                        <td id="r_lessThan20_three_permanent_woman" class="v_field"></td>
                                        <td id="r_lessThan20_three_total" class="v_field"></td>
                                        <td id="r_lessThan20_three_notTaken" class="v_field"></td>
                                        <td id="r_lessThan20_three_pregnant" class="v_field"></td>
                                        <td id="r_lessThan20_three_totalNoOfChild" class="v_field"></td>
                                        <td id="r_lessThan20_three_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">মোট</td>
                                        <td id="r_lessThan20_total_pill" class="v_field"></td>
                                        <td id="r_lessThan20_total_condom" class="v_field"></td>
                                        <td id="r_lessThan20_total_inject" class="v_field"></td>
                                        <td id="r_lessThan20_total_iud" class="v_field"></td>
                                        <td id="r_lessThan20_total_implant" class="v_field"></td>
                                        <td id="r_lessThan20_total_permanent_man" class="v_field"></td>
                                        <td id="r_lessThan20_total_permanent_woman" class="v_field"></td>
                                        <td id="r_lessThan20_total_total" class="v_field"></td>
                                        <td id="r_lessThan20_total_notTaken" class="v_field"></td>
                                        <td id="r_lessThan20_total_pregnant" class="v_field"></td>
                                        <td id="r_lessThan20_total_totalNoOfChild" class="v_field"></td>
                                        <td id="r_lessThan20_total_husbandAbroad" class="v_field"></td>   
                                    </tr>
                                    <!--End 1st Portion (<20)-->
                                    <!--2nd Portion (20-29)-->
                                    <tr>
                                        <td class="t_field rotate" rowspan="5">২০-২৯</td>
                                        <td class="t_field">০</td>
                                        <td id="r_20to29_zero_pill" class="v_field"></td>
                                        <td id="r_20to29_zero_condom" class="v_field"></td>
                                        <td id="r_20to29_zero_inject" class="v_field"></td>
                                        <td id="r_20to29_zero_iud" class="v_field"></td>
                                        <td id="r_20to29_zero_implant" class="v_field"></td>
                                        <td id="r_20to29_zero_permanent_man" class="v_field"></td>
                                        <td id="r_20to29_zero_permanent_woman" class="v_field"></td>
                                        <td id="r_20to29_zero_total" class="v_field"></td>
                                        <td id="r_20to29_zero_notTaken" class="v_field"></td>
                                        <td id="r_20to29_zero_pregnant" class="v_field"></td>
                                        <td id="r_20to29_zero_totalNoOfChild" class="v_field"></td>
                                        <td id="r_20to29_zero_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">১</td>
                                        <td id="r_20to29_one_pill" class="v_field"></td>
                                        <td id="r_20to29_one_condom" class="v_field"></td>
                                        <td id="r_20to29_one_inject" class="v_field"></td>
                                        <td id="r_20to29_one_iud" class="v_field"></td>
                                        <td id="r_20to29_one_implant" class="v_field"></td>
                                        <td id="r_20to29_one_permanent_man" class="v_field"></td>
                                        <td id="r_20to29_one_permanent_woman" class="v_field"></td>
                                        <td id="r_20to29_one_total" class="v_field"></td>
                                        <td id="r_20to29_one_notTaken" class="v_field"></td>
                                        <td id="r_20to29_one_pregnant" class="v_field"></td>
                                        <td id="r_20to29_one_totalNoOfChild" class="v_field"></td>
                                        <td id="r_20to29_one_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">২</td>
                                        <td id="r_20to29_two_pill" class="v_field"></td>
                                        <td id="r_20to29_two_condom" class="v_field"></td>
                                        <td id="r_20to29_two_inject" class="v_field"></td>
                                        <td id="r_20to29_two_iud" class="v_field"></td>
                                        <td id="r_20to29_two_implant" class="v_field"></td>
                                        <td id="r_20to29_two_permanent_man" class="v_field"></td>
                                        <td id="r_20to29_two_permanent_woman" class="v_field"></td>
                                        <td id="r_20to29_two_total" class="v_field"></td>
                                        <td id="r_20to29_two_notTaken" class="v_field"></td>
                                        <td id="r_20to29_two_pregnant" class="v_field"></td>
                                        <td id="r_20to29_two_totalNoOfChild" class="v_field"></td>
                                        <td id="r_20to29_two_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">৩+</td>
                                        <td id="r_20to29_three_pill" class="v_field"></td>
                                        <td id="r_20to29_three_condom" class="v_field"></td>
                                        <td id="r_20to29_three_inject" class="v_field"></td>
                                        <td id="r_20to29_three_iud" class="v_field"></td>
                                        <td id="r_20to29_three_implant" class="v_field"></td>
                                        <td id="r_20to29_three_permanent_man" class="v_field"></td>
                                        <td id="r_20to29_three_permanent_woman" class="v_field"></td>
                                        <td id="r_20to29_three_total" class="v_field"></td>
                                        <td id="r_20to29_three_notTaken" class="v_field"></td>
                                        <td id="r_20to29_three_pregnant" class="v_field"></td>
                                        <td id="r_20to29_three_totalNoOfChild" class="v_field"></td>
                                        <td id="r_20to29_three_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">মোট</td>
                                        <td id="r_20to29_total_pill" class="v_field"></td>
                                        <td id="r_20to29_total_condom" class="v_field"></td>
                                        <td id="r_20to29_total_inject" class="v_field"></td>
                                        <td id="r_20to29_total_iud" class="v_field"></td>
                                        <td id="r_20to29_total_implant" class="v_field"></td>
                                        <td id="r_20to29_total_permanent_man" class="v_field"></td>
                                        <td id="r_20to29_total_permanent_woman" class="v_field"></td>
                                        <td id="r_20to29_total_total" class="v_field"></td>
                                        <td id="r_20to29_total_notTaken" class="v_field"></td>
                                        <td id="r_20to29_total_pregnant" class="v_field"></td>
                                        <td id="r_20to29_total_totalNoOfChild" class="v_field"></td>
                                        <td id="r_20to29_total_husbandAbroad" class="v_field"></td>   
                                    </tr>
                                    <!--End 2nd Portion (20-29)-->
                                    <!--3rd Portion (30-39)-->
                                    <tr>
                                        <td class="t_field rotate" rowspan="5">৩০-৩৯</td>
                                        <td class="t_field">০</td>
                                        <td id="r_30to39_zero_pill" class="v_field"></td>
                                        <td id="r_30to39_zero_condom" class="v_field"></td>
                                        <td id="r_30to39_zero_inject" class="v_field"></td>
                                        <td id="r_30to39_zero_iud" class="v_field"></td>
                                        <td id="r_30to39_zero_implant" class="v_field"></td>
                                        <td id="r_30to39_zero_permanent_man" class="v_field"></td>
                                        <td id="r_30to39_zero_permanent_woman" class="v_field"></td>
                                        <td id="r_30to39_zero_total" class="v_field"></td>
                                        <td id="r_30to39_zero_notTaken" class="v_field"></td>
                                        <td id="r_30to39_zero_pregnant" class="v_field"></td>
                                        <td id="r_30to39_zero_totalNoOfChild" class="v_field"></td>
                                        <td id="r_30to39_zero_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">১</td>
                                        <td id="r_30to39_one_pill" class="v_field"></td>
                                        <td id="r_30to39_one_condom" class="v_field"></td>
                                        <td id="r_30to39_one_inject" class="v_field"></td>
                                        <td id="r_30to39_one_iud" class="v_field"></td>
                                        <td id="r_30to39_one_implant" class="v_field"></td>
                                        <td id="r_30to39_one_permanent_man" class="v_field"></td>
                                        <td id="r_30to39_one_permanent_woman" class="v_field"></td>
                                        <td id="r_30to39_one_total" class="v_field"></td>
                                        <td id="r_30to39_one_notTaken" class="v_field"></td>
                                        <td id="r_30to39_one_pregnant" class="v_field"></td>
                                        <td id="r_30to39_one_totalNoOfChild" class="v_field"></td>
                                        <td id="r_30to39_one_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">২</td>
                                        <td id="r_30to39_two_pill" class="v_field"></td>
                                        <td id="r_30to39_two_condom" class="v_field"></td>
                                        <td id="r_30to39_two_inject" class="v_field"></td>
                                        <td id="r_30to39_two_iud" class="v_field"></td>
                                        <td id="r_30to39_two_implant" class="v_field"></td>
                                        <td id="r_30to39_two_permanent_man" class="v_field"></td>
                                        <td id="r_30to39_two_permanent_woman" class="v_field"></td>
                                        <td id="r_30to39_two_total" class="v_field"></td>
                                        <td id="r_30to39_two_notTaken" class="v_field"></td>
                                        <td id="r_30to39_two_pregnant" class="v_field"></td>
                                        <td id="r_30to39_two_totalNoOfChild" class="v_field"></td>
                                        <td id="r_30to39_two_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">৩+</td>
                                        <td id="r_30to39_three_pill" class="v_field"></td>
                                        <td id="r_30to39_three_condom" class="v_field"></td>
                                        <td id="r_30to39_three_inject" class="v_field"></td>
                                        <td id="r_30to39_three_iud" class="v_field"></td>
                                        <td id="r_30to39_three_implant" class="v_field"></td>
                                        <td id="r_30to39_three_permanent_man" class="v_field"></td>
                                        <td id="r_30to39_three_permanent_woman" class="v_field"></td>
                                        <td id="r_30to39_three_total" class="v_field"></td>
                                        <td id="r_30to39_three_notTaken" class="v_field"></td>
                                        <td id="r_30to39_three_pregnant" class="v_field"></td>
                                        <td id="r_30to39_three_totalNoOfChild" class="v_field"></td>
                                        <td id="r_30to39_three_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">মোট</td>
                                        <td id="r_30to39_total_pill" class="v_field"></td>
                                        <td id="r_30to39_total_condom" class="v_field"></td>
                                        <td id="r_30to39_total_inject" class="v_field"></td>
                                        <td id="r_30to39_total_iud" class="v_field"></td>
                                        <td id="r_30to39_total_implant" class="v_field"></td>
                                        <td id="r_30to39_total_permanent_man" class="v_field"></td>
                                        <td id="r_30to39_total_permanent_woman" class="v_field"></td>
                                        <td id="r_30to39_total_total" class="v_field"></td>
                                        <td id="r_30to39_total_notTaken" class="v_field"></td>
                                        <td id="r_30to39_total_pregnant" class="v_field"></td>
                                        <td id="r_30to39_total_totalNoOfChild" class="v_field"></td>
                                        <td id="r_30to39_total_husbandAbroad" class="v_field"></td>   
                                    </tr>
                                    <!--End 3rd Portion (30-39)-->
                                    <!--4thd Portion (40-49)-->
                                    <tr>
                                        <td class="t_field rotate" rowspan="5">৪০-৪৯</td>
                                        <td class="t_field">০</td>
                                        <td id="r_40to49_zero_pill" class="v_field"></td>
                                        <td id="r_40to49_zero_condom" class="v_field"></td>
                                        <td id="r_40to49_zero_inject" class="v_field"></td>
                                        <td id="r_40to49_zero_iud" class="v_field"></td>
                                        <td id="r_40to49_zero_implant" class="v_field"></td>
                                        <td id="r_40to49_zero_permanent_man" class="v_field"></td>
                                        <td id="r_40to49_zero_permanent_woman" class="v_field"></td>
                                        <td id="r_40to49_zero_total" class="v_field"></td>
                                        <td id="r_40to49_zero_notTaken" class="v_field"></td>
                                        <td id="r_40to49_zero_pregnant" class="v_field"></td>
                                        <td id="r_40to49_zero_totalNoOfChild" class="v_field"></td>
                                        <td id="r_40to49_zero_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">১</td>
                                        <td id="r_40to49_one_pill" class="v_field"></td>
                                        <td id="r_40to49_one_condom" class="v_field"></td>
                                        <td id="r_40to49_one_inject" class="v_field"></td>
                                        <td id="r_40to49_one_iud" class="v_field"></td>
                                        <td id="r_40to49_one_implant" class="v_field"></td>
                                        <td id="r_40to49_one_permanent_man" class="v_field"></td>
                                        <td id="r_40to49_one_permanent_woman" class="v_field"></td>
                                        <td id="r_40to49_one_total" class="v_field"></td>
                                        <td id="r_40to49_one_notTaken" class="v_field"></td>
                                        <td id="r_40to49_one_pregnant" class="v_field"></td>
                                        <td id="r_40to49_one_totalNoOfChild" class="v_field"></td>
                                        <td id="r_40to49_one_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">২</td>
                                        <td id="r_40to49_two_pill" class="v_field"></td>
                                        <td id="r_40to49_two_condom" class="v_field"></td>
                                        <td id="r_40to49_two_inject" class="v_field"></td>
                                        <td id="r_40to49_two_iud" class="v_field"></td>
                                        <td id="r_40to49_two_implant" class="v_field"></td>
                                        <td id="r_40to49_two_permanent_man" class="v_field"></td>
                                        <td id="r_40to49_two_permanent_woman" class="v_field"></td>
                                        <td id="r_40to49_two_total" class="v_field"></td>
                                        <td id="r_40to49_two_notTaken" class="v_field"></td>
                                        <td id="r_40to49_two_pregnant" class="v_field"></td>
                                        <td id="r_40to49_two_totalNoOfChild" class="v_field"></td>
                                        <td id="r_40to49_two_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">৩+</td>
                                        <td id="r_40to49_three_pill" class="v_field"></td>
                                        <td id="r_40to49_three_condom" class="v_field"></td>
                                        <td id="r_40to49_three_inject" class="v_field"></td>
                                        <td id="r_40to49_three_iud" class="v_field"></td>
                                        <td id="r_40to49_three_implant" class="v_field"></td>
                                        <td id="r_40to49_three_permanent_man" class="v_field"></td>
                                        <td id="r_40to49_three_permanent_woman" class="v_field"></td>
                                        <td id="r_40to49_three_total" class="v_field"></td>
                                        <td id="r_40to49_three_notTaken" class="v_field"></td>
                                        <td id="r_40to49_three_pregnant" class="v_field"></td>
                                        <td id="r_40to49_three_totalNoOfChild" class="v_field"></td>
                                        <td id="r_40to49_three_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">মোট</td>
                                        <td id="r_40to49_total_pill" class="v_field"></td>
                                        <td id="r_40to49_total_condom" class="v_field"></td>
                                        <td id="r_40to49_total_inject" class="v_field"></td>
                                        <td id="r_40to49_total_iud" class="v_field"></td>
                                        <td id="r_40to49_total_implant" class="v_field"></td>
                                        <td id="r_40to49_total_permanent_man" class="v_field"></td>
                                        <td id="r_40to49_total_permanent_woman" class="v_field"></td>
                                        <td id="r_40to49_total_total" class="v_field"></td>
                                        <td id="r_40to49_total_notTaken" class="v_field"></td>
                                        <td id="r_40to49_total_pregnant" class="v_field"></td>
                                        <td id="r_40to49_total_totalNoOfChild" class="v_field"></td>
                                        <td id="r_40to49_total_husbandAbroad" class="v_field"></td>   
                                    </tr>
                                    <!--End 4th Portion (40-49)-->
                                    <!--End Portion-->
                                    <tr>
                                        <td class="rotate t_field" rowspan="5">সর্বমোট</td>
                                        <td class="t_field">০</td>
                                        <td id="r_allTotal_zero_pill" class="v_field"></td>
                                        <td id="r_allTotal_zero_condom" class="v_field"></td>
                                        <td id="r_allTotal_zero_inject" class="v_field"></td>
                                        <td id="r_allTotal_zero_iud" class="v_field"></td>
                                        <td id="r_allTotal_zero_implant" class="v_field"></td>
                                        <td id="r_allTotal_zero_permanent_man" class="v_field"></td>
                                        <td id="r_allTotal_zero_permanent_woman" class="v_field"></td>
                                        <td id="r_allTotal_zero_total" class="v_field"></td>
                                        <td id="r_allTotal_zero_notTaken" class="v_field"></td>
                                        <td id="r_allTotal_zero_pregnant" class="v_field"></td>
                                        <td id="r_allTotal_zero_totalNoOfChild" class="v_field"></td>
                                        <td id="r_allTotal_zero_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">১</td>
                                        <td id="r_allTotal_one_pill" class="v_field"></td>
                                        <td id="r_allTotal_one_condom" class="v_field"></td>
                                        <td id="r_allTotal_one_inject" class="v_field"></td>
                                        <td id="r_allTotal_one_iud" class="v_field"></td>
                                        <td id="r_allTotal_one_implant" class="v_field"></td>
                                        <td id="r_allTotal_one_permanent_man" class="v_field"></td>
                                        <td id="r_allTotal_one_permanent_woman" class="v_field"></td>
                                        <td id="r_allTotal_one_total" class="v_field"></td>
                                        <td id="r_allTotal_one_notTaken" class="v_field"></td>
                                        <td id="r_allTotal_one_pregnant" class="v_field"></td>
                                        <td id="r_allTotal_one_totalNoOfChild" class="v_field"></td>
                                        <td id="r_allTotal_one_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">২</td>
                                        <td id="r_allTotal_two_pill" class="v_field"></td>
                                        <td id="r_allTotal_two_condom" class="v_field"></td>
                                        <td id="r_allTotal_two_inject" class="v_field"></td>
                                        <td id="r_allTotal_two_iud" class="v_field"></td>
                                        <td id="r_allTotal_two_implant" class="v_field"></td>
                                        <td id="r_allTotal_two_permanent_man" class="v_field"></td>
                                        <td id="r_allTotal_two_permanent_woman" class="v_field"></td>
                                        <td id="r_allTotal_two_total" class="v_field"></td>
                                        <td id="r_allTotal_two_notTaken" class="v_field"></td>
                                        <td id="r_allTotal_two_pregnant" class="v_field"></td>
                                        <td id="r_allTotal_two_totalNoOfChild" class="v_field"></td>
                                        <td id="r_allTotal_two_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">৩+</td>
                                        <td id="r_allTotal_three_pill" class="v_field"></td>
                                        <td id="r_allTotal_three_condom" class="v_field"></td>
                                        <td id="r_allTotal_three_inject" class="v_field"></td>
                                        <td id="r_allTotal_three_iud" class="v_field"></td>
                                        <td id="r_allTotal_three_implant" class="v_field"></td>
                                        <td id="r_allTotal_three_permanent_man" class="v_field"></td>
                                        <td id="r_allTotal_three_permanent_woman" class="v_field"></td>
                                        <td id="r_allTotal_three_total" class="v_field"></td>
                                        <td id="r_allTotal_three_notTaken" class="v_field"></td>
                                        <td id="r_allTotal_three_pregnant" class="v_field"></td>
                                        <td id="r_allTotal_three_totalNoOfChild" class="v_field"></td>
                                        <td id="r_allTotal_three_husbandAbroad" class="v_field"></td>
                                    </tr>
                                    <tr>
                                        <td class="t_field">মোট</td>
                                        <td id="r_allTotal_total_pill" class="v_field"></td>
                                        <td id="r_allTotal_total_condom" class="v_field"></td>
                                        <td id="r_allTotal_total_inject" class="v_field"></td>
                                        <td id="r_allTotal_total_iud" class="v_field"></td>
                                        <td id="r_allTotal_total_implant" class="v_field"></td>
                                        <td id="r_allTotal_total_permanent_man" class="v_field"></td>
                                        <td id="r_allTotal_total_permanent_woman" class="v_field"></td>
                                        <td id="r_allTotal_total_total" class="v_field"></td>
                                        <td id="r_allTotal_total_notTaken" class="v_field"></td>
                                        <td id="r_allTotal_total_pregnant" class="v_field"></td>
                                        <td id="r_allTotal_total_totalNoOfChild" class="v_field"></td>
                                        <td id="r_allTotal_total_husbandAbroad" class="v_field"></td>   
                                    </tr>
                                    <!--End Total Portio-->
                                </tbody>
                            </table>
                        </div>
                    </div> 
                </div><br/>
            </div> 
        </div>
    </div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
