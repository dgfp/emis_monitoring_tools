<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/epi_dropdown_controls.js"></script>
<script>

    function upazilaAndUnionSelected() {

        var districtId = $("select#district").val();
        var upazilaId = $("select#upazila").val();
        var year = $("select#year").val();
        var bar1 = $("select#bar1").val();
        var bar2 = $("select#bar2").val();
        var message = "";
        var error = false;
      
        if (districtId.length === 0 || districtId=="0") {
            message += "দয়া করে জেলা পছন্দ করুন\n";
            error = true;
        }
          if (upazilaId==null || upazilaId.length === 0  ) {
            message += "দয়া করে উপজেলা পছন্দ করুন\n";
            error = true;
        }
        if (year.length === 0) {
            message += "দয়া করে সাল পছন্দ করুন\n ";
            error = true;
        }
        if (bar1.length === 0) {
            message += "দয়া করে ১ম বার পছন্দ করুন\n ";
            error = true;
        }
        if (bar1.length === 0) {
            message += "দয়া করে ২য় বার পছন্দ করুন\n ";
            error = true;
        }
        if (error === true) {
            alert(message);
            return false;
        } else {
            return true;
        }
    }

    $(document).ready(function () {
        $('#btnShowBar').click(function (e) {
            e.preventDefault();
            var districtId = $("select#district").val();
            if (districtId.length === 0 || districtId == '0') {
                alert("Select a specific Zilla\n");
                return;
            }
            var btn = $(this).button('loading');
            $('#scheduleBarData').empty();
            $.ajax({
                url: "epischedulebar?action=getScheduleBar",
                data: {
                    district: districtId
                },
                type: 'POST',
                success: function (result) {

                    var json = JSON.parse(result);
                    for (var i = 0; i < json.length; i++) {
                        var parsedData = "<tr>"
                                + "<td> " + json[i].year + "</td>"
                                + "<td> " + json[i].zillaname + "</td>"
                                + "<td> " + json[i].upazilaname + "</td>"


                                + "<td> " + json[i].cname + "</td>"
                                + "<td> " + json[i].cname1 + "</td>"
                                + "</tr>";

                        $('#scheduleBarData').append(parsedData);
                    }
                    btn.button('reset');
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    btn.button('reset');
                    alert("Error while fetching data");
                }
            });
        });

        $("#addScheduleBar").submit(function (e) {
            e.preventDefault();
            upazilaAndUnionSelected();
            var postData = $(this).serializeArray();
            var formURL = $(this).attr("action");
            $.ajax({
                url: formURL,
                type: "POST",
                data: postData,
                success: function (result) {
                    if (result === "1") { //change only if one row is affected
                        alert("নতুন বার সংযুক্ত হয়েছে");
                    }else{
                        alert("বার প্রথমেই সংযুক্ত করা হয়েছে, নতুন বার সংযুক্ত করুন");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error while adding village");
                }
            });
            e.preventDefault();	//STOP default action
        });
    });
</script>
<%@include file="/WEB-INF/jspf/underDevelopment.jspf" %>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    ই পি আই সেশন বার 
    <small></small>
  </h1>
  <ol class="breadcrumb">
    <a class="btn btn-flat btn-primary btn-sm" href="schedule_epi_settings"><b>EPI session plan</b></a>
    <a class="btn btn-flat btn-primary btn-sm" href="epi_schedule_add"><b>Add EPI session </b></a>
    <a class="btn btn-flat btn-info btn-sm" href="epischedulebar"><b>EPI session times</b></a>
  </ol>
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
            <form action="epischedulebar?action=addSchedulebar" id="addScheduleBar" method="Post">
                <div class="row">
                    <div class="col-md-1">
                        <label for="division">বিভাগ</label>
                    </div>
                    <div class="col-md-3">
                        <select class="form-control input-sm" name="division" id="division"> </select>
                    </div>
                    <div class="col-md-1">
                        <label for="district">জেলা</label>
                    </div>
                    <div class="col-md-3">
                        <select class="form-control input-sm" name="district" id="district" required> </select>
                    </div>
                    <div class="col-md-1">
                        <label for="upazila">উপজেলা</label>
                    </div>
                    <div class="col-md-3">
                        <select class="form-control input-sm" name="upazila" id="upazila" required> </select>
                    </div>
                    <br/>
                    <br/>
                    <div class="col-md-1">
                        <label for="year">সাল</label>
                    </div>
                    <div class="col-md-3">
                        <select class="form-control input-sm" name="year" id="year" required> </select>
                    </div>
                    <div class="col-md-1">
                        <label for="bar1">১ম বার</label>
                    </div>
                    <div class="col-md-3">
                        <select class="form-control input-sm" name="bar1" id="bar1" required> </select>
                    </div>
                    <div class="col-md-1">
                        <label for="bar2">২য় বার</label>
                    </div>
                    <div class="col-md-3">
                        <select class="form-control input-sm" name="bar2" id="bar2" required> </select>
                    </div>
                </div><br>
                <div class="row">
                    <div class="col-md-offset-3 col-md-3  ">
                        <button type="submit" id="btnAddBar" class="btn btn-flat btn-primary btn-block">
                            <b>বার সংযুক্ত করুন</b>
                        </button>
                    </div>
                    <div class="col-md-3  ">
                        <button type="button" id="btnShowBar" class="btn btn-flat btn-primary btn-block">
                            <b>বার তালিকা দেখুন</b>
                        </button>
                    </div>
                </div>
            </form>     
          </div>
        </div>
      </div>
    </div>
    <!--Table body-->
    
    <div class="row" id="tableContent">
    <div class="col-xs-12">
        <div class="box box-primary">
                <!--  Table top -->
    <!--        <div class="box-header">
                <h3 class="box-title pull-center">  <span id="result">Show</span>
                    <select id="tableEntrySize">
                        <option value="0">All</option>
                        <option value="10">10</option>
                        <option value="15">15</option>
                        <option value="20">20</option>
                        <option value="25">25</option>
                        <option value="30">30</option>
                    </select>entries 
                </h3>

                <h3 class="box-title pull-right">   
                        <input type="text" class="form-control" placeholder="Search ...." id="search">
                </h3>
            </div>-->

            <!-- table -->
            <div class="box-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-striped table-hover" id="data-table">
                        <thead>
                            <tr>
                                <th>সাল</th>
                                <th>জেলা</th>
                                <th>উপজেলা</th>
                                <th>১ম বার</th>
                                <th>২য় বার</th>
                            </tr>
                        </thead>
                        <tbody id="scheduleBarData">
                        </tbody>
                        </table>
                </div>
            </div>
        </div>
    </div>
</div>
</section>        

<!-- Page Content -->
<!--<div id="page-wrapper">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <h3>
                    ই পি আই সেশন বার 
                </h3>
            </div>
        </div>
        <form action="epischedulebar?action=addSchedulebar" id="addScheduleBar" method="Post">
            <div class="well well-sm">
                <div class="row">
                    <div class="col-md-1">
                        <label for="division">বিভাগ</label>
                    </div>
                    <div class="col-md-3">
                        <select class="form-control input-sm" name="division" id="division"> </select>
                    </div>
                    <div class="col-md-1">
                        <label for="district">জেলা</label>
                    </div>
                    <div class="col-md-3">
                        <select class="form-control input-sm" name="district" id="district" required> </select>
                    </div>
                    <div class="col-md-1">
                        <label for="upazila">উপজেলা</label>
                    </div>
                    <div class="col-md-3">
                        <select class="form-control input-sm" name="upazila" id="upazila" required> </select>
                    </div>
                    <br/>
                    <br/>
                    <div class="col-md-1">
                        <label for="year">সাল</label>
                    </div>
                    <div class="col-md-3">
                        <select class="form-control input-sm" name="year" id="year" required> </select>
                    </div>
                    <div class="col-md-1">
                        <label for="bar1">১ম বার</label>
                    </div>
                    <div class="col-md-3">
                        <select class="form-control input-sm" name="bar1" id="bar1" required> </select>
                    </div>
                    <div class="col-md-1">
                        <label for="bar2">২য় বার</label>
                    </div>
                    <div class="col-md-3">
                        <select class="form-control input-sm" name="bar2" id="bar2" required> </select>
                    </div>


                </div>

                <div class="row">

                </div>
                <BR/>
                <div class="row">
                    <div class="col-md-offset-3 col-md-3  ">
                        <button type="submit" id="btnAddBar" class="btn btn-success btn-block btn-sm">
                            বার সংযুক্ত করুন
                        </button>
                    </div>
                    <div class="col-md-3  ">
                        <button type="button" id="btnShowBar" class="btn btn-success btn-block btn-sm">
                            বার তালিকা দেখুন
                        </button>
                    </div>
                </div>
            </div>
        </form>

        <div class="col-ld-12">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>সাল</th>
                            <th>জেলা</th>
                            <th>উপজেলা</th>
                            <th>১ম বার</th>
                            <th>২য় বার</th>
                        </tr>
                    </thead>
                    <tbody id="scheduleBarData">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <br/>
    <style>
        .table th{text-align: left;}
    </style>   
</div>-->

<style>
    .table th{text-align: left;}
</style>

<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
