<%-- 
    Document   : ProviderManagementDGFP
    Created on : Jun 7, 2020, 7:34:05 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<link href="resources/css/newStyle.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/centerModal.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://www.jquery-az.com/boots/css/bootstrap-multiselect/bootstrap-multiselect.css" type="text/css">
<style>
    .label {
        border-radius: 11px!important;
    }
    .table-row, #tableContent{
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
    .condition-block{
        /*transition: all 1s;*/
    }
    .custom-hidden{
        display: none;
        /*        opacity: 0;
                transition: opacity 1s; */
    }
    .display-hidden-unit-group, .display-hidden-union-group{
        display: none;
    }
    .display-visible-unit-group, .display-visible-union-group{
        display: block;
        -webkit-animation: slide-down 1s ease-out;
        -moz-animation: slide-down 1s ease-out;
    }
    .custom-visible{
        display: block;
        -webkit-animation: slide-down 1s ease-out;
        -moz-animation: slide-down 1s ease-out;
    }
    #multi-select-village-container .dropdown-menu{
        height: 450px;
        overflow: scroll;
    }
    @-webkit-keyframes slide-down {
        0% { opacity: 0; -webkit-transform: translateY(-100%); }
        50% { opacity: .5; -webkit-transform: translateY(-50%); }
        100% { opacity: 1; -webkit-transform: translateY(0); }
    }
    @-moz-keyframes slide-down {
        0% { opacity: 0; -moz-transform: translateY(-100%); }   
        50% { opacity: .5; -moz-transform: translateY(-50%); }   
        100% { opacity: 1; -moz-transform: translateY(0); }
    }
    #geo_assign_type_container_unit select{
        height: 31px;
        font-size: 12px;
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
            divid: 30,
            zillaid: 99,
            upazilaid: 9,
            unionid: 19
        };



        var $providerType = $.app.select.$providerType('select#providerType', 93, '', 'All'),
                $division = $.app.select.$division('select#division'),
                $zilla = $('select#district'),
                $upazila = $('select#upazila'),
                $union = $('select#union'),
                $btn = $("button#showdataButton"),
                init = 0;

        $providerType.on('Select', function (e, data) {
            providerTypeJson = data;
        });
        $division.change(function (e) {
            $zilla.Select();
            $upazila.Select();
            $union.Select();
            $division.val() && $.app.select.$zilla($zilla, $division.val());
            //alert(2);
        }).on('Select', function (e, data) {
            //alert(1);
            !init && $(this).val(config.divid).change();
            districtJson = data;
        });

        $zilla.change(function (e) {
            $upazila.Select();
            $union.Select();
            $division.val() && $zilla.val() && $.app.select.$upazila($upazila, $zilla.val());
            $.app.select.$providerType('select#providerType', $zilla.val(), '', 'All');
            // alert(4);
        }).on('Select', function (e, data) {
            //alert(3);
            !init && $(this).val(config.zillaid).change();
            upazilaJson = data;
        });

        $upazila.change(function (e) {
            $union.Select();
            $division.val() && $zilla.val() && $upazila.val() && $.app.select.$union($union, $zilla.val(), $upazila.val());
            //alert(6);
        }).on('Select', function (e, data) {
            //alert(5);
            !init && $(this).val(config.upazilaid).change();
            unionJson = data;
        });

//        $union.change(function (e) {
//            $.app.select.$providerType('select#providerType', $zilla.val(), '', 'All');
//        }).on('Select', function (e, data) {
//            !init++ && $(this).val(config.unionid) && $btn.click();
//            providerTypeJson = data;
//        });

        $union.on('Select', function (e, data) {
            !init++ && $(this).val(config.unionid) && $btn.click();
        });

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

    function toggleUnionUnit() {
        var val = $(this).val();
        console.log(val);
        if (val == 3) {
            // SHOW ADD UNIT, VILLAGE UNIT
            $('#display-show-unit').removeClass('display-hidden-unit-group');
            $('#display-show-unit').addClass('display-visible-unit-group');

            $('#display-show-union').removeClass('display-visible-union-group');
            $('#display-show-union').addClass('display-hidden-union-group');
        } else if (val == 10) {
            $('#display-show-unit').addClass('display-hidden-unit-group');
            $('#display-show-unit').removeClass('display-visible-unit-group');

            $('#display-show-union').addClass('display-visible-union-group');
            $('#display-show-union').removeClass('display-hidden-union-group');
        } else {
            $('#display-show-unit').addClass('display-hidden-unit-group');
            $('#display-show-unit').removeClass('display-visible-unit-group');

            $('#display-show-union').addClass('display-hidden-union-group');
            $('#display-show-union').removeClass('display-visible-union-group');
        }
    }
    ;

    function redirectCatchment(modalType) {
        var division = $("select#division").val();
        var district = $("select#district").val();
        var upazila = $("select#upazila").val();
        var union = $("select#union").val();
        var hostname = window.location.href.split("/");
        var url = hostname[0] + "//" + hostname[2] + "/" + hostname[3] + "/catchment-area-management-dgfp" + "?divisionid=" + division
                + "&zillaid=" + district + "&upazilaid=" + upazila + "&unionid=" + union + "&targetModal=" + modalType;
        console.log(url);
        window.open(url, "_blank");
        $('.modal').modal('hide');
        return false;
    }

    function btnAddProviderClickHandler(provType) {
        console.log("btn---", provType);
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
        $("[name='provnamebang']").val("");
        $("[name='password']").val("123");
        $("[name='phone']").val("");
        $("[name='email']").val("");
        $("[name='joinDate']").val("");
        $("[name='superviserCode']").val("");


        var pType = $("[name='type']");
        pType.find('option').remove();
        var id = provType || $('#providerType').val();
        var name = "";
        if (provType) {
            name = $('#providerType option[value=' + provType + "]").text();
        } else {
            name = $("#providerType option:selected").text();
        }
        $('<option>').val(id).text(name).appendTo(pType);

        // GENERATE SUPERVISOR CODE
        var district = $("select#district").val();
        var upazila = $("select#upazila").val();
        var union = $("select#union").val();
        // pType take decision on pTYpe
        var provTypeSupervisor = (id == 3) ? 10 : (id == 10) ? 15 : 0;
        openAddProviderModal(district, upazila, union, provTypeSupervisor, id);
    }

    function openAddProviderModal(district, upazila, union, provTypeSupervisor, providerType) {
        var addSupervisorButton = $('#addSupervisorButton');
        var scType = $("#modalAddProvider [name='superviserCode']");
        scType.find("option").remove();
        
        var organizationDropdown = $("#modalAddProvider [name='organization_id']");
        organizationDropdown.off("change").on("change", function(event){
            var organizationId = $("#modalAddProvider [name='organization_id']").val();
            UTIL.request("provider-management-dgfp?action=getDesignationByOrganization"
                , {zillaid: district, organizationId: organizationId, providerType: providerType}).then(function(d1){
                    var designationList = d1;
                    UTIL.renderDropdown("#modalAddProvider [name='designation_id']", designationList, "Please Select");
                });
        });
        $.when(UTIL.request("provider-management-dgfp?action=getSupervisorList"
                , {zillaid: district, upazilaid: upazila, unionid: union, provtype: provTypeSupervisor}),
                UTIL.request("provider-management-dgfp?action=getNewProviderId"
                , {zillaid: district, provtype: providerType})
                        , UTIL.request("provider-management-dgfp?action=getOrganizations"
                , {zillaid: district, upazilaid: upazila, unionid: union})).then(function(d1, d2, d3){
                    // Supervisor list
                    var resp = d1;
                    $('<option>').val("").text("Please Select").appendTo(scType);
                    $.each(resp, function (index, item) {
                        $('<option>').val(item["providerid"]).text(item["provname"] + " - (" + item["parent_geo"] + ")").appendTo(scType);
                    });
                    if (providerType == "15" || providerType == "16") {
                        scType.prop('disabled', 'disabled');
                    } else {
                        scType.prop('disabled', false);
                    }
                    addSupervisorButton.removeClass("hide");
                    addSupervisorButton.attr('data-supervisor-provider-type', provTypeSupervisor);
                    if (providerType == "15" || providerType == "16") {
        //                    scType.removeClass('hide');
                        addSupervisorButton.addClass('hide');
                    }
                    // Provider id
                    var newProviderId = d2[0]["provider_id"];
                    if(newProviderId){
                        var inputId = $('#addNewProviderForm input[name="id"]');
                        inputId.prop('readonly', true);
                        inputId.val(newProviderId);
                    }
                    
                    // GENERATE ORGANIZATIONS
                    var organizationList = d3;
                    console.log(organizationList);
                    UTIL.renderDropdown("#modalAddProvider [name='organization_id']", organizationList, "Please Select");
                    $("#modalAddProvider").modal('show');
                }, function(err){
                    $.toast(err, "error")();
                });
//        UTIL.request("provider-management-dgfp?action=getSupervisorList"
//                , {zillaid: district, upazilaid: upazila, unionid: union, provtype: provTypeSupervisor}).then(function (d) {
//            var resp = d;
//            $('<option>').val("").text("Please Select").appendTo(scType);
//            $.each(resp, function (index, item) {
//                $('<option>').val(item["providerid"]).text(item["provname"] + " - (" + item["parent_geo"] + ")").appendTo(scType);
//            });
//            if (providerType == "15" || providerType == "16") {
//                scType.prop('disabled', 'disabled');
//            } else {
//                scType.prop('disabled', false);
//            }
//            addSupervisorButton.removeClass("hide");
//            addSupervisorButton.attr('data-supervisor-provider-type', provTypeSupervisor);
//            if (providerType == "15" || providerType == "16") {
////                    scType.removeClass('hide');
//                addSupervisorButton.addClass('hide');
//            }
//            UTIL.request("provider-management-dgfp?action=getNewProviderId"
//                , {zillaid: district, provtype: providerType}).then(function(d){
//                    var newProviderId = d[0]["provider_id"];
//                    if(newProviderId){
//                        var inputId = $('#addNewProviderForm input[name="id"]');
//                        inputId.prop('readonly', true);
//                        inputId.val(newProviderId);
//                    }
//                    $("#modalAddProvider").modal('show');
//                });
//            
//        });
    }

    function reopenAddProviderModel() {
        var addSupervisorButton = $('#addSupervisorButton');
        var provType = addSupervisorButton.attr('data-supervisor-provider-type');
        console.log('provType===', provType);
        $('#modalAddProvider').modal('hide');
        setTimeout(function () {
            btnAddProviderClickHandler(provType);
        }, 900);

//        alert(addSupervisorButton.data('supervisor-provider-type'));
    }

    function upazilaAndUnionSelected() {
        return $.isValidAll();
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
            provnamebang: '* Bengali name',
            mobile: '* Mobile no.',
//            email: '* Email',
            supervisor: '* Supervisor code',
            active: '* Active'
        };

        $.each(editObj, function (k, v) {
//            if (k == 'supervisor')
//                return;
            if (!v && mapObj.hasOwnProperty(k)) {
                var text = mapObj[k];
                text = (text[0]) == "*" ? text + " required" : "Select a specific " + text;
                $.toast(text, "error")();
                return isAllValid = false;
            }
        });

        return isAllValid;
    }


    function setActivity(checkbox) {
        if (checkbox.checked) {
            isActive = "1";
        } else {
            isActive = "0";
        }
    }

    function disableUser(checkboxRef, providerId) {
        var $checkboxRef = $(checkboxRef);
        var userActive = $checkboxRef.data('user-active');
        console.log(providerId);
        UTIL.requestEmis("provider-management-dgfp?action=disableUser", {districtId: $("#district").val(), providerId: providerId, userActive: userActive}, "POST").then(function (r) {
            console.log(r);
            $("#showdataButton").click();
        });
    }

