$(document).ready(function () {

    $.get("DivisionJsonProviderByUserDGFP", function (response) {
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
            $('<option>').val(id).text(name).appendTo(selectTag);
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
        }


    });

    //--------------------------------Change Event------------------------------

    //Load district from division------------------------------------------------
    $('#division').change(function (event) {
        resetAll();
        var divisionId = $("select#division").val();

        if (divisionId === "" || divisionId === '0') {
            var selectTag = $('#district');
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select district -').appendTo(selectTag);

            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("").text('- Select upazila -').appendTo(selectTagUpazila);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- Select union -').appendTo(selectTagUnion);

            var selectTagUnit = $('#unit');
            selectTagUnit.find('option').remove();
            $('<option>').val("").text('- Select unit -').appendTo(selectTagUnit);

            var selectTagVillage = $('#village');
            selectTagVillage.find('option').remove();
            $('<option>').val("").text('- Select village -').appendTo(selectTagVillage);

        }

        $.get('DistrictJsonProviderDGFP', {
            divisionId: divisionId
        }, function (response) {

            var returnedData = JSON.parse(response);

            var selectTag = $('#district');
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select District -').appendTo(selectTag);

            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("").text('- Select upazila -').appendTo(selectTagUpazila);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- Select union -').appendTo(selectTagUnion);

            var selectTagUnit = $('#unit');
            selectTagUnit.find('option').remove();
            $('<option>').val("").text('- Select unit -').appendTo(selectTagUnit);

            var selectTagVillage = $('#village');
            selectTagVillage.find('option').remove();
            $('<option>').val("").text('- Select village -').appendTo(selectTagVillage);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].zillaid;
                var name = returnedData[i].zillanameeng;
                $('<option>').val(id).text(name).appendTo(selectTag);
            }
        });
    });

    //Load Upazila from district------------------------------------------------
    $('#district').change(function (event) {
        resetAll();

        var districtId = $("select#district").val();
        var selectTag = $('#upazila');
        var selectTagUnion = $('#union');
        var selectTagUnit = $('#unit');
        var selectTagVillage = $('#village');

        if (districtId === "" || districtId === '0') {

            selectTag.find('option').remove();
            $('<option>').val("").text('- Select Upazila -').appendTo(selectTag);


            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- Select Unit-').appendTo(selectTagUnion);

            selectTagUnit.find('option').remove();
            $('<option>').val("").text('- Select Unit-').appendTo(selectTagUnit);


            selectTagVillage.find('option').remove();
            $('<option>').val("").text('- Select Village-').appendTo(selectTagVillage);

        } else {

            $.get('UpazilaJsonProvider', {
                districtId: districtId
            }, function (response) {

                var returnedData = JSON.parse(response);

                selectTag.find('option').remove();
                $('<option>').val("0").text('All').appendTo(selectTag);


                selectTagUnion.find('option').remove();
                $('<option>').val("").text('- Select Unit-').appendTo(selectTagUnion);

                selectTagUnit.find('option').remove();
                $('<option>').val("").text('- Select Unit-').appendTo(selectTagUnit);


                selectTagVillage.find('option').remove();
                $('<option>').val("").text('- Select Village-').appendTo(selectTagVillage);

                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].upazilaid;
                    var name = returnedData[i].upazilanameeng;
                    $('<option>').val(id).text(name).appendTo(selectTag);
                }
            });
        }
    });


    //Laod Union from upazila---------------------------------------------------
    $('#upazila').change(function (event) {
        resetAll();

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();

        var selectTag = $('#union');
        var selectTagUnit = $('#unit');
        var selectTagVillage = $('#village');

        if (upazilaId === "" || upazilaId === '0') {
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select union-').appendTo(selectTag);

            selectTagUnit.find('option').remove();
            $('<option>').val("").text('- Select unit-').appendTo(selectTagUnit);

            selectTagVillage.find('option').remove();
            $('<option>').val("").text('- Select village-').appendTo(selectTagVillage);


        } else {
            $.get('UnionJsonProviderTest', {
                upazilaId: upazilaId, zilaId: zilaId
            }, function (response) {
                var returnedData = JSON.parse(response);


                selectTag.find('option').remove();
                $('<option>').val("0").text('All').appendTo(selectTag);

                selectTagUnit.find('option').remove();
                $('<option>').val("").text('- Selec Unit-').appendTo(selectTagUnit);

                selectTagVillage.find('option').remove();
                $('<option>').val("").text('- Select Village-').appendTo(selectTagVillage);


                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].unionid;
                    var name = returnedData[i].unionnameeng;
                    $('<option>').val(id).text(name).appendTo(selectTag);
                }
            });
        }
    });


    //Load village from Union---------------------------------------------------
    $('#union').change(function (event) {
        if ($("input[name='reportType']:checked").val() == "individual") {
            document.getElementById('villDiv').style.display = "none";
            $(".individual").attr('disabled', true);
            $(".aggregate").attr('disabled', false);
            $(".aggregate").prop("checked", true);
            $("#aggregate").next("span").removeClass("type-inactive").addClass("type-active");
            $("#individual").next("span").removeClass("type-active").addClass("type-inactive");
            $("#viewTypeBlock").slideDown();
            $("#dateBlock").fadeOut();
            resetViewType();
        }


        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();
        var selectTag = $('#village');
        var selectTagUnit = $('#unit');

        if (unionId === "" || unionId === '0') {
            document.getElementById('unitDiv').style.display = "none";

            selectTag.find('option').remove();
            $('<option>').val("").text('- Select Village-').appendTo(selectTag);

            selectTagUnit.find('option').remove();
            $('<option>').val("").text('- Select Unit-').appendTo(selectTagUnit);

        } else {
            document.getElementById('unitDiv').style.display = "block";

            $.ajax({
                url: "UnitJsonDataProviderTest",
                data: {
                    districtId: zilaId,
                    upazilaId: upazilaId,
                    unionId: unionId
                },
                type: 'POST',
                success: function (response) {
                    selectTag.find('option').remove();
                    $('<option>').val("").text('- Select Village-').appendTo(selectTag);
                    var returnedData = JSON.parse(response);
                    selectTagUnit.find('option').remove();

                    $('<option>').val("0").text('All').appendTo(selectTagUnit);
                    for (var i = 0; i < returnedData.length; i++) {
                        var id = returnedData[i].unitid;
                        var name = returnedData[i].uname;
                        $('<option>').val(id).text(name).appendTo(selectTagUnit);
                    }
                }
            });
        }
    });


    $('#unit').change(function (event) {

        var unitId = $("select#unit").val();
        var selectTag = $('#village');
        var selectTagUnit = $('#unit');

        if (unitId === "" || unitId === '0') {
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select Village-').appendTo(selectTag);

            document.getElementById('villDiv').style.display = "none";
            $(".individual").attr('disabled', true);
            $(".aggregate").attr('disabled', false);
            $(".aggregate").prop("checked", true);
            $("#aggregate").next("span").removeClass("type-inactive").addClass("type-active");
            $("#individual").next("span").removeClass("type-active").addClass("type-inactive");
            $("#viewTypeBlock").slideDown();
            $("#dateBlock").fadeOut();
            //$("#atPoint, #periodical, #monthly, #yearly").prop("checked", false);
            resetViewType();


        } else {
            document.getElementById('villDiv').style.display = "block";
            //$(".aggregate").attr('disabled', true);
            $(".individual").attr('disabled', false);
            //$(".individual").prop("checked", true);

            //$("#individual").next("span").removeClass("type-inactive").addClass("type-active");
            //$("#aggregate").next("span").removeClass("type-active").addClass("type-inactive");
            //$("#viewTypeBlock").slideUp();
            //$("#dateBlock").fadeIn();
            //$("#_atPoint").fadeIn();
            //$("#_periodical, #_monthly, #_yearly").fadeOut();

            //$("#dateBlock").slideUp();
            //resetViewType();




            var selectTag = $('#village');
            selectTag.find('option').remove();
            $('<option>').val("0").text('All').appendTo(selectTag);
            $.get('VillageJsonProviderByUnitMaster', {
                upazilaId: $('select#upazila').val(), zilaId: $('select#district').val(), unionId: $('select#union').val(), unitId: unitId
            }, function (response) {

                var jsonVillage = JSON.parse(response);
                for (var i = 0; i < jsonVillage.length; i++) {
                    var id = jsonVillage[i].mouzaid + ' ' + jsonVillage[i].villageid;
                    var name = jsonVillage[i].villagenameeng;
                    $('<option>').val(id).text(name).appendTo(selectTag);
                }
            });
        }
    });

    $('#village').change(function (event) {
        if ($("select#village").val() === "" || $("select#village").val() === '0') {
            $(".aggregate").attr('disabled', false);
        } else {
            $(".aggregate").attr('disabled', true);
            $(".individual").attr('disabled', false);
            $(".individual").prop("checked", true);
            $("#individual").next("span").removeClass("type-inactive").addClass("type-active");
            $("#aggregate").next("span").removeClass("type-active").addClass("type-inactive");
            $("#viewTypeBlock").slideUp();
            $("#dateBlock").fadeIn();
            $("#_atPoint").fadeIn();
            $("#_periodical, #_monthly, #_yearly").fadeOut();
            resetViewType();
        }
    });

    //Load District
    function loadDistrict() {
        $.get("DistrictJsonProviderByUser", function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#district');
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

    //Load Upazila
    function loadUpazila() {
        $.get("UpazilaJsonProviderByUserDGFP", function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#upazila');
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

    //Load Union
    function loadUnion() {
        $.get("UnionJsonProviderByUserTest", function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#union');
            selectTag.find('option').remove();

            if (returnedData.length > 1 || $('#userDesignation').val() == "FPI") {
                $('<option>').val("0").text('All').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].unionid;
                var name = returnedData[i].unionnameeng;
                $('<option>').val(id).text(name).appendTo(selectTag);
            }
            if ($('#userDesignation').val() !== "FPI" && $('#userDesignation').val() !== "UFPO") {
                loadUnit();
            }
        });
    }

    //Load Unit
    function loadUnit() {
        $.ajax({
            url: "UnionJsonProviderByUserTest",
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
                $('<option>').val("0").text('All').appendTo(selectTag);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].ucode;
                    var name = returnedData[i].uname;
                    $('<option>').val(id).text(name + ' [' + returnedData[i].ucode + ']').appendTo(selectTag);
                }
            }
        });
    }

    function resetViewType() {
        //$("#_atPoint, #_periodical, #_monthly, #_yearly").css("display", "none");
        $("#atPoint, #periodical, #monthly, #yearly").next("span").removeClass("view-active").addClass("view-inactive");
        $("#atPoint, #periodical, #monthly, #yearly").prop("checked", false);
    }

    function resetAll() {
        if ($("input[name='reportType']:checked").val() == "individual") {
            document.getElementById('villDiv').style.display = "none";
            $(".individual").attr('disabled', true);
            $(".aggregate").attr('disabled', false);
            $(".aggregate").prop("checked", true);
            $("#aggregate").next("span").removeClass("type-inactive").addClass("type-active");
            $("#individual").next("span").removeClass("type-active").addClass("type-inactive");
            $("#viewTypeBlock").slideDown();
            $("#dateBlock").fadeOut();
            resetViewType();
        }
        document.getElementById('unitDiv').style.display = "none";
    }
});
