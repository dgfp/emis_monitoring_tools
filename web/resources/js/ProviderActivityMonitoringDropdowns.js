var district = null;

$(document).ready(function () {

    var jsonVillage = null;
    for (i = new Date().getFullYear(); i > 1900; i--)
    {
        $('#year').append($('<option />').val(i).html(i));
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
            $('<option>').val("").text('- Select Division -').appendTo(selectTag);
        }
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].id;
            var name = returnedData[i].divisioneng;
            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
        }

        if (userLevel === '2') {
            loadDistrict();

        } else if (userLevel === '3') {
            loadDistrict();
            loadUpazila();

        } else if (userLevel === '4') {
            loadDistrict();
            loadUpazila();
            loadUnion();

        } else if (userLevel === '5') {
            loadDistrict();
            loadUpazila();
            loadUnion();

        } else if (userLevel === '6') {
            loadDistrict();
            loadUpazila();
            loadUnion();
        } else if (userLevel === '7') {
            loadDistrictFromTab();
        }


    });

    //--------------------------------Change Event------------------------------

    //Load district from division------------------------------------------------
    $('#division').change(function (event) {

        var divisionId = $("select#division").val();

        if (divisionId === "" || divisionId === '0') {
            var selectTag = $('#district');
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select District -').appendTo(selectTag);

            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("").text('- Select Upazila -').appendTo(selectTagUpazila);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- Select Union -').appendTo(selectTagUnion);

            var selectTagUnit = $('#unit');
            selectTagUnit.find('option').remove();
            $('<option>').val("").text('- Select Unit -').appendTo(selectTagUnit);

            var selectTagProvider = $('#provCode');
            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- Select Provider -').appendTo(selectTagProvider);

        }

        $.get('DistrictJsonProvider', {
            divisionId: divisionId
        }, function (response) {

            var returnedData = JSON.parse(response);

            var selectTag = $('#district');
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select District -').appendTo(selectTag);

            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("").text('- Select Upazila -').appendTo(selectTagUpazila);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- Select Union -').appendTo(selectTagUnion);

            var selectTagUnit = $('#unit');
            selectTagUnit.find('option').remove();
            $('<option>').val("").text('- Select Unit -').appendTo(selectTagUnit);

            var selectTagProvider = $('#provCode');
            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- Select Provider -').appendTo(selectTagProvider);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].zillaid;
                var name = returnedData[i].zillanameeng;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });
    });

//    $.get("DistrictJsonDataProvider", function (response) {
//        var returnedData = JSON.parse(response);
//        district=returnedData;
//        var selectTag = $('#district');
//        $('<option>').val("").text('- Select District -').appendTo(selectTag);
//        for (var i = 0; i < returnedData.length; i++) {
//            var id = returnedData[i].zillaid;
//            var name = returnedData[i].zillanameeng;
//            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
//        }
//    });

    $('#district').change(function (event) {

        var districtId = $("select#district").val();
        var selectTag = $('#upazila');
        var selectTagUnion = $('#union');
        var selectTagProviderType = $('#providerType');
        var selectTagProvider = $('#provider');

        selectTag.find('option').remove();
        $('<option>').val("").text('- Select Upazila -').appendTo(selectTag);

        selectTagUnion.find('option').remove();
        $('<option>').val("").text('- Select Union -').appendTo(selectTagUnion);

        selectTagProviderType.find('option').remove();
        $('<option>').val("").text('- Select provider Type -').appendTo(selectTagProviderType);

        selectTagProvider.find('option').remove();
        $('<option>').val("").text('- Select Provider -').appendTo(selectTagProvider);

        $.get('UpazilaJsonProvider', {
            districtId: districtId
        }, function (response) {

            var returnedData = JSON.parse(response);

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
        var selectTagProviderType = $('#providerType');
        var selectTagProvider = $('#provider');

        selectTagProviderType.find('option').remove();
        $('<option>').val("").text('- Select Provider Type -').appendTo(selectTagProviderType);
        $('<option>').val("2").text('HA').appendTo(selectTagProviderType);
        $('<option>').val("3").text('FWA').appendTo(selectTagProviderType);

        selectTagProvider.find('option').remove();
        $('<option>').val("").text('- Select Provider -').appendTo(selectTagProvider);

        $.get('UnionJsonProvider', {
            upazilaId: upazilaId, zilaId: zilaId
        }, function (response) {

            var returnedData = JSON.parse(response);

            selectTag.find('option').remove();
            $('<option>').val("").text('All').appendTo(selectTag);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].unionid;
                var name = returnedData[i].unionnameeng;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });
    });


    $('#union').change(function (event) {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();
        var selectTag = $('#providerType');
        var selectTagProvider = $('#provider');

        selectTagProvider.find('option').remove();
        $('<option>').val("").text('- Select Provider -').appendTo(selectTagProvider);

        selectTag.find('option').remove();
        $('<option>').val("").text('- Select Provider Type -').appendTo(selectTag);
        $('<option>').val("2").text('HA').appendTo(selectTag);
        $('<option>').val("3").text('FWA').appendTo(selectTag);

    });

    $('#providerType').change(function (event) {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();
        var selectTag = $('#provider');

        $.ajax({
            url: "ProviderJsonByType",
            data: {
                districtId: $("select#district").val(),
                upazilaId: $("select#upazila").val(),
                unionId: $("select#union").val(),
                type: $("select#providerType").val()
            },
            type: 'POST',
            success: function (response) {

                var returnedData = JSON.parse(response);
                selectTag.find('option').remove();
                $('<option>').val("").text('All').appendTo(selectTag);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].providerid;
                    var name = returnedData[i].provname;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }

            }
        });
    });

});






