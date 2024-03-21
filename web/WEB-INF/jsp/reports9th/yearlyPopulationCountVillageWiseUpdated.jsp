<%-- 
    Document   : yearlyPopulationCountVillageWise
    Created on : Sep 14, 2017, 11:33:26 AM
    Author     : Helal Khan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla.js"></script>
<link href="resources/css/newStyle.css" rel="stylesheet" type="text/css"/>
<style>
    #center{
        text-align: center;
    }
    .centerBold{
        text-align: center;
        font-weight: bold;
    }
    table, th, td {
        border: 1px solid black;
        border-collapse: collapse;
    }
    th, td {
        padding: 5px;
        text-align: left;
        height: 22px;
    }
    #rotate{
        width:55px;
        height:50px!important;
        text-align: center;
        -ms-transform:rotate(270deg);
        -moz-transform:rotate(270deg);
        -webkit-transform:rotate(270deg);
        -o-transform:rotate(270deg);
    }
    @font-face {
        font-family: NikoshBAN;
        src: url('resources/fonts/NikoshBAN.ttf');
    }
    .v_field{
        font-family: NikoshBAN;
        font-size: 17px;
    }
    .mayHide{
        display: none!important;
    }
    .bold{
        font-weight: bold;
    }
    [class*="col"] { margin-bottom: 10px; }
    @media print {
        .tableTitle{
            display: block;
            margin-top: -2px;
        }
        .box{ border: 0}
        #areaPanel, #back-to-top, .box-header, .main-footer{
            display: none !important;
        }
    }
</style>

