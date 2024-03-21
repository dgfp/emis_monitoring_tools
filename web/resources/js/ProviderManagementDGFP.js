var AUTOSELECTMOUZAID = "";
var rowUnion = null;
var populatedUnionTable = null;
var rowUnit = null;
var isNewUnion = false;
var updateRowUnit = null;
function  clearData() {
    $('input[name=mouzaid]').val("");
    $('input[name=villageid]').val("");
    $('input[name=mouzaname]').val("");
    $('input[name=mouzanameeng]').val("");
    $('input[name=villagename]').val("");
    $('input[name=villagenameeng]').val("");
}

function showTableRow(id) {
    $('.table-row').css('display', 'none');
    $(id).fadeIn('slow');
}
;

//GENERATE VILLAGE BASED ON REPORTING UNIT
function generateVillage(d, reporting_unionid) {
    var zillaid = $("select#district").val();
    var upazilaid = $("select#upazila").val();
    var unionid = $("select#catchment_reporting_union_id_for_unit").val() || reporting_unionid;
    UTIL.getVillage(zillaid, upazilaid, unionid, "", 'multi-select-village', true).then(function (response) {
//                $('#multi-select-village-container').html(response);
//                $('#multi-select-village-container>select').multiselect();

        var elementContainer = $('#multi-select-village-container');
        var elementSelect = $('#multi-select-village-container>select');
        elementContainer.html(response);
        elementSelect.multiselect();
        if (d) {
            $('#multi-select-village-container select').val(d);
            $('#multi-select-village-container select').multiselect('refresh');
        }
//                if (d) {
//                    elementSelect.val(d);
//                    elementSelect.multiselect('refresh');
//                }
    });
}
;

function generateVillageUpdateUnit(d, reporting_unionid, multiselectContainer, multiselectContainerSelect) {
    var zillaid = $("select#district").val();
    var upazilaid = $("select#upazila").val();
    var unionid = reporting_unionid;
    return UTIL.getVillage(zillaid, upazilaid, unionid, "", 'multi-select-village', true);
//            .then(function (response) {
////                $('#multi-select-village-container').html(response);
////                $('#multi-select-village-container>select').multiselect();
//
//        var elementContainer = multiselectContainer;
//        var elementSelect = multiselectContainerSelect;
//        elementContainer.html(response);
//        elementSelect.multiselect();
//        if (d) {
//            elementSelect.val(d);
//            elementSelect.multiselect('refresh');
//        }
////                if (d) {
////                    elementSelect.val(d);
////                    elementSelect.multiselect('refresh');
////                }
//    });
}
;
//RPORTING UNION - ADD/VIEW
function generateUnions(e) {
    var zillaid = $("select#district").val();
    var upazilaid = $("select#upazila").val();
    var selectTag = $("#reporting_union_id");
    var unions = $('#multi-select-demo');
    $.get('UnionJsonProvider', {
        zilaId: zillaid, upazilaId: upazilaid
    }, function (response) {
        var returnedData = JSON.parse(response);
        selectTag.find('option').remove();
        unions.find('option').remove();
        console.log(rowUnion);
        $('<option>').val("").text('- Select Reporting Union -').appendTo(selectTag);
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].unionid;
            var name = returnedData[i].unionnameeng;
            if (rowUnion && rowUnion["is_actual"] == 1) {
                if (id != 999 && name.substring(0, 7) != "WARD NO" && rowUnion["unionid"] == id) {
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            } else if (!rowUnion) {
                if (id != 999 && name.substring(0, 7) != "WARD NO") {
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            }
        }
        if (!rowUnion) {
            $('<option>').val(99).text('Other').appendTo(selectTag);
        } else if (rowUnion && rowUnion["is_actual"] == 0) {
            $('<option>').val(99).text('Other').appendTo(selectTag);
        }
        //GET MULTIPLE SELECTION - UNION
        UTIL.getUnion(zillaid, upazilaid, "", 'multi-select-union', true).then(function (multiSelectResponse) {
            $('#multi-select-union-container').html(multiSelectResponse);
            $('#multi-select-union-container>select').multiselect();
            if (rowUnion && rowUnion["is_actual"] == 1) {
                selectTag.val(rowUnion["unionid"]).change();
                var multiSelectValue = rowUnion["unionids"].split(",");
                $('#multiple_union').val(multiSelectValue);
                $('#multiple_union').multiselect("refresh");
            } else if (rowUnion && rowUnion["is_actual"] == 0) {
                selectTag.val(99).change();
                $("#request_from").val(rowUnion["reporting_unionid"]);
                var multiSelectValue = rowUnion["unionids"].split(",");
                $('#multiple_union').val(multiSelectValue);
                $('#multiple_union').multiselect("refresh");
                $("#unionnameeng").val(rowUnion["unionnameeng"]);
                $("#unionname").val(rowUnion["unionname"]);
            }
        });
    });
    UTIL.clearNewUnion();
}
;

