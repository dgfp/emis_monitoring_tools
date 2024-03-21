
function GetURLParameter(sParam)
{
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++)
    {
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam)
        {
            return decodeURIComponent(sParameterName[1]);
        }
    }
}

var redirectDivisionId = GetURLParameter('divisionid');
var redirectZillaId = GetURLParameter('zillaid');
var redirectUpazilaId = GetURLParameter('upazilaid');
var redirectUnionId = GetURLParameter('unionid');
var redirectTargetModal = GetURLParameter('targetModal');

console.log(redirectDivisionId);
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
            $('<option>').val("").text('- Select Division -').appendTo(selectTag);
        }
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].id;
            var name = returnedData[i].divisioneng;
            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
        }


        if (redirectDivisionId) {
            selectTag.val(redirectDivisionId.toString()).change();
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
        }
    });

    //--------------------------------Change Event------------------------------

    //Load district from division------------------------------------------------
    $('#division').change(function (event) {

        var divisionId = $("select#division").val();

        if (divisionId === "" || divisionId === '0') {
            var selectTag = $('#district');
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

        }

        $.get('DistrictJsonProvider', {
            divisionId: divisionId
        }, function (response) {

            var returnedData = JSON.parse(response);

            var selectTag = $('#district');
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select district -').appendTo(selectTag);

            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagUpazila);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagUnion);

            var selectTagProvider = $('#provCode');
            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagProvider);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].zillaid;
                var name = returnedData[i].zillanameeng;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }

            if (redirectZillaId) {
                selectTag.val(redirectZillaId.toString()).change();
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
            $('<option>').val("").text('- Select -').appendTo(selectTag);


            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagUnion);

            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagProvider);

        } else {

            $.get('UpazilaJsonProvider', {
                districtId: districtId
            }, function (response) {

                var returnedData = JSON.parse(response);

                selectTag.find('option').remove();
                $('<option>').val("").text('- Select upazila -').appendTo(selectTag);


                selectTagUnion.find('option').remove();
                $('<option>').val("").text('- Select -').appendTo(selectTagUnion);

                selectTagProvider.find('option').remove();
                $('<option>').val("").text('- Select -').appendTo(selectTagProvider);

                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].upazilaid;
                    var name = returnedData[i].upazilanameeng;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
                if (redirectUpazilaId) {
                    selectTag.val(redirectUpazilaId.toString()).change();
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
            $('<option>').val("").text('- Select -').appendTo(selectTag);

            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagProvider);


        } else {
            $.get('UnionJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId
            }, function (response) {
                var returnedData = JSON.parse(response);


                selectTag.find('option').remove();
                $('<option>').val("").text('- Select union -').appendTo(selectTag);

                selectTagProvider.find('option').remove();
                $('<option>').val("").text('- Select -').appendTo(selectTagProvider);


                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].unionid;
                    var name = returnedData[i].unionnameeng;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }

                if (redirectUnionId) {
                    selectTag.val(redirectUnionId.toString()).change();
//                    console.log(btnAddVillageClickHandler);
                    if (redirectTargetModal == "modalAddVillage") {
                        btnAddVillageClickHandler();
                    } else if (redirectTargetModal == "modalAddUnit") {
                        $('#btnShowAddReportingUnitModal').trigger('click');
                    } else if (redirectTargetModal == "modalAddUnion") {
                        $('#btnShowAddUnionModal').trigger('click');
                    }
                    redirectDivisionId = "";
                    redirectZillaId = "";
                    redirectUpazilaId = "";
                    redirectUnionId = "";
                    redirectTargetModal = "";
                }
            });
        }
    });

    //Load District
    function loadDistrict() {
        $.get("DistrictJsonProviderByUser", function (response) {

            var returnedData = JSON.parse(response);
            var selectTag = $('#district');
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
            var selectTag = $('#district');
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
                var name = returnedData[i].upazilanameeng;
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