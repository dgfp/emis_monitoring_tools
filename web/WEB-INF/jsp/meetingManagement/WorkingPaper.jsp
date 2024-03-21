<%-- 
    Document   : WorkingPaper
    Created on : Aug 12, 2020, 4:38:03 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/$.misv9.js"></script>
<script src="resources/js/TemplateMIS.js" type="text/javascript"></script>
<script src="resources/js/RenderMIS2_MeetingModule.js" type="text/javascript"></script>

<style>
    .center{
        text-align: center;
    }
    [class*="col"] {
        margin-bottom: 0px;
    }
    .box-body {
        font-family: SolaimanLipi;
        font-size: 16px;
    }
    .report-title {
        font-family: SolaimanLipi;
        font-size: 25px;
        font-weight: bold;
        text-align: center;
    }
    .sub-report-title{
        font-weight: bold;
    }
    /*    .table-responsive { 
            overflow-y: hidden;
            overflow-x: hidden; 
        }*/
    .table-bordered {
        border: 1px solid #000!important;
    }
    .table-bordered thead{
        background: #45e994;
    }
    table.table-bordered{
        padding: 0 !important;
        padding-left: 0 !important;
    }
    .table-bordered>thead>tr>th, .table-bordered>tbody>tr>th, .table-bordered>tfoot>tr>th, .table-bordered>thead>tr>td, .table-bordered>tbody>tr>td, .table-bordered>tfoot>tr>td  {
        border-color: #000!important;
        border-left-color: #000!important;
        border-right-color: #000!important;
        border-bottom-color: #000!important;
        text-align: left;
    }
    table.table-bordered thead th, table.table-bordered thead td {
        border-left-width: 0px;
    }
    .pdf-header{
        display: none;
    }
    .div-span{
        border-bottom: 1px solid #000;
        text-align: center;
    }
    .rm-padd{
        padding-left: 0 !important;
        padding-right: 0 !important;
    }
</style>
<section class="content-header">
    <h1 id="pageTitle">
        <span id="title">Working Paper</span>
    </h1>
</section>

<section class="content" id="areaPanel">
    <div class="box box-primary full-screen" id="tableView">
        <div class="box-header with-border">
            <button class="buttons-print btn btn-flat btn-default btn-xs" type="button" style="font-weight: bold;" onclick="${sessionScope.isTabAccess?'appFwa.appPrintReport();':'printContent()'}"><span> <i class="fa fa-print" aria-hidden="true"></i> Print / PDF</span></button>
        </div>

        <div class="box-body" id="printContent">

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="21">
                    <h4 class="report-title"></h4>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="31">
                    <h4 class="report-title"></h4>
                    <h5 class="sub-report-title">এমআইএস-১ রিপোর্ট</h5>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>

                <div class="col-md-10 col-md-offset-1" id="32">
                    <!--                    <h4 class="report-title"></h4>-->
                    <h5 class="sub-report-title">এমআইএস-২ রিপোর্ট</h5>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>

                <div class="col-md-10 col-md-offset-1" id="33">
                    <!--                    <h4 class="report-title"></h4>-->
                    <h5 class="sub-report-title">এমআইএস-৩ রিপোর্ট</h5>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="41">
                    <h4 class="report-title"></h4>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="51">
                    <h4 class="report-title"></h4>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="61">
                    <h4 class="report-title"></h4>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="71">
                    <h4 class="report-title"></h4>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="81">
                    <h4 class="report-title"></h4>
                    <h5 class="sub-report-title">গর্ভবতী মা নিবন্ধনের পরিস্থিতি </h5>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="82">
                    <h5 class="sub-report-title">গর্ভকালীন সেবা প্রদান</h5>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <!--                            <tbody id="tableBody">
                                                        <td rowspan="4"></td>
                                                        <td rowspan="4"></td>
                                                        <td rowspan="4"></td>
                                                        <td rowspan="4"></td>
                                                        <td rowspan="4"></td>
                                                        <td>
                                                        <tr>1</tr>
                                                        <tr>1</tr>
                                                        <tr>1</tr>
                                                        <tr>1</tr>
                                                        </td>
                                                        <td rowspan="4"></td>
                                                        </tbody>-->
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="83">
                    <h5 class="sub-report-title">প্রসবোত্তর সেবা</h5>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="84">
                    <h5 class="sub-report-title">নবজাতকের সেবা</h5>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="85">
                    <h5 class="sub-report-title">আয়রন, ফলিক এসিড বড়ি এবং ৭.১% ক্লোরোহেক্সাডিন প্রদানের পরিস্থিতি</h5>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="86">
                    <h5 class="sub-report-title">গর্ভবতী মায়েদের প্রাতিষ্ঠানিক ডেলিভারি ও রেফারেল পরিস্থিতি</h5>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="87">
                    <h5 class="sub-report-title">পুষ্টি সংক্রান্ত কাউন্সিলিং</h5>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="91">
                    <h4 class="report-title"></h4>
                    <h5 class="sub-report-title">স্যাটেলাইট ক্লিনিকের স্থান</h5>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="92">
                    <!--                    <h4 class="report-title"></h4>-->
                    <h5 class="sub-report-title">স্যাটেলাইট ক্লিনিকে উপস্থিতি</h5>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="101">
                    <h4 class="report-title"></h4>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="111">
                    <h4 class="report-title"></h4>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="121">
                    <h4 class="report-title"></h4>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="131">
                    <h4 class="report-title"></h4>
                    <h5 class="sub-report-title">জনসংখ্যা ও দম্পতি নিবন্ধন </h5>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="132">
                    <!--                    <h4 class="report-title"></h4>-->
                    <h5 class="sub-report-title">দম্পতি পরিদর্শনের  তথ্য </h5>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="141">
                    <h4 class="report-title"></h4>
                    <div class="table-responsive fixed" id="export">
                        <table class="table table-bordered" id="data-table">
                            <thead id="tableHeader">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>


        </div>
    </div>
