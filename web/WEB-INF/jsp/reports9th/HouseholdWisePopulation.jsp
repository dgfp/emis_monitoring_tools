<%-- 
    Document   : HouseholdWisePopulation
    Created on : Jan 4, 2021, 7:34:32 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla_test.js"></script>
<style>
    /*    #atPointTable> table, th, td {
            border: 1px solid black;
        }*/
    th, td {
        padding: 5px;
        text-align: center;
    }
    th{
        vertical-align: bottom;
    }
    .tableTitle{
        font-family: SolaimanLipi;
        font-size: 20px;
        margin-top: 0px;
    }
    table{
        font-family: SolaimanLipi;
        font-size: 13px;
    }
    [class*="col"] { margin-bottom: 10px; }
    #areaPanel .box { margin-bottom: 0px; }
    #dateDiv{
        display: none;
    }
    .block{
        background-color:#7c868c!important;  
        color: #7c868c;
    }
    @media print {
        .tableTitle{
            display: block;
            margin-top: -2px;
        }
        .reg-fwa-13{
            margin-top: -30px!important;
        }
        .box{ border: 0}
        #areaPanel, #back-to-top, .box-header, .main-footer{
            display: none !important;
        }
    }
    #tablePanel, #atPointTable, #yearlyTable{
        display: none;
    }
</style>

<script>
</script>
<section class="content-header">
    <h1>Household-wise population<small></small></h1>
</section>

