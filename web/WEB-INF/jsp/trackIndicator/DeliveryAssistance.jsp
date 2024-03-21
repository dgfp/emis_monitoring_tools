<%-- 
    Document   : Delivery
    Created on : Jan 29, 2019, 2:51:51 PM
    Author     : Helal
        Delivery by place and attendant
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<!--<script src="https://code.jquery.com/jquery-1.10.2.js"></script>-->
<style>
    .form-group {
        margin-bottom: 0px!important;
    }
    .select2-container--default .select2-selection--single .select2-selection__rendered {
        line-height: 22px;
    }
    #userComboLevel{
        font-size: 16px;
        font-weight: bold;
    }
    .none{
        display: none;
    }
    #viewUserDetails{
        font-size: 18px;
        margin-right: 30px!important;
    }
    .form-control {
        display: inline!important;
    }
    [class*="col"] { margin-bottom: 10px; }
    .small-box {
        margin-bottom: 3px!important;
    }
    #details{
        display: none;
    }
    #typeTitle{
        text-align: center;
    }
    div.dt-buttons {
        float: right;
    }
    .label{
        border-radius: 10px;
    }

    .dt-print-preview{ font-size: 11px !important; }
    .dt-title{ font-size: 16px!important; }
    .dt-title p { font-size: 13px!important;  margin-top: 7px}

    @media print {
        table{ font-size: 11px !important; border-collapse: collapse !important; border: 0}
        table th, table td { border: 1px solid #333}
        .dt-title{ font-size: 16px!important; }
        .dt-title p { font-size: 13px!important;  margin-top: 7px}
        html, body {
            border: 1px solid white;
            height: 99%;
            page-break-after: avoid;
            page-break-before: avoid;
        }
    }
</style>
<script>
    $(function () {
        var config = {
            init: 0,
            divid: 30,
            zillaid: 93,
            upazilaid: '', //66,
            unionid: ''
        };


        var indicators = [
            {id: 1, text: 'Proportion of births attended by skilled health personnel'},
            {id: 2, text: 'Percentage of delivery by skilled attendant'},
            {id: 3, text: 'Percentage of delivery occurred in a health facility'}
        ];
        var $indicator = $('select#indicator').Select(indicators, {placeholder: null, value: 1}),
                $division = $.app.select.$division('select#division'),
                $zilla = $('select#zilla'),
                $upazila = $('select#upazila'),
                $union = $('select#union'),
                $btn = $('#btn-summary'), //$("button#btn-data"),
                init = config.init;
        $indicator.on('Select', function (e, data) {
            console.log(data);
            $.app.cache.indicator = data;
        });

//        $.data = $.app.date();
//        $.app.select.$year('select#year', range($.data.year, 2012, -1)).val($.data.year);
//        $.app.select.$month('select#month').val($.data.month);

        $division.change(function (e) {
            $zilla.Select();
            $upazila.Select();
            $union.Select();
            $division.val() && $.app.select.$zilla($zilla, $division.val());
        }).on('Select', function (e, data) {
            !init && $(this).val(config.divid).change(); // && $(this).prop('disabled', 1);
            $.app.cache.division = data;
        });
        $zilla.change(function (e) {
            $upazila.Select();
            $union.Select();
            $zilla.val() && $.app.select.$upazila($upazila, $zilla.val(), "", "All");
            //alert($zilla.val());
        }).on('Select', function (e, data) {
            !init && $(this).val(config.zillaid).change(); //&& $(this).prop('disabled', 1);
            $.app.cache.zilla = data;
        });
        $upazila.change(function (e) {
            $union.Select();
            $zilla.val() && $upazila.val() && $.app.select.$union($union, $zilla.val(), $upazila.val(), '', 'All');
        }).on('Select', function (e, data) {
            //!init && $(this).val(config.upazilaid).change();
            !init++ && $(this).val('') && $btn.click();
            $.app.cache.upazila = data;
        });
        $union.on('Select', function (e, data) {
            //!init++ && $(this).val('') && $btn.click();
            $.app.cache.union = data;
        });




        var options = {
            //dom: 'Bifrtip',
            dom: "<'row'<'col-sm-4'B><'col-sm-4'i><'col-sm-4'f>><'row'<'col-sm-12'tr>><'row'<'col-sm-5'i><'col-sm-7'p>>",
            lengthMenu: [
                [10, 25, 50, 100, -1],
                ['10', '25', '50', '100', 'All'],
            ],
            pageLength: 50,
            bDestroy: true,
            processing: true,
            order: [[0, "desc"]],
            buttons: [
                {
                    extend: 'print',
                    text: ' <i class="fa fa-print" aria-hidden="true"></i> Print / PDF',
                    title: '<center class="dt-title">Delivery</center>',
                    filename: 'delivery'
                },
                {
                    extend: 'excelHtml5',
                    text: '<i class="fa fa-file-excel-o" aria-hidden="true"></i> Excel',
                    filename: 'delivery'
                },
                {extend: 'pageLength'}
            ],
            data: [],
            columns: []
        };

        var columns = [
            {data: {
                    _: function (d) {
                        var m = moment(d.outcome_month_trunc, 'YYYY-MM-DD');
                        return m.format('MMMM, YYYY');
                    },
                    sort: 'outcome_month_trunc'
                }, title: 'Period'},
            {data: 'upazilanameeng', title: 'Area'},
            {},
            {},
            {data: 'percentage', title: '%'}
        ];

        function getColumns(_params) {
            var _columns = columns.slice();
            if (_params.indicator == 1) {
                _columns[2] = {data: 'livebirth', title: 'Live birth'};
                _columns[3] = {data: 'skilled_attendant', title: 'Skilled attendant'}
            } else if (_params.indicator == 2) {
                _columns[2] = {data: 'delivered_women', title: 'Delivered women'};
                _columns[3] = {data: 'skilled_attendant', title: 'Skilled attendant'};
            } else if (_params.indicator == 3) {
                _columns[2] = {data: 'delivered_women', title: 'Delivered women'};
                _columns[3] = {data: 'facility', title: 'Delivered at facility'};
            }
            return _columns;
        }


        $('form').on('submit', function (e) {
            e.preventDefault();
            var _params = $.app.pairs($(this).serializeArray());
            var url = $(this).attr('action');
            if (!_params.zillaid) {
                $.toast('select district', 'error')();
                return false;
            }

            var xhr = $.post({url: url, data: _params});
            xhr.then(function (response) {
                var _data = JSON.parse(response);
                var _columns=getColumns(_params);
                var _extend = {columns: _columns, data: _data};
                var _options = $.extend({}, options, _extend);
                $('#details').show();
                $('#data-table').dt(_options);
                $.app.overrideDataTableBtn();
            }, console.log);
            return false;
            
        });

    });

</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle">Assistance during delivery</h1>
</section>
<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box box-primary full-screen">
                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <form action="delivery-assistance" method="post" id="showData">
                        <div class="row">
                            <div class="col-md-1 col-xs-2">
                                <label for="division">Division</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="divid" id="division"> </select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="zilla">District</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="zillaid" id="zilla"> 
                                    <option value="">- Select District -</option>
                                </select>
                            </div>

                            <!--                            <div class="col-md-1 col-xs-2">
                                                            <label for="upazila">Upazila</label>
                                                        </div>
                                                        <div class="col-md-2 col-xs-4">
                                                            <select class="form-control input-sm" name="upazilaid" id="upazila">
                                                                <option value="">- Select Upazila -</option>
                                                            </select>
                                                        </div>
                            
                                                        <div class="col-md-1 col-xs-2">
                                                            <label for="union">Union</label>
                                                        </div>
                                                        <div class="col-md-2 col-xs-4">
                                                            <select class="form-control input-sm" name="unionid" id="union">
                                                                <option value="">- Select Union -</option>
                                                            </select>
                                                        </div>-->
                            <div class="col-md-1 col-xs-2">
                                <label for="indicator">Indicator</label>
                            </div>
                            <div class="col-md-5 col-xs-10">
                                <select class="form-control" name="indicator" id="indicator" required>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <!--                            <div class="col-md-1 col-xs-2">
                                                            <label for="indicator">Indicator</label>
                                                        </div>
                                                        <div class="col-md-2 col-xs-4">
                                                            <select class="form-control" name="indicator" id="indicator" required>
                                                            </select>
                                                        </div>-->
<!--                            <div class="col-md-1  col-xs-2">
                                <label for="month">Month</label>
                            </div>
                            <div class="col-md-2  col-xs-4">
                                <select class="form-control input-sm" name="month" id="month">
                                </select>
                            </div>
                            <div class="col-md-1  col-xs-2">
                                <label for="year">Year</label>
                            </div>
                            <div class="col-md-2  col-xs-4">
                                <select class="form-control input-sm" name="year" id="year"> </select>
                            </div>                      <div class="col-md-1  col-xs-2">
                            </div>-->
                            <div class="col-md-2  col-xs-4 col-md-offset-10 col-xs-offset-8">
                                <button type="submit" class="btn btn-flat btn-primary btn-sm btn-block" autocomplete="off" >
                                    <i class="fa fa-table" aria-hidden="true"></i> Show data
                                </button>
                            </div>
                        </div>
                    </form>
                    <div id="dashboard"></div>
                    <div id="details">
                        <div class="col-md-12">
                            <h2 id="typeTitle"><span class="label label-default"></span></h2>
                            <div class="table-responsive- no-padding">
                                <table id="data-table" class="table table-bordered table-striped table-hover">
                                    <thead id="tableHeader">
                                    </thead>
                                    <tbody id="tableBody">
                                    </tbody>
                                    <tfoot id="tableFooter">
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        </span>
                    </div>
                </div>
            </div>
        </div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<link href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css"/>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.flash.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js" type="text/javascript"></script>
