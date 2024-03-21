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
</style>
<script>
    loadMap = tabLoad = function () {};


    $(function () {
        $.getScript('resources/js/jquery.formParams.js');
        var config = {
            init: 1,
            divid: 30,
            zillaid: 93,
            upazilaid: 66,
            unionid: 63
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
                {data: "division",title: "Division"},
                {data: "zilla",title: "Zilla"},
                {data: 'member',title: "Member"},
                {data: 'nrc', title: "NRC"},
            ]
        };
        var $table = $('#data-table');
        var $select = $('.box-body:first select');
        var $modal = $('#modal-sdp');
        function modalInfo() {
//            var html = $.map($select, function (o) {
//                var text = $(o).find('option:selected').html().replace(/\[\d+\]/, '');
//                var item = '<li class="breadcrumb-item"><a href="#">' + text + '</a></li>'
//                return item;
//            });
//            $('.modal-info').html(html.join('\n'));
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
            console.log('showdata',e.data);
            var $btn = $(e.target);
            var data = e.data? e.data: $.app.pairs($select);
//            if (!data.zillaid) {
//                return $.toast("Please select zilla first", "error")();
//
//            }
//            if (!data.upazilaid) {
//                return $.toast("Please select upazila first", "error")();
//
//            }
//            if (!data.unionid) {
//                return $.toast("Please select union first", "error")();
//            }

            modalInfo();
            console.log('details/options', data);
            var options = {
                url: "NRC?action=showdata",
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


        $table.on('click', 'tbody tr button', function (e) {
            var relatedTarget = $.table.row($(this).parents('tr')).data();
            var unit = $.unit(relatedTarget.unit, 0);
            var label = [relatedTarget.provname, ' (' + relatedTarget.providerid + ')', '-', unit].join(' ');
            $modal.find('.modal-label').html(label);
            $modal.modal('show', relatedTarget).data('relatedTarget', relatedTarget);

        });

        $modal.on('shown.bs.modal', function (e) {
            var data = e.relatedTarget;
            var $form = $modal.find('form');
            $form.find('[name=reset]').click();
            $form.formParams(data);
            $form.find('[name=is_additional_charge]').prop('checked',+data.is_additional_charge);
        });

        $modal.on('submit', 'form', function (e) {
            var $form=$(e.target);
            var action=$form.attr('action');
            var method=$form.attr('method')||'GET';
            var relatedTarget = $modal.data('relatedTarget');
            var formData =$form.formParams();
            formData.is_additional_charge=finiteFilter(formData.is_additional_charge);
            formData.start_date = $.app.isoDate(formData.start_date);
            formData.end_date = $.app.isoDate(formData.end_date);
            
            var data = $.extend({}, relatedTarget, formData);
            
            
            console.log('submit data',data,formData);
            if($form.find('.is-invalid').length){
                $.toast('Invalid parameter','error')();
                return false;
            }
            var xhr=$.ajax({url:action,type:method,data:data});
            xhr.done(function(d){
                if(d) { 
                    $modal.modal('hide'); 
                    var eData=[$.app.pluck(data,['divid','zillaid','upazilaid','unionid'])];
                    $('#btn-data').trigger('click',eData);
                    $.toast('Successfully updated','success')(); 
                }
                else{
                   $.toast('Something went wrong','error')(); 
                }
            });
            return false;
        });

        $modal.find('form').on('input', ':input[pattern]', function (e) {
            var $it = $(e.target),
                    value = $it.val().toUpperCase(),
                    pattern = $it.attr('pattern'),
                    reAll = new RegExp(pattern),
                    chars = pattern.match(/[A-Z]/);
            if (chars) {
                if(value[0]!=chars[0]){
                    value = chars[0] + value;
                }
            }
            
            value = value.replace(/(?!^)[^\d]/gi, '').substring(0, 4);

            if (reAll.test(value)) {
                $it.removeClass('is-invalid');
            } else {
                $it.addClass('is-invalid');
            }
            //console.log(value,pattern,regex,regex.test(value));
            $it.val(value);
        });

    }
    );

</script>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>Non registered client (NRC)</h1>
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
<div class="modal fade modal-sdp" id="modal-sdp" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header label-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title"><i class="fa fa-edit" aria-hidden="true"></i> SDP Mapping for <b class="modal-label"></b></h4>
            </div>
            <div class="modal-body">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb modal-info"></ol>
                </nav>
                <form method="post" id="modal-sdp-form" action="NRC?action=updatedata" class="form-horizontal" role="form"  autocomplete="off">
                    <!--                    <input type="hidden" name="zillaid">
                                        <input type="hidden" name="upazilaid">
                                        <input type="hidden" name="unionid">
                                        <input type="hidden" name="unit">
                                        <input type="hidden" name="providerid">
                                        <input type="hidden" name="provtype">-->
                    <table class="table table-striped">
                        <tbody class="text-right">
                            <tr>
                                <td><label>Facility Code <span class="star">*</span></label></td>
                                <td><input type="text" class="form-control" name="facility_code" pattern="^T\d{3,3}$" placeholder="e.g. T001" required minlength="4" maxlength="4"></td>
                            </tr>

                            <tr>
                                <td><label>SDP Code <span class="star">*</span></label></td>
                                <td><input type="text" class="form-control" name="sdp_code" pattern="^F\d{3,3}$" placeholder="e.g. F002" required minlength="4" maxlength="4"></td>
                            </tr>

                            <tr>
                                <td><label>In addition charge</td>
                                <td>
                                    <div class="material-switch pull-left text-left">
                                        <input id="is_additional_charge" name="is_additional_charge" type="checkbox" value="1">
                                        <label for="is_additional_charge" class="label-warning"></label>
                                    </div>

                                </td>
                            </tr>     
                            <tr>
                                <td><label>Start Date <span class="star">*</span></label></td>
                                <td><input type="text" class="input form-control input-sm datePickerChooseAll" placeholder="mm/dd/yyyy" name="start_date"  id="start_date" required /></td>
                            </tr>
                            <tr>
                                <td><label>End Date</label> <span class="star"></span></td>
                                <td><input type="text" class="input form-control input-sm datePickerChooseAll" placeholder="mm/dd/yyyy" name="end_date" id="end_date" /></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td class="pull-left"><button type="submit" class="btn btn-flat btn-primary btn-md" value="Update"><b><i class="fa fa-save" aria-hidden="true"></i> Update</b></button> &nbsp; <button type="reset" name="reset" class="btn btn-flat btn-default btn-md" ><b><i class="fa fa-eraser" aria-hidden="true"></i> Reset</b></button></td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
