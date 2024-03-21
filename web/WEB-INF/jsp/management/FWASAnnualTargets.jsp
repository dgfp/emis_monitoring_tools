<%-- 
    Document   : FWASAnnualTargets
    Created on : Feb 26, 2021, 8:55:34 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<link href="resources/css/reportingStatus.css" rel="stylesheet" type="text/css"/>
<script src="resources/js/monthYearLoader.js" type="text/javascript"></script>
<style>
    .callout.callout-success, .callout.callout-danger, .callout.callout-warning {
        background-color: #fff !important;
        border-radius: 10px!important;
    }
    .callout.callout-success {
        border: 2px solid #00A65A!important;
        color: #00A65A!important;
        box-shadow: inset 0 0 5px #00A65A!important;
    }
    .callout.callout-danger {
        border: 3px solid #DD4B39!important;
        color: #DD4B39!important;
        box-shadow: inset 0 0 6px #DD4B39!important;
    }
    .callout.callout-warning {
        border: 3px solid #F39C12!important;
        color: #F39C12!important;
        box-shadow: inset 0 0 6px #F39C12!important;
    }
    .callout h4 {
        margin-top: 5px;
        font-weight: 600;
        margin-bottom: 7px;
    }
    select#provtype option:nth-child(1), select#provtype option:nth-child(4) {
        background: #d9edf7;
        padding-top:10px;
    }
    /*table tr:nth-child(odd) th {
        border-color: activecaption;
    }
    table tr:nth-child(odd) td {
        border-color: activecaption;
    }
    table tr:nth-child(even) td {
        border-color: activecaption;
    }*/
    .modal-table-header{
        font-size: 18px;
    }
    .no-internet{
        color: #dd4b39;
        margin: 9px;
        font-size: 180%;
        font-weight: bold;
    }
    td.progress{ position: relative; z-index: 0}
    td.progress .bar{ content: ""; display: block; position: absolute; z-index: -1; left: 0; top:5px; bottom: 5px; width:0%; background: red; transition: all .2s .5s ease-in }
    td.progress .bar, .box-legend .fa{ opacity: .5;}
    .form-control.is-invalid{ border: solid 1px #dd4b39 !important }


    .label {
        border-radius: 11px!important;
    }
    /*    #tableContent{
            display: none;
        }*/
    .btn-modal-specialarea-x:before{
        content: " - ";
        width: 24px;
        display: inline-block;
        font-weight:bold;
    }
    .mb0{ margin-bottom: 0 !important}
    .pb0{ padding-bottom: 0 !important}
    tr:last-child .btn-modal-specialarea-x:before{
        content: " + ";
    }
    .table-counter tbody 
    {
        counter-reset:row;
    }
    .table-counter tbody tr
    {
        counter-increment:row;
    }
    .table-counter tbody td:first-child:before
    {
        content:counter(row) !important;
    }
    .modal-specialarea .fa{width: 10px;text-align: center  }
    .modal-specialarea input.form-control{ width: 70px !important;}
    /*    .modal-specialarea  tr:first-child .btn-danger,
        .modal-specialarea  tr:last-child .btn-danger
        { display: none}*/
</style>
<script>
    loadMap = tabLoad = function () {};



    $(function () {
        $.getScript('resources/js/jquery.formParams.js');
        var config = {
            init: 0,
            divid: 50,
            zillaid: 99,
            upazilaid: 9,
            unionid: 57
        };
        var
                $division = $.app.select.$division('select#division'),
                $zilla = $('select#zilla'),
                $upazila = $('select#upazila'),
                $union = $('select#union'),
                $btn = $('#btn-data'), //$("button#btn-data"),
                init = config.init;
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
            $zilla.val() && $.app.select.$upazila($upazila, $zilla.val());
            //alert($zilla.val());
        }).on('Select', function (e, data) {
            !init && $(this).val(config.zillaid).change(); //&& $(this).prop('disabled', 1);
            $.app.cache.zilla = data;
        });
        $upazila.change(function (e) {
            $union.Select();
            $zilla.val() && $upazila.val() && $.app.select.$union($union, $zilla.val(), $upazila.val(), '', '');
        }).on('Select', function (e, data) {
            !init && $(this).val(config.upazilaid).change();
            $.app.cache.upazila = data;
        });
        $union.on('Select', function (e, data) {
            !init++ && $(this).val(config.unionid) && $.Target.ajax.showData($.app.pairs('#showData'));
            $.app.cache.union = data;
        });



        var $table = $('#data-table');
        var $select = $('.box-body:first select');
        function modalInfo() {
            var html = $.map($select, function (o) {
                var text = $(o).find('option:selected').html().replace(/\[\d+\]/, '');
                var item = '<li class="breadcrumb-item"><a href="#">' + text + '</a></li>'
                return item;
            });
            $('.modal-info').html(html.join('\n'));
        }

        $.Target = {
            baseURL: "fwas-annual-targets",
            data: null,
            modal: $('#modal-set-target'),
            init: function () {
                $.Target.events.bindEvent();
                $.each($.Target.methods, function (val, text) {
                    if (val < 8) {
                        $("#methodid").append($('<option></option>').val(val).html(text));
                    }
                });
            },
            events: {
                bindEvent: function () {
                    $.Target.events.showData();
                    $.Target.events.setTarget();
                    $.Target.events.updateTarget();
                },
                showData: function () {
                    $(document).off('submit', '#showData').on('submit', '#showData', function (e) {
                        e.preventDefault();
                        $.Target.ajax.showData($.app.pairs(this));
                    });
                },
                setTarget: function () {
                    $(document).off('click', '.set-target').on('click', '.set-target', function (e) {
                        console.log($(this).data("info"));
                        var rowData = $(this).data("info");
                        $("#viewUpdateStatus").html('');
                        $.Target.modal.modal('show');
                        modalInfo();
                        var tableBody = $("#modal-set-target-from> table> tbody");
                        tableBody.empty();
                        var content = '<tr>\
                                    <td>' + $.Target.methods[rowData.methodid] + '</td>\
                                    <td><input type="number" maxlength="5" size="3" name="target" class="form-control input-sm input-number error " value="' + rowData.target + '"></td>\
                                    <td style="center"><button type="submit" class="btn btn-flat btn-sm btn-success btn-set-target bold">&nbsp;&nbsp; <i class="fa fa-plus" aria-hidden="true"></i> &nbsp;&nbsp;</button></td>\
                                    </tr>\
                                    <input type="hidden" value="' + rowData.divid + '" name="divid">\
                                    <input type="hidden" value="' + rowData.zillaid + '" name="zillaid">\
                                    <input type="hidden" value="' + rowData.upazilaid + '" name="upazilaid">\
                                    <input type="hidden" value="' + rowData.unionid + '" name="unionid">\
                                    <input type="hidden" value="' + rowData.methodid + '" name="methodid">\
                                    <input type="hidden" value="' + rowData.year + '" name="year">';
                        tableBody.append(content);
                    });
                },
                updateTarget: function () {
                    $(document).off('submit', '#modal-set-target-from').on('submit', '#modal-set-target-from', function (e) {
                        e.preventDefault();
                        $.Target.ajax.setTarget($.app.pairs(this));
                    });
                }
            },
            ajax: {
                showData: function (data) {
                    console.log(data);
                    $.ajax({
                        url: $.Target.baseURL + "?action=getData",
                        type: "POST",
                        data: {data: JSON.stringify(data)},
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response);

                            $("#details").css("display", "block");

                            var columns = [
                                {data: null, title: '#'},
                                {data: "name_upazila_eng", title: 'Upazila'},
                                {data: "name_union_eng", title: 'Union'},
                                {data: function (d) {
                                        return $.Target.methods[d.method_id];
                                    }, title: "Method"},
                                {data: "target", title: 'Taget', className: 'text-right'},
                                {data: function (d) {
                                        var json = JSON.stringify({"zillaid": d.zillaid, "upazilaid": d.upazilaid, "unionid": d.reporting_unionid, "methodid": d.method_id, "year": d.year_number, "target": d.target});
                                        return "<a class='btn btn-flat btn-warning btn-xs set-target bold'  data-info='" + json + "'><i class='fa fa-cog' aria-hidden='true'></i> &nbsp;Set Target</a>";
                                    }, title: "&nbsp;&nbsp;&nbsp;&nbsp;Action&nbsp;&nbsp;&nbsp;&nbsp;", className: 'center'}
                            ];
                            var options = {
                                rowCallback: function (r, d, i, idx) {
                                    $('td', r).eq(0).html(idx + 1);
                                },
                                lengthMenu: [
                                    [10, 25, 50, 100, -1],
                                    ['10', '25', '50', '100', 'All']
                                ],
                                processing: true,
                                data: response,
                                columns: columns
                            };
                            $('#data-table').dt(options);
                            $.app.overrideDataTableBtn();
                            $("#transparentTextForBlank").css("display", "none");

                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                },
                setTarget: function (data) {
                    data.divid = 0;
                    console.log(data);
                    $.ajax({
                        url: $.Target.baseURL + "?action=setTarget",
                        type: "POST",
                        data: {data: JSON.stringify(data)},
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response);
                            $("#viewUpdateStatus").html('<div class="callout callout-'+response.success+'" style="margin-bottom: 0!important;"><h4 class="center bold" id="viewStatusText">'+response.message+'</h4></div>');
                            $.Target.ajax.showData($.app.pairs('#showData'));
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                }
            },
            methods: {
                'null': '-',
                1: 'Pill',
                2: 'Condom',
                3: 'Injectable',
                4: 'IUD',
                5: 'Implant',
                6: 'Tubectomy',
                7: 'Discectomy',
                8: '-'
            }
        };
        $.Target.init();



    });




</script>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>Annual Targets</h1>
</section>
<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <div class="row"  id="areaPanel">
        <div class="col-md-12">
            <div class="box box-primary full-screen">
                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>

                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <form action="fwas-annual-targets" method="post" id="showData">
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

                            <div class="col-md-1 col-xs-2">
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
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-1 col-xs-2">
                                <label for="zilla">Method</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="methodid" id="methodid"> 
                                    <option value="0">All</option>
                                </select>
                            </div>
                            <div class="col-md-1 col-xs-2">
                                <label for="zilla">Year</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="year" id="year"> 
                                </select>
                            </div>
                            <div class="col-md-2 col-xs-4 col-md-offset-1 col-xs-offset-8">        
                                <button type="submit" id="btn-data" class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                    <i class="fa fa-area-chart" aria-hidden="true"></i> &nbsp;Show data
                                </button>
                            </div>
                        </div>
                    </form>

                    <span id="details">
                        <div class="col-md-12">
                            <h2 id="typeTitle"><span class="label label-default"></span></h2>
                            <div class="table-responsive no-padding">
                                <table id="data-table" class="table table-striped table-hover table-bordered">
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

    <!--Transparent Text For Blank Space-->
    <section class="content-header" id="transparentTextForBlank" style="display: block;">
        <center class="emis_hologram">eMIS</center>
    </section>

    <div class="row row-details hidden" id="tableContent">
        <div class="col-xs-12">
            <div class="box box-primary">
                <!--  Table top -->
                <div class="box-header" style="padding-bottom:0">
                    <div class="table-responsive-" style="margin-bottom:0">
                        <table class="table table-bordered table-striped table-hover" id="summary-upazila" style="margin-bottom:0">
                            <thead></thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
                <!-- table -->
                <div class="box-body">
                    <div class="table-responsive-" style="margin-bottom:0">
                        <table class="table table-bordered table-striped table-hover" id="data-table" style="width:100%">
                            <thead class="bg-success"></thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>
</section>




<div class="modal fade modal-set-target" id="modal-set-target" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close bold" data-dismiss="modal">&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold">Set Target</h4>
            </div>
            <div class="modal-body">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb modal-info"></ol>
                </nav>
                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        <div id="viewUpdateStatus" style="display: block;"></div>
                    </div>
                </div>
                <form method="post" id="modal-set-target-from" action="fwas-annual-targets?action=setTarget" class="form-horizontal">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Method</th>
                                <th style="width: 33%">Target</th>
                                <th style="center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal"><i class="fa fa-window-close-o" aria-hidden="true"></i>&nbsp;Close</button>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
