<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<link href="resources/css/newStyle.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/centerModal.css" rel="stylesheet" type="text/css"/>
<script src="resources/js/ProviderManagement.js"></script>
<style>
    .label {
        border-radius: 11px!important;
    }
    #tableContent{
        display: none;
    }
    .btn-catchment-x:before{
        content: " - ";
        width: 24px;
        display: inline-block;
        font-weight:bold;
    }
    .mb0{ margin-bottom: 0 !important}
    .pb0{ padding-bottom: 0 !important}
    tr:last-child .btn-catchment-x:before{
        content: " + ";
    }
    .table-counter tbody 
    {
        counter-reset:row;
    }
    .table-counter tbody tr
    {
        counter-increment:row;
    }
    .table-counter tbody td:first-child:before
    {
        content:counter(row) !important;
    }
    .modal-catchment .fa{width: 10px;text-align: center  }
    .modal-catchment  tr:first-child .btn-danger,
    .modal-catchment  tr:last-child .btn-danger
    { display: none}
    #addNewProviderForm .table,  #basicModal .table  {
        margin-bottom: 0px!important;
    }


</style>
<script>
    var divisionJson = null;
    var districtJson = null;
    var upazilaJson = null;
    var unionJson = null;
    var providerListJson = [];
    var providerTypeJson = null;
    var isActive = "1";


    $(document).ready(function () {

        var config = {
            divid: 50,
            zillaid: 69,
            upazilaid: 9,
            unionid: 57
        };

        //var $providerType = $.app.select.$providerType('select#providerType', '', 'All'),
                //$division = $.app.select.$division('select#division'),
                $zilla = $('select#district'),
                $upazila = $('select#upazila'),
                $union = $('select#union'),
                $btn = $("button#showdataButton"),
                init = 0;


//        $providerType.on('Select', function (e, data) {
//            providerTypeJson = data;
//        });

//        $division.change(function (e) {
//            $zilla.Select();
//            $upazila.Select();
//            $union.Select();
//            $division.val() && $.app.select.$zilla($zilla, $division.val());
//            //alert(2);
//        }).on('Select', function (e, data) {
//            //alert(1);
//            !init && $(this).val(config.divid).change();
//            districtJson = data;
//        });
//
//        $zilla.change(function (e) {
//            $upazila.Select();
//            $union.Select();
//            $division.val() && $zilla.val() && $.app.select.$upazila($upazila, $zilla.val());
//            // alert(4);
//        }).on('Select', function (e, data) {
//            //alert(3);
//            !init && $(this).val(config.zillaid).change();
//            upazilaJson = data;
//        });
//
//        $upazila.change(function (e) {
//            $union.Select();
//            $division.val() && $zilla.val() && $upazila.val() && $.app.select.$union($union, $zilla.val(), $upazila.val());
//            //alert(6);
//        }).on('Select', function (e, data) {
//            //alert(5);
//            !init && $(this).val(config.upazilaid).change();
//            unionJson = data;
//        });
//
//        $union.on('Select', function (e, data) {
//            !init++ && $(this).val(config.unionid) && $btn.click();
//        });

    });
</script>

<!--<script src="resources/js/jquery.blockUI.js" type="text/javascript"></script>-->
<style>
    /*table tr:nth-child(odd) th {
        border-color: activecaption;
    }
    table tr:nth-child(odd) td {
        border-color: activecaption;
    }
    table tr:nth-child(even) td {
        border-color: activecaption;
    }*/
    .modal-table-header{
        font-size: 18px;
    }
    .no-internet{
        color: #dd4b39;
        margin: 9px;
        font-size: 180%;
        font-weight: bold;
    }
</style>
<script>
//$.blockUI({ message: '<h1 class="no-internet"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i> No internet connection</h1>' });
    //Load Provider Type 
    //Global Variables
    //var district=null;
    var selectedProvider = null;
    var isUnitWardChange = false;

    function btnAddProviderClickHandler() {
        if (!upazilaAndUnionSelected()) {
            return;
        }
        if ($('#providerType').val() == "") {
            $.toast("Please select specific provider type", "error")();
            return;
        }
        //Clear previous value for new insert
        $("[name='id']").val("");
        $("[name='name']").val("");
        $("[name='password']").val("");
        $("[name='phone']").val("");
        $("[name='joinDate']").val("");
        $("[name='superviserCode']").val("");


        var pType = $("[name='type']");
        pType.find('option').remove();
        var id = $('#providerType').val();
        var name = $("#providerType option:selected").text();
        $('<option>').val(id).text(name).appendTo(pType);

        $("#modalAddProvider").modal('show');
    }

    function upazilaAndUnionSelected() {
        return $.isValid();
    }
    //Provider update validator
    function updateProviderValidator(editObj) {
        var isAllValid = true;
        var mapObj = {
            districtId: '* District',
            upazilaId: '* Upazila',
            unionId: '* Union',
            typeId: '* Provider Type',
            providerIdHidden: '* Provider code',
            password: '* Password',
            name: '* Provider name',
            mobile: '* Mobile no.'
        };

        $.each(editObj, function (k, v) {
            if (k == 'supervisor')
                return;
            if (!v) {
                var text = mapObj[k];
                text = (text[0]) == "*" ? text + " required" : "Select a specific " + text;
                $.toast(text, "error")();
                return isAllValid = false;
            }
        })

        return isAllValid;
    }


    function setActivity(checkbox) {
        if (checkbox.checked) {
            isActive = "1";
        } else {
            isActive = "0";
        }
    }