function showAddUnionModal(d) {
    if (!UTIL.validateGeneral.validateUpazila("select#division,select#district,select#upazila, select#union"))
        return false;
    $("#modalAddUnion").modal({'show': true});
}
;

function viewUnion() {
    if (!UTIL.validateGeneral.validateUpazila("select#division,select#district,select#upazila"))
        return;
    showTableRow('#data-table-union-row');
    var zillaid = $("select#district").val();
    var upazilaid = $("select#upazila").val();
    var data = JSON.stringify({"zillaid": zillaid, "upazilaid": upazilaid});
    UTIL.request("report-geo-info?action=getReportingUnion", {data: data}, "POST").then(function (resp) {
        renderUnionTable(resp["reporting_union"]);
    });
}

function renderUnionTable(data) {
    var columns = [
        {data: "zillanameeng", title: 'District'},
        {data: "upazilanameeng", title: 'Upazila'},
        {data: "unionnameeng", title: 'Union name (ENG)'},
        {data: "unionname", title: 'Union name (BAN)'},
        {data: function (d) {
                return '<a class="btn-union-update btn btn-flat btn-warning btn-xs bold"><i class="fa fa-pencil" aria-hidden="true"></i> Update</a>&nbsp' +
                        '<a style="margin-top: 0px !important;" class="btn-union-delete btn btn-flat btn-danger btn-xs bold">' +
                        '<i class="fa fa-trash" aria-hidden="true"></i> Delete</a>';
            }, title: 'Action'}
    ];
    var options = {
        dom: 'Bfrtip',
        paging: false,
        "ordering": false,
        searching: false,
        info: false,
        processing: true,
        data: data,
        columns: columns
    };

    if (populatedUnionTable) {
        populatedUnionTable.destroy();
        populatedUnionTable = $('#data-table-union').DataTable(options);
//                populatedUnionTable.draw();
    } else {
        populatedUnionTable = $('#data-table-union').DataTable(options);
    }
}
;

