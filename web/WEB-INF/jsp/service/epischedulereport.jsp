<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/header.jspf" %>
<script src="resources/js/jspdf.min.js"></script>
<link href="resources/css/style.css" rel="stylesheet" type="text/css"/>
<script src="resources/js/area_dropdown_control_mis.js"></script>
<script>

      function upazilaAndUnionSelected() {

        var upazilaId = $("select#upazila").val();
        var unionId = $("select#union").val();
        var wardId = $("select#ward").val();
        var year = $("select#year").val();
        var message = "";
        var error = false;



        if (upazilaId.length === 0) {
            message += "Select a specific Upazila\n";
            error = true;
        }
        if (unionId.length === 0) {
            message += "Select a specific Union\n";
            error = true;
        }
      
        if (year.length === 0) {
            message += "Select a year\n ";
            error = true;
        }
        if (error === true) {
            alert(message);
            return false;
        } else {
            return true;
        }
    }
  function getType(centerId) {
        if (centerId == 1) {
            return "অস্থায়ী";
        } else if (centerId == 2) {
            return "স্থায়ী";
        } else if (centerId == 3) {
            return "স্যাটালাইট";
        }
        else if (centerId == 4) {
            return "সিসি";
        } else if (centerId == 5) {
            return "উপস্বাস্থ্য কেন্দ্র";
        }
        else if (centerId == 6) {
            return "এফডব্লিউসি";
        }
    }
    function getBlock(blockId) {
        if (blockId == 1) {
            return "ক ১";
        } else if (blockId == 2) {
            return "ক ২";
        } else if (blockId == 3) {
            return "খ ১";
        } else if (blockId == 4) {
            return "খ ২";
        } else if (blockId == 5) {
            return "গ ১";
        } else if (blockId == 6) {
            return "গ ২";
        } else if (blockId == 7) {
            return "ঘ ১";
        } else if (blockId == 8) {
            return "ঘ ২";
        }
    }
    function geWard(wardId) {
        if (wardId == 1) {
            return "Ward-1";
        } else if (wardId == 2) {
            return "Ward-2";
        } else if (wardId == 3) {
            return "Ward-3";
        }

    }
    function nullToBlank(value) {
         if(value=="null"){
            return "-";
        }
         else{
            return value;
        }
    }
    
     function hafwaByWard(ward,hafwa){
        var fafwanew = [];
        for( var i= 0; i<hafwa.length; i++) {
            var el = hafwa[i];

            if( el.ward==ward) {
                fafwanew.push( el );
            }
        }
        return fafwanew;
    }
    
    
                    
                    
    $(document).ready(function () {

        $('#btnShowSession').click(function () {
            if (!upazilaAndUnionSelected()) {
                return;
            }
            var btn = $(this).button('loading');
            $('#sessionTableData').empty();
            $.ajax({
                url: "episessionreportbyward",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: $("select#union").val(),
                    year: $("select#year").val()
                },
                type: 'POST',
                success: function (result) {
                    var unionId = $("#union option:selected").val();
                    var unionValue = $("#union option:selected").text();
                    var upazilaId =  $("#upazila option:selected").val();
                    var upazilaValue =  $("#upazila option:selected").text();
                     var districtId = $("#district option:selected").val();
                    var districtValue = $("#district option:selected").text();
                    var yearValue = $("#year option:selected").text();
                    $("#unionName").html(unionValue);
                    $("#upzName").html(upazilaValue);
                    $("#districtName").html(districtValue);
                   
                    
                        //console.log(unionId+" " +upazilaId+" "+districtId);
                    var data = JSON.parse(result);
                    var json = data.epi;
                    var provid = data.provider;
                    var bar = data.bar[0];
                     $("#barName").html(bar.cname+", "+bar.cname1);
                    var hi=[];
                    var ahi = [];
                    var hafwa=[]
                    for( var i= 0, len = provid.length; i < len; i++) {
                        var el = provid[i];
                        
                        if( el.provtype == 2 || el.provtype ==3 ) {
                            hafwa.push( el );
                            
                        }else if(el.provtype==12){
                            hi.push(el);
                        }else if(el.provtype==11){
                            ahi.push(el);
                        }
                    }
                    
                   
                    var j=0;
                    for (var i = 0; i < json.length; i++) {
                        var j = i+1;
                        var parsedData = "<tr>";
                                //+"<td>" + (i + 1) + "</td>"
                               if(j%8==1){
                                     parsedData += "<td rowspan=8> " + geWard(json[i].wordold) + "</td>";
                                 }
                            parsedData += "<td> " + getBlock(json[i].subblockid) + "</td>";
                                 parsedData += "<td style='text-align:left'> " + json[i].centername + "</td>";
                                parsedData += "<td> " + json[i].khananofrom + "</td>";
                                  parsedData +=  "<td> " + json[i].khananoto + "</td>";
                                 parsedData +=  "<td> " + getType(json[i].centertype) + "</td>";
                                 parsedData +=  "<td> " + nullToBlank(json[i].january) + "</td>";
                                 parsedData +=  "<td> " + nullToBlank(json[i].february) + "</td>";
                                 parsedData +=  "<td> " + nullToBlank(json[i].march) + "</td>";
                                 parsedData +=  "<td> " + nullToBlank(json[i].april) + "</td>";
                                 parsedData +=  "<td> " + nullToBlank(json[i].may) + "</td>";
                                 parsedData +=  "<td> " + nullToBlank(json[i].june) + "</td>";
                                 parsedData +=  "<td> " + nullToBlank(json[i].july) + "</td>";
                                 parsedData +=  "<td> " + nullToBlank(json[i].august) + "</td>";
                                 parsedData +=  "<td> " + nullToBlank(json[i].september) + "</td>";
                                 parsedData +=  "<td> " + nullToBlank(json[i].october) + "</td>";
                                 parsedData +=  "<td> " + nullToBlank(json[i].november) + "</td>";
                                 parsedData +=  "<td> " + nullToBlank(json[i].december) + "</td>";
                                  if(j%8==1){
                                      var fwahaData1 = hafwaByWard(json[i].wordold,hafwa);
                                     
                                     parsedData += "<td rowspan=8> <ol style='padding-left:30px;text-align:left;list-style-type:number'>" ;
                                    
                                     for(var l=0;l<fwahaData1.length;l++){
                                          
                                         parsedData +="<li style=list-style-type: number;padding:0'>";
                                         parsedData +=fwahaData1[l].provname+"("+fwahaData1[l].typename+")<br/>";
                                         parsedData +=fwahaData1[l].mobileno;
                                         parsedData +="</li>";
                                     }
                                      
                                    parsedData += "</ol></td>";
                                 }

                                //  + "<td><a href='' class='delete' >delete</a></td>"
                                  parsedData += "</tr>";


                        $('#sessionTableData').append(parsedData);
                       
                    }
                    var inspectorCount = 0;
                    
                    var inspector ="<p>";
                   inspector+="তদারককারী:  ";
                   
                    if(hi.length>0){
                        inspectorCount++;
                        inspector+="  "+ inspectorCount+": ";
                        inspector+=hi[0].provname+", পদবী - "+hi[0].typename+", ( "+hi[0].mobileno+" )";
                    }
                    if(ahi.length>0){
                            inspectorCount++;
                            inspector+="  "+ inspectorCount+": ";
                            inspector+=ahi[0].provname+", পদবী - "+ahi[0].typename+", ( "+ahi[0].mobileno+" )";
                      }
                    inspector +="</p>";
                     $('#inspectorDataList').html(inspector);
                    btn.button('reset');
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    btn.button('reset');
                    alert("Error while fetching data");
                }
            });
        });

    });
