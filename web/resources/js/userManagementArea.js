function clear() {
    alert("Hello");
}

$(document).ready(function () {


    showHide(false, false, false, false, false);

//=================================================Area Drop Download=====================================================
//
//    $('#userLevel').change(function (event) {
//
//        var divisionId = $("select#userLevel").val();
//        
//        if(divisionId>1){
//            $.get("pprsJsonForDivision", function (response) {
//                var userType = $('#typeLength').val();
//
//                var returnedData = JSON.parse(response);
//                var selectTag = $('#division');
//                selectTag.find('option').remove();
//                $('<option>').val("").text('- Select Division -').appendTo(selectTag);
//
//                for (var i = 0; i < returnedData.length; i++) {
//                    var id = returnedData[i].id;
//                    var name = returnedData[i].divisioneng;
//                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
//            }
//    });
//            
//        }
//        
////        $.get('DistrictJsonProvider', {
////            divisionId: divisionId
////        }, function (response) {
////            
////            var returnedData = JSON.parse(response);
////            
////            var selectTag = $('#district');
////            selectTag.find('option').remove();
////            $('<option>').val("").text('- Select District -').appendTo(selectTag);
////
////            var selectTagUpazila = $('#upazila');
////            selectTagUpazila.find('option').remove();
////            $('<option>').val("").text('- Select Upazila -').appendTo(selectTagUpazila);
////
////            var selectTagUnion = $('#union');
////            selectTagUnion.find('option').remove();
////            $('<option>').val("").text('- Select Union -').appendTo(selectTagUnion);
////            
////            var selectTagVillage = $('#village');
////            selectTagVillage.find('option').remove();
////            $('<option>').val("").text('- Select Village -').appendTo(selectTagVillage);
////
////            for (var i = 0; i < returnedData.length; i++) {
////                var id = returnedData[i].zillaid;
////                var name = returnedData[i].zillanameeng;
////                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
////            }
////        });
//    });


    //Load Designation-------------------------------------------------------------
    $.get("DesignationJsonProvider", function (response) {

        var returnedData = JSON.parse(response);
        var selectTag = $('#designation');
        selectTag.find('option').remove();
        $('<option>').val("").text('- Select Designation -').appendTo(selectTag);

        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].id;
            var name = returnedData[i].designame;
            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
        }
    });


    //Load Division-------------------------------------------------------------
    $.get("DivisionJsonProvider", function (response) {
        var userType = $('#typeLength').val();

        var returnedData = JSON.parse(response);
        var selectTag = $('#division');
        selectTag.find('option').remove();
        $('<option>').val("0").text('- Select Division -').appendTo(selectTag);

        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].id;
            var name = returnedData[i].divisioneng;
            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
        }
    });


    $('#division').change(function (event) {

        var divisionId = $("select#division").val();

        $.get('DistrictJsonProvider', {
            divisionId: divisionId
        }, function (response) {

            var returnedData = JSON.parse(response);

            var selectTag = $('#district');
            selectTag.find('option').remove();
            $('<option>').val("0").text('- Select District -').appendTo(selectTag);

            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("0").text('- Select Upazila -').appendTo(selectTagUpazila);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("0").text('- Select Union -').appendTo(selectTagUnion);

            var selectTagVillage = $('#village');
            selectTagVillage.find('option').remove();
            $('<option>').val("0").text('- Select Village -').appendTo(selectTagVillage);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].zillaid;
                var name = returnedData[i].zillanameeng;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });
    });


    $('#district').change(function (event) {

        var districtId = $("select#district").val();
        $.get('UpazilaJsonProvider', {
            districtId: districtId
        }, function (response) {
            var returnedData = JSON.parse(response);

            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("0").text('- Select Upazila -').appendTo(selectTagUpazila);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("0").text('- Select Union -').appendTo(selectTagUnion);

            var selectTagVillage = $('#village');
            selectTagVillage.find('option').remove();
            $('<option>').val("0").text('- Select Village -').appendTo(selectTagVillage);


            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].upazilaid;
                var name = returnedData[i].upazilanameeng;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTagUpazila);
            }
        });


    });


    $('#upazila').change(function (event) {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var selectTag = $('#union');

        if (upazilaId === "") {
            selectTag.find('option').remove();
            $('<option>').val("0").text('----').appendTo(selectTag);
        } else {
            $.get('UnionJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId
            }, function (response) {
                var returnedData = JSON.parse(response);
                selectTag.find('option').remove();

                var selectTagUnion = $('#union');
                selectTagUnion.find('option').remove();
                $('<option>').val("0").text('- Select Union -').appendTo(selectTagUnion);

                var selectTagVillage = $('#village');
                selectTagVillage.find('option').remove();
                $('<option>').val("0").text('- Select Village -').appendTo(selectTagVillage);


                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].unionid;
                    var name = returnedData[i].unionnameeng;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
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
            $('<option>').val("0").text('All').appendTo(selectTag);
        } else {
            $.get('VillageJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId, unionId: unionId
            }, function (response) {
                var returnedData = JSON.parse(response);

                var selectTag = $('#village');
                selectTag.find('option').remove();
                $('<option>').val("0").text('- Select Village -').appendTo(selectTag);

                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].villageid;
                    var name = returnedData[i].villagenameeng;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
        }
    });


    //=======================================Show Hide Area by user level===================================================