// REPORTING UNION - UPDATE VIEW
function updateCatchmentUnitModal(row) {
    var zillaid = $("select#district").val();
    var upazilaid = $("select#upazila").val();
    var unionid = $("select#union").val();
    var payloadBBSUnion = JSON.stringify({upazilaid: upazilaid, zillaid: zillaid, unionid: unionid});
    $.when(UTIL.request("report-geo-info?action=getReportingUnionByBbsUnion", {data: payloadBBSUnion}, "POST")
            , UTIL.request("all-unit-josn-provider", "", "POST")).done(function (r1, r2) {
        UTIL.generateReportingUnion(r1["reporting_union"], "", "#modalUpdaReportingUnit #catchment_reporting_union_id_for_update_unit");
        UTIL.generateUnit(r2, "", "#modalUpdaReportingUnit #update_unit_label");

        $("#modalUpdaReportingUnit #catchment_reporting_union_id_for_update_unit").val(row["reporting_unionid"]).change();
        $("#modalUpdaReportingUnit #update_unit_label").val(row["unit"]).change();

        generateVillageUpdateUnit("", row["reporting_unionid"]).then(function (villageOpt) {
            updateRowUnit = row;
            var vMultiSelect = "";
            console.log("HHHH",row["villageid"], row);
            if (row["villageid"]) {
                var villageIds = row["villageid"].split(",");
                vMultiSelect = $.map(villageIds, function (item) {
                    return item;
                });
            }
            console.log("vMultiSelect",vMultiSelect);
            $("#multi-select-update-unit-village-container").html(villageOpt);
            $("#multi-select-update-unit-village-container select").multiselect();
            $("#multi-select-update-unit-village-container select").val(vMultiSelect);
            $("#multi-select-update-unit-village-container select").multiselect("refresh");

            $('#catchment_reporting_union_id_for_update_unit').attr('disabled', 'disabled');
            $('#update_unit_label').attr('disabled', 'disabled');

            $('#modalUpdaReportingUnit').modal('show');
        });
    });

}
;
//        REPORTING UNIT - ADD/VIEW
function showAddReportingUnitModal(d) {
    if (!$.isValidAll())
        return false;
    var r = generateReportingUnit();
    var hasData = !(d instanceof $.Event);
    r.then(function (resp) {
        if (resp == "success") {
            console.log(resp);
            $("#modalAddReportingUnit").modal({'show': true});
            rowUnit = null;
            $("#submitButtonReportingUnit").removeClass('hide');
            //$("#updateButtonReportingUnit").addClass('hide');

            $('#catchment_reporting_union_id_for_unit').removeAttr('disabled');
            $('#catchmentreportingunitfwa #unit').removeAttr('disabled');
//            if (hasData) {
//                rowUnit = d;
//                var reporting_unionopt = "<option value=" + d["reporting_unionid"] + ">" + d["unionnameeng"] + "</option>";
//
//                $("#submitButtonReportingUnit").addClass('hide');
//                $("#updateButtonReportingUnit").removeClass('hide');
//                $('#catchment_reporting_union_id_for_unit').append(reporting_unionopt).val(d["reporting_unionid"]).change();
//                $('#catchmentreportingunitfwa #unit').val(d["unit"]);
//
//                $('#catchment_reporting_union_id_for_unit').attr('disabled', 'disabled');
//
//                $('#catchmentreportingunitfwa #unit').attr('disabled', 'disabled');
//                var villageIds = d["villageid"].split(",");
//                var vMultiSelect = $.map(villageIds, function (item) {
//                    return item;
//                });
//                generateVillage(vMultiSelect, d["reporting_unionid"]);
//            } else if (!hasData) {
//                rowUnit = null;
//                $("#submitButtonReportingUnit").removeClass('hide');
//                $("#updateButtonReportingUnit").addClass('hide');
//
//                $('#catchment_reporting_union_id_for_unit').removeAttr('disabled');
//                $('#catchmentreportingunitfwa #unit').removeAttr('disabled');
//            }
        }
    });
}
;

function submitReportingUnit() {
    var form = $('#catchmentreportingunitfwa');
    var data = UTIL.serializeAllArray('#catchmentreportingunitfwa');//form.serializeArray();
    var formInput = $('#catchmentreportingunitfwa :input[name]');
    var zillaid = $("select#district").val();
    var upazilaid = $("select#upazila").val();

    var validate = UTIL.validateReportingGeo.validateFWAForm(data, formInput);
    if (validate) {
//                UTIL.request("report-geo-info?action=getFPIAssignment", {})
        var payload = $.app.pairs('#catchmentreportingunitfwa');
        var villageList = $('#catchmentreportingunitfwa #multi-select-village-container select option:selected');
        var villageListArr = [];
        $.each(villageList, function (i, e) {
            var v = $(e).attr('value');
            villageListArr.push(v);
        });
        payload["reporting_unionid"] = payload["catchment_reporting_union_id_for_unit"];
        delete payload['multi-select-village'];
        delete payload["catchment_reporting_union_id_for_unit"];
        payload["zillaid"] = zillaid;
        payload["upazilaid"] = upazilaid;
        payload['villages'] = villageListArr;
        payload["dboperationstatus"] = 0;
        console.log(payload);
        var p = JSON.stringify(payload);
        
        UTIL.request("report-geo-info?action=setUnitDetails", {data: p}, "POST").then(function (response) {
            alert(response.message);
            if (response.message.toLowerCase() == "successfully added") {
                console.log(response.message);
                $('#modalAddReportingUnit').modal('hide');
                $("#btnShowReportingUnit").click();
            }
        });
    } else {
        alert("Fill up all field");
    }
}
;