//=Change device setting======================================================================
    function buttonSettings(providerId, columnType, setting) {
        var klass = setting == 1 ? 'btn-info' : 'btn-default';
        return  '<button  onclick="changeSettings(this,' + providerId + ',' + columnType + ')" data-setting="' + setting + '" class="btn btn-flat ' + klass + ' btn-xs bold"><i class="fa fa-check fa-lg" aria-hidden="true"></i></button>';
    }

    function changeSettings(btnRef, providerId, columnType) {
        var btn = $(btnRef);
        var setting = btn.data("setting");
        console.log(btnRef, providerId, columnType, setting);

        Pace.track(function () {
            $.ajax({
                url: "provider-management?action=updateSettings",
                data: {
                    providerId: providerId,
                    settingId: setting,
                    columnType: columnType,
                    districtId: $("select#district").val()
                },
                type: 'POST',
                success: function (result) {
                    if (result === "1") { //change only if one row is affected (When device setting is updated)
                        if (setting === 1) {
                            btn.data('setting', 2);
                            btn.removeClass('btn-info');
                        } else {
                            btn.data('setting', 1);
                            btn.addClass('btn-info');
                        }
                        var message = columnType == 1 ? "Device setting is updated" : "Area is updated";
                        $.toast(message, "success")();
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.toast("Error while updating device settings", "error")();
                }
            }); //End Ajax
        }); //End Pace loader 
    }
//=End Change device setting===================================================================

//=Add area to provider========================================================================
    function btnAddAreaClickHandler(btnId, providerId, typeId, mouzaId, villageId) {

        Pace.track(function () {
            $.ajax({
                url: "provider-management?action=addAreaToProvider",
                data: {
                    divisonId: $("select#division").val(),
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: $("select#unionForAssign").val(),
                    mouzaId: mouzaId,
                    villageId: villageId,
                    providerId: providerId,
                    typeId: typeId
                },
                type: 'POST',
                success: function (result) {
                    loadModalData(providerId, typeId, $("select#unionForAssign").val());
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.toast("Error while adding area to provide", "error")();
                }
            });
        });
    }
//=End add area to provider====================================================================


//=Remove area to provider====================================================================
    function btnRemoveAreaClickHandler(btnId, providerId, typeId, mouzaId, villageId) {
        Pace.track(function () {
            $.ajax({
                url: "provider-management?action=removeAreaFromProvider",
                data: {
                    districtId: selectedProvider.zillaid,
                    upazilaId: selectedProvider.upazilaid,
                    unionId: $("#unionForAssign").val(), //selectedProvider.unionid, //unionForAssign
                    mouzaId: mouzaId,
                    villageId: villageId,
                    providerId: providerId,
                    typeId: typeId
                },
                type: 'POST',
                success: function (result) {
                    if (result === "1") { //change only if one row is affected
                        loadModalData(providerId, typeId, $("select#unionForAssign").val());
                        // alert("Area Removed");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.toast("Error while removing area to provider", "error");
                }
            });
        });
    }
//=End remove area to provider=================================================================


//=Load Assign modal data=====================================================================
    function loadModalData(providerid, provtype, unionId) {
        $('#modalTableBody').empty();
        Pace.track(function () {
            $.ajax({
                url: "provider-management?action=getMouzaData",
                data: {
                    districtId: selectedProvider.zillaid,
                    upazilaId: selectedProvider.upazilaid,
                    unionId: unionId,
                    providerId: providerid,
                    provType: provtype
                },
                type: 'POST',
                success: function (result) {
                    var json = JSON.parse(result);
                    if (json.length === 0) {
                        //btn.button('reset');
                        $.toast("No village found", "error")();
                        return;
                    }

                    for (var i = 0; i < json.length; i++) {
                        var parsedData = "<tr data-village='" + JSON.stringify(json[i]) + "'>";
                        parsedData += "<td>" + (i + 1) + "</td>"
                                + "<td class='text-left'> [" + json[i].mouzaid + "] " + json[i].mouzaname + "</td>"
                                + "<td class='text-left'> [" + json[i].villageid + "] " + json[i].villagename + "</td>";
                        if (json[i].provtype === "null" && json[i].providerid === "null") {

                            parsedData += "<td><button id='btnAddArea" + (i + 1) + "' onClick='btnAddAreaClickHandler(" + (i + 1) + ", " + providerid + "," + provtype + "," + json[i].mouzaid + "," + json[i].villageid + ")'  class='btn btn-flat btn-block btn-default btn-xs bold'>Add</button></td>";
                            parsedData += "<td></td>";

                        } else {

                            parsedData += "<td><button id='btnAddArea" + (i + 1) + "' onClick='btnRemoveAreaClickHandler(" + (i + 1) + ", " + providerid + "," + provtype + "," + json[i].mouzaid + "," + json[i].villageid + ")'  class='btn btn-flat btn-block btn-info btn-xs bold'>Remove</button></td>";
                            parsedData += "<td><button class='btn btn-flat btn-block btn-info btn-xs btn-catchment bold'>Unit/Ward</button></td>";
                        }

                        parsedData += "</tr>";
                        $('#modalTableBody').append(parsedData);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.toast("Error while fetching data", "error")();
                }
            });
        });
    }
//=End load modal data========================================================================

//=Set And Change unit========================================================================
    function changeUnit(selectedOption, unionid, mouzaId, villageId, provCode) {
        Pace.track(function () {
            $.ajax({
                url: "provider-management?action=updateUnit",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: unionid,
                    mouzaId: mouzaId,
                    villageId: villageId,
                    unitId: selectedOption.value,
                    providerCode: provCode
                },
                type: 'POST',
                success: function (result) {
                    //alert("Unit added");

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.toast("Error while fetching data", "error")();
                }
            });
        });
    }
    function changeUnitClick(selectedOption, unionid, mouzaId, villageId, provCode) {
        var unitId = $("#optionUnit" + provCode + "" + unionid + "" + mouzaId + "" + villageId).val();

        var buttonClass = "btn btn-flat btn-xs btn-success";
        var buttonIcon = '<i class=\"fa fa-check\" aria-hidden=\"true\"></i>';

        if (unitId == "") {
            buttonClass = "btn btn-flat btn-xs btn-info";
            buttonIcon = '<i class=\"fa fa-plus\" aria-hidden=\"true\"></i>';

        }

        $(selectedOption).html("<i class='fa fa-spinner fa-pulse'></i>");
        Pace.track(function () {
            $.ajax({
                url: "provider-management?action=updateUnit",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: unionid,
                    mouzaId: mouzaId,
                    villageId: villageId,
                    unitId: unitId,
                    providerCode: provCode
                },
                type: 'POST',
                success: function (result) {
                    var msg = 'Unit added successfuly';
                    $(selectedOption).html(buttonIcon);
                    $(selectedOption).removeClass('btn btn-flat btn-xs btn-info').addClass(buttonClass);
                    if (unitId === null || unitId === "")
                        msg = "Unit unset successfuly";
                    $.toast(msg, "success")();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.toast("Error while fetching data", "error")();
                }
            });
        });
    }


//===Set And Change ward=====================================================================
    function changeWard(selectedOption, unionid, mouzaId, villageId, provCode) {
        Pace.track(function () {
            $.ajax({
                url: "provider-management?action=updateWard",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: unionid,
                    mouzaId: mouzaId,
                    villageId: villageId,
                    wardId: selectedOption.value,
                    providerCode: provCode
                },
                type: 'POST',
                success: function (result) {
                    //alert("Ward added");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.toast("Error while fetching data", "error")();
                }
            });
        });
    }

    function changeWardClick(selectedOption, unionid, mouzaId, villageId, provCode) {
        var wardId = $("#optionWard" + provCode + "" + unionid + "" + mouzaId + "" + villageId).val();

        var buttonClass = "btn btn-flat btn-xs btn-success";
        var buttonIcon = '<i class=\"fa fa-check\" aria-hidden=\"true\"></i>';

        if (wardId == "") {
            buttonClass = "btn btn-flat btn-xs btn-info";
            buttonIcon = '<i class=\"fa fa-plus\" aria-hidden=\"true\"></i>';
        }

        $(selectedOption).html("<i class='fa fa-spinner fa-pulse'></i>");
        Pace.track(function () {
            $.ajax({
                url: "provider-management?action=updateWard",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: unionid,
                    mouzaId: mouzaId,
                    villageId: villageId,
                    wardId: wardId,
                    providerCode: provCode
                },
                type: 'POST',
                success: function (result) {
                    var msg = 'Word added successfuly';
                    $(selectedOption).html(buttonIcon);
                    $(selectedOption).removeClass('btn btn-flat btn-xs btn-info').addClass(buttonClass);
                    if (wardId === null || wardId === "")
                        msg = "Word unset successfuly";
                    $.toast(msg, "success")();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.toast("Error while fetching data", "error")();
                }
            });
        });

    }



    function changeRound(selectedOption, districtId, upazilaId, unionId, providerId, FWAUnit) {
        Pace.track(function () {
            $.ajax({
                url: "provider-management?action=updateRound",
                data: {
                    districtId: districtId,
                    upazilaId: upazilaId,
                    unionId: unionId,
                    round: selectedOption.value,
                    providerId: providerId,
                    FWAUnit: FWAUnit
                },
                type: 'POST',
                success: function (result) {
                    $.toast("Round added successfully", "success")();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.toast("Error while fetching data", "error")();
                }
            });
        });
    }


