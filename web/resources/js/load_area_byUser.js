$(document).ready(function () {

    
    $.get("pprsJsonForDistrict", function (response) {
        var returnedData = JSON.parse(response);
        var selectTag = $('#district1');
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].zillaid;
            var name = returnedData[i].zillanameeng;
            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
        }
    });
    
    $.get("helal", function (response) {
        var returnedData = JSON.parse(response);
        var selectTag = $('#upazila');
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].upazilaid;
            var name = returnedData[i].upazilanameeng;
            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
        }
    });
    


//    var upazilaId = $("select#upazila").val();
//    var zilaId = $("select#district").val();
//    
//
//    $.get('UnionJsonProvider', {
//        upazilaId: upazilaId, zilaId: zilaId
//    }, function (response) {
//        var returnedData = JSON.parse(response);
//        
//        var selectTag = $('#union');
//        
//        selectTag.find('option').remove();
//        $('<option>').val("").text('All').appendTo(selectTag);
//        for (var i = 0; i < returnedData.length; i++) {
//            var id = returnedData[i].unionid;
//            var name = returnedData[i].unionnameeng;
//            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
//        }
//    });

    $.get("unionJsonForPPRS", function (response) {
        var returnedData = JSON.parse(response);
        
        var selectTag = $('#union');
        selectTag.find('option').remove();
        $('<option>').val("").text('All').appendTo(selectTag);
        
        
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].unionid;
            var name = returnedData[i].unionnameeng;
            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
        }
    });
    
    $.get("pPRS_ReportType_JsonProvider", function (response) {
        var returnedData = JSON.parse(response);
        var typeLength=$('#typeLength').val();
        var selectTag = $('#type');
        for (var i = typeLength-1; i < returnedData.length; i++) {
            var id = returnedData[i].code;
            var name = returnedData[i].cname;
            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
        }
    });
    
});

