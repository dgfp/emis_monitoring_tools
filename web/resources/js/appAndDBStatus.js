$(document).ready(function () {

    var userDesignation = $('#userDesignation').val();
    var userLevel = $('#userLevel').val();
    var userCategory = $('#userCategory').val();

    for (i = new Date().getFullYear(); i > 2014; i--)
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
            $('<option>').val("").text('- Select division -').appendTo(selectTag);
        }
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].id;
            var name = returnedData[i].divisioneng;
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

    //Load zilla from division------------------------------------------------
    $('#division').change(function (event) {

        var divisionId = $("select#division").val();

        if (divisionId === "" || divisionId === '0') {
            var selectTag = $('#zilla');
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTag);

            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagUpazila);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagUnion);

            var selectTagProvider = $('#provCode');
            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagProvider);

            $('#unit').find('option').remove();
            $('<option>').val("").text('- Select -').appendTo($('#unit'));

        }

        $.get('DistrictJsonProvider', {
            divisionId: divisionId
        }, function (response) {

            var returnedData = JSON.parse(response);


            var selectTag = $('#zilla');
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select District -').appendTo(selectTag);

            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagUpazila);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagUnion);

            var selectTagProvider = $('#provCode');
            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagProvider);

            $('#unit').find('option').remove();
            $('<option>').val("").text('- Select -').appendTo($('#unit'));

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].zillaid;
                var name = returnedData[i].zillanameeng;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });
    });

    //Load Upazila from zilla------------------------------------------------
    $('#zilla').change(function (event) {

        var zillaId = $("select#zilla").val();
        var selectTag = $('#upazila');
        var selectTagUnion = $('#union');
        var selectTagUnit = $('#unit');
        var selectTagProvider = $('#provCode');

        if (zillaId === "" || zillaId === '0') {

            selectTag.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTag);


            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagUnion);

            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagProvider);

            $('#unit').find('option').remove();
            $('<option>').val("").text('- Select -').appendTo($('#unit'));

        } else {

            $.get('UpazilaJsonProvider', {
                districtId: zillaId
            }, function (response) {

                var returnedData = JSON.parse(response);

                selectTag.find('option').remove();
                $('<option>').val("").text('- Select Upazila -').appendTo(selectTag);


                selectTagUnion.find('option').remove();
                $('<option>').val("").text('- Select -').appendTo(selectTagUnion);

                selectTagProvider.find('option').remove();
                $('<option>').val("").text('- Select -').appendTo(selectTagProvider);

                $('#unit').find('option').remove();
                $('<option>').val("").text('- Select -').appendTo($('#unit'));

                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].upazilaid;
                    var name = returnedData[i].upazilanameeng;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
        }
    });


    //Laod Union from upazila---------------------------------------------------
    $('#upazila').change(function (event) {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#zilla").val();

        var selectTag = $('#union');
        var selectTagUnit = $('#unit');
        var selectTagProvider = $('#provCode');

        if (upazilaId === "" || upazilaId === '0') {
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTag);

            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagProvider);

            $('#unit').find('option').remove();
            $('<option>').val("").text('- Select -').appendTo($('#unit'));


        } else {
            $.get('UnionJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId
            }, function (response) {
                var returnedData = JSON.parse(response);


                selectTag.find('option').remove();
                $('<option>').val("").text('All').appendTo(selectTag);

                selectTagProvider.find('option').remove();
                $('<option>').val("").text('- Select -').appendTo(selectTagProvider);

                $('#unit').find('option').remove();
                $('<option>').val("").text('- Select -').appendTo($('#unit'));


                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].unionid;
                    var name = returnedData[i].unionnameeng;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
        }
    });


    //Load District
    function loadDistrict() {
        $.get("DistrictJsonProviderByUser", function (response) {

            var returnedData = JSON.parse(response);
            var selectTag = $('#zilla');
            selectTag.find('option').remove();

            if (returnedData.length > 1 || $('#userLevel').val() == "2") {
                $('<option>').val("").text('- Select district -').appendTo(selectTag);
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
            var selectTag = $('#zilla');
            selectTag.find('option').remove();

            if (returnedData.length > 1 || $('#userLevel').val() == "2") {
                $('<option>').val("").text('- Select district -').appendTo(selectTag);
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
                $('<option>').val("").text('- Select upazila -').appendTo(selectTag);
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
                $('<option>').val("").text('- Select upazila -').appendTo(selectTag);
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
                $('<option>').val("").text('- Select union -').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].unionid;
                var name = returnedData[i].unionnameeng;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });

    }

    //Load loadUnionFromTab
    function loadUnionFromTab() {
        $.get("UnionJsonProviderByUser", function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#union');
            selectTag.find('option').remove();

            if (returnedData.length > 1) {
                $('<option>').val("").text('- Select union -').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].unionid;
                var name = returnedData[i].unionnameeng;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });
    }
});