function updateReportingUnit() {
    var form = $('#updatecatchmentunitmodalform');
    var data = UTIL.serializeAllArray('#updatecatchmentunitmodalform');//form.serializeArray();
    var formInput = $('#updatecatchmentunitmodalform :input[name]');
    var zillaid = $("select#district").val();
    var upazilaid = $("select#upazila").val();

    var validate = UTIL.validateReportingGeo.validateFWAForm(data, formInput);
    if (validate) {
        var payload = $.app.pairs('#updatecatchmentunitmodalform');
        var villageList = $('#updatecatchmentunitmodalform #multi-select-update-unit-village-container select option:selected');

        var villageListArr = [];
        $.each(villageList, function (i, e) {
            var v = $(e).attr('value');
            villageListArr.push(v);
        });
        console.log("updateRowUnit", updateRowUnit);
//        console.log(payload, villageListArr, updateRowUnit);
        var modifiedPayload = {};
        modifiedPayload["reporting_unionid"] = updateRowUnit["reporting_unionid"];
        modifiedPayload["zillaid"] = updateRowUnit["zillaid"];
        modifiedPayload["unit"] = updateRowUnit["unit"];
        modifiedPayload["upazilaid"] = updateRowUnit["upazilaid"];
        modifiedPayload["villages"] = villageListArr;
        modifiedPayload["unitid"] = updateRowUnit["unitid"];
        console.log(modifiedPayload);
        modifiedPayload = JSON.stringify(modifiedPayload);
//        console.log(modifiedPayload);
        //updateRowUnit
//        payload["reporting_unionid"] = payload["catchment_reporting_union_id_for_unit"];
//        delete payload['multi-select-village'];
//        delete payload["catchment_reporting_union_id_for_unit"];
//        payload["zillaid"] = zillaid;
//        payload["upazilaid"] = upazilaid;
//        payload['villages'] = villageListArr
//        payload["unitid"] = rowUnit["unitid"];
//        payload["dboperationstatus"] = 0;
//        payload = JSON.stringify(payload, formInput, data);
//        console.log("updateReportingUnit", rowUnit);
//        return false;
        UTIL.request("report-geo-info?action=updateUnit", {data: modifiedPayload}, "POST").then(function (r1) {
            toastr[r1.success]("<b>" + r1.message + "</b>");
            $('#modalUpdaReportingUnit').modal('hide');
            //GLOBAL VARIABLE "updateRowUnit"  RESET ON MODAL HIDE EVENT AT THE BOTTOM
            if (r1.success == "success")
                $("#btnShowReportingUnit").click();
        });
    } else {
        alert("Fill up all field");
    }
}
;

function generateReportingUnit() {
    var dfd = $.Deferred();
    var zillaid = $("select#district").val();
    var upazilaid = $("select#upazila").val();
    var unionid = $("select#union").val();
    var payloadBBSUnion = JSON.stringify({upazilaid: upazilaid, zillaid: zillaid, unionid: unionid});
    $.when(UTIL.request("report-geo-info?action=getReportingUnionByBbsUnion", {data: payloadBBSUnion}, "POST")
            , UTIL.request("all-unit-josn-provider", "", "POST")).done(function (r1, r2) {
        UTIL.generateReportingUnion(r1["reporting_union"], "", "#catchment_reporting_union_id_for_unit");
        UTIL.generateUnit(r2, "", "#catchmentreportingunitfwa #unit");
        dfd.resolve("success");
    }, function (error) {
        dfd.reject("Failure");
    });
    return dfd.promise();
//            UTIL.request("UnionJsonProviderTest", {upazilaId: upazilaid, zilaId: zillaid}, "GET").then(function (resp) {
//                UTIL.generateReportingUnion(resp, "", "#reporting_union_id_for_unit");
//            });
//            UTIL.request("all-unit-josn-provider", "", "POST").then(function (resp) {
//                UTIL.generateUnit(resp, "", "#catchmentreportingunitfwa #unit");
//            });
}
;

function populateMouzaId(district, upazila, union) {
    var dfd = $.Deferred();
    var mouzaSelect = $("#modalAddVillageForm [name='mouzaid']");

    mouzaSelect.find("option").remove();

    UTIL.request("catchment-area-management-dgfp?action=getMouzaList"
            , {districtid: district, upazilaid: upazila, unionid: union}).then(function (resp) {
        $('<option>').val("").text("Please Select").appendTo(mouzaSelect);

        if (resp.length) {
            $.each(resp, function (index, item) {
                $('<option>').val(item["mouzaid"]).text(item["mouzanameeng"]).appendTo(mouzaSelect);
            });
            console.log("AUTOSELECTMOUZAID", AUTOSELECTMOUZAID);
            mouzaSelect.val(AUTOSELECTMOUZAID).change();
            dfd.resolve();
        } else {
            dfd.reject("Fail");
            AUTOSELECTMOUZAID = "";
        }
    });
    return dfd.promise();
}

