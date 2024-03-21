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
            loadProviderType();

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

            var selectTagProvider = $('#provCode');
            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);

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

            var selectTagProvider = $('#provCode');
            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);

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

            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);

        } else {

            $.get('UpazilaJsonProvider', {
                districtId: districtId
            }, function (response) {

                var returnedData = JSON.parse(response);

                selectTag.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট উপজেলা -').appendTo(selectTag);


                selectTagUnion.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnion);

                selectTagProvider.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);

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

            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);


        } else {
            $.get('UnionJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId
            }, function (response) {
                var returnedData = JSON.parse(response);


                selectTag.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট ইউনিয়ন -').appendTo(selectTag);

                selectTagProvider.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);


                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].unionid;
                    var name = returnedData[i].unionname;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
        }
    });

    $('#providerType').on('change', function (event) {
        var providerType = $('select#providerType').val();
        provider = $('#provider');

        if (providerType === "") {
            provider.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট প্রোভাইডার -').appendTo(provider);
        } else {

            $.ajax({
                url: "DropdownLoaderController?action=getProviderByTypeAndUnion",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: $("select#union").val(),
                    providerType: $("select#providerType").val()
                },
                type: 'POST',
                success: function (response) {
                    var json = $.parseJSON(response);
                    var data = $.parseJSON(json.data);


                    if (json.status == "success") {
                        if (data.length != 0) {
                            provider.find('option').remove();
                            $('<option>').val("").text('- সিলেক্ট প্রোভাইডার -').appendTo(provider);
                            for (var i = 0; i < data.length; i++) {
                                var id = data[i].providerid;
                                var name = data[i].provname;
                                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(provider);
                            }
                        } else {
                            provider.find('option').remove();
                            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(provider);
                            $.toast("There is no " + $("#providerType option:selected").text() + " provider in this area", json.status)();
                        }


                    } else if (json.status == "error") {
                        $.toast(json.message, json.status)();
                    }
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

    //Load Union
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
            console.log("Ready For Provider Type");
            loadProviderTypeFromTab();
        });
    }

    function loadProviderType() {
        console.log("Going to mine: " + userCategory);

        var selectTag = $('#providerType');
        selectTag.find('option').remove();
        $('<option>').val("").text('- সিলেক্ট প্রোভাইডার টাইপ -').appendTo(selectTag);

        if (userDesignation == "FPI") {
            $('<option>').val("10").text('FPI [10]').appendTo(selectTag);
            $('<option>').val("3").text('FWA [3]').appendTo(selectTag);

        } else if (userDesignation == "HI") {
            $('<option>').val("12").text('HI [12]').appendTo(selectTag);
            $('<option>').val("11").text('AHI [11]').appendTo(selectTag);
            $('<option>').val("2").text('HA [2]').appendTo(selectTag);

        } else if (userDesignation == "AHI") {
            $('<option>').val("11").text('AHI [11]').appendTo(selectTag);
            $('<option>').val("2").text('HA [2]').appendTo(selectTag);

        }

    }

    function loadProviderTypeFromTab() {
        var selectTag = $('#providerType');
        selectTag.find('option').remove();

        if (userDesignation == "FPI") {
            $('<option>').val("").text('- সিলেক্ট প্রোভাইডার টাইপ -').appendTo(selectTag);
            $('<option>').val("10").text('FPI [10]').appendTo(selectTag);
            $('<option>').val("3").text('FWA [3]').appendTo(selectTag);

        } else if (userDesignation == "HI") {
            $('<option>').val("").text('- সিলেক্ট প্রোভাইডার টাইপ -').appendTo(selectTag);
            $('<option>').val("12").text('HI [12]').appendTo(selectTag);
            $('<option>').val("11").text('AHI [11]').appendTo(selectTag);
            $('<option>').val("2").text('HA [2]').appendTo(selectTag);

        } else if (userDesignation == "AHI") {
            $('<option>').val("").text('- সিলেক্ট প্রোভাইডার টাইপ -').appendTo(selectTag);
            $('<option>').val("11").text('AHI [11]').appendTo(selectTag);
            $('<option>').val("2").text('HA [2]').appendTo(selectTag);

        } else if (userDesignation == "FWA") {
            $('<option>').val("3").text('FWA [3]').appendTo(selectTag);
            loadProviderFromTab();

        } else if (userDesignation == "HA") {
            $('<option>').val("2").text('HA [2]').appendTo(selectTag);
            loadProviderFromTab();
        }

    }












    /*
     //Load Provider
     function loadProvider() {
     
     var upazilaId = $("select#upazila").val();
     var zilaId = $("select#district").val();
     var unionId = $("select#union").val();
     var selectTag = $('#provCode');
     //var selectTagUnit = $('#unit');
     
     if (unionId === "" || unionId === '0') {
     selectTag.find('option').remove();
     $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);
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
     $.get('ProviderJsonProviderByUnion', {
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
     }
     */


    //Load Provider from Tab
    function loadProviderFromTab() {
        
        console.log("called~~~~~~~~~~~~~~~~~~");
        
        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();
        var providerType = $('select#providerType');
        var provider = $('select#provider');

        if (providerType === "" || providerType === '0') {
            selectTag.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);
        } else {

            $.ajax({
                url: "DropdownLoaderController?action=getProviderByType",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: $("select#union").val(),
                    providerType: $("select#providerType").val()
                },
                type: 'POST',
                success: function (response) {
                    
                    var json = $.parseJSON(response);
                    var data = $.parseJSON(json.data);
                    
                    console.log(data);


                    if (json.status == "success") {
                        if (data.length != 0) {
                            provider.find('option').remove();
                            var id = data[0].providerid;
                            var name = data[0].provname;
                            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(provider);

//                            for (var i = 0; i < data.length; i++) {
//                                var id = data[i].providerid;
//                                var name = data[i].provname;
//                                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(provider);
//                            }
                        } else {
                            provider.find('option').remove();
                            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(provider);
                            $.toast("There is no " + $("#providerType option:selected").text() + " provider in this area", json.status)();
                        }


                    } else if (json.status == "error") {
                        $.toast(json.message, json.status)();
                    }
                }
            });


        }//end else
    }

});