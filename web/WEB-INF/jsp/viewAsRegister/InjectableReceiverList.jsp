<%-- 
    Document   : InjectableReceiverList
    Created on : Mar 25, 2018, 6:57:50 AM
    Author     : Helal | m.helal.k@gmail.com
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

    /*    th, td {
            padding: 1px;
            padding-left: 5px;
        }*/
    #name{
        font-size: 11px;
    }

    @media print {
        .tableTitle{
            display: block;
            
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
                        url: "InjectableReceiverList",
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

                                var doseDate = json[i].dose_given_dt.split(",");
                                var intervalDays = 90;
                                var doseGivenDate = "";
                                var doseDueDate = "<td>" + convertE2B($.app.date(new Date(json[i].first_dosedate).addDays(intervalDays)).date) + "</td>";

                                for (var m = 0; m < doseDate.length; m++) {
                                    doseGivenDate += "<td>" + convertE2B(convertDateFrontFormat(doseDate[m])) + "</td>";
                                    if(doseDate.length > 0 && doseDate[m]!=''){
                                        doseDueDate += "<td>" + convertE2B($.app.date(new Date(doseDate[m]).addDays(intervalDays)).date) + "</td>";
                                    }else{
                                        doseDueDate   += '<td>-</td>';
                                    }
                                    //intervalDays += 90;
                                }
                                console.log(json[i].receiver_name,doseDate);
                                
                                for (var n = 1; n <= 11-doseDate.length; n++) {
                                    doseGivenDate += '<td>-</td>';
                                    doseDueDate   += '<td>-</td>';
                                    //n==0 && doseDate.length>1? doseDueDate += "" : doseDueDate += "<td>-</td>";
                                    //n==0 && doseDate.length>1? doseDueDate += "<td>" + convertE2B($.app.date(new Date(json[i].first_dosedate).addDays(intervalDays)).date) + "</td>" : doseDueDate += "<td>-</td>";
                                    //doseDueDate += '<td>0</td>';
                                    //console.log("n",n);
                                }
                                
                                $(tableBody).append('<tr>'
                                        + '<td rowspan="2" class="center">' + convertE2B((i + 1)) + '</td>'
                                        + '<td rowspan="2" class="center">' + convertE2B(json[i].elco_no) + '</td>'
                                        + '<td rowspan="2"><span id="name">' + json[i].receiver_name + '</span> <br> ' + json[i].villagename + '</td>'
                                        + '<td rowspan="2" class="center">' + convertE2B(convertDateFrontFormat(json[i].first_dosedate)) + '</td>'
                                        + '<td>ডিউ ডোজ</td>' + doseDueDate
//                                        + '<td></td>'
//                                        + '<td></td>'
//                                        + '<td></td>'
//                                        + '<td></td>'
//                                        + '<td></td>'
//                                        + '<td></td>'
//                                        + '<td></td>'
//                                        + '<td></td>'
//                                        + '<td></td>'
//                                        + '<td></td>'
//                                        + '<td></td>'
//                                        + '<td></td>'
                                        + '<td rowspan="2" class="center">' + json[i].sideeffect + '</td>'
                                        + '</tr>'
                                        + '<tr>'
                                        + '<td>প্রয়োগের তারিখ</td>' + doseGivenDate
//                                        +'<td></td>'
//                                        +'<td></td>'
//                                        +'<td></td>'
//                                        +'<td></td>'
//                                        +'<td></td>'
//                                        +'<td></td>'
//                                        +'<td></td>'
//                                        +'<td></td>'
//                                        +'<td></td>'
//                                        +'<td></td>'
//                                        +'<td></td>'
//                                        +'<td></td>'
                                        + '<td</tr>');
                            }

                            if (json.length < 18) {
                                for (var i = 0; i < 18 - json.length; i++) {
                                    $(tableBody).append('<tr>'
                                            + '<td rowspan="2"></td>'
                                            + '<td rowspan="2"></td>'
                                            + '<td rowspan="2"></td>'
                                            + '<td rowspan="2"></td>'
                                            + '<td  style="width: 5%!important">ডিউ ডোজ</td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td rowspan="2"></td>'
                                            + '</tr>'
                                            + '<tr>'
                                            + '<td  style="width: 5%!important">প্রয়োগের তারিখ</td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
                                            + '<td  style="width: 5%"></td>'
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
            for (var i = 0; i < 18; i++) {
                $(tableBody).append('<tr>\
                                        <td rowspan="2"></td>\
                                        <td rowspan="2"></td>\
                                        <td rowspan="2"></td>\
                                        <td rowspan="2"></td>\
                                        <td style="width: 5%">ডিউ ডোজ</td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td rowspan="2"></td>\
                                    </tr>\
                                    <tr>\
                                        <td style="width: 8%">প্রয়োগের তারিখ</td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                        <td style="width: 5%"></td>\
                                    </tr>');
            }
        }
    });

</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle">Injectable acceptor <small>১৫. ইনজেকটবল গ্রহণকারীর তালিকা ছক</small></h1>
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
                        <h3 class="tableTitle"><center>১৫. ইনজেকটবল গ্রহণকারীর তালিকা ছক</center></h3>
                        <div class="reg-fwa-15 table-data">
                            <table>
                                <thead>
                                    <tr>
                                        <td class="center" style="width: 3%" rowspan="2">ক্রমিক নং</td>
                                        <td class="center" style="width: 4%" rowspan="2">দম্পতি নং</td>
                                        <td class="center" style="width: 15%" rowspan="2">গ্রহণকারীর নাম ও গ্রামের নাম</td> 
                                        <td class="center" style="width: 6%" rowspan="2">প্রথম ডোজের <br>তারিখ</td>
                                        <td class="center" rowspan="2" colspan="13">ইনজেকটবল প্রদানের তারিখ</td>
                                        <td rowspan="2">পাৰ্শ্ব-প্রতিক্রিয়া</td>
                                    </tr>
                                </thead>
                                <tbody id="tbody">
                                    <!--                                    <tr>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td>ডিউ ডোজ</td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td rowspan="2"></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>প্রয়োগের তারিখ</td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
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
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td rowspan="2"></td>
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
                                                                        </tr><tr>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td rowspan="2"></td>
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
                                                                        </tr><tr>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td rowspan="2"></td>
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
                                                                        </tr><tr>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td rowspan="2"></td>
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
                                                                        </tr><tr>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td rowspan="2"></td>
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
                                                                        </tr><tr>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td rowspan="2"></td>
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
                                                                        </tr><tr>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td rowspan="2"></td>
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
                                                                        </tr><tr>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td rowspan="2"></td>
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
                                                                        </tr><tr>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td rowspan="2"></td>
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
                                                                        </tr><tr>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td rowspan="2"></td>
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
                                                                        </tr><tr>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td rowspan="2"></td>
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
                                                                        </tr><tr>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td rowspan="2"></td>
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
                                                                        </tr><tr>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td rowspan="2"></td>
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
                                                                        </tr><tr>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td rowspan="2"></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td></td>
                                                                            <td rowspan="2"></td>
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
                        </div>
                    </div>
                </div>
            </div> 
        </div>
    </div>
</div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>