
function resetYearlyPopulationCountVillageWise(){
    $('#r_year').append('<tr id="r_year">'
	+'<td colspan="3" id="center">সালঃ <span id="year"></span></td>'
	+'<td colspan="3" id="center">সালঃ <span id="year"></span></td>'
	+'<td colspan="3" id="center">সালঃ <span id="year"></span></td>'
                +'</tr>');
    $('#r_male_female').append('<tr id="r_male_female">'
                                                +'<td class="tg-0e45" id="rotate">পুরুষ</td>'
                                                +'<td class="tg-0e45" id="rotate">মহিলা</td>'
                                                +'<td class="tg-0e45" id="rotate">মোট</td>'
                                                +'<td class="tg-0e45" id="rotate">পুরুষ</td>'
                                                +'<td class="tg-0e45" id="rotate">মহিলা</td>'
                                                +'<td class="tg-0e45" id="rotate">মোট</td>'
                                                +'<td class="tg-0e45" id="rotate">পুরুষ</td>'
                                                +'<td class="tg-0e45" id="rotate">মহিলা</td>'
                                                +'<td class="tg-0e45" id="rotate">মোট</td>'
                                            +'</tr>');
    var tableBody = $('#tableBody');
    for (var i = 0; i < 10; i++) {
         tableBody.append('<tr>'
                                    +'<td class="tg-0e45" colspan="4"></td>'
                                    +'<td class="tg-0e45"></td>'
                                    +'<td class="tg-0e45"></td>'
                                    +'<td class="tg-0e45"></td>'
                                    +'<td class="tg-0e45"></td>'
                                    +'<td class="tg-0e45"></td>'
                                    +'<td class="tg-0e45"></td>'
                                    +'<td class="tg-0e45"></td>'
                                    +'<td class="tg-0e45"></td>'
                                    +'<td class="tg-0e45"></td>'
                                +'</tr>');
    }
    tableBody.append('<tr>'
                           +'<td class="tg-0e45" colspan="4">সর্বমোট</td>'
                           +'<td class="tg-0e45"></td>'
                           +'<td class="tg-0e45"></td>'
                           +'<td class="tg-0e45"></td>'
                           +'<td class="tg-0e45"></td>'
                           +'<td class="tg-0e45"></td>'
                           +'<td class="tg-0e45"></td>'
                           +'<td class="tg-0e45"></td>'
                           +'<td class="tg-0e45"></td>'
                           +'<td class="tg-0e45"></td>'
                       +'</tr>');
    
}

