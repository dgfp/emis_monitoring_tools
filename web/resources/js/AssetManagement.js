$(function () {
    $.prsDropdown = $.prsDropdown || {
        divid: "#divid",
        zillaid: "#zillaid",
        upazilaid: "#upazilaid",
        unionid: "#unionid",
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
                    $('<option>').val("0").text('All').appendTo($.prsDropdown.divid);

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
            $('<option>').val("0").text('All').appendTo(dropdown);
        }
    };
    $.prsDropdown.init();
















    $.NDropdown = $.NDropdown || {
        divid: "#n_divid",
        zillaid: "#n_zillaid",
        upazilaid: "#n_upazilaid",
        unionid: "#n_unionid",
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
                            $('<option>').val("").text('- Select District -').appendTo(dropdown);
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
                            $('<option>').val("").text('- Select Upazila -').appendTo(dropdown);
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
                            $('<option>').val("").text('- Select Union -').appendTo(dropdown);
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
                    $('<option>').val("").text('- Select Division -').appendTo($.NDropdown.divid);

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
                        $('<option>').val("0").text('- Select District -').appendTo(dropdown);
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
                        $('<option>').val("0").text('- Select Upazila -').appendTo(dropdown);
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
                        $('<option>').val("0").text('- Select Union -').appendTo(dropdown);
                    $.each(response, function (i, o) {
                        $('<option>').val(o.unionid).text(o.unionnameeng + " [" + o.unionid + "]").appendTo(dropdown);
                    });
                });
            }
        }, //end ajax
        setDefault: function (dropdown, name) {
            dropdown.find('option').remove();
            $('<option>').val("0").text(' - select - ').appendTo(dropdown);
        }
    };
    $.NDropdown.init();














    $.AssetManagement = {
        assetURL: "asset-management",
        assetReportURL: "asset-reports",
        init: function () {
        },
        ajax: {
            getAssetDetails: function (json) {
                console.log(json);
                $.ajax({
                    url: $.AssetManagement.assetURL + "?action=getAssetDetails",
                    type: 'POST',
                    data: {imei: json.imei1},
                    success: function (response) {
                        response = JSON.parse(response);
                        console.log(response);
                        if (response.success === true) {
                            var d = response.data[0];
                            var acc = function (status, text) {
                                return (status != 'null' && status != 0) ? '<span style="color: #04723f">' + text + '</span>' : '<mark><del >' + text + '</del></mark>';
                            }
                            $("#d_provname").text(d.provname != "null" ? (d.provname + "" + (d.providerid != "null" ? " - " + d.providerid : '')) : '');
                            $("#d_providertype").text((d.designation != "null" ? d.designation : (d.typename != "null" ? "" + d.typename : '')));
                            $("#d_mobileno").text((d.mobileno != "null" ? "0" + d.mobileno : ''));
                            $("#d_imei1").text(d.imei1);
                            $("#d_imei2").text((d.imei2 != "null" ? d.imei2 : ''));
                            $("#d_specification").text(d.modelname);
                            $("#d_simnumber").text((d.simnumber != "null" ? "0" + d.simnumber : ''));
                            $("#d_purchaseby").text(d.purchaseby);
                            $("#d_simoperator").text(d.telconame);
                            $("#d_status1").html((d.statusname != "null" ? d.statusname + ' ( ' + d.locationname + ' )' : ''));
                            $("#d_issueDate").text((d.receiveddate != "null" ? $.app.date(d.receiveddate).dateHuman : ''));
                            $("#d_duration").html((d.duration != "null" ? "<b>" + d.duration.replace(/-/g, " ") + "</b>" : ''));
                            $("#d_tab_duration").html((d.tab_duration != "null" ? "<b>" + d.tab_duration.replace(/-/g, " ") + "</b>" : ''));
                            $("#d_accessories").html(acc(d.cover, 'Cover') + ", &nbsp;&nbsp;" + acc(d.screenprotector, 'Screen protector') + ",<br/>" + acc(d.charger, 'Charger') + ", &nbsp;&nbsp;" + acc(d.waterproofbag, 'Water proof bag'));
                            $("#d_addedby").text((d.createdby != "null" ? d.createdby : ''));
                            $('#viewAsset').modal('show');
                        } else {
                            toastr['error']("Error occured while dashboard loading");
                        }
                    }
                });
            },
            getAssetHistory: function (json) {
                console.log(json);
                $.ajax({
                    url: $.AssetManagement.assetURL + "?action=getAssetHistory",
                    type: "POST",
                    data: {imei: json.imei1},
                    success: function (response) {
                        response = JSON.parse(response);
                        console.log(response);
                        if (response.success == true) {
                            var d = response.data[0];
                            $(".tab-history").html('<span class="bold">IMEI:</span> ' + d.imei1 + ' &nbsp;-&nbsp; <span class="bold">Model:</span> ' + d.modelname + ' &nbsp;-&nbsp; <span class="bold">Duration:</span> ' + d.tab_duration.replace(/-/g, " "));
                            $(".timeline").html("");
                            if (d.active != "null") {

//                                for (var i = response.data.length-1; i =0; i--) {
//                                    $(".timeline").append($.AssetManagement.getHistoryItem(response.data[i]));
//                                }
                                response.data = response.data.reverse();
                                $.each(response.data, function (i, o) {
                                    console.log(i, o);
                                    $(".timeline").append($.AssetManagement.getHistoryItem(o));
                                });
                            }
                            $(".timeline").append('<li><p><span class="bold">Purchase date:</span> ' + $.app.date(d.purchaseddate).dateHuman + ' &nbsp;-&nbsp; <span class="bold">Purchased by:</span> ' + d.purchaseby + '</p></li>');
                            $("#assetHistory").modal('show');
                        } else {
                            toastr['error']("Error occured while data loading");
                        }
                    }, error: function (error) {
                        toastr['error'](error);
                    }
                });
            },
            getProvider: function (divid, zillaid, upazilaid, unionid, provtype) {
                if (divid != "" && zillaid != "" && upazilaid != "" && unionid != "" && provtype != "") {
                    $.ajax({
                        url: $.AssetManagement.assetURL + "?action=getProvider",
                        type: "POST",
                        data: {
                            divid: divid,
                            zillaid: zillaid,
                            upazilaid: upazilaid,
                            unionid: unionid,
                            provtype: provtype
                        },
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response);
                            if (response.success == true) {
                                var d = response.data[0];

                                var dropdown = $("#providerid");
                                dropdown.find('option').remove();
                                if (response.length > 1)
                                    $('<option>').val("").text('- Select Provider -').appendTo(dropdown);
                                $.each(response.data, function (i, o) {
                                    $('<option>').val(o.providerid).text(o.provname + " [" + o.providerid + "]").appendTo(dropdown);
                                });
                            } else {
                                toastr['error']("Error occured while data loading");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                }
            },
        },
        getHistoryItem: function (d) {
            var user = "", inactivedate = "";
            var duration = d.duration;
            if (d.inactivedate_duration != "null" && d.active == 2) {
                duration = d.inactivedate_duration
            }
            if (d.provname != "null") {
                user = '<p><span class="bold">Received by:&nbsp;</span> ' + d.provname + ' &nbsp;-&nbsp; <span class="bold">Designation:&nbsp;</span> ' + (d.designation != "null" ? d.designation : d.typename) + '</p>';
            }
            if (d.inactivedate != "null") {
                inactivedate = '-&nbsp; <a href="#"><span class="bold">Return date:&nbsp;</span> ' + $.app.date(d.inactivedate).dateHuman + '</a>&nbsp;';
            }
            return '<li>\
                    <a href="#"><span class="bold">Issue date:&nbsp;</span> ' + $.app.date(d.receiveddate).dateHuman + '</a> &nbsp;' + inactivedate + '\
                    ' + user + '\
                    <p><span class="bold">Status:&nbsp;</span> ' + d.statusname + ' &nbsp;-&nbsp; <span class="bold">Location:&nbsp;</span> ' + d.locationname + ' <br/><span class="bold">Issued by:&nbsp;</span> ' + d.createdby + '&nbsp;-&nbsp; <span class="bold">Duration:&nbsp;</span> ' + duration.replace(/-/g, " ") + '</p>\
                </li>';
        }
    };
});




function printContent(div, title, style) {
    var contents = $("#" + div).html();
    var frame1 = $('<iframe />');
    frame1[0].name = "frame1";
    frame1.css({"position": "absolute", "top": "-1000000px"});
    $("body").append(frame1);
    var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
    frameDoc.document.open();
    frameDoc.document.write('<html><head><title>eMIS Initiative</title>');
    frameDoc.document.write('</head><body>');
    frameDoc.document.write('<link rel="stylesheet" href="resources/css/' + style + '.css" type="text/css" />');
    frameDoc.document.write('<style>table, th, td{border:1px solid black; border-collapse: collapse;padding:10px;}th{vertical-align: text-center} th td{text-align:left;} .area{text-align: left !important;}</style>');
    frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center!important;"><center>' + title + '</center></h3><br/><br/>');
    frameDoc.document.write(contents);
    frameDoc.document.write('</body></html>');
    frameDoc.document.close();
    setTimeout(function () {
        window.frames["frame1"].focus();
        window.frames["frame1"].print();
        frame1.remove();
    }, 500);

}








