$(document).ready(function () {
    
    //Load Division
    $.get("DivisionJsonProviderByUserDGFP", function (response) {
        var userLevel = $('#userLevel').val();

        var returnedData = JSON.parse(response);
        var selectTag = $('#division1');
        selectTag.find('option').remove();
        //returnedData.length!=1 && 

        if (userLevel === '1') {
            $('<option>').val("0").text('All').appendTo(selectTag);
        }
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].id;
            var name = returnedData[i].divisioneng;
            $('<option>').val(id).text(name).appendTo(selectTag);
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
        }
    });

    //Load district
    $('#division1').change(function (event) {

        var division1Id = $("select#division1").val();

        if (division1Id === "" || division1Id === '0') {
            var selectTag = $('#district1');
            selectTag.find('option').remove();
            $('<option>').val("0").text('All').appendTo(selectTag);

            var selectTagUpazila = $('#upazila1');
            selectTagUpazila.find('option').remove();
            $('<option>').val("0").text('All').appendTo(selectTagUpazila);

        }

        $.get('DistrictJsonProviderDGFP', {
            divisionId: division1Id
        }, function (response) {

            var returnedData = JSON.parse(response);

            var selectTag = $('#district1');
            selectTag.find('option').remove();
            $('<option>').val("0").text('All').appendTo(selectTag);

            var selectTagUpazila = $('#upazila1');
            selectTagUpazila.find('option').remove();
            $('<option>').val("0").text('All').appendTo(selectTagUpazila);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].zillaid;
                var name = returnedData[i].zillanameeng;
                $('<option>').val(id).text(name).appendTo(selectTag);
            }
        });
    });

    //Load Upazila from district1------------------------------------------------
    $('#district1').change(function (event) {

        var district1Id = $("select#district1").val();
        var selectTag = $('#upazila1');

        if (district1Id === "" || district1Id === '0') {

            selectTag.find('option').remove();
            $('<option>').val("0").text('All').appendTo(selectTag);

        } else {

            $.get('UpazilaJsonProviderDGFP', {
                districtId: district1Id
            }, function (response) {

                var returnedData = JSON.parse(response);

                selectTag.find('option').remove();
                $('<option>').val("0").text('All').appendTo(selectTag);


                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].upazilaid;
                    var name = returnedData[i].upazilanameeng;
                    $('<option>').val(id).text(name).appendTo(selectTag);
                }
            });
        }
    });




    //Load District
    function loadDistrict() {
        $.get("DistrictJsonProviderByUser", function (response) {

            var returnedData = JSON.parse(response);
            var selectTag = $('#district1');
            selectTag.find('option').remove();

            if (returnedData.length > 1 || $('#userLevel').val() == "2") {
                $('<option>').val("0").text('All').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].zillaid;
                var name = returnedData[i].zillanameeng; //ZILLANAMEENG
                $('<option>').val(id).text(name).appendTo(selectTag);
            }
        });

    }
    //Load District
    function loadDistrictFromTab() {
        $.get("DistrictJsonProviderByUser", function (response) {

            var returnedData = JSON.parse(response);
            var selectTag = $('#district1');
            selectTag.find('option').remove();

            if (returnedData.length > 1 || $('#userLevel').val() == "2") {
                $('<option>').val("0").text('All').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].zillaid;
                var name = returnedData[i].zillanameeng; //ZILLANAMEENG
                $('<option>').val(id).text(name).appendTo(selectTag);
            }
            console.log("Ready For Upazila");
            loadUpazilaFromTab();
        });

    }

    //Load Upazila
    function loadUpazila() {
        $.get("UpazilaJsonProviderByUserDGFP", function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#upazila1');
            selectTag.find('option').remove();

            if (returnedData.length > 1) {
                $('<option>').val("0").text('All').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].upazilaid;
                var name = returnedData[i].upazilanameeng; //UPAZILANAMEENG
                $('<option>').val(id).text(name).appendTo(selectTag);
            }
        });
    }

    //Load loadUpazilaFromTab
    function loadUpazilaFromTab() {
        $.get("UpazilaJsonProviderByUserDGFP", function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#upazila1');
            selectTag.find('option').remove();

            if (returnedData.length > 1) {
                $('<option>').val("All").text('All').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].upazilaid;
                var name = returnedData[i].upazilanameeng; //UPAZILANAMEENG
                $('<option>').val(id).text(name).appendTo(selectTag);
            }
        });
    }
});