//=Open Modal For Assign area to provider========================================================
    function areaAssignClickHandler(id) {
        if (!upazilaAndUnionSelected()) {
            return;
        }
        $("#basicModal").modal('show');
        var unionId = $("select#union").val();
        alert(unionId);
        var unionForAssign = $('#unionForAssign');

        $.get('UnionJsonProvider', {
            districtId: $("select#district").val(), upazilaId: $("select#upazila").val(), zilaId: $("select#district").val()
        }, function (response) {
            var returnedData = JSON.parse(response);
            unionForAssign.find('option').remove();
            //$('<option>').val("0").text('- Select Union -').appendTo(unionForAssign);
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].unionid;
                var name = returnedData[i].unionnameeng;
                if (unionId == id)
                    $('<option selected>').val(id).text(name + ' [' + id + ']').appendTo(unionForAssign);
                else
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(unionForAssign);


            }
        });



        var provider = $("#btnAssign" + id).data('provider');
        selectedProvider = provider;
        $('#assignModalTitle').html('Assign area to <strong>' + provider.provname + ' [' + provider.typename + ']</strong>');
        var unitOptions = '';
        $.post('provider-management?action=getUnits', function (response) {
            var units = JSON.parse(response);
            for (var i = 0; i < units.length; i++) {
                unitOptions += '<option value=\"' + units[i].ucode + '\">' + units[i].uname + '</option>';
            }
        });

        window.loadModalData(provider.providerid, provider.provtype, unionId);
        /*$('#modalTableBody').empty();
         
         $.ajax({
         url: "provider-management?action=getMouzaData",
         data: {
         districtId: $("select#district").val(),
         upazilaId: $("select#upazila").val(),
         unionId: $("select#union").val(),
         providerid: provider.providerid,
         provtype: provider.provtype
         },
         type: 'POST',
         success: function (result) {
         var json = JSON.parse(result);
         
         for (var i = 0; i < json.length; i++) {
         
         var parsedData = "<tr><td>" + (i + 1) + "</td>"
         + "<td> [" + json[i].mouzaid + "] " + json[i].mouzanameeng + "</td>"
         + "<td> [" + json[i].villageid + "] " + json[i].villagenameeng + "</td>";
         
         if (json[i].provtype === "null" && json[i].providerid === "null") {
         parsedData += "<td><button id='btnAddArea" + (i + 1) + "' onClick='btnAddAreaClickHandler(" + (i + 1) + ", " + provider.providerid + "," + provider.provtype + "," + json[i].mouzaid + "," + json[i].villageid + ")'  class='btn btn-flat btn-block btn-default btn-xs'>Add</button></td></tr>";
         } else {
         parsedData += "<td><button id='btnAddArea" + (i + 1) + "' onClick='btnRemoveAreaClickHandler(" + (i + 1) + ", " + provider.providerid + "," + provider.provtype + "," + json[i].mouzaid + "," + json[i].villageid + ")'  class='btn btn-flat btn-block btn-success btn-xs'>Removes</button></td></tr>";
         }
         $('#modalTableBody').append(parsedData);
         }
         },
         error: function (jqXHR, textStatus, errorThrown) {
         alert("Error while fetching data");
         }
         });*/
    }

//=End Open Modal For  assign area=============================================================

//=Open Modal for Update provider==============================================================

    $(function () {
        var $providerType = $('select#editProviderType'),
                $zilla = $('select#editDistrict')
                .change(function (e) {
                    $upazila.Select();
                    $union.Select();
                    $.app.select.$upazila($upazila, $zilla.val());
                }),
                $upazila = $('select#editUpazila')
                .change(function (e) {
                    $union.Select();
                    $zilla.val() && $upazila.val() && $.app.select.$union($union, $zilla.val(), $upazila.val());
                }),
                $union = $('select#editUnion');


        /************/
        window.assignArea = function (index) {
            var provider = window.providerListJson[index];
            console.log("Hello: " + provider);

            window.selectedProvider = provider;
            var $modal = $("#basicModal").modal('show');
            var unionForAssign = $('#unionForAssign');
            //var unionid=$('select#union').val();
            $.app.select.$union(unionForAssign, provider.zillaid, provider.upazilaid, provider.unionid, null);

            $modal.find('#assignModalTitle').html('Assign area - <strong>' + provider.provname + ' [' + provider.typename + ']</strong>');
            window.loadModalData(provider.providerid, provider.provtype, provider.unionid);
        }

        window.updateProvider = function (target) {
            //aaaaaaaaaa
            var row = $(target).data('provider');
            console.log('Update: ', row);
            $('#nameAsEditProvTitle').text(row.provname + " - " + row.providerid); //title
            $('#editProviderIdHidden').val(row.providerid);
            $('#editProviderName').val(row.provname);
            $('#editProviderPassword').val(row.provpass);
            $('#editProviderId').val(row.providerid);
            $('#editProviderMobile').val(('0' + row.mobileno).substr(-11));
            $('#editProviderSupervisor').val(row.supervisorcode);
            $("#editProviderActive").prop("checked", !!row.active);

            //Load provtype 
            $.app.select.$providerTypeByProvider($('select#editProviderType'), $("#district").val(), row.provtype);
            
            var selected = "";
            var $select = "";
            $.get("DistrictJsonDataProvider?division=" + (row.divid || 0), function (data) {
                $select = clearSelect('editDistrict', '--Select division--');
//                $select = $('select#editDistrict');
//                $select.find('option').remove();
//                $select.append('<option value="">--Select division--</option>');
                $.each(JSON.parse(data), function (key, value){
                    value.zillaid == row.zillaid ? $select.append('<option value=' + value.zillaid + ' selected>' + value.zillanameeng + ' [' + value.zillaid + ']</option>') : "";
                    //value.zillaid == row.zillaid ? selected = "selected" : selected = "";
                    //$select.append('<option value=' + value.zillaid + ' ' + selected + '>' + value.zillanameeng + ' [' + value.zillaid + ']</option>');
                });
                //upazila load here
                $.get("UpazilaJsonProvider?districtId=" + (row.zillaid || 0), function (data) {
                    $select = clearSelect('editUpazila', '--Select upazila--');
                    $.each(JSON.parse(data), function (key, value){
                        value.upazilaid == row.upazilaid ? $select.append('<option value=' + value.upazilaid + ' selected>' + value.upazilanameeng + ' [' + value.upazilaid + ']</option>') : "";
                        //value.upazilaid == row.upazilaid ? selected = "selected" : selected = "";
                        //$select.append('<option value=' + value.upazilaid + ' ' + selected + '>' + value.upazilanameeng + ' [' + value.upazilaid + ']</option>');
                    });
                    //union load here
                    $.get( "UnionJsonProvider", { zilaId: (row.zillaid || 0), upazilaId: (row.upazilaid || 0) } )
                    .done(function( data ) {
                        $select = clearSelect('editUnion', '--Select union--');
                        $.each(JSON.parse(data), function (key, value){
                            value.unionid == row.unionid ? selected = "selected" : selected = "";
                            $select.append('<option value=' + value.unionid + ' ' + selected + '>' + value.unionnameeng + ' [' + value.unionid + ']</option>');
                        });
                        $('#updateProviderModal').modal('show');
                    });
                });
            });
            function clearSelect(context, firstSelect) {
                context = $('select#' + context);
                context.find('option').remove();
                //context.append('<option value="">' + firstSelect + '</option>');
                return context;
            }
            //$.app.select.$zilla($('select#editDistrict'), row.divid, row.zillaid);
            //$.app.select.$upazila($('select#editUpazila'), row.zillaid, row.upazilaid);
            //$.app.select.$union($('select#editUnion'), row.zillaid, row.upazilaid, row.unionid);
            //$('#updateProviderModal').modal('show');
        };
    });


