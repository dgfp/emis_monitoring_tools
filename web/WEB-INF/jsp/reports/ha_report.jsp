<%-- 
    Document   : epiDailyVaccineChild
    Author     : Helal | m.helal.k@gmail.com
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_epi_monthly_bangla.js"></script>
<!--<link href="resources/css/style.css" rel="stylesheet" type="text/css"/>-->
<!--<script src="resources/js/HATabResponsive-EPI.js" type="text/javascript"></script>-->
<%
    if(session.getAttribute("isTabAccess")!=null) {
%>
    <style>
        #areaPanel{
            margin-top: -90px!important;
        }
    </style>
<%
    }
%>
<style>
        .tg  {border-collapse:collapse;border-spacing:0;}
        .tg td{font-family:Arial, sans-serif;font-size:13px;padding:1px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
        .tg th{font-family:Arial, sans-serif;font-size:13px;font-weight:bold;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
        .tg .tg-0e45{font-size:11px}
        .tg .tg-q19q{font-size:11px;vertical-align:top}
        .tg .tg-yw4l{vertical-align:top}
/*    .rotate {
        filter:  progid:DXImageTransform.Microsoft.BasicImage(rotation=0.083);
        -ms-filter: "progid:DXImageTransform.Microsoft.BasicImage(rotation=0.083)";
        -moz-transform: rotate(-90.0deg);  
        -ms-transform: rotate(-90.0deg);  
        -o-transform: rotate(-90.0deg);  
        -webkit-transform: rotate(-90.0deg);  
        transform: rotate(-90.0deg); 
    }*/
    .center{
        text-align: center;
    }
    @media print {
    .tableTitle{
        display: block;
        margin-top: -20px!important;
    }
    .box{ border: 0}
    #areaPanel, #back-to-top, .box-header, .main-footer{
        display: none !important;
    }
}

#exportWarningModal{
    display: none;
}
[class*="col"] { margin-bottom: 10px; }
</style>

