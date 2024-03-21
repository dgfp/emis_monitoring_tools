<%-- 
    Document   : AdolescentsHealthCareList
    Created on : Mar 25, 2018, 6:39:02 AM
    Author     : Helal | m.helal.k@gmail.com
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_register_wise_view.js"></script>
<link href="resources/css/registerWiseView.css" rel="stylesheet" type="text/css"/>
<script>
    $(document).ready(function () {
        var tableBody = $("#tbody");
        var regExp = /(\d{1,2})\/(\d{1,2})\/(\d{2,4})/; //for date compare

        $('#showdataButton').on('click', function (event) {
            setDefaultTable();
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
                        url: "AdolescentsHealthCareList",
                        data: {
                            divisionId: $("select#division").val(),
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            unitId: $("select#unit").val(),
                            startDate: $("#startDate").val() == "" ? "01/01/2015" : $("#startDate").val(),
                            endDate: $("#endDate").val()
//                        divisionId: 30,
//                        districtId: 93,
//                        upazilaId: 66,
//                        unionId: 63,
//                        unitId: $("select#unit").val(),
//                        startDate: $("#startDate").val() == "" ? "01/01/2015" : $("#startDate").val(),
//                        endDate: $("#endDate").val()
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
                                setDefaultTable();
                                toastr["error"]("<h4><b>কোন ডাটা পাওয়া যায়নি</b></h4>");
                                return;
                            }
                            for (var i = 0; i < json.length; i++) {
                                var visit_problem = json[i].agg_visit_problem.split('#').sort();

                                var male = "", female = "";
                                json[i].sex == 1 ? male = json[i].calculated_age + " বছর" : female = json[i].calculated_age + " বছর";

                                var elco_household = json[i].elco_no;
                                if (isNaN(json[i].elco_no) || json[i].elco_no == "") {
                                    elco_household = json[i].hhno
                                }

                                var tableBodyContent = '<tr>'
                                        + '<td class="center">' + convertE2B((i + 1)) + '</td>'
                                        + '<td class="center">' + convertE2B(elco_household) + '</td>'
                                        + '<td><span id="name">' + json[i].name + '</td>'
                                        + '<td class="center">' + convertE2B(male) + '</td>'
                                        + '<td class="center">' + convertE2B(female) + '</td>';

//                                $(tableBody).append('<tr>'
//                                        + '<td class="center">' + convertE2B((i + 1)) + '</td>'
//                                        + '<td>' + convertE2B(json[i].hhno) + '</td>'
//                                        + '<td><span id="name">' + json[i].name + '</td>'
//                                        + '<td>' + convertE2B(male) + '</td>'
//                                        + '<td>' + convertE2B(female) + '</td>'
//                                        + '<td></td>'
//                                        + '<td></td>'
//                                        + '<td></td>'
//                                        + '<td></td>'
//                                        + '<td></td>'
//                                        + '<td></td>'
//                                        + '<td></td>'
//                                        + '<td></td>'
//                                        + '<td>' + json[i].remarks + '</td>'
//                                        + '<td</tr>');

                                //agg_visit_problem
                                for (var j = 0; j < 8; j++) {
                                    if (visit_problem[j] != undefined) {
                                        var temp = visit_problem[j].split(',');
                                        var row = "";

                                        for (var k = 0; k < temp.length; k++) {
                                            if (k == 0) {
                                                row += convertE2B(convertDateFrontFormat(temp[k])) + "<br>";
                                            } else {
                                                row += convertE2B("<span>" + getProblem(temp[k]) + "</span>   ");
                                            }
                                        }

                                        //visit_problem[j].substring(0, visit_problem[j].length - 1); 

                                        tableBodyContent += '<td class="center">' + row + '</td>';
                                    } else {
                                        tableBodyContent += '<td>-</td>';
                                    }
                                }


                                tableBodyContent += '<td>' + json[i].remarks + '</td>'
                                        + '<td</tr>';
                                $(tableBody).append(tableBodyContent);


                            }

                            if (json.length < 16) {
                                for (var i = 0; i < 16 - json.length; i++) {
                                    $(tableBody).append('<tr>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                    </tr>');
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

        function  getProblem(id) {
            var units = {
                15: ["ক"],
                16: ["খ"],
                17: ["গ"],
                18: ["ঘ"],
                19: ["ঙ"],
                20: ["চ"]
            };
            return units[id] || ['-'];
        }

        function  getProblem2(id) {
            var units = {
                15: ["<span class='square-border'>ক</span>"],
                16: ["<span class='square-border'>খ</span>"],
                17: ["<span class='square-border'>গ</span>"],
                18: ["<span class='square-border'>ঘ</span>"],
                19: ["<span class='square-border'>ঙ</span>"],
                20: ["<span class='square-border'>চ</span>"]
            };
            return units[id] || ['-'];
        }

        setDefaultTable();
        function setDefaultTable() {
            $(tableBody).html("");
            for (var i = 0; i < 20; i++) {
                $(tableBody).append('<tr>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                        <td></td>\
                                    </tr>');
            }
        }

    });

</script>
<section class="content-header">
    <h1 id="pageTitle">Adolescent <small>১১. কিশোর কিশোরীর স্বাস্থ্য সেবাদান ছক</small></h1>
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
                        <h3 class="tableTitle"><center>১১. কিশোর কিশোরীর স্বাস্থ্য সেবাদান ছক </center></h3>
                        <div class="reg-fwa-11 table-data">
                            <table>
                                <thead>
                                    <tr>
                                        <td class="center" style="width: 3%" rowspan="2">ক্রমিক<br> নং</td>
                                        <td class="center" style="width: 4%" rowspan="2">খানা/<br>দম্পতি নং</td>
                                        <td class="center" style="width: 15%" rowspan="2">নাম</td>
                                        <td class="center" rowspan="1" colspan="2">বয়স</td>
                                        <td class="center" rowspan="1" colspan="8">পরিদর্শনের তারিখ ও কাউন্সিলিং এর বিষয়সমূহের কোড নম্বর লিখুন </td>
                                        <td class="center" rowspan="2">মন্তব্য</td>
                                    </tr>
                                    <tr>
                                        <td class="center" style="width: 5%">ছেলে</td>
                                        <td class="center" style="width: 5%">মেয়ে</td>
                                        <td style="width: 8%"></td>
                                        <td style="width: 8%"></td>
                                        <td style="width: 8%"></td>
                                        <td style="width: 8%"></td>
                                        <td style="width: 8%"></td>
                                        <td style="width: 8%"></td>
                                        <td style="width: 8%"></td>
                                        <td style="width: 8%"></td>
                                    </tr>
                                    <tr>
                                        <td class="center">১</td>
                                        <td class="center">২</td>
                                        <td class="center">৩</td>
                                        <td class="center">৪</td>
                                        <td class="center">৫</td>
                                        <td class="center">৬</td>
                                        <td class="center">৭</td>
                                        <td class="center">৮</td>
                                        <td class="center">৯</td>
                                        <td class="center">১০</td>
                                        <td class="center">১১</td>
                                        <td class="center">১২</td>
                                        <td class="center">১৩</td>
                                        <td class="center">১৪</td>
                                    </tr>
                                </thead>
                                <!--                                <tdead>
                                                                    <tr>
                                                                        <td class="center" rowspan="2">ক্রমিক<br> নং</td>
                                                                        <td class="center" rowspan="2">খানা/<br>দম্পতি নং</td>
                                                                        <td class="center" rowspan="2">নাম</td>
                                                                        <td class="center" rowspan="1" colspan="2">বয়স</td>
                                                                        <td class="center" rowspan="1" colspan="8">পরিদর্শনের তারিখ ও কাউন্সিলিং এর বিষয়সমূহের কোড নম্বর লিখুন </td>
                                                                        <td class="center" rowspan="2">মন্তব্য</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="center">ছেলে</td>
                                                                        <td class="center">মেয়ে</td>
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
                                                                        <td class="center">১</td>
                                                                        <td class="center">২</td>
                                                                        <td class="center">৩</td>
                                                                        <td class="center">৪</td>
                                                                        <td class="center">৫</td>
                                                                        <td class="center">৬</td>
                                                                        <td class="center">৭</td>
                                                                        <td class="center">৮</td>
                                                                        <td class="center">৯</td>
                                                                        <td class="center">১০</td>
                                                                        <td class="center">১১</td>
                                                                        <td class="center">১২</td>
                                                                        <td class="center">১৩</td>
                                                                        <td class="center">১৪</td>
                                                                    </tr>
                                                                    
                                                                    
                                                                    
                                                                </tdead>-->


                                <tbody id="tbody">
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
                                    </tr>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="14">
                                            <table class="no-border">
                                                <tr>
                                                    <td>কাউন্সেলিং এর কোড সমূহঃ</td>
                                                    <td><span class="square-border">ক</span> বাল্যবিবাহ এবং কিশোরী মাতৃত্বের কুফল</td>
                                                    <td><span class="square-border">খ</span> কিশোরীকে আয়রণ ও ফলিক এসিড বড়ি খেতে বলা</td>
                                                    <td><span class="square-border">গ</span> কিশোর-কিশোরীদের পুষ্টিকর ও সুষম খাবার</td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td><span class="square-border">ঘ</span> কিশোর-কিশোরীকে বয়ঃসন্ধিকালিন পরিবর্তন বিষয়ে</td>
                                                    <td><span class="square-border">ঙ</span> কিশোরীদের মাসিককালিন পরিছন্নতা ও মাসিক সংক্রান্ত জটিলতা</td>
                                                    <td><span class="square-border">চ</span> কিশোর-কিশোরীর প্রজননতন্ত্রের সংক্রমণ ও যৌনবাহিত রোগ</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </tfoot>

                                <!--                                        <table style="font-size: 11px;" class="no-border">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td>কাউন্সেলিং এর কোড সমূহঃ</td>
                                                                                    <td><span class="square-border">ক</span> বাল্যবিবাহ এবং কিশোরী মাতৃত্বের কুফল</td>
                                                                                    <td><span class="square-border">খ</span> কিশোরীকে আয়রণ ও ফলিক এসিড বড়ি খেতে বলা</td>
                                                                                    <td><span class="square-border">গ</span> কিশোর-কিশোরীদের পুষ্টিকর ও সুষম খাবার</td>
                                                                                <tr>
                                                                                    <td></td>
                                                                                    <td><span class="square-border">ঘ</span> কিশোর-কিশোরীকে বয়ঃসন্ধিকালিন পরিবর্তন বিষয়ে</td>
                                                                                    <td><span class="square-border">ঙ</span> কিশোরীদের মাসিককালিন পরিছন্নতা ও মাসিক সংক্রান্ত জটিলতা</td>
                                                                                    <td><span class="square-border">চ</span> কিশোর-কিশোরীর প্রজননতন্ত্রের সংক্রমণ ও যৌনবাহিত রোগ</td>
                                                                                </tr>
                                                                            </thead>
                                                                        </table>-->

                            </table>
                            <br>

                            <!--                            <table style="font-size: 11px;page-break-after: always" class="no-border">
                                                                <tr>
                                                                    <td>কাউন্সেলিং এর কোড সমূহঃ</td>
                                                                    <td><span class="square-border">ক</span> বাল্যবিবাহ এবং কিশোরী মাতৃত্বের কুফল</td>
                                                                    <td><span class="square-border">খ</span> কিশোরীকে আয়রণ ও ফলিক এসিড বড়ি খেতে বলা</td>
                                                                    <td><span class="square-border">গ</span> কিশোর-কিশোরীদের পুষ্টিকর ও সুষম খাবার</td>
                                                                <tr>
                                                                    <td></td>
                                                                    <td><span class="square-border">ঘ</span> কিশোর-কিশোরীকে বয়ঃসন্ধিকালিন পরিবর্তন বিষয়ে</td>
                                                                    <td><span class="square-border">ঙ</span> কিশোরীদের মাসিককালিন পরিছন্নতা ও মাসিক সংক্রান্ত জটিলতা</td>
                                                                    <td><span class="square-border">চ</span> কিশোর-কিশোরীর প্রজননতন্ত্রের সংক্রমণ ও যৌনবাহিত রোগ</td>
                                                                </tr>
                                                        </table>-->
                        </div>
                    </div>
                </div>
            </div> 
        </div>
    </div>
</div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>