//=Open Modal For deactive Provider ID====================================================
    function setProviderInActiveModal(id) {
        if (!upazilaAndUnionSelected()) {
            return;
        }
        //yyyyyyyyyyyyyyy
        //var btn = $(this).button('loading');
        // providerIdForInActive = $("#btnInActive" + id).data('provider');
        //providerIdForInActive=id;
        $('#inActiveProvider').modal('show');
        $('#providerIdForInActive').val(id);

    }

    // Catchment set unit/ward

    var Catchment = {
        modal: null,
        relatedButton: null,
        relatedTarget: {},
        relatedArea: [],
        //relatedArea: [{fwaunit: 1, ward: 1}, {fwaunit: 2, ward: 1}],
        template: null,
        getRow: function (row) {
            row = row || {oid: '', fwaunit: '', ward: ''};
            var tpl = $(this.template);
            tpl.find(':input').each(function (i, o) {
                $(o).val(row[o.name]);
            });

            var bs = tpl.find('.btn-catchment-set'), fa = bs.find('.fa');
            if (row.oid) {
                bs.removeClass('btn-info').addClass('btn-success');
                fa.removeClass('fa-plus').addClass('fa-check');
            }
            return tpl;
        },

        list: function (rows) {
            var self = this;
            self.relatedArea = rows;
            var tbody = self.modal.find('tbody');
            var tr = $.map(self.relatedArea, $.proxy(self.getRow, self));
            var last = (rows.slice(-1) || [{}])[0];
            console.log('last', last);
            if ((last.fwaunit || last.ward)) {
                tr.push(self.getRow());
            }
            tbody.html(tr);
        },
        listAsync: function (data) {
            var self = this;
            var xhr = self.post(data);
            return xhr.then(function (d) {
                //console.log('relatedArea', d);
                self.list($.parseJSON(d));
            });
        },
        fixScrolling: function () {
            //$('.modal').on("hidden.bs.modal", function (e) {
            if ($('.modal:visible').length) {
                $('body').addClass('modal-open');
            }
            //});
        },
        setup: function (modal) {
            this.modal = modal;
            $.app.select.$unit(this.modal.find('.input-unit'), '', '---');
            $.app.select.$ward(this.modal.find('.input-ward'), '', '---');
            this.template = this.modal.find('tbody').html();
        },
        post: function (data, action) {
            action = action || 'get';
            var options = {url: 'provider-management?action=' + action + 'Providerarea', data: data, type: 'POST'};
            console.log('post: options ', options);
            return $.ajax(options);
        },
        reset: function (data) {
            this.relatedArea = [];
            //var html = '<span class="badge">' + data.typename + '</span> ' + data.villagenameeng;
            this.modal.find('.text-catchment').html(data.villagenameeng);
            this.modal.find('tbody').html(this.template);
        },
        init: function () {
            var self = this, modal = $('.modal-catchment');
            self.setup(modal);
            //----------------------------------------;---------------------------
            $('body').on('click', '.btn-catchment', function (e) {

                self.relatedButton = $(e.target).button('loading');

                var tr = $(this).closest('tr');
                var selectedVillage = tr.data('village');
                self.reset({villagenameeng: selectedVillage.villagenameeng, typename: selectedProvider.typename});

                var relatedTarget = {
                    zillaid: selectedProvider.zillaid,
                    upazilaid: selectedProvider.upazilaid,
                    unionid: selectedProvider.unionid,
                    providerid: selectedProvider.providerid,
                    provtype: selectedProvider.provtype,
                    mouzaid: selectedVillage.mouzaid,
                    villageid: selectedVillage.villageid
                };

                self.relatedTarget = relatedTarget;
                modal.modal('show', relatedTarget);
            });

            modal.on('click', '.btn', function (e) {
                var btn = $(this);
                var tr = btn.closest('tr');
                var pairs = $.app.pairs(tr.find(':input').serializeArray());
                var row = $.extend({}, self.relatedTarget, pairs);
                console.log('row', row);

                if (btn.is('.btn-catchment-set')) {
                    if (!(row.fwaunit || row.ward)) {
                        return $.toast('Ooops! choose unit/ward first', 'error')();
                    }

                    if (row.provtype == 3 && !(row.fwaunit && row.ward)) {
                        return $.toast('You have to choose both of unit &amp; ward', 'error')();
                    }

                    if (row.provtype == 2 && !(row.ward)) {
                        return $.toast('Ooops! Ward is mandatory', 'error')();
                    }

                    self.post(row, 'set').then(function (res) {
                        res = $.parseJSON(res);
                        $.toast(res.message, 'warning')();
                        self.listAsync(self.relatedTarget);
                    });
                }

                if (btn.is('.btn-catchment-del')) {
                    if (!(row.oid)) {
                        $.toast('Ooops! Nothing to delete', 'error')();
                        return;
                    }

                    self.post(row, 'del').then(function (res) {
                        res = $.parseJSON(res);
                        $.toast(res.message, 'warning')();
                        self.listAsync(self.relatedTarget);
                    });
                }
            });

            modal.on('shown.bs.modal', function (e) {
                //console.log('data: ', e.relatedTarget, self.relatedArea);
                self.listAsync(e.relatedTarget);
            });

            modal.on('hidden.bs.modal', function () {
                self.relatedButton.button('reset');
                self.fixScrolling();
            });
        }
    };

    $(function () {
        Catchment.init();
    });


