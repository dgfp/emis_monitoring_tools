<%-- 
    Document   : ReportGeoInformationUnion
    Created on : Mar 10, 2020, 10:35:28 AM
    Author     : Nibras
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/ReportGeoInformationMaster.jspf" %>
<script src="resources/js/area_dropdown_control_reporting_union.js"></script>
<style>
    .display{
        display: none;
    }
</style>
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
                    <form role="form" id="reportingunionfpi">
                        <div class="row setup-content" id="step-reporting-union">
                            <div class="col-xs-12">
                                <div class="col-md-12">
                                    <h3 class="center">Reporting Union (FPI)</h3>
                                    <div class="row">
                                        <div class="col-md-2 col-xs-4">
                                            <label>Division</label>
                                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="division" id="division">
                                                <option value="">- Select Division -</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2 col-xs-4">
                                            <label>District</label>
                                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="zillaid" id="district">
                                                <option value="">- Select District -</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2 col-xs-4">
                                            <label>Upazila</label>
                                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="upazilaid" id="upazila" >
                                                <option value="">- Select Upazila -</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2 col-xs-4">
                                            <label>Reporting union</label>
                                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="unionid" id="union" >
                                                <option value="">- Select Union -</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2 col-xs-4 display">
                                            <label>Union name (Bangla)</label>
                                            <input type="text" name="unionname" id="unionname" class="form-control">
                                        </div>
                                        <div class="col-md-2 col-xs-4 display">
                                            <label>Union name (English)</label>
                                            <input type="text" name="unionnameeng" id="unionnameeng" class="form-control">
                                        </div>
                                        <div class="col-md-2 col-xs-4">
                                            <label>Union (BBS)</label>
                                            <div id="multi-select-union-container">
                                                <select class="form-control" id="multi-select-union1" multiple="multiple" name="unionids">
                                                </select>
                                            </div>
                                            <!--                                            <select class="form-control" id="multi-select-union" multiple="multiple" name="unions">
                                                                                            <option value="13">Union 1</option>
                                                                                            <option value="15">Union 2</option>
                                                                                            <option value="23">Union 3</option>
                                                                                            <option value="31">Union 4</option>
                                                                                            <option value="34">Union 5</option>
                                                                                        </select>-->
                                        </div>
                                        <div class="col-md-2 col-xs-4">
                                            <label>Assign to (FPI)</label>
                                            <select class="form-control" tabindex="-1" aria-hidden="true" name="providerid" id="providerid" >
                                                <option value="">- Select FPI -</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2 col-xs-4">
                                            <label>Assign Type</label>
                                            <div id="geo_assign_type_container">

                                            </div>
                                        </div>
                                        <div class="col-md-2 col-xs-4">
                                            <label>&nbsp;</label>
                                            <button type="button" id="submitButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-success btn-block btn-sm bold" autocomplete="off">
                                                <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Add Union
                                            </button>
                                        </div>
                                        <div class="col-md-2 col-xs-4">
                                            <label>&nbsp;</label>
                                            <button type="button" id="viewButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm bold" autocomplete="off">
                                                <i class="fa fa-bar-chart" aria-hidden="true"></i>&nbsp; View Union 
                                            </button>
                                        </div>
                                    </div><br/>
                                    <div class="row">
                                        <div class="table-responsive- no-padding">
                                            <table id="data-table" class="table table-bordered table-striped">
                                                <thead id="tableHeader">
                                                </thead>
                                                <tbody id="tableBody">
                                                </tbody>
                                                <tfoot id="tableFooter">
                                                </tfoot>
                                                <!--                                                <thead id="tableHeader">
                                                                                                    <tr>
                                                                                                        <th>District</th>
                                                                                                        <th>Upazila</th>
                                                                                                        <th>Union name (BAN)</th>
                                                                                                        <th>Union name (ENG)</th>
                                                                                                        <th>Assign to</th>
                                                                                                        <th>Actions</th>
                                                                                                    </tr>
                                                                                                </thead>
                                                                                                <tbody id="tableBody">
                                                                                                    <tr>
                                                                                                        <td>Natore</td>
                                                                                                        <td>Lalpur</td>
                                                                                                        <td>ইউনিয়ন ১</td>
                                                                                                        <td>Union 1</td>
                                                                                                        <td>FPI 1</td>
                                                                                                        <td><button class="btn btn-flat btn-primary btn-xs bold"> Details</button> <button class="btn btn-flat btn-warning btn-xs bold"> Update</button></td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>Natore</td>
                                                                                                        <td>Lalpur</td>
                                                                                                        <td>ইউনিয়ন ২</td>
                                                                                                        <td>Union 2</td>
                                                                                                        <td>FPI 2</td>
                                                                                                        <td><button class="btn btn-flat btn-primary btn-xs bold"> Details</button> <button class="btn btn-flat btn-warning btn-xs bold"> Update</button></td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>Natore</td>
                                                                                                        <td>Lalpur</td>
                                                                                                        <td>ইউনিয়ন ৩</td>
                                                                                                        <td>Union 3</td>
                                                                                                        <td>FPI 3</td>
                                                                                                        <td><button class="btn btn-flat btn-primary btn-xs bold"> Details</button> <button class="btn btn-flat btn-warning btn-xs bold"> Update</button></td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>Natore</td>
                                                                                                        <td>Lalpur</td>
                                                                                                        <td>ইউনিয়ন ৪</td>
                                                                                                        <td>Union 4</td>
                                                                                                        <td>FPI 4</td>
                                                                                                        <td><button class="btn btn-flat btn-primary btn-xs bold"> Details</button> <button class="btn btn-flat btn-warning btn-xs bold"> Update</button></td>
                                                                                                    </tr>
                                                                                                </tbody>
                                                                                                <tfoot id="tableFooter">
                                                                                                </tfoot>-->
                                            </table>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<link rel="stylesheet" href="https://www.jquery-az.com/boots/css/bootstrap-multiselect/bootstrap-multiselect.css" type="text/css">