function btnAddVillageClickHandler() {
    if (!$.isValidAll())
        return;
    clearData();
    var mouzaSelect = $("#modalAddVillageForm [name='mouzaid']");

    mouzaSelect.find("option").remove();

    var district = $("select#district").val();
    var upazila = $("select#upazila").val();
    var union = $("select#union").val();

    UTIL.request("catchment-area-management-dgfp?action=getMouzaList"
            , {districtid: district, upazilaid: upazila, unionid: union}).then(function (resp) {
        if (resp.length == 0) {
            $.toast("No mouza found", "error")();
            return;
        }
        $('<option>').val("").text("Please Select").appendTo(mouzaSelect);
        $.each(resp, function (index, item) {
            $('<option>').val(item["mouzaid"]).text(item["mouzanameeng"]).appendTo(mouzaSelect);
        });
        populateMouzaId(district, upazila, union).then(function (r) {
            console.log(r);
            $("#modalAddVillage").modal('show');
        });
    });
}
function btnAddMouzaClickHandler() {
    if (!$.isValidAll())
        return;
    clearData();
    $("#modalAddMouza").modal('show');
}
;

function renderUnitDetailsTable(data) {

    var columns = [
        {data: "zillanameeng", title: 'District'},
        {data: "upazilanameeng", title: 'Upazila'},
        {data: "unionnameeng", title: 'Union name'},
        {data: "fwaunitlabel", title: 'Unit'},
//        {data: "mouzaid", title: 'Mouza'},
        {data: "villagename", title: 'Village Name'},
        {data: function (d) {
                return '<a class="btn-unit-update btn btn-flat btn-warning btn-xs bold"><i class="fa fa-pencil" aria-hidden="true"></i> Update</a> &nbsp' +
                        '<a style="margin-top: 0px !important;" class="btn-unit-delete btn btn-flat btn-danger btn-xs bold">' +
                        '<i class="fa fa-trash" aria-hidden="true"></i> Delete</a>';
            }, title: 'Action'}
    ];
    var options = {
        dom: 'Bfrtip',
        paging: true,
        "ordering": false,
        searching: true,
        info: true,
        processing: true,
        data: data,
        columns: columns,
        "bRetrieve": true,
        "columnDefs": [
            {"width": "190px", "targets": 4}
        ]
    };
    var rt = new UTIL.renderingTable('#data-table-unit', options);
    rt.createDataTable();
    console.log(rt);
}
;

function viewReportingUnitTable() {
    if (!UTIL.validateGeneral.validateUpazila("select#division,select#district,select#upazila"))
        return;
    $("#transparentTextForBlank").hide();
    var zillaid = $('select#district').val();
    var upazilaid = $('select#upazila').val();
    var unionid = $('select#union').val();
    var payload = JSON.stringify({zillaid: zillaid, upazilaid: upazilaid, unionid: unionid});
    UTIL.request("report-geo-info?action=getUnitDetails", {data: payload}, "POST").then(function (resp) {
        console.log("getUnitDetails",resp);
        renderUnitDetailsTable(resp["unit_details"]);
        showTableRow('#data-table-unit-row');
    });
};
var jsonVillage = [];
//---------------------------------------------------------------------------------------Edit User ------------------------------------------------------------------------
function  editVillageHandler(i) {
    if (!$.isValid())
        return;
    var data = jsonVillage[i] || {};
    console.log(data);
    $("#modalEditVillage").modal('show').find('form').find(':input').each(function (i, o) {
        $(o).val(data[o.name]);
    });
    console.log('add/editVillage', data);
}


//---------------------------------------------------------------------------------------Delete Village ------------------------------------------------------------------------
function  deleteVillageHandler(i) {
    if (!$.isValid())
        return;
    $('#deleteVillage').modal('show');
    var data = jsonVillage[i] || {};
    console.log('add/editVillage', data);
    $('#deleteVillageName').html('Village:<b> ' + data.villagenameeng + '</b> of  Mouza: <b>' + data.mouzanameeng + '</b>');
    console.log('deleteVillage', data);
    var postData = [
        {name: 'districtid', value: $("select#district").val()},
        {name: 'upazilaid', value: $("select#upazila").val()},
        {name: 'unionid', value: $("select#union").val()},
        {name: 'mouzaid', value: data.mouzaid},
        {name: 'villageid', value: data.villageid}
    ];

    $('#btnConfirm-deleteVillage').off().on('click', function () {
        var btn = $(this).button('loading');
        var xhr = $.ajax({url: "catchment-area-management-dgfp?action=deleteVillage", data: postData, type: 'POST'});
        xhr.then(function (result) {
            btn.button('reset');
            result = JSON.parse(result);
//            var i = +result;
//            var data = [['error', "Somthing went wrong"], ['success', "Village delete sucessfully"]];
            toastr[result.success]("<b>" + result.message + "</b>");
            $('#deleteVillage').modal('hide');
            $('#btnShowVillages').trigger('click');
        }, console.log);
    });
}

