<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/area_dropdown_controls.js"></script>
<script>
    $(document).ready(function () {
        var regExp = /(\d{1,2})\/(\d{1,2})\/(\d{2,4})/; //for date compare

        $('#showdataButton').click(function () {

            var tableBody = $('#tableBody');
            tableBody.empty(); //first empty table before showing data

            if( $("select#district").val()=="" || $("select#district").val()==0){
                toastr["error"]("<h4><b>Please select District</b></h4>");
                return ;
            }else if($("#endDate").val()==""){
                toastr["error"]("<h4><b>Please select End Date</b></h4>");
                return;
            }else if(parseInt($("#startDate").val().replace(regExp, "$3$2$1")) > parseInt($("#endDate").val().replace(regExp, "$3$2$1"))){
                toastr["error"]("<h4><b>Start date should be smaller than end date</b></h4>");
                return;
            }else{
                var startDate=$("#startDate").val();
                if( startDate==""){
                    startDate="01/01/2015"; 
                }
                
                var btn = $(this).button('loading');
                Pace.track(function(){
                    $.ajax({
                        url: "deaths",
                        data: {
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            villageId: $("select#village").val(),
                            startDate: startDate,
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

                            //alert("Clicked");
                            for (var i = 0; i < json.length; i++) {

                                var fatherName = nullConverter(json[i].fathername);
                                var motherName = nullConverter(json[i].fathername);
                                var placeofbirth = nullConverter(json[i].placeofbirth);

                                var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                        + "<td>" + json[i].upzila + "</td>"
                                        + "<td>" + json[i].union + "</td>"
                                        + "<td>" + json[i].village + "</td>"
                                        + "<td>" + json[i].name + "</td>"
                                        + "<td>" + motherName + "</td>"
                                        + "<td>" + fatherName + "</td>"
                                        + "<td>" + moment(json[i].dob).format('DD MMM YYYY') + "</td>"
                                        + "<td>" + placeofbirth + "</td></tr>";

                                tableBody.append(parsedData);
                            }
                            btn.button('reset');
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    }); //End Ajax
                }); //End Pace
            }
        });


    });


    function nullConverter(value) {

        if (value === "null")
            return "-";
        else return value;
    }

</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>Death notification</h1>
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
                    <select class="form-control input-sm" name="upazila" id="upazila" >
                        <option value="">- Select Upazila -</option>
                    </select>
                </div>
                <div class="col-md-1">
                    <label for="union">Union</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="union" id="union" >
                        <option value="">- Select Unon -</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="village">Village</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="village" id="village" >
                        <option value="">All</option>
                    </select>
                </div>
            </div>
            <br/>

            <div class="row">
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
    
    <!--Birth Data Table-->
    <div class="box box-primary">
        <div class="box-header with-border">
            <h3 class="box-title"><b><span id="prsTypeTitleForTable"></span></b></h3>
            <div class="box-tools pull-right" style="margin-top: 0px;">
                <button type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print</button>
                <button type="button" class="btn btn-box-tool"><i class="fa fa-file-pdf-o" aria-hidden="true"></i>&nbsp;PDF</button>
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
            </div>
        </div>
        <div class="box-body">
            <!--Data Table-->               
            <div class="col-ld-12" id="">
                <div class="table-responsive" >
                   <table class="table table-striped table-bordered table-hover" id="data-table">
                        <thead id="tableHeader" class="data-table">
                            <tr>
                                <th>#</th>
                                <th>Upazila</th>
                                <th>Union</th>
                                <th>Village</th>
                                <th>Name</th>
                                <th>Mother's Name</th>
                                <th>Father Name</th>
                                <th>Date of Death</th>
                                <th>Place of Death</th>
                            </tr>
                        </thead>

                        <tbody id="tableBody">
                        </tbody>

                        <tfoot id="tableFooter" class="data-table">
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>
<!--<div id="page-wrapper">

    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <h3>Deaths</h3>
            </div>
        </div>

        <div class="well well-sm">
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
                    <select class="form-control input-sm" name="upazila" id="upazila" >
                        <option value="">All</option>
                    </select>
                </div>
                <div class="col-md-1">
                    <label for="union">Union</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="union" id="union" >
                        <option value="">All</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="village">Village</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="village" id="village" >
                        <option value="">All</option>
                    </select>
                </div>
            </div>

            <br>

            <div class="row">
                <div id="datepicker-container">

                    <div class="input-daterange input-group" id="datepicker">

                        <div class="col-md-1">
                            <label for="startDate">From</label>
                        </div>

                        <div class="col-md-2">
                            <input type="text" class="input form-control input-sm" placeholder="dd/mm/yyyy" name="startDate" id="startDate"/>
                        </div>

                        <div class="col-md-1">
                            <label for="endDate">To</label>
                        </div>

                        <div class="col-md-2">
                            <input type="text" class="input form-control input-sm" placeholder="dd/mm/yyyy" name="endDate" id="endDate" />
                        </div>


                        <div class="col-md-2 col-md-offset-1">
                                        <div class="col-md-2 col-md-offset-1">
                            <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-success btn-block btn-sm" autocomplete="off">
                                Show data
                            </button>
                        </div>




                    </div>
                </div>
            </div>

        </div>

        <div class="col-ld-12">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Upazila</th>
                            <th>Union</th>
                            <th>Village</th>
                            <th>Name</th>
                            <th>Mother's Name</th>
                            <th>Father Name</th>
                            <th>Date of Death</th>
                            <th>Place of Death</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>-->

<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>