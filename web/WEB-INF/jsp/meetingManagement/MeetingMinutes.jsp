<%-- 
    Document   : MeetingMinutes
    Created on : Sep 8, 2020, 6:01:43 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    .thirt-box{
        display: none;
    }
    .decision-title{
        font-family: SolaimanLipi;
        font-size: 19px;
    }
    #printContent{
        display: none;
    }
</style>
<section class="content-header">
    <h1 id="pageTitle">
        <span id="title">&nbsp;</span>
    </h1>
</section>

<section class="content">
    <div class="row" id="areaPanel">
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
                                <td><b>তারিখ: </b><span id="meetingMonth">${noticeMaster.meeting_date}</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>সময়: </b><span id="meetingTime">${noticeMaster.meeting_time}</span></td>
                            </tr>
                            <tr>
                                <td><b>স্থান: </b>${noticeMaster.place} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br/><b>সভার ধরন: </b>${noticeMaster.meeting_type}</td>
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
                    <h3 class="box-title">অংশগ্রহণকারীদের তালিকা</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body box-profile">
                    <table class="table table-hover" id="data-table">
                        <tbody id="tableBody">
                            <tr>
                                <td>
                            <c:forEach items="${participants}" var="item" varStatus="loop">
                                <p><span id="${loop.index}_serial">${loop.index+1}.</span> ${item}</p>                                
                            </c:forEach>
                                    </td>
                            </tr> 

                            <!--                            <tr>
                                                            <td><b>১। &nbsp;${noticeMaster.ucmo}</b></td>
                                                        </tr>              
                                                        <tr>
                                                            <td><b>২। &nbsp;${noticeMaster.fwv}</b></td>
                                                        </tr>
                                                        <tr>
                                                            <td><b>৩। &nbsp;${noticeMaster.pharmacist}</b></td>
                                                        </tr>
                                                        <tr>
                                                            <td><b>৪। &nbsp;${noticeMaster.fwa}</b></td>
                                                        </tr>-->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="col-md-4 thirt-box">
            <div class="box box-primary" id="profileBox">
                <div class="box-header with-border">
                    <h3 class="box-title bold">অনুলিপি</h3>
                </div>
                <div class="box-body box-profile">
                    <table class="table table-hover" id="data-table" >
                        <tbody id="tableBody">
                            <tr>
                                <td><b>১। &nbsp;${noticeMaster.cc_ufpo}</b></td>
                            </tr>              
                            <tr>
                                <td><b>২। &nbsp;${noticeMaster.cc_uch}</b></td>
                            </tr>
                            <!--                            <tr>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                        </tr>-->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="box box-primary full-screen" id="tableView">
        <div class="box-header with-border">
            <h3 class="box-title">&nbsp;</h3>
            <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
            </div>
        </div>
        <div class="box-body">
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <h2 class="box-title bold center" style="margin-top: -25px"><span class="label label-default">সিদ্ধান্ত সমূহ</span></h2>
                    
                    <h5 class="bold decision-title">আলোচ্য সূচি</h5>
                    <c:forEach items="${decisions}" var="decision" varStatus="loop">
                        <h5 class="bold decision-title"  style="text-decoration: underline">${loop.index+1}: ${decision.item}</h5>
                        <div class="" style="text-align: justify;text-justify: inter-word;">
                            <c:forEach items="${decision.decisionText}" var="text" varStatus="loop_">
                                ${text} 
                            </c:forEach>
                        </div>
                        <br/>
                    </c:forEach>
                </div>
            </div>




            <div class="row" id="printContent">
                <div class="col-md-10 col-md-offset-1">
                    <div class="table-responsive" >
                        <table id="print-content"  style="text-align: left; width: 100%;">
                            <%@include file="/WEB-INF/jsp/meetingManagement/PDFHeader.jspf" %>
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
                                                                    <br/><h5 class="bold center">সিদ্ধান্ত সমূহ</h5>
                                                                </th>
                                                            </tr>
                                                        </thead>-->
                            <!--                            <tbody>
                            <c:forEach items="${decisions}" var="decision" varStatus="loop">
                                <tr>
                            <h5 class="bold decision-title"  style="text-decoration: underline">${decision.item}</h5>
                            <div class="" style="text-align: justify;text-justify: inter-word;">
                                <c:forEach items="${decision.decisionText}" var="text" varStatus="loop">
                                    ${text} 
                                </c:forEach>
                            </div>
                            </tr>
                            </c:forEach>
                            </tbody>-->
                            <tr>
                                <th colspan="2">
                                    <br/><h5 class="bold center">সিদ্ধান্ত সমূহ</h5>
                                </th>
                            </tr>
                        </table>
                    </div>


                    <c:forEach items="${decisions}" var="decision" varStatus="loop">
                        <h6 class="bold decision-title"  style="text-decoration: underline">আলোচ্য সূচি ${loop.index+1}: ${decision.item}</h6>
                        <div class="" style="text-align: justify;text-justify: inter-word; margin-bottom: 3%">
                            <c:forEach items="${decision.decisionText}" var="text" varStatus="loop_">
                                ${text} 
                            </c:forEach>
                        </div>
                    </c:forEach>




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
            $("#decisions_" + index + "_serial").text(e2b($("#decisions_" + index + "_serial").text()));
        });
        $('table#print-content > tbody > tr').each(function (index, tr) {
            $("#" + index + "_serial_print").text(e2b($("#" + index + "_serial_print").text()));
        });
        $("#meetingMonth, .meeting-date").text(e2b($.app.date($("#meetingMonth").text()).date));
        $(".meeting-circulate-date").text(e2b($.app.date($(".meeting-circulate-date").text()).date));
        $("#meetingTime, .meeting-time").text(e2b($("#meetingTime").text()));
        //meeting-circulate-date
        
    });
</script>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>