function ElcoCountChildAndAgeWiseSetDash(){
    //Less than 20
    $('#r_lessThan20_zero_pill').html('-');
    $('#r_lessThan20_zero_condom').html('-');
    $('#r_lessThan20_zero_inject').html('-');
    $('#r_lessThan20_zero_iud').html('-');
    $('#r_lessThan20_zero_implant').html('-');
    $('#r_lessThan20_zero_permanent_man').html('-');
    $('#r_lessThan20_zero_permanent_woman').html('-');
    
    $('#r_lessThan20_one_pill').html('-');
    $('#r_lessThan20_one_condom').html('-');
    $('#r_lessThan20_one_inject').html('-');
    $('#r_lessThan20_one_iud').html('-');
    $('#r_lessThan20_one_implant').html('-');
    $('#r_lessThan20_one_permanent_man').html('-');
    $('#r_lessThan20_one_permanent_woman').html('-');
    
    $('#r_lessThan20_two_pill').html('-');
    $('#r_lessThan20_two_condom').html('-');
    $('#r_lessThan20_two_inject').html('-');
    $('#r_lessThan20_two_iud').html('-');
    $('#r_lessThan20_two_implant').html('-');
    $('#r_lessThan20_two_permanent_man').html('-');
    $('#r_lessThan20_two_permanent_woman').html('-');
    
    $('#r_lessThan20_three_pill').html('-');                                
    $('#r_lessThan20_three_condom').html('-');
    $('#r_lessThan20_three_inject').html('-');
    $('#r_lessThan20_three_iud').html('-');
    $('#r_lessThan20_three_implant').html('-');
    $('#r_lessThan20_three_permanent_man').html('-');
    $('#r_lessThan20_three_permanent_woman').html('-');
    
    //20-29
    $('#r_20to29_zero_pill').html('-');
    $('#r_20to29_zero_condom').html('-');
    $('#r_20to29_zero_inject').html('-');
    $('#r_20to29_zero_iud').html('-');
    $('#r_20to29_zero_implant').html('-');
    $('#r_20to29_zero_permanent_man').html('-');
    $('#r_20to29_zero_permanent_woman').html('-');
    
    $('#r_20to29_one_pill').html('-');
    $('#r_20to29_one_condom').html('-');
    $('#r_20to29_one_inject').html('-');
    $('#r_20to29_one_iud').html('-');
    $('#r_20to29_one_implant').html('-');
    $('#r_20to29_one_permanent_man').html('-');
    $('#r_20to29_one_permanent_woman').html('-');
    
    $('#r_20to29_two_pill').html('-');
    $('#r_20to29_two_condom').html('-');
    $('#r_20to29_two_inject').html('-');
    $('#r_20to29_two_iud').html('-');
    $('#r_20to29_two_implant').html('-');
    $('#r_20to29_two_permanent_man').html('-');
    $('#r_20to29_two_permanent_woman').html('-');
    
    $('#r_20to29_three_pill').html('-');                                
    $('#r_20to29_three_condom').html('-');
    $('#r_20to29_three_inject').html('-');
    $('#r_20to29_three_iud').html('-');
    $('#r_20to29_three_implant').html('-');
    $('#r_20to29_three_permanent_man').html('-');
    $('#r_20to29_three_permanent_woman').html('-');
    
    //30-39
    $('#r_30to39_zero_pill').html('-');
    $('#r_30to39_zero_condom').html('-');
    $('#r_30to39_zero_inject').html('-');
    $('#r_30to39_zero_iud').html('-');
    $('#r_30to39_zero_implant').html('-');
    $('#r_30to39_zero_permanent_man').html('-');
    $('#r_30to39_zero_permanent_woman').html('-');
    
    $('#r_30to39_one_pill').html('-');
    $('#r_30to39_one_condom').html('-');
    $('#r_30to39_one_inject').html('-');
    $('#r_30to39_one_iud').html('-');
    $('#r_30to39_one_implant').html('-');
    $('#r_30to39_one_permanent_man').html('-');
    $('#r_30to39_one_permanent_woman').html('-');
    
    $('#r_30to39_two_pill').html('-');
    $('#r_30to39_two_condom').html('-');
    $('#r_30to39_two_inject').html('-');
    $('#r_30to39_two_iud').html('-');
    $('#r_30to39_two_implant').html('-');
    $('#r_30to39_two_permanent_man').html('-');
    $('#r_30to39_two_permanent_woman').html('-');
    
    $('#r_30to39_three_pill').html('-');                                
    $('#r_30to39_three_condom').html('-');
    $('#r_30to39_three_inject').html('-');
    $('#r_30to39_three_iud').html('-');
    $('#r_30to39_three_implant').html('-');
    $('#r_30to39_three_permanent_man').html('-');
    $('#r_30to39_three_permanent_woman').html('-');
    
    //40-49
    $('#r_40to49_zero_pill').html('-');
    $('#r_40to49_zero_condom').html('-');
    $('#r_40to49_zero_inject').html('-');
    $('#r_40to49_zero_iud').html('-');
    $('#r_40to49_zero_implant').html('-');
    $('#r_40to49_zero_permanent_man').html('-');
    $('#r_40to49_zero_permanent_woman').html('-');
    
    $('#r_40to49_one_pill').html('-');
    $('#r_40to49_one_condom').html('-');
    $('#r_40to49_one_inject').html('-');
    $('#r_40to49_one_iud').html('-');
    $('#r_40to49_one_implant').html('-');
    $('#r_40to49_one_permanent_man').html('-');
    $('#r_40to49_one_permanent_woman').html('-');
    
    $('#r_40to49_two_pill').html('-');
    $('#r_40to49_two_condom').html('-');
    $('#r_40to49_two_inject').html('-');
    $('#r_40to49_two_iud').html('-');
    $('#r_40to49_two_implant').html('-');
    $('#r_40to49_two_permanent_man').html('-');
    $('#r_40to49_two_permanent_woman').html('-');
    
    $('#r_40to49_three_pill').html('-');                                
    $('#r_40to49_three_condom').html('-');
    $('#r_40to49_three_inject').html('-');
    $('#r_40to49_three_iud').html('-');
    $('#r_40to49_three_implant').html('-');
    $('#r_40to49_three_permanent_man').html('-');
    $('#r_40to49_three_permanent_woman').html('-');
}

