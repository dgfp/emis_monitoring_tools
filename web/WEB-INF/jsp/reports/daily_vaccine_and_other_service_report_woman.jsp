<%-- 
    Document   : epi_report
    Created on : May 31, 2017, 11:37:59 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_epi_bangla.js"></script>
<!--<script src="resources/js/HATabResponsive-EPI.js" type="text/javascript"></script>-->
<%    if (session.getAttribute("isTabAccess") != null) {
%>
<style>
    #areaPanel{
        margin-top: -90px!important;
    }
</style>
<%
    }
%>
<style>
    .underDevTitle{
        display: none;
    }
    .tg  {border-collapse:collapse;border-spacing:0;}
    .tg td{font-family:Arial, sans-serif;font-size:13px;padding:3px 3px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
    .tg th{font-family:Arial, sans-serif;font-size:13px;font-weight:normal;padding:3px 3px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
    .tg .tg-0e45{font-size:12px}
    .tg .tg-q19q{font-size:12px;vertical-align:top}
    .tg .tg-yw4l{vertical-align:top}
    .center{
        text-align: center;
    }
    .left{
        text-align: left;
    }
    .tg th {
        background-color: #fff;
        color: #000;
    }
    [class*="col"] { margin-bottom: 10px; }
</style>
<script>


    $(document).ready(function () {
        function e2b(k) {
            return function (d) {
                var v = d ? d[k] : k;
                v = isNaN(parseInt(v)) ? (v || '-') : v;
                return convertE2B(v);
            };
        }
        ;
        function tt(n, p) {
            return function (d) {
                var v = d["tt" + n];
                return (+d.pregnant === p) ? (tt.symbols[v] || '-') : '';
            };
        }
        tt.symbols = {0: "০", 1: "∅"};
        tt.key = function (d, n, suffix) {
            n = n || '';
            suffix = suffix || '';
            return 'tt' + n + '_p' + d.pregnant + suffix;
        };

        tt.reducer = function (p, d) {
            var tsum = 0,
                    k = '',
                    v = 0,
                    target = '',
                    given = '',
                    due = '';

            for (var i = 6; --i; ) {
                k = tt.key(d, i),
                        v = parseInt(d['tt' + i], 10),
                        target = k + '_target',
                        given = k + '_given',
                        due = k + '_due';

                //tsum = tsum + (+v);
                p[given] = (p[given] || 0) + (+v);
                p[target] = (p[target] || 0) + (+!isNaN(v) && 1);
                p[due] = p[target] - p[given];
            }

            // k=tt.key(d,i);
            // p[k] = (p[k]||0) + tsum;
            return p;
        };



        var $table = $('#data-table'),
                $thead = $table.find('thead'),
                $tbody = $table.find('tbody'),
                $tfoot = $table.find('tfoot'),
                tfootHTML = $tfoot.html(),
                colspan = {
                    clear: function () {
                        $tfoot.empty();
                        $thead.find('tr:first>th').filter('[data-colspan]').removeAttr('colspan');
                    },
                    draw: function (settings) {
                        console.log('--------');
                        var $th = $thead.find('tr:first>th');
                        var index = -1;
                        $th.each(function (i, o) {
                            var colA = $(o).attr('colspan'),
                                    colD = $(o).data('colspan'),
                                    col = +colA || 1;
                            index += col;
                            if (colD) {
                                if (colA > 1)
                                    index -= col - 1;
                                console.log(i, index);
                                $tbody.find('td:nth-child(' + (index + 1) + ')').attr('colspan', colD);
                                $(o).attr('colspan', colD);
                            }
                        });
                        console.log('--------');
                        //var api = this.api();
                        // console.log('drawCallback', api.rows( {page:'current'} ).data() );
                    }
                },
                options = {
                    data: [],
                    //dom: 'Bflrtip',
                    //destroy: true,
                    searching: false,
                    paging: false,
                    //order: [[1, 'asc']],
                    // ajax: {
                    //     url:'',
                    //     type:'POST',
                    //     data:{},
                    // },
                    columnDefs: [
                        {
                            //targets: [0, 1, 2, [3, 4, 5, 6], 7, [8, 9, 10], 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, [22, 23, 24], [25, 26]],
                            targets: '_all',
                            defaultContent: '-'
                        }
                    ],
                    rowCallback: function (r, d, i, idx) {
                        //console.log('fnRowCallback',this, r,d, i, idx);
                        $('td', r).eq(0).html(e2b(idx + 1));
                    },
                    preDrawCallback: function (settings) {
                        colspan.clear();
                        var data = settings.oInit.data;
                        console.log('settings', settings);
                        console.log('total: ', data.length);
                        var $tt = $tfoot.html(tfootHTML).find('.tt').html('-');
                        var dd = data.reduce(tt.reducer, {});
                        $.each(dd, function (k, v) {
                            $tt.filter('.' + k).html(e2b(v));
                        });
                        //console.log('preDrawCallback',settings );
                    },
                    drawCallback: function drawCallback(settings) {
                        colspan.draw();
                        //var api = this.api();
                        // console.log('drawCallback', api.rows( {page:'current'} ).data() );
                    },
                    initComplete: function () {
                        //var api = this.api();
                        // api.columns().indexes().flatten().each( function ( i ) {
                        //     var column = api.column( i );
                        //     console.log('initComplete',i, column);
                        // });
                    },
                    columns: [
                        {
                            orderable: false,
                            searchable: false,
                            data: null,
                            defaultContent: '#'
                        },
                        {data: e2b('regno'), defaultContent: '-'},
                        {data: e2b('scheduledate'), defaultContent: '-', className: 'text-nowrap'},
                        {data: function (d) {
                                return '<span class="text-nowrap">' + d.nameeng + '</span>'
                            }, defaultContent: '-', colspan: 4}, //4
                        {data: e2b('dob'), className: 'text-nowrap'},
                        {data: function (d) {
                                return '<span class="text-nowrap">' + ['ক) ' + (d.fathername || '-'), 'খ) ' + (d.villagename || '-'), 'গ) ' + e2b('mobileno')(d)].join('<br>') + '</span>';
                            }, className: 'text-left', defaultContent: '-'},
                        {data: e2b('hhno'), defaultContent: '-', colspan: 3}, //3
                        {data: tt(1, 1)},
                        {data: tt(2, 1)},
                        {data: tt(3, 1)},
                        {data: tt(4, 1)},
                        {data: tt(5, 1)},
                        {data: tt(1, 0)},
                        {data: tt(2, 0)},
                        {data: tt(3, 0)},
                        {data: tt(4, 0)},
                        {data: tt(5, 0)},
                        {data: null, defaultContent: '-', colspan: 3}, //3
                        {data: null, defaultContent: '-', colspan: 2} //2
                    ]
                            // ,buttons: [
                            //     {
                            //         extend: 'excel',
                            //         footer: true,
                            //         title: 'My Title ',
                            //         text: '<i class="fa fa-file-excel-o"></i>',
                            //         titleAttr: 'Export as EXCEL',
                            //     }
                            // ]
                }

        colspan.draw();
        function render(data) {
            colspan.clear();
            options.data = data;
            options.destroy = true;
            if ($.table) {
                $.table.clear();
                $.table.rows.add(options.data);
                $.table.draw();
            } else {
                $.table = $table.DataTable(options);
            }

        }
        //Show data button click
        $('#showdataButton').click(function () {
            if ($("select#division").val() === "") {
                toastr["error"]("<h4><b>বিভাগ সিলেক্ট করুন </b></h4>");
            } else if ($("select#district").val() === "") {
                toastr["error"]("<h4><b>জেলা সিলেক্ট করুন </b></h4>");
            } else if ($("select#upazila").val() === "") {
                toastr["error"]("<h4><b>উপজেলা সিলেক্ট করুন </b></h4>");
            } else if ($("select#union").val() === "") {
                toastr["error"]("<h4><b>ইউনিয়ন সিলেক্ট করুন </b></h4>");
            } else if ($("select#ward").val() === "") {
                toastr["error"]("<h4><b>ওয়ার্ড সিলেক্ট করুন </b></h4>");
            } else if ($("select#subblock").val() === "") {
                toastr["error"]("<h4><b>সাব ব্লক সিলেক্ট করুন </b></h4>");
            } else if ($("select#year").val() === "") {
                toastr["error"]("<h4><b>সন সিলেক্ট করুন </b></h4>");
            } else if ($("select#nameOfEPICenter").val() === "") {
                toastr["error"]("<h4><b>টিকাদান কেন্দ্রের নাম সিলেক্ট করুন </b></h4>");
            } else {
                var str = $("select#nameOfEPICenter").val();
                var epi = str.split('~');
                var scheduleDate = epi[0];
                var centerName = epi[1];
                var btn = $(this).button('loading');
                //Ajax Begin
                Pace.track(function () {
                    $.ajax({
                        url: "daily_vaccine_and_other_service_report_woman",
                        data: {
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            wardId: $("select#ward").val(),
                            subblockId: $("select#subblock").val(),
                            scheduleDate: scheduleDate,
                            centerName: centerName
                        },
                        type: 'POST',
                        success: function (result) {
                            btn.button('reset');
                            var json = JSON.parse(result);
                            if (json.length === 0) {
                                toastr["error"]("<h4><b>কোন ডাটা পাওয়া যায়নি</b></h4>");
                                return;
                            } else {
                                console.log(json, json.length && JSON.stringify(json[0]));
                                render(json);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>অনুরোধটি প্রক্রিয়াধীন করা যাচ্ছে না</b></h4>");
                        }
                    }); //Ajax end
                }); //Pace End
            }
        });
    });
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>EPI tally sheet (Women)<small> দৈনিক টিকা ও অন্যান্য সেবা রিপোর্ট (কিশোরী/মহিলা)</small></h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <%@include file="/WEB-INF/jspf/HAAreaControls-EPI.jspf" %>

    <div class="col-ld-12">
        <div class="box box-primary">
            <div class="box-header with-border">
                <div class="box-tools pull-right" style="margin-top: -10px;">
                    <!--                    <button type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print</button>
                                        <button type="button" class="btn btn-box-tool"><i class="fa fa-file-pdf-o" aria-hidden="true"></i>&nbsp;PDF</button>-->
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool btn-remove" data-widget="remove"><i class="fa fa-times"></i></button>
                </div>
            </div>
            <div class="box-body">
                <h4 style="text-align: center;margin-top: 0px;;"><b>দৈনিক টিকা ও অন্যান্য সেবা রিপোর্ট (কিশোরী/মহিলা)</b></h4>
                <h5 style="text-align: left;margin-top: 5px;">
                    সাব-ব্লকঃ <span id="">..................................</span>
                    টিকাদানঃ <span id="">..................................</span>
                    টিকাদান কেন্দ্রের নামঃ <span id="">..................................</span>
                    গ্রাম/ মহল্লার নামঃ <span id="">..................................</span>
                    ওয়ার্ডঃ <span id="">..................................</span>
                </h5>
                <h5 style="text-align: left;margin-top: 5px;">
                    ইউনিয়ন/ জোনঃ <span id="">..................................</span>
                    উপজেলা/ পৌরসভা/ জোনঃ <span id="">..................................</span>
                    জেলা/ সিটি কর্পোরেশনঃ <span id="">..................................</span>
                    টিকাদানের বারঃ <span id="">..................................</span>
                </h5>
                <h5 style="text-align: left;margin-top: 5px;">
                    টিকাদানের তারিখঃ <span id="">..................................</span>
                </h5>
                <div class="table-responsive">
                    <!--<table class="table table-bordered table-striped table-hover" id="data-table">-->
                    <table style="width: 100% !important;" class="tg center" id="data-table">
                        <thead id="tableHeader" class="data-table">
                            <tr class="center">
                                <th rowspan="3" class="center">ক্রমিক নং</th>
                                <th rowspan="3" class="center">রেজিঃ
                                    <br>নং</th>
                                <th rowspan="3" class="center">তারিখ </th>
                                <th data-colspan="4" rowspan="3" class="center">কিশোরী/মহিলার নাম
                                    <br>(গত সেশনে বাদ পড়া কিশোরী/মহিলার নাম লিখুন এবং পাশে * চিহ্ন দিন)</th>
                                <th rowspan="3" class="center">জন্ম তারিখ/
                                    <br>বয়স</th>
                                <th data-colspan="3" rowspan="3">ক)মাতা/পিতা/স্বামী/অভিভাবকে নাম
                                    <br>খ) গ্রাম/পাড়া/মহল্লা
                                    <br>গ) মাতা/ পিতা/ স্বামী/ অভিভাবকের মোবাইল নম্বর</th>
                                <th rowspan="3" class="center">বাড়ি/
                                    <br>জিআর/
                                    <br>হোল্ডিং
                                    <br>নম্বর </th>
                                <th colspan="10">কিশোরী/মহিলাটি কোন টিকার কোন ডোজ পাবে তা "০" চিহ্ন দিয়ে পূরণ করুন এবং টিকা দেয়ার পর "০" চিহ্নটি আড়াআড়িভাবে
                                    কেটে দিন।</th>
                                <th data-colspan="3" rowspan="3">ক) কিশোরী/মহিলাকে টিকা দেয়া সম্ভব না হলে তার কারন লিখুন।
                                    <br>খ) বহিরাগত মহিলা/কিশোরী হলে লিখুন "বহিরাগত"</th>
                                <th data-colspan="2" rowspan="3" class="center">মন্তব্য</th>
                            </tr>
                            <tr>
                                <th colspan="5">গর্ভবতী মহিলা(১৫-৪৯ বছর)</th>
                                <th colspan="5">সাধারন মহিলা(১৫-৪৯ বছর)</th>
                            </tr>
                            <tr>
                                <th>টিটি১</th>
                                <th>টিটি২</th>
                                <th>টিটি৩</th>
                                <th>টিটি৪</th>
                                <th>টিটি৫</th>
                                <th>টিটি১</th>
                                <th>টিটি২</th>
                                <th>টিটি৩</th>
                                <th>টিটি৪</th>
                                <th>টিটি৫</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>১</td>
                                <td></td>
                                <td></td>
                                <td colspan="4"></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td>২</td>
                                <td></td>
                                <td></td>
                                <td colspan="4"></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td>৩</td>
                                <td></td>
                                <td></td>
                                <td colspan="4"></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td>৪</td>
                                <td></td>
                                <td></td>
                                <td colspan="4"></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td>৫</td>
                                <td></td>
                                <td></td>
                                <td colspan="4"></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td>৬</td>
                                <td></td>
                                <td></td>
                                <td colspan="4"></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td>৭</td>
                                <td></td>
                                <td></td>
                                <td colspan="4"></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td>৮</td>
                                <td></td>
                                <td></td>
                                <td colspan="4"></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td>৯</td>
                                <td></td>
                                <td></td>
                                <td colspan="4"></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td>১০</td>
                                <td></td>
                                <td></td>
                                <td colspan="4"></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td colspan="2"></td>
                            </tr>

                        </tbody>


                        <tfoot>
                            <tr>
                                <td colspan="12" class="left">ক) (০) চিহ্ন যোগ করে আজকের সেশনের মোট লক্ষমাত্রা লিখুন</td>
                                <!-- td[class="tt tt$_p1_target"]*5  -->
                                <td class="tt tt1_p1_target"></td>
                                <td class="tt tt2_p1_target"></td>
                                <td class="tt tt3_p1_target"></td>
                                <td class="tt tt4_p1_target"></td>
                                <td class="tt tt5_p1_target"></td>
                                <td class="tt tt1_p0_target"></td>
                                <td class="tt tt2_p0_target"></td>
                                <td class="tt tt3_p0_target"></td>
                                <td class="tt tt4_p0_target"></td>
                                <td class="tt tt5_p0_target"></td>

                                <td colspan="3"></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td colspan="12" class="left">খ) (∅) চিহ্ন যোগ করে আজকের সেশনের নিয়মিত টিকা পাওয়া কিশোরী/মহিলার মোট সংখ্যা লিখুন</td>
                                <td class="tt tt1_p1_given"></td>
                                <td class="tt tt2_p1_given"></td>
                                <td class="tt tt3_p1_given"></td>
                                <td class="tt tt4_p1_given"></td>
                                <td class="tt tt5_p1_given"></td>
                                <td class="tt tt1_p0_given"></td>
                                <td class="tt tt2_p0_given"></td>
                                <td class="tt tt3_p0_given"></td>
                                <td class="tt tt4_p0_given"></td>
                                <td class="tt tt5_p0_given"></td>
                                <td colspan="3"></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td colspan="12" class="left">গ) আজকের সেশনে বাদ পড়া কিশোরী/মহিলার মোট সংখ্যা লিখুন (ক-খ) </td>
                                <td class="tt tt1_p1_due"></td>
                                <td class="tt tt2_p1_due"></td>
                                <td class="tt tt3_p1_due"></td>
                                <td class="tt tt4_p1_due"></td>
                                <td class="tt tt5_p1_due"></td>
                                <td class="tt tt1_p0_due"></td>
                                <td class="tt tt2_p0_due"></td>
                                <td class="tt tt3_p0_due"></td>
                                <td class="tt tt4_p0_due"></td>
                                <td class="tt tt5_p0_due"></td>
                                <td colspan="3"></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td colspan="12" class="left">ঘ) (∅) চিহ্ন যোগ করে আজকের সেশনের বহিরাগত টিকা পাওয়া কিশোরী/মহিলার মোট সংখ্যা লিখুন</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td colspan="12" class="left">ঙ) (∅) চিহ্ন যোগ করে আজকের সেশনের টিকা পাওয়া কিশোরী/মহিলার সর্বমোট সংখ্যা লিখুন (খ+ঘ)</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td colspan="3"></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td colspan="2" rowspan="3">প্রাপ্ত
                                    <br>ভ্যাকসিন
                                    <br>ভায়ালের
                                    <br>হিসাব</td>
                                <td colspan="4">টিটি </td>
                                <td colspan="3">ভিটামিন-এ (লাল)
                                    <br>(শিশু রেজিঃ বই থেকে পূরণ করতে হবে)</td>
                                <td rowspan="3">এডি/
                                    <br>মিক্সিং
                                    <br>সিরিঞ্জ
                                    <br>ব্যবহারের হিসাব</td>
                                <td>০.০৫
                                    <br>এম. এল</td>
                                <td>০.০৫
                                    <br>এম.এল</td>
                                <td>৫
                                    <br>এম এল</td>
                                <td>২/৩
                                    <br>এম এল</td>
                                <td colspan="2" rowspan="3">এই কেন্দ্রের
                                    <br>পরবর্তী সেশনের
                                    <br>চাহিদা</td>
                                <td colspan="2">বিসিজি+
                                    <br>ডাইলুয়েন্ট</td>
                                <td>পেন্টা</td>
                                <td>পিসিভি</td>
                                <td>ওপিভি</td>
                                <td>আই
                                    <br>পিভি</td>
                                <td colspan="2">এমআর + ডাইলুয়েন্ট</td>
                                <td colspan="2">হাম+ডাইলুয়েন্ট</td>
                                <td>টিটি </td>
                            </tr>
                            <tr>
                                <td>প্রাপ্ত
                                    <br>সংখ্যা</td>
                                <td>পূর্ণ
                                    <br>ব্যবহৃত</td>
                                <td>আংশিক
                                    <br>ব্যবহৃত </td>
                                <td>অব্যবহৃত </td>
                                <td>প্রাপ্ত
                                    <br>সংখ্যা</td>
                                <td>ব্যবহৃত</td>
                                <td>অবশিষ্ট</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
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
                                <td>&nbsp;</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
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
                                <td colspan="17" class="left">স্বাস্থ্য সহকারী/ টিকাদানের নাম, মোবাইল নং ও স্বাক্ষরঃ </td>
                                <td colspan="10" class="left">পঃ কঃ সহকারী/ টিকাদানকারীর নাম, মোবাইল নং ও স্বাক্ষরঃ</td>
                            </tr>
                            <tr>
                                <td colspan="17" class="left">স্বাঃ পরিঃ/ সহঃ স্বাঃ পরিঃ/পঃ পঃ পরিঃ এর নাম, পদবী ও স্বাক্ষর</td>
                                <td colspan="10" class="left">মন্তব্যঃ</td>
                            </tr>
                            <tr>
                                <td colspan="17" class="left">উপঃ স্বাঃ ও পঃ পঃ কর্মকর্তা/ সিসি/ পৌরসভা কর্তৃপক্ষ/ অন্যান্য সুপারভাইজাএর নাম,পদবী,মোবাইল নং ও স্বাক্ষর</td>
                                <td colspan="10" class="left">মন্তব্যঃ</td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

        </div>
    </div>
    <%@include file="/WEB-INF/jspf/templateFooter.jspf" %>