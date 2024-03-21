$(document).ready(function () {


    for (i = new Date().getFullYear(); i > 2014; i--)
    {
        $('#year').append($('<option />').val(i).html(e2b(i)));
    }

    //-----------------------------Load Area By AJAX----------------------------
    //Load Division----------------------------------------------------------------
    $.get("DivisionJsonProviderByUser", function (response) {
        var userLevel = $('#userLevel').val();

        var returnedData = JSON.parse(response);
        var selectTag = $('#division');
        selectTag.find('option').remove();
        //returnedData.length!=1 && 

        if (userLevel === '1') {
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);
        }
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].id;
            var name = returnedData[i].division;
            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
        }

        if (userLevel === '2') {
            //Division level
            loadDistrict();

        } else if (userLevel === '3') {
            //DIstrict level
            loadDistrict();
            loadUpazila();

        } else if (userLevel === '4') {
            //Upazila level
            loadDistrict();
            loadUpazila();
            loadUnion();

        } else if (userLevel === '5') {
            //Union level
            loadDistrict();
            loadUpazila();
            loadUnion();

        } else if (userLevel === '6') {
            //May be village level
            loadDistrict();
            loadUpazila();
            loadUnion();

        } else if (userLevel === '7') {
            loadDistrictFromTab();
            console.log("Ready For District");
        }


    });

    //--------------------------------Change Event------------------------------

    //Load district from division------------------------------------------------
    $('#division').change(function (event) {

        var divisionId = $("select#division").val();

        if (divisionId === "" || divisionId === '0') {
            var selectTag = $('#district');
            selectTag.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);

            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUpazila);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnion);

            var selectTagUnit = $('#unit');
            selectTagUnit.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnit);

//            var selectTagProvider = $('#provCode');
//            selectTagProvider.find('option').remove();
//            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);

        }

        $.get('DistrictJsonProvider', {
            divisionId: divisionId
        }, function (response) {

            var returnedData = JSON.parse(response);

            var selectTag = $('#district');
            selectTag.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট জেলা -').appendTo(selectTag);

            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUpazila);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnion);

            var selectTagUnit = $('#unit');
            selectTagUnit.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnit);

//            var selectTagProvider = $('#provCode');
//            selectTagProvider.find('option').remove();
//            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].zillaid;
                var name = returnedData[i].zillaname;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });
    });

    //Load Upazila from district------------------------------------------------
    $('#district').change(function (event) {

        var districtId = $("select#district").val();
        var selectTag = $('#upazila');
        var selectTagUnion = $('#union');
        var selectTagUnit = $('#unit');
        var selectTagProvider = $('#provCode');

        if (districtId === "" || districtId === '0') {

            selectTag.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);


            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnion);

            selectTagUnit.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnit);


//                selectTagProvider.find('option').remove();
//                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);

        } else {

            $.get('UpazilaJsonProvider', {
                districtId: districtId
            }, function (response) {

                var returnedData = JSON.parse(response);

                selectTag.find('option').remove();
                $('<option>').val("").text('সকল ').appendTo(selectTag);


                selectTagUnion.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnion);

                selectTagUnit.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnit);


//                selectTagProvider.find('option').remove();
//                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);

                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].upazilaid;
                    var name = returnedData[i].upazilaname;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
        }
    });


    //Laod Union from upazila---------------------------------------------------
    $('#upazila').change(function (event) {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();

        var selectTag = $('#union');
        var selectTagUnit = $('#unit');
        var selectTagProvider = $('#provCode');

        if (upazilaId === "" || upazilaId === '0') {
            selectTag.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);

            selectTagUnit.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnit);

//            selectTagProvider.find('option').remove();
//            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);


        } else {
            $.get('UnionJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId
            }, function (response) {
                var returnedData = JSON.parse(response);


                selectTag.find('option').remove();
                $('<option>').val("").text('সকল ').appendTo(selectTag);

                selectTagUnit.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnit);

//                selectTagProvider.find('option').remove();
//                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);


                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].unionid;
                    var name = returnedData[i].unionname;
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
//        var selectTag = $('#provCode');
        var selectTagUnit = $('#unit');

        if (unionId === "" || unionId === '0') {
            selectTag.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);

            selectTagUnit.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnit);

        } else {

            //var unit = JSON.parse($.unitJson);

//            var returnedData = JSON.parse($.unitJson);
//            selectTagUnit.find('option').remove();
//
//
//            $('<option>').val("").text('সকল ').appendTo(selectTagUnit);
//
//            for (var i = 0; i < returnedData.unit.length; i++) {
//                var id = returnedData.unit[i].ucode;
//                var name = returnedData.unit[i].unameban;
//                $('<option>').val(id).text(name + ' [' + returnedData.unit[i].ucode + ']').appendTo(selectTagUnit);
//            }



             $.ajax({
             url: "FWAUnitJsonDataProviderForElco",
             data: {
             districtId: zilaId,
             upazilaId: upazilaId,
             unionId: unionId
             },
             type: 'POST',
             success: function (response) {
             
             //                    selectTag.find('option').remove();
             //                    $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);
             
             //var selectTag = $('#unit');
             var returnedData = JSON.parse(response);
             selectTagUnit.find('option').remove();
             
             
             $('<option>').val("").text('সকল ').appendTo(selectTagUnit);
             
             for (var i = 0; i < returnedData.length; i++) {
             var id = returnedData[i].ucode;
             var name = returnedData[i].unameban;
             $('<option>').val(id).text(name + ' [' + returnedData[i].ucode + ']').appendTo(selectTagUnit);
             }
             }
             }); 


        }//end else
    });