<script>
    $(document).ready(function () {
        
        if($('#isSubmitAccess').val()=='99'){
            $(".mis_table").css("width", "100%");
        }
        
        //Data Send to DHIS2 
        $("#exportToDHIS2Button").click(function(){
            var btn = $(this).button('loading');
            //http://localhost:8080/hareport?dataset=mxw5LM5v2Wd&orgunit=JoItjM53R2X&zilla=93&upz=66&un=13&year=2018&month=01
            Pace.track(function(){
                  $.ajax({
                    url: "DHIS2RequestService",
                    data: {
                        dataset: "mxw5LM5v2Wd",
                        orgunit: "JoItjM53R2X",
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val(),
                        month: $("select#month").val().length==1 ? "0"+$("select#month").val() : $("select#month").val(),
                        year: $("select#year").val()
                    },
                    type: "GET",
                    success: function (result) {
                        $('#exportTODHIS2Warning').modal('hide');
                        btn.button('reset');
                        toastr["success"]("<h4><b>Congratulations! Your data has been successfully exported to the DHIS2.</b></h4>");
                    },
                     error: function (jqXHR, textStatus, errorThrown) {
                        toastr["error"]("<h4><b>Sorry something is missing</b></h4>");
                    }
                }); //End Ajax request
            }); //End Pace loading
        });
        
        
        $("#showdataButton").click(function(){

            if( $("select#division").val()===""){
	toastr["error"]("<h4><b>বিভাগ সিলেক্ট করুন </b></h4>");

            }else if( $("select#district").val()===""){
                    toastr["error"]("<h4><b>জেলা সিলেক্ট করুন </b></h4>");

            }else if( $("select#upazila").val()===""){
                    toastr["error"]("<h4><b>উপজেলা সিলেক্ট করুন </b></h4>");

            }else if( $("select#union").val()===""){
                    toastr["error"]("<h4><b>ইউনিয়ন সিলেক্ট করুন</b></h4>");

            }else if( $("select#month").val()===""){
                    toastr["error"]("<h4><b>মাস সিলেক্ট করুন </b></h4>");

            }else if( $("select#year").val()===""){
                    toastr["error"]("<h4><b>সন সিলেক্ট করুন </b></h4>");

            }else{
                var btn = $(this).button('loading');
                var exportBtn =$('#exportWarningModal');
                Pace.track(function(){
                  $.ajax({
                        url: "ha_report",
                        data: {
                                districtId: $("select#district").val(),
                                upazilaId: $("select#upazila").val(),
                                unionId: $("select#union").val(),
                                month: $("select#month").val(),
                                year: $("#year").val(),
                                ward: $("#ward").val()
                        },
                        type: "POST",
                        success: function (result) {
                            
                            btn.button('reset');
                            var json = JSON.parse(result);
                            var ward=$("select#ward").val();
                            
                            if (json.length === 0) {
                                toastr["error"]("<h4><b>কোন ডাটা পাওয়া যায়নি</b></h4>");
                                return;
                            }
                            
                            //Set Ward Dynamically
                            if( ward==='1'){
                                $("#setWard").html("ওয়ার্ড ১"); 
                                
                            }else if( ward==='2'){
                                $("#setWard").html("ওয়ার্ড ২"); 
                                
                            }else if( ward==='3'){
                                $("#setWard").html("ওয়ার্ড ৩"); 
                            }else{
                                $("#setWard").html($("#union option:selected").text().substr(0,$("#union option:selected").text().length - 4));
                            }
                            
                            //Set Data to table
                            if (json.length > 0) {
                                $("#r_preg_woman_new_w1").html(convertE2B(json[0].r_preg_woman_new_w1));

                                $("#r_preg_woman_old_w1").html(convertE2B(json[0].r_preg_woman_old_w1));

                                $("#r_preg_woman_tot_w1").html(convertE2B(json[0].r_preg_woman_tot_w1));

                                $("#r_pnc_visit1_w1").html(convertE2B(json[0].r_pnc_visit1_w1));
                                $("#r_pnc_visit2_w1").html(convertE2B(json[0].r_pnc_visit2_w1));
                                $("#r_pnc_visit3_w1").html(convertE2B(json[0].r_pnc_visit3_w1));
                                $("#r_pnc_visit4_w1").html(convertE2B(json[0].r_pnc_visit4_w1));

                                $("#r_preg_iron_folic_acid_anc__w1").html(convertE2B(json[0].r_preg_iron_folic_acid_anc__w1));

                                $("#r_delivery_home_expert_w1").html(convertE2B(json[0].r_delivery_home_expert_w1));

                                $("#r_delivery_home_unexpert_w1").html(convertE2B(json[0].r_delivery_home_unexpert_w1));

                                $("#r_delivery_facility_w1").html(convertE2B(json[0].r_delivery_facility_w1));

                                $("#r_misoprostol_eaten_w1").html(convertE2B(json[0].r_misoprostol_eaten_w1));

                                $("#r_delivery_patern_normal_w1").html(convertE2B(json[0].r_delivery_patern_normal_w1));
                                $("#r_delivery_patern_operation_w1").html(convertE2B(json[0].r_delivery_patern_operation_w1));

                                $("#r_live_birth_w1").html(convertE2B(json[0].r_live_birth_w1));
                                $("#r_birth_less_weight_w1").html(convertE2B(json[0].r_birth_less_weight_w1));
                                $("#r_death_birth_w1").html(convertE2B(json[0].r_death_birth_w1));

                                $("#r_preg_service_anc_visit1_w1").html(convertE2B(json[0].r_preg_service_anc_visit1_w1));
                                $("#r_preg_service_anc_visit2_w1").html(convertE2B(json[0].r_preg_service_anc_visit2_w1));
                                $("#r_preg_service_anc_visit3_w1").html(convertE2B(json[0].r_preg_service_anc_visit3_w1));
                                $("#r_preg_service_anc_visit4_w1").html(convertE2B(json[0].r_preg_service_anc_visit4_w1));

                                $("#r_total_death_0_7days_w1").html(convertE2B(json[0].r_total_death_0_7days_w1));
                                $("#r_total_death_8_28days_w1").html(convertE2B(json[0].r_total_death_8_28days_w1));
                                $("#r_total_death_29d_bellow_1year_w1").html(convertE2B(json[0].r_total_death_29d_bellow_1year_w1));
                                $("#r_total_death_1y_bellow_5year_w1").html(convertE2B(json[0].r_total_death_1y_bellow_5year_w1));
                                $("#r_total_death_oth_all_w1").html(convertE2B(json[0].r_total_death_oth_all_w1));
                                $("#r_total_death_maternal_w1").html(convertE2B(json[0].r_total_death_maternal_w1));
                            }
                            
                            var params = {
                                d:$("select#district").val(),
                                u:$("select#upazila").val(),
                                un:$("select#union").val(),
                                w:$("select#ward").val()
                            };
                            
                            if(params.d=="93" && params.u=="66" && params.un=="13" && params.w=="0"){
                                exportBtn.css("display","block");
                            }
                            else{
                                exportBtn.css("display","none");
                            }
                            
                            
                            
                            
                        },
                         error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>অনুরোধটি প্রক্রিয়া করা যাচ্ছে না</b></h4>");
                        }
                    }); //End ajax request
                }); //End pace loading
            } //End Validation else
        }); //End showdataButton 
   
        
    });
    
    function  exportWarningModal(){

        if( $("select#district").val()===""){
            toastr["error"]("<h4><b>দয়া করে জেলা সিলেক্ট করুন</b></h4>");

        }else if( $("select#upazila").val()===""){
            toastr["error"]("<h4><b>দয়া করে উপজেলা সিলেক্ট করুন</b></h4>");

        }else if( $("select#union").val()===""){
            toastr["error"]("<h4><b>দয়া করে ইউনিয়ন সিলেক্ট করুন</b></h4>");
            
        }else if( $("select#month").val()===""){
            toastr["error"]("<h4><b>দয়া করে মাস সিলেক্ট করুন</b></h4>");
            
        }else if( $("select#year").val()===""){
            toastr["error"]("<h4><b>দয়া করে সন সিলেক্ট করুন</b></h4>");
            
        }else{
            $('#exportTODHIS2Warning').modal('show');
        }
    }
