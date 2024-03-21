$(function () {
    $.prsDropdown = $.prsDropdown || {
        divid: "#divid",
        zillaid: "#zillaid",
        upazilaid: "#upazilaid",
        unionid: "#unionid",
        unitid: "#unitid",
        userLevel: $('#userLevel').val(),
        init: function () {
            $.prsDropdown.ajax.loadDivision();
            $.prsDropdown.events.bindEvent();
        },
        events: {
            bindEvent: function () {
                $.prsDropdown.events.loadDistrict();
                $.prsDropdown.events.loadUpazila();
                $.prsDropdown.events.loadUnion();
                $.prsDropdown.events.loadUnit();
            },
            loadDistrict: function () {
                $(document).off('change', $.prsDropdown.divid).on('change', $.prsDropdown.divid, function (e) {
                    $.prsDropdown.unitVisibility("none");
                    var divisionId = $($.prsDropdown.divid).val();
                    var dropdown = $($.prsDropdown.zillaid);
                    if (divisionId === "" || divisionId === '0') {
                        $.prsDropdown.setDefault($($.prsDropdown.zillaid), "District");
                        $.prsDropdown.setDefault($($.prsDropdown.upazilaid), "Upazila");
                        $.prsDropdown.setDefault($($.prsDropdown.unionid), "Union");
                    } else {
                        $.get('DistrictJsonProviderDGFP', {
                            divisionId: divisionId
                        }, function (response) {
                            response = JSON.parse(response);
                            dropdown.find('option').remove();
                            $('<option>').val("").text('- Select District -').appendTo(dropdown);
                            $.prsDropdown.setDefault($($.prsDropdown.upazilaid), "Upazila");
                            $.prsDropdown.setDefault($($.prsDropdown.unionid), "Union");

                            $.each(response, function (i, o) {
                                $('<option>').val(o.zillaid).text(o.zillanameeng).appendTo(dropdown);
                            });
                        });
                    }
                });
            }, //end district loader
            loadUpazila: function () {
                $(document).off('change', $.prsDropdown.zillaid).on('change', $.prsDropdown.zillaid, function (e) {
                    $.prsDropdown.unitVisibility("none");
                    var zillaid = $($.prsDropdown.zillaid).val();
                    var dropdown = $($.prsDropdown.upazilaid);
                    if (zillaid === "" || zillaid === '0') {
                        $.prsDropdown.setDefault($($.prsDropdown.upazilaid), "Upazila");
                        $.prsDropdown.setDefault($($.prsDropdown.unionid), "Union");
                    } else {
                        $.get('UpazilaJsonProvider', {
                            districtId: zillaid
                        }, function (response) {
                            response = JSON.parse(response);
                            dropdown.find('option').remove();
                            $('<option>').val("0").text('All').appendTo(dropdown);
                            $.prsDropdown.setDefault($($.prsDropdown.unionid), "Union");

                            $.each(response, function (i, o) {
                                $('<option>').val(o.upazilaid).text(o.upazilanameeng).appendTo(dropdown);
                            });
                        });

                    }
                });
            }, //end upazila loader 
            loadUnion: function () {
                $(document).off('change', $.prsDropdown.upazilaid).on('change', $.prsDropdown.upazilaid, function (e) {
                    $.prsDropdown.unitVisibility("none");
                    var upazilaid = $($.prsDropdown.upazilaid).val();
                    var dropdown = $($.prsDropdown.unionid);
                    if (upazilaid === "" || upazilaid === '0' || upazilaid === 0) {
                        console.log("Unionreset");
                        $.prsDropdown.setDefault($($.prsDropdown.unionid), "Union");
                    } else {
                        $.get('UnionJsonProviderTest', {
                            upazilaId: upazilaid, zilaId: $($.prsDropdown.zillaid).val()
                        }, function (response) {
                            response = JSON.parse(response);
                            dropdown.find('option').remove();
                            $('<option>').val("0").text('All').appendTo(dropdown);
                            $.each(response, function (i, o) {
                                $('<option>').val(o.unionid).text(o.unionnameeng).appendTo(dropdown);
                            });
                        });
                    }
                });
            },
            loadUnit: function () {
                $(document).off('change', $.prsDropdown.unionid).on('change', $.prsDropdown.unionid, function (e) {
                    var unionid = $($.prsDropdown.unionid).val();
                    var dropdown = $($.prsDropdown.unitid);
                    if (unionid === "" || unionid === '0' || unionid === 0) {
                        $.prsDropdown.setDefault($($.prsDropdown.unitid), "Unit");
                        $.prsDropdown.unitVisibility("none");
                    } else {
                        $.post('UnitJsonDataProviderTest', {
                            unionId: unionid, upazilaId: $($.prsDropdown.upazilaid).val(), districtId: $($.prsDropdown.zillaid).val()
                        }, function (response) {
                            $.prsDropdown.unitVisibility("block");
                            response = JSON.parse(response);
                            dropdown.find('option').remove();
                            $('<option>').val("0").text('All').appendTo(dropdown);
                            $.each(response, function (i, o) {
                                $('<option>').val(o.unitid).text(o.uname).appendTo(dropdown);
                            });
                        });
                    }
                });
            }
        },
        ajax: {
            loadDivision: function () {
                $.get("DivisionJsonProviderByUserDGFP", function (response) {
                    response = JSON.parse(response);
                    $($.prsDropdown.divid).find('option').remove();
                    $('<option>').val("").text('- Select Division -').appendTo($.prsDropdown.divid);
                    $.each(response, function (i, o) {
                        $('<option>').val(o.id).text(o.divisioneng).appendTo($.prsDropdown.divid);
                    });
                });
            },
            loadDistrict: function () {
                $.get("DistrictJsonProviderByUser", function (response) {
                    response = JSON.parse(response);
                    var dropdown = $($.prsDropdown.zillaid);
                    dropdown.find('option').remove();
                    if (response.length > 1 || $.prsDropdown.userLevel == "2")
                        $('<option>').val("0").text('All').appendTo(dropdown);
                    $.each(response, function (i, o) {
                        $('<option>').val(o.zillaid).text(o.zillanameeng).appendTo(dropdown);
                    });
                });
            },
            loadUpazila: function () {
                $.get("UpazilaJsonProviderByUser", function (response) {
                    response = JSON.parse(response);
                    var dropdown = $($.prsDropdown.upazilaid);
                    dropdown.find('option').remove();
                    if (response.length > 1)
                        $('<option>').val("0").text('All').appendTo(dropdown);
                    $.each(response, function (i, o) {
                        $('<option>').val(o.upazilaid).text(o.upazilanameeng).appendTo(dropdown);
                    });
                });
            },
            loadUnion: function () {
                $.get("UnionJsonProviderByUser", function (response) {
                    response = JSON.parse(response);
                    var dropdown = $($.prsDropdown.unionid);
                    dropdown.find('option').remove();
                    if (response.length > 1)
                        $('<option>').val("0").text('All').appendTo(dropdown);
                    $.each(response, function (i, o) {
                        $('<option>').val(o.unionid).text(o.unionnameeng).appendTo(dropdown);
                    });
                });
            },
            loadUnit: function () {
                $.get("UnionJsonProviderByUser", function (response) {
                    response = JSON.parse(response);
                    var dropdown = $($.prsDropdown.unionid);
                    dropdown.find('option').remove();
                    if (response.length > 1)
                        $('<option>').val("0").text('All').appendTo(dropdown);
                    $.each(response, function (i, o) {
                        $('<option>').val(o.unionid).text(o.unionnameeng).appendTo(dropdown);
                    });
                });
            }
        }, //end ajax
        setDefault: function (dropdown, name) {
            dropdown.find('option').remove();
            $('<option>').val("").text('- Select ' + name + ' -').appendTo(dropdown);
        },
        unitVisibility: function (visibility){
            document.getElementById('unitDiv').style.display = visibility;
        }
    };
    $.prsDropdown.init();
});