<script type="text/javascript" src="https://www.jquery-az.com/boots/js/bootstrap-multiselect/bootstrap-multiselect.js"></script>
<script type="text/javascript">
    $(function () {
        var isNewUnion = false;
        $('#multi-select-union1').multiselect();

        $('#submitButton').on('click', function () {
            var f = $('#reportingunionfpi');
            var multipleUnionsArr = [];
            var multipleUnionsSel = $('#multi-select-union-container select option:selected');
            $.each(multipleUnionsSel, function (i, e) {
                var v = $(e).attr('value');
                multipleUnionsArr.push(v);
            });
            //Modified by Helal
            var data = $.app.pairs('form');
            var mUnion = $("#multiple_union").val();
            data.unionids = mUnion ? $("#multiple_union").val().toString() : null;
            delete data['multi-select-union'];
            var failed = UTIL.validateReportingGeo.validateFPIForm(data, isNewUnion);
            if (failed) {
                alert("Fill Up All Data Properly");
            } else {
                data = JSON.stringify(data);
                UTIL.request("report-geo-info?action=insertFPIAssignment", {data: data}, "POST").then(function (resp) {
                    alert(resp.message);
                });
            }
        });

        $('#viewButton').on('click', function () {
            var data = $.app.pairs('form');
            if (data.divid == "") {
                $.toast('Please select division', 'error')();
                return false;

            } else if (data.zillaid == "") {
                $.toast('Please select district', 'error')();
                return false;

            } else if (data.upazilaid == "") {
                $.toast('Please select upazila', 'error')();
                return false;
            } else {
                delete data['multi-select-union'];
                UTIL.request("report-geo-info?action=getFPIAssignment", {data: JSON.stringify(data)}, "POST").then(function (response) {
                    renderFPITable(response.fpi);
                });
            }
        });
        function renderFPITable(data) {
            var columns = [
                {data: "zillanameeng", title: 'District'},
                {data: "upazilanameeng", title: 'Upazila'},
                {data: "unionname", title: 'Union name (BAN)'},
                {data: "unionnameeng", title: 'Union name (ENG)'},
                {data: function (d) {
                        return $.app.getAssignType(d["assign_type"], 2);
                    }, title: 'Union type'},
                {data: "provname", title: 'Assign to'}
            ];
            var options = {
                dom: 'Bfrtip',
                paging: false,
                "ordering": false,
                searching: false,
                info: false,
                processing: true,
                data: data,
                columns: columns
            };
            $('#data-table').dt(options);
        }


        $('#geo_assign_type_container').html(UTIL.getAssignTypeDropdown({}));

        $('#multi-select-union').multiselect();

        $("#union").change(function () {
            UTIL.clearNewUnion();
            if (this.value == "99") {
                isNewUnion = true;
                $(".display").fadeIn();
            } else {
                isNewUnion = false;
                $(".display").fadeOut();
            }
        });
    });
</script>