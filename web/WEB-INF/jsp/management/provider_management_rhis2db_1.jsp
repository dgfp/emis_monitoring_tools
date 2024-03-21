<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script>
    var districtJson=null;
    var upazilaJson=null;
    var unionJson=null;
    var providerListJson=null;
    var providerTypeJson=null;
    

$(document).ready(function () {

//    for (i = new Date().getFullYear(); i > 1900; i--)
//    {
//        $('#year').append($('<option />').val(i).html(i));
//    }
    
    $.get("DivisionJsonDataProvider", function (response) {
        var returnedData = JSON.parse(response);
        districtJson=returnedData;
        var selectTag = $('#division');
        $('<option>').val(0).text('Select Division').appendTo(selectTag);
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].id;
            var name = returnedData[i].divisioneng;
            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
        }
    });
    
    $('#division').change(function (event) {
        
        $.get("DistrictJsonDataProvider",{
            division: $("select#division").val()
        }, function (response) {
            var returnedData = JSON.parse(response);
            districtJson=returnedData;
            
            var selectTag = $('#district');
            selectTag.find('option').remove();
            $('<option>').val(0).text('Select District').appendTo(selectTag);
            
            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("").text('- Select Upazila -').appendTo(selectTagUpazila);
            
            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- Select Union -').appendTo(selectTagUnion);
            
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].zillaid;
                var name = returnedData[i].zillanameeng;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });
        
    });
    


    $('#district').change(function (event) {

        var districtId = $("select#district").val();
        $.get('UpazilaJsonProvider', {
            districtId: districtId
        }, function (response) {
            var returnedData = JSON.parse(response);
            upazilaJson=returnedData;
            var selectTag = $('#upazila');
            selectTag.find('option').remove();
            $('<option>').val("").text('Select Upazila').appendTo(selectTag);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- Select Union -').appendTo(selectTagUnion);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].upazilaid;
                var name = returnedData[i].upazilanameeng;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });
    });
    
    
    //For Provider update district dropdown
    $('#editDistrict').change(function (event) {

        var districtId = $("select#editDistrict").val();
        $.get('UpazilaJsonProvider', {
            districtId: districtId
        }, function (response) {
            var returnedData = JSON.parse(response);
            upazilaJson=returnedData;
            var selectTag = $('#editUpazila');
            selectTag.find('option').remove();
            $('<option>').val("").text('Select Upazila').appendTo(selectTag);

            var selectTagUnion = $('#editUnion');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- Select Union -').appendTo(selectTagUnion);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].upazilaid;
                var name = returnedData[i].upazilanameeng;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });
    });
    
    

    $('#upazila').change(function (event) {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var selectTag = $('#union');

        if (upazilaId === "") {
            selectTag.find('option').remove();
            $('<option>').val("").text('Select Union').appendTo(selectTag);
        } else {
            $.get('UnionJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId
            }, function (response) {
                var returnedData = JSON.parse(response);
                unionJson = returnedData;
                selectTag.find('option').remove();
                $('<option>').val("").text('Select Union').appendTo(selectTag);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].unionid;
                    var name = returnedData[i].unionnameeng;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
        }
    });
    
    //For Provider update Upazila dropdown
    $('#editUpazila').change(function (event) {

        var upazilaId = $("select#editUpazila").val();
        var zilaId = $("select#editDistrict").val();
        var selectTag = $('#editUnion');

        if (upazilaId === "") {
            selectTag.find('option').remove();
            $('<option>').val("").text('Select Union').appendTo(selectTag);
        } else {
            $.get('UnionJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId
            }, function (response) {
                var returnedData = JSON.parse(response);
                unionJson = returnedData;
                selectTag.find('option').remove();
                $('<option>').val("").text('- Select Union -').appendTo(selectTag);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].unionid;
                    var name = returnedData[i].unionnameeng;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
        }
    });


    $('#union').change(function (event) {
               

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();

        var selectTag = $('#village');

        if (upazilaId === "") {
            selectTag.find('option').remove();
            $('<option>').val("").text('All').appendTo(selectTag);
        } else {
            $.get('VillageJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId, unionId: unionId
            }, function (response) {
                var returnedData = JSON.parse(response);
                selectTag.find('option').remove();
                $('<option>').val("").text('All').appendTo(selectTag);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].mouzaid + '' + returnedData[i].villageid;
                    var name = returnedData[i].villagenameeng;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
            
    
            $.ajax({
                url: "ProviderJsonData",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: $("select#union").val()
                },
                type: 'POST',
                success: function (response) {
                    //alert("Hi");
                    var selectTag = $('#provCode');

                    var returnedData = JSON.parse(response);
                    selectTag.find('option').remove();
                    $('<option>').val("").text('All').appendTo(selectTag);
                    for (var i = 0; i < returnedData.length; i++) {
                        var id = returnedData[i].provcode;
                        var name = returnedData[i].provname;
                        $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                    }

                }
            });
            
            
            
        }
    });
    
    $("#provCode").change(function(){
        
        
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
    var selectedProvider=null;
    var isUnitWardChange=false;
    
    
    
    $.get('providerTypeJsonProvider', {
    }, function (response) {
        var returnedData = JSON.parse(response);
        providerTypeJson = returnedData;
        var providerType = $('#providerType');
        providerType.find('option').remove();
        $('<option>').val("").text('All').appendTo(providerType);
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].provtype;
            var name = returnedData[i].typename;
            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(providerType);
        }
    });

    function btnAddProviderClickHandler() {
        if (!upazilaAndUnionSelected()) {
            return;
        } 
        if($('#providerType').val()==""){
            toastr["error"]("<h4><b>Please select specific provider type</b></h4>");
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
            var $options=$("select#division,select#district,select#upazila,select#union");
            var isValid=true;
            $.each($options,function(i,o){
                if(!+$(o).val()){
                     toastr["error"]("<h4><b>Please select  "+o.id+"</b></h4>");
                     isValid =false;
                     return false;
                }
            });
//        var upazilaId = $("select#upazila").val();
//        var unionId = $("select#union").val();
//        if (upazilaId.length === 0 || unionId.length === 0) {
//            if (upazilaId.length === 0 && unionId.length === 0) {
//                 toastr["error"]("<h4><b>Select a specific Upazila and Union</b></h4>");
//            } else if (upazilaId.length === 0) {
//                 toastr["error"]("<h4><b>Select a specific Upazila</b></h4>");
//            } else if (unionId.length === 0) {
//                 toastr["error"]("<h4><b>Select a specific Union</b></h4>");
//            }
//            return false;
//        }
        
        
        return isValid;
    }

//=Change device setting======================================================================
    function changeSettings(id) {

        var btnId = "#btn" + id;
        var btn = $(btnId);
        var setting = btn.data("setting");
        Pace.track(function (){
            $.ajax({
                url: "ProviderManagement_RHIS2DB?action=updateSettings",
                data: {
                    providerId: id,
                    settingId: setting,
                    districtId: $("select#district").val()
                },
                type: 'POST',
                success: function (result) {
                    if (result === "1") { //change only if one row is affected (When device setting is updated)
                        if (setting === 1) {
                            btn.data('setting', 2);
                            btn.attr('class', 'btn btn-flat btn-default btn-sm');
                        } else if (setting === 2) {
                            btn.data('setting', 1);
                            btn.attr('class', 'btn btn-flat btn-info btn-sm');
                        }
                        toastr["success"]("<h4><b>Device setting is updated</b></h4>");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Error while updating device settings</b></h4>");
                }
            }); //End Ajax
        }); //End Pace loader 
    }
//=End Change device setting===================================================================

//=Add area to provider========================================================================
    function btnAddAreaClickHandler(btnId, providerId, typeId, mouzaId, villageId) {
        
        Pace.track(function() {
            $.ajax({
                url: "ProviderManagement_RHIS2DB?action=addAreaToProvider",
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
                    loadModalData(providerId, typeId,$("select#unionForAssign").val());
                    /*if (result === "1") { //change only if one row is affected
                        loadModalData(providerId, typeId,$("select#unionForAssign").val());
                        //  alert("Area Assigned");
                    }else if(result=="2"){
                        toastr["error"]("<h4><b>For FWA, staring household no exceed 40001. Please delete all, and then reassign.</b></h4>");
                    }else if(result=="3"){
                        toastr["error"]("<h4><b>For HA, staring household no exceed 100001. Please delete all, and then reassign.</b></h4>");
                    }else{
                        toastr["error"]("<h4><b>Error occured.</b></h4>");   
                    }*/
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Error while adding area to provider</b></h4>");
                }
            });
        });
    }
//=End add area to provider====================================================================


//=Remove area to provider====================================================================
    function btnRemoveAreaClickHandler(btnId, providerId, typeId, mouzaId, villageId) {
        Pace.track(function() {
            $.ajax({
                url: "ProviderManagement_RHIS2DB?action=removeAreaFromProvider",
                data: {
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
                    if (result === "1") { //change only if one row is affected
                        loadModalData(providerId, typeId,$("select#unionForAssign").val());
                        // alert("Area Removed");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Error while removing area to provider</b></h4>");
                }
            });
        });
    }
//=End remove area to provider=================================================================


//=Load Assign modal data=====================================================================
    function loadModalData(provcode, provtype, unionId) {
        $('#modalTableBody').empty();
        Pace.track(function (){
            $.ajax({
                url: "ProviderManagement_RHIS2DB?action=getMouzaData",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId:  unionId, //$("select#union").val()
                    provcode: provcode,
                    provtype: provtype
                },
                type: 'POST',
                success: function (result) {
                    var json = JSON.parse(result);
                    if (json.length === 0) {
                        btn.button('reset');
                         toastr["error"]("<h4><b>No data found</b></h4>");
                         return;
                    }

                    for (var i = 0; i < json.length; i++) {
                        var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                + "<td class='text-left'> [" + json[i].mouzaid + "] " + json[i].mouzanameeng + "</td>"
                                + "<td class='text-left'> [" + json[i].villageid + "] " + json[i].villagenameeng + "</td>";
                        if (json[i].provtype === "null" && json[i].provcode === "null") {
                            parsedData += "<td><button id='btnAddArea" + (i + 1) + "' onClick='btnAddAreaClickHandler(" + (i + 1) + ", " + provcode + "," + provtype + "," + json[i].mouzaid + "," + json[i].villageid + ")'  class='btn btn-flat btn-block btn-default btn-xs'>Add</button></td></tr>";

                        } else {
                            parsedData += "<td><button id='btnAddArea" + (i + 1) + "' onClick='btnRemoveAreaClickHandler(" + (i + 1) + ", " + provcode + "," + provtype + "," + json[i].mouzaid + "," + json[i].villageid + ")'  class='btn btn-flat btn-block btn-info btn-xs'>Remove</button></td></tr>";
                        }
                        $('#modalTableBody').append(parsedData);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Error while fetching data</b></h4>");
                }
            });
        });
    }
//=End load modal data========================================================================

//=Set And Change unit========================================================================
    function changeUnit(selectedOption, unionid, mouzaId, villageId,provCode) {
        Pace.track(function (){
            $.ajax({
                url: "ProviderManagement_RHIS2DB?action=updateUnit",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: unionid,
                    mouzaId: mouzaId,
                    villageId: villageId,
                    unitId: selectedOption.value,
                    providerCode:provCode
                },
                type: 'POST',
                success: function (result) {
                    //alert("Unit added");

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Error while fetching data</b></h4>");
                }
            });
        });
    }
    function changeUnitClick(selectedOption, unionid, mouzaId, villageId,provCode) {
        var unitId = $("#optionUnit" + provCode+""+unionid+""+mouzaId+""+villageId).val();
        
        var buttonClass="btn btn-flat btn-xs btn-success";
        var buttonIcon='<i class=\"fa fa-check\" aria-hidden=\"true\"></i>';
        
         if(unitId==""){
            buttonClass="btn btn-flat btn-xs btn-info";
            buttonIcon='<i class=\"fa fa-plus\" aria-hidden=\"true\"></i>';

         }
        
        $(selectedOption).html("<i class='fa fa-spinner fa-pulse'></i>" );
        Pace.track(function (){
            $.ajax({
                url: "ProviderManagement_RHIS2DB?action=updateUnit",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: unionid,
                    mouzaId: mouzaId,
                    villageId: villageId,
                    unitId: unitId,
                    providerCode:provCode
                },
                type: 'POST',
                success: function (result) {
                    $(selectedOption).html(buttonIcon);
                    $(selectedOption).removeClass('btn btn-flat btn-xs btn-info').addClass(buttonClass);
                    toastr["success"]("<h4><b>Unit added</b></h4>");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Error while fetching data</b></h4>");
                }
            });
        });
    }
    
    
