$(document).ready(function () {
    for (i = new Date().getFullYear()+2; i >= 2016; i--)
    {
        $('#year').append($('<option />').val(i).html(i));
    }
    
    for (i = new Date().getFullYear()+2; i >= new Date().getFullYear(); i--)
    {
        $('#epiCreateYear').append($('<option />').val(i).html(i));
    }
    $("#epiCreateYear").val((new Date()).getFullYear());
    
    epiTwelveMonthDates((new Date()).getFullYear());
    function epiTwelveMonthDates(year){
        
        //January
        $("#scheduleDateJanuary").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/01/"+year).datepicker('setEndDate', endDateOfSelectedMonth("01",year)+"/01/"+year);
        
        //February
        $("#scheduleDateFebruary").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/02/"+year).datepicker('setEndDate', endDateOfSelectedMonth("02",year)+"/02/"+year);
        
        //March
        $("#scheduleDateMarch").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/03/"+year).datepicker('setEndDate', endDateOfSelectedMonth("03",year)+"/03/"+year);
        
        //April
        $("#scheduleDateApril").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/04/"+year).datepicker('setEndDate', endDateOfSelectedMonth("04",year)+"/04/"+year);
        
        //May
        $("#scheduleDateMay").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/05/"+year).datepicker('setEndDate', endDateOfSelectedMonth("05",year)+"/05/"+year);
        
        //June
        $("#scheduleDateJune").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/06/"+year).datepicker('setEndDate', endDateOfSelectedMonth("06",year)+"/06/"+year);
        
        //July
        $("#scheduleDateJuly").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/07/"+year).datepicker('setEndDate', endDateOfSelectedMonth("07",year)+"/07/"+year);
        
        //August
        $("#scheduleDateAugust").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/08/"+year).datepicker('setEndDate', endDateOfSelectedMonth("08",year)+"/08/"+year);
        
        //Setember
        $("#scheduleDateSeptember").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/09/"+year).datepicker('setEndDate', endDateOfSelectedMonth("09",year)+"/09/"+year);
        
        //October
        $("#scheduleDateOctober").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/10/"+year).datepicker('setEndDate', endDateOfSelectedMonth("10",year)+"/10/"+year);
        
        //November
        $("#scheduleDateNovember").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/11/"+year).datepicker('setEndDate', endDateOfSelectedMonth("11",year)+"/11/"+year);
        
        //December
        $("#scheduleDateDecember").datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true
        }).datepicker('setStartDate', "01/12/"+year).datepicker('setEndDate', endDateOfSelectedMonth("12",year)+"/12/"+year);
    }
    function endDateOfSelectedMonth(month,year){
        return new Date(new Date(year,month,1).getFullYear(), new Date(year,month,1).getMonth(), 0).getDate();
    }
    
    $('#epiCreateYear').change(function (event) {
        epiTwelveMonthDates($('#epiCreateYear').val());
    });
    
    
    
    
    
    $.get("DivisionJsonProviderByUser", function (response) {
        var userLevel = $('#userLevel').val();
        
        var returnedData = JSON.parse(response);
        var selectTag = $('#division');
        selectTag.find('option').remove();
        //returnedData.length!=1 && 
        
        if(userLevel==='1'){
            $('<option>').val("").text('- Select Division -').appendTo(selectTag);
        }        
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].id;
            var name = returnedData[i].divisioneng;
            $('<option>').val(id).text(name).appendTo(selectTag);
        }
        
    });
    
$('#division').change(function (event) {

        var divisionId = $("select#division").val();
        
        if (divisionId === "" || divisionId ==='0') {
            var selectTag = $('#district');
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select District -').appendTo(selectTag);

            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("").text('- Select Upazila -').appendTo(selectTagUpazila);
            
            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- Select Union -').appendTo(selectTagUnion);
            
            var selectTagWard = $('#ward');
            selectTagWard.find('option').remove();
            $('<option>').val("").text('- Select Ward -').appendTo(selectTagWard);
            
            var selectTagSubblock = $('#subblock');
            selectTagSubblock.find('option').remove();
            $('<option>').val("").text('- Select Subblock -').appendTo(selectTagSubblock);
            
            $("#centerType").val($("#centerType option:first").val());
             $("#centerName").prop('readonly', false);
            $("#centerName").val("");
            
            
            
        }
        
        $.get('DistrictJsonProvider', {
            divisionId: divisionId
        }, function (response) {
            
            var returnedData = JSON.parse(response);
            
            var selectTag = $('#district');
            selectTag.find('option').remove();
            $('<option>').val("0").text('- Select District -').appendTo(selectTag);

            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("").text('- Select Upazila -').appendTo(selectTagUpazila);
            
            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- Select Union -').appendTo(selectTagUnion);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].zillaid;
                var name = returnedData[i].zillanameeng;
                $('<option>').val(id).text(name).appendTo(selectTag);
            }
        });
    });
    
    
    
    
