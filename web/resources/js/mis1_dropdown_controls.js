$(document).ready(function () {

    for (i = new Date().getFullYear(); i > 1900; i--)
    {
        $('#year').append($('<option />').val(i).html(i));
    }
    
    $.get("DistrictJsonDataProvider", function (response) {
        var returnedData = JSON.parse(response);
        var selectTag = $('#district');
        $('<option>').val("").text('- Select District -').appendTo(selectTag);
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].zillaid;
            var name = returnedData[i].zillanameeng;
            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
        }
    });

    $('#district').change(function (event) {

        var districtId = $("select#district").val();
        $.get('UpazilaJsonProvider', {
            districtId: districtId
        }, function (response) {
            var returnedData = JSON.parse(response);
            
            var selectTag = $('#upazila');
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select Upazila -').appendTo(selectTag);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- Select Union -').appendTo(selectTagUnion);
            
            var selectTagProvider = $('#provCode');
            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- Select Provider -').appendTo(selectTagProvider);
            
            var selectTagWard = $('#ward');
            selectTagWard.find('option').remove();
            $('<option>').val("").text('- Select Ward -').appendTo(selectTagWard);
            
            var selectTagUnit = $('#unit');
            selectTagUnit.find('option').remove();
            $('<option>').val("").text('- Select Unit -').appendTo(selectTagUnit);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].upazilaid;
                var name = returnedData[i].upazilanameeng;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });


    });

    $('#upazila').change(function (event) {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var selectTag = $('#union');

        if (upazilaId === "") {
            selectTag.find('option').remove();
            $('<option>').val("").text('----').appendTo(selectTag);
        } else {
            $.get('UnionJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId
            }, function (response) {
                var returnedData = JSON.parse(response);
                selectTag.find('option').remove();
                
                var selectTagUnion = $('#union');
                selectTagUnion.find('option').remove();
                $('<option>').val("").text('- Select Union -').appendTo(selectTagUnion);

                var selectTagProvider = $('#provCode');
                selectTagProvider.find('option').remove();
                $('<option>').val("").text('- Select Provider -').appendTo(selectTagProvider);

                var selectTagWard = $('#ward');
                selectTagWard.find('option').remove();
                $('<option>').val("").text('- Select Ward -').appendTo(selectTagWard);

                var selectTagUnit = $('#unit');
                selectTagUnit.find('option').remove();
                $('<option>').val("").text('- Select Unit -').appendTo(selectTagUnit);
                
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].unionid;
                    var name = returnedData[i].unionnameeng;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
        }
    });


    $('#union').change(function (event) {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();

        var selectTag = $('#provCode');

        if (upazilaId === "") {
            selectTag.find('option').remove();
            $('<option>').val("").text('----').appendTo(selectTag);
        } else {
            
            

            $.ajax({
                url: "ProviderJsonData",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: $("select#union").val()
                },
                type: 'POST',
                success: function (response) {
                    var returnedData = JSON.parse(response);
                    
                    
                    var selectTagProvider = $('#provCode');
                    selectTagProvider.find('option').remove();
                    $('<option>').val("").text('- Select Provider -').appendTo(selectTagProvider);

                    var selectTagWard = $('#ward');
                    selectTagWard.find('option').remove();
                    $('<option>').val("").text('- Select Ward -').appendTo(selectTagWard);

                    var selectTagUnit = $('#unit');
                    selectTagUnit.find('option').remove();
                    $('<option>').val("").text('- Select Unit -').appendTo(selectTagUnit);
                
                    selectTag.find('option').remove();
                    $('<option>').val("").text('- Select Provider -').appendTo(selectTag);
                    for (var i = 0; i < returnedData.length; i++) {
                        var id = returnedData[i].provcode;
                        var name = returnedData[i].provname;
                        $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                    }

                }
            });
        }
    });
    
    
//    $("#provCode").change(function(){
//
//        var upazilaId = $("select#upazila").val();
//        var zilaId = $("select#district").val();
//        var unionId = $("select#union").val();
//
//        var selectTag1 = $('#ward');
//        
//        if (unionId === "") {
//            selectTag.find('option').remove();
//            $('<option>').val("").text('----').appendTo(selectTag);
//        } else {
//            
//            $.get('HAWardJsonDataProvider',  function (response) {
//                var returnedData = JSON.parse(response);
//                selectTag1.find('option').remove();
//                $('<option>').val("").text('- Select Ward -').appendTo(selectTag1);
//                for (var i = 0; i < returnedData.length; i++) {
//                    var id = returnedData[i].id;
//                     var name = returnedData[i].name;
//                     console.log(id+" - "+name);
//                    $('<option>').val(id).text(name).appendTo(selectTag1);
//                }
//            });
//            
//        }
//        
//    });

    $("#provCode").change(function(){
        
        
        var selectTagWard = $('#ward');
        selectTagWard.find('option').remove();
        //$('<option>').val("").text('- Select Ward -').appendTo(selectTagWard);

        var selectTagUnit = $('#unit');
        selectTagUnit.find('option').remove();
        //$('<option>').val("").text('- Select Unit -').appendTo(selectTagUnit);

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();

        var selectTag1 = $('#ward');
        var selectTag = $('#unit');
        
        if (unionId === "") {
            selectTag.find('option').remove();
            $('<option>').val("").text('----').appendTo(selectTag);
        } else {
            
            
            //Load Ward=====================================
            $.ajax({
                url: "WardJsonDataProviderForMIS1",
                data: {
                    provCode: $('#provCode').val()
                },
                type: 'POST',
                success: function (response) {
                    var returnedData = JSON.parse(response);
                    selectTag1.find('option').remove();
                    //$('<option>').val("").text('- Select Ward -').appendTo(selectTag1);
                    for (var i = 0; i < returnedData.length; i++) {
                        var id = returnedData[i].ward;
                        var name = getWard(returnedData[i].ward);       //returnedData[i].uname;
                        $('<option>').val(id).text(name).appendTo(selectTag1);
                    }
                }
            });
            
            
            //Load Unit=====================================
            Pace.track(function(){
                $.ajax({
                    url: "FWAUnitJsonDataProviderForMIS1",
                    data: {
                        provCode: $('#provCode').val()
                    },
                    type: 'POST',
                    success: function (response) {
                        var returnedData = JSON.parse(response);
                        selectTag.find('option').remove();

    //                    if(returnedData.length>1){
    //                        $('<option>').val("").text('- Select Unit -').appendTo(selectTag);
    //                    }
                        for (var i = 0; i < returnedData.length; i++) {
                            var id = returnedData[i].ucode;
                            var name = returnedData[i].uname;
                            $('<option>').val(id).text(name).appendTo(selectTag);
                        }

                    }
                });
            });
            
//            $.get('FWAUnitJsonDataProvider',  function (response) {
//                var returnedData = JSON.parse(response);
//                selectTag.find('option').remove();
//                $('<option>').val("").text('- Select Unit -').appendTo(selectTag);
//                for (var i = 0; i < returnedData.length; i++) {
//                    var id = returnedData[i].ucode;
//                    var name = returnedData[i].uname;
//                    $('<option>').val(id).text(name).appendTo(selectTag);
//                }
//            });
            
            
        }
        
    });
    

    function getWard(wardId) {
        if (wardId === '1') {
            return "Ward-1";
        } else if (wardId === '2') {
            return "Ward-2";
        } else if (wardId === '3') {
            return "Ward-3";
        }

    }

});