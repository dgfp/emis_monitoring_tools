<%-- 
    Document   : PublicRepresentativeSupervisionList
    Created on : Mar 25, 2018, 7:03:03 AM
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
    #name{
        font-size: 11px;
    }

    @media print {
        .tableTitle{
            display: block;
            margin-top: -11px;
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
      table td{ 
          text-align: center;
  }
</style>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle"><small>২১. জনপ্রতিনিধি/ কর্মকর্তাদের তদারকি ছক</small></h1>
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
                        <h2 class="tableTitle"><center>জনপ্রতিনিধি/ কর্মকর্তাদের তদারকি ছক</center></h2>
                        <div class="reg-fwa-21 table-data">
                            <table>
                                <thead>
                                    <tr>
                                        <td rowspan="2">পরিদর্শনের তারিখ</td>
                                        <td rowspan="2">পরিদর্শিত গ্রামের নাম</td>
                                        <td rowspan="2">কর্মী অগ্রীম কর্মসূচীর কোন পর্যায়ে (সঠিক/ আগে/ পিছনে)</td>
                                        <td rowspan="1" colspan="6">রেজিস্টারের নিম্নোক্ত ছক সমূহ সঠিকভাবে পূরণ করা হচ্ছে কি? (হ্যাঁ/না)</td>
                                        <td rowspan="2">পরিদর্শিত দম্পতির নম্বর</td>
                                        <td rowspan="1" colspan="2">দম্পতির উপাত্ত যাচাই (পদ্ধতি গ্রহণকারী/ ব্যবহারকারী) </td>
                                        <td rowspan="2">পরামর্শ (পদবীসহ স্বাক্ষর)</td>
                                    </tr>
                                    <tr>
                                        <td>দম্পতি ছক</td>
                                        <td>গর্ভবতী ও নবজাতকের তালিকা ছক</td>
                                        <td>মৃত্যু তালিকা ছক</td>
                                        <td>দৈনিক কার্যাবলীর হিসাব ছক</td>
                                        <td>ইনজেকটবল গ্রহণকারীর তালিকা ছক</td>
                                        <td>কিশোর-কিশোরী স্বাস্থ সেবাদান ছক</td>
                                        <td>সঠিক<br>(সংখ্যা)</td>
                                        <td>সঠিক নয়<br>(সংখ্যা)</td>
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
                                    </tr>
                                </thead>
                                <tbody>
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