//===Set And Change ward=====================================================================
        function changeWard(selectedOption, unionid, mouzaId, villageId,provCode) {
        Pace.track(function (){
            $.ajax({
                url: "ProviderManagement_RHIS2DB?action=updateWard",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: unionid,
                    mouzaId: mouzaId,
                    villageId: villageId,
                    wardId: selectedOption.value,
                    providerCode:provCode
                },
                type: 'POST',
                success: function (result) {
                    //alert("Ward added");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Error while fetching data</b></h4>");
                }
            });
        });
    }
    
    function changeWardClick(selectedOption, unionid, mouzaId, villageId,provCode){
        var wardId = $("#optionWard" + provCode+""+unionid+""+mouzaId+""+villageId).val();
        
        var buttonClass="btn btn-flat btn-xs btn-success";
        var buttonIcon='<i class=\"fa fa-check\" aria-hidden=\"true\"></i>';
        
         if(wardId==""){
            buttonClass="btn btn-flat btn-xs btn-info";
            buttonIcon='<i class=\"fa fa-plus\" aria-hidden=\"true\"></i>';
         }
        
        $(selectedOption).html("<i class='fa fa-spinner fa-pulse'></i>" );
        Pace.track(function (){
            $.ajax({
                url: "ProviderManagement_RHIS2DB?action=updateWard",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: unionid,
                    mouzaId: mouzaId,
                    villageId: villageId,
                    wardId: wardId,
                    providerCode:provCode
                },
                type: 'POST',
                success: function (result) {
                    $(selectedOption).html(buttonIcon);
                    $(selectedOption).removeClass('btn btn-flat btn-xs btn-info').addClass(buttonClass);
                    toastr["success"]("<h4><b>Ward added</b></h4>");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Error while fetching data</b></h4>");
                }
            });
        });
        
    }
    
    

    function changeRound(selectedOption, districtId, upazilaId, unionId,provCode,FWAUnit) {
    console.log( "Second"+ FWAUnit);
        Pace.track(function (){
            $.ajax({
                url: "ProviderManagement_RHIS2DB?action=updateRound",
                data: {
                    districtId: districtId,
                    upazilaId: upazilaId,
                    unionId: unionId,
                    round: selectedOption.value,
                    providerCode: provCode,
                    FWAUnit: FWAUnit
                },
                type: 'POST',
                success: function (result) {

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Error while fetching data</b></h4>");
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
        var unionId=$("select#union").val();
        var unionForAssign=$('#unionForAssign');
        
        $.get('UnionJsonProvider', {
            districtId: $("select#district").val(), upazilaId: $("select#upazila").val(), zilaId: $("select#district").val()
        }, function (response) {
            var returnedData = JSON.parse(response);
            unionForAssign.find('option').remove();
            //$('<option>').val("0").text('- Select Union -').appendTo(unionForAssign);
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].unionid;
                var name = returnedData[i].unionnameeng;
                if(unionId==id)
                    $('<option selected>').val(id).text(name + ' [' + id + ']').appendTo(unionForAssign);
                else
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(unionForAssign);
                
             
            }
        });
        
        

        var provider = $("#btnAssign" + id).data('provider');
        selectedProvider = provider;
        $('#assignModalTitle').html('<i class="fa fa-map-marker" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;Assign area to <strong>' + provider.provname + ' [' + provider.typename + ']</strong>');
        var unitOptions = '';
        $.post('ProviderManagement_RHIS2DB?action=getUnits', function (response) {
            var units = JSON.parse(response);
            for (var i = 0; i < units.length; i++) {
                unitOptions += '<option value=\"' + units[i].ucode + '\">' + units[i].uname + '</option>';
            }
        });

        this.loadModalData(provider.provcode, provider.provtype,unionId);
        /*$('#modalTableBody').empty();

        $.ajax({
            url: "ProviderManagement_RHIS2DB?action=getMouzaData",
            data: {
                districtId: $("select#district").val(),
                upazilaId: $("select#upazila").val(),
                unionId: $("select#union").val(),
                provcode: provider.provcode,
                provtype: provider.provtype
            },
            type: 'POST',
            success: function (result) {
                var json = JSON.parse(result);

                for (var i = 0; i < json.length; i++) {

                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
                            + "<td> [" + json[i].mouzaid + "] " + json[i].mouzanameeng + "</td>"
                            + "<td> [" + json[i].villageid + "] " + json[i].villagenameeng + "</td>";

                    if (json[i].provtype === "null" && json[i].provcode === "null") {
                        parsedData += "<td><button id='btnAddArea" + (i + 1) + "' onClick='btnAddAreaClickHandler(" + (i + 1) + ", " + provider.provcode + "," + provider.provtype + "," + json[i].mouzaid + "," + json[i].villageid + ")'  class='btn btn-flat btn-block btn-default btn-xs'>Add</button></td></tr>";
                    } else {
                        parsedData += "<td><button id='btnAddArea" + (i + 1) + "' onClick='btnRemoveAreaClickHandler(" + (i + 1) + ", " + provider.provcode + "," + provider.provtype + "," + json[i].mouzaid + "," + json[i].villageid + ")'  class='btn btn-flat btn-block btn-success btn-xs'>Removes</button></td></tr>";
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
    function updateProvider(id){
            //h20
            if (!upazilaAndUnionSelected()) {
                return;
            }


            var selectedProviderType=providerJson[id].provtype;
            
            $('#nameAsEditProvTitle').text(providerJson[id].provname+" - "+providerJson[id].provcode); //For title set
            alert(providerJson[id].provpass);
            $('#editProviderID').val(providerJson[id].provcode);
            $('#editProviderName').val(providerJson[id].provname);
            $('#editProviderPassword').val(providerJson[id].provpass);
            $('#editProviderCode').val(providerJson[id].provcode);
            $('#editProviderMobile').val(providerJson[id].mobileno);
            $('#editProviderSupervisor').val(providerJson[id].supervisorcode);


            //Load Selected District 
            var selectDistrict = $('#editDistrict');
            selectDistrict.find('option').remove();
             $('<option>').val(0).text('- Select District -').appendTo(selectDistrict);
            for (var i = 0; i < districtJson.length; i++) {
                    var id = districtJson[i].zillaid;
                    var name = districtJson[i].zillanameeng;
                    
                    if(districtJson[i].zillaid == $('#district').val() ){
                         $('<option selected>').val(id).text(name).appendTo(selectDistrict);
                    }else{
                         $('<option>').val(id).text(name).appendTo(selectDistrict);
                    }
            }
            
            //Load Selected Upazila 
            var selectUpazila = $('#editUpazila');
            selectUpazila.find('option').remove();
             $('<option>').val(0).text('- Select Upazila -').appendTo(selectUpazila);
            for (var i = 0; i < upazilaJson.length; i++) {
                    var id = upazilaJson[i].upazilaid;
                    var name = upazilaJson[i].upazilanameeng;
                    
                    if(upazilaJson[i].upazilaid == $('#upazila').val() ){
                         $('<option selected>').val(id).text(name).appendTo(selectUpazila);
                    }else{
                         $('<option>').val(id).text(name).appendTo(selectUpazila);
                    }
            }
            
            //Load Selected Union 
            var selectUnion = $('#editUnion');
            selectUnion.find('option').remove(); 
             $('<option>').val(0).text('- Select Union -').appendTo(selectUnion);
            for (var i = 0; i < unionJson.length; i++) {
                    var id = unionJson[i].unionid;
                    var name = unionJson[i].unionnameeng;
                    
                    if(unionJson[i].unionid == $('#union').val() ){
                         $('<option selected>').val(id).text(name).appendTo(selectUnion);
                    }else{
                         $('<option>').val(id).text(name).appendTo(selectUnion);
                    }
            }
            
            //Load Provider Type
            var selectProviderType = $('#editProviderType');
            selectProviderType.find('option').remove(); 
             $('<option>').val(0).text('- Select Provider Type -').appendTo(selectProviderType);
            for (var i = 0; i < providerTypeJson.length; i++) {
                    var id = providerTypeJson[i].provtype;
                    var name = providerTypeJson[i].typename;
                    
                    if(providerTypeJson[i].provtype == selectedProviderType){
                         $('<option selected>').val(id).text(name).appendTo(selectProviderType);
                    }else{
                         $('<option>').val(id).text(name).appendTo(selectProviderType);
                   }
            }
            
           // $('#editProviderName').val(providerJson[id].provname);
           
            
            
            
            //var btn = $(this).button('loading');
           // providerIdForInActive = $("#btnInActive" + id).data('provider');
           //providerIdForInActive=id;
            $('#updateProviderModal').modal('show');
            //$('#providerIdForInActive').val(id);

    }
    
 



//=Open Modal For deactive Provider ID====================================================
    function setProviderInActiveModal(id){
            if (!upazilaAndUnionSelected()) {
                return;
            }
            //yyyyyyyyyyyyyyy
            //var btn = $(this).button('loading');
           // providerIdForInActive = $("#btnInActive" + id).data('provider');
           //providerIdForInActive=id;
            $('#inActiveProvider').modal('show');
            $('#providerIdForInActive').val(id);
            
            
           /* Pace.track(function (){
            $.ajax({
                url: "ProviderManagement_RHIS2DB?action=inActiveProvider",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: $("select#union").val(),
                    providerCode:provCode
                },
                type: 'POST',
                success: function (result) {
                    $(selectedOption).html(buttonIcon);
                    $(selectedOption).removeClass('btn btn-flat btn-xs btn-info').addClass(buttonClass);
                    toastr["success"]("<h4><b>Unit added</b></h4>");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Error while fetching data</b></h4>");
                }
            });
        });*/
    
}

//=Open Modal For Set Ward Unit by Provider ID====================================================
function setWardUnitClickHandler(id){
            if (!upazilaAndUnionSelected()) {
                return;
            }
            //var btn = $(this).button('loading');
            var provider = $("#btnAssign" + id).data('provider');
            $('#setUnitWardModalTitle').html('<i class="fa fa-wrench" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;Set Unit Ward to <strong>' + provider.provname + ' [' + provider.typename + ']</strong>');

            
            var unit=null;
            var unitLength=null;
            var unitOptions = '<option value=""> -- </option>';
            var wardOptions = '<option value=""> -- </option>';

            
            $.post('ProviderManagement_RHIS2DB?action=getUnits', function (response) {
                var units = JSON.parse(response);
                unit = JSON.parse(response);
                unitLength=units.length;
            });
            
            $('#modalSetUnitWard').modal('show');

            $('#modalSetUnitWardTableBody').empty();
            
            Pace.track(function (){
                $.ajax({
                    url: "ProviderManagement_RHIS2DB?action=getDataForSettingUnitWardByProvider",
                    data: {
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val(),
                        providerId: provider.provcode
                    },
                    type: 'POST',
                    success: function (result) {
                        var json = JSON.parse(result);

                    $('#modalSetUnitWardTableHead').empty();
                    var header="<tr>"
                            +"<th>#</th>"
                            +"<th>Name</th>"
                            +"<th>Type</th>"
                            +"<th>Code</th>"
                            +"<th>Union</th>"
                            +"<th>Mouza</th>"
                            +"<th>Village</th>"
                            +"<th>Unit</th>"
                            +"<th>Ward</th>"
                        +"</tr>";
                    $('#modalSetUnitWardTableHead').append(header);

                        for (var i = 0; i < json.length; i++) {
                            
                            var buttonClassForUnit="btn btn-flat btn-xs btn-info";
                            var buttonIconForUnit='<i class=\"fa fa-plus\" aria-hidden=\"true\"></i>';
                            var buttonClassForWard="btn btn-flat btn-xs btn-info";
                            var buttonIconForWard='<i class=\"fa fa-plus\" aria-hidden=\"true\"></i>';
                            
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
     
                           for(var j = 0; j < unitLength; j++ ){
                                if(json[i].fwaunit!="null" || json[i].fwaunit!=null || json[i].fwaunit!=""){
                                    if(json[i].fwaunit==unit[j].ucode ){
                                        
                                        buttonClassForUnit="btn btn-flat btn-xs btn-success";
                                        buttonIconForUnit='<i class=\"fa fa-check\" aria-hidden=\"true\"></i>';
                                        unitOptions += '<option value=\"' + unit[j].ucode + '\" selected>' + unit[j].uname + '</option>';
                                    }
                                    else{
                                        unitOptions += '<option value=\"' + unit[j].ucode + '\">' + unit[j].uname + '</option>';
                                    }
                                }else{
                                   unitOptions += '<option value=\"' + unit[j].ucode + '\">' + unit[j].uname + '</option>';
                                }
                               
                           }
                                    
                            for(var k = 1; k <=3; k++ ){
                                if(json[i].ward!="null" || json[i].ward!=null || json[i].ward!=""){
                                    if(json[i].ward==k ){
                                        buttonClassForWard="btn btn-flat btn-xs btn-success";
                                        buttonIconForWard='<i class=\"fa fa-check\" aria-hidden=\"true\"></i>';
                                        wardOptions += '<option value=\"' + k + '\" selected>' + k + '</option>';
                                    }else{
                                        wardOptions += '<option value=\"' + k + '\">' + k + '</option>';
                                    }
                                }else{
                                        wardOptions += '<option value=\"' + k + '\">' + k + '</option>';
                                }

                           }

                            id="btnAssign' + json[i].provcode + '"
                            
                            var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                    + "<td>" + json[i].provname + "</td>"
                                    + "<td>" + provType + "</td>"
                                    + "<td>" + json[i].provcode + "</td>"
                                    + "<td>" + json[i].unionnameeng + "</td>"
                                    + "<td> [" + json[i].mouzaid + "] " + json[i].mouzanameeng + "</td>"
                                    + "<td> [" + json[i].villageid + "] " + json[i].villagenameeng + "</td>"
                                    + "<td><select id='optionUnit" + json[i].provcode + "" + json[i].unionid + "" + json[i].mouzaid + "" + json[i].villageid + "'>" + unitOptions + "</select> <button onclick='changeUnitClick(this," + json[i].unionid + "," + json[i].mouzaid + "," + json[i].villageid + "," + json[i].provcode + ")' type='button' class='"+buttonClassForUnit+"'>"+buttonIconForUnit+"</button> </td>"
                                    + "<td><select id='optionWard" + json[i].provcode + "" + json[i].unionid + "" + json[i].mouzaid + "" + json[i].villageid + "'>"+ wardOptions +"</select> <button onclick='changeWardClick(this," + json[i].unionid + "," + json[i].mouzaid + "," + json[i].villageid + "," + json[i].provcode + ")' type='button' class='"+buttonClassForWard+"'>"+buttonIconForWard+"</button> </td></tr>";
                            $('#modalSetUnitWardTableBody').append(parsedData);
                            unitOptions=null;
                            wardOptions=null;
                            unitOptions = '<option value=""> -- </option>';
                            wardOptions = '<option value=""> -- </option>';

                        }
                        btn.button('reset');
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        btn.button('reset');
                        toastr["error"]("<h4><b>Error while fetching data</b></h4>");
                    }
                }); //Ajax end
            }); //Pace end
    

    
    
    
    
    
//    if (!upazilaAndUnionSelected()) {
//        return;
//    }
//    //$("#basicModal").modal('show'); 
//    var provider = $("#btnAssign" + id).data('provider');
//    $('#setUnitWardModalTitle').html('<i class="fa fa-wrench" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;Set Unit Ward to <strong>' + provider.provname + ' [' + provider.typename + ']</strong>');
//    $('#modalSetUnitWard').modal('show');
//    
//    var unitOptions = '<option value=""> -- </option>';
//    $.post('ProviderManagement_RHIS2DB?action=getUnits', function (response) {
//        var units = JSON.parse(response);
//        for (var i = 0; i < units.length; i++) {
//            unitOptions += '<option value=\"' + units[i].ucode + '\">' + units[i].uname + '</option>';
//        }
//    });
//
//    $('#modalSetUnitWardTableBody').empty();
//    
//    
//    Pace.track(function (){
//        $.ajax({
//            url: "ProviderManagement_RHIS2DB?action=getDataForSettingUnitWardByProvider",
//            data: {
//                districtId: $("select#district").val(),
//                upazilaId: $("select#upazila").val(),
//                unionId: $("select#union").val(),
//                providerId: provider.provcode,
//            },
//            type: 'POST',
//            success: function (result) {
//                var json = JSON.parse(result);
//
//                $('#modalSetUnitWardTableHead').empty();
//                var header="<tr>"
//                        +"<th>#</th>"
//                        +"<th>Name</th>"
//                        +"<th>Type</th>"
//                        +"<th>Code</th>"
//                        +"<th>Union</th>"
//                        +"<th>Mouza</th>"
//                        +"<th>Village</th>"
//                        +"<th>Unit</th>"
//                        +"<th>Ward</th>"
//                    +"</tr>";
//                    $('#modalSetUnitWardTableHead').append(header);
//
//                for (var i = 0; i < json.length; i++) {
//                    var provType;
//                    if (json[i].provtype === 2)
//                        provType = "HA";
//                    else if (json[i].provtype === 3)
//                        provType = "FWA";
//                    else if (json[i].provtype === 4)
//                        provType = "FWV";
//                    else if (json[i].provtype === 11)
//                        provType = "AHI";
//                    else if (json[i].provtype === 12)
//                        provType = "HI";
//                    //provcode
//                    //alert(json[i].provname+json[i].provtype);
//
//
//                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
//                            + "<td>" + json[i].provname + "</td>"
//                            + "<td>" + provType + "</td>"
//                            + "<td>" + json[i].provcode + "</td>"
//                            + "<td>" + json[i].unionnameeng + "</td>"
//                            + "<td> [" + json[i].mouzaid + "] " + json[i].mouzanameeng + "</td>"
//                            + "<td> [" + json[i].villageid + "] " + json[i].villagenameeng + "</td>"
//                            + "<td><select onchange='changeUnit(this," + json[i].unionid + "," + json[i].mouzaid + "," + json[i].villageid + "," + json[i].provcode + ")' id='optionUnit" + (i + 1) + "'>" + unitOptions + "</select></td>"
//                            + "<td><select onchange='changeWard(this," + json[i].unionid + "," + json[i].mouzaid + "," + json[i].villageid + "," + json[i].provcode + ")' id='optionWard" + (i + 1) + "'> <option value=''>--</option> <option value='1'>1</option><option value='2'>2</option> <option value='3'>3</option></select></td></tr>";
//                    $('#modalSetUnitWardTableBody').append(parsedData);
//
//                    if (json[i].fwaunit !== "null") {
//                        var id = "#optionUnit" + (i + 1);
//                        $('' + id + '').val('' + json[i].fwaunit + '').trigger('change');
//                    }
//                    if (json[i].ward !== "null") {
//                        var id = "#optionWard" + (i + 1);
//                        $('' + id + '').val('' + json[i].ward + '').trigger('change');
//                    }
//                }
//                btn.button('reset');
//            },
//            error: function (jqXHR, textStatus, errorThrown) {
//                btn.button('reset');
//                toastr["error"]("<h4><b>Error while fetching data</b></h4>");
//            }
//        });
//    });

    
}
//=End Open Modal For Set Ward Unit============================================================


//`````````````````````````````````````````````````````````````````````````````JQuery Part goes here```````````````````````````````````````````````````````````````````````````
    $(document).ready(function () {
        $("#btnSetRound").attr("disabled", true); //this enable only for FWA
        
            //Assign for selected uion area
           $('#unionForAssign').change(function (event) {
               loadModalData(selectedProvider.provcode, selectedProvider.provtype,$('#unionForAssign').val());
            });
        
//===Search User============================================================================
        $('#searchBtn').click(function () {
            if (!upazilaAndUnionSelected()) {
                return;
            }
            
            var btn = $(this).button('loading');
            Pace.track(function(){
                $.ajax({
                    url: "ProviderManagement_RHIS2DB?action=showDataByProviderId",
                    data: {
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val(),
                        providerCode: $("#search").val()
                    },
                    type: 'POST',
                    success: function (result) {
                        var json = JSON.parse(result);
                        providerJson=JSON.parse(result); //assign for globally access like search-short-pagin
                        btn.button('reset');
                        if (json.length === 0) {
                             toastr["error"]("<h4><b>No data found</b></h4>");
                             return;
                        }

                        var tableBody = $('#tableBody');
                        tableBody.empty(); //first empty table before showing data

                        for (var i = 0; i < json.length; i++) {
                            
                  
                            var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                    + "<td>" + json[i].provcode + "</td>"
                                    + "<td>" + json[i].provname + "</td>"
                                    + "<td>" + json[i].typename + "</td>";
                                    if (json[i].devicesetting === "1") {
                                        parsedData = parsedData + '<td><button id="btn' + json[i].provcode + '" onclick="changeSettings(' + json[i].provcode + ')" data-setting="1" class="btn btn-flat btn-info btn-sm">' +
                                                '<i class="fa fa-check fa-lg"></i></button></td>';
                                    } else if (json[i].devicesetting === "2") {
                                        parsedData = parsedData + '<td><button id="btn' + json[i].provcode + '" onclick="changeSettings(' + json[i].provcode + ')" data-setting="2" class="btn btn-flat btn-default btn-sm">' +
                                                '<i class="fa fa-check fa-lg"></i></button></td>';
                                    }
                                    
                                    var jsonStr = JSON.stringify(json[i]);
                                    
                                    parsedData = parsedData + '<td><button id="btnAssign' + json[i].provcode + '" data-provider=\'' + jsonStr + '\' onclick="areaAssignClickHandler(' + json[i].provcode + ')" class="btn btn-flat btn-info btn-md" >' + //data-toggle="modal" data-target="#basicModal"
                                        '<i class="fa fa-map-marker" aria-hidden="true"></i> Assign</button></td>';
                                        
                                    parsedData = parsedData + '<td><button id="btnAssign' + json[i].provcode + '" data-provider=\'' + jsonStr + '\' onclick="setWardUnitClickHandler(' + json[i].provcode + ')" class="btn btn-flat btn-info btn-md" >' + //data-toggle="modal" data-target="#basicModal"
                                    '<i class="fa fa-wrench" aria-hidden="true"></i> Unit/Ward</button></td>';
                                    
                                                                            parsedData = parsedData + '<td>'+
                                         //zzzzzzzzzzzzzzzzzzzzzzzz
                                         '<button id="btnUpdate' + json[i].provcode + '" data-provider=\'' + jsonStr + '\' onclick="updateProvider(' + i + ')" class="btn btn-flat btn-warning btn-xs" >' + //data-toggle="modal" data-target="#basicModal"
                                        '<i class="fa fa-pencil-square-o" aria-hidden="true"></i> Update</button>&nbsp;'+
                                                
                                        '<button disabled id="btnAssign' + json[i].provcode + '" data-provider=\'' + jsonStr + '\' onclick="setWardUnitClickHandler(' + json[i].provcode + ')" class="btn btn-flat btn-primary btn-xs" >' + //data-toggle="modal" data-target="#basicModal"
                                        '<i class="fa fa-wheelchair-alt" aria-hidden="true"></i> Transfer</button>&nbsp;'+
                                                
                                                '<button disabled id="btnAssign' + json[i].provcode + '" data-provider=\'' + jsonStr + '\' onclick="setWardUnitClickHandler(' + json[i].provcode + ')" class="btn btn-flat btn-warning btn-xs" >' + //data-toggle="modal" data-target="#basicModal"
                                        '<i class="fa fa-wheelchair" aria-hidden="true"></i> Go PRL</button>&nbsp;'+
                                                
                                                '<button disabled id="btnInActive' + json[i].provcode + '" data-provider=\'' + jsonStr + '\' onclick="setProviderInActiveModal(' + json[i].provcode + ')" class="btn btn-flat btn-danger btn-xs" >' + //data-toggle="modal" data-target="#basicModal"
                                        '<i class="fa fa-user-times" aria-hidden="true"></i> Deactivate</button>'+
                                                
                                                '</td></tr>';

                            tableBody.append(parsedData);
                        }
                        btn.button('reset');
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        btn.button('reset');
                        toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                    }
                }); //ajax end
            }); //face end
            
        });

        /*$('#search').keyup(function(){
            var searchField = $('#search').val();
            var regex = new RegExp(searchField, "i");
            var tableBody = $('#tableBody');
            tableBody.empty();
            //reset dropdown
            $('#tableEntrySize').get(0).selectedIndex = 0;
            
            for (var i = 0; i < providerJson.length; i++) {

                if ((providerJson[i].provname.search(regex) !== -1)) {
                            var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                    + "<td>" + providerJson[i].provcode + "</td>"
                                    + "<td>" + providerJson[i].provname + "</td>"
                                    + "<td>" + providerJson[i].typename + "</td>";
                            
                            if (providerJson[i].devicesetting === "1") {
                                parsedData = parsedData + '<td><button id="btn' + providerJson[i].provcode + '" onclick="changeSettings(' + providerJson[i].provcode + ')" data-setting="1" class="btn btn-flat btn-info btn-sm">' +
                                        '<i class="fa fa-check fa-lg"></i></button></td>';
                            } else if (providerJson[i].devicesetting === "2") {
                                parsedData = parsedData + '<td><button id="btn' + providerJson[i].provcode + '" onclick="changeSettings(' + providerJson[i].provcode + ')" data-setting="2" class="btn btn-flat btn-default btn-sm">' +
                                        '<i class="fa fa-check fa-lg"></i></button></td>';
                            }

                            var providerJsonStr = JSON.stringify(providerJson[i]);
                            parsedData = parsedData + '<td><button id="btnAssign' + providerJson[i].provcode + '" data-provider=\'' + providerJsonStr + '\' onclick="areaAssignClickHandler(' + providerJson[i].provcode + ')" class="btn btn-flat btn-info btn-sm" >' + //data-toggle="modal" data-target="#basicModal"
                                '<i class="fa fa-plus fa-lg"></i> Assign</button></td></tr>';

//                            if(providerJson[i].typename==='FWA'){
//                                parsedData = parsedData + '<td><button id="btnAssign' + providerJson[i].provcode + '" data-provider=\'' + providerJsonStr + '\' onclick="areaAssignClickHandler(' + providerJson[i].provcode + ')" class="btn btn-flat btn-info btn-sm" >' + //data-toggle="modal" data-target="#basicModal"
//                                '<i class="fa fa-plus fa-lg"></i> Assign </button>   <span class="btn btn-flat btn-info btn-sm"><b><i class="fa fa-plus fa-lg" aria-hidden="true"></i></b></span>  </td></tr>';
//                            }else{
//                                parsedData = parsedData + '<td><button id="btnAssign' + providerJson[i].provcode + '" data-provider=\'' + providerJsonStr + '\' onclick="areaAssignClickHandler(' + providerJson[i].provcode + ')" class="btn btn-flat btn-info btn-sm" >' + //data-toggle="modal" data-target="#basicModal"
//                                '<i class="fa fa-plus fa-lg"></i> Assign</button></td></tr>';
//                            }

                            tableBody.append(parsedData);
                }
             }
        });*/
//===End Search=============================================================================


//===Update provider=========================================================================
$('#btnConfirmToEdit').click(function () {
        if (!upazilaAndUnionSelected()) {
            return;
        }
        
        
        var editDistrict=$("select#editDistrict").val();
        var editUpazila=$("select#editUpazila").val();
        var editUnion=$("select#editUnion").val();
        var editProviderType=$("select#editProviderType").val();
        var editProviderPassword=$("select#editProviderPassword").val();
        var editProviderCode=$("#editProviderCode").val();
        var editProviderName=$("#editProviderName").val();
        var editProviderMobile=$("#editProviderMobile").val();
        var editProviderSupervisor=$("#editProviderSupervisor").val();
        
        
        
        
            if (editDistrict.length === 0 || editDistrict==0) {
                 toastr["error"]("<h4><b>Select a specific District</b></h4>");
                return ;
                                  
            } else if (editUpazila.length === 0 || editUpazila==0) {
                 toastr["error"]("<h4><b>Select a specific Upazila</b></h4>");
                 return ;
                 
            } else if (editUnion.length === 0 || editUnion==0) {
                 toastr["error"]("<h4><b>Select a specific Union</b></h4>");
                return ;

            }else if (editProviderType.length === 0 || editProviderType==0) {
                 toastr["error"]("<h4><b>Select a specific provider type</b></h4>");
                return ;

            }else if (editProviderCode.length === 0) {
                 toastr["error"]("<h4><b>Provider code required</b></h4>");
                return ;

            }else if (editProviderPassword.length === 0) {
                 toastr["error"]("<h4><b>Provider password required</b></h4>");
                return ;

            }else if (editProviderName.length === 0) {
                 toastr["error"]("<h4><b>Provider name required</b></h4>");
                return ;

            }else if (editProviderMobile.length === 0) {
                 toastr["error"]("<h4><b>Mobile no. required</b></h4>");
                return ;

            }else if (editProviderSupervisor.length === 0) {
                 toastr["error"]("<h4><b>Supervisor code required</b></h4>");
                return ;

            }
            
             var btn = $(this).button('loading');
           
            
            if(editDistrict!=$("select#district").val() || editUpazila!=$("select#upazila").val() || editUnion!=$("select#union").val()){
                
                Pace.track(function (){
                    $.ajax({
                        url: "ProviderManagement_RHIS2DB?action=checkProviderAreaExistance",
                        data: {
                            districtId: $("select#district").val(),
                            upazilaId: $("select#upazila").val(),
                            unionId: $("select#union").val(),
                            providerCode: $("#editProviderID").val()
                        },
                        type: 'POST',
                        success: function (result) {
                            var json = JSON.parse(result);
                            
                            if(json.length==0){
                                
                                Pace.track(function (){
                                    $.ajax({
                                        url: "ProviderManagement_RHIS2DB?action=updateProvider",
                                        data: {
                                            districtId: editDistrict,
                                            upazilaId: editUpazila,
                                            unionId: editUnion,
                                            typeId: editProviderType,

                                            providerCode: editProviderCode,
                                            name: editProviderName,
                                            mobile:  editProviderMobile,
                                            supervisor: editProviderSupervisor,
                                            id: $('#editProviderID').val()
                                        },
                                        type: 'POST',
                                        success: function (result) {
                                            btn.button('reset');
                                            if(result!=null){

                                                var tableBody = $('#tableBody');
                                                tableBody.empty(); //first empty table before showing data
                                                $('#updateProviderModal').modal('hide');
                                                $( "#showdataButton" ).click();

                                                toastr["success"]("<h4><b>Provider update successfully</b></h4>");
                                            }else{
                                                toastr["error"]("<h4><b>Problem Occured</b></h4>");
                                            }
                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {
                                            toastr["error"]("<h4><b>Error while fetching data</b></h4>");
                                        }
                                    });
                                });
                                

                            }else{
                                btn.button('reset');
                                toastr["error"]("<h4><b>Please first delete all area for this provider</b></h4>");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            toastr["error"]("<h4><b>Error while fetching data</b></h4>");
                        }
                    });
                }); 
                
                
            }else{
                
                Pace.track(function (){
                    $.ajax({
                        url: "ProviderManagement_RHIS2DB?action=updateProvider",
                        data: {
                            districtId: editDistrict,
                            upazilaId: editUpazila,
                            unionId: editUnion,
                            typeId: editProviderType,

                            providerCode: editProviderCode,
                            name: editProviderName,
                            mobile:  editProviderMobile,
                            supervisor: editProviderSupervisor,
                            id: $('#editProviderID').val()
                        },
                        type: 'POST',
                        success: function (result) {
                            btn.button('reset');
                            if(result!=null){

                                var tableBody = $('#tableBody');
                                tableBody.empty(); //first empty table before showing data
                                $('#updateProviderModal').modal('hide');
                                $( "#showdataButton" ).click();

                                toastr["success"]("<h4><b>Provider update successfully</b></h4>");
                            }else{
                                toastr["error"]("<h4><b>Problem Occured</b></h4>");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            toastr["error"]("<h4><b>Error while fetching data</b></h4>");
                        }
                    });
                });
            }
        
});


//===Show provider data=======================================================================

        $('#showdataButton').click(function () {
            if (!upazilaAndUnionSelected()) {
                return;
            }
            
            var btn = $(this).button('loading');
           
            if($("select#providerType").val()==='3'){
                        $("#btnSetRound").attr("disabled", false);
            }else{
                $("#btnSetRound").attr("disabled", true);
            }

            Pace.track(function(){
                $.ajax({
                    url: "ProviderManagement_RHIS2DB?action=showdata",
                    data: {
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val(),
                        provId: $("select#providerType").val()
                    },
                    type: 'POST',
                    success: function (result) {
                        var json = JSON.parse(result);
                        providerJson=JSON.parse(result); //assign for globally access like search-short-pagin
                        
                        if (json.length === 0) {
                            btn.button('reset');
                             toastr["error"]("<h4><b>No data found</b></h4>");
                             return;
                        }

                        var tableBody = $('#tableBody');
                        tableBody.empty(); //first empty table before showing data

                        for (var i = 0; i < json.length; i++) {
                            var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                    + "<td>" + json[i].provcode + "</td>"
                                    + "<td>" + json[i].provname + "</td>"
                                    + "<td>" + json[i].typename + "</td>";
                                    //Device setting
                                    if (json[i].devicesetting === "1") {
                                        parsedData = parsedData + '<td><button id="btn' + json[i].provcode + '" onclick="changeSettings(' + json[i].provcode + ')" data-setting="1" class="btn btn-flat btn-info btn-sm">' +
                                                '<i class="fa fa-check fa-lg"></i></button></td>';
                                    } else if (json[i].devicesetting === "2") {
                                        parsedData = parsedData + '<td><button id="btn' + json[i].provcode + '" onclick="changeSettings(' + json[i].provcode + ')" data-setting="2" class="btn btn-flat btn-default btn-sm">' +
                                                '<i class="fa fa-check fa-lg"></i></button></td>';
                                    }
                                    //Area setting
                                    if (json[i].areaupdate === "2") {
                                        parsedData = parsedData + '<td><button id="btn' + json[i].provcode + '" onclick="changeSettings(' + json[i].provcode + ')" data-setting="1" class="btn btn-flat btn-info btn-sm">' +
                                                '<i class="fa fa-check fa-lg"></i></button></td>';
                                    } else if (json[i].devicesetting === "1") {
                                        parsedData = parsedData + '<td><button id="btn' + json[i].provcode + '" onclick="changeSettings(' + json[i].provcode + ')" data-setting="2" class="btn btn-flat btn-default btn-sm">' +
                                                '<i class="fa fa-check fa-lg"></i></button></td>';
                                    } else {
                                        parsedData = parsedData + '<td><button id="btn' + json[i].provcode + '" onclick="changeSettings(' + json[i].provcode + ')" data-setting="2" class="btn btn-flat btn-default btn-sm">' +
                                                '<i class="fa fa-check fa-lg"></i></button></td>';
                                    }
                                    
                                    var jsonStr = JSON.stringify(json[i]);
                                    
                                    parsedData = parsedData + '<td><button id="btnAssign' + json[i].provcode + '" data-provider=\'' + jsonStr + '\' onclick="areaAssignClickHandler(' + json[i].provcode + ')" class="btn btn-flat btn-info btn-sm" >' + //data-toggle="modal" data-target="#basicModal"
                                        '<i class="fa fa-map-marker" aria-hidden="true"></i> Assign</button></td>';
                                        
                                    parsedData = parsedData + '<td><button id="btnAssign' + json[i].provcode + '" data-provider=\'' + jsonStr + '\' onclick="setWardUnitClickHandler(' + json[i].provcode + ')" class="btn btn-flat btn-info btn-sm" >' + //data-toggle="modal" data-target="#basicModal"
                                        '<i class="fa fa-wrench" aria-hidden="true"></i> Unit/Ward</button></td>';
                                        
                                        parsedData = parsedData + '<td>'+
                                         //hhhhhhhhhhhhhhhh
                                 
                                  '<button id="btnUpdate' + json[i].provcode + '" data-provider=\'' + jsonStr + '\' onclick="updateProvider(' + i + ')" class="btn btn-flat btn-warning btn-xs" >' + //data-toggle="modal" data-target="#basicModal"
                                        '<i class="fa fa-pencil-square-o" aria-hidden="true"></i> Update</button>&nbsp;'+
                                                
                                                
                                                '<button disabled id="btnAssign' + json[i].provcode + '" data-provider=\'' + jsonStr + '\' onclick="setWardUnitClickHandler(' + json[i].provcode + ')" class="btn btn-flat btn-primary btn-xs" >' + //data-toggle="modal" data-target="#basicModal"
                                        '<i class="fa fa-wheelchair" aria-hidden="true"></i> Go PRL</button>&nbsp;'+
                                                
                                                '<button disabled id="btnInActive' + json[i].provcode + '" data-provider=\'' + jsonStr + '\' onclick="setProviderInActiveModal(' + json[i].provcode + ')" class="btn btn-flat btn-danger btn-xs" >' + //data-toggle="modal" data-target="#basicModal"
                                        '<i class="fa fa-user-times" aria-hidden="true"></i> Deactivate</button>'+
                                                
                                                '</td></tr>';

//                                    if(json[i].typename==='FWA'){
//                                        parsedData = parsedData + '<td><button id="btnAssign' + json[i].provcode + '" data-provider=\'' + jsonStr + '\' onclick="areaAssignClickHandler(' + json[i].provcode + ')" class="btn btn-flat btn-info btn-sm" >' + //data-toggle="modal" data-target="#basicModal"
//                                        '<i class="fa fa-plus fa-lg"></i> Assign </button>   <span class="btn btn-flat btn-info btn-sm"><b><i class="fa fa-plus fa-lg" aria-hidden="true"></i></b></span>  </td></tr>';
//                                    }else{
//                                        parsedData = parsedData + '<td><button id="btnAssign' + json[i].provcode + '" data-provider=\'' + jsonStr + '\' onclick="areaAssignClickHandler(' + json[i].provcode + ')" class="btn btn-flat btn-info btn-sm" >' + //data-toggle="modal" data-target="#basicModal"
//                                        '<i class="fa fa-plus fa-lg"></i> Assign</button></td></tr>';
//                                    }

                            tableBody.append(parsedData);
                        }
                        btn.button('reset');
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        btn.button('reset');
                        toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                    }
                }); //ajax end
            }); //face end
        });
//===End Show Data==========================================================================


//===Set Unit/Ward===========================================================================
        $('#btnSetUnitWard').click(function () {
            
            if (!upazilaAndUnionSelected()) {
                return;
            }
            var btn = $(this).button('loading');
            
            var unit=null;
            var unitLength=null;
            var unitOptions = '<option value=NULL> -- </option>';
            var wardOptions = '<option value=NULL> -- </option>';

            
            $.post('ProviderManagement_RHIS2DB?action=getUnits', function (response) {
                var units = JSON.parse(response);
                unit = JSON.parse(response);
                unitLength=units.length;
//                for (var i = 0; i < units.length; i++) {
//                    unitOptions += '<option value=\"' + units[i].ucode + '\">' + units[i].uname + '</option>';
//                }
            });
            //====================================================
            
           $('#modalSetUnitWard').modal('show');

            $('#modalSetUnitWardTableBody').empty();
            Pace.track(function (){
                $.ajax({
                    url: "ProviderManagement_RHIS2DB?action=getDataForSettingUnitWard",
                    data: {
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val()
                    },
                    type: 'POST',
                    success: function (result) {
                        var json = JSON.parse(result);

                    $('#modalSetUnitWardTableHead').empty();
                    var header="<tr>"
                            +"<th>#</th>"
                            +"<th>Name</th>"
                            +"<th>Type</th>"
                            +"<th>Code</th>"
                            +"<th>Mouza</th>"
                            +"<th>Village</th>"
                            +"<th>Unit</th>"
                            +"<th>Ward</th>"
                        +"</tr>";
                    $('#modalSetUnitWardTableHead').append(header);

                        for (var i = 0; i < json.length; i++) {
                            
                            var buttonClassForUnit="btn btn-flat btn-xs btn-info";
                            var buttonIconForUnit='<i class=\"fa fa-plus\" aria-hidden=\"true\"></i>';
                            var buttonClassForWard="btn btn-flat btn-xs btn-info";
                            var buttonIconForWard='<i class=\"fa fa-plus\" aria-hidden=\"true\"></i>';
                            
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
                            //provcode
                            //alert(json[i].provname+json[i].provtype);
                           // alert(unit.length);      
                           for(var j = 0; j < unitLength; j++ ){
                                if(json[i].fwaunit!="null" || json[i].fwaunit!=null || json[i].fwaunit!=""){
                                    if(json[i].fwaunit==unit[j].ucode ){
                                        
                                        buttonClassForUnit="btn btn-flat btn-xs btn-success";
                                        buttonIconForUnit='<i class=\"fa fa-check\" aria-hidden=\"true\"></i>';
                                        unitOptions += '<option value=\"' + unit[j].ucode + '\" selected>' + unit[j].uname + '</option>';
                                    }
                                    else{
                                        unitOptions += '<option value=\"' + unit[j].ucode + '\">' + unit[j].uname + '</option>';
                                    }
                                }else{
                                   unitOptions += '<option value=\"' + unit[j].ucode + '\">' + unit[j].uname + '</option>';
                                }
                               
                           }
                                    
                           
                            for(var k = 1; k <=3; k++ ){
                                if(json[i].ward!="null" || json[i].ward!=null || json[i].ward!=""){
                                    if(json[i].ward==k ){
                                        buttonClassForWard="btn btn-flat btn-xs btn-success";
                                        buttonIconForWard='<i class=\"fa fa-check\" aria-hidden=\"true\"></i>';
                                        wardOptions += '<option value=\"' + k + '\" selected>' + k + '</option>';
                                    }else{
                                        wardOptions += '<option value=\"' + k + '\">' + k + '</option>';
                                    }
                                }else{
                                        wardOptions += '<option value=\"' + k + '\">' + k + '</option>';
                                }

                           }

                            id="btnAssign' + json[i].provcode + '"
                            
                            var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                    + "<td>" + json[i].provname + "</td>"
                                    + "<td>" + provType + "</td>"
                                    + "<td>" + json[i].provcode + "</td>"
                                    + "<td> [" + json[i].mouzaid + "] " + json[i].mouzanameeng + "</td>"
                                    + "<td> [" + json[i].villageid + "] " + json[i].villagenameeng + "</td>"
                                    + "<td><select id='optionUnit" + json[i].provcode + "" + json[i].unionid + "" + json[i].mouzaid + "" + json[i].villageid + "'>" + unitOptions + "</select> <button onclick='changeUnitClick(this," + json[i].unionid + "," + json[i].mouzaid + "," + json[i].villageid + "," + json[i].provcode + ")' type='button' class='"+buttonClassForUnit+"'>"+buttonIconForUnit+"</button> </td>"
                                    + "<td><select id='optionWard" + json[i].provcode + "" + json[i].unionid + "" + json[i].mouzaid + "" + json[i].villageid + "'>"+ wardOptions +"</select> <button onclick='changeWardClick(this," + json[i].unionid + "," + json[i].mouzaid + "," + json[i].villageid + "," + json[i].provcode + ")' type='button' class='"+buttonClassForWard+"'>"+buttonIconForWard+"</button> </td></tr>";
                            $('#modalSetUnitWardTableBody').append(parsedData);
                            unitOptions=null;
                            wardOptions=null;
                            unitOptions = '<option value=""> -- </option>';
                            wardOptions = '<option value=""> -- </option>';

//                            if (json[i].fwaunit !== "null") {
//                                var id = "#optionUnit" + (i + 1);
//                                $('' + id + '').val('' + json[i].fwaunit + '').trigger('change');
//                            }
//                            if (json[i].ward !== "null") {
//                                var id = "#optionWard" + (i + 1);
//                                $('' + id + '').val('' + json[i].ward + '').trigger('change');
//                            }

                            //alert((i+1));
                        }
                        btn.button('reset');
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        btn.button('reset');
                        toastr["error"]("<h4><b>Error while fetching data</b></h4>");
                    }
                }); //Ajax end
            }); //Pace end
            

//            if (!upazilaAndUnionSelected()) {
//                return;
//            }
//
//            $('#modalSetUnitWard').modal('show');
//            var btn = $(this).button('loading');
//            var unitOptions = '<option value=""> -- </option>';
//            $.post('ProviderManagement_RHIS2DB?action=getUnits', function (response) {
//                var units = JSON.parse(response);
//                for (var i = 0; i < units.length; i++) {
//                    unitOptions += '<option value=\"' + units[i].ucode + '\">' + units[i].uname + '</option>';
//                }
//            });
//
//            $('#modalSetUnitWardTableBody').empty();
//            $.ajax({
//                url: "ProviderManagement_RHIS2DB?action=getDataForSettingUnitWard",
//                data: {
//                    districtId: $("select#district").val(),
//                    upazilaId: $("select#upazila").val(),
//                    unionId: $("select#union").val()
//                },
//                type: 'POST',
//                success: function (result) {
//                    var json = JSON.parse(result);
//
//                    for (var i = 0; i < json.length; i++) {
//                        var provType;
//                        if (json[i].provtype === 2)
//                            provType = "HA";
//                        else if (json[i].provtype === 3)
//                            provType = "FWA";
//                        else if (json[i].provtype === 4)
//                            provType = "FWV";
//                        else if (json[i].provtype === 11)
//                            provType = "AHI";
//                        else if (json[i].provtype === 12)
//                            provType = "HI";
//                        //provcode
//                        //alert(json[i].provname+json[i].provtype);
//                        var parsedData = "<tr><td>" + (i + 1) + "</td>"
//                                + "<td>" + json[i].provname + "</td>"
//                                + "<td>" + provType + "</td>"
//                                + "<td>" + json[i].provcode + "</td>"
//                                + "<td> [" + json[i].mouzaid + "] " + json[i].mouzanameeng + "</td>"
//                                + "<td> [" + json[i].villageid + "] " + json[i].villagenameeng + "</td>"
//                                + "<td><select onchange='changeUnit(this," + json[i].mouzaid + "," + json[i].villageid + "," + json[i].provcode + ")' id='optionUnit" + (i + 1) + "'>" + unitOptions + "</select></td>"
//                                + "<td><select onchange='changeWard(this," + json[i].mouzaid + "," + json[i].villageid + "," + json[i].provcode + ")' id='optionWard" + (i + 1) + "'> <option value=''>--</option> <option value='1'>1</option><option value='2'>2</option> <option value='3'>3</option></select></td></tr>";
//                        $('#modalSetUnitWardTableBody').append(parsedData);
//                        if (json[i].fwaunit !== "null") {
//                            var id = "#optionUnit" + (i + 1);
//                            $('' + id + '').val('' + json[i].fwaunit + '').trigger('change');
//                        }
//                        if (json[i].ward !== "null") {
//                            var id = "#optionWard" + (i + 1);
//                            $('' + id + '').val('' + json[i].ward + '').trigger('change');
//                        }
//                    }
//                    btn.button('reset');
//                },
//                error: function (jqXHR, textStatus, errorThrown) {
//                    btn.button('reset');
//                    alert("Error while fetching data");
//                }
//            });
        });
//===End set unit ward========================================================================

//===Deactive Provider========================================================================
        $('#setProviderInActive').click(function () {
            if (!upazilaAndUnionSelected()) {
                return;
            }
        var btn = $(this).button('loading');

        Pace.track(function (){
                $.ajax({
                    url: "ProviderManagement_RHIS2DB?action=inActiveProvider",
                    data: {
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val(),
                        providerCode:$('#providerIdForInActive').val()
                    },
                    type: 'POST',
                    success: function (result) {
                        btn.button('reset');
                        if(result!=null){
                            //zzzzz
                            $('#inActiveProvider').modal('hide');
                            toastr["success"]("<h4><b>Provider deactivated successfully</b></h4>");
                        }else{
                            toastr["error"]("<h4><b>Problem Occured</b></h4>");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        toastr["error"]("<h4><b>Error while fetching data</b></h4>");
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
            Pace.track(function (){
                $.ajax({
                    url: "ProviderManagement_RHIS2DB?action=getDataForSetRound",
                    data: {
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val()
                    },
                    type: 'POST',
                    success: function (result) {
                        btn.button('reset');
                        var json = JSON.parse(result);
                       // alert(json[0].provcode);
                        //=========================================

                        for (var i = 0; i < json.length; i++) {
                            if(json[i].fwaunit ==="null"){
                                 var fwaunit="-";
                            }else{
                                 var fwaunit=json[i].fwaunit;
                            }

                            if(json[i].fwa_round !=="null" && json[i].fwa_round ===1){
                                            var roundOptions = '<option value="">- Select Round-</option>';
                                            roundOptions += '<option value="1" selected>01</option>';
                                            roundOptions += '<option value="2">02</option>';
                                            roundOptions += '<option value="3">03</option>';
                                            roundOptions += '<option value="4">04</option>';
                                            roundOptions += '<option value="5">05</option>';

                            }else if(json[i].fwa_round !=="null" && json[i].fwa_round ===2){
                                            var roundOptions = '<option value="">- Select Round-</option>';
                                            roundOptions += '<option value="1">01</option>';
                                            roundOptions += '<option value="2" selected>02</option>';
                                            roundOptions += '<option value="3">03</option>';
                                            roundOptions += '<option value="4">04</option>';
                                            roundOptions += '<option value="5">05</option>';

                            }else if(json[i].fwa_round !=="null" && json[i].fwa_round ===3){
                                            var roundOptions = '<option value="">- Select Round-</option>';
                                            roundOptions += '<option value="1">01</option>';
                                            roundOptions += '<option value="2">02</option>';
                                            roundOptions += '<option value="3" selected>03</option>';
                                            roundOptions += '<option value="4">04</option>';
                                            roundOptions += '<option value="5">05</option>';

                            }else if(json[i].fwa_round !=="null" && json[i].fwa_round ===4){
                                            var roundOptions = '<option value="">- Select Round-</option>';
                                            roundOptions += '<option value="1">01</option>';
                                            roundOptions += '<option value="2">02</option>';
                                            roundOptions += '<option value="3">03</option>';
                                            roundOptions += '<option value="4" selected>04</option>';
                                            roundOptions += '<option value="5">05</option>';

                            }else if(json[i].fwa_round !=="null" && json[i].fwa_round ===5){
                                            var roundOptions = '<option value="">- Select Round-</option>';
                                            roundOptions += '<option value="1">01</option>';
                                            roundOptions += '<option value="2">02</option>';
                                            roundOptions += '<option value="3">03</option>';
                                            roundOptions += '<option value="4">04</option>';
                                            roundOptions += '<option value="5" selected>05</option>';

                            }else{
                                        var roundOptions = '<option value="">- Select Round-</option>';
                                        roundOptions += '<option value="1">01</option>';
                                        roundOptions += '<option value="2">02</option>';
                                        roundOptions += '<option value="3">03</option>';
                                        roundOptions += '<option value="4">04</option>';
                                        roundOptions += '<option value="5">05</option>';
                            }

                            var parsedData = "<tr style='text-align:center;'><td>" + (i + 1) + "</td>"
                                    + "<td style='text-align:center;'>" + json[i].provname + "</td>"
                                    + "<td style='text-align:center;'>" + json[i].provcode + "</td>"
                                    + "<td style='text-align:center;'>FWA</td>"
                                    + "<td style='text-align:center;'>" + fwaunit + "</td>"
                                    + "<td style='text-align:center;'><select onchange='changeRound(this," + json[i].zillaid + "," + json[i].upazilaid + "," + json[i].unionid + "," + json[i].provcode + "," + json[i].fwaunit + ")' id='optionRound" + (i + 1) + "'>" + roundOptions + "</select></td>";
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
                        toastr["error"]("<h4><b>Error while fetching data</b></h4>");
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
            Pace.track(function (){
                $.ajax(
                        {
                            url: formURL,
                            type: "POST",
                            data: postData,
                            success: function (result) {
                                if (result === "1") { //change only if one row is affected
                                    toastr["success"]("<h4><b>Provider added successfully</b></h4>");
                                    $('#showdataButton').click();
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                toastr["error"]("<h4><b>Error while adding provider</b></h4>");
                            }
                        }); //End Ajax
                }); //Pace end
            e.preventDefault();	//STOP default action
            $('#modalAddProvider').modal('hide');
        });
//===End Add provider submisson===============================================================

    });
//=End Jquery===============================================================================
</script>

<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
      <span style="color:#4fef2f;"><i class="fa fa-check-circle" aria-hidden="true"></i></span> Provider management
    <small>(community)</small>
  </h1>
<!--  <ol class="breadcrumb">
    <a class="btn btn-flat btn-info btn-sm" href="ProviderManagement_RHIS2DB"><b>Area Assign</b></a>
    <a class="btn btn-flat btn-primary btn-sm" href="#"><b>Add provider</b></a>
  </ol>-->
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <div class="row">
      <div class="col-md-12">
        <div class="box box-primary">
          <div class="box-header with-border">
              <div class="box-tools pull-right" style="margin-top: -10px;">
              <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
              </button>
              <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
            </div>
          </div>
          <!-- /.box-header -->
          <div class="box-body">
            <div class="row">
                <div class="col-md-1">
                    <label for="division">Division</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="division" id="division"> </select>
                </div>
                
                <div class="col-md-1">
                    <label for="district">District</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="district" id="district"> 
                        <option value="">- Select District -</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="upazila">Upazila</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="upazila" id="upazila">
                        <option value="">- Select Upazila -</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="union">Union</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="union" id="union">
                        <option value="">- Select Union -</option>
                    </select>
                </div>
            </div><br>
            
            <div class="row">
                <div class="col-md-1">
                    <label for="union">Provider </label>
                </div>
                <div class="col-md-2">
                    <select class="form-control" name="providerType" id="providerType" required>
                        <option value="">- Select Type -</option>
                    </select>
                </div>
                
                <div class="col-md-2 col-md-offset-1">        
                    <button type="button" id="showdataButton" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block" autocomplete="off" >
                        <i class="fa fa-table" aria-hidden="true"></i> Show data
                    </button>
                </div>
                
                <div class="col-md-2 col-md-offset-1">        
                    <button type="button" id="btnAddProvider" onclick="btnAddProviderClickHandler()" class="btn btn-flat btn-primary btn-block btn-sm">
                        <i class="fa fa-user-plus" aria-hidden="true"></i> Add Provider
                    </button>
                </div>
                
                <div class="col-md-2 col-md-offset-1">
                    <button type="button" id="btnSetUnitWard" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-sm btn-block" autocomplete="off">
                        <i class="fa fa-wrench" aria-hidden="true"></i> Set Unit/Ward
                    </button>
                </div>
                
                
            </div><br>
            <div class="row">
                <div class="col-md-2 col-md-offset-10">
                    <button type="button" id="btnSetRound" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-sm btn-block" autocomplete="off">
                        <i class="fa fa-circle-o-notch" aria-hidden="true"></i> Set Round
                    </button>
                </div>
            </div><br>
                          
          </div>
        </div>
      </div>
    </div>
    <!--Table body-->
    
    <div class="row" id="tableContent">
    <div class="col-xs-12">
        <div class="box box-primary">
            
            <!--  Table top -->
            <div class="box-header" style="margin-bottom: -10px;">
                <div class="row">
                    <div class="col-md-7">
<!--                        <h3 class="box-title pull-center">  <span id="result">Show</span>
                            <select id="tableEntrySize">
                                <option value="0">All</option>
                                <option value="10">10</option>
                                <option value="15">15</option>
                                <option value="20">20</option>
                                <option value="25">25</option>
                                <option value="30">30</option>
                            </select> entries 
                        </h3>-->
                    </div>

<!--                    <div class="col-md-1">
                                 <button type="button" class="btn btn-flat btn-primary"><i class="fa fa-search" aria-hidden="true"></i></button>
                    </div>-->
                </div>
            </div>
            
        <!-- table -->
        <div class="box-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover" id="data-table">
                    <thead class="data-table">
                        <tr>
                            <th>#</th>
                            <th>Provider ID</th>
                            <th>Provider Name</th>
                            <th>Type </th>
                            <th>Device Settings </th>
                            <th>Area Settings </th>
                            <th>Area</th>
                            <th>Set</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                    </tbody>
                    <tfoot id="tableFooter">
                    </tfoot>
                </table>
                
<!--                <ul class="pager pull-right">
                <li><a href="#">Previous</a></li>
                <li><a href="#">1</a></li>
                <li class="active"><a href="#">2</a></li>
                <li><a href="#">Next</a></li>
                </ul>-->
            </div>
        </div>
        
      </div>
    </div>
  </div>
</section>



<!-- Page Content -->
<!--<div id="page-wrapper">

    <div class="container-fluid">

        <div class="row">
            <div class="col-lg-12">
                <h3>Provider Management</h3>
            </div>

        </div>

        <div class="well well-sm">
            <div class="row">

                <div class="col-md-1">
                    <label for="district">District</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="district" id="district"> </select>
                </div>
                <div class="col-md-1">
                    <label for="upazila">Upazila</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="upazila" id="upazila" >
                        <option value="">All</option>
                    </select>
                </div>
                
                <div class="col-md-1">
                    <label for="union">Union</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="union" id="union" >
                        <option value="">All</option>
                    </select>
                </div>
                
                <div class="col-md-1">
                    <label for="union">Provider </label>
                </div>
                <div class="col-md-2">
                    <select class="form-control" name="providerType" id="providerType" required>
                        <option value="">- Select Type -</option>
                        <option value="1">Data Collector</option>
                        <option value="2">HA</option>
                        <option value="3">FWA</option>
                        <option value="10">FPI</option>
                        <option value="11">AHI</option>
                        <option value="12">HI</option>
                    </select>
                </div>

            </div>

            <br>

            <div class="row">
                <div class="col-md-2 col-md-offset-1">        
                    <button type="button" id="showdataButton" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-primary btn-sm btn-block" autocomplete="off" >
                        Show data
                    </button>
                </div>
                
                <div class="col-md-2 col-md-offset-1">        
                    <button type="button" id="btnAddProvider" onclick="btnAddProviderClickHandler()" class="btn btn-primary btn-block btn-sm">
                        Add Provider
                    </button>
                </div>
                
                <div class="col-md-2 col-md-offset-1">
                    <button type="button" id="btnSetUnitWard" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-primary btn-sm btn-block" autocomplete="off">
                        Set Unit/Ward
                    </button>
                </div>
                
                <div class="col-md-2 col-md-offset-1">
                    <button type="button" id="btnSetRound" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-primary btn-sm btn-block" autocomplete="off">
                        Set Round
                    </button>
                </div>
            </div>

        </div>

        <div class="col-ld-12">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Provider ID</th>
                            <th>Provider Name</th>
                            <th>Type</th>
                            <th>Device Settings</th>
                            <th>Area</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                    </tbody>
                </table>
            </div>
        </div>

         /.row 
    </div>
     /.container-fluid 
</div>-->
<!-- /#page-wrapper -->

<!------------------------------------------------------------------------------ Add Provider Modal ------------------------------------------------------------------------------> 
<div class="modal fade" id="modalAddProvider" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header label-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel"><b><i class="fa fa-user-plus" aria-hidden="true"></i>    &nbsp; Add New Provider</b></h4>
            </div>
            <div class="modal-body">
                <form method="post" id="addNewProviderForm" action="ProviderManagement_RHIS2DB?action=addNewProvider" class="form-horizontal" role="form">
                    
                    <table class="table table-striped table-hover">
                        <tbody style="text-align: center">
                            <tr>
                                <td>Code *</td>
                                <td><input type="number" class="form-control" name="id" placeholder="Enter provider ID" required></td>
                            </tr>
                            <tr>
                                <td>Password *</td>
                                <td><input type="password" class="form-control" name="password" placeholder="" required></td>
                            </tr>
                            <tr>
                                <td>Name *</td>
                                <td><input type="text" class="form-control" name="name" placeholder="Enter provider name" required></td>
                            </tr>
                            <tr>
                                <td>Type *</td>
                                <td>
                                    <select class="form-control" name="type" required>
<!--                                        <option value="">- Select Type -</option>
                                        <option value="1">Data Collector</option>
                                        <option value="2">HA</option>
                                        <option value="3">FWA</option>
                                        <option value="10">FPI</option>
                                        <option value="11">AHI</option>
                                        <option value="12">HI</option>-->
                                    </select>
                                </td>
                            </tr>     
                            <tr>
                                <td>Phone *</td>
                                <td><input type="number" class="form-control" name="phone" min="11" max="11"  placeholder="Enter phone number" required></td>
                            </tr>     
                            <tr>
                                <td>Join Date</td>
                                <td><input type="text" class="input form-control input-sm datePickerChooseAll" placeholder="dd/mm/yyyy" name="joinDate" id="joinDate" /></td>
                            </tr>
                            <tr>
                                <td>Superviser Code</td>
                                <td><input type="number" class="form-control" name="superviserCode" placeholder="Enter superviser code"></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td class="pull-left"><button type="submit" class="btn btn-flat btn-primary btn-md" >Submit</button> &nbsp; <button type="reset" name="reset" class="btn btn-flat btn-primary btn-md" >Reset</button></td>
                            </tr>
                        </tbody>
                    </table>

<!--                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-2" for="id">Code:</label>
                        <div class="col-sm-5">
                            <input type="number" class="form-control" name="id" placeholder="Enter provider ID" required>
                        </div>
                    </div>

                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-2" for="name">Name:</label>
                        <div class="col-sm-5">          
                            <input type="text" class="form-control" name="name" placeholder="Enter provider name" required>
                        </div>
                    </div>

                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-2" for="type">Type:</label>
                        <div class="col-sm-5">          
                            <select class="form-control" name="type" required>
                                <option value="">--Select Type--</option>
                                <option value="1">Data Collector</option>
                                <option value="2">HA</option>
                                <option value="3">FWA</option>
                                <option value="10">FPI</option>
                                <option value="11">AHI</option>
                                <option value="12">HI</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-2" for="phone">Phone:</label>
                        <div class="col-sm-5">          
                            <input type="text" class="form-control" name="phone" placeholder="Enter phone number" required>
                        </div>
                    </div>


                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-2" for="joinDate">Join Date:</label>
                        <div class="col-sm-5">          
                            <input type="text" class="form-control datepicker"  id="joinDate" class="form-control" placeholder="dd/mm/yyyy" name="joinDate"/>
                        </div>
                    </div>

                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-2" for="superviserCode">Superviser Code:</label>
                        <div class="col-sm-5">          
                            <input type="text" class="form-control" name="superviserCode" placeholder="Enter superviser code">
                        </div>
                    </div>

                    <div class="form-group form-group-sm">        
                        <div class="col-sm-offset-2 col-sm-2">
                            <button type="submit" class="btn btn-flat btn-primary btn-sm" >Submit</button>
                        </div>

                        <div class="col-sm-offset-1">
                            <button type="reset" name="reset" class="btn btn-flat btn-primary btn-sm" >Reset</button>
                        </div>

                    </div>-->
                </form>

            </div>
        </div>
    </div>
</div>

<!-------------------------------------------------------------------------Set Unit Modal--------------------------------------------------------------------------->
<div class="modal fade" id="modalSetUnitWard" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header label-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="setUnitWardModalTitle"><b><i class="fa fa-wrench" aria-hidden="true"></i>    &nbsp; Set Unit/Ward</b></h4>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-hover table-striped ">
                        <thead class="modal-table-header" id="modalSetUnitWardTableHead">
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
        </div>
    </div>
</div>

<!-----------------------------------------------------------------------------Set Round Modal-------------------------------------------------------------------------------->
<div class="modal fade" id="modalRound" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header label-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel"><b><i class="fa fa-circle-o-notch" aria-hidden="true"></i>    &nbsp; Set Round</b></h4>
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
            <div class="modal-header label-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="assignModalTitle"><b>    &nbsp; Assign Area</b></h4>
            </div>

            <div class="modal-body">
                
                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-2">
                        <select class="form-control input-sm" name="unionForAssign" id="unionForAssign">
                            <option value="">- Select Union -</option>
                        </select>
                    </div>
                    <div class="col-md-7">
                        <label for="union">( To assign another union, change union from Dropdown )</label>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover table-striped">
                        <thead class="modal-table-header">
                            <tr>
                                <th>#</th>
                                <th>Mouza</th>
                                <th>Village</th>
                                <th>Assign</th>
                            </tr>
                        </thead>
                        <tbody id="modalTableBody">
                        </tbody>
                    </table>
                </div>
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
        <h4 class="modal-title"><b><i class="fa fa-user-times" aria-hidden="true"></i><span>    &nbsp; Are you sure ?</span></b></h4>
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
          <div class="modal-header label-warning">
              <button type="button" class="close" data-dismiss="modal"><b>&times;</b></button>
              <h4 class="modal-title"><b><i class="fa fa-pencil-square-o" aria-hidden="true"></i><span></b>    &nbsp; Update Provider - <b  id="nameAsEditProvTitle"></b></span></h4>
          </div>

          <div class="modal-body">
                <input type="hidden" id="editProviderID">
                <div class="row">
                    <div class="col-md-2">
                        <h4 for="district">District</h4>
                    </div>
                    <div class="col-md-4">
                        <select class="form-control" id='editDistrict'>
                            <option value="0">All</option>
                        </select>
                    </div>

                    <div class="col-md-2">
                        Upazila
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
                        Union
                    </div>
                    <div class="col-md-4">
                        <select class="form-control" id='editUnion'>
                            <option value="0">All</option>
                        </select>
                    </div>

                    <div class="col-md-2">
                        Provider Type
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
                        Provider Code
                    </div>
                    <div class="col-md-4">
                        <input type="number" class="form-control" placeholder="Enter Provider Code" id="editProviderCode">
                    </div>

                    <div class="col-md-2">
                        Name
                    </div>
                    <div class="col-md-4">
                        <input class="form-control" placeholder="Enter Name" id="editProviderName">
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col-md-2">
                        Password
                    </div>
                    <div class="col-md-4">
                        <input type="password" class="form-control" placeholder="Enter Password" id="editProviderPassword">
                    </div>

                    <div class="col-md-2">
                        Mobile
                    </div>
                    <div class="col-md-4">
                        <input type="number" class="form-control" placeholder="Enter Mobile No." id="editProviderMobile">
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col-md-2">
                        <label for="editProviderSupervisor">Supervisor</label>
                    </div>
                    <div class="col-md-4">
                        <input type="number" class="form-control" placeholder="Enter Supervisor Code" id="editProviderSupervisor">
                    </div>

                    <div class="col-md-2">
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <button type="button"  id="btnConfirmToEdit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Updating" class="btn btn-flat btn-warning"><b><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Update</b></button>&nbsp;&nbsp;
                        </div>
                    </div>
                </div>
                
                
                
                
<!--                <div class="form-group">
                    <label>District</label>
                    <select class="form-control" id='editDistrict'>
                        <option value="0">All</option>
                    </select>
                </div>
              
                <div class="form-group">
                    <label>Upazila</label>
                    <select class="form-control" id='editUpazila'>
                        <option value="0">All</option>
                    </select>
                </div>-->
              
<!--                <div class="form-group">
                    <label>Union</label>
                    <select class="form-control" id='editUnion'>
                        <option value="0">All</option>
                    </select>
                </div>
              
              
                <div class="form-group">
                    <label>Provider Type</label>
                    <select class="form-control" id='editProviderType'>
                        <option value="0">All</option>
                    </select>
                </div>-->
              
<!--                <div class="form-group">
                    <label>Provider Code</label>
                    <input type="number" class="form-control" placeholder="Enter Provider Code" id="editProviderCode">
                </div>
                
                <div class="form-group">
                    <label>Name</label>
                    <input class="form-control" placeholder="Enter Name" id="editProviderName">
                </div>
                
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" class="form-control" placeholder="Enter Password" id="editProviderPassword">
                </div>
                
                <div class="form-group">
                    <label>Mobile</label>
                    <input type="number" class="form-control" placeholder="Enter Mobile No." id="editProviderMobile">
                </div>
                
                <div class="form-group">
                    <label>Supervisor</label>
                    <input type="number" class="form-control" placeholder="Enter Supervisor Code" id="editProviderSupervisor">
                </div>

                <div class="form-group">
                    <button type="button"  id="btnConfirmToEdit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Updating" class="btn btn-flat btn-warning">Update</button>&nbsp;&nbsp;
                </div>-->


          </div>
            
            
        <div class="modal-footer">
            <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Close</button>
        </div>
        </div>

      </div>
</div>





<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>