function ElcoCountChildAndAgeWiseSetBlank(){
    //Less than 20
    $('#r_lessThan20_zero_pill').html('');
    $('#r_lessThan20_zero_condom').html('');
    $('#r_lessThan20_zero_inject').html('');
    $('#r_lessThan20_zero_iud').html('');
    $('#r_lessThan20_zero_implant').html('');
    $('#r_lessThan20_zero_permanent_man').html('');
    $('#r_lessThan20_zero_permanent_woman').html('');
    $('#r_lessThan20_zero_notTaken').html('');
    $('#r_lessThan20_zero_pregnant').html('');
    $('#r_lessThan20_zero_totalNoOfChild').html('');
    $('#r_lessThan20_zero_husbandAbroad').html('');
    
    $('#r_lessThan20_one_pill').html('');
    $('#r_lessThan20_one_condom').html('');
    $('#r_lessThan20_one_inject').html('');
    $('#r_lessThan20_one_iud').html('');
    $('#r_lessThan20_one_implant').html('');
    $('#r_lessThan20_one_permanent_man').html('');
    $('#r_lessThan20_one_permanent_woman').html('');
    $('#r_lessThan20_one_notTaken').html('');
    $('#r_lessThan20_one_pregnant').html('');
    $('#r_lessThan20_one_totalNoOfChild').html('');
    $('#r_lessThan20_one_husbandAbroad').html('');
    
    $('#r_lessThan20_two_pill').html('');
    $('#r_lessThan20_two_condom').html('');
    $('#r_lessThan20_two_inject').html('');
    $('#r_lessThan20_two_iud').html('');
    $('#r_lessThan20_two_implant').html('');
    $('#r_lessThan20_two_permanent_man').html('');
    $('#r_lessThan20_two_permanent_woman').html('');
    $('#r_lessThan20_two_notTaken').html('');
    $('#r_lessThan20_two_pregnant').html('');
    $('#r_lessThan20_two_totalNoOfChild').html('');
    $('#r_lessThan20_two_husbandAbroad').html('');
    
    $('#r_lessThan20_three_pill').html('');                                
    $('#r_lessThan20_three_condom').html('');
    $('#r_lessThan20_three_inject').html('');
    $('#r_lessThan20_three_iud').html('');
    $('#r_lessThan20_three_implant').html('');
    $('#r_lessThan20_three_permanent_man').html('');
    $('#r_lessThan20_three_permanent_woman').html('');
    $('#r_lessThan20_three_notTaken').html('');
    $('#r_lessThan20_three_pregnant').html('');
    $('#r_lessThan20_three_totalNoOfChild').html('');
    $('#r_lessThan20_three_husbandAbroad').html('');
    
    //2029
    $('#r_20to29_zero_pill').html('');
    $('#r_20to29_zero_condom').html('');
    $('#r_20to29_zero_inject').html('');
    $('#r_20to29_zero_iud').html('');
    $('#r_20to29_zero_implant').html('');
    $('#r_20to29_zero_permanent_man').html('');
    $('#r_20to29_zero_permanent_woman').html('');
    $('#r_20to29_zero_notTaken').html('');
    $('#r_20to29_zero_pregnant').html('');
    $('#r_20to29_zero_totalNoOfChild').html('');
    $('#r_20to29_zero_husbandAbroad').html('');
    
    $('#r_20to29_one_pill').html('');
    $('#r_20to29_one_condom').html('');
    $('#r_20to29_one_inject').html('');
    $('#r_20to29_one_iud').html('');
    $('#r_20to29_one_implant').html('');
    $('#r_20to29_one_permanent_man').html('');
    $('#r_20to29_one_permanent_woman').html('');
    $('#r_20to29_one_notTaken').html('');
    $('#r_20to29_one_pregnant').html('');
    $('#r_20to29_one_totalNoOfChild').html('');
    $('#r_20to29_one_husbandAbroad').html('');
    
    $('#r_20to29_two_pill').html('');
    $('#r_20to29_two_condom').html('');
    $('#r_20to29_two_inject').html('');
    $('#r_20to29_two_iud').html('');
    $('#r_20to29_two_implant').html('');
    $('#r_20to29_two_permanent_man').html('');
    $('#r_20to29_two_permanent_woman').html('');
    $('#r_20to29_two_notTaken').html('');
    $('#r_20to29_two_pregnant').html('');
    $('#r_20to29_two_totalNoOfChild').html('');
    $('#r_20to29_two_husbandAbroad').html('');
    
    $('#r_20to29_three_pill').html('');                                
    $('#r_20to29_three_condom').html('');
    $('#r_20to29_three_inject').html('');
    $('#r_20to29_three_iud').html('');
    $('#r_20to29_three_implant').html('');
    $('#r_20to29_three_permanent_man').html('');
    $('#r_20to29_three_permanent_woman').html('');
    $('#r_20to29_three_notTaken').html('');
    $('#r_20to29_three_pregnant').html('');
    $('#r_20to29_three_totalNoOfChild').html('');
    $('#r_20to29_three_husbandAbroad').html('');
    
    //3039
    $('#r_30to39_zero_pill').html('');
    $('#r_30to39_zero_condom').html('');
    $('#r_30to39_zero_inject').html('');
    $('#r_30to39_zero_iud').html('');
    $('#r_30to39_zero_implant').html('');
    $('#r_30to39_zero_permanent_man').html('');
    $('#r_30to39_zero_permanent_woman').html('');
    $('#r_30to39_zero_notTaken').html('');
    $('#r_30to39_zero_pregnant').html('');
    $('#r_30to39_zero_totalNoOfChild').html('');
    $('#r_30to39_zero_husbandAbroad').html('');
    
    $('#r_30to39_one_pill').html('');
    $('#r_30to39_one_condom').html('');
    $('#r_30to39_one_inject').html('');
    $('#r_30to39_one_iud').html('');
    $('#r_30to39_one_implant').html('');
    $('#r_30to39_one_permanent_man').html('');
    $('#r_30to39_one_permanent_woman').html('');
    $('#r_30to39_one_notTaken').html('');
    $('#r_30to39_one_pregnant').html('');
    $('#r_30to39_one_totalNoOfChild').html('');
    $('#r_30to39_one_husbandAbroad').html('');
    
    $('#r_30to39_two_pill').html('');
    $('#r_30to39_two_condom').html('');
    $('#r_30to39_two_inject').html('');
    $('#r_30to39_two_iud').html('');
    $('#r_30to39_two_implant').html('');
    $('#r_30to39_two_permanent_man').html('');
    $('#r_30to39_two_permanent_woman').html('');
    $('#r_30to39_two_notTaken').html('');
    $('#r_30to39_two_pregnant').html('');
    $('#r_30to39_two_totalNoOfChild').html('');
    $('#r_30to39_two_husbandAbroad').html('');
    
    $('#r_30to39_three_pill').html('');                                
    $('#r_30to39_three_condom').html('');
    $('#r_30to39_three_inject').html('');
    $('#r_30to39_three_iud').html('');
    $('#r_30to39_three_implant').html('');
    $('#r_30to39_three_permanent_man').html('');
    $('#r_30to39_three_permanent_woman').html('');
    $('#r_30to39_three_notTaken').html('');
    $('#r_30to39_three_pregnant').html('');
    $('#r_30to39_three_totalNoOfChild').html('');
    $('#r_30to39_three_husbandAbroad').html('');
    
    //4049
    $('#r_40to49_zero_pill').html('');
    $('#r_40to49_zero_condom').html('');
    $('#r_40to49_zero_inject').html('');
    $('#r_40to49_zero_iud').html('');
    $('#r_40to49_zero_implant').html('');
    $('#r_40to49_zero_permanent_man').html('');
    $('#r_40to49_zero_permanent_woman').html('');
    $('#r_40to49_zero_notTaken').html('');
    $('#r_40to49_zero_pregnant').html('');
    $('#r_40to49_zero_totalNoOfChild').html('');
    $('#r_40to49_zero_husbandAbroad').html('');
    
    $('#r_40to49_one_pill').html('');
    $('#r_40to49_one_condom').html('');
    $('#r_40to49_one_inject').html('');
    $('#r_40to49_one_iud').html('');
    $('#r_40to49_one_implant').html('');
    $('#r_40to49_one_permanent_man').html('');
    $('#r_40to49_one_permanent_woman').html('');
    $('#r_40to49_one_notTaken').html('');
    $('#r_40to49_one_pregnant').html('');
    $('#r_40to49_one_totalNoOfChild').html('');
    $('#r_40to49_one_husbandAbroad').html('');
    
    $('#r_40to49_two_pill').html('');
    $('#r_40to49_two_condom').html('');
    $('#r_40to49_two_inject').html('');
    $('#r_40to49_two_iud').html('');
    $('#r_40to49_two_implant').html('');
    $('#r_40to49_two_permanent_man').html('');
    $('#r_40to49_two_permanent_woman').html('');
    $('#r_40to49_two_notTaken').html('');
    $('#r_40to49_two_pregnant').html('');
    $('#r_40to49_two_totalNoOfChild').html('');
    $('#r_40to49_two_husbandAbroad').html('');
    
    $('#r_40to49_three_pill').html('');                                
    $('#r_40to49_three_condom').html('');
    $('#r_40to49_three_inject').html('');
    $('#r_40to49_three_iud').html('');
    $('#r_40to49_three_implant').html('');
    $('#r_40to49_three_permanent_man').html('');
    $('#r_40to49_three_permanent_woman').html('');
    $('#r_40to49_three_notTaken').html('');
    $('#r_40to49_three_pregnant').html('');
    $('#r_40to49_three_totalNoOfChild').html('');
    $('#r_40to49_three_husbandAbroad').html('');
    
    
    //Sum ror row total portion
    //Pill
    $('#r_lessThan20_total_pill').html('');
    $('#r_20to29_total_pill').html('');
    $('#r_30to39_total_pill').html('');
    $('#r_40to49_total_pill').html('');
    //Condom
    $('#r_lessThan20_total_condom').html('');
    $('#r_20to29_total_condom').html('');
    $('#r_30to39_total_condom').html('');
    $('#r_40to49_total_condom').html('');
    //injectable
    $('#r_lessThan20_total_inject').html('');
    $('#r_20to29_total_inject').html('');
    $('#r_30to39_total_inject').html('');
    $('#r_40to49_total_inject').html('');
    //Iud
    $('#r_lessThan20_total_iud').html('');
    $('#r_20to29_total_iud').html('');
    $('#r_30to39_total_iud').html('');
    $('#r_40to49_total_iud').html('');
    //Implant
    $('#r_lessThan20_total_implant').html('');
    $('#r_20to29_total_implant').html('');
    $('#r_30to39_total_implant').html('');
    $('#r_40to49_total_implant').html('');
    //permanent_man
    $('#r_lessThan20_total_permanent_man').html('');
    $('#r_20to29_total_permanent_man').html('');
    $('#r_30to39_total_permanent_man').html('');
    $('#r_40to49_total_permanent_man').html('');
    //permanent_woman
    $('#r_lessThan20_total_permanent_woman').html('');
    $('#r_20to29_total_permanent_woman').html('');
    $('#r_30to39_total_permanent_woman').html('');
    $('#r_40to49_total_permanent_woman').html('');


    //For total column
    //Less than 20 sum
    $('#r_lessThan20_zero_total').html('');
    $('#r_lessThan20_one_total').html('');
    $('#r_lessThan20_two_total').html('');
    $('#r_lessThan20_three_total').html('');
    $('#r_lessThan20_total_total').html('');
    //20-29 sum
    $('#r_20to29_zero_total').html('');
    $('#r_20to29_one_total').html('');
    $('#r_20to29_two_total').html('');
    $('#r_20to29_three_total').html('');
    $('#r_20to29_total_total').html('');
    //30-39 sum
    $('#r_30to39_zero_total').html('');
    $('#r_30to39_one_total').html('');
    $('#r_30to39_two_total').html('');
    $('#r_30to39_three_total').html('');
    $('#r_30to39_total_total').html('');
    //40-49 sum
    $('#r_40to49_zero_total').html('');
    $('#r_40to49_one_total').html('');
    $('#r_40to49_two_total').html('');
    $('#r_40to49_three_total').html('');
    $('#r_40to49_total_total').html('');
    //40-49 sum
    $('#r_40to49_zero_total').html('');
    $('#r_40to49_one_total').html('');
    $('#r_40to49_two_total').html('');
    $('#r_40to49_three_total').html('');
    $('#r_40to49_total_total').html('');
    //All total sum
    $('#r_allTotal_zero_total').html('');
    $('#r_allTotal_one_total').html('');
    $('#r_allTotal_two_total').html('');
    $('#r_allTotal_three_total').html('');
    $('#r_allTotal_total_total').html('');
    //Bottom all total portion
    //Pill
    $('#r_allTotal_zero_pill').html('');
    $('#r_allTotal_one_pill').html('');  
    $('#r_allTotal_two_pill').html('');    
    $('#r_allTotal_three_pill').html('');
    $('#r_allTotal_total_pill').html('');
    //Condom
    $('#r_allTotal_zero_condom').html('');
    $('#r_allTotal_one_condom').html('');  
    $('#r_allTotal_two_condom').html('');    
    $('#r_allTotal_three_condom').html('');
    $('#r_allTotal_total_condom').html('');
    //Injectable
    $('#r_allTotal_zero_inject').html('');
    $('#r_allTotal_one_inject').html('');  
    $('#r_allTotal_two_inject').html('');    
    $('#r_allTotal_three_inject').html('');
    $('#r_allTotal_total_inject').html('');
    //Iud
    $('#r_allTotal_zero_iud').html('');
    $('#r_allTotal_one_iud').html('');  
    $('#r_allTotal_two_iud').html('');    
    $('#r_allTotal_three_iud').html('');
    $('#r_allTotal_total_iud').html('');
    //Implant
    $('#r_allTotal_zero_implant').html('');
    $('#r_allTotal_one_implant').html('');  
    $('#r_allTotal_two_implant').html('');    
    $('#r_allTotal_three_implant').html('');
    $('#r_allTotal_total_implant').html('');
    //permanent_man
    $('#r_allTotal_zero_permanent_man').html('');
    $('#r_allTotal_one_permanent_man').html('');  
    $('#r_allTotal_two_permanent_man').html('');    
    $('#r_allTotal_three_permanent_man').html('');
    $('#r_allTotal_total_permanent_man').html('');
    //permanent_woman
    $('#r_allTotal_zero_permanent_woman').html('');
    $('#r_allTotal_one_permanent_woman').html('');  
    $('#r_allTotal_two_permanent_woman').html('');    
    $('#r_allTotal_three_permanent_woman').html('');
    $('#r_allTotal_total_permanent_woman').html('');
}