<!-- Main content -->
<section class="content">
    <%@include file="/WEB-INF/jspf/HouseholdAndVilllageWisePopulation.jspf" %>


    <!--Table body-->
    <div class="col-ld-12" id="tablePanel">
        <div class="box box-primary full-screen">
            <div class="box-header with-border">
                <div class="box-tools pull-right" style="margin-top: -10px;">
                    <button type="button" class="btn btn-flat btn-default btn-xs bold" onclick="window.print();"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                    <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                </div>
            </div>
            <div class="box-body">
                <div class="tableTitle">
                    <h4 style="text-align: center;margin-top: 0px;;">খানার জনসংখ্যার হিসাব ছক</h4>
                    <center>সক্ষম দম্পতি, দম্পতি এবং দম্পতি বিহীন বাড়ীর জনসংখ্যা</center>
                </div>
                <h6 id="area"></h6><br/>
                <div class="row" id="atPointTable">
                    <div class="col-md-10 col-md-offset-1">
                        <div class="table-responsive">
                            <caption>গ্রামের নামঃ&nbsp;&nbsp;<b class="villageName">. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .</b></caption>
                            <table border="1px" class="mis_table" style="width: 100%;">
                                <thead style="font-weight: normal">
                                    <tr>
                                        <th rowspan="3">ক্রমিক  নং</th>
                                        <th rowspan="3">দম্পতি  নং</th>
                                        <th rowspan="3">পরিবার প্রধানের নাম</th>
                                    </tr>
                                    <tr>
                                        <th colspan="4" style="text-align: center;">তারিখ: <span id="atPointTableDate"></span></th>
                                    </tr>
                                    <tr>
                                        <th>পুরুষ</th>
                                        <th>মহিলা</th>
                                        <th>তৃতীয় লিঙ্গ</th>
                                        <th>মোট</th>
                                    </tr>
                                </thead>
                                <tbody id="atPointTableBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!--Yearly data-->
                <div class="row" id="yearlyTable">
                    <div class="col-md-10 col-md-offset-1" id="yearly-col">
                        <div class="table-responsive">
                            <caption>গ্রামের নামঃ&nbsp;<b class="villageName">. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .</b></caption>
                            <table border="1px" class="mis_table" style="width: 100%;">
                                <thead style="font-weight: normal" id="yearlyTableHead">
                                    <tr>
                                        <th rowspan="3">ক্রমিক  নং</th>
                                        <th rowspan="3">দম্পতি  নং</th>
                                        <th rowspan="3">পরিবার প্রধানের নাম</th>
                                    </tr>
                                    <tr>
                                        <th colspan="4" style="text-align: center;">মাসঃ জানুয়ারি<br/>সনঃ ২০২০</th>
                                        <th colspan="4" style="text-align: center;">মাসঃ ফেব্রুয়ারি<br/>সনঃ ২০২০</th>
                                        <th colspan="4" style="text-align: center;">মাসঃ মার্চ<br/>সনঃ ২০২০</th>
                                    </tr>
                                    <tr>
                                        <th>পুরুষ</th>
                                        <th>মহিলা</th>
                                        <th>তৃতীয় লিঙ্গ</th>
                                        <th>মোট</th>

                                        <th>পুরুষ</th>
                                        <th>মহিলা</th>
                                        <th>তৃতীয় লিঙ্গ</th>
                                        <th>মোট</th>

                                        <th>পুরুষ</th>
                                        <th>মহিলা</th>
                                        <th>তৃতীয় লিঙ্গ</th>
                                        <th>মোট</th>
                                    </tr>
                                </thead>
                                <tbody id="yearlyTableBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    $(function () {
        var ui = {
            tablePanel: $("#tablePanel"),
            atPointTable: $("#atPointTable"),
            yearlyTable: $("#yearlyTable"),
            yearlyTableHead: $("#yearlyTableHead"),
            atPointTableBody: $("#atPointTableBody"),
            yearlyTableBody: $("#yearlyTableBody"),
            atPointTableDate: $("#atPointTableDate"),
            villageName: $(".villageName")
        };
        $('#showData').click(function () {
            var form = $.app.pairs('form');
            console.log(form);
            if (!validateReport(form)) {
                return;
            }

            $.ajax({
                url: "household-wise-population?action=" + form.viewType,
                data: {
                    data: JSON.stringify(getPayload(form))
                },
                type: 'POST',
                success: function (data) {
                    data = JSON.parse(data);
                    console.log(data);
                    if (data.length === 0) {
                        toast("error", "No data found");
                        return;
                    }
                    data = getBlankFiltered(data);
                    var cal = new Calc(data);

                    ui.tablePanel.fadeIn();
                    ui.villageName.text(getDistinct(data, 'villagename').join(", "));
                    if (form.viewType == "atPoint") {
                        ui.atPointTable.fadeIn();
                        ui.yearlyTable.css("display", "none");
                        ui.atPointTableBody.empty();
                        ui.atPointTableDate.text(e2b(form.endDate));
                        //At point data rendering
                        $.each(data, function (key, v) {
                            var household_head_name = v.household_head_name == null ? "-" : v.household_head_name;
                            ui.atPointTableBody.append("<tr>\
                                        <td>" + e2b(key + 1) + "</td>\
                                        <td style='text-align: left'>" + e2b(nullCheck(v.elconos)) + "</td>\\n\
                                        <td style='text-align: left'>" + nullCheck(household_head_name) + "</td>\
                                        <td>" + e2b(nullZero(v.male_count)) + "</td>\
                                        <td>" + e2b(nullZero(v.female_count)) + "</td>\
                                        <td>" + e2b( nullZero(v.population) - (nullZero(v.male_count)  + nullZero(v.female_count)) ) + "</td>\
                                        <td>" + e2b(nullZero(v.population)) + "</td>\
                                    </tr>");
                        });
                        ui.atPointTableBody.append("<tr>\
                                        <td colspan='3' style='text-align: right'>সর্বমোট</td>\
                                        <td>" + e2b(cal.sum.male_count) + "</td>\
                                        <td>" + e2b(cal.sum.female_count) + "</td>\
                                        <td>" + e2b( cal.sum.population - (cal.sum.male_count + cal.sum.female_count) ) + "</td>\
                                        <td>" + e2b(cal.sum.population) + "</td>\
                                    </tr>");



                    } else {
                        ui.atPointTable.css("display", "none");
                        ui.yearlyTable.fadeIn();
                        
                        if(form.yearlyViewType==4){
                            $("#yearly-col").removeClass('col-md-10 col-md-offset-1').addClass('col-md-12');
                        }else{
                            $("#yearly-col").removeClass().addClass('col-md-10 col-md-offset-1');
                        }

                        var years = getDistinct(data, 'year');
                        var year, population;

                        ui.yearlyTableHead.empty();
                        ui.yearlyTableBody.empty();
                        
                        //Table Header
                        $.each(years, function (index, value) {
                            year += '<th colspan="4" style="text-align: center;">মাসঃ ফেব্রুয়ারি<br/>সনঃ ' + e2b(value) + '</th>';
                            population += '<th>পুরুষ</th>\
                                                    <th>মহিলা</th>\
                                                    <th>তৃতীয় লিঙ্গ</th>\
                                                    <th>মোট</th>';
                        });
                        ui.yearlyTableHead.append('<tr>\
                                                                        <th rowspan="3">ক্রমিক  নং</th>\
                                                                        <th rowspan="3">দম্পতি  নং</th>\
                                                                        <th rowspan="3">পরিবার প্রধানের নাম</th>\
                                                                </tr>\
                                                                <tr>' + year + '</tr>\
                                                                <tr>' + population + '</tr>');



                        //Table data
                        var uniqueData = data.filter(function (obj) {
                            return obj.year == years[years.length - 1]
                        });
                        console.log(uniqueData);
                        $.each(uniqueData, function (i, v) {
                            var household_head_name = v.household_head_name == null ? "-" : v.household_head_name;
                            var parsedData = "<tr>\
                                        <td>" + e2b(i + 1) + "</td>\
                                        <td style='text-align: left'>" + e2b(v.elconos) + "</td>\
                                        <td style='text-align: left'>" + nullCheck(household_head_name) + "</td>";
        
                            $.each(years, function (index, value) {
                                var d = data.filter(function (obj) {
                                    return obj.year == value && obj.hhno == v.hhno; //&& obj.household_head_name == v.household_head_name;
                                });
                                d = d[0];
                                if (d != undefined) {
                                    parsedData += "<td>" + e2b(nullZero(d.male_count)) + "</td>\
                                                                <td>" + e2b(nullZero(d.female_count)) + "</td>\
                                                                <td>" + e2b(nullZero(d.population) - (nullZero(d.male_count)  + nullZero(d.female_count)) ) + "</td>\
                                                                <td>" + e2b(nullZero(d.population)) + "</td>";
                                } else {
                                    parsedData += "<td>-</td>\
                                                                <td>-</td>\
                                                                <td>-</td>\
                                                                <td>-</td>";
                                }

                            });
                            parsedData += "</tr>";
                            ui.yearlyTableBody.append(parsedData);
                        });

                        //Total Data view
                        ui.yearlyTableBody.append("<tr>\
                                        <td colspan='3' style='text-align: right'>সর্বমোট</td>\
                                        " + getYearlyTotal(years, data) + "\
                                        </tr>");

                    }
                },
                error: function () {
                    toast("error", "Request can't be processed");
                }
            });
        });
    });
</script>

<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>