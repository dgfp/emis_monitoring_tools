<%-- 
    Document   : PregnantMotherAndNewbornInfoServiceList
    Created on : Mar 25, 2018, 6:45:16 AM
    Author     : RHIS082
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_register_wise_view.js"></script>
<!--<link href="resources/css/registerWiseView.css" rel="stylesheet" type="text/css"/>-->
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
        #data-table_info{
            display: none;
        }
        table{
            font-family: SolaimanLipi;
            font-size: 10px;
            margin-top: -11px;
        }
        th, td {
            padding: 0px!important;
            padding-left: 5px!important;
            padding-bottom: 5px!important;
            padding-right: 0px!important;
        }
        .box{ border: 0}
        #areaPanel, #back-to-top, .box-header, .main-footer{
            display: none !important;
        }
    }
</style>
<script>
    $(function () {
        function e2b(k, i) {
            return function (d) {
                var v = d ? d[k] : k;
                if (i >= 0 && $.isArray(v)) {
                    v = v[i];
                }
                v = isNaN(parseInt(v)) ? (v || '-') : v;
                return convertE2B(v);
            };
        }

        function wrapper(str) {
            return '<span class=td>' + convertE2B(str || '') + '</span>';
        }
        function wrap(k) {
            return function (d) {
                var v = d ? d[k] : k;
                var arr = [].concat(v);
                return arr.map(wrapper).join('');
            }
        }

        var $table = $('#data-table');
        window.options = {
            data: [],
            bDestroy: true,
            searching: false,
            paging: false,
            columnDefs: [
                {
                    orderable: false,
                    searchable: false,
                    targets: '_all',
                    defaultContent: '-',
                }
            ],
            rowCallback: function (r, d, i, idx) {
                //console.log('fnRowCallback', this, r, d, i, idx);
                $('td', r).eq(0).html(e2b(idx + 1));
            },
            columns: [
                {data: null},
                {data: function (d) {
                        return [convertE2B(d.elcono), convertE2B(d.hhno)].join('/<br>');
                    }},
                {data: wrap('vdate'), className: 'p0 no-wrap'},
                {data: function (d) {
                        return [d.nameeng, d.husbandname, d.villagenameeng, e2b('mobileno')(d)].join('/<br>');
                    }},
                {data: e2b('age')},
                {data: e2b('lmp')},
                {data: e2b('edd')},
                {data: e2b('gravida')},
                {data: e2b('para')},
                {data: e2b('lastchildage')},
                {data: e2b('anc_vdate', 0)},
                {data: e2b('anc_vdate', 1)},
                {data: e2b('anc_vdate', 2)},
                {data: e2b('anc_vdate', 3)},
                {data: wrap('refer'), className: 'p0 no-wrap'},
                {data: function (d) {
                        return d.ironfolstatus ? 'সঠিক' : (d.ironfolstatus == null ? "-" : 'সঠিক নয়');
                    }},
                {data: e2b('misostatus')},
                {data: e2b('outcomedate')},
                {data: e2b('outcomeplace')},
                {data: e2b('attendant')},
                {data: e2b('outcometype')},
                {data: e2b('misoprostol')},
                {data: function (d) {
                        return [e2b('livebirth')(d), e2b('stillbirth')(d)].join('/');
                    }},
                {data: e2b('birthweight')},
                {data: e2b('immaturebirth')},
                {data: e2b('dryingafterbirth')},
                {data: e2b('chlorehexidin')},
                {data: e2b('breastfeed')},
                {data: e2b('baththreedays')},
                {data: e2b('pnc_vdate', 0)},
                {data: e2b('pnc_vdate', 1)},
                {data: e2b('pnc_vdate', 2)},
                {data: e2b('pnc_vdate', 3)},
                {data: null},
                {data: null},
                {data: null}

            ]
        };

        function render(data) {
            data = $.parseJSON(data);
            console.log('data', data);
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

        $('#showdataButton').on('click', function (e) {
            var regExp = /(\d{1,2})\/(\d{1,2})\/(\d{2,4})/; //for date compare
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

                var data = $(':input', '#areaPanel').serializeArray();
                Pace.track(function () {
                    var xhr = $.ajax({url: 'PregnantMotherAndNewbornInfoServiceList', type: 'POST', data: data});
                    xhr.done(render);
                });
                return false;
            }
        });
    })
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle">Pregnant and newborn <small>১২. গর্ভবতী মা ও নবজাতকের তথ্য/ সেবা ছক</small></h1>
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
                        <h2 class="tableTitle"><center>১২. গর্ভবতী মা ও নবজাতকের তথ্য/ সেবা ছক</center></h2>
                        <div class="reg-fwa-12">
                            <table id="data-table">
                                <thead>
                                    <tr valign="bottom">
                                        <td rowspan="2">
                                            <span class="r-v">ক্রমিক নং</span>
                                        </td>
                                        <td rowspan="2">
                                            <span class="r-v">দম্পতি নাম্বার এবং খানা নাম্বার</span>
                                        </td>
                                        <td rowspan="2">
                                            <span class="r-v">পরিদর্শনের তারিখ</span>
                                        </td>
                                        <td rowspan="2">
                                            <span class="r-v">গর্ভবর্তী মায়ের নাম, স্বামীর নাম
                                                <br>গ্রাম/ মহল্লা ও মোবাইলের নাম্বার</span>
                                        </td>
                                        <td rowspan="2">
                                            <span class="r-v">বয়স (বছর)</span>
                                        </td>
                                        <td rowspan="2">
                                            <span class="r-v">শেষ মাসিকের তারিখ (LMP)</span>
                                        </td>
                                        <td rowspan="2">
                                            <span class="r-v">প্রসবের সম্ভাব্য তারিখ (EDD)</span>
                                        </td>
                                        <td rowspan="2">
                                            <span class="r-v">বর্তমানে কততম গর্ভ</span>
                                        </td>
                                        <td rowspan="2">
                                            <span class="r-v">জীবিত সন্তান সংখ্যা</span>
                                        </td>
                                        <td rowspan="2">
                                            <span class="r-v">শেষ সন্তানের বয়স</span>
                                        </td>
                                        <td colspan="7"  class="text-center v-m">গর্ভকালীন সেবার তথ্য</td>
                                        <td colspan="6"  class="text-center v-m">প্রসব সংক্রান্ত তথ্য</td>
                                        <td colspan="6"  class="text-center v-m">নবজাতক সংক্রান্ত তথ্য</td>
                                        <td colspan="4"   class="text-center v-m">প্রসবোত্তর সেবার তথ্য</td>
                                        <td rowspan="2">
                                            <span class="r-v">নবজাতকের মৃত্যু (০-২৮ দিন)</span>
                                        </td>
                                        <td rowspan="2">
                                            <span class="r-v">মাতৃ মৃত্যু</span>
                                        </td>
                                        <td rowspan="2">
                                            <span class="r-v">মন্তব্য</span>
                                        </td>
                                    </tr>
                                    <tr valign="bottom" align="left">
                                        <td>
                                            <span class="r-v">পরিদর্শন-১ (তারিখ)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">পরিদর্শন-২ (তারিখ)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">পরিদর্শন-৩ (তারিখ)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">পরিদর্শন-৪ (তারিখ)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">ঝুঁকিপূর্ণ/ জটিল গর্ভবতী মাকে
                                                <br> রেফার করা হয়েছে (হ্যাঁ/না)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">আয়রন ও ফলিক বড়ি পেয়েছেন কি (হ্যাঁ/না)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">মিসোপ্রোস্টল বড়ি পেয়েছেন কি (হ্যাঁ/না)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">প্রসব/গর্ভপাতের তারিখ</span>
                                        </td>
                                        <td>
                                            <span class="r-v">কোথায় প্রসব হয়েছে (বাড়ী/হাসপাতাল*)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">কে প্রসব করিয়েছেন
                                                <br>(প্রশিক্ষণ প্রাপ্ত**/প্রশিক্ষণ বিহীন ব্যক্তি)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">প্রসবের ধরণ (স্বাভাবিক/ সিজারিয়ান)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">মিসোপ্রোস্টল বড়ি খেয়েছে কি না (হ্যাঁ/না)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">প্রসবের ফলাফল (জীবিত জন্ম/মৃত জন্ম)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">জন্মের সময় ওজন (কেজি)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">অপরিণত জন্ম (৩৭ সপ্তাহের পূর্বে) (হ্যাঁ/না)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">জন্মের পর পরই শুস্ক ও পরিস্কার কাপড় দিয়ে
                                                <br>মুছানো ও মোড়ানো হয়েছে কি না (হ্যাঁ/না)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">নাড়ি কাটার পর ৭.১% একবার ক্লোরোহেক্সিডিন
                                                <br>ব্যবহার করা হয়েছে কি না (হ্যাঁ/না)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">জন্মের ১ ঘন্টার মধ্যে বুকের দুধ খাওয়ানো
                                                <br>হয়েছে কি না (হ্যাঁ/না)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">জন্মের ১ম ৩দিন গোসল থেকে বিরত
                                                <br>রাখা হয়েছে কি না (হ্যাঁ/না)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">পরিদর্শন-১ (তারিখ)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">পরিদর্শন-২ (তারিখ)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">পরিদর্শন-৩ (তারিখ)</span>
                                        </td>
                                        <td>
                                            <span class="r-v">পরিদর্শন-৪ (তারিখ)</span>
                                        </td>
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
                                        <td>১৪</td>
                                        <td>১৫</td>
                                        <td>১৬</td>
                                        <td>১৭</td>
                                        <td>১৮</td>
                                        <td>১৯</td>
                                        <td>২০</td>
                                        <td>২১</td>
                                        <td>২২</td>
                                        <td>২৩</td>
                                        <td>২৪</td>
                                        <td>২৫</td>
                                        <td>২৬</td>
                                        <td>২৭</td>
                                        <td>২৮</td>
                                        <td>২৯</td>
                                        <td>৩০</td>
                                        <td>৩১</td>
                                        <td>৩২</td>
                                        <td>৩৩</td>
                                        <td>৩৪</td>
                                        <td>৩৫</td>
                                        <td>৩৬</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td class="p0">
                                            <span class="td"></span>
                                            <span class="td"></span>
                                            <span class="td"></span>
                                            <span class="td"></span>
                                        </td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td class="p0">
                                            <span class="td"></span>
                                            <span class="td"></span>
                                            <span class="td"></span>
                                            <span class="td"></span>
                                        </td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
