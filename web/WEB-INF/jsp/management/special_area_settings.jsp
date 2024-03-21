<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<style>
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
            upazilaid: 63,
            unionid: 43
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
            !init++ && $(this).val(config.unionid) && $btn.click();
            $.app.cache.union = data;
        });
        ////////////////////////////////
        //data table / statistics here//
        ////////////////////////////////

        window.stats = {
            data: [],
            toggleBlock: function (flag) {
                //flag = 0, 1, 2
                //flags={0:hide all,1: show data,2:show summary,3: show all];
                flag = +flag;
                var ctx = ['.row-details', '.row-summary'],
                        fun = ['addClass', 'removeClass'],
                        flags = [+!!(1 & flag), +!!(2 & flag)],
                        _call = function (i, o) {
                            var id = flags[i], fn = fun[id];
                            console.log(id, fn);
                            $(ctx[i])[fn]('hidden');
                        };
                $(ctx).each(_call);
                $.app.$emis[flag ? 'hide' : 'show']();
                return this;
            },
            reload: function (json) {
                this.data = json;
                render(json);
            },
            post: function (data, actionType) {
                actionType = actionType || 'get';
                var action = $.camelCase([actionType, 'specialarea'].join('-'));
                var options = {url: 'Special_Area_Settings?action=' + action, data: data, type: 'POST'};
                console.log('post: options ', options);
                return $.ajax(options);
            }
        };
        window.options = {
            data: [],
            fixedHeader: {
                header: true
            },
            dom: "<'row'<'col-sm-6'i><'col-sm-6'f>><'row'<'col-sm-12'tr>><'row'<'col-sm-5'i><'col-sm-7'p>>",
            bDestroy: true,
            //searching: false,
            paging: false,
            columnDefs: [
                {
                    //orderable: false,
                    //searchable: false,
                    targets: '_all',
                    defaultContent: '-'
                }
            ],

            rowCallback: function (r, d, i, idx) {
                //console.log('fnRowCallback', this, r, d, i, idx);
                $('td', r).eq(0).html(idx + 1);
            },
            columns: [
                {data: null},
                {data: function (row) {
                        return "[" + row.mouzaid + "] " + row.mouzanameeng;
                    }, title: 'Mouza'},
                {data: function (row) {
                        return "[" + row.villageid + "] " + row.villagenameeng;
                    }, title: 'Village'},
                {data: 'specialarea_name', title: 'Spacial Area'},
                {data: null, title: 'Action', defaultContent: "<button class='btn btn-flat btn-xs btn-info btn-specialarea-settings bold''><i class='fa fa-cog' aria-hidden=true></i> Settings</button>"}
            ]
        };
        var $table = $('#data-table');
        var $select = $('.box-body:first select');
        var $modal = $('#modal-specialarea');
        function modalInfo() {
            var html = $.map($select, function (o) {
                var text = $(o).find('option:selected').html().replace(/\[\d+\]/, '');
                var item = '<li class="breadcrumb-item"><a href="#">' + text + '</a></li>'
                return item;
            });
            $('.modal-info').html(html.join('\n'));
        }
        function render(data) {
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



        $('body').on('click', '#btn-data,.btn-data', function (e, data) {
            console.log('showdata', e.data);
            var $btn = $(e.currentTarget);
            var data = e.data ? e.data : $.app.pairs($select);
            if (!data.zillaid) {
                return $.toast("Please select zilla first", "error")();

            }
            if (!data.upazilaid) {
                return $.toast("Please select upazila first", "error")();

            }
            if (!data.unionid) {
                return $.toast("Please select union first", "error")();
            }

            modalInfo();
            console.log('details/options', data);
            var options = {
                url: "Special_Area_Settings?action=showdata",
                data: data,
                type: 'POST',
                success: function (result) {
                    var json = JSON.parse(result);
                    $btn.button('reset');
                    if (!json.length) {
                        $.toast('No data found', 'error')();
                    }
                    stats.toggleBlock(1);
                    stats.reload(json);
//                    Specialarea.post(data, 'type').done(function (data) {
//                        //$(Specialarea.template).find('select.input-specialarea').Select(data);
//                    });
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    stats.toggleBlock();
                    $btn.button('reset');
                    $.toast("Request can't be processed", 'error')();
                }
            };
            $btn.button('loading');
            stats.toggleBlock();
            Pace.track(function () {
                $.ajax(options);
            });
        });

        $modal.on('shown.bs.modal', function (e) {
            $modal.find('table').empty();
            modalLoad(e.relatedTarget);
        });

        $modal.on('hidden.bs.modal', function (e) {
            $modal.find('table').empty();
            var data = $modal.data('relatedTarget');
            var eData = [$.app.pluck(data, ['divid', 'zillaid', 'upazilaid', 'unionid'])];
            $('#btn-data').trigger('click', eData);
            console.log(e.type, eData);
        });


        $table.on('click', 'tbody tr button.btn-specialarea-settings', function (e) {
            var relatedTarget = $.table.row($(e.currentTarget).closest('tr')).data();
            var label = [' (' + relatedTarget.mouzanameeng + ')', '-', relatedTarget.villagenameeng].join(' ');
            $modal.find('.modal-label').html(label);
            $modal.modal('show', relatedTarget).data('relatedTarget', relatedTarget);
        });

        var optionsModalTable = {
            paging: false,
            searching: false,
            info: false,
            destroy: true,
            data: [],
            columnDefs: [{
                    targets: "_all",
                    orderable: false
                }],
            columns: [
                {data: 'specialarea_name', title: 'Special area'},
                {data: function (row) {
                        var value = (row.barrack || '');
                        //console.log('barrack',row.barrack,value);
                        var input = '<input  type="number" min=0 name="barrack" class="form-control input-sm input-number ' + (value ? '' : 'error') + ' " value="' + value + '">';
                        return input;
                    }, title: '# of Barrack'},
                {data: function (row) {
                        var getBtn = function (status) {
                            var types = {
                                set: ['info', 'set', 'plus'],
                                del: ['danger', 'del', 'remove'],
                                chk: ['success', 'chk', 'check']
                            };
                            var type = types[status];
                            return '<button  type="button"  class="btn btn-flat btn-xs btn-' + type[0] + ' btn-specialarea-' + type[1] + '"><i class="fa fa-' + type[2] + '" aria-hidden="true"></i></button>'
                        };
                        var btn = row.has_specialarea ? getBtn('chk') + getBtn('del') : getBtn('set');
                        return btn;
                    }
                    , title: 'Action'
                }
            ]

        };

        function modalList(data) {
            var _extend = {data: data};
            var _options = $.extend({}, optionsModalTable, _extend);
            $modal.find('table').dt(_options);
        }

        function modalLoad(req) {
            console.log('request', req, null);
            stats.post(req, 'get').done(function (res) {
                res = $.parseJSON(res);
                modalList(res);
                console.log('response', req, res);
            });
        }



        $modal.on('input', ':input', function (e) {

                    var $it = $(e.currentTarget);
                    var tr = $it.closest('tr');
                    var dt = $modal.find('table').DataTable();
                    var row = dt.row(tr).data();
                    var name = $it.attr('name');
                    var value = $it.val();
                    value = value.replace(/(?!^\-)[^\d]/gi, '');
                    row[name] = +value;
                    var fnClass = value ? 'removeClass' : 'addClass';
                    $it[fnClass]('error');
                    //dt.rows(tr).invalidate().draw(false);
                    console.log(e.type, row);

          }).on('click', '.btn', function (e) {
            var $it = $(e.currentTarget);
            var tr = $it.closest('tr');
            var dt = $modal.find('table').DataTable();
            var row = dt.row(tr).data();
            var self = stats;
            console.log(row);

            if ($it.is('.btn-specialarea-set') || $it.is('.btn-specialarea-chk')) {
                if (!(row.specialarea && row.barrack)) {
                    return $.toast('Ooops! Nothing to set', 'error')();
                }

                self.post(row, 'set').then(function (res) {
                    //res = $.parseJSON(res);
                    //$.toast(res.message, 'success')();
                    modalLoad(row);
                }, function (e) {
                    console.log('error set', e);
                });
            }

            if ($it.is('.btn-specialarea-del')) {
                if (!(row.specialarea)) {
                    $.toast('Ooops! Nothing to delete', 'error')();
                    return;
                }

                self.post(row, 'del').then(function (res) {
                    //res = $.parseJSON(res);
                    //$.toast(res.message, 'warning')();
                    modalLoad(row);
                }, function (e) {
                    console.log('error del', e);
                });
            }
        });


    });




</script>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>Special Area Settings</h1>
</section>
<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <div class="row">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
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
                    </div><br>

                    <div class="row">
                        <div class="col-md-2 col-xs-3 col-md-offset-10 col-xs-offset-9">        
                            <button type="button" id="btn-data" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block" autocomplete="off" >
                                <i class="fa fa-table" aria-hidden="true"></i> Show data
                            </button>
                        </div>

                    </div>
                    <br>
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
<div class="modal fade modal-specialarea" id="modal-specialarea" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header label-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Special area for <b class="modal-label"></b></h4>
            </div>
            <div class="modal-body">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb modal-info"></ol>
                </nav>
                <form method="post" id="modal-specialarea" action="Special_Area_Settings?action=updatedata" class="form-horizontal" role="form"  autocomplete="off">
                    <table class="table table-striped">

                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
