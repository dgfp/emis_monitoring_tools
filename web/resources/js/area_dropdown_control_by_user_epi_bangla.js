$(document).ready(function () {

    for (i = new Date().getFullYear(); i > 2012; i--)
    {
        $('#year').append($('<option />').val(i).html(convertE2B(i)));
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

            var selectTagWard = $('#ward');
            selectTagWard.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagWard);

            var selectTagSubblock = $('#subblock');
            selectTagSubblock.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagSubblock);

            var selectTagNameOfEPICenter = $('#nameOfEPICenter');
            selectTagNameOfEPICenter.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagNameOfEPICenter);

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

            var selectTagWard = $('#ward');
            selectTagWard.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagWard);

            var selectTagSubblock = $('#subblock');
            selectTagSubblock.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagSubblock);

            var selectTagNameOfEPICenter = $('#nameOfEPICenter');
            selectTagNameOfEPICenter.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagNameOfEPICenter);

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
        var selectTagWard = $('#ward');
        var selectTagSubblock = $('#subblock');
        var selectTagNameOfEPICenter = $('#nameOfEPICenter');

//        var selectTagUnit = $('#unit');
//        var selectTagProvider = $('#provCode');

        if (districtId === "" || districtId === '0') {

            selectTag.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);

            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnion);

            selectTagWard.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagWard);

            selectTagSubblock.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagSubblock);

            selectTagNameOfEPICenter.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagNameOfEPICenter);

        } else {

            $.get('UpazilaJsonProvider', {
                districtId: districtId
            }, function (response) {

                var returnedData = JSON.parse(response);

                selectTag.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট উপজেলা -').appendTo(selectTag);

                selectTagUnion.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnion);

                selectTagWard.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagWard);

                selectTagSubblock.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagSubblock);

                selectTagNameOfEPICenter.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagNameOfEPICenter);

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
        var selectTagWard = $('#ward');
        var selectTagSubblock = $('#subblock');
        var selectTagNameOfEPICenter = $('#nameOfEPICenter');

        if (upazilaId === "" || upazilaId === '0') {

            selectTag.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);

            selectTagWard.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagWard);

            selectTagSubblock.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagSubblock);

            selectTagNameOfEPICenter.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagNameOfEPICenter);


        } else {
            $.get('UnionJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId
            }, function (response) {
                var returnedData = JSON.parse(response);

                selectTag.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট ইউনিয়ন -').appendTo(selectTag);

                selectTagWard.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagWard);

                selectTagSubblock.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagSubblock);

                selectTagNameOfEPICenter.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagNameOfEPICenter);


                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].unionid;
                    var name = returnedData[i].unionname;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
        }
    });


    //Load ward from Union---------------------------------------------------
    $('#union').change(function (event) {
        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();

        var selectTagWard = $('#ward');
        var selectTagSubblock = $('#subblock');
        var selectTagYear = $('#year');
        var selectTagNameOfEPICenter = $('#nameOfEPICenter');

        if (unionId === "" || unionId === '0') {

            selectTagWard.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagWard);

            selectTagSubblock.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagSubblock);

            selectTagYear.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagYear);

            selectTagNameOfEPICenter.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagNameOfEPICenter);


        } else {


            $.get('HAWardJsonDataProviderBangla', function (response) {
                var returnedData = JSON.parse(response);

                selectTagWard.find('option').remove();
                $('<option>').val("").text('-সিলেক্ট ওয়ার্ড -').appendTo(selectTagWard);

                selectTagSubblock.find('option').remove();
                $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagSubblock);

                selectTagYear.find('option').remove();
                $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagYear);

                selectTagNameOfEPICenter.find('option').remove();
                $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagNameOfEPICenter);

                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].id;
                    var name = returnedData[i].name;
                    console.log(id + " - " + name);
                    $('<option>').val(id).text(name).appendTo(selectTagWard);
                }
            });

        }

    });


    //Load sublock from ward---------------------------------------------------
    $('#ward').change(function (event) {
        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();
        var wardId = $("select#ward").val();

        var selectTagSubblock = $('#subblock');
        var selectTagYear = $('#year');
        var selectTagNameOfEPICenter = $('#nameOfEPICenter');

        if (wardId === "" || wardId === '0') {

            selectTagSubblock.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagSubblock);

            selectTagYear.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagYear);

            selectTagNameOfEPICenter.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagNameOfEPICenter);


        } else {

            $.get('HABlockJsonDataProvider', function (response) {
                var returnedData = JSON.parse(response);

                selectTagSubblock.find('option').remove();
                $('<option>').val("").text('-সিলেক্ট সাব ব্লক -').appendTo(selectTagSubblock);

                selectTagYear.find('option').remove();
                $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagYear);

                selectTagNameOfEPICenter.find('option').remove();
                $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagNameOfEPICenter);

                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].bcode;
                    var name = returnedData[i].bnameban;
                    $('<option>').val(id).text(name).appendTo(selectTagSubblock);
                }
            });
        }

    });

    //Load year from subblock---------------------------------------------------
    $('#subblock').change(function (event) {

        var subblockId = $("select#subblock").val();
        var selectTagYear = $('#year');
        var selectTagNameOfEPICenter = $('#nameOfEPICenter');

        if (subblockId === "" || subblockId === '0') {

            selectTagYear.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagYear);

            selectTagNameOfEPICenter.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagNameOfEPICenter);

        } else {
            selectTagYear.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট সন -').appendTo(selectTagYear);

            selectTagNameOfEPICenter.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagNameOfEPICenter);

            getYear();

        }
    });

    //Load EPI center from all---------------------------------------------------
    $('#year').change(function (event) {

        var selectTagNameOfEPICenter = $('#nameOfEPICenter');
        selectTagNameOfEPICenter.find('option').remove();
        $('<option>').val("").text('-সিলেক্ট টিকাকেন্দ্র -').appendTo(selectTagNameOfEPICenter);

        $.get('EPIScheduleJsonProvider', {
            
            district: $("select#district").val(), 
            upazila: $("select#upazila").val(), 
            union: $("select#union").val(), 
            ward: $("select#ward").val(), 
            subblock: $("select#subblock").val(), 
            year: $("select#year").val()
            
        }, function (response) {
            var returnedData = JSON.parse(response);
            for (var i = 0; i < returnedData.length; i++) {
                
                var name = convertE2B(convertDateFrontFormat(returnedData[i].vaccinedate)) + "  " + returnedData[i].centername + "";
                var id = returnedData[i].vaccinedate + "~" + returnedData[i].centername + "";
                $('<option>').val(id).text(name).appendTo(selectTagNameOfEPICenter);
            }
        });
    });

    //Load year from month---------------------------------------------------
    /*$('#month').change(function (event) {

        var selectTagYear = $('#year');

        if (month === "" || month === '0') {

            selectTagYear.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagYear);

        } else {
            selectTagYear.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট সন -').appendTo(selectTagYear);

            getYear();

        }
    });*/

    //Get year---------------------------------------------------
    function getYear() {
        for (i = new Date().getFullYear(); i > 2012; i--)
        {
            $('#year').append($('<option />').val(i).html(convertE2B(i)));
        }
    }


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

            loadWard();
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
            console.log("Ready For Ward");
            loadWardFromTab();
        });

    }


    //Load Ward
    function loadWard() {
        $.get('WardJsonDataProviderByUser', function (response) {
            var returnedData = JSON.parse(response);
            var selectTagWard = $('#ward');

            selectTagWard.find('option').remove();
            if (returnedData.length > 1) {
                $('<option>').val("").text('-সিলেক্ট ওয়ার্ড -').appendTo(selectTagWard);
            }

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].id;
                var name = returnedData[i].name;
                $('<option>').val(id).text(name).appendTo(selectTagWard);
            }
        });

    }

    //Load Unit from Tab
    function loadWardFromTab() {

        $.get('WardJsonDataProviderByUser', function (response) {
            var returnedData = JSON.parse(response);
            var selectTagWard = $('#ward');

            selectTagWard.find('option').remove();
            if (returnedData.length > 1) {
                $('<option>').val("").text('-সিলেক্ট ওয়ার্ড -').appendTo(selectTagWard);
            }
            
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].id;
                var name = returnedData[i].name;
                $('<option>').val(id).text(name).appendTo(selectTagWard);
            }
            console.log("Ready For Sub block");
            loadSubBlock();
        });


    }

    function loadSubBlock() {
        $.get('HABlockJsonDataProvider', function (response) {
            var returnedData = JSON.parse(response);

            var selectTagSubblock = $('#subblock');
            selectTagSubblock.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট সাব ব্লক -').appendTo(selectTagSubblock);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].bcode;
                var name = returnedData[i].bnameban;
                $('<option>').val(id).text(name).appendTo(selectTagSubblock);
            }
        });
    }


});