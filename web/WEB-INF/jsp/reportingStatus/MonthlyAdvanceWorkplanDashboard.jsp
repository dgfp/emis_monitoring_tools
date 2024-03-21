<%-- 
    Document   : MonthlyAdvanceWorkplanDashboard
    Created on : Nov 28, 2018, 12:32:55 PM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<link href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css"/>
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
    <h1>Monthly Advance Workplan Dashboard</h1>
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
                    <form action="MonthlyAdvanceWorkplanDashboard" method="post" id="showData">
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
                                <label for="union">Provider </label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control" name="provtype" id="provtype" required>
                                    <option value="">- Select Type -</option>
                                </select>
                            </div>
                            <div class="col-md-1  col-xs-2">
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
                            </div>

                            <div class="col-md-1  col-xs-2">
                            </div>
                            <div class="col-md-2  col-xs-4">
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
        $.fn.dts = function (options) {
            return this.each(function (i, o) {
                if ($.fn.dataTable.isDataTable(o)) {
                    var dt = $(o).DataTable();
                    dt.destroy();
                    $(o).empty();
                }
                $(o).DataTable(options);
            });
        }
        $.MAWDashboard = $.MAWDashboard || {
            formData: null,
            init: function () {
                $.data = $.app.date();
                $.app.select.$year('select#year', range($.data.year, 2012, -1)).val($.data.year);
                $.app.select.$month('select#month').val($.data.month);
                $.MAWDashboard.events.bindEvent();
                $( ".full-screen" ).after($.app.getWatermark());
            },
            events: {
                bindEvent: function () {
                    $.MAWDashboard.events.viewStatus();
                    $.MAWDashboard.events.viewProviderList();
                    $.MAWDashboard.events.viewWorkplan();
                },
                viewStatus: function () {
                    $(document).off('submit', '#showData').on('submit', '#showData', function (e) {
                        e.preventDefault();
                        $("#details").css("display", "none");
                        var area = $.app.pairs('form');
                        if (area.divid == "") {
                            $.toast('Please select division', 'error')();
                            return false;
                        } else if (area.zillaid == "") {
                            $.toast('Please select district', 'error')();
                            return false;
                        }
                        $.MAWDashboard.ajax.statusLoader(area);
                    });
                },
                viewProviderList: function () {
                    $(document).off('click', '.small-box-footer').on('click', '.small-box-footer', function (e) {
                        $.MAWDashboard.ajax.getProviderList($(this).attr('id'));
                    });
                },
                viewWorkplan: function () {
                    $(document).off('click', '.workplan-view').on('click', '.workplan-view', function (e) {
                        $.MAWDashboard.ajax.getWorkplan($(this).data("info"));
                    });
                }
            },
            ajax: {
                //totalProvider = 0 ,waiting =1, approved= 2, disapproved = 3, resubmitted = 4;
                statusLoader: function (area) {
                    $('#dashboard').empty();
                    $.ajax({
                        url: "MonthlyAdvanceWorkplanDashboard?action=getStatus",
                        type: "POST",
                        data: {workplanArea: JSON.stringify(area)},
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success == true) {
                                $.MAWDashboard.formData = area;
                                var dashboard = "";
                                dashboard += $.MAWDashboard.workplanDashboard(0, response.data[0].total_provider); // totalProvider
                                dashboard += $.MAWDashboard.workplanDashboard(2, response.data[0].approved); // approved
                                dashboard += $.MAWDashboard.workplanDashboard(4, response.data[0].resubmitted); //resubmitted
                                dashboard += $.MAWDashboard.workplanDashboard(3, response.data[0].disapproved); //disapproved
                                dashboard += $.MAWDashboard.workplanDashboard(1, response.data[0].waiting); //waiting
                                $.app.removeWatermark();
                                $('#dashboard').html(dashboard);
                                $('#dashboard').slideDown("slow");
                            } else {
                                $( ".full-screen" ).after($.app.getWatermark());
                                toastr['error']("Error occured while user load");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                },
                getProviderList: function (type) {
                    $.ajax({
                        url: "MonthlyAdvanceWorkplanDashboard?action=getProviderList&type=" + type,
                        type: "POST",
                        data: {workplanArea: JSON.stringify($.MAWDashboard.formData)},
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success === true) {
                                console.log("json", response)
                                $("#details").css("display", "block");
                                $('#typeTitle span').html( type == "0" ? $.MAWDashboard.type[type]+" list" : $.MAWDashboard.type[type]+" provider list");
                                var columns = [
                                    {data: "providerid", title: 'Provider id'},
                                    {data: "provname", title: 'Provider name'},
//                                    {data: "mobileno", title: 'Mobile'},
                                    {data: function (d) {
                                            return "0" + d.mobileno;
                                    }, title: "Mobile"},
                                    {data: function (d) {
                                            var json = JSON.stringify({"zillaid": d.zillaid, "providerid": d.providerid, "provname":d.provname, "provtype": d.provtype, "year": d.work_plan_year, "month": d.work_plan_mon});
                                            return "<a class='btn btn-flat btn-primary btn-xs workplan-view' id='" + d.providerid + "' data-info='" + json + "'><b> View Workplan</b></a>";
                                        }, title: "Action"}
                                ]
                                !+type && columns.pop();

                                var options = {
                                    processing: true,
                                    data: response.data,
                                    columns: columns
                                };
                                $('#data-table').dts(options);
                            } else {
                                $("#details").css("display", "none");
                                toastr['error']("Error occured while login status load");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                },
                getWorkplan: function (json) {
                    $.ajax({
                        url: "MonthlyAdvanceWorkplanDashboard?action=getWorkplan",
                        type: "POST",
                        data: json,
//                    data: {
//                        zillaid : json.zillaid,
//                        providerid : json.zillaid,
//                        provtype : json.zillaid,
//                        year : json.zillaid,
//                        month json.zillaid:
//                    },
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response)
                            if (response.success == true) {
                                
                                var columns = [
                                        {data: function (d) {
                                            return convertE2B(convertDateFrontFormat(d.workplandate));
                                        }, title: "তারিখ"},
                                        {data: function (d) {
                                            return getDayByDate(d.workplandate);
                                        }, title: "বার"},
                                        {data: "activity", title: 'কর্মসূচি'}
                                    ];
                                var options = {
                                    "searching": false,
                                    "lengthChange": false,
                                    "paging": false,
                                    dom: 'Bfrtip',
                                    buttons: [
                                        {
                                            extend: 'print',
                                            text: ' <i class="fa fa-print" aria-hidden="true"></i> Print / PDF',
                                            title: '<center>মাসিক অগ্রিম কর্মসূচী <br/> <p>নাম:'+json.provname+'    মাস:'+$.app.monthBangla[json.month]+'    বছর:'+convertE2B(json.year)+'</p></center>',
                                            filename: 'pdf_monthly_advance_workplan'
                                        },
                                        {
                                            extend: 'excelHtml5',
                                            text: '<i class="fa fa-file-excel-o" aria-hidden="true"></i> Excel',
                                            filename: 'excel_monthly_advance_workplan'
                                        },
                                        {
                                            extend: 'csvHtml5',
                                            text: '<i class="fa fa-file-text-o" aria-hidden="true"></i> CSV',
                                            filename: 'csv_monthly_advance_workplan'
                                        }
                                    ],
                                    processing: true,
                                    data: response.data,
                                    columns: columns
                                };
                                $('#workplan-table').dts(options);
                                $('#viewWorkplan').modal('show');
                            } else {
                                toastr['error']("Error occured while user load");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                }
            },
            type: {
                0: "Total provider",
                1: "Waiting",
                2: "Approved",
                3: "Disapproved",
                4: "Resubmitted"
            },
            workplanDashboard: function (type, count) {
                //totalProvider = 0 ,waiting =1, approved= 2, disapproved = 3, resubmitted = 4;
                var color = "", icon = "", xs = "col-xs-6";
                switch (type) {
                    case 0:
                        color = "bg-blue";
                        icon = '<i class="fa fa-users" aria-hidden="true"></i>', xs = "col-xs-12 col-lg-offset-1";
                        break;
                    case 2:
                        color = "bg-green";
                        icon = '<i class="fa fa-check-square-o" aria-hidden="true"></i>';
                        break;
                    case 4:
                        color = "bg-yellow";
                        icon = '<i class="fa fa-history" aria-hidden="true"></i>';
                        break;
                    case 3:
                        color = "bg-red";
                        icon = '<i class="fa fa-window-close-o" aria-hidden="true"></i>';
                        break;
                    case 1:
                        color = "bg-aqua";
                        icon = '<i class="fa fa-clock-o" aria-hidden="true"></i>';
                        break;
                }
                return '<div class="col-lg-2 ' + xs + '">\
                           <div class="small-box ' + color + '">\
                             <div class="inner">\
                               <h3>' + icon + ' ' + count + '</h3>\
                               <p>' + $.MAWDashboard.type[type] + '</p>\
                             </div>\
                               <a href="#" id="' + type + '" class="small-box-footer">View details <i class="fa fa-arrow-circle-right"></i></a>\
                           </div>\
                         </div>';
            }
        };
        $.MAWDashboard.init();
    });
</script>
<div id="viewWorkplan" class="modal fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header label-primary">
                <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                <h4 class="modal-title"><b><i class="fa fa-calendar" aria-hidden="true"></i><span>    &nbsp; Monthly Advance Workplan</span></b></h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        <div class="table-responsive fixed" >
                            <table class="table table-bordered table-striped table-hover" id="workplan-table">
                                <thead>
                                </thead>
                                <tbody id="tableBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.flash.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js" type="text/javascript"></script>