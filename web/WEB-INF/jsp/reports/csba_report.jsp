<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>

<script src="resources/js/area_dropdown_control_for_CSBA_HA.js"></script>

<script>
</script>
<style>
        .underDevTitle{
            display: block;
        }
        .tg  {border-collapse:collapse;border-spacing:0;}
        .tg td{font-family:Arial, sans-serif;font-size:13px;padding:3px 2px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
        .tg th{font-family:Arial, sans-serif;font-size:13px;font-weight:normal;padding:3px 2px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
        .tg .tg-0e45{font-size:11px}
        .tg .tg-q19q{font-size:11px;vertical-align:top}
        .tg .tg-yw4l{vertical-align:top}
        .center{
            text-align: center;
        }
        .left{
            text-align: left;
        }
        #tableView{
            display: none;
        }
        [class*="col"] { margin-bottom: 10px; }
</style>
<script>
        function getCurrentPreviousDate(currMonth,year){
        var preMonth = Number(currMonth)-1;
        var preYear = year;

        if(preMonth.toString().length==1)
          preMonth = "0"+preMonth;    
        if(currMonth=="01"){
            preMonth="12";
          preYear = Number(preYear)-1;
        }

        var current = new Date(year,currMonth,1);
        var previous = new Date(preYear,preMonth,1);
        var currLastDay  = new Date(current.getFullYear(), current.getMonth(), 0);
        var preLastDay = new Date(previous.getFullYear(), previous.getMonth(), 0);
        
        /*var currFirst=year+"-"+currMonth+"-"+"01";
        var currLast=year+"-"+currMonth+"-"+currLastDay.getDate();
        var preFirst=preYear+"-"+preMonth+"-"+"01";
        var preLast=preYear+"-"+preMonth+"-"+preLastDay.getDate();*/
        
        return year+"-"+currMonth+"-"+"01"+"~"+year+"-"+currMonth+"-"+currLastDay.getDate()+"~"+preYear+"-"+preMonth+"-"+"01"+"~"+preYear+"-"+preMonth+"-"+preLastDay.getDate();
    }
    $(document).ready(function () {
        $("#areaDropDownPanel").slideDown("slow"); 
        
        $('#printTableBtn').click(function () {
            //alert("Hey");
            //$('#printTable').printElement();
            var contents = $(".table-responsive").html();
            var frame1 = $('<iframe />');
            frame1[0].name = "frame1";
            frame1.css({ "position": "absolute", "top": "-1000000px" });
            $("body").append(frame1);
            var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
            frameDoc.document.open();
            //Create a new HTML document.
            frameDoc.document.write('<html><head><title>eMIS Initiative</title>');

            frameDoc.document.write('</head><body>');
            //Append the external CSS file. //border-collapse: collapse;
            frameDoc.document.write('<style>table, th, td{font-family: SolaimanLipi;border:1px solid black; border-collapse: collapse;padding:10px; text-align:center;vertical-align: text-center;}th{vertical-align: text-center} td{text-align:left;font-family: SolaimanLipi;}</style>');
            //Append the DIV contents.
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center!important;"><center>CSBA monthly progress report (Health)</center></h3>');
            frameDoc.document.write('<h5 style="color:black;text-align:center!important;"><center></center></h5>');
            frameDoc.document.write(contents);
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 500);
        });
        
        
        $("#showdataButton").click(function(){
            $("#tableView").css("display","none");
            $("#transparentTextForBlank").css("display","block");
                            
            if( $("select#division").val()===""){
	toastr["error"]("<h4><b>Please select division</b></h4>");

            }else if( $("select#district").val()===""){
                    toastr["error"]("<h4><b>Please select district</b></h4>");

            }else if( $("select#upazila").val()===""){
                    toastr["error"]("<h4><b>Please select upazila</b></h4>");

            }else if( $("select#union").val()===""){
                    toastr["error"]("<h4><b>Please select union</b></h4>");

            }else if( $("select#provider").val()===""){
                    toastr["error"]("<h4><b>Please select provider</b></h4>");

            }else if( $("select#month").val()===""){
                    toastr["error"]("<h4><b>Please select month</b></h4>");

            }else if( $("select#year").val()===""){
                    toastr["error"]("<h4><b>Please select year</b></h4>");

            }else{
                
                var btn = $(this).button('loading');
                //alert(getCurrentPreviousDate($("select#month").val(),$("#year").val()));
                
//Load own server=========================================================================================================
                Pace.track(function(){
                    $.ajax({
                        url: "csba_report",
                        data: {
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            providerCode: $("select#provider").val(),
                            date: getCurrentPreviousDate($("select#month").val(),$("#year").val())
                        },
                        type: 'POST',
                        dataType : "text",
                        //contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        success: function (data) {
                            btn.button('reset');
                            if (data.length === 0) {
                                toastr["error"]("<h4><b>No data found</b></h4>");
                                return;
                            }
                            
                           window.html = $(data).find('table').parent().html()
                           $('.table-responsive').html(html);
                           $('table').attr('align', 'center');
                           $("#transparentTextForBlank").css("display","none");
                            $("#tableView").fadeIn("slow");
                            
                            
                           //$('#table-responsive').replaceWith($('#table-responsive').html(data));
                        }, error: function( xhr, status ) {
                            
                            alert( "Sorry, there was a problem!" );
                        }
                    });
                });
                
                
            }
            
        });
    });
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>CSBA progress report (Health)<small id=""></small></h1>
</section>
<!-- Main content -->
<section class="content">
<!--    <div id="ajaxLoading">
    </div>-->
    <!------------------------------Load Area----------------------------------->
    <div class="row" id="areaDropDownPanel">
      <div class="col-md-12">
        <div class="box box-primary">
          <div class="box-body">
            <div class="row">
                <div class="col-md-1">
                    <label for="division">বিভাগ</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="division" id="division"> </select>
                </div>
                
                <div class="col-md-1">
                    <label for="district">জেলা</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="district" id="district"> 
                        <option value="">- সিলেক্ট করুন -</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="upazila">উপজেলা</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="upazila" id="upazila">
                        <option value="">- সিলেক্ট করুন -</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="union">ইউনিয়ন</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="union" id="union">
                        <option value="">- সিলেক্ট করুন -</option>
                    </select>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-1">
                    <label for="provider">প্রোভাইডার </label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="provider" id="provider" required>
                        <option value="">- সিলেক্ট করুন -</option>
                    </select>
                </div>
                
                <div class="col-md-1">
                    <label for="month">মাস</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="month" id="month">
                        <option value="01">জানুয়ারি</option>
                        <option value="02">ফেব্রুয়ারি</option>
                        <option value="03">মার্চ</option>
                        <option value="04">এপ্রিল</option>
                        <option value="05">মে</option>
                        <option value="06">জুন</option>
                        <option value="07">জুলাই</option>
                        <option value="08">আগষ্ট</option>
                        <option value="09">সেপ্টেম্বর</option>
                        <option value="10">অক্টোবর</option>
                        <option value="11">নভেম্বর</option>
                        <option value="12">ডিসেম্বর</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="year">বছর</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="year" id="year"> </select>
                </div>
                
                <div class="col-md-2 col-md-offset-1">        
                    <button type="button" id="showdataButton" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block" autocomplete="off" >
                        <b><i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; রিপোর্ট দেখুন</b>
                    </button>
                </div>
                          
          </div>
        </div>
      </div>
    </div>
    </div>
    
    <!--Transparent Text For Blank Space-->
    <section class="content-header" id="transparentTextForBlank" style="display: block;">
        <center class="emis_hologram">eMIS</center>
    </section>
    
    <div class="col-ld-12" id="tableView">
        <div class="box box-primary full-screen">
            <div class="box-header with-border">
                <div class="box-tools pull-right" style="margin-top: -10px;">
                    <button id="printTableBtn" type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                    <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                </div>
            </div>
            <div class="box-body">
                <div class="table-responsive">
                        <table style="text-align: center" class="daily_service_table tg" id="printTable">
                        <colgroup>
                            <col style="width: 151px">
                            <col style="width: 131px">
                            <col style="width: 551px">
                            <col style="width: 83px">
                        </colgroup>
                        <tr >
                            <th colspan="3">সেবার ধরণ<br></th>
                            <th>মোট<br></th>
                        </tr>
                        <tr>
                            <td rowspan="4">গর্ভকালীন সেবা<br></td>
                            <td colspan="2">পরিদর্শন ১ <br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2">পরিদর্শন ২<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2">পরিদর্শন ৩<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2">পরিদর্শন ৪<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td rowspan="5">প্রসবকালীন সেবা<br></td>
                            <td colspan="2">প্রসব করানো হয়েছে<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2">প্রসবের তৃতীয় ধাপে সক্রিয় ব্যবস্থাপনা (AMTSL) অনুসরণ করে প্রসব করানো হয়েছে <br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2">অক্সিটোসিন না থাকলে মিসোপ্রস্টল বড়ি খাওয়ানো হয়েছে<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2">জীবিত জন্মের সংখ্যা<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2">মৃত জন্মের সংখ্যা <br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td rowspan="7">নবজাতক সংক্রান্ত তথ্য<br></td>
                            <td rowspan="5">নবজাতকের তাৎক্ষণিক পরিচর্যা<br></td>
                            <td>১ মিনিটের মধ্যে মোছানো হয়েছে<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>নাড়িকাটার পর মায়ের ত্বকে লাগানো হয়েছে <br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>নাড়ি কাটার পর ৭.১% ক্লোরোহেক্সিডিন ব্যবহার করা হয়েছে<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>জন্মের ১ঘণ্টার মধ্যে বুকের দুধ খাওয়ানো হয়েছে<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>জন্মকালীন শ্বাসকষ্টে আক্রান্ত কতজনকে ব্যাগ ও মাস্ক ব্যবহার করে রিসাসসিটেট করা হয়েছে<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2">কম ওজন (২.৫ কেজির কম) নিয়ে জন্মগ্রহনকারী নবজাতক<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2">অপরিণত (৩৭ সপ্তাহের পূর্ণ হওয়ার আগে) নবজাতক<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td rowspan="9">প্রসবোত্তর সেবা<br></td>
                            <td rowspan="5">মা</td>
                            <td>পরিদর্শন ১ <br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>পরিদর্শন ২<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>পরিদর্শন ৩<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>পরিদর্শন ৪<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>প্রসব পরবর্তী পরিবার পরিকল্পনা গ্রহণকারীর সংখ্যা<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td rowspan="4">নবজাতক</td>
                            <td>পরিদর্শন ১</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>পরিদর্শন ২<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>পরিদর্শন ৩ <br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>পরিদর্শন ৪ <br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td rowspan="3">রেফার</td>
                            <td colspan="2">গর্ভকালীন, প্রসবকালীন ও প্রসবোত্তর জটিলতার জন্য রেফার করা হয়েছে<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2">একলাম্পসিয়া রোগীকে MgSO4 ইনজেকশন দিয়ে রেফার করা হয়েছে<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2">নবজাতককে জটিলতার জন্য রেফার করা হয়েছে<br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="3">নবজাতকের মৃত্যুর সংখ্যা <br></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="3">মাতৃমৃত্যুর সংখ্যা <br></td>
                            <td></td>
                        </tr>
                    </table>
                    
                </div>
            </div>
        </div>
    </div>
</section>

<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
