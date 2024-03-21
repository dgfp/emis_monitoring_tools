<%-- 
    Document   : ReportGeoInformationUfpo
    Created on : Mar 3, 2020, 12:30:46 PM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    /*
    table content
    */
    /* Create a custom radio button */
    .checkmark {
        position: absolute;
        top: 0;
        left: 0;
        height: 18px;
        width: 18px;
        background-color: white;
        border-radius: 50%;
        border:1px solid #BEBEBE;
    }

    /* On mouse-over, add a grey background color */
    .customradio:hover input ~ .checkmark {
        background-color: transparent;
    }

    /* When the radio button is checked, add a blue background */
    .customradio input:checked ~ .checkmark {
        background-color: white;
        border:1px solid #222D32;
    }

    /* Create the indicator (the dot/circle - hidden when not checked) */
    .checkmark:after {
        content: "";
        position: absolute;
        display: none;
    }

    /* Show the indicator (dot/circle) when checked */
    .customradio input:checked ~ .checkmark:after {
        display: inline;
    }

    /* Style the indicator (dot/circle) */
    .customradio .checkmark:after {
        top: 2px;
        left: 2px;
        width: 12px;
        height: 12px;
        border-radius: 50%;
        background: #222D32;
    }
    table#data-table {
        table-layout:fixed;
        text-align: center;
    }
    table#data-table th{
        text-align: center;
    }
</style>

<%@include file="/WEB-INF/jspf/ReportGeoInformationMaster.jspf" %>
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box box-default full-screen">
                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <!--<div class="row">
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="division" id="division"> 
                                <option value="">- Select Division -</option>
                            </select>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="district" id="district">
                                <option value="">- Select District -</option>
                            </select>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="upazila" id="upazila" >
                                <option value="">- Select Upazila -</option>
                            </select>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="union" id="union" >
                                <option value="">- Select Union -</option>
                            </select>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="unit" id="unit" >
                                <option value="">- select Unit -</option>
                            </select>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm bold" autocomplete="off">
                                <i class="fa fa-bar-chart" aria-hidden="true"></i>&nbsp; Show Data
                            </button>
                        </div>
                    </div>-->
                    <form role="form">
                        <div class="row setup-content" id="step-reporting-upazila">
                            <div class="col-xs-12">
                                <div class="col-md-12">
                                    <h3 class="center">Reporting Upazila (UFPO)</h3>
                                    <div class="table-responsive- no-padding">
                                        <table id="data-table" class="table table-bordered">
                                            <thead id="tableHeader">
                                            </thead>
                                            <tbody id="tableBody">
                                            </tbody>
                                            <tfoot id="tableFooter">
                                            </tfoot>
                                        </table>
                                    </div>
                                    <button id="SubmitReportingUpazila" class="btn btn-primary nextBtn btn-md btn-flat pull-right bold" type="button" >Submit</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    $(function () {
        console.log(UTIL.getAssignTypeDropdown);
        $.ReportingGeo = {
            baseURL: "report-geo-info",
            init: function () {
                UTIL.request("report-geo-info?action=getReportingUpazila", {}, "POST").then(function (response) {
                    var columns = [
                        {data: "upazilanameeng", title: 'Upazila'},
                        {data: function (d, type, val, meta) {
                                return $.ReportingGeo.getUFPODropdown(d, response.ufpo, "ufpo_" + meta.row);
                            }, title: 'Assign to'},
                        {data: function (d) {
                                return UTIL.getAssignTypeDropdown(d);
                            }, title: 'Assign type'},
                    ];
                    var options = {
                        dom: 'Bfrtip',
                        paging: false,
                        "ordering": false,
                        searching: false,
                        info: false,
                        processing: true,
                        data: response.upazila,
                        columns: columns
                    };
                    $('#data-table').dt(options);
                });
            },
            getUFPODropdown: function (d, provider, elementName) {
                var option = "<option class='bold' value='0' selected>- Select Upazila Family Planning Officer -</option>";
                $.each(provider, function (i, o) {
                    var selected = d.providerid == o.providerid ? "selected" : "";
                    option += "<option value='" + o.providerid + "' " + selected + ">" + o.provname + "</option>";
                });
                return '<select name="' + elementName + '" class="form-control select2 ufpo" data-rowname="providerid" style="width: 100%;" tabindex="-1" aria-hidden="true">' + option + '</select>';
            },
            getAssignTypeDropdown: function (d) {
                var option = "<option class='bold' value='0' selected>-Select Assign Type-</option>";
                $.each([{id: 1, title: 'Main'}, {id: 2, title: 'Additional'}], function (i, o) {
                    var selected = d.assign_type == o.id ? "selected" : "";
                    option += "<option value='" + o.id + "' " + selected + ">" + o.title + "</option>";
                });
                return '<select class="form-control select2 ufpo" data-rowname="assign_type" style="width: 100%;" tabindex="-1" aria-hidden="true">' + option + '</select>';
            }
        };

        $.ReportingGeo.init();

        $('#data-table tbody').on('change', 'input, select', function () {
            var table = $('#data-table').DataTable();
            var row = table.row($(this).closest('tr'));
            var value = $(this).val();
            var rowName = $(this).data('rowname');
            var rowIndex = row.index();
            var data = table.row(rowIndex).data();
            data[rowName] = value;
//            table.row(rowIndex).data(data).invalidate();
            //console.log(value);
        });

        $('#SubmitReportingUpazila').on('click', function () {
            var table = $('#data-table').DataTable();
            var data = table.rows().data().toArray();
            var valid = UTIL.getDupesUFPO(data, 'providerid', 'assign_type');
            if (valid.length) {
                alert("Single UFPO assigned with multiple 'Main' charge.");
            } else {
                //var filledUFPO = [];
                var filledUFPO = data.filter(function (o) {
                    return o.providerid != null && o.assign_type != null;
                });
                filledUFPO = JSON.stringify(filledUFPO);
                UTIL.request("report-geo-info?action=insertUFPOAssignment", {data: filledUFPO}, "POST").then(function (resp) {
                    alert(resp.success == true ? "Added successfully" : "Can't set");
                    console.log(resp);
                });
            }
        });
    });
</script>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>