//=Open Modal For Set Ward Unit by Provider ID====================================================





    function setWardUnitClickHandler(id) {
        //alert(['setWardUnitClickHandler',id]);
        if (!upazilaAndUnionSelected()) {
            return;
        }
        var btn = $("#btnAssign" + id).button('loading');
        var provider = btn.data('provider');
        $('#setUnitWardModalTitle').html('Set Unit/ Ward - <strong>' + provider.provname + ' [' + provider.typename + ']</strong>');


        var unit = null;
        var unitLength = null;
        var unitOptions = '<option value=""> -- </option>';
        var wardOptions = '<option value=""> -- </option>';

//
//        $.post('provider-management?action=getUnits', function (response) {
//            var units = JSON.parse(response);
//            unit = JSON.parse(response);
//            unitLength = units.length;
//        });

        $('#modalSetUnitWard').modal('show');

        $('#modalSetUnitWardTableBody').empty();
        $.ajax({
            url: "provider-management?action=getDataForSettingUnitWardByProvider",
            data: {
                districtId: $("select#district").val(),
                upazilaId: $("select#upazila").val(),
                unionId: $("select#union").val(),
                providerId: provider.providerid
            },
            type: 'POST',
            success: function (result) {
                result = JSON.parse(result);
                unit = result.unit;
                var json = result.area;

                $('#modalSetUnitWardTableHead').empty();
                var header = "<tr>"
                        + "<th>#</th>"
                        + "<th>Name</th>"
                        + "<th>Type</th>"
                        + "<th>Code</th>"
                        + "<th>Union</th>"
                        + "<th>Mouza</th>"
                        + "<th>Village</th>"
                        + "<th>Unit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>"
                        + "<th>Ward&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>"
                        + "</tr>";
                $('#modalSetUnitWardTableHead').append(header);

                for (var i = 0; i < json.length; i++) {

                    var buttonClassForUnit = "btn btn-flat btn-xs btn-info";
                    var buttonIconForUnit = '<i class=\"fa fa-plus\" aria-hidden=\"true\"></i>';
                    var buttonClassForWard = "btn btn-flat btn-xs btn-info";
                    var buttonIconForWard = '<i class=\"fa fa-plus\" aria-hidden=\"true\"></i>';

                    var provType;
                    if (json[i].provtype === 2)
                        provType = "HA";
                    else if (json[i].provtype === 3)
                        provType = "FWA";
                    else if (json[i].provtype === 4)
                        provType = "FWV";
                    else if (json[i].provtype === 11)
                        provType = "AHI";
                    else if (json[i].provtype === 12)
                        provType = "HI";

                    for (var j = 0; j < unit.length; j++) {
                        if (json[i].fwaunit != "null" || json[i].fwaunit != null || json[i].fwaunit != "") {
                            if (json[i].fwaunit == unit[j].ucode) {

                                buttonClassForUnit = "btn btn-flat btn-xs btn-success";
                                buttonIconForUnit = '<i class=\"fa fa-check\" aria-hidden=\"true\"></i>';
                                unitOptions += '<option value=\"' + unit[j].ucode + '\" selected>' + unit[j].uname + '</option>';
                            } else {
                                unitOptions += '<option value=\"' + unit[j].ucode + '\">' + unit[j].uname + '</option>';
                            }
                        } else {
                            unitOptions += '<option value=\"' + unit[j].ucode + '\">' + unit[j].uname + '</option>';
                        }

                    }

                    for (var k = 1; k <= 30; k++) {
                        if (json[i].ward != "null" || json[i].ward != null || json[i].ward != "") {
                            if (json[i].ward == k) {
                                buttonClassForWard = "btn btn-flat btn-xs btn-success";
                                buttonIconForWard = '<i class=\"fa fa-check\" aria-hidden=\"true\"></i>';
                                wardOptions += '<option value=\"' + k + '\" selected>' + k + '</option>';
                            } else {
                                wardOptions += '<option value=\"' + k + '\">' + k + '</option>';
                            }
                        } else {
                            wardOptions += '<option value=\"' + k + '\">' + k + '</option>';
                        }

                    }

                    id = "btnAssign' + json[i].providerid + '"

                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
                            + "<td>" + json[i].provname + "</td>"
                            + "<td>" + provType + "</td>"
                            + "<td>" + json[i].providerid + "</td>"
                            + "<td>" + json[i].unionnameeng + "</td>"
                            + "<td> [" + json[i].mouzaid + "] " + json[i].mouzaname + "</td>"
                            + "<td> [" + json[i].villageid + "] " + json[i].villagename + "</td>"
                            + "<td><select id='optionUnit" + json[i].providerid + "" + json[i].unionid + "" + json[i].mouzaid + "" + json[i].villageid + "'>" + unitOptions + "</select> <button onclick='changeUnitClick(this," + json[i].unionid + "," + json[i].mouzaid + "," + json[i].villageid + "," + json[i].providerid + ")' type='button' class='" + buttonClassForUnit + "'>" + buttonIconForUnit + "</button> </td>"
                            + "<td><select id='optionWard" + json[i].providerid + "" + json[i].unionid + "" + json[i].mouzaid + "" + json[i].villageid + "'>" + wardOptions + "</select> <button onclick='changeWardClick(this," + json[i].unionid + "," + json[i].mouzaid + "," + json[i].villageid + "," + json[i].providerid + ")' type='button' class='" + buttonClassForWard + "'>" + buttonIconForWard + "</button> </td></tr>";
                    $('#modalSetUnitWardTableBody').append(parsedData);
                    unitOptions = null;
                    wardOptions = null;
                    unitOptions = '<option value=""> -- </option>';
                    wardOptions = '<option value=""> -- </option>';

                }
                btn.button('reset');
            },
            error: function (jqXHR, textStatus, errorThrown) {
                btn.button('reset');
                $.toast("Error while fetching data", "error")();
            }
        }); //Ajax end


    }
//=End Open Modal For Set Ward Unit============================================================


