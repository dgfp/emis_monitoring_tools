<%-- 
    Document   : BelowZeroToFiveYearsChildServing
    Created on : Mar 25, 2018, 6:31:19 AM
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
            margin-top: 0px;

        }
        table{
            font-family: SolaimanLipi;
            font-size: 12px;
            margin-top: -11px;
        }
        th, td {
            padding: 1px;
            padding-left: 5px;
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
</style>
<script>
    $(document).ready(function () {
        var tableBody = $("#tbody");
        var regExp = /(\d{1,2})\/(\d{1,2})\/(\d{2,4})/; //for date compare
        function formatAge(age) {
            age.match(/\w/)
        }

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
                        url: "BelowZeroToFiveYearsChildServing",
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
                                setDefaultTable();
                                toastr["error"]("<h4><b>কোন ডাটা পাওয়া যায়নি</b></h4>");
                                return;
                            }
                            for (var i = 0; i < json.length; i++) {
                                var male = "", female = "";
                                json[i].sex == 1 ? male = json[i].calculated_age + " মাস" : female = json[i].calculated_age + " মাস"

                                $(tableBody).append('<tr>'
                                        + '<td class="center">' + convertE2B((i + 1)) + '</td>'
                                        + '<td class="center">' + convertE2B(convertDateFrontFormat(json[i].visitdate)) + '</td>'
                                        + '<td class="center">' + convertE2B(json[i].hhno) + '</td>'
                                        + '<td><span id="name">' + json[i].child_name + '</td>'
                                        + '<td>' + convertE2B(male) + '</td>'
                                        + '<td>' + convertE2B(female) + '</td>'
                                        + '<td>' + json[i].problems + '</td>'
                                        + '<td>' + json[i].advices + '</td>'
                                        + '<td>' + json[i].remarks + '</td>'
                                        + '<td</tr>');
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
                                            + '</tr>');
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
                                    </tr>');
            }
        }

    });

</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle">Under-five children <small>১০. শিশু (০-৫ বৎসরের নিচে) সেবাদান ছক</small></h1>
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
                        <h3 class="tableTitle"><center>১০. শিশু (০-৫ বৎসরের নিচে) সেবাদান ছক</center></h3>
                        <div class="reg-fwa-10 table-data">
                            <table>
                                <thead >
                                    <tr>
                                        <td class="center" rowspan="2" style="width: 3%"    >ক্রমিক<br>নং</td>
                                        <td class="center" rowspan="2" style="width: 5%">পরিদর্শনের<br>তারিখ</td>
                                        <td class="center" rowspan="2" style="width: 4%">খানা/<br>দম্পতি নং</td>
                                        <td class="center" rowspan="2">শিশুর নাম</td>
                                        <td class="center" rowspan="1" colspan="2">বয়স</td>
                                        <td class="center" rowspan="2" style="width: 25%">অসুবিধা</td>
                                        <td class="center" rowspan="2" style="width: 25%">উপদেশ/ব্যবস্থা</td>
                                        <td class="center" rowspan="2">মন্তব্য</td>
                                    </tr>
                                    <tr>
                                        <td class="center" style="width: 4%">ছেলে</td>
                                        <td class="center" style="width: 4%">মেয়ে</td>
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