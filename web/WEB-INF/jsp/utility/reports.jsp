<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/area_dropdown_controls.js"></script>
<script>
    $(document).ready(function () {
        
        $('#union').change(function (event) {
            
            var unionId=  $('select#union').val();
            var selectTagProviderType = $('#providerType');
            var selectTagProvider = $('#provider');
            
            if (unionId === "") {
                selectTagProviderType.find('option').remove();
                $('<option>').val("").text('- Select Provider Type-').appendTo(selectTag);

                selectTagProvider.find('option').remove();
                $('<option>').val("").text('- Select Provider-').appendTo(selectTagUnit);

            }else {
                  selectTagProviderType.find('option').remove();
                  $('<option>').val("").text('- Select Provider Type -').appendTo(selectTagProviderType);
                  $('<option>').val('2').text("HA [2]").appendTo(selectTagProviderType);
                  $('<option>').val('3').text("FWA [3]").appendTo(selectTagProviderType);                  
                
            }//end else

        });
        
        //Provider Load
        $('#providerType').change(function (event) {
            
                    //get Unit
                    $.ajax({
                    url: "reports?action=loadProvider",
                    data: {
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val(),
                        providerType: $("select#providerType").val()
                    },
                    type: 'POST',
                    success: function (response) {
                        var returnedData = JSON.parse(response);
                        
                        var selectTag = $('#provider');
                        selectTag.find('option').remove();
                        
                        $('<option>').val("0").text('All').appendTo(selectTag);
                        for (var i = 0; i < returnedData.length; i++) {
                            var id = returnedData[i].provcode;
                            var name = returnedData[i].provname;
                            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                        }
                    }
                });  
        });
        
        
        //Show data
        $('#showdataButton').click(function () {
            
            
            if($("select#district").val()===""){
                toastr["error"]("<h4><b>Please select district</b></h4>");
                return;
            }else if($("select#upazila").val()===""){
                toastr["error"]("<h4><b>Please select upazila</b></h4>");
                return;
            }else if($("select#union").val()===""){
                toastr["error"]("<h4><b>Please select union</b></h4>");
                return;
            }else if($("startDate").val()===""){
                toastr["error"]("<h4><b>Please select start date</b></h4>");
                return;
            }
             var btn = $(this).button('loading');
            Pace.track(function(){
                    $.ajax({
                        url: "reports?action=loadCount",
                        data: {
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            villageId: $("select#village").val(),
                            provider: $("select#provider").val(),
                            startDate: $("#startDate").val(),
                            endDate: $("#endDate").val()
                        },
                        type: 'POST',
                        success: function (result) {
                            

                            var json = JSON.parse(result);

                            if (json.length === 0) {
                                btn.button('reset');
                                toastr["error"]("<h4><b>No data found</b></h4>");
                                return;
                            }
                           var tableBody = $('#tableBody');
                           tableBody.empty(); 
                           
                            for (var i = 0; i < json.length; i++) {

                            var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                    + "<td>" + json[i].provcode + "</td>"
                                    + "<td>" + json[i].mouzanameeng + "</td>"
                                    + "<td> " + json[i].villagenameeng + "</td>"
                                    + "<td>" + json[i].count + "</td>";
                            tableBody.append(parsedData);
                            }

                            btn.button('reset');
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    }); //End Ajax Request 
                }); //End Pace 
                
                
                
        
        });

    });
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
      <span style="color:#4fef2f;"><i class="fa fa-check-circle" aria-hidden="true"></i></span> Provider reports
  </h1>
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
                <div class="col-md-1">
                    <label for="district">District</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="district" id="district"> </select>
                </div>

                <div class="col-md-1">
                    <label for="upazila">Upazila</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="upazila" id="upazila">
                        <option value="">- Select Upazila -</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="union">Union</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="union" id="union">
                        <option value="">- Select Union -</option>
                    </select>
                </div>
                
                <div class="col-md-1">
                    <label for="union">Provider Type</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control" name="providerType" id="providerType" required>
                        <option value="">- Select Type -</option>
                    </select>
                </div>
            </div><br>
            
            
            
            <div class="row">
                <div class="col-md-1">
                    <label for="union">Provider </label>
                </div>
                <div class="col-md-2">
                    <select class="form-control" name="providerType" id="provider" required>
                        <option value="">- Select Type -</option>
                    </select>
                </div>
                
                <div class="col-md-1">
                    <label for="one" id="">From</label>
                </div>
                <div class="col-md-2">
                    <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="startDate" id="startDate" />
                </div>

                <div class="col-md-1">
                    <label for="one" id="">To</label>
                </div>
                <div class="col-md-2">
                    <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="endDate" id="endDate" />
                </div>

                <div class="col-md-2 col-md-offset-1">
                    <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off">
                        <i class="fa fa-bar-chart" aria-hidden="true"></i> View Data
                    </button>
                </div>
            </div>    
                          
          </div>
        </div>
      </div>
    </div>
    <!--Table body-->
    
    <div class="row" id="tableContent">
    <div class="col-xs-12">
        <div class="box box-primary">
            
            <!--  Table top -->
            <div class="box-header" style="margin-bottom: -10px;">
                <div class="row">
                    <div class="col-md-7">
<!--                        <h3 class="box-title pull-center">  <span id="result">Show</span>
                            <select id="tableEntrySize">
                                <option value="0">All</option>
                                <option value="10">10</option>
                                <option value="15">15</option>
                                <option value="20">20</option>
                                <option value="25">25</option>
                                <option value="30">30</option>
                            </select> entries 
                        </h3>-->
                    </div>
                </div>
            </div>
            
        <!-- table -->
        <div class="box-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover" id="data-table">
                    <thead class="data-table">
                        <tr>
                            <th>#</th>
                            <th>Provider Code</th>
                            <th>VIllage</th>
                            <th>Mouza</th>
                            <th>Count</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                    </tbody>
                    <tfoot id="tableFooter">
                    </tfoot>
                </table>
            </div>
        </div>
        
      </div>
    </div>
  </div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>