<script>
    $(document).ready(function () {
        
        $('#showdataButton').click(function () {
            resetYearlyPopulationCountVillageWise();
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

            }else{
                
                var btn = $(this).button('loading');
                Pace.track(function(){
                    $.ajax({
                        url: "yearlyPopulationCountVillageWise",
                        data: {
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            unitId: $("select#unit").val(),
//                            provCode: $("select#provCode").val(),
                            year: $("#year").val()
                        },
                        type: 'POST',
                        success: function (result) {
                            btn.button('reset');
                            var json = JSON.parse(result);
                            

                            if (json.length === 0) {
                                toastr["error"]("<h4><b>দুঃখিত, কোন ডাটা পাওয়া যায়নি</b></h4>");
                                return;
                            }
                            var dataTable = $('#dataTable').html();
                            dataTable="";  //Get and clear data table div
                            
                            var totalMale=0,totalFemale=0; //Declare for al total male female
                            
                            dataTable+='<table class="tg" border="1px"  style="table-layout: fixed; width: 581px" align="center">'+
                                '<thead>'+
                                    '<tr>'+
                                        '<td colspan="4" rowspan="3" id="center"><p>গ্রামের নাম</p></td>'+
                                    '</tr>'+
                                    '<tr id="r_year">'+
                                        '<td colspan="3" id="center">সালঃ <span id="year">'+convertE2B($("#year option:selected").val())+'</span></td>'+
                                    '</tr>'+
                                    '<tr id="r_male_female">'+
                                        '<td class="tg-0e45" id="rotate">পুরুষ</td>'+
                                        '<td class="tg-0e45" id="rotate">মহিলা</td>'+
                                        '<td class="tg-0e45" id="rotate">মোট</td>'+
                                    '</tr>'+
                                '</thead>'+
                                '<tbody>'; //Set Table head
                        
                                for (var i = 0; i <  json.length; i++) {
                                    dataTable+='<tr id="tableBody">'
                                        +'<td class="tg-0e45" colspan="4">'+json[i].r_villagename+'</td>'
                                        +'<td class="tg-0e45">'+convertE2B(json[i].r_male)+'</td>'
                                        +'<td class="tg-0e45">'+convertE2B(json[i].r_female)+'</td>'
                                        +'<td class="tg-0e45">'+convertE2B(json[i].r_pop_tota)+'</td>'
                                    +'</tr>';
                                    totalMale+=json[i].r_male;
                                    totalFemale+=json[i].r_female;
                                } //set table body and count total male female
                                
                                dataTable+='<tr id="r_male_female">'
                                    +'<td class="tg-0e45 bold" colspan="4">সর্বমোট</td>'
                                    +'<td class="tg-0e45 bold">'+convertE2B(totalMale)+'</td>'
                                    +'<td class="tg-0e45 bold">'+convertE2B(totalFemale)+'</td>'
                                    +'<td class="tg-0e45 bold">'+convertE2B((totalMale+totalFemale))+'</td>'
                                +'</tr>'
                                +'</tbody>'
                                +'</table>'; //Footer set here
                                $('#dataTable').html(dataTable);
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>অনুরোধটি প্রক্রিয়াধীন করা যাচ্ছে না</b></h4>");
                        }
                    }); //End Ajax
                }); //End Pace
                
            }//End else
        });//End Button Click
    });
    function resetYearlyPopulationCountVillageWise(){
        var defaultTable = $('#dataTable').html();
        defaultTable="";
        
                            
        defaultTable+='<table class="tg" border="1px"  style="table-layout: fixed; width: 881px" align="center">'+
            '<thead>'+
                '<tr>'+
                    '<td colspan="4" rowspan="3" id="center"><p>গ্রামের নাম</p></td>'+
                '</tr>'+
                '<tr id="r_year">'+
                    '<td colspan="3" id="center">সালঃ <span id="year"></span></td>'+
                    '<td colspan="3" id="center">সালঃ <span id="year"></span></td>'+
                    '<td colspan="3" id="center">সালঃ <span id="year"></span></td>'+
                '</tr>'+
                '<tr id="r_male_female">'+
                    '<td class="tg-0e45" id="rotate">পুরুষ</td>'+
                    '<td class="tg-0e45" id="rotate">মহিলা</td>'+
                    '<td class="tg-0e45" id="rotate">মোট</td>'+
                    '<td class="tg-0e45" id="rotate">পুরুষ</td>'+
                    '<td class="tg-0e45" id="rotate">মহিলা</td>'+
                    '<td class="tg-0e45" id="rotate">মোট</td>'+
                    '<td class="tg-0e45" id="rotate">পুরুষ</td>'+
                    '<td class="tg-0e45" id="rotate">মহিলা</td>'+
                    '<td class="tg-0e45" id="rotate">মোট</td>'+
                '</tr>'+
            '</thead>'+
            '<tbody>';

            for (var i = 0; i <  20; i++) {
                defaultTable+='<tr id="tableBody">'
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
                                +'</tr>';
            }

            defaultTable+='<tr id="r_male_female">'
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
                            +'</tr>'
                            +'</tbody>'
                            +'</table>';
            $('#dataTable').html(defaultTable);
    }
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1 id="pageTitle"><span style="color:#4fef2f;"><i class="fa fa-check-circle" aria-hidden="true"></i></span> Yearly villlage wise population</h1>
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
                    <h4 style="text-align: center;margin-top: 0px;;"><b>গ্রাম ভিত্তিক জনসংখ্যার হিসাব ছক</b></h4>
                    <div class="table-responsive" id="dataTable">
                            <table class="tg" border="1px"  style="table-layout: fixed; width: 881px" align="center">
                                <thead>
                                    <tr>
                                        <td colspan="4" rowspan="3" id='center'><p>গ্রামের নাম</p></td>
                                    </tr>
                                    <tr id="r_year">
                                        <td colspan="3" id='center'>সালঃ <span id="year"></span></td>
                                        <td colspan="3" id='center'>সালঃ <span id="year"></span></td>
                                        <td colspan="3" id='center'>সালঃ <span id="year"></span></td>
                                    </tr>
                                    <tr id="r_male_female">
                                        <td class="tg-0e45" id='rotate'>পুরুষ</td>
                                        <td class="tg-0e45" id='rotate'>মহিলা</td>
                                        <td class="tg-0e45" id='rotate'>মোট</td>
                                        <td class="tg-0e45" id='rotate'>পুরুষ</td>
                                        <td class="tg-0e45" id='rotate'>মহিলা</td>
                                        <td class="tg-0e45" id='rotate'>মোট</td>
                                       <td class="tg-0e45" id='rotate'>পুরুষ</td>
                                        <td class="tg-0e45" id='rotate'>মহিলা</td>
                                        <td class="tg-0e45" id='rotate'>মোট</td>
                                    </tr>
                                </thead>
                                <tbody id="tableBody">
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                    <tr>
                                        <td class="tg-0e45" colspan="4">সর্বমোট</td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                        <td class="tg-0e45"></td>
                                    </tr>
                                </tbody>
                                <tbody id="tableFooter">
                                </tbody>
                        </table>
                        </div>
                    </div>
                </div> 
            </div>
        </div>
    </div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>