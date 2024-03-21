<%-- 
    Document   : FPISupervisionReport
    Created on : Nov 23, 2020, 10:29:56 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla_test.js"></script>
<style>
    .datepicker-days > table, th, td {
        border: none;
    }
    .datepicker-years > table, th, td {
        border: none;
    }
    .datepicker-months > table, th, td {
        border: none;
    }
    table, th, td {
        border: 1px solid black;
    }
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
    [class*="col"] {
        margin-bottom: 10px;
    }
    #areaPanel .box {
        margin-bottom: 0px;
    }
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
        .box{
            border: 0
        }
        #areaPanel, #back-to-top, .box-header, .main-footer{
            display: none !important;
        }
    }
    #tablePanel{
        display: none;
    }
    #area{
        text-align: center;
    }
</style>

<script>
</script>
<section class="content-header">
    <h1>FPI supervision report<small></small></h1>
</section>

<!-- Main content -->
<section class="content">
    <%@include file="/WEB-INF/jspf/fpi_supervision_report.jspf" %>

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
                    <h4 style="text-align: center;margin-top: 0px;;">পরিবার পরিকল্পনা পরিদর্শকের তদারকি ছক</h4>
                    <h6 id="area"></h6>
                    <!--                    <center>( প্রত্যেকবার কর্মীকে পরিদর্শনের সময় তদারকি সহায়ক নির্দেশমালা* অনুযায়ী পূরণ করতে হবে )</center>-->
                </div>
                <div class="table-responsive">
                    <table border="1px" class="mis_table" style="width: 100%;">
                        <thead style="font-weight: normal">
                            <tr>
                                <th rowspan="3">পরিদর্শনের<br> তারিখ ও গ্রামের <br> নাম</th>
                                <!--                                <th rowspan="3">পরিবার<br> কল্যাণ<br> সহকারীর নাম</th>-->
                                <th rowspan="3" colspan="1">কর্মীর অগ্রিম<br> কর্মসূচী <br>কোন পর্যায়ে <br>( সঠিক /আগে / <br>পিছনে )</th>
                                <th rowspan="3" colspan="1">পর্যাপ্ত<br> সামগ্রী <br>আছে কি? <br>( হ্যাঁ /না )</th>
                                <th rowspan="3" colspan="1">পরিদর্শিত<br> দম্পতি <br>সমূহের <br>নম্বর</th>
                                <th colspan="11" style="text-align: center;">রেজিস্টারে লিপিবদ্ধ তথ্য যাচাইয়ের ফলাফল ( দম্পতি সংখ্যা )</th>
                            </tr>
                            <tr>
                                <th colspan="2" style="text-align: center;">পদ্ধতি প্রহনকারী /<br>ব্যবহারকারী</th>
                                <th colspan="2" style="text-align: center;">পদ্ধতির জন্য <br/>প্রেরণ&nbsp;&nbsp;&nbsp;</th>
                                <th rowspan="2"><span class="r-v">পার্শ্বপ্রতিক্রিয়ার জন্য প্রেরণ</span></th>
                                <th rowspan="2">যাচাইকৃত<br> গর্ভবতী<br> মায়ের সংখ্যা </th>
                                <th rowspan="2">যাচাইকৃত <br/>মিসো-<br/>প্রোস্টল<br/> সরবরাহপ্রাপ্ত <br/>গর্ভবতী <br/>মায়ের সংখ্যা</th>
                                <th rowspan="2">যাচাইকৃত <br/>৭.১% ক্লোর-<br/>হেক্সিডিন সরবরাহ প্রাপ্ত <br/>গর্ভবতী <br/>মায়ের সংখ্যা </th>
                                <th rowspan="2">অন্যান্য<br> দম্পতি</th>
                                <th rowspan="2" >মোট<br> যাচাইকৃত<br> দম্পতি&nbsp;&nbsp;</th>
                                <th rowspan="2">পরামর্শ ও <br>স্বাক্ষর</th>
                            </tr>
                            <tr>
                                <th><span class="r-v">সঠিক</span></th>
                                <th><span class="r-v">সঠিক নয়</span></th>
                                <th><span class="r-v">স্বাভাবিক</span></th>
                                <th><span class="r-v">প্রসব পরবর্তী</span></th>
                            </tr>
                            <tr>
                                <td>১</td>
                                <td colspan="1">২</td>
                                <td colspan="1">৩</td>
                                <td colspan="1">৪</td>
                                <td colspan="1">৫</td>
                                <td colspan="1">৬</td>
                                <td colspan="1">৭</td>
                                <td colspan="1">৮</td>
                                <td colspan="1">৯</td>
                                <td colspan="1">১০</td>
                                <td colspan="1">১১</td>
                                <td colspan="1">১২</td>
                                <td colspan="1">১৩</td>
                                <td colspan="1">১৪</td>
                                <td colspan="1">১৫</td>
                            </tr>
                        </thead>
                        <tbody id="tableBody">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    $(function () {

        $('#showdataButton').click(function () {

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
                if ($("#reportType:checked").val() == "dateWise") {
                    if ($("#sDate").val() == "") {
                        toastr["error"]("<b>শুরুর তারিখ সিলেক্ট করুন</b>");
                        return;
                    } else if ($("#eDate").val() == "") {
                        toastr["error"]("<b>শেষের তারিখ সিলেক্ট করুন</b>");
                        return;
                    }
                }

                $.ajax({
                    url: "fpi-supervision-report?action=showData",
                    type: "POST",
                    data: {
                        divisionId: $("select#division").val(),
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val(),
                        fwaUnit: $("select#unit").val(),
                        provCode: $("select#provCode").val(),
                        month: $("select#month").val(),
                        year: $("#year").val(),
                        reportType: $("#reportType:checked").val(),
                        startDate: $("#sDate").val(),
                        endDate: $("#eDate").val()
                    },
                    success: function (response) {
                        try{
                            var json = JSON.parse(response);
                            console.log(json);
                            if (json.length === 0) {
                                toastr["error"]("<h4><b>কোন ডাটা পাওয়া যায়নি</b></h4>");
                                return;
                            }
                            $("#tablePanel").css("display", "block");


                            var tableBody = $('#tableBody');
                            tableBody.empty();

                            for (var i = 0; i < json.length; i++) {
                                var parsedData = "<tr>"
                                        + "<td style='vertical-align: top;'>" + e2b($.app.date(json[i].rvdate).date) + "<br/>" + json[i].rvdate_village_list_ + "</td>"
                                        + "<td style='vertical-align: top;'>" + json[i].rfpaadvance_2 + "</td>"
                                        + "<td style='vertical-align: top;'>" + json[i].rsufficientmaterrial_3 + "</td>"
                                        + "<td style='vertical-align: top;text-align: left'>" + getSortedRange(json[i].relcolist_4) + "</td>"
                                        + "<td style='vertical-align: top;'>" + parsingAs(json[i].rrightelco, 0, 'e2b') + "</td>"
                                        + "<td style='vertical-align: top;'>" + parsingAs(json[i].rnot_correct_elco, 0, 'e2b') + "</td>"
                                        + "<td style='vertical-align: top;'>" + parsingAs(json[i].rnormal, 0, 'e2b') + "</td>"
                                        + "<td style='vertical-align: top;'>" + parsingAs(json[i].raftedelivery, 0, 'e2b') + "</td>"
                                        + "<td style='vertical-align: top;'>" + parsingAs(json[i].rsendtosideeffect, 0, 'e2b') + "</td>"
                                        + "<td style='vertical-align: top;'>" + parsingAs(json[i].rverified_pregwoman_10, 0, 'e2b') + "</td>"
                                        + "<td style='vertical-align: top;'>" + parsingAs(json[i].rnumberofmisopostral_11, 0, 'e2b') + "</td>"
                                        + "<td style='vertical-align: top;'>" + parsingAs(json[i].rclorohexidin_12, 0, 'e2b') + "</td>"
                                        + "<td style='vertical-align: top;'>" + parsingAs(json[i].rotherselco, 0, 'e2b') + "</td>"
                                        + "<td style='vertical-align: top;'>" + parsingAs(json[i].rtotalelco, 0, 'e2b') + "</td>"
                                        + "<td style='vertical-align: top;'>" + parsingAs(json[i].radvisename) + "</td>"
                                        + "</tr>";
                                tableBody.append(parsedData);
                            }
                        }
                        catch(err){
                            toastr['error'](err);
                        }
                    }, error: function (error) {
                        toastr['error'](error);
                    }
                });
            }
        });



        function getSortedRange(num) {
            if (isNaN(num)) {
                return '-';
            }
            num = num.split(", ");
            num = num.map(function (n, i) {
                return parseInt(n);
            });
            num = num.sort(function (a, b) {
                return a - b;
            });
            var rangeOfNum = "", rangeContinue = false;

            for (var i = 0; i < num.length; i++) {
                if (num[i] == (num[i - 1] + 1) && num[i] == (num[i + 1] - 1)) {
                    if (!rangeContinue) {
                        rangeOfNum += " - ";
                        rangeContinue = true;
                    }
                    if (i == (num.length - 1)) {
                        rangeOfNum += e2b(num[i]);
                    }
                } else {
                    if (rangeContinue) {
                        rangeOfNum += e2b(num[i - 1]);
                        rangeContinue = false;
                    }
                    rangeOfNum += ", " + e2b(num[i]);
                }
            }
            return rangeOfNum.substring(2, rangeOfNum.length);
        }


        //
        var _print = window.print;
        window.print = function () {
            document.title = ".";
            printCatchmentarea();
            _print();
            document.title = "eMIS";
            $("#area").text("");
        }

        //
        function printCatchmentarea() {
            var division = "বিভাগ: <b style='color:#3C8DBC'>" + $("#division option:selected").text() + "</b>";
            var district = " জেলা: <b style='color:#3C8DBC'>" + $("#district option:selected").text() + "</b>";
            var upazila = " উপজেলা: <b style='color:#3C8DBC'>" + $("#upazila option:selected").text() + "</b>";
            var union = " ইউনিয়ন: <b style='color:#3C8DBC'>" + $("#union option:selected").text() + "</b>";
            var unit = " ইউনিট: <b style='color:#3C8DBC'>" + $("#unit option:selected").text() + "</b>";
            $("#area").html(division + ',&nbsp;&nbsp;' +
                    district + ',&nbsp;&nbsp;' +
                    upazila + '&nbsp;&nbsp;' +
                    union + '&nbsp;&nbsp;' +
                    unit);
        }
    });
</script>

<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>