</script>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3> ইপিআই সেশন </h3>
        </div>
    </div>
        <div class="well well-sm">

            <div class="row">
              

                <div class="col-md-1">
                    <label for="year">Year</label>
                </div>

                <div class="col-md-2">
                    <select class="form-control input-sm" name="year" id="year"> </select>
                </div>


         
          

          

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
                        <option value="">All</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="union">Union</label>
                </div>

                <div class="col-md-2">
                    <select class="form-control input-sm" name="union" id="union">
                        <option value="">All</option>
                    </select>
                </div>




            </div>

           

            <br/>

            <div class="row">
                <div class="col-md-2 col-md-offset-1">
                    <!--            <div class="col-md-2 col-md-offset-1">-->
                    <button type="button" id="btnShowSession" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-sm btn-success btn-block" autocomplete="off">
                        Show data
                    </button>
                </div>
            </div>

            <br/>          
        </div> 
    
    
    
    <div class="row">
    <div class="col-ld-12">
        <div class="table-responsive">
           
            <table style="width: 1300px" class="mis_table">
                
                <colgroup>
                    <col style="width: 50px">
                    <col style="width: 30px">
                    <col style="width: 250px;text-align:left;">
                    <col style="width: 55px">
                    <col style="width: 55px">
                    <col style="width: 55px">
                    <col style="width: 55px">
                    <col style="width: 55px">
                    <col style="width: 55px">
                    <col style="width: 54px">
                    <col style="width: 54px">
                    <col style="width: 54px">
                    <col style="width: 55px">
                    <col style="width: 54px">
                    <col style="width: 54px">
                    <col style="width: 53px">
                    <col style="width: 54px">
                    <col style="width: 54px">
                    <col style="width: 230px">
                </colgroup>
                <thead>
                <tr>
                    <th colspan="19">
                        ফর্ম ২।৮ঃ ওয়ার্ড ভিত্তিক সেশন পরিকল্পনা (উপজেলা) <br/>
                        ইউনিয়নঃ <span id="unionName"></span>,
                        উপজেলাঃ  <span id="upzName"></span>, 
                        জেলাঃ<span id="districtName"></span>,
                        বৎসরঃ <span id="yearName"></span>,
                        সাপ্তাহিক টিকার দিন  (বার )-
                        <span id="barName"></span>
                    </th>
                </tr>
                
                <tr>
                    <td rowspan="2">ওয়ার্ড নং</td>
                    <td rowspan="2">ব্লক / সাইট</td>
                    <td rowspan="2">কেন্দ্রের নাম ও ঠিকানা</td>
                  
                    <td colspan ="2">বাড়ি নং</td>
                      <td rowspan="2"> কেন্দ্রের ধরন (স্থায়ী/ অস্থায়ী/ স্যাটালাইট) </td>
                    <td colspan="12"  rowspan="1">তারিখ</td>
                    <td colspan="1" rowspan="2">কর্মীর নাম ও পদবী</td>
                  
                </tr>
               
               
                
                <tr>
                     <td rowspan="1">হতে </td>
                    <td rowspan="1">পর্যন্ত</td>
                    <td rowspan="1">জা</td>
                    <td rowspan="1">ফে</td>
                    <td rowspan="1">মা</td>
                    <td rowspan="1"> এ</td>
                    <td rowspan="1">মে</td>
                    <td rowspan="1"> জু </td>
                    <td rowspan="1"> জু </td>
                    <td rowspan="1"> আ </td>
                    <td rowspan="1">সে </td>
                    <td rowspan="1"> অ </td>
                    <td rowspan="1">ন </td>
                    <td rowspan="1"> ডি </td>
                    
                </tr>
                 </thead>
                 <tbody id="sessionTableData">
                <tr>
                    <td rowspan=8>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                 <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                 <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                 <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                 <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                 <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                 <tr>
                    <td rowspan=8>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                 <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                 <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                 <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                 <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                 <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                 <tr>
                    <td rowspan=8>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                 <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                 <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                 <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                 <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                 <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                </tbody>
               
            </table>
            <div id="inspectorDataList"></div>
        </div>
    </div>
       
    </div>
</div>

<%@include file="/WEB-INF/jspf/footer.jspf" %>
