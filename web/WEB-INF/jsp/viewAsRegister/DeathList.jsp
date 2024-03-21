<%-- 
    Document   : DeathList
    Created on : Mar 25, 2018, 6:50:25 AM
    Author     : RHIS082
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_register_wise_view.js"></script>
<link href="resources/css/registerWiseView.css" rel="stylesheet" type="text/css"/>
<style>
    .tableTitle{
        font-family: SolaimanLipi;
        display: none;
    }
    table{
        font-family: SolaimanLipi;
        font-size: 12px;
    }
    #name{
        font-size: 11px;
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
    .age{
        width: 5%!important;
    }
</style>
<script>
    $(document).ready(function () {
        var tableBody = $("#tbody");
        var regExp = /(\d{1,2})\/(\d{1,2})\/(\d{2,4})/; //for date compare


        $('#showdataButton').on('click', function (event) {

            if ($("select#division").val() == "" || $("select#division").val() == 0) {
                toastr["error"]("<h4><b>বিভাগ সিলেক্ট করুন </b></h4>");
                return;
            } else if ($("select#district").val() == "" || $("select#district").val() == 0) {
                toastr["error"]("<h4><b>জেলা সিলেক্ট করুন </b></h4>");
                return;
            } else if ($("#endDate").val() == "") {
                toastr["error"]("<h4><b>শেষের তারিখ সিলেক্ট করুন</b></h4>");
                return;
            } else if (parseInt($("#startDate").val().replace(regExp, "$3$2$1")) > parseInt($("#endDate").val().replace(regExp, "$3$2$1"))) {
                toastr["error"]("<h4><b>শুরুর তারিখ শেষের তারিখের থেকে ছোট হবে</b></h4>");
                return;
            } else {

                Pace.track(function () {
                    $.ajax({
                        url: "DeathList",
                        data: {
                            divisionId: $("select#division").val(),
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            unitId: $("select#unit").val(),
                            startDate: $("#startDate").val() == "" ? "01/01/2015" : $("#startDate").val(),
                            endDate: $("#endDate").val()
                        },
                        type: 'POST',
                        success: function (response) {
                            var result = JSON.parse(response);
                            console.log(result);
                            tableBody.empty();
                            if (result.status == "error") {
                                setDefaultTable();
                                toastr["error"]("<h4><b>" + result.message + "</b></h4>");
                                return;
                            }
                            var json = result.data;
                            if (json.length === 0) {
                                toastr["error"]("<h4><b>কোন ডাটা পাওয়া যায়নি</b></h4>");
                                setDefaultTable();
                                return;
                            }
                            for (var i = 0; i < json.length; i++) {
                                var male = "", female = "";
                                json[i].sex == 1 ? male = json[i].date_of_death : female = json[i].date_of_death
                                var cause_of_death = json[i].cause_of_death.split("-");
                                cause_of_death = cause_of_death[0] + " (" + cause_of_death[1] + ")";

                                //Age Calculation
                                var zeroToSevenDays = json[i].age_as_day < 8 && json[i].deathofpregwomen != 1 ? json[i].age_as_day + " দিন" : "-";
                                var eightToTwentyeight = json[i].age_as_day >= 8 && json[i].age_as_day <= 28 && json[i].deathofpregwomen != 1 ? json[i].age_as_day + " দিন" : "-";
                                var twentynineToOneYear = json[i].age_as_day >= 29 && json[i].age_as_day < 365 && json[i].deathofpregwomen != 1 ? json[i].age_as_day + " দিন" : "-";
                                var maternalDeath = json[i].deathofpregwomen == 1 ? json[i].age_as_year + " বছর" : "-";
                                var oneToBelowFive = json[i].age_as_year >= 1 && json[i].age_as_year < 5 && json[i].deathofpregwomen != 1 ? json[i].age_as_year + " বছর" : "-";
                                var otherDeath = json[i].age_as_year >= 5 && json[i].deathofpregwomen != 1 ? json[i].age_as_year + " বছর" : "-";

                                var row = "<tr>"
                                        + "<td class='center'>" + convertE2B((i + 1)) + "</td>"
                                        + "<td>" + convertE2B(convertDateFrontFormat(json[i].info_collection_date)) + "</td>"
                                        + "<td>" + convertE2B(json[i].elco_household) + "</td>"
                                        + "<td>" + json[i].villagename + "</td>"
                                        + "<td>" + json[i].name_of_death_person + "</td>"
                                        + "<td>" + json[i].father_name + "</td>"
                                        + "<td class='center'>" + convertE2B(convertDateFrontFormat(male)) + "</td>"
                                        + "<td class='center'>" + convertE2B(convertDateFrontFormat(female)) + "</td>"
                                        + "<td class='center'> " + convertE2B(zeroToSevenDays) + "</td>"
                                        + "<td class='center'> " + convertE2B(eightToTwentyeight) + "</td>"
                                        + "<td class='center'> " + convertE2B(twentynineToOneYear) + "</td>"
                                        + "<td class='center'>" + convertE2B(oneToBelowFive) + "</td>"
                                        + "<td class='center'>" + convertE2B(maternalDeath) + "</td>"
                                        + "<td class='center'>" + convertE2B(otherDeath) + "</td>"
                                        + "<td>" + cause_of_death + "</td>"
                                        + "</tr>";
                                $(tableBody).append(row);
                            }

                            if (json.length < 18) {
                                for (var i = 0; i < 18 - json.length; i++) {
                                    var row = "<tr>"
                                            + "<td></td>"
                                            + "<td></td>"
                                            + "<td></td>"
                                            + "<td></td>"
                                            + "<td></td>"
                                            + "<td></td>"
                                            + "<td></td>"
                                            + "<td></td>"
                                            + "<td></td>"
                                            + "<td></td>"
                                            + "<td></td>"
                                            + "<td></td>"
                                            + "<td></td>"
                                            + "<td></td>"
                                            + "<td></td>"
                                            + "</tr>";
                                    $(tableBody).append(row);
                                }

                            }



                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            setDefaultTable();
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    });//End Ajax
                }); //end pace
            }//end validation else
        });

        setDefaultTable();
        function setDefaultTable() {
            $(tableBody).html("");
            for (var i = 0; i < 18; i++) {
                $(tableBody).append('<tr>'
                        + '<td></td>'
                        + '<td></td>'
                        + '<td></td>'
                        + '<td></td>'
                        + '<td></td>'
                        + '<td></td>'
                        + '<td></td>'
                        + '<td></td>'
                        + '<td></td>'
                        + '<td></td>'
                        + '<td></td>'
                        + '<td></td>'
                        + '<td></td>'
                        + '<td></td>'
                        + '<td></td>'
                        + '</tr>');
            }
        }

    });

</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle">Death list <small>১৩. মৃত্যু তালিকা ছক</small></h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <%@include file="/WEB-INF/jspf/registerViewBangla.jspf" %>
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
                        <h3 class="tableTitle"><center>১৩. মৃত্যু তালিকা ছক</center></h3>
                        <div class="reg-fwa-13 table-data">
                            <center><small style="font-family: SolaimanLipi;font-size: 15px;margin-top: 4px!important">(ইউনিটের সকল মৃত্যুর তথ্য তালিকাভুক্ত করুন )</small></center>
                            <table>
                                <thead class="center">
                                    <tr>
                                        <td rowspan="2" style="width: 3%">ক্রমিক নং</td> 
                                        <td rowspan="2" style="width: 4%">তথ্য সংগ্রহের তারিখ</td>
                                        <td rowspan="2" style="width: 5%">খানা/দম্পতি<br>নং (যদি <br>থাকে)</td>
                                        <td rowspan="2" style="width: 7%">গ্রামের নাম</td>
                                        <td rowspan="2" style="width: 13%">মৃত ব্যক্তির নাম</td>
                                        <td rowspan="2" style="width: 13%">পিতা/ স্বামীর নাম</td>
                                        <td rowspan="1" colspan="2" class="center">মৃত্যুর তারিখ</td>
                                        <td rowspan="1" colspan="6"><center>প্রযোজ্য ঘরে মৃত ব্যক্তির মৃতকালীন বয়স লিখুন</center></td>
                                <td rowspan="2" style="width: 13%">মৃত্যুর কারণ</td>
                                </tr>
                                <tr>
                                    <td style="width: 4%">পুরুষ</td>
                                    <td style="width: 4%">মহিলা</td>
                                    <td class="age">০ থেকে<br>৭ দিন</td>
                                    <td class="age"> ৮ থেকে<br>২৮ দিন</td>
                                    <td class="age">২৯ দিন<br>থেকে ১ <br>বৎসরের<br>কম</td>
                                    <td class="age">১ বৎসর<br>থেকে ৫ <br>বৎসরের <br>কম</td>
                                    <td class="age">মাতৃ মৃত্যু</td>
                                    <td class="age">অন্যান্য<br>সকল<br>মৃত্যু</td>
                                </tr>
                                <tr>
                                    <td>১</td>
                                    <td>২</td>
                                    <td>৩</td>
                                    <td>৪</td>
                                    <td>৫</td>
                                    <td>৬</td>
                                    <td>৭</td>
                                    <td>৮</td>
                                    <td>৯</td>
                                    <td>১০</td>
                                    <td>১১</td>
                                    <td>১২</td>
                                    <td>১৩</td>
                                    <td>১৪</td>
                                    <td>১৫</td>
                                </tr>
                                </thead>
                                <tbody id="tbody">
                                    <!--                                    <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                        <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                        <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                        <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                        <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                        <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                        <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                        <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                        <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                        <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                        <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                        <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                        <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                        <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                        <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                        <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                        <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                        <tr>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                        </tr>-->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
    </div>
</div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>