function submitUnion() {
    var f = $('#addreportingunionform');
    var division = $("select#division").val();
    var zillaid = $("select#district").val();
    var upazilaid = $("select#upazila").val();
    var multipleUnionsArr = [];
    var multipleUnionsSel = $('#multi-select-union-container select option:selected');
    $.each(multipleUnionsSel, function (i, e) {
        var v = $(e).attr('value');
        multipleUnionsArr.push(v);
    });
    //Modified by Helal
    var data = $.app.pairs('#addreportingunionform');
    var mUnion = $("#multiple_union").val();
    data.unionids = mUnion ? $("#multiple_union").val().toString() : null;
    delete data['multi-select-union'];
    console.log(data, isNewUnion);
    var failed = UTIL.validateReportingGeo.validateFPIForm(data, isNewUnion);
    if (failed) {
        alert("Fill Up All Data Properly");
    } else {
        data["request_from"] = $("#request_from").val();
        data["division"] = division;
        data["zillaid"] = zillaid;
        data["upazilaid"] = upazilaid;
        data["unionid"] = data["reporting_union_id"];
        delete data["reporting_union_id"];
        data = JSON.stringify(data);
        UTIL.request("report-geo-info?action=insertUnionDetails", {data: data}, "POST").then(function (resp) {
            alert(resp.message);
            $("#btnShowUnion").click();
        });
    }
}
;