</div>
</section>
<script>
    $(function () {
        function generateDivSpan(selector, number, data) {
            for (var i = 0; i <= number; i++) {
                var d = data ? data[i] : ((i + 1) + "টি");
                if (i == number) {
                    selector.append("<div class='text-center'>" + e2b(d) + "</div>");
                } else {
                    selector.append("<div class='div-span'>" + e2b(d) + "</div>");
                }
            }
            selector.attr('class', 'rm-padd');
        }
        $.wp = {
            title: "Working Paper",
            baseURL: "working-paper",
            data: null,
            init: function () {
                $.wp.viewData();
                $.wp.events.bindEvent();
//                Template.init(1);
//                Template.init(2);
            },
            events: {
                bindEvent: function () {
                    $.wp.events.viewMIS1();
                    $.wp.events.viewMIS2();
                },
                viewMIS1: function () {
                    $(document).off('click', '.mis1-view').on('click', '.mis1-view', function (e) {
//                        $.wp.ajax.getMIS1($(this).data("info"), $(this).data("prov"));
//
//                        console.log(json);
//                        console.log(provider);
//                        Template.init(1);
                        var provider = $(this).data("prov");
                        var data = $(this).data("info");
                        console.log(provider, data);
                        $.ajax({
                            url: $.wp.baseURL + "?action=getMIS1",
                            type: "POST",
                            data: {misStatus: JSON.stringify(data)},
                            success: function (response) {
                                response = JSON.parse(response);
                                console.log(Template.context);
                                if (response.success == true) {
                                    $.wp.renderMIS1(response, provider);
                                    $("#provider-info").html("<b> MIS 1 (FWA) - Provider: " + provider.provname + " - ID: " + provider.providerid + "</b>");
                                    $.app.mis1PageColor(provider.assin_type);
                                    $('#mis1-modal-container #modalReportView').modal('show');
                                } else {
                                    toastr['error']("Error occured while user load");
                                }
                            }, error: function (xhr, status, error) {
                                console.log(xhr, status, error);
                                toastr['error'](error);
                            }
                        });
                    });
                },
                viewMIS2: function () {
                    $(document).off('click', '.mis2-view').on('click', '.mis2-view', function (e) {
//                        $.wp.ajax.getMIS1($(this).data("info"), $(this).data("prov"));
//
//                        console.log(json);
//                        console.log(provider);
//                        Template.init(2);
                        var provider = $(this).data("prov");
                        var data = $(this).data("info");
                        console.log(provider, data);
                        $.ajax({
                            url: $.wp.baseURL + "?action=getMIS2",
                            type: "POST",
                            data: {misStatus: JSON.stringify(data)},
                            success: function (response) {
                                response = JSON.parse(response);
//                                console.log(response["data"]);
                                if (response.success == true) {
                                    $.wp.renderMIS2(response["data"], provider);
//                                    $("#provider-info").html("<b> MIS 1 (FWA) - Provider: " + provider.provname + " - ID: " + provider.providerid + "</b>");
//                                    $.app.mis1PageColor(provider.assin_type);
                                    $('#mis2-modal-container #modal-report-view').modal('show');
                                } else {
                                    toastr['error']("Error occured while user load");
                                }
                            }, error: function (xhr, status, error) {
                                console.log(xhr, status, error);
                                toastr['error'](error);
                            }
                        });
                    });
                }
            },
            viewData: function () {
                $.ajax({
                    url: $.wp.baseURL + "?action=getWorkingPaper",
                    type: "POST",
                    success: function (response) {
                        response = JSON.parse(response);
                        console.log(response);
                        if (response.success == true) {
                            var data = response.data;
                            $.wp.data = response.data;
                            if (data.length === 0) {
                                //toast("error", "No data found");
                                toastr['error']("No data found");
                                return;
                            }
                            $.wp.renderTableData(data);
                        } else {
                            toastr['error']("Error occured while data loading");
                        }
                    }, error: function (error) {
                        toastr['error'](error);
                    }
                });
            },
            renderTableData: function (data) {

                $.each(data, function (i, o) {
                    console.log(i, o);
                    var id = parseInt(o.agenda_code + "" + o.report_no);
                    var block = $("#" + o.agenda_code + "" + o.report_no);
                    block.find('h4').text(o.itemdes);
                    block.find('table thead').append($.wp.getTableHeader(id, o.meeting_month, o.meeting_year));
                    //Render data table
//                    console.log(o.itemdes, JSON.parse(o.report_json).MIS, o.agenda_code);
                    block.find("#data-table").DataTable().clear();
                    block.find("#data-table").DataTable().destroy();
                    var option = {
                        searching: false,
                        paging: false,
                        ordering: false,
                        info: false,
                        data: JSON.parse(o.report_json).MIS,
                        columns: $.wp.column[id]
                    };

                    if (id == 82) {
                        option.createdRow = function (row, data, dataIndex) {
                            generateDivSpan($('td:eq(3)', row), 3, null);
                            generateDivSpan($('td:eq(4)', row), 3, {0: data['ancex1'], 1: data['ancex2'], 2: data['ancex3'], 3: data['ancex4']});
                            generateDivSpan($('td:eq(5)', row), 3, {0: data['ancrcv1_0'], 1: data['ancrcv2_0'], 2: data['ancrcv3_0'], 3: data['ancrcv4_0']});
                        };
                    } else if (id == 83) {
                        option.createdRow = function(row, data, dataIndex){
                            generateDivSpan($('td:eq(3)', row), 3, null);
                            generateDivSpan($('td:eq(4)', row), 3, {0: data['pncex1'], 1: data['pncex2'], 2: data['pncex3'], 3: data['pncex4']});
                            generateDivSpan($('td:eq(5)', row), 3, {0: data['pncrcv1_0'], 1: data['pncrcv2_0'], 2: data['pncrcv3_0'], 3: data['pncrcv4_0']});
                        };
                    } else if (id == 84) {
                        option.createdRow = function(row, data, dataIndex){
                            generateDivSpan($('td:eq(3)', row), 3, null);
                            generateDivSpan($('td:eq(4)', row), 3, {0: data['pncchildex1'], 1: data['pncchildex2'], 2: data['pncchildex3'], 3: data['pncchildex4']});
                            generateDivSpan($('td:eq(5)', row), 3, {0: data['pncchildrcv1_0'], 1: data['pncchildrcv2_0'], 2: data['pncchildrcv3_0'], 3: data['pncchildrcv4_0']});
                        };
                    }
                    block.find("#data-table").dt(option);
                    block.find("#data-table").DataTable().draw();
                    block.parent('.row').after("<br/>");
                });
            },
            getTableHeader: function (agendaCode, month, year) {
                console.table("getTableHeader", month, year);
                var currentDate = new Date(month + "/1/" + year);
                
                var previousDateCalc = new Date(month + "/1/" + year);
                var nextDateCalc = new Date(month + "/1/" + year);
                var dtPreviousMonthDate = new Date(previousDateCalc.setMonth(previousDateCalc.getMonth() - 1));
                var dtMonthBeforePreviousMonthDate = new Date(previousDateCalc.setMonth(previousDateCalc.getMonth() - 1));
                var dtNextMonthDate = new Date(nextDateCalc.setMonth(nextDateCalc.getMonth() + 1));

                month = $.app.monthBangla[month];
                year = e2b(year);
                var threemBeforeM = currentDate.setMonth(currentDate.getMonth() - 2);
                threemBeforeM = new Date(threemBeforeM).getMonth();
                console.log("threemBeforeM",threemBeforeM);
                // 3 months before
                threemBeforeM = $.app.monthBangla[threemBeforeM];
                var threemBeforeY = e2b(currentDate.getFullYear());

                // Previous month
                var dtPreviousMonthDateMonth = $.app.monthBangla[dtPreviousMonthDate.getMonth() + 1];
                var dtPreviousMonthDateYear = e2b(dtPreviousMonthDate.getFullYear());

                //Month before previous month
                var dtMonthBeforePreviousMonthMonth = $.app.monthBangla[dtMonthBeforePreviousMonthDate.getMonth() + 1];
                var dtMonthBeforePreviousMonthYear = e2b(dtMonthBeforePreviousMonthDate.getFullYear());

                //Next month
                var dtNextMonthDateMonth = $.app.monthBangla[dtNextMonthDate.getMonth() + 1];
                var dtNextMonthDateYear = e2b(dtNextMonthDate.getFullYear());

//                console.log(dtPreviousMonthDateMonth, dtMonthBeforePreviousMonthMonth, dtNextMonthDateMonth);
                switch (agendaCode) {
                    case 21:

                        return '<tr id="tableRow">\
                            <th>কর্মীর নাম&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                            <th>পদবী</th>\
                            <th>কর্ম এলাকা</th>\
                            <th>' + dtNextMonthDateMonth + ', ' + dtNextMonthDateYear + '  মাসের<br/>অগ্রিম কর্মসূচির<br/> অবস্থা</th>\
                        </tr>';
                        break;
                    case 31:
                        return '<tr id="tableRow">\
                            <th>ইউনিট</th>\
                            <th>র্কমীর নাম</th>\
                            <th>' + dtPreviousMonthDateMonth + ', ' + dtPreviousMonthDateYear + '  মাসের<br/>এমআইএস-১ প্রনয়ন ও<br/>জমাদান পরিস্থিতি</th>\
                            <th>জমাকৃত এমআইএস-১<br/>পর্যালোচনা</th>\
                        </tr>';
                        break;

                    case 32:
                        return '<tr id="tableRow">\
                            <th>ইউনিয়ন</th>\
                            <th>র্কমীর নাম</th>\
                            <th>' + dtPreviousMonthDateMonth + ', ' + dtPreviousMonthDateYear + '  মাসের<br/>এমআইএস-২ প্রনয়ন ও<br/>জমাদান পরিস্থিতি</th>\
                            <th>জমাকৃত এমআইএস-২<br/>পর্যালোচনা</th>\
                        </tr>';
                        break;

                    case 33:
                        return '<tr id="tableRow">\
                            <th>সেবা কেন্দ্রের নাম </th>\
                            <th>র্কমীর নাম</th>\
                            <th>পদবি</th>\
                            <th>' + dtPreviousMonthDateMonth + ', ' + dtPreviousMonthDateYear + '  মাসের<br/>এমআইএস-৩ প্রনয়ন ও<br/>জমাদান পরিস্থিতি</th>\
                            <th>জমাকৃত এমআইএস-৩<br/>পর্যালোচনা</th>\
                        </tr>';
                        break;

                    case 41:
                        return '<tr>\
                            <th>ইউনিট  </th>\
                            <th>কর্মীর নাম </th>\
                            <th>সক্ষম দম্পতি</th>\
                            <th>অগ্রগতি</th>\
                        \
                        ' + '<th>' + threemBeforeM + " "
                                + threemBeforeY + '</th>' +
                                '<th>' + dtMonthBeforePreviousMonthMonth
                                + " " + dtMonthBeforePreviousMonthYear + '</th>\
                            <th>' + dtPreviousMonthDateMonth + " " + dtPreviousMonthDateYear + '</th>\
                        </tr>';
//                        '<tr>\
//                            <th rowspan="2">ইউনিট  </th>\
//                            <th rowspan="2">কর্মীর নাম &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
//                            <th rowspan="2">সক্ষম দম্পতি</th>\
//                            <th rowspan="2">অগ্রগতি</th>\
//                            <th colspan="2">পূর্ববর্তী মাস</th>\
//                            <th colspan="1">বর্তমান মাস</th>\
//                        </tr>\
//                        <tr>' + '<th>' + dtMonthBeforePreviousMonthMonth + " "
//                                + dtMonthBeforePreviousMonthYear + '</th>' +
//                                '<th>' + dtMonthBeforePreviousMonthMonth
//                                + " " + dtMonthBeforePreviousMonthYear + '</th>\
//                            <th>' + dtPreviousMonthDateMonth + " " + dtPreviousMonthDateYear + '</th>\
//                        </tr>';
                        break;
                    case 51:
                        return '<tr id="tableRow">\
                            <th>ইউনিট</th>\
                            <th>কর্মীর নাম &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                            <th>পদ্ধতি (গ্রহণকারীর সংখ্যা)</th>\
                            <th>লক্ষ্যমাত্রা</th>\
                            <th>অগ্রগতি</th>\
                            <th>অর্জন</th>\
                        </tr>';
                        break;
                    case 61:
                        return '<tr id="tableRow">\
                            <th>ইউনিট</th>\
                            <th>কর্মীর নাম </th>\
                            <th>পদ্ধতি (দম্পতি - ১ সন্তানের মা )</th>\
                            <th>লক্ষ্যমাত্রা </th>\
                            <th>অগ্রগতি </th>\
                            <th>অর্জন </th>\
                        </tr>';
                        break;
                    case 71:
                        return '<tr id="tableRow">\
                            <th>ইউনিট</th>\
                            <th>কর্মীর নাম &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                            <th>স্থায়ী পদ্ধতি সংক্রান্ত তথ্য</th>\
                            <th>লক্ষ্যমাত্রা  </th>\
                            <th>অগ্রগতি </th>\
                            <th>অর্জন </th>\
                        </tr>';
                        break;

                    case 81:
                        return '<tr id="tableRow">\
                                <th>ইউনিট</th>\
                                <th>কর্মীর নাম &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                                <th>সক্ষম দম্পতি</th>\
                                <th>প্রক্ষেপিত গর্ভবতী</th>\
                                <th>বর্তমানে গর্ভবতী</th>\
                                <th>২ মাসের অধিক গর্ভবতীর তথ্য হালনাগাদ হয়নি</th>\
                        </tr>';
                        break;
                    case 82:
                        return '<tr id="tableRow">\
                                <th>ইউনিট</th>\
                                <th>কর্মীর নাম &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                                <th>বর্তমানে গর্ভবতী</th>\
                                <th>সেবা</th>\
                                <th>পাওয়ার কথা</th>\
                                <th>পেয়েছেন</th>\
                        </tr>';
                        break;
                    case 83:
                        return '<tr id="tableRow">\
                            <th>ইউনিট</th>\
                            <th>কর্মীর নাম &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                            <th>প্রসব করেছেন</th>\
                            <th>সেবা</th>\
                            <th>পাওয়ার কথা</th>\
                            <th>পেয়েছেন</th>\
                        </tr>';
                        break;
                    case 84:
                        return '<tr id="tableRow">\
                            <th>ইউনিট</th>\
                            <th>কর্মীর নাম &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                            <th>জীবিত জন্ম</th>\
                            <th>সেবা</th>\
                            <th>পাওয়ার কথা</th>\
                            <th>পেয়েছেন</th>\
                        </tr>';
                        break;
                    case 85:
                        return '<tr>\
                                            <th rowspan="2">ইউিনট </th>\
                                            <th rowspan="2">কর্মীর নাম &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                                            <th rowspan="2">বর্তমানে গর্ভবতী</th>\
                                            <th colspan="2">আয়রন ও ফলিক অ্যাসিড বড়ি</th>\
                                            <th colspan="2">৭.১% ক্লোরোহেক্সিডিন</th>\
                                        </tr>\
                                        <tr>\
                                            <th>পাবে</th>\
                                            <th>পেয়েছে</th>\
                                            <th>পাবে</th>\
                                            <th>পেয়েছে</th>\
                                        </tr>';
                        break;
                    case 86:
//                        return '<tr>\
//                                            <th rowspan="2">ইউনিট </th>\
//                                            <th rowspan="2">কর্মীর নাম &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
//                                            <th rowspan="2">প্রসব </th>\
//                                            <th colspan="2">বাড়ি </th>\
//                                            <th rowspan="2">সেবা কেন্দ্র </th>\
//                                            <th rowspan="2">ঝুঁকিপূর্ণ গর্ভবতী রেফার্ড </th>\
//                                        </tr>\
//                                        <tr>\
//                                            <th>দক্ষ </th>\
//                                            <th>অদক্ষ </th>\
//                                        </tr>';

                        return '<tr>\
//                                            <th rowspan="2">ইউনিট </th>\
//                                            <th rowspan="2">কর্মীর নাম &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
//                                            <th rowspan="2">প্রসব </th>\
//                                            <th colspan="2">বাড়ি </th>\
//                                            <th rowspan="2">সেবা কেন্দ্র </th>\
//                                            <th rowspan="2">ঝুঁকিপূর্ণ গর্ভবতী রেফার্ড </th>\
//                                        </tr>\
//                                        <tr>\
//                                            <th>দক্ষ </th>\
//                                            <th style="border-right: 1px solid #000;">অদক্ষ </th>\
//                                        </tr>';
                        break;

                    case 87:
                        return '<tr>\
                                            <th rowspan="2">ইউনিট </th>\
                                            <th rowspan="2">কর্মীর নাম &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                                            <th colspan="2">গর্ভবতী মায়েদের কাউন্সেলিং</th>\
                                            <th colspan="2">০-২৩ মাস বয়সী শিশুর মায়েদের কাউন্সেলিং</th>\
                                        </tr>\
                                        <tr>\
                                            <th>পাবে</th>\
                                            <th>পেয়েছে</th>\
                                            <th>পাবে</th>\
                                            <th>পেয়েছে</th>\
                                        </tr>';
                        break;

                    case 91:
                        return '<tr>\
                                <th>সেবাদানকারী,<br/>সুপারভাইজার ও মাঠ <br/>কর্মীর নাম&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                                <th>পদবী&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                                <th>কর্ম এলাকা</th>\
                                <th>ক্লিনিকের স্থান</th>\
                                <th>তারিখ </th>\
                        </tr>';
                        break;
                    case 92:
                        return '<tr>\
                                <th rowspan="2">সেবাদানকারী,<br/>সুপারভাইজার ও মাঠ <br/>কর্মীর নাম&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                                <th rowspan="2">পদবী&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                                <th rowspan="2">কর্ম এলাকা</th>\
                                <th colspan="2">স্যাটেলাইট ক্লিনিকে উপস্থিতি</th>\
                        </tr>\
                        <tr>\
                                <th>বর্তমান মাস</th>\
                                <th>গত মাস</th>\
                        </tr>';
                        break;

                    case 101:
                        return '<tr>\
                            <th rowspan="2">মাঠ কর্মীর নাম&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                            <th rowspan="2">পদবী&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                            <th rowspan="2">কর্ম এলাকা</th>\
                            <th colspan="2">কমিউনিটি ক্লিনিকে উপস্থিতি (দিন)</th>\
                            <th colspan="2">ইপিআই কেন্দ্রে উপস্থিতি (সংখ্যা)</th>\
                            <th colspan="2">আই পি সি </th>\
                        </tr>\
                        <tr>\
                            <th>বর্তমান মাস</th>\
                            <th>গত মাস</th>\
                            <th>বর্তমান মাস</th>\
                            <th>গত মাস</th>\
                            <th>বর্তমান মাস</th>\
                            <th>গত মাস</th>\
                        </tr>';
                        break;
                    case 111:
                        return '<tr>\
                                <th>নাম&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                                <th>পদবী&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                                <th>ইউনিট</th>\
                                <th>বর্তমান মাস</th>\
                                <th>গত মাস</th>\
                        </tr>';
                        break;
                    case 121:
                        return '<tr>\
                                <th>কর্মীর নাম&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                                <th>পদবী&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                                <th>ইউনিট</th>\
                                <th>জনসংখ্যা নিবন্ধন হতে প্রাপ্ত কিশোর-কিশোরী</th>\
                                <th>ই-রেজিস্টারে নিবন্ধিত কিশোর-কিশোরী</th>\
                                <th>কাউন্সেলিং করা হয়েছে</th>\
                        </tr>';
                        break;
                    case 131:
                        return '<tr>\
                                <th>কর্মীর নাম&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                                <th>পদবী&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                                <th>ইউনিট</th>\
                                <th>জনসংখ্যা রেজিস্ট্রেশন</th>\
                                <th>দম্পতি রেজিস্ট্রেশন</th>\
                                <th>মৃত্যু তথ্য সংগ্রহ</th>\
                                <th>নতুন গর্ভবতী মহিলা</th>\
                                <th>ফোন নম্বর বিহীন দম্পতি</th>\
                        </tr>';
                        break;
                    case 132:
                        return '<tr>\
                                <th>কর্মীর নাম&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                                <th>পদবী&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                                <th>ইউনিট</th>\
                                <th>৩ মাসের অধিক সময় পরিদর্শন করা হয়নি এমন দম্পতি</th>\
                                <th>ইডিডি অতিক্রান্ত হয়েছে ৩ মাসের অধিক কিন্তু এখনও গর্ববতী তালিকায় রয়েছে এমন মহিলা</th>\
                                <th>গত ২ সপ্তাহ ই-রেজিস্টার ব্যবহার করেছেন</th>\
                        </tr>';
                        break;

                    case 141:
                        return '<tr>\
                            <th rowspan="2">নাম&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                            <th rowspan="2">পদবী&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>\
                            <th rowspan="2">ইউিনট</th>\
                            <th colspan="4">' + month + ', ' + year + ' মাসের অবস্থা</th>\
                        </tr>\
                        <tr>\
                            <th>ফোন  নম্বর বিহীন দম্পতি (%)</th>\
                            <th>৩ মাসের অধিক সময় পরিদর্শন করা হয়নি এমন দম্পতি (%)</th>\
                            <th>ইডিডি অতিক্রান্ত হয়েছে ৩ মাসের অধিক কিন্তু এখনও গর্ভবতী তালিকায় রয়েছে এমন মহিলা (%)</th>\
                            <th>গত ২ সপ্তাহে ই-রেজিস্টার ব্যবহার করেছেন (দিন)</th>\
                        </tr>';
                        break;
                    default:
                        return "";
                }
            },

            column: {
                21: [
                    {data: "provider_name"},
                    {data: "designation"},
                    {data: function (d) {
                            return d.working_area; //.substring(1, d.working_area.length - 1);
                        }},
                    {data: function (d) {
                            if (d.submition_status == "দাখিলকৃত") {
                                return '<span class="label label-flat label-success label-md">' + d.submition_status + '</span>';
                            } else {
                                return '<span class="label label-flat label-danger label-md">' + d.submition_status + '</span>';
                            }
                            //return d.working_area.substring(1, d.working_area.length - 1);
                        }, className: "center"}

                ],
                31: [
                    {data: function (d) {
                            return d.working_area; //.substring(1, d.working_area.length - 1);
                        }},
                    {data: "provider_name"},
//                    {data: "submition_status"},
                    {data: "submitted_status", render: function (d, t, r) {
                            if (r.submitted_status !== "Not Submitted") {
                                return '<span class="label label-flat label-success label-md">' + r["submitted_status"] + '</span>';
                            } else {
                                return '<span class="label label-flat label-danger label-md">' + r["submitted_status"] + '</span>';
                            }
                        }, className: "center"},
//                    {data: function (d) {
//                            return '<a class="btn btn-flat btn-primary btn-xs mis1-view bold">View MIS1</a>';
//                        }},
                    {data: function (d) {
                            if (d["providerid"]) {
                                var json = JSON.stringify({"zillaid": d["zillaid"], "providerid": d["providerid"], "unit": d["unit"], "provtype": 3, "month": d["submitted_month"], "year": d["submitted_year"]});

                                return  "<a class='btn btn-flat btn-primary btn-xs mis1-view' id='" + d.providerid + "' data-info='" + json + "' data-prov='" + JSON.stringify({"provname": d["provider_name"], "providerid": d["providerid"], "assin_type": d["assign_type"] || 1}) + "'><b> View MIS1</b></a>";
                            } else {
                                return "<div class='btn btn-flat btn-primary btn-xs disabled'>View MIS1</div>";
                            }

                            //action += $.MIS1Status.status[d.status];
                            //return action;
                        }}
                ],
                32: [
                    {data: function (d) {
                            return d.working_area;
                        }},
                    {data: "provider_name"},
//                    {data: "submition_status"},
                    {data: function (d) {
                            if (d["submitted_status"] !== "Not Submitted") {
                                return '<span class="label label-flat label-success label-md">' + d["submitted_status"] + '</span>';
                            } else {
                                return '<span class="label label-flat label-danger label-md">' + d["submitted_status"] + '</span>';
                            }
                        }, className: "center"},
                    {data: function (d) {
                            var json = JSON.stringify({"zillaid": d["zillaid"], "upazilaid": d["upazilaid"], "providerid": d["providerid"], "unionid": d["reporting_unionid"], "provtype": 3, "month": d["submitted_month"], "year": d["submitted_year"]});

                            return  "<a disabled class='btn btn-flat btn-primary btn-xs mis2-view' id='" + d.providerid + "' data-info='" + json + "' data-prov='" + JSON.stringify({"provname": d["provider_name"], "providerid": d["providerid"], "assign_type": d["assign_type"] || 1}) + "'><b> View MIS2</b></a>";
                        }}
                ],
                33: [
                    {data: function (d) {
                            return d.working_area;
                        }},
                    {data: "providername"},
                    {data: "degination"},
                    {data: function (d) {
                            if (d["submitionstatus"] !== "Approved") {
                                return '<span class="label label-flat label-danger label-md">' + d["submitionstatus"] + '</span>';
                            } else {
                                return '<span class="label label-flat label-success label-md">' + d["submitionstatus"] + '</span>';
                            }
                        }, className: "center"},
                    {data: function (d) {
                            var json = JSON.stringify({"zillaid": 93, "providerid": 93004, "unit": 11, "provtype": 3, "month": 2, "year": 2021});

                            return  "<a class='btn btn-flat btn-primary btn-xs mis1-view' id='" + d.providerid + "' data-info='" + json + "' data-prov='" + JSON.stringify({"provname": 'Anowara Khatun', "providerid": 93004, "assin_type": 1}) + "' disabled><b> View MIS3</b></a>";
                        }}
                ],
                41: [
                    {data: "working_area"},
                    {data: "provider_name"},
                    {data: function (d) {
                            return d.elcono == null ? e2b("0") : e2b(d.elcono);
                        }},
                    {data: "progress"},
                    {data: function (d) {
                            return d.prev_month1 == null ? e2b("0") : e2b(d.prev_month1);
                        }},
                    {data: function (d) {
                            return d.prev_month2 == null ? e2b("0") : e2b(d.prev_month2);
                        }},
                    {data: function (d) {
                            return d.curr_month == null ? e2b("0") : e2b(d.curr_month);
                        }}
                ],
                51: [
                    {data: "working_area"},
                    {data: "provider_name"},
                    {data: function (d) {
                            return d.method == null ? e2b("0") : d.method + " (" + e2b(d.elco_acceptance) + ")";
                        }},
                    {data: function (d) {
                            return d.target == null ? e2b("0") : e2b(d.target);
                        }},
                    {data: function (d) {
                            return d.progress == null ? e2b("0") : e2b(d.progress);
                        }},
                    {data: function (d) {
                            return d.achieved == null ? e2b("0") : e2b(d.achieved) + " %";
                        }},
//                    {data: function (d) {
//                            return d.elco_acceptance == null ? e2b("0") : e2b(d.elco_acceptance);
//                        }}
                ],
                61: [
                    {data: "working_area"},
                    {data: "provider_name"},
                    {data: function (d) {
                            var info = d.elco_acc_mother1 == null ? e2b("0") : e2b(d.elco_acc_mother1);
                            return d["method"] + " (" + info + ")";
                        }},
                    {data: function (d) {
                            return d.target == null ? e2b("0") : e2b(d.target);
                        }},
                    {data: function (d) {
                            return d.progress == null ? e2b("0") : e2b(d.progress);
                        }},
                    {data: function (d) {
                            return d.achieved == null ? e2b("0") : e2b(d.achieved) + " %";
                        }}
                ],
                71: [
                    {data: "working_area"},
                    {data: "provider_name"},
                    {data: function (d) {
                            var info = d.elco_acc_mother2 == null ? e2b("0") : e2b(d.elco_acc_mother2);
                            return d["method"] + " (" + info + ")";
                        }},
                    {data: function (d) {
                            return d.target == null ? e2b("0") : e2b(d.target);
                        }},
                    {data: function (d) {
                            return d.progress == null ? e2b("0") : e2b(d.progress);
                        }},
                    {data: function (d) {
                            return d.achieved == null ? e2b("0") : e2b(d.achieved) + " %";
                        }}
//                    ,
//                    {data: function (d) {
//                            return d.elco_acc_mother2 == null ? e2b("0") : e2b(d.elco_acc_mother2);
//                        }}
                ],
                81: [
                    {data: "working_area"},
                    {data: "provider_name"},
                    {data: function (d) {
                            return e2b(d.elco_tot || 0);
                        }},
                    {data: function (d) {
                            return e2b(d.targetpreg || 0);
                        }},
                    {data: function (d) {
                            return e2b(d.presentpreg || 0);
                        }},
                    {data: function (d) {
                            return e2b(d.preg_not_monitored2 || 0);
                        }}
                ],
                82: [
                    {data: "working_area", name: "unit"},
                    {data: "provider_name"},
                    {data: function (d) {
                            return e2b(d["pregnow"]);
                        }},
                    {data: function (d) {
                            return "";
                        }},
                    {data: function (d) {
                            return "";
                        }},
                    {data: function (d) {
                            return "";
                        }}
                ],
                83: [
                    {data: "working_area"},
                    {data: "provider_name"},
                    {data: function (d) {
                            return e2b(d["deliverynow"]);
                        }},
                    {data: function (d) {
                            return "";
                        }},
                    {data: function (d) {
                            return "";
                        }},
                    {data: function (d) {
                            return "";
                        }}
                ],
                84: [
                    {data: "working_area"},
                    {data: "provider_name"},
                    {data: function (d) {
                            return e2b(d["livebirth"]);
                        }},
                    {data: function (d) {
                            return "";
                        }},
                    {data: function (d) {
                            return "";
                        }},
                    {data: function (d) {
                            return "";
                        }}
                ],
                85: [
                    {data: "working_area"},
                    {data: "provider_name"},
                    {data: function (d) {
                            return e2b(d.present_preg);
                        }},
                    {data: function (d) {
                            return e2b(d.tot_iron_folic_acid);
                        }},
                    {data: function (d) {
                            return e2b(d.iron_folic_acid);
                        }},
                    {data: function (d) {
                            return e2b(d.tot_misprostal);
                        }},
                    {data: function (d) {
                            return e2b(d.misprostal_done);
                        }}
                ],
                86: [
                    {data: "working_area"},
                    {data: "provider_name"},
                    {data: function (d) {
                            return e2b(d.total_delivery);
                        }},
                    {data: function (d) {
                            return e2b(d.home_delivery_skilled);
                        }},
                    {data: function (d) {
                            return e2b(d.home_delivery_unskilled);
                        }},
                    {data: function (d) {
                            return e2b(d.service_center_delivery);
                        }},
                    {data: function (d) {
                            return e2b(d.referred_nearest_hospital);
                        }}
                ],
                87: [
                    {data: "working_area"},
                    {data: "provider_name"},
                    {data: function (d) {
                            return e2b(d.pregnow);
                        }},
                    {data: function (d) {
                            return e2b(d.breastfeeding_pregwoman);
                        }},
                    {data: function (d) {
                            return e2b(d.tot_concealing_mother);
                        }},
                    {data: function (d) {
                            return e2b(d.breastfeeding_child);
                        }}
                ],
                91: [
                    {data: "rprovname"},
                    {data: "rdesignation"},
                    {data: function (d) {
                            return d.rworking_area; //.substring(1, d.working_area.length - 1);
                        }},
                    {data: function (d) {
                            return d.rsatelite_name == null ? e2b("0") : e2b(d.rsatelite_name);
                        }},
                    {data: function (d) {
                            return d.rschedule_date == null ? e2b("0") : e2b($.app.date(d.rschedule_date).date);
                        }}
                ],
                92: [
                    {data: "provider_name"},
                    {data: "degination"},
                    {data: function (d) {
                            return d.working_area; //.substring(1, d.working_area.length - 1);
                        }},
                    {data: function (d) {
                            return d.curr_sc == null ? e2b("0") : e2b(d.curr_sc);
                        }},
                    {data: function (d) {
                            return d.prev_sc == null ? e2b("0") : e2b(d.prev_sc);
                        }},
                ],
                101: [
                    {data: "provider_name"},
                    {data: "degination"},
                    {data: function (d) {
                            return d.working_area; //.substring(1, d.working_area.length - 1);
                        }},
                    {data: function (d) {
                            return d.curr_cc == null ? e2b("0") : e2b(d.curr_cc);
                        }},
                    {data: function (d) {
                            return d.prev_cc == null ? e2b("0") : e2b(d.prev_cc);
                        }},
                    {data: function (d) {
                            return d.curr_epi == null ? e2b("0") : e2b(d.curr_epi);
                        }},
                    {data: function (d) {
                            return d.prev_epi == null ? e2b("0") : e2b(d.prev_epi);
                        }},
                    {data: function (d) {
                            return d["curr_ipc"]== null ? e2b("0") : e2b(d["curr_ipc"]);
                        }},
                    {data: function (d) {
                            return d["prev_ipc"]== null ? e2b("0") : e2b(d["prev_ipc"]);
                        }}
                ],
                111: [
                    {data: "provider_name"},
                    {data: "degination"},
                    {data: function (d) {
                            return d.working_area; //.substring(1, d.working_area.length - 1);
                        }},
                    {data: function (d) {
                            return d.curr_uth == null ? e2b("0") : e2b(d.curr_uth);
                        }},
                    {data: function (d) {
                            return d.prev_uth == null ? e2b("0") : e2b(d.prev_uth);
                        }}
                ],
                121: [
                    {data: "provider_name"},
                    {data: "degination"},
                    {data: function (d) {
                            return d.working_area;
                        }},
                    {data: function (d) {
                            return d.prs_ado == null ? e2b("0") : e2b(d.prs_ado);
                        }},
                    {data: function (d) {
                            return d.reg_ado == null ? e2b("0") : e2b(d.reg_ado);
                        }},
                    {data: function (d) {
                            return d.couns_ado == null ? e2b("0") : e2b(d.couns_ado);
                        }}
                ],
                131: [
                    {data: "provider_name"},
                    {data: "degination"},
                    {data: function (d) {
                            return d.working_area;
                        }},
                    {data: function (d) {
                            return d.prs_populaiton == null ? e2b("0") : e2b(d.prs_population);
                        }},
                    {data: function (d) {
                            return d.reg_elco == null ? e2b("0") : e2b(d.reg_elco);
                        }},
                    {data: function (d) {
                            return d.counts_death == null ? e2b("0") : e2b(d.counts_death);
                        }},
                    {data: function (d) {
                            return d.counts_new_pregnant == null ? e2b("0") : e2b(d.counts_new_pregnant);
                        }},
                    {data: function (d) {
                            return d.elco_without_phonenumber == null ? e2b("0") : e2b(d.elco_without_phonenumber);
                        }}
                ],
                132: [
                    {data: "provider_name"},
                    {data: "degination"},
                    {data: function (d) {
                            return d.working_area;
                        }},
                    {data: function (d) {
                            return d.elco_not_visited_last_three_months == null ? e2b("0") : e2b(d.elco_not_visited_last_three_months);
                        }},
                    {data: function (d) {
                            return d.edd_expire_exists_delivery_list == null ? e2b("0") : e2b(d.edd_expire_exists_delivery_list);
                        }},
                    {data: function (d) {
                            return d.eregister_used_last_week == null ? e2b("0") : e2b(d.eregister_used_last_week);
                        }}
                ],
                141: [
                    {data: "provider_name"},
                    {data: "degination"},
                    {data: function (d) {
                            return d.working_area;
                        }},
                    {data: function (d) {
                            return d.elco_without_phonenumber == null ? e2b("0") : e2b(d.elco_without_phonenumber);
                        }},
                    {data: function (d) {
                            return d.elco_not_visited_last_three_months == null ? e2b("0") : e2b(d.elco_not_visited_last_three_months);
                        }},
                    {data: function (d) {
                            return d.edd_expire_exists_delivery_list == null ? e2b("0") : e2b(d.edd_expire_exists_delivery_list);
                        }},
                    {data: function (d) {
                            return d.eregister_used_last_week == null ? e2b("0") : e2b(d.eregister_used_last_week);
                        }}
                ],
            },
            renderMIS1: function (data, provider) {
                submissionDate = data.modifydate.split(" ")[0] || new Date();
                data = data.data;
//                var pairs = Template.pairs();
//                var version = Template.getVersion(pairs.year, pairs.month);
//                Template.reset(version);

                var json = data.MIS, mis = data.MIS, lmis = data.LMIS;//, submissionDate = data.submissionDate;
                //Top area part
                function setHeaderArea(row) {
                    var d = {r_unit_name: 'aaa', r_ward_name: 'bbbb', r_un_name: 'ccc', r_upz_name: 'ddd', r_dist_name: 'eee'};

                    if (row) {
                        d = row;
                    }
                    var headerMonth = new Date(submissionDate).getMonth() + 1;
                    var headerYear = new Date(submissionDate).getFullYear();
                    console.log(submissionDate, headerMonth, headerYear);
                    $("#unitValue").html("&nbsp;<b>" + d.r_unit_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#wardValue").html("&nbsp;<b>" + d.r_ward_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#unionValue").html("&nbsp;<b>" + d.r_un_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#upazilaValue").html("&nbsp;<b>" + d.r_upz_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#districtValue").html("&nbsp;<b>" + d.r_dist_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#yearValue").html("<b>" + convertE2B($("#year :selected").text() || headerYear) + "&nbsp;&nbsp;&nbsp;&nbsp;</b>");
                    $("#monthValue").html("<b>" + $.app.monthBangla[$("#month").val() || headerMonth] + "</b>");
                }
                setHeaderArea(json[0]);
                $("#submissionDate").html("&nbsp;&nbsp;<b>" + e2b(convertToUserDate(submissionDate)) + "</b>");
                $("#providerName").html("&nbsp;&nbsp;<b>" + provider.provname + "</b>");
                //Data rendering into table
                var $tables = $('table', Template.context);
                //Data rendering into table
                var mis_data = mis[0] || {};
                if (!mis_data.r_car && mis_data.r_unit_capable_elco_tot) {
                    var r_car = 0;
                    r_car = $.app.percentage(mis_data.r_unit_all_total_tot, mis_data.r_unit_capable_elco_tot, 2);
                    mis_data.r_car = r_car;
                }
                var NA = [], SKIP = ['r_car', 'r_unit_all_total_tot', 'r_unit_capable_elco_tot'];
                $.each(mis_data, function (k, v) {
                    var _k = '[id$=' + k.replace(/^(r|v)_/, '') + ']', _v = Template.reportValue(v, ~SKIP.indexOf(k));
                    var $k = $tables.find(_k);
                    if ($k.length) {
                        $k.html(_v);
                    } else {
                        NA.push(_k);
                    }
                });

                //LMIS
                var $stockvacuum = {
                    1: 'ক',
                    2: 'খ',
                    3: 'গ',
                    4: 'ঘ'
                }
                $.each(lmis, function (k, v) {
                    $row = e2b(finiteFilter(v));
                    if (k.split("_")[0] == "stockvacuum")
                        $row = $stockvacuum[v];
                    $('.mis_table').find('#' + k).html($row);
                });
            },
            renderMIS2: function (data, provider) {
                submissionDate = new Date();//data.modifydate.split(" ")[0] || 
                data = JSON.parse(data[0]["data"]);
                data = data["mis2"];
                var mis = data;
//                var pairs = Template.pairs();
//                var version = Template.getVersion(pairs.year, pairs.month);
//                Template.reset(version);
                console.log(data, provider);
                // var json = data.MIS, mis = data.MIS, lmis = data.LMIS;//, submissionDate = data.submissionDate;
                //Top area part

                function setHeaderArea(row) {
                    var d = {r_unit_name: 'aaa', r_ward_name: 'bbbb', r_un_name: 'ccc', r_upz_name: 'ddd', r_dist_name: 'eee'};

                    if (row) {
                        d = row;
                    }
                    var headerMonth = new Date(submissionDate).getMonth() + 1;
                    var headerYear = new Date(submissionDate).getFullYear();
                    console.log(submissionDate, headerMonth, headerYear);
                    $("#unitValue").html("&nbsp;<b>" + d.r_unit_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#wardValue").html("&nbsp;<b>" + d.r_ward_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#unionValue").html("&nbsp;<b>" + d.r_un_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#upazilaValue").html("&nbsp;<b>" + d.r_upz_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#districtValue").html("&nbsp;<b>" + d.r_dist_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    $("#yearValue").html("<b>" + convertE2B($("#year :selected").text() || headerYear) + "&nbsp;&nbsp;&nbsp;&nbsp;</b>");
                    $("#monthValue").html("<b>" + $.app.monthBangla[$("#month").val() || headerMonth] + "</b>");
                }
//                setHeaderArea(json[0]);
//                $("#submissionDate").html("&nbsp;&nbsp;<b>" + e2b(convertToUserDate(submissionDate)) + "</b>");
//                $("#providerName").html("&nbsp;&nbsp;<b>" + provider.provname + "</b>");
                //Data rendering into table
                console.log(data);
                renderMIS2(data);
//                var $tables = $('table', Template.context);
                //Data rendering into table
//                MIS2[9].render(mis, 93263, mis, mis, mis);
//                var mis_data = mis[0] || {};
//                if (!mis_data.r_car && mis_data.r_unit_capable_elco_tot) {
//                    var r_car = 0;
//                    r_car = $.app.percentage(mis_data.r_unit_all_total_tot, mis_data.r_unit_capable_elco_tot, 2);
//                    mis_data.r_car = r_car;
//                }
//                var NA = [], SKIP = ['r_car', 'r_unit_all_total_tot', 'r_unit_capable_elco_tot'];
//                $.each(mis_data, function (k, v) {
//                    var _k = '[id$=' + k.replace(/^(r|v)_/, '') + ']', _v = Template.reportValue(v, ~SKIP.indexOf(k));
//                    var $k = $tables.find(_k);
//                    if ($k.length) {
//                        $k.html(_v);
//                    } else {
//                        NA.push(_k);
//                    }
//                });

                //LMIS
//                var $stockvacuum = {
//                    1: 'ক',
//                    2: 'খ',
//                    3: 'গ',
//                    4: 'ঘ'
//                }
//                $.each(lmis, function (k, v) {
//                    $row = e2b(finiteFilter(v));
//                    if (k.split("_")[0] == "stockvacuum")
//                        $row = $stockvacuum[v];
//                    $('.mis_table').find('#' + k).html($row);
//                });
            }
        };//end wp
        $.wp.init();
    });
    function printContent() {
        var divContents = document.getElementById("printContent").innerHTML;
        var oldPage = document.body.innerHTML;
        document.body.innerHTML = "<html><head><title></title><style>body{font-family: SolaimanLipi; font-size: 18px;} h5{font-family: SolaimanLipi; font-size: 20px;}</style></head><body>" + divContents + "</body>";
        window.print();
        document.body.innerHTML = oldPage;
    }
</script>

<div id="mis1-modal-container">
    <%@include file="/WEB-INF/jspf/modalMIS1ViewV9.jspf" %>
    <%@include file="/WEB-INF/jspf/modal-mis1-view-v9.jspf" %>
</div>
<div id="mis2-modal-container">
    <%@include file="/WEB-INF/jspf/modalMIS2ViewV9_MeetingModule.jspf" %>
</div>
<%--<%@include file="/WEB-INF/jspf/modal-report-response.jspf" %>--%>
<%--<%@include file="/WEB-INF/jspf/modalMIS2ViewV9.jspf" %>--%>

<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>