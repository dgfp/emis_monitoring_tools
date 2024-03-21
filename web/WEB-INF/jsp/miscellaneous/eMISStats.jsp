<%-- 
    Document   : eMISstats
    Created on : Jul 21, 2019, 4:19:20 PM
    Author     : Rahen
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<link href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css"/>
<style>
    #areaPanel [class*="col"] { margin-bottom: 10px; }
    #areaPanel .box {margin-bottom:5px}
    .info-box-md-container .info-box{ min-height: 56px}
    .info-box-md-container .info-box-icon{ width: 56px; height: 56px; line-height: 56px; font-size: 32px;}
    .info-box-md-container .info-box-content{ margin-left: 56px;}
    .box-body {
        padding: 10px!important;
        padding-bottom: 0px!important;
    }
    .label {
        border-radius: 11px!important;
    }
    label[for=provtypeWise]{ background: red; color: white; cursor: pointer}
    label.checked[for=provtypeWise]{ background: green}
    #provtypeWise+#provtype{ display: none}
    #provtypeWise:checked+#provtype{ display: block}

</style>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>eMIS <small>Statistics</small></h1>
</section
<!-- Main content -->
<section class="content">
    <div class="row"  id="areaPanel">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-body" id="a">
                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <label for="report_type">Report</label>
                        </div>
                        <div class="col-md-4 col-xs-10">
                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="report_type" id="report_type"><option value="">- Select report -</option></select>
                        </div>
                        <div class="col-md-1 col-xs-2" style="padding-right: 0px; padding-left: 0px; width: 3.1%;">
                            <label>From</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="startDate" id="startDate" readonly="readonly" style="background-color: rgb(255, 255, 255);">
                        </div>
                        <div class="col-md-1 col-xs-2" style="padding-right: 0px; padding-left: 0px; width: 1.3%;">
                            <label>To</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="endDate" id="endDate" readonly="readonly" style="background-color: rgb(255, 255, 255);">
                        </div>
                        <div class="col-md-2 col-xs-3">        
                            <button id="report_view" type="button" id="btn-data" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                <i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; Show data
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="box box-primary full-screen" id="tableView">
        <div class="box-body">
            <!--Data Table-->               
            <div class="col-ld-12" id="">
                <div class="table-responsive fixed" >
                    <div id="dvData">
                        <table class="table table-bordered table-striped table-hover" id="data-table">

                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script>
    $(function () {

        var stats = [
            {id: 'loginuser', text: 'Users with access to monitoring tools', columns: ["division", "zilla", "typename", "directorate", "total"]}
            , {id: 'providerdb', text: 'No of users of eMIS in different districts', columns: ["division", "zilla", "typename", "directorate", "total"]}
            , {id: 'stats', text: 'Data relating to population register and services provided', columns: ["division", "zilla", "household", "member", "elco", "pregwomen", "ancservice", "delivery", "newborn", "pncservicechild", "pncservicemother", "death", "gpservice"]}
            , {id: 'nrc', text: 'Non Registered Clients', columns: ["division", "zilla", "member", "nrc"]}
            , {id: 'unassigned_healthid', text: 'Unassigned Health ID', columns: ["division", "zilla", "member", "unassigned_healthid"]}
        ];

        var $report_type = $('#report_type').Select(stats, {placeholder: null, text: function (o) {
                return this.text;
            }});
        var $report_view = $('#report_view');
        var $report_table = $('#data-table');

        var getOptions = function (report_item) {
            var today = (new Date()).toISOString().split('T')[0];
            var title = report_item.text;
            var filename = [report_item.id, today].join('-');
            var defaults = {
                lengthMenu: [
                    [10, 25, 50, 100, -1],
                    ['10', '25', '50', '100', 'All']
                ],
                dom: 'Bfrtip',
                buttons: [
                    {
                        extend: 'print',
                        text: ' <i class="fa fa-print" aria-hidden="true"></i> Print / PDF',
                        title: title,
                        filename: filename
                    },
                    {
                        extend: 'excelHtml5',
                        text: '<i class="fa fa-file-excel-o" aria-hidden="true"></i> Excel',
                        title: title,
                        filename: filename
                    },
                    {extend: 'pageLength'}
                ]
//                    processing: true
            };
            return defaults;
        }

        function getStat(report_type) {
            var report_item = stats.find(function (o) {
                return o.id === report_type;
            }) || {};
            var columns = $.map(report_item.columns, function (o, i) {
                return {data: o, title: o};
            });
            var xhr = $.ajax({url: 'eMISStats', type: 'POST', data: {action: "showdata", report_type: report_type, startDate: $("#startDate").val(), endDate: $("#endDate").val()}});
            xhr.done(function (response) {
                var data = $.parseJSON(response);
                var _options = $.extend({}, getOptions(report_item), {data: data, columns: columns});
                console.log(_options);
                $report_table.dt(_options);
                //$report_table.DataTable().buttons().container().insertBefore("#"+$report_table.attr('id')+'_filter');
                $.app.overrideDataTableBtn();
            });

        }

        $report_view.on('click', function () {
            var report_type = $report_type.val();
            getStat(report_type);
            return false;
        }).trigger('click');

    })
</script>

<script src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.flash.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js" type="text/javascript"></script>