$(function () {

    //Add Village Submit
    $("#modalAddVillageForm").submit(function (e) {

        e.preventDefault();
        var postData = $(this).serializeArray();
        var formURL = $(this).attr("action");

        postData.push({name: 'districtid', value: $("select#district").val()});
        postData.push({name: 'upazilaid', value: $("select#upazila").val()});
        postData.push({name: 'unionid', value: $("select#union").val()});
        $.ajax({
            url: formURL,
            type: "POST",
            data: postData,
            success: function (result) {
                var i = +result;
                var data = [['error', "Already  exists"], ['success', "Village Added"]];
                toastr[data[i][0]]("<h4><b>" + data[i][1] + "</b></h4>");
                $('#modalAddVillage').modal('hide');
                $("#btnShowVillages").click();
                //loadModalData($("#assignModalTitle").attr("data-openproviderid"), 3, $("select#unionForAssign").val());
            },
            error: function (jqXHR, textStatus, errorThrown) {
                toastr["error"]("<h4><b>Error while adding village</b></h4>");
            }
        });
    });
    //Update Village Submit
    $("#modalEditVillageForm").submit(function (e) {

        e.preventDefault();
        var postData = $(this).serializeArray();
//            var formURL = $(this).attr("action");
        var formURL = "catchment-area-management-dgfp?action=editVillage";

        postData.push({name: 'districtid', value: $("select#district").val()});
        postData.push({name: 'upazilaid', value: $("select#upazila").val()});
        postData.push({name: 'unionid', value: $("select#union").val()});
        var btn = $(this).button('loading');
        $.ajax({
            url: formURL,
            type: "POST",
            data: postData,
            success: function (result) {
                btn.button('reset');
                var i = +result;
                var data = [['error', "Already  exists"], ['success', "Village/ Mouza update successfully"]];
                toastr[data[i][0]]("<h4><b>" + data[i][1] + "</b></h4>");
                $('.modal').modal('hide');
                $('#btnShowVillages').trigger('click');
            },
            error: function (jqXHR, textStatus, errorThrown) {
                toastr["error"]("<h4><b>Error while editing village/ mouza</b></h4>");
            }
        });

    });
    //Add Mouza Submit
    $("#modalMouzaForm").submit(function (e) {
        e.preventDefault();

        var postData = $(this).serializeArray();
        var formURL = $(this).attr("action");

        postData.push({name: 'districtid', value: $("select#district").val()});
        postData.push({name: 'upazilaid', value: $("select#upazila").val()});
        postData.push({name: 'unionid', value: $("select#union").val()});
        var btn = $(this).button('loading');

        AUTOSELECTMOUZAID = $('#modalMouzaForm ').find('input[name="mouzaid"]').val();

        $.ajax({
            url: formURL,
            type: "POST",
            data: postData,
            success: function (result) {
                var i = +result;
                btn.button('reset');
                var data = [['error', "Already  exists"], ['success', "Mouza added"]];
                toastr[data[i][0]]("<h4><b>" + data[i][1] + "</b></h4>");
                $('#modalAddMouza').modal('hide');
                populateMouzaId($("select#district").val(), $("select#upazila").val(), $("select#union").val());
                //$('#btnShowVillages').trigger('click');
            },
            error: function (jqXHR, textStatus, errorThrown) {
                toastr["error"]("<h4><b>Error while adding mouza</b></h4>");
            }
        });

    });

    $('#btnShowVillages').click(function () {
//        $("#tableContentVillage").hide();
//        $("#data-table-union-row").addClass("hide");
//        $("#data-table-unit-row").addClass("hide");
//        $("#transparentTextForBlank").show();


        if (!$.isValid())
            return;
        var btn = $(this).button('loading');
        $('#modalSetUnitWardTableBodyVillage').empty();
        $.ajax({
            url: "catchment-area-management-dgfp?action=showVillage",
            data: {
                districtid: $("select#district").val(),
                upazilaid: $("select#upazila").val(),
                unionid: $("select#union").val()
            },
            type: 'POST',
            success: function (result) {
                var json = JSON.parse(result);
                jsonVillage = json;
                for (var i = 0; i < json.length; i++) {
                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
                            + "<td> [" + json[i].mouzaid + "] " + json[i].mouzanameeng + "</td>"
                            + "<td> [" + json[i].villageid + "] " + json[i].villagename + "</td>"
                            + "<td> <a class='btn btn-flat btn-warning btn-xs bold' onclick='editVillageHandler(" + i + ")'><i class='fa fa-pencil' aria-hidden='true'></i> Update</a>   <a class='btn btn-flat btn-danger btn-xs bold' onclick='deleteVillageHandler(" + i + ")'><i class='fa fa-trash' aria-hidden='true'></i> Delete</a></td></tr>";
                    $('#modalSetUnitWardTableBodyVillage').append(parsedData);
                }
                btn.button('reset');
                showTableRow('#tableContentVillage');
//                $("#transparentTextForBlank").hide();
//                $("#tableContentVillage").fadeIn();
            },
            error: function (jqXHR, textStatus, errorThrown) {
                btn.button('reset');
                alert("Error while fetching data");
            }
        });
    });


    //Add Reporting Union Modal, Table
    $("#reporting_union_id").change(function () {
        var v = $(this).val();
        UTIL.clearNewUnion();
        if (v == "99") {
            isNewUnion = true;
            $(".display").fadeIn();
        } else {
            isNewUnion = false;
            $(".display").fadeOut();
        }
    });

    $("#btnShowAddUnionModal").on('click', function () {
        $('#updateButtonUnion').hide();
        $('#submitButtonUnion').show();
        showAddUnionModal();
    });
    $("#modalAddUnion").on('show.bs.modal', generateUnions);
    $("#modalAddUnion").on('hide.bs.modal', function () {
        rowUnion = null;
        $("#request_from").val("");
    });
    
    $("#submitButtonUnion").on('click', submitUnion);

    $("#updateButtonUnion").on('click', function () {
        var f = $('#addreportingunionform');
        var division = $("select#division").val();
        var zillaid = $("select#district").val();
        var upazilaid = $("select#upazila").val();
        var multipleUnionsArr = [];
        var multipleUnionsSel = $('#multi-select-union-container select option:selected');
        $.each(multipleUnionsSel, function (i, e) {
            var v = $(e).attr('value');
            multipleUnionsArr.push(v);
        });
        //Modified by Helal
        var data = $.app.pairs('#addreportingunionform');
        var mUnion = $("#multiple_union").val();
        data.unionids = mUnion ? $("#multiple_union").val().toString() : null;
        delete data['multi-select-union'];
        console.log(rowUnion);
        var failed = UTIL.validateReportingGeo.validateFPIForm(data, isNewUnion);
        if (failed) {
            alert("Fill Up All Data Properly");
        } else {
            data["request_from"] = $("#request_from").val();
            data["division"] = division;
            data["zillaid"] = zillaid;
            data["upazilaid"] = upazilaid;
            data["unionid"] = rowUnion["reporting_unionid"];
            delete data["reporting_union_id"];
            data = JSON.stringify(data);
            console.log(data);
//            return false;
            UTIL.request("report-geo-info?action=updateUnionDetails", {data: data}, "POST").then(function (resp) {
                alert(resp.message);
                $("#modalAddUnion").modal("hide");
                $("#btnShowUnion").click();
            });
        }

    });

    $("#data-table-union tbody").on('click', 'a.btn-union-update', function () {
        var tr = $(this).closest('tr');
        rowUnion = populatedUnionTable.row(tr).data();
        console.log(rowUnion);
        $("#modalAddUnion .modal-title").text("Update Union");
        $('#submitButtonUnion').hide();
        $('#updateButtonUnion').show();

        showAddUnionModal();
    });
    $('#btnShowUnion').on('click', viewUnion);


    // Add Unit Modal, Table
    $('#btnShowAddReportingUnitModal').on('click', showAddReportingUnitModal);
    $('#catchment_reporting_union_id_for_unit').on('change', generateVillage);
    $("#btnShowReportingUnit").on("click", viewReportingUnitTable);
    $("#submitButtonReportingUnit").on("click", submitReportingUnit);
//    $('#updateButtonReportingUnit').on('click', updateReportingUnit);
    $('#updateButtonReportingUnit').on('click', updateReportingUnit);
    $("#modalUpdaReportingUnit").on('hide.bs.modal', function () {
        updateRowUnit = null;
    });
    //Table Unit - Update Button
    $(document).on('click', '#data-table-unit tbody a.btn-unit-update', function (event) {
//        event.stopImmediatePropagation();
        var rt = new UTIL.renderingTable('#data-table-unit');
        var dt = rt.getDataTable();
        var tr = $(this).closest('tr');
        var row = dt.row(tr).data();
        console.log("Update catchment area Current Rows", row);
        updateCatchmentUnitModal(row);
//        return false;
//        showAddReportingUnitModal(rows);
    });

    //Table Unit - Delete Unit
    $(document).on('click', '#data-table-unit tbody a.btn-unit-delete', function () {
        var rt = new UTIL.renderingTable('#data-table-unit');
        var dt = rt.getDataTable();
        var tr = $(this).closest('tr');
        var rows = dt.row(tr).data();
        console.log(rows);
        $('#deleteReportingUnitName').html("<b>" + rows['fwaunitlabel'] + " Unit</b>" + " of  <b>" + rows['unionnameeng']) + " Union?</b>";
        $('#deleteReportingUnit').modal('show');

        $('#btnConfirm-deleteReportingUnit').off().on('click', function () {
            console.log(rows);
            var payload = JSON.stringify(rows);
            console.log(payload);
            UTIL.request("report-geo-info?action=deleteUnit", {data: payload}, "POST").then(function (r1) {
                toastr[r1.success]("<b>" + r1.message + "</b>");
                $('#deleteReportingUnit').modal('hide');
                if (r1.success == "success")
                    $("#btnShowReportingUnit").click();
            });
        });
    });

    //Table Union - Delete Union
    $(document).on('click', '#data-table-union tbody a.btn-union-delete', function () {
        var rt = new UTIL.renderingTable('#data-table-union');
        var dt = rt.getDataTable();
        var tr = $(this).closest('tr');
        var rows = dt.row(tr).data();
        console.log(rows);
        $('#deleteReportingUnionName').html("<b>" + rows['unionnameeng'] + " Union</b>" + " of  <b>" + rows['upazilanameeng']) + " Upazila?</b>";
        $('#deleteReportingUnion').modal('show');

        $('#btnConfirm-deleteReportingUnion').off().on('click', function () {
            console.log(rows);
            delete rows.zillanameeng;
            delete rows.upazilanameeng;
            var payload = JSON.stringify(rows);
            console.log(rows);
            UTIL.request("report-geo-info?action=deleteUnionDetails", {data: payload}, "POST").then(function (r1) {
                console.log(r1);
                alert(r1["message"]);
                $("#deleteReportingUnion").modal("hide");
                $("#btnShowUnion").click();
            });
        });
    });
});
