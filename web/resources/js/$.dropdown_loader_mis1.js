$(function () {
    $.prsDropdown = $.prsDropdown || {
        divid: "#division",
        zillaid: "#district",
        upazilaid: "#upazila",
        unionid: "#union",
        unitid: "#unit",
        providerid: "#provCode",
        month: "#month",
        year: "#year",
        init: function () {
            $.prsDropdown.ajax.loadDivision();
            $.prsDropdown.events.bindEvent();
        },
        events: {
            bindEvent: function () {
                $.prsDropdown.events.loadDistrict();
                $.prsDropdown.events.loadUpazila();
                $.prsDropdown.events.loadUnion();
            },
            loadDistrict: function () {
                $(document).off('change', $.prsDropdown.divid).on('change', $.prsDropdown.divid, function (e) {
                    var divisionId = $($.prsDropdown.divid).val();
                    var dropdown = $($.prsDropdown.zillaid);
                    if (divisionId === "" || divisionId === '0') {
                        $.prsDropdown.setDefault($($.prsDropdown.zillaid), "District");
                        $.prsDropdown.setDefault($($.prsDropdown.upazilaid), "Upazila");
                        $.prsDropdown.setDefault($($.prsDropdown.unionid), "Union");
                    } else {
                        $.get('DistrictJsonProvider', {
                            divisionId: divisionId
                        }, function (response) {
                            response = JSON.parse(response);
                            dropdown.find('option').remove();
                            $('<option>').val("0").text('All').appendTo(dropdown);
                            $.prsDropdown.setDefault($($.prsDropdown.upazilaid), "Upazila");
                            $.prsDropdown.setDefault($($.prsDropdown.unionid), "Union");

                            $.each(response, function (i, o) {
                                $('<option>').val(o.zillaid).text(o.zillanameeng + " [" + o.zillaid + "]").appendTo(dropdown);
                            });
                        });
                    }
                });
            }, //end district loader
            loadUpazila: function () {
                $(document).off('change', $.prsDropdown.zillaid).on('change', $.prsDropdown.zillaid, function (e) {
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
                                $('<option>').val(o.upazilaid).text(o.upazilanameeng + " [" + o.upazilaid + "]").appendTo(dropdown);
                            });
                        });

                    }
                });
            }, //end upazila loader 
            loadUnion: function () {
                $(document).off('change', $.prsDropdown.upazilaid).on('change', $.prsDropdown.upazilaid, function (e) {
                    var upazilaid = $($.prsDropdown.upazilaid).val();
                    var dropdown = $($.prsDropdown.unionid);
                    if (upazilaid === "" || upazilaid === '0' || upazilaid === 0) {
                        console.log("Unionreset");
                        $.prsDropdown.setDefault($($.prsDropdown.unionid), "Union");
                    } else {
                        $.get('UnionJsonProvider', {
                            upazilaId: upazilaid, zilaId: $($.prsDropdown.zillaid).val()
                        }, function (response) {
                            response = JSON.parse(response);
                            dropdown.find('option').remove();
                            $('<option>').val("0").text('All').appendTo(dropdown);
                            $.each(response, function (i, o) {
                                $('<option>').val(o.unionid).text(o.unionnameeng + " [" + o.unionid + "]").appendTo(dropdown);
                            });
                        });
                    }
                });
            }
        },
        ajax: {
            loadDivision: function () {
                // DivisionJsonProviderByUser
                $.get("DivisionJsonDataProvider", function (response) {
                    response = JSON.parse(response);
                    $($.prsDropdown.divid).find('option').remove();
                    //if ($.prsDropdown.userLevel === '1')
                        $('<option>').val("").text('- Select Division -').appendTo($.prsDropdown.divid);

                    $.each(response, function (i, o) {
                        $('<option>').val(o.id).text(o.divisioneng + " [" + o.id + "]").appendTo($.prsDropdown.divid);
                    });
//                    if ($.prsDropdown.userLevel === '2') {
//                        $.prsDropdown.ajax.loadDistrict();
//                    } else if ($.prsDropdown.userLevel === '3') {
//                        $.prsDropdown.ajax.loadDistrict();
//                        $.prsDropdown.ajax.loadUpazila();
//                    } else if ($.prsDropdown.userLevel === '4' || $.prsDropdown.userLevel === '5' || $.prsDropdown.userLevel === '6') {
//                        $.prsDropdown.ajax.loadDistrict();
//                        $.prsDropdown.ajax.loadUpazila();
//                        $.prsDropdown.ajax.loadUnion();
//                    }
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
                        $('<option>').val(o.zillaid).text(o.zillanameeng + " [" + o.zillaid + "]").appendTo(dropdown);
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
                        $('<option>').val(o.upazilaid).text(o.upazilanameeng + " [" + o.upazilaid + "]").appendTo(dropdown);
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
                        $('<option>').val(o.unionid).text(o.unionnameeng + " [" + o.unionid + "]").appendTo(dropdown);
                    });
                });
            }
        }, //end ajax
        setDefault: function (dropdown, name) {
            dropdown.find('option').remove();
            $('<option>').val("").text('- Select ' + name + ' -').appendTo(dropdown);
        }
    };
    $.prsDropdown.init();
});