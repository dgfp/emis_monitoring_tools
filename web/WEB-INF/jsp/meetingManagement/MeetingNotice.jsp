<%-- 
    Document   : MeetingNotice
    Created on : Jul 28, 2020, 7:52:54 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<style>
    [class*="col"] {
        margin-bottom: 0px;
    }
    .box{
        margin-bottom: 15px!important;
    }
    h2 {
        margin-top: 5px;
        margin-bottom: 20px;
    }
    .box-header.with-border {
        border-bottom: 0px; 
    }
    .box-header {
        padding-bottom: 0px!important;
    }
    .box-body {
        font-family: SolaimanLipi;
        font-size: 18px;
    }
    .box-header>.fa, .box-header>.glyphicon, .box-header>.ion, .box-header .box-title {
        font-family: SolaimanLipi;
        font-size: 23px;
        font-weight: bold;
    }
    .box-title{
        font-family: SolaimanLipi;
        font-size: 35px;
        font-weight: bold;
    }
    .table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
        padding-right: 0px!important; 
    }
    #printContent{
        display: none;
    }
</style>
<section class="content-header">
    <h1 id="pageTitle">
        <span id="title">&nbsp;</span>
    </h1>
    <!--    <ol class="breadcrumb">
            <a class="btn btn-flat btn-default btn-sm" href="asset-management"><b>Print</b></a>
        </ol>-->
</section>

