<%-- 
    Document   : ZeroToEighteenthMonthAgedChildList
    Created on : Mar 25, 2018, 6:05:36 AM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_register_wise_view.js"></script>
<link href="resources/css/registerWiseView.css" rel="stylesheet" type="text/css"/>
<style>
    .dose{
        width: 4%!important;
    }
    .none{
        display: none;
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
                        url: "ZeroToEighteenthMonthAgedChildList",
                        data: {
                            divisionId: $("select#division").val(),
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            unitId: $("select#unit").val(),
//                            startDate: $("#startDate").val() == "" ? "01/01/2015" : $("#startDate").val(),
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
                            //Start rendering
                            for (var i = 0; i < json.length; i++) {
                                var male = "", female = "";
                                json[i].sex == 1 ? male = json[i].calculated_age + " মাস" : female = json[i].calculated_age + " মাস";
                                var given_vaccine_list = json[i].given_vaccine_list.split(",");

                                if (isNaN(json[i].elco_no) || json[i].elco_no == "") {
                                    json[i].elco_no = "-";
                                }

                                var row = "<tr>"
                                        + "<td class='center'>" + convertE2B((i + 1)) + "</td>"
                                        + "<td class='center'>" + convertE2B(json[i].elco_no) + "</td>"
                                        + "<td class='center'>" + convertE2B(convertDateFrontFormat(json[i].info_collect_date)) + "</td>"
                                        + "<td>" + json[i].nameeng + "</td>"
                                        + "<td class='center'>" + convertE2B(male) + "</td>"
                                        + "<td class='center'>" + convertE2B(female) + "</td>";
                                //Set vaccine status
                                //vaccine series (1,2,3,4,5,6,7,8,9,10,11,12,13,14);
                                given_vaccine_list.includes("1") ? row += "<td class='center'>✔</td>" : row += "<td></td>";
                                given_vaccine_list.includes("2") ? row += "<td class='center'>✔</td>" : row += "<td></td>";
                                given_vaccine_list.includes("3") ? row += "<td class='center'>✔</td>" : row += "<td></td>";
                                given_vaccine_list.includes("4") ? row += "<td class='center'>✔</td>" : row += "<td></td>";
                                given_vaccine_list.includes("5") ? row += "<td class='center'>✔</td>" : row += "<td></td>";
                                given_vaccine_list.includes("6") ? row += "<td class='center'>✔</td>" : row += "<td></td>";
                                given_vaccine_list.includes("7") ? row += "<td class='center'>✔</td>" : row += "<td></td>";
                                given_vaccine_list.includes("8") ? row += "<td class='center'>✔</td>" : row += "<td></td>";
                                given_vaccine_list.includes("9") ? row += "<td class='center'>✔</td>" : row += "<td></td>";
                                given_vaccine_list.includes("10") ? row += "<td class='center'>✔</td>" : row += "<td></td>";
                                given_vaccine_list.includes("11") ? row += "<td class='center'>✔</td>" : row += "<td></td>";
                                given_vaccine_list.includes("12") ? row += "<td class='center'>✔</td>" : row += "<td></td>";
                                given_vaccine_list.includes("13") ? row += "<td class='center'>✔</td>" : row += "<td></td>";
                                given_vaccine_list.includes("14") ? row += "<td class='center'>✔</td>" : row += "<td></td>";
                                row += "</tr>";
                                $(tableBody).append(row);

                            }

                            if (json.length < 18) {
                                for (var i = 0; i < 18 - json.length; i++) {
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
                                            + '<td></td>'
                                            + '<td></td>'
                                            + '<td></td>'
                                            + '<td></td>'
                                            + '<td></td>'
                                            + '</tr>');
                                }
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            tableBody.empty();
                            setDefaultTable();
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    });//End Ajax
                }); //end pace
            }//end validation else
        });

        setDefaultTable();
        function setDefaultTable() {
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
    <h1 id="pageTitle">0-15 month children <small>৯. শূন্য থেকে ১৫ মাস বয়সী শিশুর তালিকা ছক</small></h1>
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
                        <h3 class="tableTitle"><center>৯. শূন্য থেকে ১৫ মাস বয়সী শিশুর তালিকা ছক</center></h3>
                        <div class="reg-fwa-9 table-data">
                            <!--                            <h6 class="fill_gap" style="font-family: SolaimanLipi;font-size: 15px;"><span class="subject">গ্রামের নামঃ</span> </h6>-->
                            <table>
                                <thead>
                                    <tr>
                                        <td rowspan="3" colspan="1" class="center" style="width: 4%!important">ক্রমিক নং</td>
                                        <td rowspan="3" colspan="1" class="center" style="width: 4%!important;">দম্পতি নং</td>
                                        <td rowspan="3" colspan="1" class="center" style="width: 7%!important">তথ্য সংগ্রহের <br>তারিখ</td>
                                        <td rowspan="5" colspan="1" style="text-align: center;width: 18%!important">শিশুর নাম<br> (০ - ১৫ মাস)</td>
                                        <td rowspan="2" colspan="2" class="center">জন্ম তারিখ/<br> বয়স</td>
                                        <td rowspan="1" colspan="14" class="center">টিকা প্রদানের তারিখ</td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2" colspan="1" class="center dose">বিসিজি</td>
                                        <td colspan="3" class="center">পেন্টাভ্যালেন্ট<br> (ডিপিটি, হেপ-বি, হিব)</td>
                                        <td colspan="3" class="center">পিসিভি</td>
                                        <td colspan="4" class="center">ওপিভি</td>
                                        <td rowspan="4" colspan="1" class="center dose">আই<br>পিভি</td>
                                        <td rowspan="2" colspan="1" class="center dose">এমআর<br>(হাম ও<br>রুবেলা)</td>
                                        <td rowspan="2" colspan="1" class="center dose">হাম/<br/>এমআর <br>(২য় ডোজ)</td>
                                    </tr>
                                    <tr>
                                        <td class="center" style="width: 5%!important">ছেলে</td>
                                        <td class="center" style="width: 5%!important">মেয়ে</td>
                                        <td class="center dose">১ম</td>
                                        <td class="center dose">২য়</td>
                                        <td class="center dose">৩য়</td>
                                        <td class="center dose">১ম</td>
                                        <td class="center dose">২য়</td>
                                        <td class="center dose">৩য়</td>
                                        <td class="center dose">০</td>
                                        <td class="center dose">১ম</td>
                                        <td class="center dose">২য়</td>
                                        <td class="center dose">৩য়</td>
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
                                                                        </tr>-->
                                </tbody>
                            </table>
                            <h4 style="font-family: SolaimanLipi;font-size: 15px;">বিশেষ দ্রষ্টব্যঃ রেজিস্ট্রেশন কালীন সময়ে  ০-১৫ মাস বয়সী সকল শিশুর রেজিস্ট্রেশনের পর জন্মগ্রহণকারী সকল শিশু ও পরবর্তী সময়ে কোনো মহিলা যদি   ০-১৫ মাস বয়সী শিশু নিয়ে যদি  এলাকায় বসবাসের জন্য আসে তাহলে ঐ শিশুর রেজিস্ট্রেশন করতে হবে।  </h4>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
    </div>
</div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>