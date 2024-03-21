$.NDropdown = $.NDropdown || {
        divid: "#divid",
        zillaid: "#zillaid",
        upazilaid: "#upazilaid",
        unionid: "#unionid",
        userLevel: $('#userLevel').val(),
        init: function () {
            $.NDropdown.ajax.loadDivision();
            $.NDropdown.events.bindEvent();
        },
        events: {
            bindEvent: function () {
                $.NDropdown.events.loadDistrict();
                $.NDropdown.events.loadUpazila();
                $.NDropdown.events.loadUnion();
            },
            loadDistrict: function () {
                $(document).off('change', $.NDropdown.divid).on('change', $.NDropdown.divid, function (e) {
                    var divisionId = $($.NDropdown.divid).val();
                    var dropdown = $($.NDropdown.zillaid);
                    if (divisionId === "" || divisionId === '0') {
                        $.NDropdown.setDefault($($.NDropdown.zillaid), "District");
                        $.NDropdown.setDefault($($.NDropdown.upazilaid), "Upazila");
                        $.NDropdown.setDefault($($.NDropdown.unionid), "Union");
                    } else {
                        $.get('DistrictJsonProvider', {
                            divisionId: divisionId
                        }, function (response) {
                            response = JSON.parse(response);
                            dropdown.find('option').remove();
                            $('<option>').val("0").text('All').appendTo(dropdown);
                            $.NDropdown.setDefault($($.NDropdown.upazilaid), "Upazila");
                            $.NDropdown.setDefault($($.NDropdown.unionid), "Union");

                            $.each(response, function (i, o) {
                                $('<option>').val(o.zillaid).text(o.zillanameeng + " [" + o.zillaid + "]").appendTo(dropdown);
                            });
                        });
                    }
                });
            }, //end district loader
            loadUpazila: function () {
                $(document).off('change', $.NDropdown.zillaid).on('change', $.NDropdown.zillaid, function (e) {
                    var zillaid = $($.NDropdown.zillaid).val();
                    var dropdown = $($.NDropdown.upazilaid);
                    if (zillaid === "" || zillaid === '0') {
                        $.NDropdown.setDefault($($.NDropdown.upazilaid), "Upazila");
                        $.NDropdown.setDefault($($.NDropdown.unionid), "Union");
                    } else {
                        $.get('UpazilaJsonProvider', {
                            districtId: zillaid
                        }, function (response) {
                            response = JSON.parse(response);
                            dropdown.find('option').remove();
                            $('<option>').val("0").text('All').appendTo(dropdown);
                            $.NDropdown.setDefault($($.NDropdown.unionid), "Union");

                            $.each(response, function (i, o) {
                                $('<option>').val(o.upazilaid).text(o.upazilanameeng + " [" + o.upazilaid + "]").appendTo(dropdown);
                            });
                        });

                    }
                });
            }, //end upazila loader 
            loadUnion: function () {
                $(document).off('change', $.NDropdown.upazilaid).on('change', $.NDropdown.upazilaid, function (e) {
                    var upazilaid = $($.NDropdown.upazilaid).val();
                    var dropdown = $($.NDropdown.unionid);
                    if (upazilaid === "" || upazilaid === '0' || upazilaid === 0) {
                        console.log("Unionreset");
                        $.NDropdown.setDefault($($.NDropdown.unionid), "Union");
                    } else {
                        $.get('UnionJsonProvider', {
                            upazilaId: upazilaid, zilaId: $($.NDropdown.zillaid).val()
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
                    $($.NDropdown.divid).find('option').remove();
                    //if ($.NDropdown.userLevel === '1')
                    $('<option>').val("0").text('All').appendTo($.NDropdown.divid);

                    $.each(response, function (i, o) {
                        $('<option>').val(o.id).text(o.divisioneng + " [" + o.id + "]").appendTo($.NDropdown.divid);
                    });
//                    if ($.NDropdown.userLevel === '2') {
//                        $.NDropdown.ajax.loadDistrict();
//                    } else if ($.NDropdown.userLevel === '3') {
//                        $.NDropdown.ajax.loadDistrict();
//                        $.NDropdown.ajax.loadUpazila();
//                    } else if ($.NDropdown.userLevel === '4' || $.NDropdown.userLevel === '5' || $.NDropdown.userLevel === '6') {
//                        $.NDropdown.ajax.loadDistrict();
//                        $.NDropdown.ajax.loadUpazila();
//                        $.NDropdown.ajax.loadUnion();
//                    }
                });
            },
            loadDistrict: function () {
                $.get("DistrictJsonProviderByUser", function (response) {
                    response = JSON.parse(response);
                    var dropdown = $($.NDropdown.zillaid);
                    dropdown.find('option').remove();
                    if (response.length > 1 || $.NDropdown.userLevel == "2")
                        $('<option>').val("0").text('All').appendTo(dropdown);
                    $.each(response, function (i, o) {
                        $('<option>').val(o.zillaid).text(o.zillanameeng + " [" + o.zillaid + "]").appendTo(dropdown);
                    });
                });
            },
            loadUpazila: function () {
                $.get("UpazilaJsonProviderByUser", function (response) {
                    response = JSON.parse(response);
                    var dropdown = $($.NDropdown.upazilaid);
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
                    var dropdown = $($.NDropdown.unionid);
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
            $('<option>').val("0").text('All').appendTo(dropdown);
        }
    };
    $.NDropdown.init();