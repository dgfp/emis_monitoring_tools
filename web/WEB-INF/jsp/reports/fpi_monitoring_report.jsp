<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla.js"></script>
<script src="resources/js/functions.js" type="text/javascript"></script>

<style>
table, th, td {
        border: 1px solid black;
    }
    th, td {
        padding: 5px;
        text-align: center;
        font-weight: normal!important;
        
    }
    .tableTitle{
        font-family: SolaimanLipi;
    }
    table{
        font-family: SolaimanLipi;
        font-size: 13px;
    }

    @media print {
        .tableTitle{
            display: block;
            margin-top: -2px;
        }
        .reg-fwa-13{
            margin-top: -30px!important;
        }
        /*        @page {
                    size: A4 landscape;
                    margin: 10px;
                }*/
        .box{ border: 0}
        #areaPanel, #back-to-top, .box-header, .main-footer{
            display: none !important;
        }
    }
    [class*="col"] { margin-bottom: 10px; }
</style>

<script>
    $(document).ready(function () {
        
         var tableBody = $('#tableBody');
         tableBody.append(getInitial());
        
        
        $('#showdataButton').click(function () {
                var alert = $('#alert');
                alert.empty();
                 var btn = $(this).button('loading');
                 
                 //Get Table
                var tableBody = $('#tableBody');
                tableBody.empty();
                tableBody.append(getInitial());

                tableBody.append('');
                 
                        $.ajax({
                        url: "fpi_monitoring_report",
                        data: {
                            divisionId: $("select#division").val(),
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            startDate: $("#startDate").val(),
                            endDate: $("#endDate").val()
                        },
                        type: 'POST',
                        success: function (result) {
                            var json = JSON.parse(result);
                            btn.button('reset');


                            if (json.length === 0) {
                                toastr["error"]("<h4><b>কোন ডাটা পাওয়া যায়নি</b></h4>");
                                return;
                            }else{
                                
                                //Initial Variable
                                var sufficientmaterrialValue="হাঁ";
                                 var fpaadvanceValue="সঠিক";
                                
                                //Set table Data
                                tableBody.empty();
                                for (var i = 0; i < json.length; i++) {
                                    
                                    
                                    //Set column three by condition
                                    if(json[i].sufficientmaterrial==1){
                                        sufficientmaterrialValue="না";
                                    }
                                    
                                    //Set column two by condition
                                    if(json[i].fpaadvance==02){
                                        fpaadvanceValue="আগে";
                                    }else if(json[i].fpaadvance==03){
                                        fpaadvanceValue="পিছনে";
                                    }
                                    
                                    var parsedData = "<tr><td>" + convertToUserDate(json[i].vdate) + "</td>"
                                            + "<td colspan='1'>"+ json[i].provname +"</td>"
                                            + "<td colspan='1'>" + fpaadvanceValue + "</td>"
                                            + "<td colspan='1'>" + sufficientmaterrialValue+ "</td>"
                                            + "<td colspan='1'>" + json[i].elcolist + "</td>"
                                            + "<td colspan='1'></td>"
                                            + "<td colspan='1'></td>"
                                            + "<td colspan='1'></td>"
                                            + "<td colspan='1'></td>"
                                            + "<td colspan='1'></td>"
                                            + "<td colspan='1'></td>"
                                            + "<td colspan='1'>" + json[i].totalelco + "</td>"
                                            + "</tr>";
                                    tableBody.append(parsedData);
                                }
                            }

                            btn.button('reset');
                            $("table td").each(function () {
                                $(this).text(convertE2B($(this).text()));
                            });
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            ajaxLoading.empty();
                            btn.button('reset');
                            alert.append(getAlert("Request can't be processed","danger"));
                        }
                    });
        });
        
    });
    
    
    function getInitial(){
            return '<tr>'
                        +'<td style="height: 250px"></td>'
                        +'<td colspan="1">-</td>'
                        +'<td colspan="1"></td'
                        +'<td colspan="1"></td>'
                        +'<td colspan="1"></td>'
                        +'<td colspan="1"></td>'
                        +'<td colspan="1"></td>'
                        +'<td colspan="1"></td>'
                        +'<td colspan="1"></td>'
                        +'<td colspan="1"></td>'
                        +'<td colspan="1"></td>'
                        +'<td colspan="1"></td>'
                        +'<td colspan="1"></td>'
                    +'</tr>';
    }
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>FPI supervision report<small></small></h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <div class="row" id="areaPanel">
      <div class="col-md-12">
        <div class="box box-primary">
