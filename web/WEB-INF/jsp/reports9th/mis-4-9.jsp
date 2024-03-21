<%-- 
    Document   : mis-4-9
    Created on : May 1, 2019, 12:13:50 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_mis4_bangla.js"></script>
<script src="resources/js/TemplateMIS.js" type="text/javascript"></script>
<script src="resources/js/$.mis4.js"></script>
<link href="resources/css/newStyle.css" rel="stylesheet" type="text/css"/>
<style>
    .callout.callout-success, .callout.callout-danger, .callout.callout-warning {
        border:none!important;
    }
    .callout {
        border-radius: 50px!important;
    }
    #submitDataButton{
        display: none;
    }
    .rotate {
        filter:  progid:DXImageTransform.Microsoft.BasicImage(rotation=0.083);  /* IE6,IE7 */
        -ms-filter: "progid:DXImageTransform.Microsoft.BasicImage(rotation=0.083)"; /* IE8 */
        -moz-transform: rotate(-90.0deg);  /* FF3.5+ */
        -ms-transform: rotate(-90.0deg);  /* IE9+ */
        -o-transform: rotate(-90.0deg);  /* Opera 10.5 */
        -webkit-transform: rotate(-90.0deg);  /* Safari 3.1+, Chrome */
        transform: rotate(-90.0deg);  /* Standard */
    }
    #slogan{
        border: 1px solid #000000;
        text-align: center;
        padding: 2px;
        margin-top: 45px;
        word-wrap: break-word;
    }
    #page{
        margin-top: -55px;
    }
    #logo{
        margin-top: 10px;
        margin-left: 5px;
        width:50px;
        height:50px;
    }
    .center{
        text-align: center;
    }
    .left{
        text-align: left;
    }
    #unit{
        display: none;
    }
    .mis_table th, .mis_table td{ 
        border: 1px solid #000;
        padding: 5px;
    }

    .tableTitle{
        font-family: SolaimanLipi;
        display: none;
    }
    table{
        font-family: SolaimanLipi;
        font-size: 13px;
    }
    #name{
        font-size: 11px;
    }
    table th, table td{
        padding: 3px!important;
        padding-left: 5px!important;
        text-align: center;
    }
    .submit{
        display: none;
    }
    .serial-color{
        background-color: #f4f5f7;
    }
    .not-submitted{
        background-color: #fff7f7;
    }
    .disabled-color{
        background-color: #a1afb7;
    }
    .r-v{
        text-align: center;
    }
    .color0{
        /*        background-color: red;*/
    }
    .color1{
        background-color: #ff3d3d;
    }
    .color2{
        background-color: #b20303;
    }
    .color3{
        /*        background-color: yellow;*/
    }
</style>
${sessionScope.designation=='UFPO'  || sessionScope.role=='Super admin'?
  "<input type='hidden' id='isSubmitAccess' value='99'>" : "<input type='hidden' id='isSubmitAccess' value='66'>"}
<section class="content-header">
    <h1 id="pageTitle">
        <span id="title">MIS 4 (Upazila)</span><small></small>
        <span id="submitStatus" class="pull-right"></span>
    </h1>