</script>
${sessionScope.designation=='HA'  && sessionScope.userLevel=='7'? 
    "<input type='hidden' id='isSubmitAccess' value='99'>" : "<input type='hidden' id='isSubmitAccess' value='66'>"}
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>HA progress report</h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <%@include file="/WEB-INF/jspf/HAAreaControls_EPI_Monthly.jspf" %>
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
                <h4 style="text-align: center;margin-top: 0px;" class="tableTitle bold">স্বাস্থ্য সেবা কার্যক্রমের মাসিক অগ্রগতির রিপোর্ট</h4>
                <div class="table-responsive">
                    <table class="ha-report-table  tg pull-center" style="width: 70%;font-size: 13px;" align="center">
                        <colgroup>
                            <col style="width: 50px">
                            <col style="width: 30px">
                            <col style="width: 30px">
                            <col style="width: 50px">
                        </colgroup>
                        <tr>
                            <th colspan="3">সেবার তথ্য</th>
                            <th id="setWard">ওয়ার্ড </th>
                        </tr>
                        <tr>
                            <td colspan="2" rowspan="3" style="text-align: left;">গর্ভবতী মায়ের সংখ্যা</td>
                            <td style="text-align: left;">নতুন</td>
                            <td id="r_preg_woman_new_w1"></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">পুরাতন </td>
                            <td id="r_preg_woman_old_w1"></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">মোট</td>
                            <td id="r_preg_woman_tot_w1"></td>
                        </tr>
                        <tr>
                            <td colspan="2" rowspan="4" style="text-align: left;">গর্ভকালীন সেবা</td>
                            <td style="text-align: left;">পরিদর্শন ১</td>
                            <td id="r_preg_service_anc_visit1_w1"></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">পরিদর্শন ২</td>
                            <td id="r_preg_service_anc_visit2_w1"></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">পরিদর্শন ৩</td>
                            <td id="r_preg_service_anc_visit3_w1"></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">পরিদর্শন ৪</td>
                            <td id="r_preg_service_anc_visit4_w1"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="text-align: left;">গর্ভকালীন সময়ে আয়রন ও ফলিক এসিড পেয়েছেন </td>
                            <td id="r_preg_iron_folic_acid_anc__w1"></td>
                        </tr>
                        <tr>
                            <td rowspan="3" style="text-align: left;">প্রসব</td>
                            <td rowspan="2" style="text-align: left;">বাড়িতে</td>
                            <td style="text-align: left;">দক্ষ কর্মী দ্বারা</td>
                            <td id="r_delivery_home_expert_w1"></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">অদক্ষ কর্মী দ্বারা</td>
                            <td id="r_delivery_home_unexpert_w1"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: left;"> ফ্যাসিলিটিতে</td>
                            <td id="r_delivery_facility_w1"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="text-align: left;">মিসোপ্রস্টল বড়ি খেয়েছেন কি না</td>
                            <td id="r_misoprostol_eaten_w1"></td>
                        </tr>
                        <tr>
                            <td colspan="2" rowspan="2" style="text-align: left;">প্রসবের ধরন</td>
                            <td style="text-align: left;">স্বাভাবিক</td>
                            <td id="r_delivery_patern_normal_w1"></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">সিজোরিয়ান</td>
                            <td id="r_delivery_patern_operation_w1"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="text-align: left;">জীবিত জন্ম</td>
                            <td id="r_live_birth_w1"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="text-align: left;">কম ওজন নিয়ে জন্ম নিয়েছে</td>
                            <td id="r_birth_less_weight_w1"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="text-align: left;">মৃত জন্ম</td>
                            <td id="r_death_birth_w1"></td>
                        </tr>
                        <tr>
                            <td colspan="2" rowspan="4" style="text-align: left;">প্রসবোত্তর সেবা</td>
                            <td style="text-align: left;">পরিদর্শন ১</td>
                            <td id="r_pnc_visit1_w1"></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">পরিদর্শন ২</td>
                            <td id="r_pnc_visit2_w1"></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">পরিদর্শন ৩</td>
                            <td id="r_pnc_visit3_w1"></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">পরিদর্শন ৪</td>
                            <td id="r_pnc_visit4_w1"></td>
                        </tr>
                        <tr>
                            <td rowspan="6" style="text-align: left;">মৃতের সংখ্যা</td>
                            <td colspan="2" style="text-align: left;">০ থেকে ৭ দিন </td>
                            <td id="r_total_death_0_7days_w1"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: left;">৮ থেকে ২৮ দিন</td>
                            <td id="r_total_death_8_28days_w1"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: left;">২৯ দিন থেকে ১ বছরের কম</td>
                            <td id="r_total_death_29d_bellow_1year_w1">-</td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: left;">১ বছর থেকে ৫ বছরের কম</td>
                            <td id="r_total_death_1y_bellow_5year_w1"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: left;">অন্যান্য সকল মৃত্যু</td>
                            <td id="r_total_death_oth_all_w1"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: left;">মাতৃমৃত্যু</td>
                            <td id="r_total_death_maternal_w1"></td>
                        </tr>
                        
                        <tr>
                            <td rowspan="14" style="text-align: left;">সংক্রামক রোগ</td>
                            <td rowspan="2" style="text-align: left;">ডায়রিয়া</td>
                            <td style="text-align: left;">পুরুষ</td>
                            <td>-</td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">মহিলা</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td rowspan="2" style="text-align: left;"><br>যক্ষ্মা</td>
                            <td style="text-align: left;">পুরুষ</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">মহিলা</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td rowspan="2" style="text-align: left;"><br>কুষ্ঠ</td>
                            <td style="text-align: left;">পুরুষ</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">মহিলা</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td rowspan="2" style="text-align: left;"><br>ফাইলেরিয়াসিস</td>
                            <td style="text-align: left;">পুরুষ</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">মহিলা</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td rowspan="2" style="text-align: left;"><br>কালাজ্বর</td>
                            <td style="text-align: left;">পুরুষ</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">মহিলা</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td rowspan="2" style="text-align: left;"><br>এ আর আই</td>
                            <td style="text-align: left;">পুরুষ</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">মহিলা</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td rowspan="2" style="text-align: left;"> অন্যান্য<br>(নির্দিষ্ট করুন)</td>
                            <td style="text-align: left;">পুরুষ</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">মহিলা</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td rowspan="4" style="text-align: left;">বিসিসি কার্যক্রম</td>
                            <td colspan="2" style="text-align: left;">পরিকল্পিত স্বাস্থ্য শিক্ষা সেশনের সংখ্যা</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: left;">সম্পাদিত স্বাস্থ্য শিক্ষা সেশনের সংখ্যা</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td rowspan="2" style="text-align: left;">উপস্থিতির সংখ্যা</td>
                            <td style="text-align: left;">পুরুষ</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">মহিলা</td>
                            <td></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

</section>

    <!--------------------------------------------------------------------------------   Export to DHIS warning -------------------------------------------------------------------------------->        
    <div class="modal fade" id="exportTODHIS2Warning" role="dialog">
      <div class="modal-dialog modal-sm">
        <div class="modal-content">
          <div class="modal-header label-primary">
              <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
            <h4 class="modal-title"><b><i class="fa fa-exclamation-circle" aria-hidden="true"></i><span>    &nbsp; Are you sure ?</span></b></h4>
          </div>
          <div class="modal-body">
            <button type="button" id="exportToDHIS2Button" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-primary">&nbsp;&nbsp;&nbsp;&nbsp;Yes&nbsp;&nbsp;&nbsp;&nbsp;</button>&nbsp;&nbsp;
            <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">&nbsp;&nbsp;&nbsp;&nbsp;No&nbsp;&nbsp;&nbsp;&nbsp;</button>
          </div>
        </div>
      </div>
    </div>

<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>