//=Change device setting======================================================================
    function buttonSettings(providerId, columnType, setting) {
        console.log("HHHH", setting, columnType);
        var klass = setting == 1 ? 'btn-info' : 'btn-default';
        var checked = setting == 1 ? 'checked' : '';
        return '<div class="material-switch pull-left">'
                + '<input ' + checked + ' id="providerDeviceSettingActivate_' + providerId + '"' + ' onchange="changeSettings(this,' + providerId + ',' + columnType + ')" data-setting="' + setting + '" name="editProviderActive" type="checkbox">'
                + '<label for="providerDeviceSettingActivate_' + providerId + '"' + 'class="label-info"></label></div>';
//         return  '<button  onclick="changeSettings(this,' + providerId + ',' + columnType + ')" data-setting="' + setting + '" class="btn btn-flat ' + klass + ' btn-xs bold"><i class="fa fa-check fa-lg" aria-hidden="true"></i></button>';
    }

    function changeSettings(btnRef, providerId, columnType) {
        var btn = $(btnRef);
        var setting = btn.data("setting");
        console.log(btnRef, providerId, columnType, setting);

        Pace.track(function () {
            $.ajax({
                url: "provider-management-dgfp?action=updateSettings",
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
                url: "provider-management-dgfp?action=addAreaToProvider",
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
                url: "provider-management-dgfp?action=removeAreaFromProvider",
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
                    if (result >= 1) { //change only if one row is affected
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
        console.log(selectedProvider);
        return false;
        $('#modalTableBody').empty();
        Pace.track(function () {
            $.ajax({
                url: "provider-management-dgfp?action=getMouzaData",
                data: {
                    districtId: selectedProvider.districtid,
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
                url: "provider-management-dgfp?action=updateUnit",
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
                url: "provider-management-dgfp?action=updateUnit",
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
                url: "provider-management-dgfp?action=updateWard",
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
                url: "provider-management-dgfp?action=updateWard",
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
                url: "provider-management-dgfp?action=updateRound",
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
        $.post('provider-management-dgfp?action=getUnits', function (response) {
            var units = JSON.parse(response);
            for (var i = 0; i < units.length; i++) {
                unitOptions += '<option value=\"' + units[i].ucode + '\">' + units[i].uname + '</option>';
            }
        });

        window.loadModalData(provider.providerid, provider.provtype, unionId);
        /*$('#modalTableBody').empty();
         
         $.ajax({
         url: "provider-management-dgfp?action=getMouzaData",
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

        $('select#providerType').on('change', toggleUnionUnit);

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
            $modal.find('#assignModalTitle').attr("data-openproviderid", provider.providerid);
            window.loadModalData(provider.providerid, provider.provtype, provider.unionid);
        }
        //Assign reporting union
        window.assignReportingUnion = function (index) {
            var provider = window.providerListJson[index];
            var zillaid = provider["zillaid"];
            var upazilaid = provider["upazilaid"];
        }
        // Assign reporting unit
        window.assignReportingUnit = function (index) {
            var provider = window.providerListJson[index];
            var zillaid = provider["zillaid"];
            var upazilaid = provider["upazilaid"];
        }

        window.updateProvider = function (target) {
            //aaaaaaaaaa
            var row = $(target).data('provider');
            console.log('Update: ', row);
            $('#nameAsEditProvTitle').text(" : " + row.provname); //title
            $('#editProviderIdHidden').val(row.providerid);
            $('#editProviderName').val(row.provname);
            $('#editProvnamebang').val(row.provnamebang == "null" ? '' : row.provnamebang);
            $('#editEmail').val(row.email == "null" ? '' : row.email);
            $('#editProviderPassword').val(row.provpass);
            $('#editProviderId').val(row.providerid);
            $('#editProviderMobile').val(('0' + row.mobileno).substr(-11));
            $('#editProviderSupervisor').val(row.supervisorcode);
            $("#editProviderActive").prop("checked", !!row.active);

            //Load Selected 
            $.app.select.$providerType($('select#editProviderType'), row.provtype);
            var selected = "";
            var $select = "";
            $.get("DistrictJsonDataProvider?division=" + (row.divid || 0), function (data) {
                $select = clearSelect('editDistrict', '--Select division--');
//                $select = $('select#editDistrict');
//                $select.find('option').remove();
//                $select.append('<option value="">--Select division--</option>');
                $.each(JSON.parse(data), function (key, value) {
                    value.zillaid == row.zillaid ? $select.append('<option value=' + value.zillaid + ' selected>' + value.zillanameeng + ' [' + value.zillaid + ']</option>') : "";
                    //value.zillaid == row.zillaid ? selected = "selected" : selected = "";
                    //$select.append('<option value=' + value.zillaid + ' ' + selected + '>' + value.zillanameeng + ' [' + value.zillaid + ']</option>');
                });
                //upazila load here
                $.get("UpazilaJsonProvider?districtId=" + (row.zillaid || 0), function (data) {
                    $select = clearSelect('editUpazila', '--Select upazila--');
                    $.each(JSON.parse(data), function (key, value) {
                        value.upazilaid == row.upazilaid ? selected = "selected" : selected = "";
                        $select.append('<option value=' + value.upazilaid + ' ' + selected + '>' + value.upazilanameeng + ' [' + value.upazilaid + ']</option>');
                    });
                    //union load here
                    $.get("UnionJsonProvider", {zilaId: (row.zillaid || 0), upazilaId: (row.upazilaid || 0)})
                            .done(function (data) {
                                $select = clearSelect('editUnion', '--Select union--');
                                $.each(JSON.parse(data), function (key, value) {
                                    value.unionid == row.unionid ? selected = "selected" : selected = "";
                                    $select.append('<option value=' + value.unionid + ' ' + selected + '>' + value.unionnameeng + ' [' + value.unionid + ']</option>');
                                });

                                $('#updateProviderModal').modal('show');
                                $('#editProviderType').val(row.provtype).change();
                            });
                });
            }).done(function (data) {
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
            var options = {url: 'provider-management-dgfp?action=' + action + 'Providerarea', data: data, type: 'POST'};
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
            console.log(modal);
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

    //SET FPI REPORTING UNION
//                var provider = window.providerListJson[index];
//            var zillaid = provider["zillaid"];
//            var upazilaid = provider["upazilaid"];
//            console.log(provider, UTIL);
//            UTIL.request("UnionJsonProviderTest", {upazilaId: upazilaid, zilaId: zillaid}, "GET").then(function (resp) {
//                UTIL.generateReportingUnion(resp, "", "#reporting_union_id_for_unit");
//                $("#geo_assign_type_container").html(UTIL.getAssignTypeDropdown({}));
//                reportingUnionTable({});
////                console.log(resp);
////                window.selectedProvider = provider;
//                var $modal = $("#assignReportingUnionModal").modal('show');
//            });

//        function reportingUnionTable(data) {
//            var columns = [
//                {data: "zillanameeng", title: 'District'},
//                {data: "upazilanameeng", title: 'Upazila'},
//                {data: "unionnameeng", title: 'Union name (ENG)'},
//                {data: "unionname", title: 'Union name (BAN)'}
//            ];
//            var opt = {
//                dom: 'Bfrtip',
//                paging: false,
//                "ordering": false,
//                searching: false,
//                info: false,
//                processing: true,
//                data: data,
//                columns: columns
//            };
//            var t = new UTIL.renderingTable("#data-table-assign-reporting-union",  opt);
//            t.createDataTable();
//        };

    var ReportingCatchmentUpazila = {
        provider: null,
        modalFor: null,
        modal: null,
        $modal: null,
        form: null,
        submitBtn: null,
        submitUrl: null,
        tableId: null,
        tableDataUrl: null,
        inputTags: null,
        relatedTarget: null,
        generateTable: function () {
            var self = this;
            var columns = [
                {data: "reporting_upazilanameeng", title: 'Upazila Name'},
                {data: function (d) {
//                        return $.app.getAssignType(d["assign_type"], 1);
                        return UTIL.getAssignTypeDropdownTable(d, 'dtUfpoAssignTypeSelect')
//                                + '<a style="margin-top: 5px;" class="btn btn-info btn-xs btn-catchment-set-responsibility">Update</a>'
                                ;
                        //+ '<button type="button" class="btn btn-info btn-xs btn-catchment-set-responsibility" value="">';
                        //<i class="fa fa-check" aria-hidden="true">Update</i></button>';
                    }, title: 'Assign type'},
                {data: function (d) {
                        return '<a class="btn-reporting-upazila-unassign btn btn-flat btn-danger btn-xs bold"><i class="fa fa-pencil" aria-hidden="true"></i> Unassign</a>';
                    }, title: 'Action'}
            ];
            var data = {
                "providerid": self.provider["providerid"],
                "zillaid": self.provider["zillaid"]
            };

            var payload = JSON.stringify(data);

            UTIL.request(self.tableDataUrl, {data: payload}, "POST").then(function (d) {
                var opt = {
                    dom: 'Bfrtip',
                    paging: false,
                    "ordering": false,
                    searching: false,
                    info: false,
                    processing: true,
                    data: d["reporting_upazila_assigned"],
                    columns: columns
                };
                var t = new UTIL.renderingTable(self.tableId, opt);
                t.createDataTable();
            });
        },
        //May need to pass customize setup function.
        setup: function () {
//            
            var self = this, provider = this.provider;
            console.log("REPORTING CATCHMENT UPAZILA - SETUP", self);
            //, unionid: provider["unionid"]
            var payload = JSON.stringify({zillaid: provider["zillaid"], upazilaid: provider["upazilaid"]});

            this.$headerAssignProviderName.css({
                color: '#f58812'
            });
            this.$headerAssignProviderName.html(" " + this.provider["provname"]);

            //May need to change and need to query with unionids[]
            $.when(UTIL.request("report-geo-info?action=getReportingUpazila", {data: payload}, "POST"))
                    .done(function (r1)
                    {
                        console.log(r1);
                        //GENERATE UPAZILA DROPDOWN
                        var reporting_upazila = r1["upazila"];
                        UTIL.generateReportingUpazila(reporting_upazila, "", "#reporting_upazilaid");
//                        if (reporting_upazila.length == 1) {
//                            $('#reporting_upazilaid').val(reporting_upazila).change();
//                        }
                        $("#geo_assign_type_container_upazila").html(UTIL.getAssignTypeDropdownUFPO({}, ""));
                        self.generateTable();
                    });
        },
        getFormData: function () {
            var self = this;
            var payload = {
                zillaid: self.provider["zillaid"],
                upazilaid: self.provider["upazilaid"],
                providerid: self.provider["providerid"]
            };
            return payload;
        },
        submitReportingUpazila: function (e) {
            var self = e.data.self;
            var data = UTIL.serializeAllArray(self.form);//form.serializeArray();
            var formInput = $(self.inputTags);
            var v = UTIL.validateReportingGeo.validateFWAForm(data, formInput);
            if (v) {
                var payload = self.getFormData();
                var modifiedPayload = $.extend({}, payload, $.app.pairs(self.form));

//                modifiedPayload["unitid"] = modifiedPayload["reporting_unit"];
//                delete modifiedPayload["reporting_unit"];
//                modifiedPayload["wardnumber"] = UTIL.getWardByUnit(ward);
//                modifiedPayload["division"] = self.provider["divid"];

                console.log("submitReportingUpazila:", modifiedPayload, self.provider);
                modifiedPayload["assign_type"] = modifiedPayload["assign_type_reporting_upazila"];
                delete modifiedPayload["assign_type_reporting_upazila"];
                modifiedPayload = JSON.stringify(modifiedPayload);
                UTIL.request(self.submitUrl, {data: modifiedPayload}, "POST").then(function (d) {
                    alert(d["message"]);
                    self.setup();
                });
            } else {
                alert("Fill Up All Field");
            }
        },
        init: function (props) {
            console.log(props);
            var self = this;
            this.modal = props.modal;
            this.modalFor = props.modalFor;
            this.$modal = $(this.modal);
            this.submitBtn = props.submitBtn;
            this.form = props.form;
            this.inputTags = self.form + " " + ":input[name]";
            this.relatedTarget = props.relatedTarget;
            this.submitUrl = props.submitUrl;
            this.tableId = props.tableId;
            this.tableDataUrl = props.tableDataUrl;
            this.$headerAssignProviderName = $('#assignProviderUFPOName');
            this.updateButtonAssingReportingUnit = props.updateButtonAssingReportingUnit;

            self.$modal.on('show.bs.modal', function (e) {
                var relatedBtn = e.relatedTarget;
                var d = relatedBtn.data('provider');
                self.setup();
//                console.log(e, relatedBtn.data('provider'));
            });

//            $('body').on('change', '#reporting_union_id_for_unit', function (e) {
//                var v = $(this).val();
//                var zillaId = $('select#district').val();
//                var payload = JSON.stringify({reporting_unionid: v, 'zillaid': zillaId});
//                UTIL.request("report-geo-info?action=getUnitByReportingUnion", {data: payload}, "POST").then(function (resp) {
//                    UTIL.generateUnit(resp["reporting_unit"], "", "#reporting_unit");
//                });
//            });

            $('body').on('click', self.relatedTarget, function (e) {
                console.log(self);
                var d = $(this).data('provider');
                self.provider = d;
                self.$modal.modal('show', $(this));
            });

            $(self.modal + " " + self.submitBtn).on('click', {
                self: self
            }, self.submitReportingUpazila);

            $(self.modal + " " + self.updateButtonAssingReportingUnit).on('click', {
                self: self
            }, function (e) {
                var assignedTableList = new UTIL.renderingTable(self.tableId);
                var allRow = assignedTableList.getDataTable().rows().data().toArray();
                var validationArray = [];
                var validateAssign = false;
                $.each(allRow, function (index, item) {
                    if (item["assign_type"] == 1) {
                        validationArray.push(item["assign_type"]);
                    }

                    if (item["assign_type"] == 0) {
                        validationArray.push(item["assign_type"]);
                    }
                })
                validateAssign = validationArray.length > 1 ? validateAssign : true;
                console.log(validateAssign, validationArray, allRow);
                allRow = allRow.map(function (item) {
                    delete item.reporting_upazilanameeng;
                    delete item.reporting_upazilaname;
                    return item;
                });
                var payload = JSON.stringify(allRow);
                if (validateAssign) {
                    UTIL.request('report-geo-info?action=updateUFPOAssignType', {data: payload}, "POST").then(function (r1) {
                        toastr[r1.success]("<b>" + r1.message + "</b>");
                        ReportingCatchmentUpazila.generateTable();
                    });
                } else {
                    toastr['error']("<b>Main upazila will be once</b>");
                    ReportingCatchmentUpazila.generateTable();
                }
            });

            //ASSIGN TYPE UPDATE BUTTON
//            ASSIGN TYPE SELECT EVENT
            $(self.modal).on('change', '.dtUfpoAssignTypeSelect', function (e) {
                var val = $(this).val();
                var tr = $(this).closest('tr');
                var assignedTableList = new UTIL.renderingTable(self.tableId);
                var currentRow = assignedTableList.getDataTable().row(tr).data();
                console.log('currentRow', currentRow);
                currentRow["assign_type"] = val;
                assignedTableList.getDataTable().row(tr).data(currentRow);
                console.log(assignedTableList.getDataTable().row(tr).data());
            });
            //BUTTON UNASSIGNED
            $(self.modal).on('click', '.btn-reporting-upazila-unassign', function (e) {
                var tr = $(this).closest('tr');
                var assignedTableList = new UTIL.renderingTable(self.tableId);
                var allRows = assignedTableList.getDataTable().rows().data().toArray();
                var currentRow = assignedTableList.getDataTable().row(tr).data();
                console.log(currentRow);
                var rcu = new ReportingCatchmentUnassign({modal: '#unassignCatchmentModal', table: self.tableId
                    , provider: self.provider, allRows: allRows, currentRow: currentRow});
                rcu.init();
            });
        }
    };

    var ReportingCatchmentUnion = {
        provider: null,
        modalFor: null,
        modal: null,
        $modal: null,
        form: null,
        submitBtn: null,
        submitUrl: null,
        tableId: null,
        tableDataUrl: null,
        inputTags: null,
        relatedTarget: null,
        generateTable: function () {
            var self = this;
            var columns = [
                {data: "unionnameeng", title: 'Union Name'},
                {data: function (d) {
                        return  UTIL.getAssignTypeDropdownTable(d, 'dtFpiAssignTypeSelect');
//                        return $.app.getAssignType(d["assign_type"], 2);
                    }, title: 'Assign type'},
                {data: function (d) {
                        return '<a class="btn-reporting-union-unassign btn btn-flat btn-danger btn-sm bold"><i class="fa fa-pencil" aria-hidden="true"></i>&nbsp; Unassign</a>';
                    }, title: 'Action'}
            ];
            var data = {
                providerid: self.provider["providerid"],
                zillaid: self.provider["zillaid"]
            };
            var payload = JSON.stringify(data);
            UTIL.request(self.tableDataUrl, {"data": payload}, "POST").then(function (d) {
                console.log(d);
                var opt = {
                    dom: 'Bfrtip',
                    paging: false,
                    "ordering": false,
                    searching: false,
                    info: false,
                    processing: true,
                    data: d["fpi"],
                    columns: columns
                };
                var t = new UTIL.renderingTable(self.tableId, opt);
                t.createDataTable();
            });
        },
        //May need to pass customize setup function.
        setup: function () {
            var self = this, provider = this.provider;
            this.$headerAssignProviderName.css({
                color: '#f58812'
            });
            this.$headerAssignProviderName.html(" " + this.provider["provname"]);

            //May need to change and need to query with unionids[]
            // 
            var payload = JSON.stringify({zillaid: provider["zillaid"], upazilaid: provider["upazilaid"], unionid: provider["unionid"]});
            //getUnassignedReportingUnionByUpazila
            $.when(UTIL.request("report-geo-info?action=getUnassignedReportingUnionByUpazila", {data: payload}, "POST"))
                    .done(function (r1)
                    {
                        UTIL.generateReportingUnion(r1["reporting_union"], "", "#reporting_union_id_for_union");
                        $("#geo_assign_type_container").html(UTIL.getAssignTypeDropdown({}));
                        self.generateTable();
                    });
        },
        getFormData: function () {
            var self = this;
            var payload = {
                zillaid: self.provider["zillaid"],
                upazilaid: self.provider["upazilaid"],
                providerid: self.provider["providerid"]
            };
            return payload;
        },
        submitReportingUnion: function (e) {
            var self = e.data.self;
            var data = UTIL.serializeAllArray(self.form);//form.serializeArray();
            var formInput = $(self.inputTags);
            var v = UTIL.validateReportingGeo.validateFWAForm(data, formInput);
            if (v) {
                var payload = self.getFormData();
                var modifiedPayload = $.extend({}, payload, $.app.pairs(self.form));
                console.log(modifiedPayload);
                var modifiedPayload = JSON.stringify(modifiedPayload);
                UTIL.request(self.submitUrl, {data: modifiedPayload}, "POST").then(function (d) {
                    self.generateTable();
                    self.setup();
                    alert(d["message"]);
                });
            } else {
                alert("Fill Up All Field");
            }
        },
        init: function (props) {
            var self = this;
//            this.modal = '#assignReportingUnionModal';
//            this.modalFor = "ReportingUnion";
//            this.$modal = $(this.modal);
//            this.submitBtn = '#submitButtonAssingReportingUnion';
//            this.form = "#reportingunionfpi";
//            this.inputTags = self.form + " " + ":input[name]";
//            this.relatedTarget = ".btn-assign-reporting-union";
//            this.submitUrl = "report-geo-info?action=setReportingUnionFPI";
//            this.tableId = "#data-table-assign-reporting-union";
//            this.tableDataUrl = "report-geo-info?action=getReportingUnionFPI";
            console.log(props);
            this.modal = props.modal;
            this.modalFor = props.modalFor;
            this.$modal = $(this.modal);
            this.submitBtn = props.submitBtn;
            this.form = props.form;
            this.inputTags = self.form + " " + ":input[name]";
            this.relatedTarget = props.relatedTarget;
            this.submitUrl = props.submitUrl;
            this.tableId = props.tableId;
            this.tableDataUrl = props.tableDataUrl;
            this.$headerAssignProviderName = $('#assignProviderFPIName');
            this.updateButtonAssingReportingUnion = props.updateButtonAssingReportingUnion;

            self.$modal.on('show.bs.modal', function (e) {
                var relatedBtn = e.relatedTarget;
                var d = relatedBtn.data('provider');
                self.setup();
//                console.log(e, relatedBtn.data('provider'));
            });

            $('body').on('click', self.relatedTarget, function (e) {
                console.log(this);
                var d = $(this).data('provider');
                self.provider = d;
                self.$modal.modal('show', $(this));
            });
            $(self.modal + " " + self.submitBtn).on('click', {
                self: self
            }, self.submitReportingUnion);
            // UPDATE FPI TABLE ROWS
            $(self.modal + " " + self.updateButtonAssingReportingUnion).on('click', {
                self: self
            }, function (e) {
                var assignedTableList = new UTIL.renderingTable(self.tableId);
                var allRow = assignedTableList.getDataTable().rows().data().toArray();
                var validationArray = [];
                var validateAssign = false;
                $.each(allRow, function (index, item) {
                    if (item["assign_type"] == 1) {
                        validationArray.push(item["assign_type"]);
                    }
                    if (item["assign_type"] == 0) {
                        validationArray.push(item["assign_type"]);
                    }
                })
                validateAssign = validationArray.length > 1 ? validateAssign : true;
                console.log("UPDATE FPI ASSIGN", validateAssign, validationArray, allRow);
                allRow = allRow.map(function (item) {
                    delete item.unionnameeng;
                    return item;
                });
                var payload = JSON.stringify(allRow);

                if (validateAssign) {
                    UTIL.request('report-geo-info?action=updateFPIAssignType', {data: payload}, "POST").then(function (r1) {
                        toastr[r1.success]("<b>" + r1.message + "</b>");
                        ReportingCatchmentUnion.generateTable();
                    });
                } else {
                    toastr['error']("<b>Main union will be once</b>");
                    ReportingCatchmentUnion.generateTable();
                }
            });

//            ASSIGN TYPE SELECT EVENT
            $(self.modal).on('change', '.dtFpiAssignTypeSelect', function (e) {
                var val = $(this).val();
                var tr = $(this).closest('tr');
                var assignedTableList = new UTIL.renderingTable(self.tableId);
                var currentRow = assignedTableList.getDataTable().row(tr).data();
                currentRow["assign_type"] = val;
                assignedTableList.getDataTable().row(tr).data(currentRow);
            });
            //BUTTON UNASSIGNED
            $(self.modal).on('click', '.btn-reporting-union-unassign', function (e) {
                var tr = $(this).closest('tr');
                var assignedTableList = new UTIL.renderingTable(self.tableId);
                var allRows = assignedTableList.getDataTable().rows().data().toArray();
                var currentRow = assignedTableList.getDataTable().row(tr).data();
                console.log(allRows, currentRow);
                var rct = new ReportingCatchmentUnassign({modal: '#unassignCatchmentModal', table: self.tableId
                    , provider: self.provider, allRows: allRows, currentRow: currentRow});
                rct.init();
            });
        }
    };

    var ReportingCatchmentUnit = {
        provider: null,
        modalFor: null,
        modal: null,
        $modal: null,
        form: null,
        submitBtn: null,
        submitUrl: null,
        tableId: null,
        tableDataUrl: null,
        inputTags: null,
        relatedTarget: null,
        generateTable: function () {
            var self = this;
            var columns = [
                {data: "unionnameeng", title: 'Union Name'},
                {data: "unit_label", title: 'Unit'},
                {data: "village_name", title: 'Village Names'},
                {data: function (d) {
//                        return $.app.getAssignType(d["assign_type"], 1);
                        return UTIL.getAssignTypeDropdownTable(d, 'dtFwaAssignTypeSelect')
//                                + '<a style="margin-top: 5px;" class="btn btn-info btn-xs btn-catchment-set-responsibility">Update</a>'
                                ;
                        //+ '<button type="button" class="btn btn-info btn-xs btn-catchment-set-responsibility" value="">';
                        //<i class="fa fa-check" aria-hidden="true">Update</i></button>';
                    }, title: 'Assign type'},
                {data: function (d) {
                        return '<a class="btn-reporting-unit-unassign btn btn-flat btn-danger btn-xs bold"><i class="fa fa-pencil" aria-hidden="true"></i> Unassign</a>';
                    }, title: 'Action'}
            ];
            var data = {
                "providerid": self.provider["providerid"],
                "zillaid": self.provider["zillaid"]
            };

            var payload = JSON.stringify(data);

            UTIL.requestEmis(self.tableDataUrl, data, "POST").then(function (d) {
                console.log('UNIT DETAILS', d);
                var opt = {
                    dom: 'Bfrtip',
                    paging: false,
                    "ordering": false,
                    searching: false,
                    info: false,
                    processing: true,
                    data: d,
                    columns: columns
                };
                var t = new UTIL.renderingTable(self.tableId, opt);
                t.createDataTable();
            });
        },
        //May need to pass customize setup function.
        setup: function () {
            var self = this, provider = this.provider;
            console.log(self);
            self.generateTable();
            var payload = JSON.stringify({zillaid: provider["zillaid"], upazilaid: provider["upazilaid"], unionid: provider["unionid"]});
            this.$headerAssignProviderName.css({
                color: '#f58812'
            });
            this.$headerAssignProviderName.html(": " + this.provider["provname"]);

            //May need to change and need to query with unionids[]
            $.when(UTIL.request("report-geo-info?action=getReportingUnionByBbsUpazila", {data: payload}, "POST"))
                    .done(function (r1)
                    {
                        var reporting_unionids = r1["reporting_union"];
                        UTIL.generateReportingUnion(reporting_unionids, "", "#reporting_union_id_for_unit");
                        if (reporting_unionids.length == 1) {
                            //$('#reporting_union_id_for_unit').val(reporting_unionids[0]['unionid']).change();
                        }
                        $("#geo_assign_type_container_unit").html(UTIL.getAssignTypeDropdown({}));
                        self.generateTable();
                    });
        },
        getFormData: function () {
            var self = this;
            var payload = {
                zillaid: self.provider["zillaid"],
                upazilaid: self.provider["upazilaid"],
                providerid: self.provider["providerid"]
            };
            return payload;
        },
        submitReportingUnit: function (e) {
            var self = e.data.self;
            var data = UTIL.serializeAllArray(self.form);//form.serializeArray();
            var formInput = $(self.inputTags);
            var v = UTIL.validateReportingGeo.validateFWAForm(data, formInput);
            if (v) {
                var payload = self.getFormData();
                var modifiedPayload = $.extend({}, payload, $.app.pairs(self.form));
                var ward = $('#assignReportingUnitModal select#reporting_unit').children("option:selected").text().split(" ")[0];
                console.log(ward);
                modifiedPayload["unitid"] = modifiedPayload["reporting_unit"];
                delete modifiedPayload["reporting_unit"];
                modifiedPayload["wardnumber"] = UTIL.getWardByUnit(ward);
                modifiedPayload["division"] = self.provider["divid"];

                console.log(modifiedPayload, self.provider);
                var modifiedPayload = JSON.stringify(modifiedPayload);
                UTIL.request(self.submitUrl, {data: modifiedPayload}, "POST").then(function (d) {
                    self.generateTable();
                    $('#reporting_union_id_for_unit').change();
                    alert(d["message"]);
                });
            } else {
                alert("Fill Up All Field");
            }
        },
        init: function (props) {
            console.log(props);
            var self = this;
//            this.modal = '#assignReportingUnionModal';
//            this.modalFor = "ReportingUnion";
//            this.$modal = $(this.modal);
//            this.submitBtn = '#submitButtonAssingReportingUnion';
//            this.form = "#reportingunionfpi";
//            this.inputTags = self.form + " " + ":input[name]";
//            this.relatedTarget = ".btn-assign-reporting-union";
//            this.submitUrl = "report-geo-info?action=setReportingUnionFPI";
//            this.tableId = "#data-table-assign-reporting-union";
//            this.tableDataUrl = "report-geo-info?action=getReportingUnionFPI";
            console.log(props);
            this.modal = props.modal;
            this.modalFor = props.modalFor;
            this.$modal = $(this.modal);
            this.submitBtn = props.submitBtn;
            this.form = props.form;
            this.inputTags = self.form + " " + ":input[name]";
            this.relatedTarget = props.relatedTarget;
            this.submitUrl = props.submitUrl;
            this.tableId = props.tableId;
            this.tableDataUrl = props.tableDataUrl;
            this.$headerAssignProviderName = $('#assignProviderName');
            this.updateButtonAssingReportingUnit = props.updateButtonAssingReportingUnit;

            self.$modal.on('show.bs.modal', function (e) {
                var relatedBtn = e.relatedTarget;
                var d = relatedBtn.data('provider');
                self.setup();
//                console.log(e, relatedBtn.data('provider'));
            });

            $('body').on('change', '#reporting_union_id_for_unit', function (e) {
                var v = $(this).val();
                var zillaId = $('select#district').val();
                var upazilaId = $('select#upazila').val();
                var payload = JSON.stringify({reporting_unionid: v, 'zillaid': zillaId, 'upazilaid': upazilaId});
                UTIL.request("report-geo-info?action=getUnitByReportingUnion", {data: payload}, "POST").then(function (resp) {
                    UTIL.generateUnit(resp["reporting_unit"], "", "#reporting_unit");
                });
            });

            $('body').on('click', self.relatedTarget, function (e) {
                console.log(this);
                var d = $(this).data('provider');
                self.provider = d;
                self.$modal.modal('show', $(this));
            });
            $(self.modal + " " + self.submitBtn).on('click', {
                self: self
            }, self.submitReportingUnit);
            $(self.modal + " " + self.updateButtonAssingReportingUnit).on('click', {
                self: self
            }, function (e) {
                var assignedTableList = new UTIL.renderingTable(self.tableId);
                var allRow = assignedTableList.getDataTable().rows().data().toArray();
                var validationArray = [];
                var validateAssign = false;
                $.each(allRow, function (index, item) {
                    if (item["assign_type"] == 1) {
                        validationArray.push(item["assign_type"]);
                    }

                    if (item["assign_type"] == 0) {
                        validationArray.push(item["assign_type"]);
                    }
                })
                validateAssign = validationArray.length > 1 ? validateAssign : true;
                console.log(validateAssign, validationArray, allRow);
                allRow = allRow.map(function (item) {
                    delete item.unionnameeng;
                    delete item.unit_label;
                    delete item.village_name;
                    return item;
                });
                var payload = JSON.stringify(allRow);
                if (validateAssign) {
                    UTIL.request('report-geo-info?action=updateFWAAssignType', {data: payload}, "POST").then(function (r1) {
                        toastr[r1.success]("<b>" + r1.message + "</b>");
                        ReportingCatchmentUnit.generateTable();
                    });
                } else {
                    toastr['error']("<b>Main unit will be once</b>");
                    ReportingCatchmentUnit.generateTable();
                }
            });

            //ASSIGN TYPE UPDATE BUTTON
//            ASSIGN TYPE SELECT EVENT
            $(self.modal).on('change', '.dtFwaAssignTypeSelect', function (e) {
                var val = $(this).val();
                var tr = $(this).closest('tr');
                var assignedTableList = new UTIL.renderingTable(self.tableId);
                var currentRow = assignedTableList.getDataTable().row(tr).data();
                console.log('currentRow', currentRow);
                currentRow["assign_type"] = val;
                assignedTableList.getDataTable().row(tr).data(currentRow);
                console.log(assignedTableList.getDataTable().row(tr).data());
            });
            //BUTTON UNASSIGNED
            $(self.modal).on('click', '.btn-reporting-unit-unassign', function (e) {
                var tr = $(this).closest('tr');
                var assignedTableList = new UTIL.renderingTable(self.tableId);
                var allRows = assignedTableList.getDataTable().rows().data().toArray();
                var currentRow = assignedTableList.getDataTable().row(tr).data();
                var rcu = new ReportingCatchmentUnassign({modal: '#unassignCatchmentModal', table: self.tableId
                    , provider: self.provider, allRows: allRows, currentRow: currentRow});
                rcu.init();
            });
        }
    };

    var ReportingCatchmentUnassign = function (props) {
        var self = this;
        this.$modal = $(props.modal);
        this.tableHeader = '#unassignProviderName';
        this.$header = $('#unassignProviderName');
        this.form = '#unassigncatchmentform';
        this.$form = $('#unassigncatchmentform');
        this.inputTags = '#unassigncatchmentform' + " " + ":input[name]";

        this.init = function () {
            this.setup();
            var parameterInfo = props;
            console.log("ReportingCatchmentUnassign", props);
            $('body #submitButtonUnassignCatchment').off('click').on('click', {parameterInfo: parameterInfo}, function (e) {
//                console.log(e.data['parameterInfo']);
                self.submitUnassign(e);
            });
        };

        this.setup = function () {
            this.$header.css({
                color: '#f58812'
            });
            this.$modal.modal('show');
            console.log("props.provider", props.provider);
            this.$header.html(": " + props.provider["provname"] + " (" + props.provider["providerid"] + ")");
            this.generateReasonType();
            $("#unassign_date").datepicker({
                endDate: '+0d',
            });
            $("#unassign_leave_end_date").datepicker({
                endDate: '+0d',
            });

            UTIL.generateAllDistrict().done(function (select) {
                $('#all_district_container').html(select);

                $('body #district_all').off('change').on('change', function (event) {
//                    console.log(this);
                    var transferDistrictId = $(this).val();
                    var optUpazila = UTIL.generateUpazila(transferDistrictId);
                    console.log(optUpazila);
                    optUpazila.done(function (r) {
                        $('#transfer_upazila').html(r);
                        $("body #transfer_upazila").off("change").on("change", function (ev) {
                            var transferUpazilaId = $(this).val();
                            UTIL.generateUnion(transferDistrictId, transferUpazilaId).done(function (r) {
                                $("#transfer_union").html(r);
                            });
                        });
//                        UTIL.generateUnion(did, $(this).val()).done(function(r){
//                            console.log(r);
//                        });
                    });
                });
            });

            $('body #unassign_reason_type').off('change').on('change', {conditionalRendering: this.conditionalRendering}
            , function (event) {
                event.stopImmediatePropagation();
                var optionValue = $(this).val();
//                console.log($(this).find("option[value='" + optionValue + "']").text());
                var optionsText = $(this).find("option[value='" + optionValue + "']").text();
                console.log(optionsText);
                self.onChangeReasonType(optionValue, optionsText);
            });
            console.log("HHH");


            $('#unassigncatchmentform input[type=text], input[type=number]').val("");
        };
        this.conditionalRendering = function (v, text) {
            var conditionBlock = $('.condition-block');
            console.log(text);
            if (text == "Leave") {
                text = "Start Date";
            } else {
                text = text + " Date";
            }
            console.log(text);
            $('#label_start_date').html(text + ' <i style="" class="star">*</i>');
            $('#label_end_date').html("End Date" + '<i style="" class="star">*</i>');
//            console.log(conditionBlock, conditionBlock.length, v);
            conditionBlock.each(function (index, element) {
                var $element = $(element);
                var list = $element.data('show');

                if (list.includes(v)) {
                    $element.addClass('custom-visible');
                    $element.removeClass('custom-hidden');
                    $element.find('input').prop("disabled", false);
                    $element.find('select').prop("disabled", false);
                } else {
                    $element.addClass('custom-hidden');
                    $element.removeClass('custom-visible');
                    $element.find('input').prop("disabled", 'disabled');
                    $element.find('select').prop("disabled", 'disabled');
                }
            });
        };
        this.onChangeReasonType = function (v, text) {
            self.conditionalRendering(v, text);
        };
        this.generateReasonType = function () {
            var select = UTIL.unassignGenerateReasonType();
            $('#unassign_reason_type_container').html(select);
            var leaveType = UTIL.leaveType();
            $('.unassign_leave_type_container').html(leaveType);
        };
        this.submitUnassign = function (e) {
            var params = e.data["parameterInfo"];
            var form = self.form;
            var inputTags = self.inputTags;
            var data = $(form).serializeArray();//UTIL.serializeAllArray(form);
            var formInput = $(inputTags);
            console.log(formInput);
            var v = UTIL.validateReportingGeo.validateConditionalRenderingForm(data, formInput, "unassign_provider_hris_id");
            console.log(v);
            var providerInfo = params['provider'];
            console.log("providerInfo", providerInfo);
            if (v) {
                var unAssignType = $(self.form + ' #unassign_reason_type').val();

                var finalPayload = {
                    zillaid: $('select#district').val(),
                    upazilaid: providerInfo['upazilaid'],
                    providerid: providerInfo['providerid'],
                    provtype: providerInfo['provtype'],
                    reportinginfo: []
                };
                $.each(data, function (i, value) {
                    finalPayload[value['name']] = value['value'];
                });
//
                if (unAssignType == 5 || unAssignType == 6) {

                    if (providerInfo['provtype'] == 3) {
                        $.each([props['currentRow']], function (i, value) {
//                            console.log(value);
                            finalPayload['reportinginfo'].push({unit: value['unit'], unitid: value['unitid'], reporting_unionid: value["reporting_unionid"], upazilaid: value["reporting_unionid"], assign_type: value['assign_type']});
                        });
                    }
                    // FPI
                    else if (providerInfo['provtype'] == 10) {
                        console.log("Unassign FPI current row", props['currentRow']);
                        $.each([props['currentRow']], function (i, value) {
                            finalPayload['reportinginfo'].push({unit: 0, unitid: 0, reporting_unionid: value["reporting_unionid"], upazilaid: value["upazilaid"], assign_type: value['assign_type']});
                        });
                    }
                    // UFPO
                    else if (providerInfo['provtype'] == 15) {
                        console.log("Unassign UFPO current row", props['currentRow']);
                        $.each([props['currentRow']], function (i, value) {
                            finalPayload['reportinginfo'].push({unit: 0, unitid: 0, reporting_unionid: 0, upazilaid: value["upazilaid"], assign_type: value['assign_type']});
                        });
                    }
                } else {
                    if (providerInfo['provtype'] == 3) {
                        $.each(props['allRows'], function (i, value) {
                            finalPayload['reportinginfo'].push({unit: value['unit'], unitid: value['unitid'], reporting_unionid: value["reporting_unionid"], upazilaid: value["upazilaid"], assign_type: value['assign_type']});
                        });
                    }
                    // FPI
                    else if (providerInfo['provtype'] == 10) {
                        $.each(props['allRows'], function (i, value) {
                            finalPayload['reportinginfo'].push({unit: 0, unitid: 0, reporting_unionid: value["reporting_unionid"], upazilaid: value["upazilaid"], assign_type: value['assign_type']});
                        });
                        console.log("Unassign FPI all row", props['allRows']);
                    }
                    // UFPO
                    else if (providerInfo['provtype'] == 15) {
                        console.log("Unassign UFPO all row", props['allRows']);

                        $.each(props['allRows'], function (i, value) {
                            finalPayload['reportinginfo'].push({unit: 0, unitid: 0, reporting_unionid: 0, upazilaid: value["upazilaid"], assign_type: value['assign_type']});
                        });
                    }
                }
                finalPayload = JSON.stringify(finalPayload);
                console.log(finalPayload);
//                return false;
//                console.log({unAssignUnit: unAssignUnitPayload, unAssignReasonType: data, provider: provider});
                UTIL.request('provider-management-dgfp?action=unassignFwaUnit', {data: finalPayload}).then(function (r1) {
                    alert(r1["message"]);
                    self.$modal.modal("hide");
                    if (providerInfo["provtype"] == 3) {
                        ReportingCatchmentUnit.generateTable();
                        $('#reporting_union_id_for_unit').change();
                    } else if (providerInfo["provtype"] == 10) {
                        ReportingCatchmentUnion.generateTable();
                        ReportingCatchmentUnion.setup();
                    } else if (providerInfo["provtype"] == 15) {
                        ReportingCatchmentUpazila.generateTable();
                        ReportingCatchmentUpazila.setup();
                    }
                });
//
//                //NEED TO SEND REQUEST BY MODIFYING THE STRUCTURE. WE CAN USE UTIL.REQUEST
//
//                self.$modal.modal('hide');
//                alert("successfully added");
            } else {
                alert("Fillup all field");
            }
        };
//        $('body').on('click', '#submitButtonUnassignCatchment', {propInfo: props}, self.submitUnassign);
//        

//        
//        $('body').on('click', '#submitButtonUnassignCatchment', {parameterInfo: self["parameterInfo"]}, function (event) {
//            event.stopImmediatePropagation();
//            console.log(self.parameterInfo, event.data);
////            self.submitUnassign(event);
//        });
    };


    $(function () {
        Catchment.init();
        var ReportingUpazilaConfig = {
            modal: '#assignReportingUpazilaModal',
            modalFor: "ReportingUpazila",
            submitBtn: '#submitButtonAssignReportingUpazila',
            form: "#reportingupazilaufpo",
            relatedTarget: ".btn-assign-reporting-upazila",
            submitUrl: "report-geo-info?action=insertReportingUpazilaUFPO",
            tableId: "#data-table-assign-reporting-upazila",
            tableDataUrl: "report-geo-info?action=getReportingUpazilaDetailsByUFPO",
            updateButtonAssingReportingUnit: "#updateButtonAssingReportingUpazila"
        };
        var ReportingUnionConfig = {
            modal: '#assignReportingUnionModal',
            modalFor: "ReportingUnion",
            submitBtn: '#submitButtonAssingReportingUnion',
            form: "#reportingunionfpi",
            relatedTarget: ".btn-assign-reporting-union",
            submitUrl: "report-geo-info?action=setReportingUnionFPI",
            tableId: "#data-table-assign-reporting-union",
            tableDataUrl: "report-geo-info?action=getReportingUnionFPI",
            updateButtonAssingReportingUnion: "#updateButtonAssingReportingUnion"
        };
        var ReportingUnitConfig = {
            modal: '#assignReportingUnitModal',
            modalFor: "ReportingUnit",
            submitBtn: '#submitButtonAssingReportingUnit',
            form: "#reportingunitfwa",
            relatedTarget: ".btn-assign-reporting-unit",
            submitUrl: "report-geo-info?action=insertProviderareaUnit",
            tableId: "#data-table-assign-reporting-unit",
            tableDataUrl: "provider-management-dgfp?action=getUnitDetailsByFWA",
            updateButtonAssingReportingUnit: "#updateButtonAssingReportingUnit"
        };

        ReportingCatchmentUnion.init(ReportingUnionConfig);
        ReportingCatchmentUnit.init(ReportingUnitConfig);
        ReportingCatchmentUpazila.init(ReportingUpazilaConfig);

        $(document).on('click', '.btn-catchment-set-responsibility', function () {
            var tr = $(this).closest('tr');
            var assignedTableList = new UTIL.renderingTable('#data-table-assign-reporting-unit');
            var currentRow = assignedTableList.getDataTable().row(tr).data();
            console.log('UPDATE SIGNLE UNIT RESPONSIBILITY', currentRow);
        });
    });


//=Open Modal For Set Ward Unit by Provider ID====================================================





    function setWardUnitClickHandler(id) {

        //alert(['setWardUnitClickHandler',id]);
        if (!upazilaAndUnionSelected()) {
            return;
        }
        var btn = $("#btnAssign" + id).button('loading');
        var provider = btn.data('provider');
        $('#setUnitWardModalTitle').html('View Mouza/ Villages - <strong>' + provider.provname + ' [' + provider.typename + ']</strong>');


        var unit = null;
        var unitLength = null;
        var unitOptions = '<option value=""> -- </option>';
        var wardOptions = '<option value=""> -- </option>';

//
//        $.post('provider-management-dgfp?action=getUnits', function (response) {
//            var units = JSON.parse(response);
//            unit = JSON.parse(response);
//            unitLength = units.length;
//        });

        $('#modalSetUnitWard').modal('show');

        $('#modalSetUnitWardTableBody').empty();
        $.ajax({
            url: "provider-management-dgfp?action=getDataForSettingUnitWardByProvider",
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
                console.log(unit);
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
//                        + "<th>Unit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>"
//                        + "<th>Ward&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>"
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
//                            + "<td><select id='optionUnit" + json[i].providerid + "" + json[i].unionid + "" + json[i].mouzaid + "" + json[i].villageid + "'>" + unitOptions + "</select> <button onclick='changeUnitClick(this," + json[i].unionid + "," + json[i].mouzaid + "," + json[i].villageid + "," + json[i].providerid + ")' type='button' class='" + buttonClassForUnit + "'>" + buttonIconForUnit + "</button> </td>"
//                            + "<td><select id='optionWard" + json[i].providerid + "" + json[i].unionid + "" + json[i].mouzaid + "" + json[i].villageid + "'>" + wardOptions + "</select> <button onclick='changeWardClick(this," + json[i].unionid + "," + json[i].mouzaid + "," + json[i].villageid + "," + json[i].providerid + ")' type='button' class='" + buttonClassForWard + "'>" + buttonIconForWard + "</button> </td></tr>"
                            ;
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
            var editProviderNameBang = $("#editProvnamebang").val();
            var editProviderMobile = $("#editProviderMobile").val();
            var editEmail = $("#editEmail").val();
            var editProviderSupervisor = $("#editProviderSupervisor").val();
            var editProviderIdHidden = $("#editProviderIdHidden").val();

            var options = {
                districtId: editDistrict,
                upazilaId: editUpazila,
                unionId: editUnion,
                typeId: editProviderType,
                password: editProviderPassword,
                name: editProviderName,
                provnamebang: editProviderNameBang,
                mobile: editProviderMobile,
                email: editEmail,
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

            var url = "provider-management-dgfp?action=updateProvider";
            var url2 = "provider-management-dgfp?action=checkProviderAreaExistance";

            var btn = $(this).button('loading');
            var xhr;

            xhr = $.post(url2, options2);
            xhr.done(function (d) {
                d = JSON.parse(d);
                console.log(d);
                if (d.length==0) {
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
//            $("#tableContent").css("display", "none");
            // $("#transparentTextForBlank").css("display", "block");

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
                url: "provider-management-dgfp?action=showdata",
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
                    console.log(providerListJson);
                    if (json.length === 0) {
                        btn.button('reset');
                        $.toast("No data found", "error")();
                        showTableRow();
                        return;
                    }
                    $("#transparentTextForBlank").css("display", "none");
                    //show table view after data load
//                    $("#tableContent").fadeIn("slow");
                    showTableRow('#tableContent');


                    var tableBody = $('#tableBody');
                    tableBody.empty(); //first empty table before showing data

                    for (var i = 0; i < json.length; i++) {
                        var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                + "<td>" + json[i].providerid + "</td>"
                                + "<td>" + json[i].provname + "</td>"
                                + "<td>" + json[i].typename + "</td>"
                                + "<td>" + json[i].organization_abbr_name_eng + "</td>"
                                + "<td>" + json[i].typename_abbr + "</td>";
                        //Device setting
                        if (json[i].devicesetting) {
                            parsedData += "<td>" + buttonSettings(json[i].providerid, 1, json[i].devicesetting) + "</td>";
                        }
                        //Area Update
                        if (json[i].areaupdate) {
//                            parsedData += "<td>" + buttonSettings(json[i].providerid, 2, json[i].areaupdate) + "</td>";
                        }

                        var jsonStr = JSON.stringify(json[i]);
                        //Area and Unit/ Ward assign
                        if (json[i].provtype == 3) {
                            //var jsonStr = JSON.stringify(json[i]);
//                            parsedData = parsedData + '<td><button id="btnAssign' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="assignArea(' + i + ')" class="btn btn-flat btn-info btn-xs bold hide">' + //data-toggle="modal" data-target="#basicModal"
//                                    '<i class="fa fa-map-marker" aria-hidden="true"></i> Assign</button>&nbsp;<button id="btnAssignReportingUnit' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="assignReportingUnit(' + i + ')" class="btn btn-flat btn-info btn-xs bold btn-assign-reporting-unit">' + //data-toggle="modal" data-target="#basicModal"
//                                    '<i class="fa fa-map-marker" aria-hidden="true"></i> Assign Area </button>&nbsp;'
//                                            +
//                                    '<button id="btnAssign' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="setWardUnitClickHandler('
//                                    + json[i].providerid + ')" class="btn btn-flat btn-info btn-xs bold">' + //data-toggle="modal" data-target="#basicModal"
//                                    '<i class="fa fa-eye" aria-hidden="true"></i> Mouza wise village</button>'
                            +'</td>';

                            //assignReportingUnitModal
//
//                            parsedData = parsedData + '<td><button id="btnAssign' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="setWardUnitClickHandler(' + json[i].providerid + ')" class="btn btn-flat btn-info btn-xs bold">' + //data-toggle="modal" data-target="#basicModal"
//                                    '<i class="fa fa-wrench" aria-hidden="true"></i> Unit/Ward</button></td>';

                        } else if (json[i].provtype == 2) {
                            //var jsonStr = JSON.stringify(json[i]);
//                            parsedData = parsedData + '<td><button id="btnAssign' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="assignArea(' + i + ')" class="btn btn-flat btn-info btn-xs bold">' + //data-toggle="modal" data-target="#basicModal"
//                                    '<i class="fa fa-map-marker" aria-hidden="true"></i> Assign</button>' + '&nbsp;<button id="btnAssign' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="setWardUnitClickHandler(' + json[i].providerid + ')" class="btn btn-flat btn-info btn-xs bold">' + //data-toggle="modal" data-target="#basicModal"
//                                    '<i class="fa fa-eye" aria-hidden="true"></i> View</button>' + '</td>';
//
//                            parsedData = parsedData + '<td><button id="btnAssign' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="setWardUnitClickHandler(' + json[i].providerid + ')" class="btn btn-flat btn-info btn-xs bold">' + //data-toggle="modal" data-target="#basicModal"
//                                    '<i class="fa fa-wrench" aria-hidden="true"></i> Unit/Ward</button></td>';

                        } else if (json[i].provtype == 10) {
                            //var jsonStr = JSON.stringify(json[i]);
//                            parsedData += '<td><button id="btnAssignReportingUnion' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="assignReportingUnion(' + i + ')" class="btn btn-flat btn-info btn-xs bold btn-assign-reporting-union">' + //data-toggle="modal" data-target="#basicModal"
//                                    '<i class="fa fa-map-eye" aria-hidden="true"></i> Type</button> &nbsp<button id="btnViewReportingUnion' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="assignReportingUnion(' + i + ')" class="btn btn-flat btn-info btn-xs bold btn-assign-reporting-union">' + //data-toggle="modal" data-target="#basicModal"
//                                    '<i class="fa fa-map-eye" aria-hidden="true"></i> VIew</button></td>';
//                            parsedData += '<td>-</td>';

                        } else if (json[i].provtype == 15) {
                            //var jsonStr = JSON.stringify(json[i]);
//                            parsedData += '<td><button id="btnViewReportingUpazila' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="assignReportingUpazila(' + i + ')" class="btn btn-flat btn-info btn-xs bold btn-assign-reporting-upazila">' + //data-toggle="modal" data-target="#basicModal"
//                                    '<i class="fa fa-map-eye" aria-hidden="true"></i> Type</button></td>';
//                            parsedData += '<td>-</td>';

                        } else {
//                            parsedData += '<td>-</td>';
//                            parsedData += '<td>-</td>';
                        }


                        //Set Status
                        var providerActiveChecked = (json[i].active == 1) ? 'checked' : '';
                        if (json[i].active == 1) {
//                            '<div class="material-switch pull-left">'
//                                    + '<input ' + checked + ' id="providerDeviceSettingActivate_' + providerId + '"' + ' onchange="changeSettings(this,' + providerId + ',' + columnType + ')" data-setting="' + setting + '" name="editProviderActive" type="checkbox">'
//                                    + '<label for="providerDeviceSettingActivate_' + providerId + '"' + 'class="label-warning"></label></div>';
                            parsedData += "<td>" + '<div class="material-switch pull-left" style="">'
                                    + '<input ' + providerActiveChecked + ' id="providerActivate_' + json[i].providerid + '"' + ' onchange="disableUser(this,' + json[i].providerid + ')"'
                                    + 'data-user-active="' + json[i].active
                                    + '" type="checkbox">'
                                    + '<label for="providerActivate_' + json[i].providerid + '"' + 'class="label-warning"></label></div>' + "&nbsp <span class='label label-flat label-success label-sm'>Active</span></td>";
                        } else {
//                            parsedData += "<td><span class='label label-flat label-danger label-sm'>Inactive</span></td>";
                            parsedData += "<td>" + '<div class="material-switch pull-left">'
                                    + '<input ' + ' id="providerDeactivate_' + json[i].providerid + '"' + ' onchange="disableUser(this,' + json[i].providerid + ')"'
                                    + 'data-user-active="' + json[i].active
                                    + '" type="checkbox">'
                                    + '<label for="providerDeactivate_' + json[i].providerid + '"' + 'class="label-warning"></label></div>' + "&nbsp<span class='label label-flat label-danger label-sm'>Inactive</span></td>";
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

// showdataProviderAssignButton CLICK

        $('#showdataProviderAssignButton').click(function () {

            //ooo
//            $("#tableContent").css("display", "none");
            //$("#transparentTextForBlank").css("display", "block");

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
                url: "provider-management-dgfp?action=showdata",
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
                    console.log(json);

                    if (json.length === 0) {
                        btn.button('reset');
                        $.toast("No data found", "error")();
                        showTableRow();
                        return;
                    }
                    $("#transparentTextForBlank").css("display", "none");
                    //show table view after data load
//                    $("#tableContent").fadeIn("slow");
                    showTableRow('#tableContentProviderAssign');


                    var tableBody = $('#tableBodyProviderAssign');
                    tableBody.empty(); //first empty table before showing data

                    for (var i = 0; i < json.length; i++) {
                        var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                + "<td>" + json[i].providerid + "</td>"
                                + "<td>" + json[i].provname + "</td>"
                                + "<td>" + json[i].typename + "</td>";
                        //Device setting
                        if (json[i].devicesetting) {
//                            parsedData += "<td>" + buttonSettings(json[i].providerid, 1, json[i].devicesetting) + "</td>";
                        }
                        //Area Update
                        if (json[i].areaupdate) {
//                            parsedData += "<td>" + buttonSettings(json[i].providerid, 2, json[i].areaupdate) + "</td>";
                        }

                        var jsonStr = JSON.stringify(json[i]);
//                        console.log(json[i]["active"]);
                        var assignButtonClass = (json[i]['active'] == 1) ? "" : "hide";
//                        console.log(json[i]["active"], assignButtonClass);
                        //Area and Unit/ Ward assign
                        if (json[i].provtype == 3) {
                            //var jsonStr = JSON.stringify(json[i]);
                            parsedData = parsedData + '<td style="text-align: center"><button id="btnAssign' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="assignArea(' + i + ')" class="btn btn-flat btn-info btn-xs bold hide">' + //data-toggle="modal" data-target="#basicModal"
                                    '<i class="fa fa-map-marker" aria-hidden="true"></i> Assign</button>&nbsp;<button id="btnAssignReportingUnit' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="assignReportingUnit(' + i + ')" class="btn btn-flat btn-info btn-xs bold btn-assign-reporting-unit ' + assignButtonClass + '">' + //data-toggle="modal" data-target="#basicModal"
                                    '<i class="fa fa-map-marker" aria-hidden="true"></i> Assign Area </button>&nbsp;'
//                                            +
//                                    '<button id="btnAssign' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="setWardUnitClickHandler('
//                                    + json[i].providerid + ')" class="btn btn-flat btn-info btn-xs bold">' + //data-toggle="modal" data-target="#basicModal"
//                                    '<i class="fa fa-eye" aria-hidden="true"></i> Mouza wise village</button>'
                                    + '</td>';

                            //assignReportingUnitModal
//
//                            parsedData = parsedData + '<td><button id="btnAssign' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="setWardUnitClickHandler(' + json[i].providerid + ')" class="btn btn-flat btn-info btn-xs bold">' + //data-toggle="modal" data-target="#basicModal"
//                                    '<i class="fa fa-wrench" aria-hidden="true"></i> Unit/Ward</button></td>';

                        } else if (json[i].provtype == 2) {
                            //var jsonStr = JSON.stringify(json[i]);
                            parsedData = parsedData + '<td style="text-align: center"><button id="btnAssign' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="assignArea(' + i + ')" class="btn btn-flat btn-info btn-xs bold">' + //data-toggle="modal" data-target="#basicModal"
                                    '<i class="fa fa-map-marker" aria-hidden="true"></i> Assign</button>' + '&nbsp;<button id="btnAssign' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="setWardUnitClickHandler(' + json[i].providerid + ')" class="btn btn-flat btn-info btn-xs bold">' + //data-toggle="modal" data-target="#basicModal"
                                    '<i class="fa fa-eye" aria-hidden="true"></i> View</button>' + '</td>';
//
//                            parsedData = parsedData + '<td><button id="btnAssign' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="setWardUnitClickHandler(' + json[i].providerid + ')" class="btn btn-flat btn-info btn-xs bold">' + //data-toggle="modal" data-target="#basicModal"
//                                    '<i class="fa fa-wrench" aria-hidden="true"></i> Unit/Ward</button></td>';

                        } else if (json[i].provtype == 10) {
                            //var jsonStr = JSON.stringify(json[i]);
                            parsedData += '<td style="text-align: center"><button' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="assignReportingUnion(' + i + ')" class="btn btn-flat btn-info btn-xs bold btn-assign-reporting-union ' + assignButtonClass + '">' + //data-toggle="modal" data-target="#basicModal"
                                    '<i class="fa fa-map-eye" aria-hidden="true"></i> Assign Area</button>';
//                                            '<button id="btnViewReportingUnion' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="assignReportingUnion(' + i + ')" class="btn btn-flat btn-info btn-xs bold btn-assign-reporting-union">' + //data-toggle="modal" data-target="#basicModal"
//                                    '<i class="fa fa-map-eye" aria-hidden="true"></i> VIew</button></td>';
//                            parsedData += '<td>-</td>';

                        } else if (json[i].provtype == 15) {
                            //var jsonStr = JSON.stringify(json[i]);
                            ////onclick="assignReportingUpazila(' + i + ')
                            parsedData += '<td style="text-align: center"><button id="btnViewReportingUpazila_' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' ' + ' class="btn btn-flat btn-info btn-xs bold btn-assign-reporting-upazila ' + assignButtonClass + '">' + //data-toggle="modal" data-target="#basicModal"
                                    '<i class="fa fa-map-marker" aria-hidden="true"></i> Assign Area</button></td>';
//                            parsedData += '<td>-</td>';

                        } else {
//                            parsedData += '<td>-</td>';
                            parsedData += '<td style="text-align: center">-</td>';
                        }


                        //Set Status
                        var providerActiveChecked = (json[i].active == 1) ? 'checked' : '';
                        if (json[i].active == 1) {
//                            '<div class="material-switch pull-left">'
//                                    + '<input ' + checked + ' id="providerDeviceSettingActivate_' + providerId + '"' + ' onchange="changeSettings(this,' + providerId + ',' + columnType + ')" data-setting="' + setting + '" name="editProviderActive" type="checkbox">'
//                                    + '<label for="providerDeviceSettingActivate_' + providerId + '"' + 'class="label-warning"></label></div>';
//                            parsedData += "<td><span class='label label-flat label-success label-sm'>Active</span>" + '<br /><div class="material-switch pull-left" style="margin-top:5px;">'
//                                    + '<input ' + providerActiveChecked + ' id="providerActivate_' + json[i].providerid + '"' + ' onchange="disableUser(this,' + json[i].providerid + ')"'
//                                    + 'data-user-active="' + json[i].active
//                                    + '" type="checkbox">'
//                                    + '<label for="providerActivate_' + json[i].providerid + '"' + 'class="label-warning"></label></div>' + "</td>";
                        } else {
//                            parsedData += "<td><span class='label label-flat label-danger label-sm'>Inactive</span></td>";
//                            parsedData += "<td><span class='label label-flat label-success label-sm'>Inactive</span>" + '<br /><div class="material-switch pull-left" style="margin-top:5px;">'
//                                    + '<input ' + ' id="providerDeactivate_' + json[i].providerid + '"' + ' onchange="disableUser(this,' + json[i].providerid + ')"'
//                                    + 'data-user-active="' + json[i].active
//                                    + '" type="checkbox">'
//                                    + '<label for="providerDeactivate_' + json[i].providerid + '"' + 'class="label-warning"></label></div>' + "</td>";
                        }

                        //Action Buttion
//                        parsedData = parsedData + '<td>' +
//                                '<button id="btnUpdate' + json[i].providerid + '" data-provider=\'' + jsonStr + '\' onclick="updateProvider(this)" class="btn btn-flat btn-warning btn-xs bold" >' + //data-toggle="modal" data-target="#basicModal"
//                                '<i class="fa fa-pencil-square-o" aria-hidden="true"></i> Update</button></td></tr>';

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

//

//===Deactive Provider========================================================================
        $('#setProviderInActive').click(function () {
            if (!upazilaAndUnionSelected()) {
                return;
            }
            var btn = $(this).button('loading');

            Pace.track(function () {
                $.ajax({
                    url: "provider-management-dgfp?action=inActiveProvider",
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
                    url: "provider-management-dgfp?action=getDataForSetRound",
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
    });
//=End Jquery===============================================================================
</script>
<script src="resources/js/ProviderManagementDGFP.js" type="text/javascript"></script>

<section class="content-header">
    <h1>Provider and catchment area management</h1>
    <!--    <ol class="breadcrumb">
                    <a class="btn btn-flat btn-success btn-sm" id="createUser"><i class="fa fa-user-plus" aria-hidden="true"></i> <b>&nbsp;Add User</b></a>
            <a class="btn btn-flat btn-primary btn-sm" href="report-geo-info?action=ReportingUpazila
               "><b>Set Provider Reporting Area</b></a>
        </ol>-->
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
                            <label for="union">Role </label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" tabindex="-1" aria-hidden="true" name="providerType" id="providerType" required>
                                <option value="">- Select Type -</option>
                            </select>
                        </div>

                        <!--                        <div class="col-md-1 col-xs-2">
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
                                                        <i class="fa fa-user-plus" aria-hidden="true"></i>&nbsp; Add User and Assign Area
                                                    </button>
                                                </div>
                        
                                                <div class="col-md-1 col-xs-2">
                                                    &nbsp;
                                                </div>
                                                <div class="col-md-2 col-xs-4">
                                                    <div id="display-show-unit" class="hide">
                        
                                                        <button type="button" id="btnShowAddReportingUnitModal" 
                                                                class="btn btn-flat btn-primary btn-block btn-sm bold" autocomplete="off">
                                                            <i class="fa fa-plus" aria-hidden="true"></i>&nbsp; Add Unit
                                                        </button>
                                                        <button type="button" id="btnShowReportingUnit" 
                                                                data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" 
                                                                class="btn btn-flat btn-info btn-sm btn-block bold" autocomplete="off">
                                                            <i class="fa fa-table"></i> &nbsp;View/Update Unit
                                                        </button>
                                                        <a class="btn btn-flat btn-primary btn-sm btn-block bold" onclick="btnAddVillageClickHandler()">Add Village</a>
                                                        <button type="button" id="btnShowVillages" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" 
                                                                class="btn btn-flat btn-info btn-sm btn-block bold" autocomplete="off">
                                                            <i class="fa fa-home"></i> &nbsp;View/Update Village
                                                        </button>
                                                    </div>
                                                    <div id="display-show-union" class="hide">
                                                        <button type="button" id="btnShowAddUnionModal" 
                                                                class="btn btn-flat btn-primary btn-block btn-sm bold" autocomplete="off">
                                                            <i class="fa fa-user-plus" aria-hidden="true"></i>&nbsp; Add Union
                                                        </button>
                                                        <button type="button" id="btnShowUnion" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" 
                                                                class="btn btn-flat btn-info btn-sm btn-block bold" autocomplete="off">
                                                            <i class="fa fa-home"></i> &nbsp;View All Union
                                                        </button>
                                                    </div>
                                                                                <button type="button" id="btnSetRound" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-sm btn-block bold hide" autocomplete="off">
                                                                                    <i class="fa fa-circle-o-notch" aria-hidden="true"></i>&nbsp; Set Round
                                                                                </button>
                                                </div>-->
                    </div>
                    <!--Action-->
                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <label>Action </label>
                        </div>
                        <div id="display-show-unit" class="display-hidden-unit-group">
                            <div class="col-md-2 col-xs-4">
                                <c:if test="${sessionScope.role!='Advanced Troubleshooter'}">   
                                    <button type="button" id="btnShowAddReportingUnitModal" 
                                            class="btn btn-flat btn-info btn-block btn-sm bold" autocomplete="off">
                                        <i class="fa fa-plus" aria-hidden="true"></i>&nbsp; Add Unit
                                    </button>
                                </c:if>
                                <button type="button" id="btnShowReportingUnit" 
                                        data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" 
                                        class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off">
                                    <i class="fa fa-home"></i>&nbsp; View/Update Unit
                                </button>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <c:if test="${sessionScope.role!='Advanced Troubleshooter'}">
                                <a class="btn btn-flat btn-info btn-sm btn-block bold" onclick="btnAddVillageClickHandler()"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp; Add Village</a>
                                </c:if>
                                <button type="button" id="btnShowVillages" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" 
                                        class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off">
                                    <i class="fa fa-home"></i>&nbsp; View/Update Village
                                </button>
                            </div>
                        </div>
                        <div id="display-show-union" class="display-hidden-union-group">
                            <div class="col-md-2 col-xs-4">
                                <c:if test="${sessionScope.role!='Advanced Troubleshooter'}">
                                <button type="button" id="btnShowAddUnionModal" 
                                        class="btn btn-flat btn-info btn-block btn-sm bold" autocomplete="off">
                                    <i class="fa fa-user-plus" aria-hidden="true"></i>&nbsp; Add Union
                                </button>
                                </c:if>
                                <button type="button" id="btnShowUnion" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" 
                                        class="btn btn-flat btn-info btn-sm btn-block bold" autocomplete="off">
                                    <i class="fa fa-home"></i> &nbsp;View All Union
                                </button>
                            </div>
                        </div>
                        <div class="col-md-2 col-xs-4" style="height: 70px">
                            <c:if test="${sessionScope.role!='Advanced Troubleshooter'}">
                            <button type="button" id="btnAddProvider" onclick="btnAddProviderClickHandler()" class="btn btn-flat btn-primary btn-block btn-sm bold" autocomplete="off">
                                <i class="fa fa-user-plus" aria-hidden="true"></i>&nbsp; Add User
                            </button>
                            </c:if>
                            <button type="button" id="showdataButton" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                <i class="fa fa-user" aria-hidden="true"></i>&nbsp; View/Update User
                            </button>
                        </div>
                        <div class="col-md-2 col-xs-4" style="height: 70px">
                            <button type="button" id="showdataProviderAssignButton" style="height: 90%" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                <i class="fa fa-table" aria-hidden="true"></i>&nbsp; Assign Area
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--    <div class="col-md-2 col-md-offset-1 col-xs-4 col-xs-offset-2">
            <button type="button" id="btnShowVillages" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off">
                <i class="fa fa-home"></i> &nbsp;View village
            </button>
        </div>-->
    <!--Transparent Text For Blank Space-->
    <section class="content-header" id="transparentTextForBlank" style="display: block;">
        <center class="emis_hologram">eMIS</center>
    </section>



    <!--Table body-->

    <div class="row table-row" id="tableContent">
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
                                    <th>Role </th>
                                    <th>Organization </th>
                                    <th>Designation </th>
                                    <th>Device Settings </th>
                                    <th class="hide">Area Settings </th>
                                    <!--<th>Catchment Area (CA)</th>-->
                                    <!--<th>Set</th>-->
                                    <th>Provider Status</th>
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
    <!--PORIVIDER ASSIGN BUTTON TABLE-->
    <div class="row table-row" id="tableContentProviderAssign">
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
                        <table class="table table-hover table-striped" id="data-table-provider-assign">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Provider ID</th>
                                    <th>Provider Name</th>
                                    <th>Type </th>
                                    <!--<th>Device Settings </th>-->
                                    <!--<th class="hide">Area Settings </th>-->
                                    <th style="text-align: center">Catchment Area (CA)</th>
                                    <!--<th>Set</th>-->
                                    <!--<th>Status</th>-->
                                    <!--<th>Action</th>-->
                                </tr>
                            </thead>
                            <tbody id="tableBodyProviderAssign">
                            </tbody>
                            <tfoot id="tableFooterProviderAssign">
                            </tfoot>
                        </table>


                    </div>
                </div>

            </div>
        </div>
    </div>
    <!-- TABLE - VIEW VILLAGE -->
    <div class="row table-row" id="tableContentVillage">
        <div class="col-xs-12">
            <div class="box box-primary full-screen">
                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <!--                        <button type="button" class="btn btn-flat btn-default btn-xs bold" onclick="window.print();"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>-->
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <!-- table -->

                <div class="box-body">
                    <h4>Village List</h4>
                    <div class="table-responsive">
                        <table class="table table-hover table-striped" id="data-table">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th onclick="short(1);" class="clickable">Mouza <span class="pull-right"><i class="fa fa-caret-down" aria-hidden="true"></i></span></th>
                                    <th onclick="short(1);" class="clickable">Village <span class="pull-right"><i class="fa fa-caret-down" aria-hidden="true"></i></span></th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody id="modalSetUnitWardTableBodyVillage">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!--------------------------------------------------------------Union Table------------------------------------------------------------------>
    <div class="row table-row" id="data-table-union-row">
        <div class="col-xs-12">
            <div class="box box-primary full-screen">
                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <!--                        <button type="button" class="btn btn-flat btn-default btn-xs bold" onclick="window.print();"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</button>-->
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <!-- table -->
                <div class="box-body">
                    <h3>Union List</h3>
                    <div class="table-responsive- no-padding">
                        <table id="data-table-union" class="table table-striped">
                            <thead id="">
                            </thead>
                            <tbody id="">
                            </tbody>
                            <tfoot id="">
                            </tfoot>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!--------------------------------------------------------------Unit Table------------------------------------------------------------------>
    <div class="row table-row" id="data-table-unit-row">
        <div class="col-xs-12">
            <div class="box box-primary full-screen">
                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen">
                            <i class="fa fa-expand" aria-hidden="true"></i>
                        </button>
                    </div>
                </div>
                <!-- table -->
                <div class="box-body">
                    <h4>Unit List</h4>
                    <div class="table-responsive- no-padding">
                        <table id="data-table-unit" class="table table-striped">
                            <thead id="">
                            </thead>
                            <tbody id="">
                            </tbody>
                            <tfoot id="">
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
        <div class="modal-content box">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold" id="myModalLabel">Add New User</h4>
            </div>
            <form method="post" id="addNewProviderForm" action="provider-management-dgfp?action=addNewProvider" class="form-horizontal" role="form"  autocomplete="off">
                <div class="modal-body box-body">
                    <table class="table table-striped">
                        <tbody style="text-align: right">
                            <tr>
                                <td><label>Provider ID <span class="star">*</span></label></td>
                                <td><input type="number" class="form-control check-pos-num" name="id" placeholder="Enter provider ID" required></td>
                            </tr>
                            <tr>
                                <td><label>Password <span class="star">*</span></label></td>
                                <td><input type="text" class="form-control" name="password" placeholder="" required ></td>
                            </tr>
                            <tr>
                                <td><label>Name (English)<span class="star">*</span></label></td>
                                <td><input type="text" class="form-control check-name" name="name" placeholder="Enter provider name (English)" required></td>
                            </tr>
                            <tr>
                                <td><label>Name (Bangla)<span class="star">*</span></label></td>
                                <td><input type="text" class="form-control" name="provnamebang" placeholder="Enter provider name (Bangla)" required></td>
                            </tr>
                            <tr>
                                <td><label>Role <span class="star">*</span></label></td>
                                <td>
                                    <select class="form-control" name="type" required>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td><label>Organization <span class="star">*</span></label></td>
                                <td>
                                    <select class="form-control" name="organization_id" id="organization_id" required>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td><label>Designation <span class="star">*</span></label></td>
                                <td>
                                    <select class="form-control" name="designation_id" id="designation_id" required>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td><label>Phone <span class="star">*</span></label></td>
                                <td><input type="text" class="form-control" name="phone"  placeholder="Enter phone number" pattern="01\d{9}" required></td>
                            </tr>    
                            <tr>
                                <td><label>Email</label></td>
                                <td><input type="text" class="form-control" name="email"  placeholder="Enter email"></td>
                            </tr> 
                            <tr>
                                <td><label>Join Date</label></td>
                                <td><input type="text" class="input form-control input-sm datePickerChooseAll" placeholder="dd/mm/yyyy" name="joinDate" id="joinDate" /></td>
                            </tr>
                            <tr>
                                <td><label>Superviser Code <span class="star">*</span></label></td>
                                <td>
                                    <!--<input type="number" class="form-control check-pos-num" name="superviserCode" placeholder="Enter superviser code">-->
                                    <select class="form-control" name="superviserCode" class="" required>
                                    </select>
                                    <span style="color: green;font-weight: bold;">Don’t see supervisor in the list?</span>
                                    <div class="btn btn-flat btn-primary btn-md bold" onclick="reopenAddProviderModel()" 
                                         data-supervisor-provider-type="" id="addSupervisorButton"><i class="fa fa-user" aria-hidden="true"></i>&nbsp; Add Supervisor</div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-flat btn-success btn-md bold" ><i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Add</button>
                    <button type="reset" name="reset" class="btn btn-flat btn-default btn-md bold" ><i class="fa fa-eraser" aria-hidden="true"></i>&nbsp; Reset</button>
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
<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true" style="overflow-y: auto">
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
                                <th>Assign Village</th>
                                <th>Set Unit/ Ward</th>
                            </tr>
                        </thead>
                        <tbody id="modalTableBody">
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <!--                <a class="btn btn-flat btn-default bold" onClick="redirectCatchment('modalAddVillage')" target="_blank">Add Village</a>-->
                <a class="btn btn-flat btn-default bold" onclick="btnAddVillageClickHandler()">Add Village</a>
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
                <h4 class="modal-title bold">Update Provider <b  id="nameAsEditProvTitle" style="color: rgb(245, 136, 18);"></b></h4>
            </div>
            <div class="box box-primary">
                <div class="box-body">
                    <form  autocomplete="off">
                        <div class="modal-body">
                            <input type="hidden" id="editProviderIdHidden" >
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
                                    <select class="form-control" id='editProviderType' disabled="disabled">
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
                                    <label for="editProviderPassword">Password</label>
                                </div>
                                <div class="col-md-4">
                                    <input type="text" class="form-control" placeholder="Enter Password" id="editProviderPassword" readonly>
                                </div>
                            </div>
                            <br>

                            <div class="row">
                                <div class="col-md-2">
                                    <label for="editProviderName">Name (English)</label>
                                </div>
                                <div class="col-md-4">
                                    <input class="form-control check-name" placeholder="Enter Name (English)" id="editProviderName">
                                </div>

                                <div class="col-md-2">
                                    <label for="editProvnamebang">Name (Bangla)</label>
                                </div>
                                <div class="col-md-4">
                                    <input class="form-control" placeholder="Enter Name (Bangla)" id="editProvnamebang">
                                </div>
                            </div>
                            <br>

                            <div class="row">
                                <div class="col-md-2">
                                    <label for="editProviderMobile">Mobile</label>
                                </div>
                                <div class="col-md-4">
                                    <input type="text" class="form-control" placeholder="Enter Mobile No." id="editProviderMobile" pattern="01\d{9}" required>
                                </div>

                                <div class="col-md-2">
                                    <label for="editEmail">Email</label>
                                </div>
                                <div class="col-md-4">
                                    <input type="text" class="form-control" placeholder="Enter Email" id="editEmail">
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

                                <!--                        <div class="col-md-2">
                                                            <label for="editProviderSupervisor">Active</label>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="material-switch pull-left">
                                                                <input id="editProviderActive" onchange="setActivity(this)" name="editProviderActive" type="checkbox">
                                                                <label for="editProviderActive" class="label-warning"></label>
                                                            </div>
                                                            <br />
                                                        </div>-->
                            </div>
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
                            <button type="submit"  id="btnConfirmToEdit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Updating" class="btn btn-flat btn-warning bold"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;Update</button>
                            <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal"><i class="fa fa-window-close-o" aria-hidden="true"></i>&nbsp;Cancel</button>
                        </div>
                    </form>
                </div>
            </div>

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



<!-----------------------------------------------------------------------------Assign Reporting Upazila Modal------------------------------------------------------------------------------->
<div class="modal fade" id="assignReportingUpazilaModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold"> Assign Reporting Upazila: 
                    <span id="assignProviderUFPOName"></span>
                </h4>
            </div>
            <form role="form" id="reportingupazilaufpo">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">

                            <div class="row">
                                <div class="col-md-4 col-xs-4">
                                    <label>Reporting upazila</label>
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="reporting_upazilaid" id="reporting_upazilaid" >
                                        <option value="">- Select Upazila -</option>
                                    </select>
                                </div>
                                <div class="col-md-4 col-xs-4">
                                    <label>Assign Type</label>
                                    <div id="geo_assign_type_container_upazila">

                                    </div>
                                </div>
                                <div class="col-md-3 col-xs-4">
                                    <label></label>
                                    <button type="button" id="submitButtonAssignReportingUpazila" 
                                            data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" 
                                            class="btn btn-flat btn-success bold form-control" autocomplete="off" style="margin-top: 3px;" >
                                        <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Assign Upazila
                                    </button>
                                </div>
                            </div>
                            <br/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-responsive- no-padding">
                                <table id="data-table-assign-reporting-upazila" class="table table-bordered table-striped">
                                    <thead id="tableHeader">
                                    </thead>
                                    <tbody>
                                    </tbody>
                                    <tfoot>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-4 col-xs-4 pull-right">
                            <button type="button" id="updateButtonAssingReportingUpazila" 
                                    data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" 
                                    class="btn btn-flat btn-warning bold btn-succes" autocomplete="off">
                                <i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp; Update
                            </button>
                            <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal">
                                <i class="fa fa-window-close-o" aria-hidden="true"></i> Cancel</button>       
                        </div>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>

<!-----------------------------------------------------------------------------Assign Reporting Union Modal------------------------------------------------------------------------------->
<div class="modal fade" id="assignReportingUnionModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold"> Assign Reporting Union: 
                    <span id="assignProviderFPIName"></span>
                </h4>
            </div>
            <form role="form" id="reportingunionfpi">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">

                            <div class="row">
                                <div class="col-md-4 col-xs-4">
                                    <label>Reporting union</label>
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="reporting_unionid" id="reporting_union_id_for_union" >
                                        <option value="">- Select Union -</option>
                                    </select>
                                </div>
                                <div class="col-md-4 col-xs-4">
                                    <label>Assign Type</label>
                                    <div id="geo_assign_type_container">

                                    </div>
                                </div>
                                <div class="col-md-3 col-xs-4">
                                    <label></label>
                                    <button type="button" id="submitButtonAssingReportingUnion" 
                                            data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" 
                                            class="btn btn-flat btn-success bold form-control" autocomplete="off" style="margin-top: 3px;" >
                                        <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Assign Union
                                    </button>
                                </div>
                            </div>
                            <br/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-responsive- no-padding">
                                <table id="data-table-assign-reporting-union" class="table table-bordered table-striped">
                                    <thead id="tableHeader">
                                    </thead>
                                    <tbody>
                                    </tbody>
                                    <tfoot>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-4 col-xs-4 pull-right">
                            <button type="button" id="updateButtonAssingReportingUnion" 
                                    data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" 
                                    class="btn btn-flat btn-warning bold btn-succes" autocomplete="off">
                                <i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp; Update
                            </button>     
                            <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal">
                                <i class="fa fa-window-close-o" aria-hidden="true"></i> Cancel</button>       
                        </div>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>


<!-----------------------------------------------------------------------------Assign Reporting Unit Modal------------------------------------------------------------------------------->
<div class="modal fade" id="assignReportingUnitModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content box">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold"> Assign Unit
                    <span id="assignProviderName"></span>
                </h4>
            </div>

            <form role="form" id="reportingunitfwa">
                <div class="modal-body box-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-3 col-xs-6">
                                    <label>Union</label>
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="reporting_unionid" id="reporting_union_id_for_unit" >
                                        <option value="">- Select Union -</option>
                                    </select>
                                </div>
                                <div class="col-md-3 col-xs-6">
                                    <label>Unit</label>
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="reporting_unit" id="reporting_unit" >
                                        <option value="">- Select Unit -</option>
                                    </select>
                                </div>
                                <div class="col-md-3 col-xs-6">
                                    <label>Assign Type</label>
                                    <div id="geo_assign_type_container_unit">
                                    </div>
                                </div>
                                <div class="col-md-3 col-xs-6">
                                    <label></label>
                                    <button type="button" id="submitButtonAssingReportingUnit" 
                                            data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" 
                                            class="btn btn-flat btn-success bold form-control" style="margin-top: 3px;" autocomplete="off">
                                        <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Assign Unit
                                    </button>
                                </div>
                            </div>
                            <br/>
                        </div>
                    </div>
                    <!--                    <div class="row">
                                            <div class="col-md-12 col-xs-12">
                                                <div class="pull-right">
                                                    <button type="button" id="submitButtonAssingReportingUnit" 
                                                            data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" 
                                                            class="btn btn-flat btn-default bold btn-succes" autocomplete="off">
                                                        <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Assign Unit
                                                    </button>
                                                </div>
                                                <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal">Close</button>       
                                            </div>
                                        </div>-->
                    <div class="row">

                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-responsive- no-padding">
                                <table id="data-table-assign-reporting-unit" class="table table-bordered table-striped">
                                    <thead id="">
                                    </thead>
                                    <tbody id="">
                                    </tbody>
                                    <tfoot id="">
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" id="updateButtonAssingReportingUnit" 
                            data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" 
                            class="btn btn-flat btn-warning bold btn-succes" autocomplete="off">
                        <i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp; Update
                    </button>     
                    <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal"><i class="fa fa-window-close-o" aria-hidden="true"></i> Cancel</button> 
                </div>


                <!--                <div class="modal-footer">
                                    <div class="row">
                                        <div class="col-md-4 col-xs-4 pull-right"> 
                                            <button type="button" id="updateButtonAssingReportingUnit" 
                                                    data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" 
                                                    class="btn btn-flat btn-warning bold btn-succes" autocomplete="off">
                                                <i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp; Update
                                            </button>     
                                            <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal"><i class="fa fa-window-close-o" aria-hidden="true"></i> Cancel</button> 
                                        </div>
                                    </div>
                                </div>-->

            </form>
        </div>
    </div>
</div>
<!-----------------------------------------------------------------------------Unassign Catchment Modal------------------------------------------------------------------------------->
<div class="modal fade" id="unassignCatchmentModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content box">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold"> Unassign Catchment Area
                    <span id="unassignProviderName"></span>
                </h4>
            </div>

            <form role="form" id="unassigncatchmentform">
                <div class="modal-body box-body">
                    <div class="row">
                        <div class="col-md-12">

                            <div class="row">
                                <div class="col-md-12 col-xs-12">
                                    <label>Reason <i style="" class="star">*</i></label>
                                </div>
                                <div class="col-md-12 col-xs-12" id="unassign_reason_type_container">

                                </div>
                                <div id="unassign_leave_type" class="custom-hidden condition-block" 
                                     data-show='["3"]'>
                                    <div class="col-md-12 col-xs-12">
                                        <label>Type of leave <i style="" class="small text-danger">*</i></label>
                                    </div>
                                    <div class="col-md-12 col-xs-12">
                                        <div class="unassign_leave_type_container"></div>
                                    </div>
                                </div>
                                <div class="custom-hidden  condition-block" data-show='["1", "2", "3", "4"]'>
                                    <div class="col-md-12 col-xs-12"'>
                                        <label id="label_start_date">Activation Date <i style="" class="star">*</i></label>
                                    </div>
                                    <div class="col-md-12 col-xs-12">
                                        <input type="text" class="form-control" id="unassign_date" name="unassign_date">
                                    </div>
                                </div>
                                <div class="custom-hidden  condition-block" data-show='["3"]'>
                                    <div class="col-md-12 col-xs-12"'>
                                        <label id=""label_end_date>End Date <i style="" class="star">*</i></label>
                                    </div>
                                    <div class="col-md-12 col-xs-12">
                                        <input type="text" class="form-control" id="unassign_leave_end_date" name="unassign_leave_end_date">
                                    </div>
                                </div>
                                <div class="custom-hidden  condition-block" data-show='["1", "2", "3", "4"]'>
                                    <!--                                    <div class="col-md-12 col-xs-12">
                                                                            <label>Employee ID <i style="" class="star">*</i></label>
                                                                        </div>
                                                                        <div class="col-md-12 col-xs-12">
                                                                            <input type="number" class="form-control" name="unassign_provider_emp_id" 
                                                                                   placeholder="Enter Employee ID" required>
                                                                        </div>-->
                                    <div class="col-md-12 col-xs-12">
                                        <label>HRIS ID </label>
                                    </div>
                                    <div class="col-md-12 col-xs-12">
                                        <input type="number" class="form-control" name="unassign_provider_hris_id" 
                                               placeholder="Enter Employee ID">
                                    </div>
                                </div>

                                <div id="unassign_district_container" class="custom-hidden condition-block" 
                                     data-show='["1"]'>
                                    <div class="col-md-12 col-xs-12">
                                        <label>Transfered District <i style="" class="star">*</i></label>
                                    </div>
                                    <div class="col-md-12 col-xs-12">
                                        <div id="all_district_container"></div>
                                    </div>
                                    <div class="col-md-12 col-xs-12">
                                        <label>Transfered Upazila <i style="" class="star">*</i></label>
                                    </div>
                                    <div class="col-md-12 col-xs-12">
                                        <select class="form-control" id="transfer_upazila" 
                                                name="transfer_upazila" style="width: 100%;" 
                                                tabindex="-1" aria-hidden="true">

                                        </select>
                                    </div>
                                    <div class="col-md-12 col-xs-12">
                                        <label>Transfered Union <i style="" class="star">*</i></label>
                                    </div>
                                    <div class="col-md-12 col-xs-12">
                                        <select class="form-control" id="transfer_union" 
                                                name="transfer_union" style="width: 100%;" 
                                                tabindex="-1" aria-hidden="true">

                                        </select>
                                    </div>
                                </div>
                            </div>
                            <br/>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="submitButtonUnassignCatchment" 
                            data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" 
                            class="btn btn-flat btn-default bold btn-warning" autocomplete="off" style="color: #fff">
                        <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Unassign
                    </button>
                    <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal"><i class="fa fa-window-close-o" aria-hidden="true"></i>&nbsp;Cancel</button>  
                </div>

                <!--                <div class="modal-footer">
                                    <div class="row">
                                        <div class="col-md-4 col-xs-4 pull-right">
                                            <button type="button" id="submitButtonUnassignCatchment" 
                                                    data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" 
                                                    class="btn btn-flat btn-default bold btn-warning" autocomplete="off">
                                                <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Unassign
                                            </button>
                                            <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;Cancel</button>       
                                        </div>
                                    </div>
                                </div>-->



            </form>
        </div>
    </div>
</div>
<!--------------------------------------------------------------Add Union Modal------------------------------------------------------------------>
<div class="modal fade" id="modalAddUnion" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold" id="myModalLabel">Add Union</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12 col-xs-12 hide">
                        <label>Request From</label>
                        <input type="text" name="request_from" id="request_from" class="form-control" value="">
                    </div>
                    <div class="col-xs-12">
                        <div class="box-body">
                            <form role="form" id="addreportingunionform">
                                <div class="row setup-content" id="step-reporting-union">
                                    <div class="col-md-12">
                                        <!--<h3 class="center">Reporting Union (FPI)</h3>-->
                                        <div class="row">
                                            <div class="form-group form-group-sm">
                                                <label  style="text-align: right" class="control-label col-sm-4" for="reporting_union_id">Union: <span class="star">*</span></label>
                                                <div class="col-sm-5">          
                                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="reporting_union_id" id="reporting_union_id" >
                                                        <option value="">- Select Union -</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group form-group-sm display">
                                                <label style="text-align: right" class="control-label col-sm-4" for="unionnameeng">Union name (English)<span class="star">*</span></label>
                                                <div class="col-sm-5">          
                                                    <input type="text" name="unionnameeng" id="unionnameeng" class="form-control">
                                                </div>
                                            </div>
                                            <div class="form-group form-group-sm display">
                                                <label style="text-align: right" class="control-label col-sm-4" for="unionname">Union name (Bangla)<span class="star">*</span></label>
                                                <div class="col-sm-5">          
                                                    <input type="text" name="unionname" id="unionname" class="form-control">
                                                </div>
                                            </div>
                                            <div class="form-group form-group-sm">
                                                <label style="text-align: right" class="control-label col-sm-4" for="unionids">Union (BBS)<span class="star">*</span></label>
                                                <div class="col-sm-5">          
                                                    <div id="multi-select-union-container">
                                                        <select class="form-control" id="multi-select-union1" multiple="multiple" name="unionids">
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--                                            <div class="col-md-4 col-xs-4">
                                                                                            <label>Reporting union <span class="star">*</span></label>
                                                                                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="reporting_union_id" id="reporting_union_id" >
                                                                                                <option value="">- Select Union -</option>
                                                                                            </select>
                                                                                        </div>-->

                                            <!--                                            <div class="col-md-4 col-xs-4 display">
                                                                                            <label>Union name (English)<span class="star">*</span> </label>
                                                                                            <input type="text" name="unionnameeng" id="unionnameeng" class="form-control">
                                                                                        </div>
                                                                                        <div class="col-md-4 col-xs-4 display">
                                                                                            <label>Union name (Bangla) <span class="star">*</span></label>
                                                                                            <input type="text" name="unionname" id="unionname" class="form-control">
                                                                                        </div>-->
                                            <!--                                            <div class="col-md-4 col-xs-4">
                                                                                            <label>Union (BBS) <span class="star">*</span></label>
                                                                                            <div id="multi-select-union-container">
                                                                                                <select class="form-control" id="multi-select-union1" multiple="multiple" name="unionids">
                                                                                                </select>
                                                                                            </div>
                                                                                        </div>-->
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <!--                <div class="col-md-4 col-xs-4 pull-right">-->
                <button type="button" id="submitButtonUnion" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-success bold" autocomplete="off">
                    <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Add Union
                </button>
                <!--                    <button type="button" id="submitButtonUnion" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-success bold hide" autocomplete="off">
                                        <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Add
                                    </button>-->

                <button type="button" id="updateButtonUnion" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-warning bold" autocomplete="off">
                    <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Update Union
                </button>
                <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal"><i class="fa fa-window-close-o" aria-hidden="true"></i>&nbsp; Cancel</button>
                <!--                </div>-->
            </div>
        </div>
    </div>
</div>
<!--------------------------------------------------------------Add Unit Modal------------------------------------------------------------------>
<div class="modal fade" id="modalAddReportingUnit" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold">Add Unit</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="box-body">
                            <form role="form" id="catchmentreportingunitfwa">
                                <!--<h3 class="center">Reporting Unit (FWA)</h3>-->
                                <div class="row">
                                    <div class="form-group form-group-sm">
                                        <label  style="text-align: right" class="control-label col-sm-4" for="catchment_reporting_union_id_for_unit">Union: <span class="star">*</span></label>
                                        <div class="col-sm-5">          
                                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" 
                                                    name="catchment_reporting_union_id_for_unit" id="catchment_reporting_union_id_for_unit" >
                                                <option value="">- Select Union -</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group form-group-sm">
                                        <label style="text-align: right" class="control-label col-sm-4" for="unit">Unit <span class="star">*</span></label>
                                        <div class="col-sm-5">          
                                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="unit" id="unit" >
                                                <option value="">- Select Unit -</option>
                                                <option value="">Unit 1</option>
                                                <option value="">Unit 2</option>
                                                <option value="">Unit 3</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group form-group-sm">
                                        <label style="text-align: right" class="control-label col-sm-4" for="unit">Village <span class="star">*</span></label>
                                        <div class="col-sm-5">
                                            <div id="multi-select-village-container">
                                                <select class="form-control" id="multi-select-village" multiple="multiple" name="villages">
                                                    <option value="13">Village 1</option>
                                                    <!--                                                    <option value="15">Village 2</option>
                                                                                                        <option value="23">Village 3</option>
                                                                                                        <option value="31">Village 4</option>
                                                                                                        <option value="34">Village 5</option>-->
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <!--                                    <div class="col-md-4 col-xs-4">
                                                                            <label>Reporting union <span class="star">*</span></label>
                                                                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="reporting_union_id_for_unit" id="reporting_union_id_for_unit" >
                                                                                <option value="">- Select Union -</option>
                                                                            </select>
                                                                        </div>-->

                                    <!--                                    <div class="col-md-4 col-xs-4">
                                                                            <label>Reporting unit <span class="star">*</span></label>
                                                                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="unit" id="unit" >
                                                                                <option value="">- Select Unit -</option>
                                                                                <option value="">Unit 1</option>
                                                                                <option value="">Unit 2</option>
                                                                                <option value="">Unit 3</option>
                                                                            </select>
                                                                        </div>-->
                                    <!--                                    <div class="col-md-4 col-xs-4">
                                                                            <label>Villages <span class="star">*</span></label>
                                                                            <div id="multi-select-village-container">
                                                                                <select class="form-control" id="multi-select-village" multiple="multiple" name="villages">
                                                                                    <option value="13">Village 1</option>
                                                                                    <option value="15">Village 2</option>
                                                                                    <option value="23">Village 3</option>
                                                                                    <option value="31">Village 4</option>
                                                                                    <option value="34">Village 5</option>
                                                                                </select>
                                                                            </div>
                                                                        </div>-->
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="submitButtonReportingUnit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-success bold hide" autocomplete="off">
                    <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Add
                </button>
                <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal"><i class="fa fa-window-close-o" aria-hidden="true"></i>&nbsp; Cancel</button>
            </div>
            <!--            <div class="modal-footer">
                            <div class="col-md-4 col-xs-4 pull-right">
                                <label>&nbsp;</label>
                                <button type="button" id="submitButtonReportingUnit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-success btn-block btn-sm bold hide" autocomplete="off">
                                    <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Add
                                </button>
                                <button type="button" id="updateButtonReportingUnit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-success btn-block btn-sm bold hide" autocomplete="off">
                                    <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Update Unit
                                </button>
                            </div>
                        </div>-->
        </div>
    </div>
</div>
<!--------------------------------------------------------------Update Unit Modal------------------------------------------------------------------>
<div class="modal fade" id="modalUpdaReportingUnit" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold">Update Unit</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="box-body">
                            <form role="form" id="updatecatchmentunitmodalform">
                                <!--<h3 class="center">Reporting Unit (FWA)</h3>-->
                                <div class="row">
                                    <div class="form-group form-group-sm">
                                        <label  style="text-align: right" class="control-label col-sm-4" for="catchment_reporting_union_id_for_update_unit">Union: <span class="star">*</span></label>
                                        <div class="col-sm-5">          
                                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" 
                                                    name="catchment_reporting_union_id_for_update_unit" id="catchment_reporting_union_id_for_update_unit" >
                                                <option value="">- Select Union -</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group form-group-sm">
                                        <label style="text-align: right" class="control-label col-sm-4" for="unit">Unit <span class="star">*</span></label>
                                        <div class="col-sm-5">          
                                            <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="update_unit_label" id="update_unit_label" >
                                                <option value="">- Select Unit -</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group form-group-sm">
                                        <label style="text-align: right" class="control-label col-sm-4" for="unit">Village <span class="star">*</span></label>
                                        <div class="col-sm-5">
                                            <div id="multi-select-update-unit-village-container">
                                                <select class="form-control" id="multi-select-update-unit-village" multiple="multiple" name="multi_select_update_unit_village" id="multi_select_update_unit_village">
                                                    <option value="13">Village 1</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="updateButtonReportingUnit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-warning bold" autocomplete="off">
                    <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Update Unit
                </button>
                <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal"><i class="fa fa-window-close-o" aria-hidden="true"></i>&nbsp; Cancel</button>
            </div>
        </div>
    </div>
</div>
<!--------------------------------------------------------------Add Village------------------------------------------------------------------>
<div class="modal fade" id="modalAddVillage" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <!--            <div class="box box-primary">
                            <div class="box-header">-->
            <form method="post" id="modalAddVillageForm" action="catchment-area-management-dgfp?action=addVillage" class="form-horizontal" role="form">
                <div class="modal-header">
                    <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                    <h4 class="modal-title bold" id="myModalLabel">Add New Village</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-4" for="mouzaid">Mouza: <span class="star">*</span></label>
                        <div class="col-sm-5">
                            <!--<input type="text" class="form-control check-pos-num" name="mouzaid" placeholder="মৌজার আইডী লিখুন" required>-->
                            <select class="form-control" name="mouzaid" required="">
                            </select>
                        </div>
                        <div class="col-sm-3">
                            <button type="button" id="btnAddMouza" onclick="btnAddMouzaClickHandler()" class="btn btn-flat btn-success btn-block btn-sm">
                                <b><i class="fa fa-home"></i> &nbsp;Add  mouza</b>
                            </button>
                        </div>
                    </div>

                    <div class="form-group form-group-sm hide">
                        <label class="control-label col-sm-4" for="villageid">Village ID: <span class="star">*</span></label>
                        <div class="col-sm-5">          
                            <input type="text" class="form-control check-pos-num" name="villageid" placeholder="গ্রামের আইডী লিখুন">
                        </div>
                    </div>

                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-4" for="villagename">Village name (Bangla): <span class="star">*</span></label>
                        <div class="col-sm-5">          
                            <input type="text" class="form-control" name="villagename" placeholder="গ্রামের নাম বাংলায় লিখুন" required>
                        </div>
                    </div>

                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-4" for="villagenameeng">Village name (English): <span class="star">*</span></label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control check-name" name="villagenameeng" placeholder="গ্রামের নাম ইংরেজিতে লিখুন" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-flat btn-success btn-md bold"><i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Add</button>
                    <button type="reset" name="reset" class="btn btn-flat btn-default btn-md bold"><i class="fa fa-eraser" aria-hidden="true"></i>&nbsp; Reset</button>
                </div>
            </form>
            <!--                </div>
                        </div>-->
        </div>
    </div>
</div>
<!---------------------------------------------------------------------------------------------------Add Mouza------------------------------------------------------------->
<div class="modal fade" id="modalAddMouza" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="post" id="modalMouzaForm" action="catchment-area-management-dgfp?action=addMouza" class="form-horizontal" role="form">
                <div class="modal-header">
                    <button type="button" class="close bold" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></button>
                    <h4 class="modal-title bold" id="myModalLabel">Add New Mouza</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-4" for="mouzaid">Mouza ID: <span class="star">*</span></label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control check-pos-num" name="mouzaid" placeholder="মৌজার আইডী লিখুন" required>
                        </div>
                    </div>

                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-4" for="mouzaname">Mouza name (Bangla): <span class="star">*</span></label>
                        <div class="col-sm-5">          
                            <input type="text" class="form-control" name="mouzaname" placeholder="মৌজার নাম বাংলায় লিখুন" required>
                        </div>
                    </div>

                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-4" for="mouzanameeng">Mouza name (English): <span class="star">*</span></label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control check-name" name="mouzanameeng" placeholder="মৌজার নাম ইংরেজিতে লিখুন" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-flat btn-success btn-md bold"><i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Add</button>
                    <button type="reset" name="reset" class="btn btn-flat btn-default btn-md bold"><i class="fa fa-eraser" aria-hidden="true"></i>&nbsp; Reset</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-----------------------------------------------edit village----------------------------------------->
<div class="modal fade" id="modalEditVillage" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <form method="post" id="modalEditVillageForm" class="form-horizontal" role="form">
                <div class="modal-header">
                    <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                    <h4 class="modal-title bold">Update Village</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group form-group-sm hide">
                        <label class="col-sm-2" for="mouzaid">Mouza id:<span class="star">*</span></label>
                        <div class="col-sm-10">          
                            <input type="text" class="form-control" name="mouzaid" placeholder="মৌজার আইডী লিখুন" required readonly>
                        </div>
                    </div>
                    <div class="form-group form-group-sm hide">

                        <label class="control-label col-sm-2" for="mouzaname">মৌজার নাম:<span class="star">*</span></label>
                        <div class="col-sm-4">          
                            <input type="text" class="form-control" name="mouzaname" placeholder="মৌজার নাম বাংলায় লিখুন" required>
                        </div>
                        <label class="control-label col-sm-2" for="mouzaameeng">Mouza name:<span class="star">*</span></label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control check-name" name="mouzanameeng" placeholder="মৌজার নাম ইংরেজিতে লিখুন" required>
                        </div>
                    </div>
                    <hr/>
                    <div class="form-group form-group-sm">
                        <label class="col-sm-2" for="villageid">Village ID:<span class="star">*</span></label>
                        <div class="col-sm-10">          
                            <input type="text" class="form-control" name="villageid" placeholder="গ্রামের আইডী লিখুন" required readonly>
                        </div>
                    </div>
                    <div class="form-group form-group-sm">

                        <label class="control-label col-sm-2" for="villagename">গ্রামের নাম:<span class="star">*</span></label>
                        <div class="col-sm-4">          
                            <input type="text" class="form-control" name="villagename" placeholder="গ্রামের নাম বাংলায় লিখুন" required>
                        </div>
                        <label class="control-label col-sm-2" for="villagenameeng">Village name:<span class="star">*</span></label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control check-name" name="villagenameeng" placeholder="গ্রামের নাম ইংরেজিতে লিখুন" required>
                        </div>
                    </div>

                    <!--                    <div class="form-group form-group-sm">
                                            <div class="col-sm-4 text-right">
                                                <button type="reset" name="reset" data-dismiss="modal" class="btn btn-flat btn-warning btn-sm">Cancel</button>
                                            </div>
                                            <div class="col-sm-5">          
                                                <button type="submit" class="btn btn-flat btn-warning btn-sm" >Submit</button>
                                            </div>
                                        </div>-->



                    <!--                    <div class="form-group form-group-sm">
                                            <div class="col-sm-offset-2 col-sm-2">
                                                <button type="submit" class="btn btn-flat btn-warning btn-sm" >Submit</button>
                                            </div>
                    
                                            <div class="col-sm-offset-1">
                                                <button type="reset" name="reset" data-dismiss="modal" class="btn btn-flat btn-warning btn-sm">Cancel</button>
                                            </div>
                                        </div>-->

                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-flat btn-warning btn-md bold"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp; Update</button>
                    <button type="button" class="btn btn-flat btn-default btn-md bold" data-dismiss="modal"><i class="fa fa-window-close-o" aria-hidden="true"></i>&nbsp; Cancel</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-------------------------------------------------------------------------------- Delete Catchment Area Modal -------------------------------------------------------------------------------->        
<div class="modal fade" id="deleteVillage" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">

            <!--            <div class="modal-header label-danger">
                            <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                            <h4 class="modal-title"><b><i class="fa fa-trash" aria-hidden="true"></i><span> Are you sure to delete?</span></b></h4>
                        </div>-->

            <div class="modal-header">
                <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold">Confirm Deletion</h4>
            </div>

            <div class="modal-body">
                <h4 class="center bold"><i class="fa fa-question-circle" aria-hidden="true"></i>&nbsp; Are you sure you want to delete ?</h4>
                <p id="deleteVillageName" style="font-size: 16px;text-align: center"></p>
                <!--                <button type="button" id="btnConfirm-deleteVillage" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger">Confirm</button>&nbsp;&nbsp;-->
                <!--                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Cancel</button>-->
            </div>

            <div class="modal-footer">
                <button type="button" id="btnConfirm-deleteVillage" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger bold"><i class="fa fa-check-square-o" aria-hidden="true"></i>&nbsp; Confirm</button>&nbsp;&nbsp;
                <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal"><i class="fa fa-window-close-o" aria-hidden="true"></i>&nbsp; Cancel</button>
            </div>
        </div>
    </div>
</div>
<!-------------------------------------------------------------------------------- Delete Union -------------------------------------------------------------------------------->        
<div class="modal fade" id="deleteReportingUnion" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">

            <!--            <div class="modal-header label-danger">
                            <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                            <h4 class="modal-title"><b><i class="fa fa-trash" aria-hidden="true"></i><span> Are you sure to delete?</span></b></h4>
                        </div>-->

            <div class="modal-header">
                <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold">Confirm Deletion</h4>
            </div>

            <div class="modal-body">
                <h4 class="center bold"><i class="fa fa-question-circle" aria-hidden="true"></i>&nbsp; Are you sure you want to delete ?</h4>
                <p id="deleteReportingUnionName" style="font-size: 16px;text-align: center"></p>
                <!--                <button type="button" id="btnConfirm-deleteVillage" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger">Confirm</button>&nbsp;&nbsp;-->
                <!--                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Cancel</button>-->
            </div>

            <div class="modal-footer">
                <button type="button" id="btnConfirm-deleteReportingUnion" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger bold"><i class="fa fa-check-square-o" aria-hidden="true"></i>&nbsp; Confirm</button>&nbsp;&nbsp;
                <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal"><i class="fa fa-window-close-o" aria-hidden="true"></i>&nbsp; Cancel</button>
            </div>
        </div>
    </div>
</div>
<!-------------------------------------------------------------------------------- Delete Unit -------------------------------------------------------------------------------->        
<div class="modal fade" id="deleteReportingUnit" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">

            <!--            <div class="modal-header label-danger">
                            <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
                            <h4 class="modal-title"><b><i class="fa fa-trash" aria-hidden="true"></i><span> Are you sure to delete?</span></b></h4>
                        </div>-->

            <div class="modal-header">
                <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                <h4 class="modal-title bold">Confirm Deletion</h4>
            </div>

            <div class="modal-body">
                <h4 class="center bold"><i class="fa fa-question-circle" aria-hidden="true"></i>&nbsp; Are you sure you want to delete ?</h4>
                <p id="deleteReportingUnitName" style="font-size: 16px;text-align: center"></p>
                <!--                <button type="button" id="btnConfirm-deleteVillage" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger">Confirm</button>&nbsp;&nbsp;-->
                <!--                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Cancel</button>-->
            </div>

            <div class="modal-footer">
                <button type="button" id="btnConfirm-deleteReportingUnit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger bold"><i class="fa fa-check-square-o" aria-hidden="true"></i>&nbsp; Confirm</button>&nbsp;&nbsp;
                <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal"><i class="fa fa-window-close-o" aria-hidden="true"></i>&nbsp; Cancel</button>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script type="text/javascript" src="https://www.jquery-az.com/boots/js/bootstrap-multiselect/bootstrap-multiselect.js"></script>