</section>
<!-- Main content -->
<section class="content">
    <div class="row" id="areaPanel">
        <div class="col-md-12">
            <div class="box box-primary">
                <input type="hidden" value="${userLevel}" id="userLevel">
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <label for="division">বিভাগ</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="division" id="division"> 
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-xs-2">
                            <label for="district">জেলা</label>
                        </div>
                        <div class="col-md-2 col-xs-4 border-success">
                            <select class="form-control input-sm" name="district" id="district"> 
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>
                        <span id="break1"></span>
                        <div class="col-md-1 col-xs-2">
                            <label for="upazila">উপজেলা</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="upazila" id="upazila">
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>
                        
                        <div class="col-md-1 col-xs-2">
                            <label for="year">বছর</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="year" id="year"> </select>
                        </div>
                    </div>

                    <div class="row secondRow">
                        <div class="col-md-1 col-xs-2">
                            <label for="month">মাস</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="month" id="month">
                                <option value="01">জানুয়ারি</option>
                                <option value="02">ফেব্রুয়ারি</option>
                                <option value="03">মার্চ</option>
                                <option value="04">এপ্রিল</option>
                                <option value="05">মে</option>
                                <option value="06">জুন</option>
                                <option value="07">জুলাই</option>
                                <option value="08">আগষ্ট</option>
                                <option value="09">সেপ্টেম্বর</option>
                                <option value="10">অক্টোবর</option>
                                <option value="11">নভেম্বর</option>
                                <option value="12">ডিসেম্বর</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-xs-2">
                            &nbsp;
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off">
                                <b><i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; রিপোর্ট দেখুন</b>
                            </button>
                        </div>
                        <div class="col-md-1 col-xs-2">
                        </div>
                        <div class="col-md-2 col-xs-4 submitButton">
                            <button type="button" id="submitDataButton" class="btn btn-flat btn-primary btn-block btn-sm">
                                <b><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp; রিপোর্ট জমা দিন</b>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="viewStatus">
    </div>
    <!--------------------------------------------------------------------------------MIS 2 Table Goes Here-------------------------------------------------------------------------------->  
    <div class="box box-primary full-screen">
        <c:if test="${sessionScope.designation=='UFPO'}">
            <div class="box-header with-border" style="padding: 0px;">
                <p class="box-title" style="font-size: 14px;padding: 2px;">
                    Status for combined data (MIS2+3) -
                    <span class="color2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> MIS-2 missing&nbsp;
                    <span class="color1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> MIS-3 missing&nbsp;
                </p>
            </c:if>
            <c:if test="${sessionScope.designation!='UFPO'}">
                <div class="box-header with-border">
                </c:if>
                <div class="box-tools pull-right" style="margin-top: -10px;">
                    <button type="button" class="btn btn-flat btn-default btn-xs bold" id="printTableBtn"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                    <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                </div>
            </div>
            <div class="box-body mis-template" id="data-table">
                <%@include file="/WEB-INF/jspf/mis4-9-template-view.jspf" %>
            </div>
        </div>
</section>

<div id="modal-report-response" class="modal modal-center fade" role="dialog">
    <div class="modal-dialog modal-dialog-center modal-lg report-response">
        <div class="modal-content">
            <div class="modal-header label-warning">
                <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                <h4 class="modal-title"><b><i class="fa fa-edit" aria-hidden="true"></i>&nbsp; <span id="responseViewTitle"></span></b></h4>
            </div>
            <div class="modal-body" >
                <div class="box box-chat box-default  direct-chat direct-chat-warning">
                    <div class="box-body">
                        <div class="direct-chat-messages">
                            <div class="direct-chat-msg">
                                <div class="direct-chat-info clearfix">
                                    <span class="direct-chat-name pull-left">Helal Khan</span>
                                    <span class="direct-chat-timestamp pull-right">23 Jan 2:00 pm</span>
                                </div>
                                <img class="direct-chat-img" src="https://metaclinician.com/assets/avatar_Dummy.png" alt="message user image">
                                <div class="direct-chat-text">
                                    এম আই এস রিপোর্ট টি জমা দেয়া হলো 
                                </div>
                            </div>
                            <div class="direct-chat-msg right">
                                <div class="direct-chat-info clearfix">
                                    <span class="direct-chat-name pull-right">Shamsul Haque</span>
                                    <span class="direct-chat-timestamp pull-left">23 Jan 2:05 pm</span>
                                </div>
                                <img class="direct-chat-img" src="https://metaclinician.com/assets/avatar_Dummy.png" alt="message user image">
                                <div class="direct-chat-text">
                                    আপনার রিপোর্ট কি অনুমোদন করা হলো
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box-footer">
                        <form action="mis1-approval-manager-v9?action=actionOnResponse" method="post" id="form-report-response" class="overlay-relative">
                            <p class="center"><span class="bold">এমআইএস ৪ </span> - এর অসরকারি সংস্থার মোট এবং বহুমূখী সংস্থার মোট নিচের ছকে লিখুন</p>

                            <c:import url="/WEB-INF/jspf/mis4-9-template-view-submit.jspf" charEncoding="UTF-8"/>

                            <div class="overlay hidden"></div>
                            <div class="input-group">
                                <span class="input-group-btn input-group-return">
                                    <button type="submit" class="btn btn-warning btn-flat" data-status="2" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading"><b><i class="fa fa-reply-all" aria-hidden="true"></i> Return</b></button>
                                </span>
                                <input type="text" name="message" placeholder="" class="form-control">
                                <span class="input-group-btn input-group-approve">
                                    <button type="submit" class="btn btn-warning btn-flat"  data-status="1" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading"><b><i class="fa fa-check-square-o" aria-hidden="true"></i> Approve</b></button>
                                </span>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/jspf/modal-report-submit.jspf" %>
<%@include file="/WEB-INF/jspf/modal-report-view.jspf" %>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>