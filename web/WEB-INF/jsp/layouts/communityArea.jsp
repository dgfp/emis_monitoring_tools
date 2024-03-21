<style>
    .box-body {
        padding: 10px 10px 0px 10px!important;
    }
    [class*="col"] { margin-bottom: 10px; }
</style>
<div class="row" id="areaDropDownPanel">
    <div class="col-md-12">
        <div class="box box-primary">
            <div class="box-body">
                <input type="hidden" value="${userLevel}" id="userLevel">
                <div class="row">
                    <div class="col-md-1 col-xs-2">
                        <label for="district">Division</label>
                    </div>
                    <div class="col-md-2 col-xs-4">
                        <select class="form-control input-sm" name="division" id="division"> </select>
                    </div>

                    <div class="col-md-1 col-xs-2">
                        <label for="district">District</label>
                    </div>
                    <div class="col-md-2 col-xs-4">
                        <select class="form-control input-sm" name="district" id="district">
                            <option value="">- Select District -</option>
                        </select>
                    </div>
                    <div class="col-md-1 col-xs-2">
                        <label for="upazila">Upazila</label>
                    </div>
                    <div class="col-md-2 col-xs-4">
                        <select class="form-control input-sm" name="upazila" id="upazila" >
                            <option value="">- Select Upazila -</option>
                        </select>
                    </div>
                    <div class="col-md-1 col-xs-2">
                        <label for="union">Union</label>
                    </div>
                    <div class="col-md-2 col-xs-4">
                        <select class="form-control input-sm" name="union" id="union" >
                            <option value="">- Select Union -</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <c:choose>
                        <c:when test="${type=='familyPlanning'}">
                            <div class="col-md-1 col-xs-2">
                                <label for="unit">Unit</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="unit" id="unit" >
                                    <option value="">- Select unit -</option>
                                </select>
                            </div>
                        </c:when>    
                        <c:otherwise>
                            <div class="col-md-1 col-xs-2">
                                <label for="ward">Ward</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control input-sm" name="ward" id="ward" >
                                    <option value="">- Select ward -</option>
                                </select>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="col-md-1 col-xs-2">
                        <label for="village">Village</label>
                    </div>
                    <div class="col-md-2 col-xs-4">
                        <select class="form-control input-sm" name="village" id="village" >
                            <option value="">- Select village -</option>
                        </select>
                    </div>
                    <div class="col-md-1 col-xs-2">
                        <label for="one" id="">From</label>
                    </div>
                    <div class="col-md-2 col-xs-4">
                        <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="startDate" id="startDate" />
                    </div>

                    <div class="col-md-1 col-xs-2">
                        <label for="one" id="">To</label>
                    </div>
                    <div class="col-md-2 col-xs-4">
                        <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="endDate" id="endDate" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-1 col-xs-2 col-md-offset-6">
                        <label for="reportType">Type</label>
                    </div>
                    <div class="col-md-3 col-xs-6" id="">
                        <span><input class="providerWise input-combo" type="radio"  id="reportType-1" name="reportType" value="aggregate" checked="checked">  <label for="reportType-1">Aggregate</label> </span>
                        <span><input class="overal input-combo" type="radio"  id="reportType-2" name="reportType" value="individual"> <label for="reportType-2">Individual</label></span>
                    </div>
                    <div class="col-md-2 col-xs-4">
                        <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off">
                            <i class="fa fa-bar-chart" aria-hidden="true"></i> View Data
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>