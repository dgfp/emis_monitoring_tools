<%-- 
    Document   : aefi
    Created on : Jan 17, 2018, 9:59:05 AM
    Author     : Rahen
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_mis1_bangla.js"></script>
<link href="resources/css/style.css" rel="stylesheet" type="text/css"/>
<style>
    @font-face {
        font-family: NikoshBAN;
        src: url('resources/fonts/NikoshBAN.ttf');
    }
    @font-face {
        font-family: SolaimanLipi;
        src: url('resources/fonts/SolaimanLipi.ttf');
    }
    .v_field{
        font-family: NikoshBAN;
        font-size: 18px;
    }
    #tableView{
        display: none;       
    }
    [class*="col"] { margin-bottom: 10px; }
</style>

<script>
   function getFWAUnit(value) {
	var data= { '01':"১", '02':"ক ১", '03': "খ ১", '04':"গ ১",'05':"২", '06':"ক ২",  '07':"খ ২", '08':"গ ২" ,'09':"৩", '10':"ক ৩",  '11':"খ ৩", '12':"গ ৩" };
   return data[value] ||"-";
}

function getAreaText() {
	var areaText = "";
	var division = " বিভাগ: <b style='color:#3C8DBC'>" + $("#division option:selected").text().split("[")[0] + "</b>";
	var district = " জেলা: <b style='color:#3C8DBC'>" + $("#district option:selected").text().split("[")[0] + "</b>";
	var upazila = "উপজেলা: <b style='color:#3C8DBC'>" + $("#upazila option:selected").text().split("[")[0] + "</b>";
	var union = "ইউনিয়ন: <b style='color:#3C8DBC'>" + $("#union option:selected").text().split("[")[0] + "</b>";
	var sDate = "শুরুর তারিখ: <b style='color:#3C8DBC'>" + convertE2B(startDate) + "</b>";
	var eDate = "শেষ তারিখ: <b style='color:#3C8DBC'>" + convertE2B($("#endDate").val()) + "</b>";
	areaText = division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + union + '&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate;
	return  areaText;
}
var Table = {
                  instance:null,
	head: {
                        _index: "#",
                        villagenameeng: "Village/ Mohalla",
                        unionname: "Union/ Urban Ward",
                        upzilaname: "Upazilla/ Municipality/ Zone",
                        zilaname: "District/ CC",
                        sex: "Sex (M/F)",
                        dob: "Date of Birth/ age",
                        vaccine: "Date of vaccine given",
                        aefidate: "Date of AEFI onset",
                        suspectimucode: "Suspected vaccine",
                        caseofaefi: "AEFI*",
                        hosp: "Hospitalization (Yes/No)",
                        death: "Death (Yes/No)",
                        caseofaefi: "Case reported from (C/F) **"
	},
	body: [],
	fn: {
                    sex: function (d) {
                            return { 1: 'M', 2: 'F' }[d];
                    }
	},
	format: function (d) {
                            return (d==0 || d=='0') ? d : d|| '-';
	},
	getTag: function (str, type) {
                            type = type || 'tr';
                            return '<' + type + '>' + str + '</' + type + '>';
	},
	getColumns:function(){
		return $.map(this.head,String).map(function(i,o){ return [o] });
	},
	getHead: function () {
		var self = this;
		var info = $.map(this.head, function (o) {
			return self.getTag(o, 'th');
		}).join('');
		return self.getTag(info, 'tr');
	},
	setHead: function () {
		$('#tableHeader').html(this.getHead());
	},
	setBody: function (data) {
		var self = this, data = data || [];
		//{data:[[],[],[]],columns:[[],[],[]]};
		self.data = {data:[],columns:[]};
		$.each(data, function (i, row) {
			var item = $.map(self.head, function (v, k) {
				var d = k == '_index' ? i + 1 : row[k];
				if (self.fn[k]) {
					d = self.fn[k].apply(self, [d, i]);
				}
				return self.format(d);
			});
			self.data.data.push(item);
		});
		self.data.columns= self.getColumns();
                                    if(self.instance){
                                        self.instance.destroy();
                                     }
                                    self.instance=$('#data-table').DataTable({data:self.data.data});
	}
}

    $(document).ready(function () {
        var defaultStartDate = "01/01/2014"; //for default date


        //======Elco data export system===============================================================================================
//======Print & PDF Data
        $('#printTableBtn').click(function () {
            //alert("Hey");
            //$('#printTable').printElement();
            var context='#data-table_length,#data-table_filter,#data-table_paginate,#data-table_info';
            var contents = $("#printTable").clone().find(context).remove().end().html();
            var frame1 = $('<iframe />');
            frame1[0].name = "frame1";
            frame1.css({"position": "absolute", "top": "-1000000px"});
            $("body").append(frame1);
            var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
            frameDoc.document.open();
            //Create a new HTML document.
            frameDoc.document.write('<html><head><title>eMIS Initiative</title>');

            frameDoc.document.write('</head><body>');
            //Append the external CSS file. //border-collapse: collapse;
            frameDoc.document.write('<style>table, th, td{font-family: SolaimanLipi;border:1px solid black; border-collapse: collapse;padding:10px; text-align:center;vertical-align: text-center;}th{vertical-align: text-center} td{text-align:left;font-family: SolaimanLipi;}</style>');
            //Append the DIV contents.
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center!important;"><center> Weekly line listing of AEFI cases </center></h3>');
            frameDoc.document.write('<h5 style="color:black!important;;text-align:center!important;"><center>' + getAreaText() + '</center></h5>');
            frameDoc.document.write(contents);
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 500);
        });


//======Export CSV using these function==========================================================
        $("#exportText").click(function (event) {
            var outputFile = "eMIS_FWA_Daily_Activity";
            outputFile = outputFile.replace('.txt', '') + '.txt';
            exportTableToText.apply(this, [$('#dvData table'), outputFile]); //function call from TemplateHeader
        });
//================================================END===================================== 
        Table.setHead();
        $('#showdataButton').click(function () {
            $("#tableView").fadeOut("slow");
            var tableBody = $('#tableBody');


            startDate = $("#startDate").val();
            if (startDate === "") {
                startDate = defaultStartDate;
            }

            //Report Validation---------------------------------------------------------------------------------------------------------------
            if ($("select#division").val() === "") {
                toastr["error"]("<h4><b>বিভাগ সিলেক্ট করুন </b></h4>");

            } else if ($("select#district").val() === "") {
                toastr["error"]("<h4><b>জেলা সিলেক্ট করুন </b></h4>");

            } else if ($("select#upazila").val() === "") {
                toastr["error"]("<h4><b>উপজেলা সিলেক্ট করুন</b></h4>");

            } else if ($("select#union").val() === "") {
                toastr["error"]("<h4><b>ইউনিয়ন সিলেক্ট করুন</b></h4>");

            } else if ($("select#unit").val() === "") {
                toastr["error"]("<h4><b>ইউনিট সিলেক্ট করুন</b></h4>");

            } else if ($("select#provCode").val() === "") {
                toastr["error"]("<h4><b>প্রোভাইডার সিলেক্ট করুন</b></h4>");

            } else {

                var btn = $(this).button('loading');
                Pace.track(function () {
                    $.ajax({
                        url: "AEFI",
                        data: {
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            startDate: startDate,
                            endDate: $("#endDate").val()
                        },
                        type: 'POST',
                        success: function (result) {
                            btn.button('reset');
                            var json = JSON.parse(result);

                            if (json.length === 0) {
                                toastr["error"]("<h4><b>No data found</b></h4>");
                                return;
                            }

                            $("#transparentTextForBlank").css("display", "none");
                            //show table view after data load
                            $("#tableView").fadeIn("slow");
                            Table.setBody(json);

//                            for (var i = 0; i < json.length; i++) {
//                                
//                                var services = json[i].services;
//                                var parsedData = "<tr><td>" + convertE2B((i + 1)) + "</td>"
//                                                        + "<td>" + json[i].provname + "</td>"
//                                                        + "<td>" + getFWAUnit(json[i].fwaunit) + "</td>"
//                                                        + "<td>-</td>"
//                                                        + "<td>" +  services.substring(1, services.length-1)+ "</td>";
//                                tableBody.append(parsedData);
//                            }
//                                
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            alert.append(getAlert("Request can't be processed", "danger"));
                        }
                    }); //End Ajax Call
                }); //end pace

            }//end else

        }); //End show data button click

    });


</script>
${sessionScope.designation=='FPI'  && sessionScope.userLevel=='5'? 
  "<input type='hidden' id='isProvider' value='1'>" : "<input type='hidden' id='isSubmitAccess' value='0'>"}
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle">
         Weekly AEFI cases <small id="isCSBA"></small>
    </h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <div class="row" id="areaPanel">
        <div class="col-md-12">
            <div class="box box-primary">
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
    <!--Transparent Text For Blank Space-->
    <section class="content-header" id="transparentTextForBlank" style="display: block;">
        <center class="emis_hologram">eMIS</center>
    </section>

    <!--------------------------------------------------------------------------------Data Table Goes Here-------------------------------------------------------------------------------->  
    <div class="box box-primary full-screen" id="tableView">
        <div class="box-header with-border">
            <div class="box-tools pull-right" style="margin-top: -10px;">
                <button id="printTableBtn" type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>
                <a href="#" id ="exportText" role='button' class="btn btn-box-tool"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Text</a>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body">
            <div class="row">
                <div class="col-sm-12" id="printTable">
                    <div id="dvData">
                        <table id="data-table" class="table table-bordered table-striped table-hover" align="center">
                            <thead id="tableHeader" class="data-table">

                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>        
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>