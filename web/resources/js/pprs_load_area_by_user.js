$(document).ready(function () {

    //-----------------------------Load Area By AJAX----------------------------
    
    //load Report type----------------------------------------------------------------
    $.get("pPRS_ReportType_JsonProvider", function (response) {
        var returnedData = JSON.parse(response);
        var typeLength=$('#typeLength').val();
        var selectTag = $('#type');
        for (var i = typeLength-1; i < returnedData.length; i++) {
            var id = returnedData[i].code;
            var name = returnedData[i].cname +" Wise";
            $('<option >').val(id).text(name).appendTo(selectTag);
        }
    });
    
    //Load Division-------------------------------------------------------------
    $.get("pprsJsonForDivision", function (response) {
        var userType = $('#typeLength').val();
        
        var returnedData = JSON.parse(response);
        var selectTag = $('#division');
        selectTag.find('option').remove();
        //returnedData.length!=1 && 
        
        if(userType==='1'){
            $('<option>').val("").text('All').appendTo(selectTag);
        }
        
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].id;
            var name = returnedData[i].divisioneng;
            $('<option>').val(id).text(name).appendTo(selectTag);
        }
    });

    //Load District-------------------------------------------------------------
    $.get("pprsJsonForDistrict", function (response) {
        var userType = $('#typeLength').val();
        
        var returnedData = JSON.parse(response);
        var selectTag = $('#district');
        selectTag.find('option').remove();
        
        if(userType==='2'){
            $('<option>').val("").text('All').appendTo(selectTag);
        }
        

        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].zillaid;
            var name = returnedData[i].zillanameeng;
            $('<option>').val(id).text(name).appendTo(selectTag);
        }
        

    });
    
    //Load Upazila--------------------------------------------------------------
    $.get("pprsJsonForUpazila", function (response) {
        var returnedData = JSON.parse(response);
        var selectTag = $('#upazila');
        selectTag.find('option').remove();
        
        if(returnedData.length!==1){
            $('<option>').val("").text('All').appendTo(selectTag);
        }
        
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].upazilaid;
            var name = returnedData[i].upazilanameeng;
            $('<option>').val(id).text(name).appendTo(selectTag);
        }
    });
    
    //Load Union----------------------------------------------------------------
    $.get("unionJsonForPPRS", function (response) {
        var returnedData;
        if(response!=null){
            returnedData = JSON.parse(response);
        }
        
        var selectTag = $('#union');
        selectTag.find('option').remove();
        
        if(returnedData.length!==1){
            $('<option>').val("").text('All').appendTo(selectTag);
        }
        
        
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].unionid;
            var name = returnedData[i].unionnameeng;
            $('<option>').val(id).text(name).appendTo(selectTag);
        }
    });
    
    
    //Load Village--------------------------------------------------------------
    $.get("pprsJsonForVillage", function (response) {
        var returnedData = JSON.parse(response);
        var selectTag = $('#village');
        selectTag.find('option').remove();
        
        if(returnedData.length!==1){
            $('<option>').val("").text('All').appendTo(selectTag);
        }
        
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].mouzaid + '' + returnedData[i].villageid;
            var name = returnedData[i].villagenameeng;
            $('<option>').val(id).text(name).appendTo(selectTag);
        }
    });
    
    
    
    //--------------------------------Change Event------------------------------
    
    //Load district from division------------------------------------------------
    $('#division').change(function (event) {

        var divisionId = $("select#division").val();
        
        $.get('DistrictJsonProvider', {
            divisionId: divisionId
        }, function (response) {
            
            var returnedData = JSON.parse(response);
            
            var selectTag = $('#district');
            selectTag.find('option').remove();
            $('<option>').val("").text('All').appendTo(selectTag);

            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("").text('All').appendTo(selectTagUpazila);
            
            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('All').appendTo(selectTagUnion);
            
            var selectTagVillage = $('#village');
            selectTagVillage.find('option').remove();
            $('<option>').val("").text('All').appendTo(selectTagVillage);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].zillaid;
                var name = returnedData[i].zillanameeng;
                $('<option>').val(id).text(name).appendTo(selectTag);
            }
        });
    });
 
    //Load Upazila from district------------------------------------------------
    $('#district').change(function (event) {

        var districtId = $("select#district").val();
        $.get('UpazilaJsonProvider', {
            districtId: districtId
        }, function (response) {
            
            var returnedData = JSON.parse(response);
            
            var selectTag = $('#upazila');
            selectTag.find('option').remove();
            $('<option>').val("").text('All').appendTo(selectTag);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('All').appendTo(selectTagUnion);
            
            var selectTagVillage = $('#village');
            selectTagVillage.find('option').remove();
            $('<option>').val("").text('All').appendTo(selectTagVillage);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].upazilaid;
                var name = returnedData[i].upazilanameeng;
                $('<option>').val(id).text(name).appendTo(selectTag);
            }
        });
    });
    
    
    //Laod Union from upazila---------------------------------------------------
    $('#upazila').change(function (event) {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var selectTag = $('#union');
        
        var selectTagVillage = $('#village');
        selectTagVillage.find('option').remove();
        $('<option>').val("").text('All').appendTo(selectTagVillage);

        if (upazilaId === "") {
            selectTag.find('option').remove();
            $('<option>').val("").text('All').appendTo(selectTag);
        } else {
            $.get('UnionJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId
            }, function (response) {
                
                var returnedData = JSON.parse(response);
                selectTag.find('option').remove();
                $('<option>').val("").text('All').appendTo(selectTag);
                             
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].unionid;
                    var name = returnedData[i].unionnameeng;
                    $('<option>').val(id).text(name).appendTo(selectTag);
                }
            });
        }
    });
    
    
    //Load village from Union---------------------------------------------------
    $('#union').change(function (event) {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();

        var selectTag = $('#village');

        if (upazilaId === "") {
            selectTag.find('option').remove();
            $('<option>').val("").text('All').appendTo(selectTag);
        } else {
            $.get('VillageJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId, unionId: unionId
            }, function (response) {
                var returnedData = JSON.parse(response);
                selectTag.find('option').remove();
                $('<option>').val("").text('All').appendTo(selectTag);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].mouzaid + '' + returnedData[i].villageid;
                    var name = returnedData[i].villagenameeng;
                    $('<option>').val(id).text(name).appendTo(selectTag);
                }
            });

            $.ajax({
                url: "ProviderJsonData",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: $("select#union").val()
                },
                type: 'POST',
                success: function (response) {
                    //alert("Hi");
                    var selectTag = $('#provCode');

                    var returnedData = JSON.parse(response);
                    selectTag.find('option').remove();
                    $('<option>').val("").text('All').appendTo(selectTag);
                    for (var i = 0; i < returnedData.length; i++) {
                        var id = returnedData[i].provcode;
                        var name = returnedData[i].provname;
                        $('<option>').val(id).text(name).appendTo(selectTag);
                    }

                }
            });
        }
    });
    
         
});