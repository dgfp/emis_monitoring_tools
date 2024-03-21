$(document).ready(function () {

    for (i = new Date().getFullYear(); i > 2014; i--)
    {
        $('#year').append($('<option />').val(i).html(e2b(i)));
    }

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


        } else if (userLevel === '6') {
            loadDistrict();
            loadUpazila();
            loadUnion();

        } else if (userLevel === '7') {
            loadDistrictFromTab();
        }
    });

    //Load district from division------------------------------------------------
    $('#division').change(function (event) {

        var divisionId = $("select#division").val();

        if (divisionId === "" || divisionId === '0') {
            var selectTag = $('#district');
            selectTag.find('option').remove();
            $('<option>').val("").text('- select -').appendTo(selectTag);

            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("").text('- select -').appendTo(selectTagUpazila);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- select -').appendTo(selectTagUnion);

            var selectTagProvider = $('#provCode');
            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- select -').appendTo(selectTagProvider);

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
            $('<option>').val("").text('- select -').appendTo(selectTagUpazila);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- select -').appendTo(selectTagUnion);

            var selectTagProvider = $('#provCode');
            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- select -').appendTo(selectTagProvider);

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
            $('<option>').val("").text('- select -').appendTo(selectTag);


            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- select -').appendTo(selectTagUnion);

            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- select -').appendTo(selectTagProvider);

        } else {

            $.get('UpazilaJsonProvider', {
                districtId: districtId
            }, function (response) {

                var returnedData = JSON.parse(response);

                selectTag.find('option').remove();
                $('<option>').val("").text('- Select Upazila -').appendTo(selectTag);


                selectTagUnion.find('option').remove();
                $('<option>').val("").text('- select -').appendTo(selectTagUnion);

                selectTagProvider.find('option').remove();
                $('<option>').val("").text('- select -').appendTo(selectTagProvider);

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
        var unions = $('#multi-select-demo');
        var unit = $("#unit");
        if (upazilaId === "" || upazilaId === '0') {
            selectTag.find('option').remove();
            $('<option>').val("").text('- select -').appendTo(selectTag);
            unions.find('option').remove();
            $('<option>').val("").text('- select -').appendTo(unions);

        } else {

            $.get('UnionJsonProviderTest', {
                upazilaId: upazilaId, zilaId: zilaId
            }, function (response) {
                var returnedData = JSON.parse(response);
                selectTag.find('option').remove();
                unions.find('option').remove();
                $('<option>').val("").text('- Select Reporting Union -').appendTo(selectTag);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].unionid;
                    var name = returnedData[i].unionnameeng;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });

            $.post('all-unit-josn-provider', {}, function (response) {
                response = JSON.parse(response);
                unit.find('option').remove();
                $('<option>').val("").text('- Select Unit -').appendTo(unit);
                for (var i = 0; i < response.length; i++) {
                    var id = response[i].ucode;
                    var name = response[i].uname;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(unit);
                }
            });
        }
    });


    //Load village from Union---------------------------------------------------
    $('#unit').change(function (event) {
        var zillaId = $("select#district").val();
        var upazilaId = $("select#upazila").val();
        var unionId = $("select#union").val();
        
        var village = $('#villages');
        var provider = $('#providerid');

        if (unionId === "" || unionId === '0') {
            village.find('option').remove();
            $('<option>').val("").text('- select -').appendTo(village);
            provider.find('option').remove();
            $('<option>').val("").text('- select -').appendTo(provider);

        } else {
            UTIL.getVillage(zillaId, upazilaId, unionId, "", 'multi-select-village', true).then(function (response) {
                $('#multi-select-village-container').html(response);
                $('#multi-select-village-container>select').multiselect()
            });
            
            $.post('fwa-provider-json-provider-by-reporting-union', {
                zillaId: zillaId, upazilaId: upazilaId, unionId: unionId
            }, function (response) {
                response = JSON.parse(response);
                provider.find('option').remove();
                $('<option>').val("").text('- Select Provider -').appendTo(provider);
                for (var i = 0; i < response.length; i++) {
                    var id = response[i].providerid;
                    var name = response[i].provname;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(provider);
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
                $('<option>').val("").text('- সিলেক্ট উপজেলা -').appendTo(selectTag);
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
                $('<option>').val("").text('- সিলেক্ট উপজেলা -').appendTo(selectTag);
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

    //Load Union UnionJsonProviderByUser_mis2
    function loadUnion() {
        $.get("UnionJsonProviderByUser", function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#union');
            selectTag.find('option').remove();

            if (returnedData.length > 1) {
                $('<option>').val("").text('- সিলেক্ট ইউনিয়ন -').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].unionid;
                var name = returnedData[i].unionname;
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
                $('<option>').val("").text('- সিলেক্ট ইউনিয়ন -').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].unionid;
                var name = returnedData[i].unionname;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
            console.log("Ready For Provider");
            loadProviderFromTab();
        });
    }
});
function clearNewUnion() {

}