<!--          <div class="box-header with-border">
              <div class="box-tools pull-right" style="margin-top: -10px;">
              <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
              <button type="button" class="btn btn-box-tool btn-remove" data-widget="remove"><i class="fa fa-times"></i></button>
            </div>
          </div>-->
            <input type="hidden" value="${userLevel}" id="userLevel">
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <label for="division">বিভাগ</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="division" id="division"> 
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-xs-2">
                            <label for="district">জেলা</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="district" id="district"> 
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="upazila">উপজেলা</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="upazila" id="upazila">
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="union">ইউনিয়ন</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control input-sm" name="union" id="union">
                                <option value="">- সিলেক্ট করুন -</option>
                            </select>
                        </div>
                    </div>
                    <div class="row secondRow">

                        <div class="col-md-1 col-xs-2">
                            <label for="month">শুরুর তারিখ</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="startDate" id="startDate" />
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="year">শেষ তারিখ</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="endDate" id="endDate" />
                        </div>
                        <div class="col-md-1 col-xs-2">
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm" autocomplete="off">
                                <b><i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; রিপোর্ট দেখুন</b>
                            </button>
                        </div>
                    </div>
                </div>
        </div>
      </div>
    </div>
    <!--Table body-->
    <div class="col-ld-12">
        <div class="box box-primary full-screen">
            <div class="box-header with-border">
                <div class="box-tools pull-right" style="margin-top: -10px;">
                    <button type="button" class="btn btn-flat btn-default btn-xs bold" onclick="window.print();"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                    <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                </div>
            </div>
            <div class="box-body">
                <div class="tableTitle">
                    <h4 style="text-align: center;margin-top: 0px;;">পরিবার পরিকল্পনা পরিদর্শকের তদারকি ছক</h4>
                    <center>( প্রতেকবার কর্মীকে পরিদর্শনের সময় তদারকি সহায়ক নির্দেশমালা* অনুযায়ী পূরণ করতে হবে )</center>
                </div>
                <div class="table-responsive">
                    <table border="1px" class="mis_table" style="width: 100%;">
                        <thead style="font-weight: normal">
                                <tr>
                                    <th rowspan="3">পরিদর্শনের<br> তারিখ ও গ্রামের <br> নাম</th>
                                    <th rowspan="3">পরিবার<br> কল্যাণ<br> সহকারীর নাম</th>
                                    <th rowspan="3" colspan="1">কর্মীর অগ্রিম<br> কর্মসূচী <br>কোন পর্যায়ে <br>( সঠিক /আগে / <br>পিছনে )</th>
                                    <th rowspan="3" colspan="1">পর্যাপ্ত<br> সামগ্রী <br>আছে কি? <br>( হ্যাঁ /না )</th>
                                    <th rowspan="3" colspan="1">পরিদর্শিত<br> দম্পতি <br>সমূহের <br>নম্বর</th>
                                    <th colspan="7" style="text-align: center;">রেজিস্টারে লিপিবদ্ধ তথ্য যাচাইয়ের ফলাফল ( দম্পতি সংখ্যা )</th>
                                </tr>
                                <tr>
                                    <th colspan="2" style="text-align: center;">পদ্ধতি<br> প্রহনকারী /ব্যবহারকারী</th>
                                    <th rowspan="2">পদ্ধতির<br> জন্য প্রেরণ</th>
                                    <th rowspan="2">পার্শ্ব-<br> প্রতিক্রিয়ার<br> জন্য প্রেরণ</th>
                                    <th rowspan="2">যাচাইকৃত<br> গর্ভবতী<br> মায়ের<br> সংখ্যা </th>
                                    <th rowspan="2" colspan="1">অন্যান্য<br> দম্পতি</th>
                                    <th rowspan="2" >মোট<br> যাচাইকৃত<br> দম্পতি&nbsp;&nbsp;</th>
                                </tr>
                                <tr>
                                    <th>&nbsp;&nbsp;&nbsp;&nbsp;সঠিক&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                    <th>সঠিক নয়</th>
                                </tr>
                                <tr>
                                    <td>১</td>
                                    <td colspan="1">২</td>
                                    <td colspan="1">৩</td>
                                    <td colspan="1">৪</td>
                                    <td colspan="1">৫</td>
                                    <td colspan="1">৬</td>
                                    <td colspan="1">৭</td>
                                    <td colspan="1">৮</td>
                                    <td colspan="1">৯</td>
                                    <td colspan="1">১০</td>
                                    <td colspan="1">১১</td>
                                    <td colspan="1">১২</td>
                                </tr>
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            
                        </table>
                </div>
            </div>
        </div>
    </div>
</section>

<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>