//    $.get("DistrictJsonDataProvider", function (response) {
//        var returnedData = JSON.parse(response);
//        var selectTag = $('#district');
//        $('<option>').val(0).text('- Select District -').appendTo(selectTag);
//        for (var i = 0; i < returnedData.length; i++) {
//            var id = returnedData[i].zillaid;
//            var name = returnedData[i].zillanameeng;
//            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
//        }
//    });
    

    $('#district').change(function (event) {
        if ($('#centerName') != null && $('#centerName') != undefined && $('#centerName').length > 0) {
            resetDefaultSet();
        }

        var districtId = $("select#district").val();
        $.get('UpazilaJsonProvider', {
            districtId: districtId
        }, function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#upazila');
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select District -').appendTo(selectTag);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- Select Union -').appendTo(selectTagUnion);
            
            var selectTagWard = $('#ward');
            selectTagWard.find('option').remove();
            $('<option>').val("").text('- Select Ward -').appendTo(selectTagWard);
            
            var selectTagSubBlock = $('#subblock');
            selectTagSubBlock.find('option').remove();
            $('<option>').val("").text('- Select SubBlock -').appendTo(selectTagSubBlock);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].upazilaid;
                var name = returnedData[i].upazilanameeng;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });


    });

    $('#upazila').change(function (event) {
        if ($('#centerName') != null && $('#centerName') != undefined && $('#centerName').length > 0) {
            resetDefaultSet();
        }

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var selectTag = $('#union');

        if (upazilaId === "") {
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select Union -').appendTo(selectTag);
        } else {
            $.get('UnionJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId
            }, function (response) {
                var returnedData = JSON.parse(response);
                selectTag.find('option').remove();
                $('<option>').val("").text('- Select Union -').appendTo(selectTag);

                var selectTagWard = $('#ward');
                selectTagWard.find('option').remove();
                $('<option>').val("").text('- Select Ward -').appendTo(selectTagWard);

                var selectTagSubBlock = $('#subblock');
                selectTagSubBlock.find('option').remove();
                $('<option>').val("").text('- Select SubBlock -').appendTo(selectTagSubBlock);
                
                
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].unionid;
                    var name = returnedData[i].unionnameeng;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
        }
    });


    $('#union').change(function (event) {
        if ($('#centerName') != null && $('#centerName') != undefined && $('#centerName').length > 0) {
            resetDefaultSet();
        }

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();

        var selectTag = $('#subblock');
        var selectTag1 = $('#ward');

        if (upazilaId === "") {
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select Ward -').appendTo(selectTag);
        } else {
            $.get('HABlockJsonDataProvider',  function (response) {
                var returnedData = JSON.parse(response);
                selectTag.find('option').remove();
                $('<option>').val("").text('- Select SubBlock -').appendTo(selectTag);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].bcode;
                    var name = returnedData[i].bname + '[' +returnedData[i].bnameban +']';
                    $('<option>').val(id).text(name).appendTo(selectTag);
                }
            });
            
             $.get('HAWardJsonDataProvider',  function (response) {
                var returnedData = JSON.parse(response);
                selectTag1.find('option').remove();
                $('<option>').val("").text('- Select Ward -').appendTo(selectTag1);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].id;
                     var name = returnedData[i].name;
                     console.log(id+" - "+name);
                    $('<option>').val(id).text(name).appendTo(selectTag1);
                }
            });
            
      

//            $.ajax({
//                url: "ProviderJsonData",
//                data: {
//                    districtId: $("select#district").val(),
//                    upazilaId: $("select#upazila").val(),
//                    unionId: $("select#union").val()
//                },
//                type: 'POST',
//                success: function (response) {
//                    //alert("Hi");
//                    var selectTag = $('#provCode');
//
//                    var returnedData = JSON.parse(response);
//                    selectTag.find('option').remove();
//                    $('<option>').val("").text('All').appendTo(selectTag);
//                    for (var i = 0; i < returnedData.length; i++) {
//                        var id = returnedData[i].provcode;
//                        var name = returnedData[i].provname;
//                        $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
//                    }
//
//                }
//            });
        }
    });
     $('#subblock').change(function (event) {
        if ($('#centerName') != null && $('#centerName') != undefined && $('#centerName').length > 0) {
           resetDefaultSet();
       }
        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();
        var wardOld = $("select#ward").val();
        var subBlock = $("select#subblock").val();
        
        var centerName = $('#centerName');
        
        //Check EPI center is exist or not
        if (centerName != null && centerName != undefined && centerName.length > 0) {
            $.post('EPIJsonProvider?action=getExistingEPICenterName', {
                districtId: zilaId,
                upazilaId:upazilaId,
                unionId:unionId,
                wardOld:wardOld,
                subBlock:subBlock,
                year:null
            }, function (response) {
                var returnedData = JSON.parse(response);
                if(returnedData.length>0){
                    centerName.val(returnedData[0].centername);
                    centerName.prop('readonly', true);
                    $('#khanaFrom').val(returnedData[0].khananofrom);
                    $('#khanaTo').val(returnedData[0].khananoto);
                    $('#centerType').val(returnedData[0].centertype);
                }
            });
            
        }
        
      
        $.get('householdtotalbyhablock', {
            districtId: zilaId,
            upazilaId:upazilaId,
            unionId:unionId,
            wardOld:wardOld,
            subBlock:subBlock
        }, function (response) {
            var returnedData = JSON.parse(response);
            console.log(returnedData.count);
            $("#householdTotal").val(returnedData[0].count);
            $("#householdTotalTxt").val(returnedData[0].count);
        });
    });
            
            
    $("#provCode").change(function(){
        
        
    });
    
    $.get("barjsondataprovider", function (response) {
        var returnedData = JSON.parse(response);
        var selectTag1 = $('#bar1');
         var selectTag2 = $('#bar2');
        $('<option>').val("").text('১ম বার পছন্দ করুন').appendTo(selectTag1);
        $('<option>').val("").text('২য় বার পছন্দ করুন').appendTo(selectTag2);
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].id;
            var name = returnedData[i].name;
            $('<option>').val(id).text(name).appendTo(selectTag1);
            $('<option>').val(id).text(name).appendTo(selectTag2);
        }
    });

});


      
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
    
    function resetDefaultSet(){
        $('#centerName').val("");
        $('#centerName').prop('disabled', false);
        $('#khanaFrom').val("");
        $('#khanaTo').val("");
        $('#centerType').val("");
    }
             