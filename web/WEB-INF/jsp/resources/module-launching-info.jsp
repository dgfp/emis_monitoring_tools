<%-- 
    Document   : module-launching-info
    Created on : Oct 19, 2017, 12:04:50 PM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<link href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css"/>
<style>
</style>
<script>
    $(function () {
        var provTypes = $.app.getProvTypes(0);
        var $provType = $('select#provtype').Select(provTypes, {placeholder: null, value: 3}),
                $division = $.app.select.$division('select#division'),
                $zilla = $('select#zilla'),
                $upazila = $('select#upazila'),
                $union = $('select#union'),
                $btn = $('#btn-summary'), //$("button#btn-data"),
                init = 1;
        $provType.on('Select', function (e, data) {
            console.log(data);
            $.app.cache.provtype = data;
        });
        
        $division.change(function (e) {
            $zilla.Select();
            $upazila.Select();
            $union.Select();
            $division.val() && $.app.select.$zilla($zilla, $division.val());
        }).on('Select', function (e, data) {
            !init && $(this).val(30).change(); // && $(this).prop('disabled', 1);
            $.app.cache.division = data;
        });
        $zilla.change(function (e) {
            $upazila.Select();
            $union.Select();
            $zilla.val() && $.app.select.$upazila($upazila, $zilla.val(), "", "All");
            //alert($zilla.val());
        }).on('Select', function (e, data) {
            !init && $(this).val(93).change(); //&& $(this).prop('disabled', 1);
            $.app.cache.zilla = data;
        });
        $upazila.change(function (e) {
            $union.Select();
            $zilla.val() && $upazila.val() && $.app.select.$union($union, $zilla.val(), $upazila.val(), '', 'All');
        }).on('Select', function (e, data) {
            //!init && $(this).val(66).change();
            !init++ && $(this).val('') && $btn.click();
            $.app.cache.upazila = data;
        });
        $union.on('Select', function (e, data) {
            //!init++ && $(this).val('') && $btn.click();
            $.app.cache.union = data;
        });

    });
</script>
<section class="content-header">
    <h1> Training information</h1>
</section>
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
                    <form action="/" method="post" id="showData">
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
                                <label for="union"></label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <button type="submit" class="btn btn-flat btn-primary btn-sm btn-block" autocomplete="off" >
                                    <i class="fa fa-table" aria-hidden="true"></i> Show data
                                </button>
                            </div>
                        </div>
                    </form>
                    <span id="dashboard">
                    </span>
                    <span id="details">
                        <div class="col-md-10 col-md-offset-1">
                            <h2 id="typeTitle"><span class="label label-default"></span></h2>
                            <div class="table-responsive1 no-padding">
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
<script>
    $(function () {
        $.MAWDashboard = $.MAWDashboard || {
            formData: null,
            init: function () {
                $.MAWDashboard.events.bindEvent();
                $( ".full-screen" ).after($.app.getWatermark());
            },
            events: {
                bindEvent: function () {
                    $.MAWDashboard.events.demo();
                },
                demo: function () {
                    $(document).off('submit', '#showData').on('submit', '#showData', function (e) {
                        $.MAWDashboard.ajax.demo();
                    });
                },
            },
            ajax: {
                demo: function () {
                    $.ajax({
                        url: "demo?action=getStatus",
                        type: "POST",
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success == true) {
                            } else {
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                }
            }
        };
        $.MAWDashboard.init();
    });
</script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.flash.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js" type="text/javascript"></script>
