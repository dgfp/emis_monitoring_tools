<%-- 
    Document   : populationCountKhanaWise
    Created on : Jan 26, 2017, 11:59:09 AM
    Author     : Helal Khan; m.helal.k@gmail.com
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla.js"></script>
<link href="resources/css/newStyle.css" rel="stylesheet" type="text/css"/>
<style>
    #center{
        text-align: center;
    }
    .left{
        text-align: left!important;
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
        width:50px;
        height:62px;
        text-align: left!important;
        -ms-transform:rotate(270deg);
        -moz-transform:rotate(270deg);
        -webkit-transform:rotate(270deg);
        -o-transform:rotate(270deg);
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
            resetPopulationCountKhanaWise(); //reset data
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
                Pace.track(function () {
                    $.ajax({
                        url: "populationCountKhanaWise",
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
                            var data = JSON.parse(result);
                            var json = data.Population;
                            var jsonYear = data.Year;
                            var jsonHouseholdHeadName = data.HouseholdHeadName;
                            //var jsonTotal = data.Total;
                            console.log(json);





                            if (json.length === 0) {
                                toastr["error"]("<h4><b>কোন ডাটা পাওয়া যায়নি</b></h4>");
                                return;
                            }

                            //Distinct village name and set 
                            var lookup = {};
                            var villageName = "";
                            for (var item, i = 0; item = json[i++]; ) {
                                var name = item.r_villagenameeng;

                                if (!(name in lookup)) {
                                    lookup[name] = 1;
                                    villageName += "&nbsp;&nbsp;" + name + "&nbsp;&nbsp;-";
                                }
                            }
                            $('#villageName').html(villageName.substring(0, villageName.length - 1)); //Set village name


                            //Load Year here dynamically
                            $('#r_year').html("");
                            $('#r_male_female').html("");
                            var sum_count = new Array(3); //All total count variables
                            for (var i = 0; i < jsonYear.length; i++) {
                                $('#r_year').append('<td colspan="3" id="center" class="v_field">সালঃ ' + convertE2B(jsonYear[i].r_year) + '</td>');
                                $('#r_male_female').append('<td class="tg-0e45" id="rotate">পুরুষ</td>'
                                        + '<td class="tg-0e45" id="rotate">মহিলা</td>'
                                        + '<td class="tg-0e45" id="rotate">মোট</td>');
                                //Initialize sum variables
                                sum_count[i] = new Array(3);
                                sum_count[i][0] = 0;
                                sum_count[i][1] = 0;
                                sum_count[i][2] = 0;
                            }//End year loading.

                            var tableBody = $('#tableBody');
                            tableBody.html("");
                            for (var i = 0; i < jsonHouseholdHeadName.length; i++) {
                                //Make Village wise pop count row
                                var td_householdHeadName = '<td class="tg-0e45" colspan="4">' + jsonHouseholdHeadName[i].r_household_head_name + '</td>'; //Village name

                                var td_year_male_female = "";
                                var index = 0;
                                //Main login for year wise pop count place here
                                for (var k = 0; k < jsonYear.length; k++) {
                                    var isGet = false; //if any pop count of selected year
                                    var male_dash = "-", female_dash = "-", total_dash = "-"; //varibale for null data


                                    for (var j = 0; j < json.length; j++) {
                                        if (json[j].r_household_head_name === jsonHouseholdHeadName[i].r_household_head_name) {
                                            if (json[j].r_year === jsonYear[k].r_year) {
                                                isGet = true;
                                                index = j;
                                                break;
                                            }

                                        }

                                    }
                                    //Check and set previous year data. If exist yhen set previous to current.
                                    if (index > 0) {
                                        male_dash = json[index].r_male;
                                        female_dash = json[index].r_female;
                                        total_dash = json[index].r_pop_total;

                                        sum_count[k][0] += json[index].r_male;
                                        sum_count[k][1] += json[index].r_female;
                                        sum_count[k][2] += json[index].r_pop_total;
                                    } else if (isGet) {
                                        sum_count[k][0] += json[index].r_male;
                                        sum_count[k][1] += json[index].r_female;
                                        sum_count[k][2] += json[index].r_pop_total;
                                    }

                                    if (isGet) {
                                        td_year_male_female = td_year_male_female + '<td class="tg-0e45 v_field" style="text-align:center">' + convertE2B(json[index].r_male) + '</td>'
                                                + '<td class="tg-0e45 v_field" style="text-align:center">' + convertE2B(json[index].r_female) + '</td>'
                                                + '<td class="tg-0e45 v_field" style="text-align:center">' + convertE2B(json[index].r_pop_total) + '</td>';
                                    } else {
                                        td_year_male_female = td_year_male_female + '<td class="tg-0e45 v_field" style="text-align:center">' + male_dash + '</td>'
                                                + '<td class="tg-0e45 v_field" style="text-align:center">' + female_dash + '</td>'
                                                + '<td class="tg-0e45 v_field" style="text-align:center">' + total_dash + '</td>';
                                    }

                                }
                                //Final loading of pop cont row
                                var no = convertE2B((i + 1));
                                tableBody.append('<tr>'
                                        + '<td class="tg-0e45 v_field">' + no + '</td>'
                                        + '<td class="tg-0e45 v_field">' + convertE2B(json[index].r_hhno) + '</td>'
                                        + '<td class="tg-0e45 v_field">' + convertE2B(json[index].r_elco_no) + '</td>'
                                        + '' + td_householdHeadName + ''
                                        + '' + td_year_male_female + ''
                                        + '<tr>');

                                //Final Calculation                    
//                                if(i==(jsonHouseholdHeadName.length-1)){
//                                    var totalYearPopCount="";
//                                    for (var m = 0; m <  jsonTotal.length; m++) {
//                                        totalYearPopCount = totalYearPopCount +'<td class="tg-0e45 centerBold v_field">'+jsonTotal[m].male+'</td>'
//                                            +'<td class="tg-0e45 centerBold v_field">'+jsonTotal[m].female+'</td>'
//                                            +'<td class="tg-0e45 centerBold v_field">'+jsonTotal[m].total+'</td>';
//                                    }
//                                    tableBody.append('<tr class="centerBold">'
//                                        +'<td class="tg-0e45" colspan="7"  style="margin-left:170px;">সর্বমোট</td>'
//                                        +''+totalYearPopCount+''
//                                    +'</tr>');
//                                }
                            }
                            //End set vill wise population

                            //all total shows here
                            var totalYearPopCount = "";
                            for (var m = 0; m < jsonYear.length; m++) {
                                totalYearPopCount = totalYearPopCount + '<td class="tg-0e45 centerBold v_field">' + convertE2B(sum_count[m][0]) + '</td>'
                                        + '<td class="tg-0e45 centerBold v_field">' + convertE2B(sum_count[m][1]) + '</td>'
                                        + '<td class="tg-0e45 centerBold v_field">' + convertE2B(sum_count[m][2]) + '</td>';
                            }
                            tableBody.append('<tr class="centerBold">'
                                    + '<td class="tg-0e45" colspan="7"  style="margin-left:170px;">সর্বমোট</td>'
                                    + '' + totalYearPopCount + ''
                                    + '</tr>');
                            //End set sum of All total

                            $(".table-responsive table td").each(function () {
                                $(this).text(convertE2B($(this).text()));
                            });

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
    function resetPopulationCountKhanaWise() {
        $('#r_year').html("");
        $('#r_male_female').html("");
        $('#r_year').append('<td colspan="3" id="center">সালঃ <span id="year"></span></td>'
                + '<td colspan="3" id="center">সালঃ <span id="year"></span></td>'
                + '<td colspan="3" id="center">সালঃ <span id="year"></span></td>');
        $('#r_male_female').append('<td class="tg-0e45" id="rotate">পুরুষ</td>'
                + '<td class="tg-0e45" id="rotate">মহিলা</td>'
                + '<td class="tg-0e45" id="rotate">মোট</td>'
                + '<td class="tg-0e45" id="rotate">পুরুষ</td>'
                + '<td class="tg-0e45" id="rotate">মহিলা</td>'
                + '<td class="tg-0e45" id="rotate">মোট</td>'
                + '<td class="tg-0e45" id="rotate">পুরুষ</td>'
                + '<td class="tg-0e45" id="rotate">মহিলা</td>'
                + '<td class="tg-0e45" id="rotate">মোট</td>');
        var tableBody = $('#tableBody');
        tableBody.html("");
        for (var i = 0; i < 20; i++) {
            tableBody.append('<tr>'
                    + '<td class="tg-0e45"></td>'
                    + '<td class="tg-0e45"></td>'
                    + '<td class="tg-0e45"></td>'
                    + '<td class="tg-0e45" colspan="4"></td>'
                    + '<td class="tg-0e45"></td>'
                    + '<td class="tg-0e45"></td>'
                    + '<td class="tg-0e45"></td>'
                    + '<td class="tg-0e45"></td>'
                    + '<td class="tg-0e45"></td>'
                    + '<td class="tg-0e45"></td>'
                    + '<td class="tg-0e45"></td>'
                    + '<td class="tg-0e45"></td>'
                    + '<td class="tg-0e45"></td>'
                    + '</tr>');
        }
        tableBody.append('<tr>'
                + '<td class="tg-0e45" colspan="7">সর্বমোট</td>'
                + '<td class="tg-0e45"></td>'
                + '<td class="tg-0e45"></td>'
                + '<td class="tg-0e45"></td>'
                + '<td class="tg-0e45"></td>'
                + '<td class="tg-0e45"></td>'
                + '<td class="tg-0e45"></td>'
                + '<td class="tg-0e45"></td>'
                + '<td class="tg-0e45"></td>'
                + '<td class="tg-0e45"></td>'
                + '</tr>');
    }
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle"> Household-wise population</h1>
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
                    <h4 style="text-align: center;margin-top: 0px;;"><b>খানার জনসংখ্যার হিসাব ছক</b></h4>
                    <h5 style="text-align: center;margin-top: 10px;">সক্ষম দম্পতি সম্পন্ন এবং দম্পতি বিহীন খানার জনসংখ্যা </h5>

                    <div class="table-responsive">
                        <table class="tg" border="1px"  style="width: 910px" align="center">
                            <caption style="color:#000">গ্রামের নামঃ&nbsp;<b id="villageName">. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .</b></caption>
                            <thead>
                                <tr>
                                    <th rowspan="3" id='rotate' class="left" style="width:60px">ক্রমিক&nbsp;&nbsp;নং&nbsp;&nbsp;</th>
                                    <th rowspan="3" id='rotate' class="left" style="width:60px">খানা&nbsp;&nbsp;নং&nbsp;&nbsp;</th>
                                    <th rowspan="3" id='rotate' class="left" style="width:125px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;দম্পতি&nbsp;&nbsp;নং</th>
                                    <th colspan="4" rowspan="3" id='center'><p>খানা প্রধানের নাম</p></th>
                                </tr>
                                <tr id="r_year">
                                    <th colspan="3" id='center'>সালঃ <span id="year"></span></th>
                                    <th colspan="3" id='center'>সালঃ <span id="year"></span></th>
                                    <th colspan="3" id='center'>সালঃ <span id="year"></span></th>
                                </tr>
                                <tr id="r_male_female">
                                    <th class="tg-0e45" id='rotate'>পুরুষ</th>
                                    <th class="tg-0e45" id='rotate'>মহিলা</th>
                                    <th class="tg-0e45" id='rotate'>মোট</th>
                                    <th class="tg-0e45" id='rotate'>পুরুষ</th>
                                    <th class="tg-0e45" id='rotate'>মহিলা</th>
                                    <th class="tg-0e45" id='rotate'>মোট</th>
                                    <th class="tg-0e45" id='rotate'>পুরুষ</th>
                                    <th class="tg-0e45" id='rotate'>মহিলা</th>
                                    <th class="tg-0e45" id='rotate'>মোট</th>
                                </tr>
                            </thead>

                            <tbody id="tableBody">
                                <tr>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
                                    <td class="tg-0e45"></td>
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
                                    <td class="tg-0e45" colspan="7">সর্বমোট</td>
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