//`````````````````````````````````````````````````````````````````````````````JQuery Part goes here```````````````````````````````````````````````````````````````````````````
    $(document).ready(function () {
        $("#btnSetRound").attr("disabled", true); //this enable only for FWA

        //Assign for selected uion area
        $('#unionForAssign').change(function (event) {
            loadModalData(selectedProvider.providerid, selectedProvider.provtype, $('#unionForAssign').val());
        });


//===Update provider=========================================================================
        $('#updateProviderModal form').on('submit', function (e) {
            e.preventDefault();

            if (!upazilaAndUnionSelected()) {
                return;
            }

            var editDistrict = $("select#editDistrict").val();
            var editUpazila = $("select#editUpazila").val();
            var editUnion = $("select#editUnion").val();
            var editProviderType = $("select#editProviderType").val();
            var editProviderPassword = $("#editProviderPassword").val();
            var editProviderId = $("#editProviderId").val();
            var editProviderName = $("#editProviderName").val();
            var editProviderMobile = $("#editProviderMobile").val();
            var editProviderSupervisor = $("#editProviderSupervisor").val();
            var editProviderIdHidden = $("#editProviderIdHidden").val();

            var options = {
                districtId: editDistrict,
                upazilaId: editUpazila,
                unionId: editUnion,
                typeId: editProviderType,
                password: editProviderPassword,
                name: editProviderName,
                mobile: editProviderMobile,
                supervisor: editProviderSupervisor,
                active: isActive,
                providerIdHidden: editProviderIdHidden
            };
            var options2update = {
                districtId: $("select#district").val(),
                upazilaId: $("select#upazila").val(),
                unionId: $("select#union").val()
            };


            //Validation
            if (!updateProviderValidator(options))
                return;

            var options2 = $.extend({}, options, options2update);

            var url = "provider-management?action=updateProvider";
            var url2 = "provider-management?action=checkProviderAreaExistance";

            var btn = $(this).button('loading');
            var xhr;

            xhr = $.post(url2, options2);
            xhr.done(function (d) {
                if (d) {
                    xhr = $.post(url, options);
                    xhr.done(function (d2) {
                        btn.button('reset');
                        $('#updateProviderModal').modal('hide');
                        $("#showdataButton").click();
                        $.toast("Provider update successfully", "success")();
                    });
                } else {
                    btn.button('reset');
                    $('#updateProviderModal').modal('hide');
                    $.toast("Please first delete all area for this provider", "error")();
                }
            });
        });


//===Show provider data=======================================================================

        $('#showdataButton').click(function () {
            //ooo
            $("#tableContent").css("display", "none");
            $("#transparentTextForBlank").css("display", "block");

            if (!upazilaAndUnionSelected()) {
                return;
            }

            var btn = $(this).button('loading');


            if ($("select#providerType").val() === '3') {
                $("#btnSetRound").attr("disabled", false);
            } else {
                $("#btnSetRound").attr("disabled", true);
            }
            $.ajax({
                url: "provider-management?action=showdata",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: $("select#union").val(),
                    providerType: $("select#providerType").val()
                },
                type: 'POST',
                success: function (result) {
                    var json = JSON.parse(result);
                    providerListJson = JSON.parse(result); //assign for globally access like search-short-pagin

                    if (json.length === 0) {
                        btn.button('reset');
                        $.toast("No data found", "error")();
                        return;
                    }
                    $("#transparentTextForBlank").css("display", "none");
                    //show table view after data load
                    $("#tableContent").fadeIn("slow");


                    var tableBody = $('#tableBody');
                    tableBody.empty(); //first empty table before showing data

                    for (var i = 0; i < json.length; i++) {
                        var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                + "<td>" + json[i].providerid + "</td>"
                                + "<td>" + json[i].provname + "</td>"
                                + "<td>" + json[i].typename + "</td>";
                        //Device setting
                        if (json[i].devicesetting) {
                            parsedData += "<td>" + buttonSettings(json[i].providerid, 1, json[i].devicesetting) + "</td>";
                        }
                        //Area Update
                        if (json[i].areaupdate) {
                            parsedData += "<td>" + buttonSettings(json[i].providerid, 2, json[i].areaupdate) + "</td>";
                        }
                        var assignBtnAccess;
                        json[i].provtype=="3"? assignBtnAccess="" : assignBtnAccess="disabled";

                        //Area and Unit/ Ward assign
                        var jsonStr = JSON.stringify(json[i]);
                        parsedData = parsedData + '<td><button id="btnAssign' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="assignArea(' + i + ')" class="btn btn-flat btn-info btn-xs bold" '+assignBtnAccess+'>' + //data-toggle="modal" data-target="#basicModal"
                                '<i class="fa fa-map-marker" aria-hidden="true"></i> Assign</button></td>';
                        parsedData = parsedData + '<td><button id="btnAssign' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="setWardUnitClickHandler(' + json[i].providerid + ')" class="btn btn-flat btn-info btn-xs bold" '+assignBtnAccess+'>' + //data-toggle="modal" data-target="#basicModal"
                                '<i class="fa fa-wrench" aria-hidden="true"></i> Unit/Ward</button></td>';

                        //Set Status
                        if (json[i].active == 1) {
                            parsedData += "<td><span class='label label-flat label-success label-sm'>Active</span></td>";
                        } else {
                            parsedData += "<td><span class='label label-flat label-danger label-sm'>Inactive</span></td>";
                        }

                        //Action Buttion
                        parsedData = parsedData + '<td>' +
                                '<button id="btnUpdate' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="updateProvider(this)" class="btn btn-flat btn-warning btn-xs bold" >' + //data-toggle="modal" data-target="#basicModal"
                                '<i class="fa fa-pencil-square-o" aria-hidden="true"></i> Update</button></td></tr>';

//                                    '<button disabled id="btnInActive' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="setProviderInActiveModal(' + json[i].providerid + ')" class="btn btn-flat btn-danger btn-xs" >' + //data-toggle="modal" data-target="#basicModal"
//                                    '<i class="fa fa-user-times" aria-hidden="true"></i> Deactivate</button>' +
//                                    '</td></tr>';

                        tableBody.append(parsedData);
                    }
                    btn.button('reset');
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    btn.button('reset');
                    $.toast("Request can't be processed", "error")();
                }
            }); //ajax end
        });
//===End Show Data==========================================================================


//

//===Deactive Provider========================================================================
        $('#setProviderInActive').click(function () {
            if (!upazilaAndUnionSelected()) {
                return;
            }
            var btn = $(this).button('loading');

            Pace.track(function () {
                $.ajax({
                    url: "provider-management?action=inActiveProvider",
                    data: {
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val(),
                        providerCode: $('#providerIdForInActive').val()
                    },
                    type: 'POST',
                    success: function (result) {
                        btn.button('reset');
                        if (result != null) {
                            //zzzzz
                            $('#inActiveProvider').modal('hide');
                            $.toast("Provider deactivated successfully", "success")();
                        } else {
                            $.toast("Problem Occured", "error")();
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $.toast("Error while fetching data", "error")();

                    }
                });
            });


        });

//===END Deactive Provider========================================================================    

//===Set Round==============================================================================
        $('#btnSetRound').click(function () {

            if (!upazilaAndUnionSelected()) {
                return;
            }

            $('#modalRound').modal('show');

//            var providerType = $('#providerType');
//            providerType.find('option').remove();
//            $('<option>').val("").text('All').appendTo(providerType);
            $('#modalRound').modal('show');
            var btn = $(this).button('loading');

            var roundOptions = '<option value="">- Select Round-</option>';
            roundOptions += '<option value="1">01</option>';
            roundOptions += '<option value="2">02</option>';
            roundOptions += '<option value="3">03</option>';
            roundOptions += '<option value="4">04</option>';
            roundOptions += '<option value="5">05</option>';

            $('#modalRoundTableBody').empty();
            Pace.track(function () {
                $.ajax({
                    url: "provider-management?action=getDataForSetRound",
                    data: {
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val()
                    },
                    type: 'POST',
                    success: function (result) {
                        btn.button('reset');
                        var json = JSON.parse(result);
                        // alert(json[0].providerid);
                        //=========================================

                        for (var i = 0; i < json.length; i++) {
                            if (json[i].fwaunit === "null") {
                                var fwaunit = "-";
                            } else {
                                var fwaunit = json[i].fwaunit;
                            }

                            if (json[i].fwa_round !== "null" && json[i].fwa_round === 1) {
                                var roundOptions = '<option value="">- Select Round-</option>';
                                roundOptions += '<option value="1" selected>01</option>';
                                roundOptions += '<option value="2">02</option>';
                                roundOptions += '<option value="3">03</option>';
                                roundOptions += '<option value="4">04</option>';
                                roundOptions += '<option value="5">05</option>';

                            } else if (json[i].fwa_round !== "null" && json[i].fwa_round === 2) {
                                var roundOptions = '<option value="">- Select Round-</option>';
                                roundOptions += '<option value="1">01</option>';
                                roundOptions += '<option value="2" selected>02</option>';
                                roundOptions += '<option value="3">03</option>';
                                roundOptions += '<option value="4">04</option>';
                                roundOptions += '<option value="5">05</option>';

                            } else if (json[i].fwa_round !== "null" && json[i].fwa_round === 3) {
                                var roundOptions = '<option value="">- Select Round-</option>';
                                roundOptions += '<option value="1">01</option>';
                                roundOptions += '<option value="2">02</option>';
                                roundOptions += '<option value="3" selected>03</option>';
                                roundOptions += '<option value="4">04</option>';
                                roundOptions += '<option value="5">05</option>';

                            } else if (json[i].fwa_round !== "null" && json[i].fwa_round === 4) {
                                var roundOptions = '<option value="">- Select Round-</option>';
                                roundOptions += '<option value="1">01</option>';
                                roundOptions += '<option value="2">02</option>';
                                roundOptions += '<option value="3">03</option>';
                                roundOptions += '<option value="4" selected>04</option>';
                                roundOptions += '<option value="5">05</option>';

                            } else if (json[i].fwa_round !== "null" && json[i].fwa_round === 5) {
                                var roundOptions = '<option value="">- Select Round-</option>';
                                roundOptions += '<option value="1">01</option>';
                                roundOptions += '<option value="2">02</option>';
                                roundOptions += '<option value="3">03</option>';
                                roundOptions += '<option value="4">04</option>';
                                roundOptions += '<option value="5" selected>05</option>';

                            } else {
                                var roundOptions = '<option value="">- Select Round-</option>';
                                roundOptions += '<option value="1">01</option>';
                                roundOptions += '<option value="2">02</option>';
                                roundOptions += '<option value="3">03</option>';
                                roundOptions += '<option value="4">04</option>';
                                roundOptions += '<option value="5">05</option>';
                            }

                            var parsedData = "<tr style='text-align:center;'><td>" + (i + 1) + "</td>"
                                    + "<td style='text-align:center;'>" + json[i].provname + "</td>"
                                    + "<td style='text-align:center;'>" + json[i].providerid + "</td>"
                                    + "<td style='text-align:center;'>FWA</td>"
                                    + "<td style='text-align:center;'>" + fwaunit + "</td>"
                                    + "<td style='text-align:center;'><select onchange='changeRound(this," + json[i].zillaid + "," + json[i].upazilaid + "," + json[i].unionid + "," + json[i].providerid + "," + json[i].fwaunit + ")' id='optionRound" + (i + 1) + "'>" + roundOptions + "</select></td>";
                            $('#modalRoundTableBody').append(parsedData);
                            //                        if (json[i].fwa_round !=="null") {
                            //                            var id = "#optionRound" + (i + 1);
                            //                           // $('' + id + '').val('' + json[i].fwaunit + '').trigger('change');
                            //
                            //                        }

                        }
                        btn.button('reset');
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        btn.button('reset');
                        $.toast("Error while fetching data", "error")();
                    }
                }); //Ajax end
            });
        });
//===End set round===========================================================================

//===Add new provider (Submission)==============================================================
        $("#addNewProviderForm").submit(function (e) {

            e.preventDefault();

            var postData = $(this).serializeArray();
            var formURL = $(this).attr("action");
            postData.push({name: 'divisionId', value: $("select#division").val()});
            postData.push({name: 'districtId', value: $("select#district").val()});
            postData.push({name: 'upazilaId', value: $("select#upazila").val()});
            postData.push({name: 'unionId', value: $("select#union").val()});
            Pace.track(function () {
                $.ajax(
                        {
                            url: formURL,
                            type: "POST",
                            data: postData,
                            success: function (result) {

                                if (result === "1") { //change only if one row is affected
                                    $('#modalAddProvider').modal('hide');
                                    $.toast("Provider added successfully", "success")();
                                    $('#showdataButton').click();
                                } else if (result === "2") {
                                    $.toast("Provider already added", "error")();

                                } else {
                                    $.toast("Somthing went wrong", "error")();
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                $.toast("Error while adding provider", "error")();
                            }
                        }); //End Ajax
            }); //Pace end
            e.preventDefault();	//STOP default action

        });
//===End Add provider submisson===============================================================

    });
//=End Jquery===============================================================================
</script>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>Provider management <small> (Managed by UFPA)</small></h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <div class="row">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <label for="division">Division</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" tabindex="-1" aria-hidden="true" name="division" id="division"> </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="district">District</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" tabindex="-1" aria-hidden="true" name="district" id="district"> 
                                <option value="">- Select District -</option>
                            </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="upazila">Upazila</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" tabindex="-1" aria-hidden="true" name="upazila" id="upazila">
                                <option value="">- Select Upazila -</option>
                            </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="union">Union</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" tabindex="-1" aria-hidden="true" name="union" id="union">
                                <option value="">- Select Union -</option>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <label for="union">Provider </label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" tabindex="-1" aria-hidden="true" name="providerType" id="providerType" required>
                                <option value="">- Select Type -</option>
                            </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            &nbsp;
                        </div>
                        <div class="col-md-2 col-xs-4">        
                            <button type="button" id="showdataButton" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                <i class="fa fa-table" aria-hidden="true"></i>&nbsp; Show data
                            </button>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            &nbsp;
                        </div>
                        <div class="col-md-2 col-xs-4">        
                            <button type="button" id="btnAddProvider" onclick="btnAddProviderClickHandler()" class="btn btn-flat btn-primary btn-block btn-sm bold" autocomplete="off">
                                <i class="fa fa-user-plus" aria-hidden="true"></i>&nbsp; Add Provider
                            </button>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            &nbsp;
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <button type="button" id="btnSetRound" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off">
                                <i class="fa fa-circle-o-notch" aria-hidden="true"></i>&nbsp; Set Round
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Transparent Text For Blank Space-->
    <section class="content-header" id="transparentTextForBlank" style="display: block;">
        <center class="emis_hologram">eMIS</center>
    </section>

    <!--Table body-->

    <div class="row" id="tableContent">
        <div class="col-xs-12">
            <div class="box box-primary full-screen">
                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <!--                        <button type="button" class="btn btn-flat btn-default btn-xs bold" onclick="window.print();"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>-->
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>

                <!--  Table top -->
                <!--                <div class="box-header" style="margin-bottom: -10px;">
                                    <div class="row">
                                        <div class="col-md-7">
                                        </div>
                
                                    </div>
                                </div>-->

                <!-- table -->
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped" id="data-table">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Provider ID</th>
                                    <th>Provider Name</th>
                                    <th>Type </th>
                                    <th>Device Settings </th>
                                    <th>Area Settings </th>
                                    <th>Area</th>
                                    <th>Set</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>

                    </div>
                </div>

            </div>
        </div>
    </div>
</section>

<!------------------------------------------------------------------------------ Add Provider Modal ------------------------------------------------------------------------------> 
<div class="modal fade" id="modalAddProvider" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold" id="myModalLabel">Add new provider</h4>
            </div>
            <form method="post" id="addNewProviderForm" action="provider-management?action=addNewProvider" class="form-horizontal" role="form"  autocomplete="off">
                <div class="modal-body">
                    <table class="table table-striped">
                        <tbody style="text-align: right">
                            <tr>
                                <td><label>Code <span class="star">*</span></label></td>
                                <td><input type="number" class="form-control check-pos-num" name="id" placeholder="Enter provider ID" required></td>
                            </tr>
                            <tr>
                                <td><label>Password <span class="star">*</span></label></td>
                                <td><input type="password" class="form-control" name="password" placeholder="" required ></td>
                            </tr>
                            <tr>
                                <td><label>Name <span class="star">*</span></label></td>
                                <td><input type="text" class="form-control check-name" name="name" placeholder="Enter provider name" required></td>
                            </tr>
                            <tr>
                                <td><label>Type <span class="star">*</span></label></td>
                                <td>
                                    <select class="form-control" name="type" required>
                                    </select>
                                </td>
                            </tr>     
                            <tr>
                                <td><label>Phone <span class="star">*</span></label></td>
                                <td><input type="text" class="form-control" name="phone"  placeholder="Enter phone number" pattern="01\d{9}" required></td>
                            </tr>     
                            <tr>
                                <td><label>Join Date</label></td>
                                <td><input type="text" class="input form-control input-sm datePickerChooseAll" placeholder="dd/mm/yyyy" name="joinDate" id="joinDate" /></td>
                            </tr>
                            <tr>
                                <td><label>Superviser Code</label></td>
                                <td><input type="number" class="form-control check-pos-num" name="superviserCode" placeholder="Enter superviser code"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="reset" name="reset" class="btn btn-flat btn-default btn-md bold" >Reset</button>
                    <button type="submit" class="btn btn-flat btn-primary btn-md bold" >Submit</button>
                </div>
            </form>
        </div>
    </div>
</div>


<!-----------------------------------------------------------------------------Set Round Modal-------------------------------------------------------------------------------->
<div class="modal fade" id="modalRound" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header label-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel"><i class="fa fa-circle-o-notch" aria-hidden="true"></i>  Set Round</b></h4>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="modal-table-header">
                            <tr>
                                <th>#</th>
                                <th>Provider Name</th>
                                <th>Provider ID</th>
                                <th>Type</th>
                                <th>Unit</th>
                                <th>Round</th>
                            </tr>
                        </thead>
                        <tbody id="modalRoundTableBody">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>


<!-----------------------------------------------------------------------------Assign Area Modal------------------------------------------------------------------------------->
<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold" id="assignModalTitle"> Assign Area</h4>
            </div>

            <div class="modal-body">
                <div class="row">
                    <div class="col-md-1 col-xs-2" style="width: 5%!important;">
                        <label for="division" class="pull-right">Union</label>
                    </div>
                    <div class="col-md-2 col-xs-4">
                        <select class="form-control input-sm" name="unionForAssign" id="unionForAssign">
                            <option value="">- Select Union -</option>
                        </select>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover table-striped">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Mouza</th>
                                <th>Village</th>
                                <th>Assign</th>
                                <th>Set</th>
                            </tr>
                        </thead>
                        <tbody id="modalTableBody">
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>



<!-------------------------------------------------------------------------------- In Active Provider Modal -------------------------------------------------------------------------------->        
<div class="modal fade" id="inActiveProvider" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header label-danger">
                <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                <h4 class="modal-title"><i class="fa fa-user-times" aria-hidden="true"></i><span> Are you sure ?</span></b></h4>
            </div>
            <div class="modal-body">
                <input type="hidden" id="providerIdForInActive">
                <button type="button" id="setProviderInActive" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger">Confirm</button>&nbsp;&nbsp;
                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>



<!-------------------------------------------------------------------------------- update Provider Modal -------------------------------------------------------------------------------->        
<div id="updateProviderModal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title">Update provider - <b  id="nameAsEditProvTitle"></b></h4>
            </div>
            <form  autocomplete="off">
                <div class="modal-body">
                    <input type="hidden" id="editProviderIdHidden">
                    <div class="row">
                        <div class="col-md-2">
                            <label for="editDistrict">District</label>
                        </div>
                        <div class="col-md-4">
                            <select class="form-control" id='editDistrict'>
                                <option value="0">All</option>
                            </select>
                        </div>

                        <div class="col-md-2">
                            <label for="editUpazila">Upazila</label>
                        </div>
                        <div class="col-md-4">
                            <select class="form-control" id='editUpazila'>
                                <option value="0">All</option>
                            </select>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-2">
                            <label for="editUnion">Union</label>
                        </div>
                        <div class="col-md-4">
                            <select class="form-control" id='editUnion'>
                                <option value="0">All</option>
                            </select>
                        </div>

                        <div class="col-md-2">
                            <label for="editProviderType">Provider Type</label>
                        </div>
                        <div class="col-md-4">
                            <select class="form-control" id='editProviderType'>
                                <option value="0">All</option>
                            </select>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-2">
                            <label for="editProviderId">Provider Code</label>
                        </div>
                        <div class="col-md-4">
                            <input type="number" class="form-control" placeholder="Enter Provider Code" id="editProviderId" readonly>
                        </div>

                        <div class="col-md-2">
                            <label for="editProviderName">Name</label>
                        </div>
                        <div class="col-md-4">
                            <input class="form-control check-name" placeholder="Enter Name" id="editProviderName">
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-2">
                            <label for="editProviderPassword">Password</label>
                        </div>
                        <div class="col-md-4">
                            <input type="password" class="form-control" placeholder="Enter Password" id="editProviderPassword">
                        </div>

                        <div class="col-md-2">
                            <label for="editProviderMobile">Mobile</label>
                        </div>
                        <div class="col-md-4">
                            <input type="text" class="form-control" placeholder="Enter Mobile No." id="editProviderMobile" pattern="01\d{9}" required>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-2">
                            <label for="editProviderSupervisor">Supervisor</label>
                        </div>
                        <div class="col-md-4">
                            <input type="number" class="form-control check-pos-num" placeholder="Enter Supervisor Code" id="editProviderSupervisor">
                        </div>

                        <div class="col-md-2">
                            <label for="editProviderSupervisor">Active</label>
                        </div>
                        <div class="col-md-4">
                            <div class="material-switch pull-left">
                                <input id="editProviderActive" onchange="setActivity(this)" name="editProviderActive" type="checkbox">
                                <label for="editProviderActive" class="label-warning"></label>
                            </div>
                        </div>
                    </div>
                    <br>
                    <!--                    <div class="row">
                                            <div class="col-md-2">
                                            </div>
                                            <div class="col-md-4">
                                            </div>
                    
                                            <div class="col-md-2">
                                            </div>
                                            <div class="col-md-4">
                    
                                                                            <div class="form-group">
                                                                                <button type="submit"  id="btnConfirmToEdit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Updating" class="btn btn-flat btn-warning"><b><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Update</b></button>&nbsp;&nbsp;
                                                                                &nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-flat btn-default" data-dismiss="modal">&nbsp;&nbsp;&nbsp;<b><i class="fa fa-window-close"></i>&nbsp;Close&nbsp;&nbsp;&nbsp;</br></button>
                                                                            </div>
                                            </div>
                                        </div>-->
                </div>
                <div class="modal-footer">
                    <!--                    <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal">Cancel</button>
                                        <button type="button" id="btnConfirmToDelete" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger bold">Delete</button>&nbsp;&nbsp;-->
                    <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal">Cancel</button>
                    <button type="submit"  id="btnConfirmToEdit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Updating" class="btn btn-flat btn-warning bold">Update</button>





                    <!--                    <div class="form-group">
                                            <button type="submit"  id="btnConfirmToEdit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Updating" class="btn btn-flat btn-warning"><b><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Update</b></button>&nbsp;&nbsp;
                                            &nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-flat btn-default" data-dismiss="modal">&nbsp;&nbsp;&nbsp;<b><i class="fa fa-window-close"></i>&nbsp;Close&nbsp;&nbsp;&nbsp;</br></button>
                                        </div>-->
                </div>
            </form>
        </div>
    </div>
</div>

<!-------------------------------------------------------------------------Set Unit Modal--------------------------------------------------------------------------->
<div class="modal fade" id="modalSetUnitWard" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title" id="setUnitWardModalTitle"><i class="fa fa-wrench" aria-hidden="true"></i> Set Unit/Ward</b>/h4>
            </div>
            <div class="modal-body">
                <div class="table-responsive" style="margin-bottom:0px!important;">
                    <table class="table table-hover table-striped" style="margin-bottom:1px!important;">
                        <thead id="modalSetUnitWardTableHead">
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Type</th>
                                <th>Code</th>
                                <th>Mouza</th>
                                <th>Village</th>                                     
                                <th>Unit</th>
                                <th>Ward</th>
                            </tr>
                        </thead>
                        <tbody id="modalSetUnitWardTableBody">
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>



<!-------------------------------------------------------------------------Set Unit Modal--------------------------------------------------------------------------->
<div class="modal fade modal-catchment" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title">Set Unit/Ward - <span class="label label-info text-catchment bold"></span></</h4>
            </div>
            <div class="modal-body">
                <div class="table-responsive text-center mb0">
                    <table class="table table-hover table-striped table-counter mb0">
                        <thead>
                            <tr>
                                <th class="text-center">#</th>                                    
                                <th class="text-center">Unit</th>
                                <th class="text-center">Ward</th>
                                <th class="text-center" style="width:64px">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input class="input-oid" name="oid" type="hidden" ></td>                                    
                                <td><select class="input-unit" name="fwaunit"></select></td>
                                <td><select class="input-ward" name="ward"></select></td>
                                <td class="text-left"><button  type="button" class="btn btn-flat btn-xs btn-info btn-catchment-set"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                    <button  type="button" class="btn btn-flat btn-xs btn-danger btn-catchment-del"><i class="fa fa-remove" aria-hidden="true"></i></button>
                                </td>
                            </tr>
                        </tbody>

                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>