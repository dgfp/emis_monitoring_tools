<%-- 
    Document   : newjspReportGeoInformationUnit
    Created on : Mar 19, 2020, 4:03:23 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/ReportGeoInformationMaster.jspf" %>
<script src="resources/js/area_dropdown_control_reporting_unit.js"></script>
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
                    <div class="row">
                        <form role="form" id="reportingunionfwa">
                            <div class="row setup-content" id="step-reporting-union">
                                <div class="col-xs-12">
                                    <div class="col-md-12">
                                        <h3 class="center">Reporting Unit (FWA)</h3>
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
                                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="reporting_unionid" id="union" >
                                                    <option value="">- Select Union -</option>
                                                    <option value="">Union 1</option>
                                                    <option value="">Union 2</option>
                                                    <option value="">Union 3</option>
                                                </select>
                                            </div>
                                            <div class="col-md-2 col-xs-4">
                                                <label>Reporting unit</label>
                                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="unitid" id="unit" >
                                                    <option value="">- Select Unit -</option>
                                                    <option value="">Unit 1</option>
                                                    <option value="">Unit 2</option>
                                                    <option value="">Unit 3</option>
                                                </select>
                                            </div>
                                            <div class="col-md-2 col-xs-4">
                                                <label>Villages</label>
                                                <div id="multi-select-village-container">
                                                    <select class="form-control" id="multi-select-village" multiple="multiple" name="villages">
                                                        <option value="13">Village 1</option>
                                                        <option value="15">Village 2</option>
                                                        <option value="23">Village 3</option>
                                                        <option value="31">Village 4</option>
                                                        <option value="34">Village 5</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-2 col-xs-4">
                                                <label>Assign to (FWA)</label>
                                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="providerid" id="providerid" >
                                                    <option value="">- Select FPI -</option>
                                                    <option value="">FWA 1</option>
                                                    <option value="">FWA 2</option>
                                                    <option value="">FWA 3</option>
                                                </select>
                                            </div>
                                            <div class="col-md-2 col-xs-4">
                                                <label>Assign Type</label>
                                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="assign_type" id="assign_type" >
                                                    <option value="">- Select Assign Type -</option>
                                                    <option value="1">Main</option>
                                                    <option value="2">Additional</option>
                                                </select>
                                            </div>
                                            <div class="col-md-2 col-xs-4">
                                                <label>&nbsp;</label>
                                                <button type="button" id="submitButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-success btn-block btn-sm bold" autocomplete="off">
                                                    <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Add Unit
                                                </button>
                                            </div>
                                            <div class="col-md-2 col-xs-4">
                                                <label>&nbsp;</label>
                                                <button type="button" id="viewButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm bold" autocomplete="off">
                                                    <i class="fa fa-bar-chart" aria-hidden="true"></i>&nbsp; View Unit 
                                                </button>
                                            </div>
                                        </div>                                    
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <br/>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="table-responsive-no-padding">
                                <table id="data-table" class="table table-bordered table-striped">
                                    <!--                                                <thead id="tableHeader">
                                                                                    </thead>
                                                                                    <tbody id="tableBody">
                                                                                    </tbody>
                                                                                    <tfoot id="tableFooter">
                                                                                    </tfoot>-->
                                    <thead id="tableHeader">
                                        <tr>
                                            <th>District</th>
                                            <th>Upazila</th>
                                            <th>Union</th>
                                            <th>Unit</th>
                                            <th>Unit type</th>
                                            <th>Assign to</th>
                                            <!--<th>Actions</th>-->
                                        </tr>
                                    </thead>
                                    <!--                                <tbody id="tableBody">
                                                                        <tr>
                                                                            <td>Natore</td>
                                                                            <td>Lalpur</td>
                                                                            <td>Union 1</td>
                                                                            <td>1KA</td>
                                                                            <td><span class="badge label-success">Main union</span></td>
                                                                            <td>FWA 1</td>
                                                                            <td><button class="btn btn-flat btn-primary btn-xs bold"> Details</button> <button class="btn btn-flat btn-warning btn-xs bold"> Update</button></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>Natore</td>
                                                                            <td>Lalpur</td>
                                                                            <td>Union 1</td>
                                                                            <td>1KA</td>
                                                                            <td><span class="badge label-success">Main union</span></td>
                                                                            <td>FWA 1</td>
                                                                            <td><button class="btn btn-flat btn-primary btn-xs bold"> Details</button> <button class="btn btn-flat btn-warning btn-xs bold"> Update</button></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>Natore</td>
                                                                            <td>Lalpur</td>
                                                                            <td>Union 1</td>
                                                                            <td>1KA</td>
                                                                            <td><span class="badge label-success">Main union</span></td>
                                                                            <td>FWA 1</td>
                                                                            <td><button class="btn btn-flat btn-primary btn-xs bold"> Details</button> <button class="btn btn-flat btn-warning btn-xs bold"> Update</button></td>
                                                                        </tr>
                                                                    </tbody>-->
                                    <tfoot id="tableFooter">
                                    </tfoot>
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
<link rel="stylesheet" href="https://www.jquery-az.com/boots/css/bootstrap-multiselect/bootstrap-multiselect.css" type="text/css">
<script type="text/javascript" src="https://www.jquery-az.com/boots/js/bootstrap-multiselect/bootstrap-multiselect.js"></script>
<script type="text/javascript">
    $(function () {
        $('#multi-select-village').multiselect();

        function renderFWAAssignment(data) {
            var columns = [
                {data: "zillanameeng", title: 'District'},
                {data: "upazilanameeng", title: 'Upazila'},
                {data: "unionnameeng", title: 'Union name'},
                {data: "uname", title: 'Unit'},
                {data: function (d) {
                        return $.app.getAssignType(d["assign_type"], 2);
                    }, title: 'Union type'},
                {data: "provname", title: 'Assign to'}
            ];
            var options = {
                dom: 'Bfrtip',
                paging: false,
                "ordering": false,
                searching: true,
                info: false,
                processing: true,
                data: data,
                columns: columns
            };
            $('#data-table').dt(options);
        };

        getFWAAssignment();

        function getFWAAssignment() {
            UTIL.request("report-geo-info?action=getFWAAssignment", "POST").then(function (response) {
                console.log(response);
                renderFWAAssignment(response.fwa);
            });
        }
        ;
        $('#submitButton').on('click', function () {
            var form = $('#reportingunionfwa');
            var data = form.serializeArray();
            var formInput = $('#reportingunionfwa :input[name]');
            var validate = UTIL.validateReportingGeo.validateFWAForm(data, formInput);
            if (validate) {
//                UTIL.request("report-geo-info?action=getFPIAssignment", {})
                var payload = $.app.pairs('form');
                var villageList = $('#multi-select-village-container select option:selected');
                var villageListArr = [];
                $.each(villageList, function (i, e) {
                    var v = $(e).attr('value');
                    villageListArr.push(v);
                });
                delete payload['multi-select-village'];
                payload['villages'] = villageListArr;
                console.log(payload);
                var p = JSON.stringify(payload);

                UTIL.request("report-geo-info?action=insertFWAAssignment", {data: p}, "POST").then(function (response) {

                    getFWAAssignment();
                    alert(response.message);
                });
            } else {
                alert("Fill up all field");
            }
        });
    });
</script>