//        //Enable dropdown for Parameter  using type change combo
    $('select#userLevel').change(function (event) {
        var type = $("select#userLevel").val();
//            var selectDivisionTag = $('#division');
//            selectDivisionTag.find('option').remove();
//            $('<option>').val("0").text('- Select Division -').appendTo(selectDivisionTag);

        var selectTag = $('#district');
        selectTag.find('option').remove();
        $('<option>').val("0").text('- Select District -').appendTo(selectTag);

        var selectTagUpazila = $('#upazila');
        selectTagUpazila.find('option').remove();
        $('<option>').val("0").text('- Select Upazila -').appendTo(selectTagUpazila);

        var selectTagUnion = $('#union');
        selectTagUnion.find('option').remove();
        $('<option>').val("0").text('- Select Union -').appendTo(selectTagUnion);

        var selectTagVillage = $('#village');
        selectTagVillage.find('option').remove();
        $('<option>').val("0").text('- Select Village -').appendTo(selectTagVillage);

        if (type === '0') {
            //division-district-upazila-union-village
            showHide(false, false, false, false, false);

        } else if (type === '1') {
            //division-district-upazila-union-village
            showHide(false, false, false, false, false);

        } else if (type === '2') {
            //division-district-upazila-union-village
            showHide(true, false, false, false, false);

        } else if (type === '3') {
            //division-district-upazila-union-village
            showHide(true, true, false, false, false);

        } else if (type === '4') {

            //division-district-upazila-union-village
            showHide(true, true, true, false, false);

        } else if (type === '5') {
            //division-district-upazila-union-village
            showHide(true, true, true, true, false);

        } else if (type === '6') {
            //division-district-upazila-union-village
            showHide(true, true, true, true, true);

        }
    });
    //Drop down show hide 
    function showHide(division, district, upazila, union, village) {
        if (division) {
            $("#division").show();
            $("#divisionLbl").show();
        } else {
            $("#division").hide();
            $("#divisionLbl").hide();
        }

        if (district) {
            $("#district").show();
            $("#districtLbl").show();
        } else {
            $("#district").hide();
            $("#districtLbl").hide();
        }

        if (upazila) {
            $("#upazila").show();
            $("#upazilaLbl").show();
        } else {
            $("#upazila").hide();
            $("#upazilaLbl").hide();
        }

        if (union) {
            $("#union").show();
            $("#unionLbl").show();
        } else {
            $("#union").hide();
            $("#unionLbl").hide();
        }

        if (village) {
            $("#village").show();
            $("#villageLbl").show();
        } else {
            $("#village").hide();
            $("#villageLbl").hide();
        }

    }





