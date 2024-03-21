<%-- 
    Document   : ZeroToEighteenthMonthAgedChildList
    Created on : Mar 25, 2018, 6:05:36 AM
    Author     : RHIS082
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<!--<script src="resources/js/area_dropdown_control_by_user_mis1_bangla.js"></script>-->

<!--<script src="resources/js/area_dropdown_control_by_user_register_wise_view.js"></script>-->
<link href="resources/css/registerWiseView.css" rel="stylesheet" type="text/css"/>
<style>
    .dose{
        width: 4%!important;
    }
    .none{
        display: none;
    }
    .reg-fwa-9{
        background-color: white;
    }
    /*    #tbody{
            display: none;
        }*/
    .r-v {
        white-space: nowrap;
        writing-mode: vertical-rl;
        transform: rotate(180deg);
        vertical-align: bottom;
    }
    #areaPanel [class*="col"] { margin-bottom: 10px; }
    table.dataTable tbody td{ padding: 2px !important; margin: 0}
    table.dataTable  input.form-control{ width: 50px !important; padding: 3px 0 3px 3px !important; margin: 0 !important; text-align: right !important}
    pre{ display: none}

</style>


<script>
    $(function () {
        //var getScript = $.getScript('resources/js/jquery.formParams.js');
        var config = {
            init: 0,
            divid: 50,
            zillaid: 99,
            upazilaid: 63,
            unionid: 43
        };
        var
                $division = $('select#division').Select({url: 'Special_Area_Report', data: {action: 'division'}}, {placeholder: '--নির্বাচন করুন--'}),
                $zilla = $('select#zilla'),
                $upazila = $('select#upazila'),
                $union = $('select#union'),
                $provider = $('select#provider'),
                $specialarea = $('select#specialarea'),
                $year = $('#year'),
                $month = $('#month'),
                $btnGet = $('#getData'), //$("button#getData"),
                $btnSet = $("#setData"),
                init = config.init;
        $division.change(function (e) {
            $zilla.Select();
            $upazila.Select();
            $union.Select();
            $division.val() && $zilla.Select({url: 'Special_Area_Report', data: {action: 'zilla', divid: $division.val()}}, {placeholder: '--নির্বাচন করুন--'});
        }).on('Select', function (e, data) {
            !init && $(this).val(config.divid).change(); // && $(this).prop('disabled', 1);
            $.app.cache.division = data;
        });
        $zilla.change(function (e) {
            $upazila.Select();
            $union.Select();
            $zilla.val() && $upazila.Select({url: 'Special_Area_Report', data: {action: 'upazila', zillaid: $zilla.val()}}, {placeholder: '--নির্বাচন করুন--'});
            //alert($zilla.val());
        }).on('Select', function (e, data) {
            !init && $(this).val(config.zillaid).change(); //&& $(this).prop('disabled', 1);
            $.app.cache.zilla = data;
        });
        $upazila.change(function (e) {
            $union.Select();
            if ($zilla.val() && $upazila.val()) {
                //$.app.select.$union($union, $zilla.val(), $upazila.val(), '', '');
                $provider.Select({url: 'Special_Area_Report', data: {action: 'provider', zillaid: $zilla.val(), upazilaid: $upazila.val()}}, {placeholder: '--নির্বাচন করুন--'});
                $specialarea.Select({url: 'Special_Area_Report', data: {action: 'specialarea', zillaid: $zilla.val(), upazilaid: $upazila.val()}}, {placeholder: '--নির্বাচন করুন--'});
            }
        }).on('Select', function (e, data) {
            !init && $(this).val(config.upazilaid).change();
            $.app.cache.upazila = data;
        });
        $union.on('Select', function (e, data) {
            !init++ && $(this).val(config.unionid) && $btnGet.click();
            $.app.cache.union = data;
        });

        var years = range(new Date().getFullYear(), 2019 - 1).map(function (o, i) {
            return {id: o, text: e2b(o)}
        });
        var months = $.map($.app.monthBangla, function (o, i) {
            return {id: i, text: o}
        });

        $year.Select(years, {placeholder: null, value: $.app.moveMonth().getYear()});
        $month.Select(months, {placeholder: null, value: $.app.moveMonth().getMonth()});
        $.app.hideNextMonths();

        var _e2b = function (k) {
            return function (d) {
                var v = d[k];
                return v === null ? '-' : e2b(v);
            };
        };

        window.options = {
            bDestroy: true,
            searching: false,
            orderable: false,
            paging: false,
            info: false,
            columnDefs: [
                {
//                    orderable: false,
//                    searchable: false,
                    targets: '_all',
                    defaultContent: '-'
                }
            ],

            rowCallback: function (r, d, i, idx) {
                //console.log('fnRowCallback', this, r, d, i, idx);
                $('td', r).eq(0).html(e2b(idx + 1));
            },
            data: [],
            columns: []
                    //columns: [{"data": null}, {"data": _e2b("r_villagename")}, {"data": _e2b("r_barrack_tot")}, {"data": _e2b("r_household_tot")}, {"data": _e2b("r_population_tot")}, {"data": _e2b("r_capable_elco_tot")}, {"data": _e2b("r_permanent_man_tot")}, {"data": _e2b("r_permanent_woman_tot")}, {"data": _e2b("r_permanent_both_tot")}, {"data": _e2b("r_inject_tot")}, {"data": _e2b("r_iud_tot")}, {"data": _e2b("r_implant_tot")}, {"data": _e2b("r_condom_tot")}, {"data": _e2b("r_pill_tot")}, {"data": _e2b("r_all_total_tot")}, {"data": _e2b("r_car")}, {"data": _e2b("r_preg_anc_service_visit_csba")}, {"data": _e2b("r_pnc_mother_visit_csba")}, {"data": _e2b("r_delivery_service_delivery_done_csba")}, {"data": _e2b("r_pnc_child_visit_csba")}, {"data": _e2b("r_delivery_service_hospital_operation_fwa")}, {"data": _e2b("r_general_patients")}, {"data": _e2b("r_tot_live_birth_fwa")}, {"data": _e2b("r_death_number_maternal_death_fwa")}, {"data": _e2b("r_death_number_child_fwa")}, {"data": _e2b("r_death_number_other_death_fwa")}, {"data": _e2b("r_death_number_all_death_fwa")}]
        };


        window.SA = {
            pairs: function (context) {
                context = context || '#areaPanel';
                return $.app.pairs($(':input', context));
            },
            columns: [null, "r_villagename", "r_barrack_tot", "r_household_tot", "r_population_tot", "r_capable_elco_tot", "r_permanent_man_tot", "r_permanent_woman_tot", "r_permanent_both_tot", "r_inject_tot", "r_iud_tot", "r_implant_tot", "r_condom_tot", "r_pill_tot", "r_all_total_tot", "r_car", "r_preg_anc_service_visit_csba", "r_pnc_mother_visit_csba", "r_delivary_service_delivery_done_csba", "r_pnc_child_visit_csba", "r_delivary_service_hospital_operation_fwa", "r_general_patients", "r_tot_live_birth_fwa", "r_death_number_maternal_death_fwa", "r_death_number_child_fwa", "r_death_number_other_death_fwa", "r_death_number_all_death_fwa"],
            skip: "r_villagename",
            relations: {
                "r_permanent_both_tot": ["r_permanent_man_tot", "r_permanent_woman_tot"],
                "r_all_total_tot": ["r_permanent_man_tot", "r_permanent_woman_tot", "r_inject_tot", "r_iud_tot", "r_implant_tot", "r_condom_tot", "r_pill_tot"],
                "r_death_number_all_death_fwa": ["r_death_number_maternal_death_fwa", "r_death_number_child_fwa", "r_death_number_other_death_fwa"],
                "r_car": ["r_all_total_tot", "r_capable_elco_tot"]
            },
            percentage: ["r_car"],
            isPercentile: function (k) {
                return  ~SA.percentage.indexOf(k);
            },
            data: [],
            autoCalc: function ($target) {
                var data = [];
                var $table = $target.closest('table');
                var getValues = function ($parent) {
                    var pairs = {};
                    $parent.find('input').each(function (k, o) {
                        var name = $(o).attr('name'), value = $(o).val();
                        var fnClass = value.toString().length ? 'removeClass' : 'addClass';
                        $(o)[fnClass]('error');
                        pairs[name] = +finiteFilter(value);
                    });
                    return pairs;
                };

//                var setValues = function ($parent, values) {
//                    $parent.find('input').each(function (k, o) {
//                        var name = $(o).attr('name');
//                        $(o).filter('[name=' + name + ']').val(values[k]);
//                    });
//                };

                //var calc = new Calc([]);
                $table.find('tbody tr').each(function (index, tr) {
                    var old = $table.DataTable().row(tr).data();
                    var row = getValues($(tr));
                    row = $.extend({}, old, row);
                    data[index] = row;
                    $.each(SA.relations, function (k, rel) {
                        var agg = 0;
                        if (!SA.isPercentile(k)) {
                            agg = rel.reduce(function (p, n) {
                                return p + row[n];
                            }, 0);
                        }
//                        else {
//                            var n = row[rel[0]], d = row[rel[1]], p = 2;
//                            agg = $.app.percentage(n, d, p);
//                        }
                        data[index][k] = agg;
                        $(tr).find('input').filter('[name=' + k + ']').val(agg);
                    });

                    var agg = 0;
                    var k = "r_car";
                    var rel = SA.relations[k];
                    var n = row[rel[0]], d = row[rel[1]], p = 2;
                    agg = $.app.percentage(n, d, p);
                    data[index][k] = agg;
                    $(tr).find('input').filter('[name=' + k + ']').val(agg);

                    //2console.log('ROW', index, old, row);
                    //var $tr = $table.find('tr').eq(index);
                    //setValues($tr, data[index]);
                });

                console.log('data', data);
                this.data = data;
            },
            init: function () {
                $('body').on('input', 'table [type=number]', function (e) {
                    var $target = $(e.target), value = $target.val();
                    value = value.replace(/(?!^\-)[^\d]/gi, '');
                    $target.val(value);
//                    if (value) {
//                        $target.removeClass('error');
//                    } else {
//                        $target.addClass('error');
//                    }
                    SA.autoCalc($target);
                });
            }
        };

        SA.init();

        function columnValues() {
            return $.map(SA.columns, function (col, i) {
                return col ? {data: _e2b(col)} : {data: null};
            });
        }

        function dumpValues() {
            var values = {};
            $.each(SA.columns, function (i, col) {
                values[col] = '';
            });
            return values;
        }

        function columnInputs() {
            return $.map(SA.columns, function (col, i) {
                return col ? (col === SA.skip ? {data: col} : {data: function (r) {
                        var attrs = SA.relations[col] ? " type=text  readonly disabled " : " type=number min=0 ";
                        var value= r[col]===null?"": r[col];
                        return '<input class="form-control" name="' + col + '" value="' +value + '" ' + attrs + ' />';
                    }}) : {data: null};
            });
        }


        var $table = $('table#special_area'), thead = $table.find('thead').html();
        /*
         var dummy = new Array(2).fill(dumpValues());
         var _options = $.extend({}, options, {data: dummy, columns: columnInputs()});
         $table.empty();
         $table.dt(_options);
         $table.find('thead').html(thead);
         */
        var isValid = function (pairs) {
            var $inputs = $(':input', '#areaPanel'), $errors = $(), klass = 'error';
            $inputs.removeClass(klass);
            if (!pairs.divid) {
                $.toast("Please select division", 'warning')();
                $errors = $errors.add($division);
            }
            if (!pairs.zillaid) {
                $.toast("Please select zilla", 'warning')();
                $errors = $errors.add($zilla);
            }
            if (!pairs.upazilaid) {
                $.toast("Please select upazila", 'warning')();
                $errors = $errors.add($upazila);
            }
            if (!pairs.specialarea) {
                $.toast("Please select project", 'warning')();
                $errors = $errors.add($specialarea);
            }

            $errors.addClass(klass);
            return !$errors.length;
        };

        $btnGet.on('click', function (e) {
            var pairs = SA.pairs();
            pairs.action = 'getData';

            if (!isValid(pairs)) {
                return false;
            }

            var xhr = $.ajax({url: 'Special_Area_Report', data: pairs, type: 'POST'});


            $btnGet.button("loading");
            //xhr.done(console.log).fail(console.log).always(function(){ alert("i'm always alive") });
            xhr.then(function (response) {
                response = $.parseJSON(response);
                response.data = $.parseJSON(response.data);
                console.log(response);
                if (response.status == "success") {

                    console.log(response.data);
                    $table.empty();
                    SA.data = response.data;

                    $btnSet[SA.data.length ? 'removeClass' : 'addClass']('hidden');
                    //var _columns=columnValues();
                    var _columns = columnInputs();
                    var _options = $.extend({}, options, {data: response.data, columns: _columns});
                    $table.dt(_options);
                    $table.find('thead').html(thead);
                }
                $btnGet.button("reset");
            }, console.log, function () {
                $btnGet.button("reset");
            });
        });


        $btnSet.on('click', function () {
            console.log('SA.data', SA.data,  $table.DataTable().rows().data().toArray());
            var xhr = $.ajax('Special_Area_Report',
                    {type: 'POST',
                        data: {
                            action: 'setData',
                            //data: SA.data,
                            json_stringify: JSON.stringify(SA.data)
                        }
                    });
            xhr.then(function (e) {
                console.log('success', e);
            }, function (e) {
                console.log('error', e);
            }, function () {
                // $btnGet.button("reset");
            });
        });

    });
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle">আশ্রায়ণ<small>আবাসন প্রকল্পের পরিবার পরিকল্পনা বিষয়ক মাসিক প্রতিবেদন</small></h1>
</section>
<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <div class="row" id="areaPanel">
        <pre>
{
        providerCode:${providerCode},
        userLevel:${userLevel},
        district:${district},
        upazila:${upazila},
        union:${upazila},
}
        </pre>
        <div class="col-md-12">
            <div class="box box-primary">
                <input type="hidden" value="${userLevel}" id="userLevel">
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <label for="division">বিভাগ</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="divid" id="division"> 
                                <option value="">--নির্বাচন করুন--</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-xs-2">
                            <label for="zilla">জেলা</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="zillaid" id="zilla"> 
                                <option value="">--নির্বাচন করুন--</option>
                            </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="upazila">উপজেলা</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="upazilaid" id="upazila">
                                <option value=""> --নির্বাচন করুন--</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-xs-2">
                            <label for="union">ইউনিয়ন</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="unionid" id="union">
                                <option value=""> --নির্বাচন করুন--</option>
                            </select>
                        </div>
                    </div>

                    <div class="row secondRow">
                        <div class="col-md-1 col-xs-2">
                            <label for="provider">প্রোভাইডার</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="providerid" id="provider">
                                <option value=""> --নির্বাচন করুন--</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-xs-2">
                            <label for="specialarea">প্রকল্প</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="specialarea" id="specialarea">
                                <option value=""> --নির্বাচন করুন--</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-xs-2">
                            <label for="yearno">বছর</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="yearno" id="year"></select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="monthno">মাস</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="monthno" id="month"> </select>
                        </div>
                    </div>
                    <div class="row thirdRow">
                        <div class="col-md-2 col-xs-4 col-md-offset-7 col-xs-offset-2">
                            <button type="button" id="setData" class="btn btn-flat btn-primary btn-block btn-sm hidden">
                                <b><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;  জমা দিন</b>
                            </button>
                        </div>
                        <div class="col-md-1 col-xs-2">

                        </div>
                        <div class="col-md-2 col-xs-4">
                            <button type="button" id="getData" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off">
                                <b><i class="fa fa-bar-chart" aria-hidden="true"></i> ডাটা দেখান</b>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
                        <h3 class="tableTitle"><center>আবাসন প্রকল্পের পরিবার পরিকল্পনা বিষয়ক মাসিক প্রতিবেদন</center></h3>
                        <div class="reg-fwa-9 table-data">
                            <table class="table text-center hidden" >
                                <thead>
                                    <tr>
                                        <td colspan="7" style="border-color:transparent">
                                            <div style="width:120px; font-size:11px; border: 1px solid #000; padding: 5px; margin:auto 30px auto auto">"ছেলে হোক, মেয়ে হোক,<br>
                                                দু’টি সন্তানই যথেষ্ট"</div>
                                        </td>
                                        <td colspan="13" style="border-color:transparent">
                                            <div style="font-size:13px;">গনপ্রজাতন্ত্রী বাংলাদেশ সরকার<br>
                                                উপজেলা পরিবার পরিকল্পনা কার্যালয়<br>
                                            </div>
                                        </td>
                                        <td colspan="7" style="border-color:transparent">
                                            <div style="width:120px; font-size:11px; border: 1px solid #000; padding: 5px; margin:auto auto auto 30px">"শেখ হাসিনার দর্শন,<br>
                                                বাংলাদেশের উন্নয়ন"</div> 
                                        </td>
                                    </tr>
                                    <tr><td colspan="37" style="padding:15px; font-weight:bold;font-size:15px;border-color:transparent"><span id="project-name"></span> আবাসন প্রকল্পের পরিবার পরিকল্পনা বিষয়ক মাসিক প্রতিবেদন</td></tr>
                                </thead>
                            </table>
                            <table class="text-center" id="special_area">
                                <thead>
                                    <tr>
                                        <td rowspan="4" class="v-b">ক্রঃ নং</td>
                                        <td rowspan="4" class="v-b" style="width: 5%">আবাসন <br />প্রকল্পের<br /> গ্রামের নাম</td>
                                        <td colspan="2">ব্যারাক সংক্রান্ত তথ্য</td>
                                        <td rowspan="4" class="v-b"><span class="r-v">ব্যারাকের জনসংখ্যা</span></td>
                                        <td rowspan="4" class="v-b"><span class="r-v">দম্পতি সংখ্যা</span></td>
                                        <td colspan="8">পরিবার পরিকল্পনা পদ্ধতি ব্যবহারকারীর সংখ্যা</td>

                                        <td rowspan="4" class="v-b" style="width: 4%">মোট পদ্ধতি <br>গ্রহণকারীর <br>সংখ্যা</td>
                                        <td rowspan="4" style="width: 4%" class="v-b"><span class="r-v">সি এ আর</span></td>

                                        <td colspan="5">মা ও শিশু স্বাস্থ্য সেবা</td>

                                        <td rowspan="4" style="width: 4%" class="v-b"><span class="r-v">সাধারণ রোগী</span></td>
                                        <td rowspan="4" style="width: 4%" class="v-b"><span class="r-v">জন্মের সংখ্যা</span></td>

                                        <td colspan="4">মৃত্যুর সংখ্যা </td>
                                    </tr>
                                    <tr>
                                        <td rowspan="4" class="v-b" style="width: 5%"><span class="r-v">ব্যারাকের সংখ্যা</span></td>
                                        <td rowspan="4" class="v-b" style="width: 5%"><span class="r-v">হাউজের সংখ্যা</span></td>
                                        <td rowspan="2" colspan="3">স্থায়ী পদ্ধতি গ্রহণকারীর<br /> সংখ্যা</td>
                                        <td colspan="5">অস্থায়ী পদ্ধতি গ্রহণকারীর সংখ্যা</td>
                                        <td rowspan="4" class="v-b"><span class="r-v">গর্ভবতী</span></td>
                                        <td rowspan="4" class="v-b"><span class="r-v">গর্ভোত্তর</span></td>
                                        <td rowspan="4" class="v-b"><span class="r-v">প্রসব</span></td>
                                        <td rowspan="4" class="v-b"><span class="r-v">শিশু</span></td>
                                        <td rowspan="4" class="v-b"><span class="r-v">সিজার অপারেশন</span></td>

                                        <td rowspan="4" class="v-b"><span class="r-v">মাতৃ মৃত্যু</span></td>
                                        <td rowspan="4" class="v-b"><span class="r-v">শিশু মৃত্যু</span></td>
                                        <td rowspan="4" class="v-b"><span class="r-v">অন্যান্য মৃত্যু</span></td>
                                        <td rowspan="4" class="v-b"><span class="r-v">মোট মৃত্যুর সংখ্যা</span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">ক্লিনিকাল</td>
                                        <td colspan="2">নন-ক্লিনিকাল</td>
                                    </tr>
                                    <tr>
                                        <td class="dose v-b"><span class="r-v">পুরুষ</span></td>
                                        <td class="dose v-b"><span class="r-v">মহিলা</span></td>
                                        <td class="dose v-b"><span class="r-v">মোট</span></td>
                                        <td class="dose v-b"><span class="r-v">ইনজেকশন</span></td>
                                        <td class="dose v-b"><span class="r-v">আইইউডি</span></td>
                                        <td class="dose v-b"><span class="r-v">ইমপ্ল্যান্ট</span></td>
                                        <td class="dose v-b"><span class="r-v">কনডম</span></td>
                                        <td class="dose v-b"><span class="r-v">বড়ি</span></td>
                                    </tr>
                                </thead>
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