<section class="content">
    <!--    <ol class="breadcrumb">
            <a class="btn btn-flat btn-default btn-sm" href="asset-management"><b>Print</b></a>
        </ol>-->
    <div class="row" id="areaPanel">
        <!--            <button class="buttons-print btn btn-flat btn-default btn-xs pull-right" tabindex="0" aria-controls="age_of_tablet" type="button" style="font-weight: bold;"><span> <i class="fa fa-print" aria-hidden="true"></i> Print / PDF</span></button>-->

        <div class="col-md-4">
            <div class="box box-primary" id="profileBox">
                <div class="box-header with-border">
                    <!--${sessionScope.isTabAccess?'appFwa.appPrintReport();':'printContent()'}-->
                    <button class="buttons-print btn btn-flat btn-default btn-xs" type="button" style="font-weight: bold;" onclick="${sessionScope.isTabAccess?'appFwa.appPrintReport();':'printContent()'}"><span> <i class="fa fa-print" aria-hidden="true"></i> Print / PDF</span></button>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body box-profile">
                    <table class="table table-hover" id="data-table">
                        <tbody id="tableBody">
                            <tr>
                                <td><b>তারিখ: </b><span id="meetingMonth">${meetingInformation.meeting_date}</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>সময়: </b><span id="meetingTime">${meetingInformation.meeting_time}</span></td>
                            </tr>
                            <tr>
                                <td><b>স্থান: </b>${meetingInformation.meeting_place} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>সভার ধরন: </b>${meetingInformation.meeting_type}</td>
                            </tr>
                            <!--                            <tr>
                                                            <td><b>সভার ধরন: </b>${noticeMaster.meeting_type}</td>
                                                        </tr>-->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="box box-primary" id="profileBox">
                <div class="box-header with-border">
                    <h3 class="box-title">অংশহণকারী</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <!--                <div class="box-header with-border">
                                    <h3 class="box-title bold">আমন্ত্রিত </h3>
                                </div>-->
                <div class="box-body box-profile">
                    <table class="table table-hover" id="data-table">
                        <tbody id="tableBody">
                                <tr>
                                    <td>
                            <c:forEach var="participant" items="${meetingInformation.meeting_participants}" varStatus="count">
                                <p class="participants"><b>${count.count}. ${participant}</b></p>
                                </c:forEach>
                                    </td>
                                <tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="box box-primary" id="profileBox">

                <div class="box-header with-border">
                    <h3 class="box-title">অনুলিপি</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body box-profile">
                    <table class="table table-hover" id="data-table" >
                        <tbody id="tableBody">
                            <tr>
                                    <td>
                            <c:forEach var="participant" items="${meetingInformation.meeting_recipients}" varStatus="count">
                                <p class="participants">${count.count}. ${participant}</p>
                            </c:forEach>
                            </td>
                                <tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="box box-primary" id="profileBox">
        <div class="box-header with-border">
            <h3 class="box-title">সভার আলোচ্য বিষয়সমূহ</h3>
            <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
            </div>
        </div>
        <div class="box-body">
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <!--                    <h2 class="box-title bold center" style="margin-top: -25px"><span class="label label-default">সভার আলোচ্য বিষয়সমূহ</span></h2>-->
                    <table class="table table-striped table-hover" id="data-table">
                        <tbody id="tableBody">
                            <tr>আলোচ্য সূচি:</tr>
                            <c:forEach items="${noticeMasterDetails}" var="item" varStatus="loop">
                                <tr>
                                    <td id="${loop.index}_serial" style=""> ${loop.index+1}. ${item}</td>
                                </tr> 
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>


            <div class="row" id="printContent">
                <div class="col-md-10 col-md-offset-1">
                    <div class="table-responsive" >
                        <table id="print-content"  style="text-align: left; width: 100%;">
                            <!--                            <thead>
                                                            <tr>
                                                                <th style="text-align:center;" colspan="2">
                                                                    <h5 class="bold">গণপ্রজাতন্ত্রী বাংলাদেশ সরকার</h5>
                                                                    <h5 class="bold">পরিবার পরিকল্পনা অধিদপ্তর</h5>
                                                                </th>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4">
                                                                    বিজ্ঞপ্তি নংঃ<span class='notice-no' style="margin-right: 50%;"> ${noticeMaster.meeting_type}</span> তারিখঃ <span class='meeting-circulate-date'> ${noticeMaster.meeting_circulate_date}</span>   
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <th colspan="2">
                                                                    <br/><h5 class="bold center" style="margin-bottom: 3%;">পাক্ষিক সভার বিজ্ঞপ্তি</h5>
                                                                </th>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4">
                                                                    জেলাঃ <span id='zilla' style="margin-right: 17%;"> ${catchment.zillaname}</span> 
                                                                    উপজেলাঃ <span id='upazila' style="margin-right: 17%;"> ${catchment.upazilaname}</span> 
                                                                    ইউনিয়নঃ <span id='union'> ${catchment.unionname}</span>   
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4">
                                                                    <br/>সভার তারিখঃ <span class="meeting-date" style="margin-right: 11%;"> ${noticeMaster.meeting_date}</span> 
                                                                    সময়ঃ <span class='meeting-time'> ${noticeMaster.meeting_time}</span> টা
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4">
                                                                    <br/>সভার স্থান: ইউনিয়ন স্বাস্থ্য ও পরিবার কল্যাণ কেন্দ্র, <span id='upazila'> ${catchment.unionname} ইউনিয়ন</span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <th colspan="2">
                                                                    <br/><h5 class="bold">সভার আলোচ্য বিষয়সমূহ</h5>
                                                                </th>
                                                            </tr>
                                                        </thead>-->
                            <%@include file="/WEB-INF/jsp/meetingManagement/PDFHeader.jspf" %>
                            <tr>
                                <th colspan="2">
                                    <br/><h5 class="bold">সভার আলোচ্য বিষয়সমূহ</h5>
                                </th>
                            </tr>
                            <tbody>
                                <c:forEach items="${noticeMasterDetails}" var="item" varStatus="loop">
                                    <tr>
                                        <td id="${loop.index}_serial_print" style="">আলোচ্য সূচি ${loop.index+1}: ${item}</td>
                                    </tr> 
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>
</section>
<script>
    $(function () {
        $('table#data-table > tbody  > tr').each(function (index, tr) {
            $("#" + index + "_serial").text(e2b($("#" + index + "_serial").text()));
        });
        $('table#print-content > tbody > tr').each(function (index, tr) {
            $("#" + index + "_serial_print").text(e2b($("#" + index + "_serial_print").text()));
        });
        $("#meetingMonth, .meeting-date").text(e2b($.app.date($("#meetingMonth").text()).date));
        $(".meeting-circulate-date").text(e2b($.app.date($(".meeting-circulate-date").text()).date));
        $("#meetingTime, .meeting-time").text(e2b($("#meetingTime").text()));
        $('.participants').each(function(i, v){
            $(this).text(e2b($(this).text()));
        });
    });
</script>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>