//    //Load District-------------------------------------------------------------
//    $.get("pprsJsonForDistrict", function (response) {
//        var userType = $('#typeLength').val();
//        
//        var returnedData = JSON.parse(response);
//        var selectTag = $('#district');
//        selectTag.find('option').remove();
//        
//        if(userType==='2'){
//            $('<option>').val("").text('All').appendTo(selectTag);
//        }
//        
//
//        for (var i = 0; i < returnedData.length; i++) {
//            var id = returnedData[i].zillaid;
//            var name = returnedData[i].zillanameeng;
//            $('<option>').val(id).text(name).appendTo(selectTag);
//        }
//        
//
//    });
//    
//    //Load Upazila--------------------------------------------------------------
//    $.get("pprsJsonForUpazila", function (response) {
//        var returnedData = JSON.parse(response);
//        var selectTag = $('#upazila');
//        selectTag.find('option').remove();
//        
//        if(returnedData.length!==1){
//            $('<option>').val("").text('All').appendTo(selectTag);
//        }
//        
//        for (var i = 0; i < returnedData.length; i++) {
//            var id = returnedData[i].upazilaid;
//            var name = returnedData[i].upazilanameeng;
//            $('<option>').val(id).text(name).appendTo(selectTag);
//        }
//    });
//    
//    //Load Union----------------------------------------------------------------
//    $.get("unionJsonForPPRS", function (response) {
//        var returnedData;
//        if(response!=null){
//            returnedData = JSON.parse(response);
//        }
//        
//        var selectTag = $('#union');
//        selectTag.find('option').remove();
//        
//        if(returnedData.length!==1){
//            $('<option>').val("").text('All').appendTo(selectTag);
//        }
//        
//        
//        for (var i = 0; i < returnedData.length; i++) {
//            var id = returnedData[i].unionid;
//            var name = returnedData[i].unionnameeng;
//            $('<option>').val(id).text(name).appendTo(selectTag);
//        }
//    });
//    
//    
//    //Load Village--------------------------------------------------------------
//    $.get("pprsJsonForVillage", function (response) {
//        var returnedData = JSON.parse(response);
//        var selectTag = $('#village');
//        selectTag.find('option').remove();
//        
//        if(returnedData.length!==1){
//            $('<option>').val("").text('All').appendTo(selectTag);
//        }
//        
//        for (var i = 0; i < returnedData.length; i++) {
//            var id = returnedData[i].mouzaid + '' + returnedData[i].villageid;
//            var name = returnedData[i].villagenameeng;
//            $('<option>').val(id).text(name).appendTo(selectTag);
//        }
//    });
//    
//    
//    
//    //--------------------------------Change Event------------------------------
//    
//    //Load district from division------------------------------------------------
//    $('#division').change(function (event) {
//
//        var divisionId = $("select#division").val();
//        
//        $.get('DistrictJsonProvider', {
//            divisionId: divisionId
//        }, function (response) {
//            
//            var returnedData = JSON.parse(response);
//            
//            var selectTag = $('#district');
//            selectTag.find('option').remove();
//            $('<option>').val("").text('All').appendTo(selectTag);
//
//            var selectTagUpazila = $('#upazila');
//            selectTagUpazila.find('option').remove();
//            $('<option>').val("").text('All').appendTo(selectTagUpazila);
//            
//            var selectTagUnion = $('#union');
//            selectTagUnion.find('option').remove();
//            $('<option>').val("").text('All').appendTo(selectTagUnion);
//            
//            var selectTagVillage = $('#village');
//            selectTagVillage.find('option').remove();
//            $('<option>').val("").text('All').appendTo(selectTagVillage);
//
//            for (var i = 0; i < returnedData.length; i++) {
//                var id = returnedData[i].zillaid;
//                var name = returnedData[i].zillanameeng;
//                $('<option>').val(id).text(name).appendTo(selectTag);
//            }
//        });
//    });
// 
//    //Load Upazila from district------------------------------------------------
//    $('#district').change(function (event) {
//
//        var districtId = $("select#district").val();
//        $.get('UpazilaJsonProvider', {
//            districtId: districtId
//        }, function (response) {
//            
//            var returnedData = JSON.parse(response);
//            
//            var selectTag = $('#upazila');
//            selectTag.find('option').remove();
//            $('<option>').val("").text('All').appendTo(selectTag);
//
//            var selectTagUnion = $('#union');
//            selectTagUnion.find('option').remove();
//            $('<option>').val("").text('All').appendTo(selectTagUnion);
//            
//            var selectTagVillage = $('#village');
//            selectTagVillage.find('option').remove();
//            $('<option>').val("").text('All').appendTo(selectTagVillage);
//
//            for (var i = 0; i < returnedData.length; i++) {
//                var id = returnedData[i].upazilaid;
//                var name = returnedData[i].upazilanameeng;
//                $('<option>').val(id).text(name).appendTo(selectTag);
//            }
//        });
//    });
//    
//    
//    //Laod Union from upazila---------------------------------------------------
//    $('#upazila').change(function (event) {
//
//        var upazilaId = $("select#upazila").val();
//        var zilaId = $("select#district").val();
//        var selectTag = $('#union');
//        
//        var selectTagVillage = $('#village');
//        selectTagVillage.find('option').remove();
//        $('<option>').val("").text('All').appendTo(selectTagVillage);
//
//        if (upazilaId === "") {
//            selectTag.find('option').remove();
//            $('<option>').val("").text('All').appendTo(selectTag);
//        } else {
//            $.get('UnionJsonProvider', {
//                upazilaId: upazilaId, zilaId: zilaId
//            }, function (response) {
//                
//                var returnedData = JSON.parse(response);
//                selectTag.find('option').remove();
//                $('<option>').val("").text('All').appendTo(selectTag);
//                             
//                for (var i = 0; i < returnedData.length; i++) {
//                    var id = returnedData[i].unionid;
//                    var name = returnedData[i].unionnameeng;
//                    $('<option>').val(id).text(name).appendTo(selectTag);
//                }
//            });
//        }
//    });
//    
//    
//    //Load village from Union---------------------------------------------------
//    $('#union').change(function (event) {
//
//        var upazilaId = $("select#upazila").val();
//        var zilaId = $("select#district").val();
//        var unionId = $("select#union").val();
//
//        var selectTag = $('#village');
//
//        if (upazilaId === "") {
//            selectTag.find('option').remove();
//            $('<option>').val("").text('All').appendTo(selectTag);
//        } else {
//            $.get('VillageJsonProvider', {
//                upazilaId: upazilaId, zilaId: zilaId, unionId: unionId
//            }, function (response) {
//                var returnedData = JSON.parse(response);
//                selectTag.find('option').remove();
//                $('<option>').val("").text('All').appendTo(selectTag);
//                for (var i = 0; i < returnedData.length; i++) {
//                    var id = returnedData[i].mouzaid + '' + returnedData[i].villageid;
//                    var name = returnedData[i].villagenameeng;
//                    $('<option>').val(id).text(name).appendTo(selectTag);
//                }
//            });
//
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
//                        $('<option>').val(id).text(name).appendTo(selectTag);
//                    }
//
//                }
//            });
//        }
//    });


});