//Load District
function loadDistrict() {
    $.get("DistrictJsonProviderByUser", function (response) {

        var returnedData = JSON.parse(response);
        var selectTag = $('#district');
        selectTag.find('option').remove();

        if (returnedData.length > 1 || $('#userLevel').val() == "2") {
            $('<option>').val("").text('- Select District -').appendTo(selectTag);
        }
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].zillaid;
            var name = returnedData[i].zillanameeng; //ZILLANAMEENG
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
            $('<option>').val("").text('- Select District -').appendTo(selectTag);
        }
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].zillaid;
            var name = returnedData[i].zillanameeng; //ZILLANAMEENG
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
            $('<option>').val("").text('- Select Upazila -').appendTo(selectTag);
        }
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].upazilaid;
            var name = returnedData[i].upazilanameeng; //UPAZILANAMEENG
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
            $('<option>').val("").text('- Select Upazila -').appendTo(selectTag);
        }
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].upazilaid;
            var name = returnedData[i].upazilanameeng; //UPAZILANAMEENG
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

        if (returnedData.length > 1) {
            $('<option>').val("").text('- Select Union -').appendTo(selectTag);
        }
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].unionid;
            var name = returnedData[i].unionnameeng;
            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
        }

        var selectTag = $('#providerType');
        selectTag.find('option').remove();
        $('<option>').val("").text('- Select Provider Type -').appendTo(selectTag);
        if ($('#userDesignation').val() != 'FPI') {
            $('<option>').val("2").text('HA').appendTo(selectTag);
        }
        $('<option>').val("3").text('FWA').appendTo(selectTag);
    });

}

//Load loadUnionFromTab
function loadUnionFromTab() {
    $.get("UnionJsonProviderByUser", function (response) {
        var returnedData = JSON.parse(response);
        var selectTag = $('#union');
        selectTag.find('option').remove();

        if (returnedData.length > 1) {
            $('<option>').val("").text('- Select Union -').appendTo(selectTag);
        }
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].unionid;
            var name = returnedData[i].unionnameeng;
            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
        }


        var selectTag = $('#providerType');
        selectTag.find('option').remove();
        $('<option>').val("").text('- Select Provider Type -').appendTo(selectTag);
        if ($('#userDesignation').val() != 'FPI') {
            $('<option>').val("2").text('HA').appendTo(selectTag);
        }
        $('<option>').val("3").text('FWA').appendTo(selectTag);
    });

}