//    $('#unit').change(function (event) {
//        //alert("Change unit: "+$("select#unit").val());
//
//        var unitId = $("select#unit").val();
//        var selectTag = $('#provCode');
//        var selectTagUnit = $('#unit');
//
//        if (unitId === "" || unitId ==='0') {
//            selectTag.find('option').remove();
//            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);
//        }else{
//            
//            var selectTag = $('#provCode');
//            selectTag.find('option').remove();
//            $.get('ProviderJsonProviderByUnit', {
//                upazilaId: $('select#upazila').val(), zilaId: $('select#district').val(), unionId: $('select#union').val(),unitId:unitId
//            }, function (response) {
//                
//                var json = JSON.parse(response);
//                for (var i = 0; i < json.length; i++) {
//                    var id = json[i].providerid ;
//                    var name = json[i].provname;
//                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
//                }                
//            });
//        }
//
//    });



    //Load District
    function loadDistrict() {
        $.get("DistrictJsonProviderByUser", function (response) {

            var returnedData = JSON.parse(response);
            var selectTag = $('#district');
            selectTag.find('option').remove();

            if (returnedData.length > 1 || $('#userLevel').val() == "2") {
                $('<option>').val("").text('- সিলেক্ট জেলা -').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].zillaid;
                var name = returnedData[i].zillaname; //ZILLANAMEENG
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });

    }
    //Load District
    function loadDistrictFromTab() {
        $.get("DistrictJsonProviderByUser", function (response) {

            var returnedData = JSON.parse(response);
            var selectTag = $('#district');
            selectTag.find('option').remove();

            if (returnedData.length > 1 || $('#userLevel').val() == "2") {
                $('<option>').val("").text('- সিলেক্ট জেলা -').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].zillaid;
                var name = returnedData[i].zillaname; //ZILLANAMEENG
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
            console.log("Ready For Upazila");
            loadUpazilaFromTab();
        });

    }

    //Load Upazila
    function loadUpazila() {
        $.get("UpazilaJsonProviderByUser", function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#upazila');
            selectTag.find('option').remove();

            if (returnedData.length > 1) {
                //$('<option>').val("").text('- সিলেক্ট উপজেলা -').appendTo(selectTag);
                $('<option>').val("").text('সকল ').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].upazilaid;
                var name = returnedData[i].upazilaname; //UPAZILANAMEENG
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });
    }

    //Load loadUpazilaFromTab
    function loadUpazilaFromTab() {
        $.get("UpazilaJsonProviderByUser", function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#upazila');
            selectTag.find('option').remove();

            if (returnedData.length > 1) {
                //$('<option>').val("").text('- সিলেক্ট উপজেলা -').appendTo(selectTag);
                $('<option>').val("").text('সকল ').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].upazilaid;
                var name = returnedData[i].upazilaname; //UPAZILANAMEENG
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
            console.log("Ready For Union");
            loadUnionFromTab();
        });
    }

    //Load Union
    function loadUnion() {
        $.get("UnionJsonProviderByUser", function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#union');
            selectTag.find('option').remove();

            if (returnedData.length > 1 || $('#userDesignation').val() == "FPI") {
                $('<option>').val("").text('সকল ').appendTo(selectTag);
            }

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].unionid;
                var name = returnedData[i].unionname;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
            console.log("FPI can try");
            if ($('#userDesignation').val() !== "FPI" && $('#userDesignation').val() !== "UFPO") {
                loadUnit();
            }
        });

    }

    //Load loadUnionFromTab
    function loadUnionFromTab() {
        $.get("UnionJsonProviderByUser", function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#union');
            selectTag.find('option').remove();

            if (returnedData.length > 1 || $('#userDesignation').val() == "FPI") {
                $('<option>').val("").text('সকল ').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].unionid;
                var name = returnedData[i].unionname;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
            if ($('#userDesignation').val() !== "FPI" && $('#userDesignation').val() !== "UFPO") {
                loadUnitFromTab();
            }
        });

    }

    //Load Unit
    function loadUnit() {
        $.ajax({
            url: "FWAUnitJsonDataProviderForElco",
            data: {
                districtId: $("select#district").val(),
                upazilaId: $("select#upazila").val(),
                unionId: $("select#union").val()
            },
            type: 'POST',
            success: function (response) {

                var selectTag = $('#unit');

                var returnedData = JSON.parse(response);
                selectTag.find('option').remove();
                if (returnedData.length > 1) {
                    //$('<option>').val("").text('- সিলেক্ট ইউনিট  -').appendTo(selectTag);
                    $('<option>').val("").text('সকল ').appendTo(selectTag);
                }
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].ucode;
                    var name = returnedData[i].unameban;
                    $('<option>').val(id).text(name + ' [' + returnedData[i].ucode + ']').appendTo(selectTag);
                }
            }
        });

    }

    //Load Unit from Tab
    function loadUnitFromTab() {
        $.ajax({
            url: "FWAUnitJsonDataProviderForElco",
            data: {
                districtId: $("select#district").val(),
                upazilaId: $("select#upazila").val(),
                unionId: $("select#union").val()
            },
            type: 'POST',
            success: function (response) {

                var selectTag = $('#unit');

                var returnedData = JSON.parse(response);
                selectTag.find('option').remove();
                if (returnedData.length > 1) {
                    //$('<option>').val("").text('- সিলেক্ট ইউনিট  -').appendTo(selectTag);
                    $('<option>').val("").text('সকল ').appendTo(selectTag);
                }
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].ucode;
                    var name = returnedData[i].unameban;
                    $('<option>').val(id).text(name + ' [' + returnedData[i].ucode + ']').appendTo(selectTag);
                }
                console.log("Ready For Provider");
                //loadProvider();
            }
        });

    }
});