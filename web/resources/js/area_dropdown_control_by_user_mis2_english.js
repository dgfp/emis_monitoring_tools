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
            loadProvider();
            
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
            });
        }
    });


    //Load village from Union---------------------------------------------------
    $('#union').change(function (event) {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();
        var selectTag = $('#provCode');
        //var selectTagUnit = $('#unit');

        if (unionId === "" || unionId === '0') {
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTag);

//            selectTagUnit.find('option').remove();
//            $('<option>').val("").text('- Select -').appendTo(selectTagUnit);

        } else {

            $.ajax({
                url: "FWAUnitJsonDataProviderForElco",
                data: {
                    districtId: zilaId,
                    upazilaId: upazilaId,
                    unionId: unionId
                },
                type: 'POST',
                success: function (response) {


                    selectTag.find('option').remove();
                    $.get('ProviderJsonProviderByUnion_mis2', {
                        upazilaId: $('select#upazila').val(), zilaId: $('select#district').val(), unionId: $('select#union').val()
                    }, function (response) {

                        var json = JSON.parse(response);
                        for (var i = 0; i < json.length; i++) {
                            var id = json[i].providerid;
                            var name = json[i].provname;
                            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                        }
                    });

                }
            });

        }//end else
    });


    /* $('#unit').change(function (event) {
     //alert("Change unit: "+$("select#unit").val());
     
     var unitId = $("select#unit").val();
     var selectTag = $('#provCode');
     var selectTagUnit = $('#unit');
     
     if (unitId === "" || unitId ==='0') {
     selectTag.find('option').remove();
     $('<option>').val("").text('- Select -').appendTo(selectTag);
     }else{
     
     var selectTag = $('#provCode');
     selectTag.find('option').remove();
     $.get('ProviderJsonProviderByUnit', {
     upazilaId: $('select#upazila').val(), zilaId: $('select#district').val(), unionId: $('select#union').val(),unitId:unitId
     }, function (response) {
     
     var json = JSON.parse(response);
     for (var i = 0; i < json.length; i++) {
     var id = json[i].providerid ;
     var name = json[i].provname;
     $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
     }                
     });
     }
     
     });*/



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
            console.log("Ready For Provider");
            loadProvider();
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
            console.log("Ready For Provider");
            loadProviderFromTab();
        });
    }

    //Load Provider
    function loadProvider() {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();
        var selectTag = $('#provCode');
        //var selectTagUnit = $('#unit');

        if (unionId === "" || unionId === '0') {
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTag);
        } else {
            $.ajax({
                url: "FWAUnitJsonDataProviderForElco",
                data: {
                    districtId: zilaId,
                    upazilaId: upazilaId,
                    unionId: unionId
                },
                type: 'POST',
                success: function (response) {

                    selectTag.find('option').remove();
                    $.get('ProviderJsonProviderByUnion_mis2', {
                        upazilaId: $('select#upazila').val(), zilaId: $('select#district').val(), unionId: $('select#union').val()
                    }, function (response) {

                        var json = JSON.parse(response);
                        for (var i = 0; i < json.length; i++) {
                            var id = json[i].providerid;
                            var name = json[i].provnameeng;
                            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                        }
                    });
                }
            });
        }//end else
    }

    //Load Provider from Tab
    function loadProviderFromTab() {
        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();
        var selectTag = $('#provCode');
        //var selectTagUnit = $('#unit');

        if (unionId === "" || unionId === '0') {
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTag);
        } else {

            $.ajax({
                url: "FWAUnitJsonDataProviderForElco",
                data: {
                    districtId: zilaId,
                    upazilaId: upazilaId,
                    unionId: unionId
                },
                type: 'POST',
                success: function (response) {


                    selectTag.find('option').remove();
                    $.get('ProviderJsonProviderByUnion_mis2', {
                        upazilaId: $('select#upazila').val(), zilaId: $('select#district').val(), unionId: $('select#union').val()
                    }, function (response) {
                        console.log("Success:   "+response);
                        var json = JSON.parse(response);
                        
                        for (var i = 0; i < json.length; i++) {
                            var id = json[i].providerid;
                            var name = json[i].provname;
                            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                        }
                    });

                }
            });

        }//end else
    }
});