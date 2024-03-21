<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/area_dropdown_controls.js"></script>

<script>

    function btnAddProviderClickHandler() {
        if (!upazilaAndUnionSelected()) {
            return;
        }
        $("#modalAddProvider").modal('show');
    }

    function upazilaAndUnionSelected() {
        var upazilaId = $("select#upazila").val();
        var unionId = $("select#union").val();
        if (upazilaId.length === 0 || unionId.length === 0) {
            if (upazilaId.length === 0 && unionId.length === 0) {
                toastr["error"]("<h4><b>Select a specific Upazila and Union</b></h4>");

            } else if (upazilaId.length === 0) {
                toastr["error"]("<h4><b>Select a specific Upazila</b></h4>");

            } else if (unionId.length === 0) {
                toastr["error"]("<h4><b>Select a specific Union</b></h4>");
            }
            return false;
        }
        return true;
    }

    function changeSettings(id) {

        var btnId = "#btn" + id;
        var btn = $(btnId);
        var setting = btn.data("setting");

        $.ajax({
            url: "ProviderManagement?action=updateSettings",
            data: {
                providerId: id,
                settingId: setting
            },
            type: 'POST',
            success: function (result) {
                if (result === "1") { //change only if one row is affected
                    if (setting === 1) {
                        btn.data('setting', 2);

                        btn.attr('class', 'btn btn-sm');

                    } else if (setting === 2) {
                        btn.data('setting', 1);

                        btn.attr('class', 'btn btn-success btn-sm');
                    }
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error while updating device settings");
            }
        });
    }

    function btnAddAreaClickHandler(btnId, providerId, typeId, mouzaId, villageId) {


        $.ajax({
            url: "ProviderManagement?action=addAreaToProvider",
            data: {
                //  divisonId: 30,
                districtId: $("select#district").val(),
                upazilaId: $("select#upazila").val(),
                unionId: $("select#union").val(),
                mouzaId: mouzaId,
                villageId: villageId,
                providerId: providerId,
                typeId: typeId
            },
            type: 'POST',
            success: function (result) {
                if (result === "1") { //change only if one row is affected
                    loadModalData(providerId, typeId);
                    //  alert("Area Assigned");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error while adding area to provider");
            }
        });
    }


    function btnRemoveAreaClickHandler(btnId, providerId, typeId, mouzaId, villageId) {

        $.ajax({
            url: "ProviderManagement?action=removeAreaFromProvider",
            data: {
                districtId: $("select#district").val(),
                upazilaId: $("select#upazila").val(),
                unionId: $("select#union").val(),
                mouzaId: mouzaId,
                villageId: villageId,
                providerId: providerId,
                typeId: typeId

            },
            type: 'POST',
            success: function (result) {
                if (result === "1") { //change only if one row is affected
                    loadModalData(providerId, typeId);
                    // alert("Area Removed");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error while removing area to provider");
            }
        });
    }


    function loadModalData(provcode, provtype) {
        $('#modalTableBody').empty();
        $.ajax({
            url: "ProviderManagement?action=getMouzaData",
            data: {
                districtId: $("select#district").val(),
                upazilaId: $("select#upazila").val(),
                unionId: $("select#union").val(),
                provcode: provcode,
                provtype: provtype
            },
            type: 'POST',
            success: function (result) {
                var json = JSON.parse(result);

                for (var i = 0; i < json.length; i++) {
                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
                            + "<td class='text-left'> [" + json[i].mouzaid + "] " + json[i].mouzanameeng + "</td>"
                            + "<td class='text-left'> [" + json[i].villageid + "] " + json[i].villagenameeng + "</td>";
                    if (json[i].provtype === "null" && json[i].provcode === "null") {
                        parsedData += "<td><button id='btnAddArea" + (i + 1) + "' onClick='btnAddAreaClickHandler(" + (i + 1) + ", " + provcode + "," + provtype + "," + json[i].mouzaid + "," + json[i].villageid + ")'  class='btn btn-block btn-flat btn-default btn-xs'>Add</button></td></tr>";

                    } else {
                        parsedData += "<td><button id='btnAddArea" + (i + 1) + "' onClick='btnRemoveAreaClickHandler(" + (i + 1) + ", " + provcode + "," + provtype + "," + json[i].mouzaid + "," + json[i].villageid + ")'  class='btn btn-block btn-flat btn-success btn-xs'>Remove</button></td></tr>";
                    }
                    $('#modalTableBody').append(parsedData);
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error while fetching data");
            }
        });
    }


    function changeUnit(selectedOption, mouzaId, villageId) {

        $.ajax({
            url: "ProviderManagement?action=updateUnit",
            data: {
                districtId: $("select#district").val(),
                upazilaId: $("select#upazila").val(),
                unionId: $("select#union").val(),
                mouzaId: mouzaId,
                villageId: villageId,
                unitId: selectedOption.value
            },
            type: 'POST',
            success: function (result) {

            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error while fetching data");
            }
        });
    }

    function changeWard(selectedOption, mouzaId, villageId) {

        $.ajax({
            url: "ProviderManagement?action=updateWard",
            data: {
                districtId: $("select#district").val(),
                upazilaId: $("select#upazila").val(),
                unionId: $("select#union").val(),
                mouzaId: mouzaId,
                villageId: villageId,
                wardId: selectedOption.value
            },
            type: 'POST',
            success: function (result) {
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error while fetching data");
            }
        });
    }



    function areaAssignClickHandler(id) {

        if (!upazilaAndUnionSelected()) {
            return;
        }

        $("#basicModal").modal('show');

        var provider = $("#btnAssign" + id).data('provider');
        $('#myModalLabel').html('Assign area to <strong>' + provider.provname + ' [' + provider.typename + ']</strong>');
        var unitOptions = '';
        $.post('ProviderManagement?action=getUnits', function (response) {
            var units = JSON.parse(response);
            for (var i = 0; i < units.length; i++) {
                unitOptions += '<option value=\"' + units[i].ucode + '\">' + units[i].uname + '</option>';
            }
        });

        $('#modalTableBody').empty();

        $.ajax({
            url: "ProviderManagement?action=getMouzaData",
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
                        parsedData += "<td><button id='btnAddArea" + (i + 1) + "' onClick='btnAddAreaClickHandler(" + (i + 1) + ", " + provider.provcode + "," + provider.provtype + "," + json[i].mouzaid + "," + json[i].villageid + ")'  class='btn btn-block btn-flat btn-default btn-xs'>Add</button></td></tr>";
                    } else {
                        parsedData += "<td><button id='btnAddArea" + (i + 1) + "' onClick='btnRemoveAreaClickHandler(" + (i + 1) + ", " + provider.provcode + "," + provider.provtype + "," + json[i].mouzaid + "," + json[i].villageid + ")'  class='btn btn-block btn-flat btn-success btn-xs'>Remove</button></td></tr>";
                    }
                    $('#modalTableBody').append(parsedData);
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error while fetching data");
            }
        });
    }

    //------------------------------------------------------------------------------Jquery  start here ---------------------------------------------------------------------
    $(document).ready(function () {
        var providerJson = null;


        //Search User===========================
        $('#search').keyup(function () {
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
                        parsedData = parsedData + '<td><button id="btn' + providerJson[i].provcode + '" onclick="changeSettings(' + providerJson[i].provcode + ')" data-setting="1" class="btn btn-flat btn-success btn-sm">' +
                                '<i class="fa fa-check fa-lg"></i></button></td>';
                    } else if (providerJson[i].devicesetting === "2") {
                        parsedData = parsedData + '<td><button id="btn' + providerJson[i].provcode + '" onclick="changeSettings(' + providerJson[i].provcode + ')" data-setting="2" class="btn btn-flat btn-sm">' +
                                '<i class="fa fa-check fa-lg"></i></button></td>';
                    }
                    var jsonStr = JSON.stringify(providerJson[i]);
                    parsedData = parsedData + '<td><button id="btnAssign' + providerJson[i].provcode + '" data-provider=\'' + jsonStr + '\' onclick="areaAssignClickHandler(' + providerJson[i].provcode + ')" class="btn btn-flat btn-success btn-sm" >' + //data-toggle="modal" data-target="#basicModal"
                            '<i class="fa fa-plus fa-lg"></i> Assign</button></td></tr>';
                    tableBody.append(parsedData);
                }
            }
        }); //Search end




        $('#showdataButton').click(function () {
            var btn = $(this).button('loading');
            var tableBody = $('#tableBody');
            tableBody.empty(); //first empty table before showing data
            Pace.track(function () {
                $.ajax({
                    url: "ProviderManagement?action=showdata",
                    data: {
                        districtId: $("select#district").val(),
                        upazilaId: $("select#upazila").val(),
                        unionId: $("select#union").val()
                    },
                    type: 'POST',
                    success: function (result) {
                        var json = JSON.parse(result) || [];
                        providerJson = json;
                        if (json.length === 0) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>No data found</b></h4>");
                        }

                        for (var i = 0; i < json.length; i++) {
                            var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                    + "<td>" + json[i].provcode + "</td>"
                                    + "<td>" + json[i].provname + "</td>"
                                    + "<td>" + json[i].provname + "</td>"
                                    + "<td>" + json[i].typename + "</td>";
                            
                            if (json[i].devicesetting === "1") {
                                parsedData = parsedData + '<td><button id="btn' + json[i].provcode + '" onclick="changeSettings(' + json[i].provcode + ')" data-setting="1" class="btn btn-flat btn-success btn-sm">' +
                                        '<i class="fa fa-check fa-lg"></i></button></td>';
                            } else if (json[i].devicesetting === "2") {
                                parsedData = parsedData + '<td><button id="btn' + json[i].provcode + '" onclick="changeSettings(' + json[i].provcode + ')" data-setting="2" class="btn btn-flat btn-sm">' +
                                        '<i class="fa fa-check fa-lg"></i></button></td>';
                            }
                            var jsonStr = JSON.stringify(json[i]);
                            parsedData = parsedData + '<td><button id="btnAssign' + json[i].provcode + '" data-provider=\'' + jsonStr + '\' onclick="areaAssignClickHandler(' + json[i].provcode + ')" class="btn btn-flat btn-success btn-sm" >' + //data-toggle="modal" data-target="#basicModal"
                                    '<i class="fa fa-plus fa-lg"></i> Assign</button></td></tr>';
                            tableBody.append(parsedData);
                        }
                        btn.button('reset');
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        btn.button('reset');
                        toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                    }
                }); //ajax end
            }); //Pace Loading end
        });



        $('#btnSetUnitWard').click(function () {

            if (!upazilaAndUnionSelected()) {
                return;
            }

            $('#modalSetUnitWard').modal('show');
            var btn = $(this).button('loading');
            var unitOptions = '<option value=""> -- </option>';
            $.post('ProviderManagement?action=getUnits', function (response) {
                var units = JSON.parse(response);
                for (var i = 0; i < units.length; i++) {
                    unitOptions += '<option value=\"' + units[i].ucode + '\">' + units[i].uname + '</option>';
                }
            });

            $('#modalSetUnitWardTableBody').empty();
            $.ajax({
                url: "ProviderManagement?action=getDataForSettingUnitWard",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: $("select#union").val()
                },
                type: 'POST',
                success: function (result) {
                    var json = JSON.parse(result);
                    for (var i = 0; i < json.length; i++) {
                        var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                + "<td> [" + json[i].mouzaid + "] " + json[i].mouzanameeng + "</td>"
                                + "<td> [" + json[i].villageid + "] " + json[i].villagenameeng + "</td>"
                                + "<td><select onchange='changeUnit(this," + json[i].mouzaid + "," + json[i].villageid + ")' id='optionUnit" + (i + 1) + "'>" + unitOptions + "</select></td>"
                                + "<td><select onchange='changeWard(this," + json[i].mouzaid + "," + json[i].villageid + ")' id='optionWard" + (i + 1) + "'> <option value=''>--</option> <option value='1'>1</option><option value='2'>2</option> <option value='3'>3</option></select></td></tr>";
                        $('#modalSetUnitWardTableBody').append(parsedData);
                        if (json[i].fwaunit !== "null") {
                            var id = "#optionUnit" + (i + 1);
                            $('' + id + '').val('' + json[i].fwaunit + '').trigger('change');
                        }
                        if (json[i].ward !== "null") {
                            var id = "#optionWard" + (i + 1);
                            $('' + id + '').val('' + json[i].ward + '').trigger('change');
                        }
                    }
                    btn.button('reset');
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    btn.button('reset');
                    toastr["error"]("<h4><b>Error while fetching data</b></h4>");
                }
            });
        });



        $("#addNewProviderForm").submit(function (e) {

            e.preventDefault();

            var postData = $(this).serializeArray();
            var formURL = $(this).attr("action");
            postData.push({name: 'districtId', value: $("select#district").val()});
            postData.push({name: 'upazilaId', value: $("select#upazila").val()});
            postData.push({name: 'unionId', value: $("select#union").val()});

            $.ajax(
                    {
                        url: formURL,
                        type: "POST",
                        data: postData,
                        success: function (result) {
                            if (result === "1") { //change only if one row is affected
                                toastr["error"]("<h4><b>Provider added successfully</b></h4>");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            toastr["error"]("<h4><b>Error while adding provider</b></h4>");
                        }
                    });
            e.preventDefault();	//STOP default action
            $('#modalAddProvider').modal('hide');
        });
    });

</script>
<%@include file="/WEB-INF/jspf/underDevelopment.jspf" %>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        Provider management
        <small>(facility)</small>
    </h1>
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
                            <label for="district">District</label>
                        </div>
                        <div class="col-md-2">
                            <select class="form-control input-sm" name="district" id="district"> </select>
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

                        <div class="col-md-2">
                            <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-primary btn-flat btn-sm btn-block" autocomplete="off">
                                Show data
                            </button>
                        </div>
                    </div><br>

                    <div class="row">
                        <div class="col-md-1">
                        </div>
                        <div class="col-md-2">
                        </div>
                        <div class="col-md-1">
                        </div>
                        <div class="col-md-2">
                        </div>
                        <div class="col-md-1">
                        </div>

                        <div class="col-md-2">
                            <button type="button" id="btnSetUnitWard" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-primary btn-flat btn-sm btn-block" autocomplete="off">
                                Set Unit/Ward
                            </button>
                        </div>

                        <div class="col-md-2">
                            <button type="button" id="btnAddProvider" onclick="btnAddProviderClickHandler()" class="btn btn-primary btn-flat btn-sm btn-block">
                                Add Provider
                            </button>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>
    <!--Table body-->

    <div class="row" id="tableContent">
        <div class="col-xs-12">
            <div class="box box-primary">

                <!--  Table top -->
                <div class="box-header">


                    <h3 class="box-title pull-center">  <span id="result">Show</span>
                        <select id="tableEntrySize">
                            <option value="0">All</option>
                            <option value="10">10</option>
                            <option value="15">15</option>
                            <option value="20">20</option>
                            <option value="25">25</option>
                            <option value="30">30</option>
                        </select>entries 
                    </h3>

                    <h3 class="box-title pull-right">   
                        <input type="text" class="form-control" placeholder="Search ...." id="search">
                    </h3>
                </div>

                <!-- table -->
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped table-hover" id="data-table">
                            <thead class="data-table">
                                <tr>
                                    <th>#</th>
                                    <th>Provider ID</th>
                                    <th onclick="short(1);" class="clickable">Provider Name <span class="pull-right"><i class="fa fa-long-arrow-down" aria-hidden="true"></i></span></th>
                                    <th>Type </th>
                                    <th>Device Settings </th>
                                    <th>Area</th>
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
                    <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-success btn-sm btn-block" autocomplete="off">
                        Show data
                    </button>
                </div>

                <div class="col-md-1">

                    <button type="button" id="btnSetUnitWard" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-success btn-sm btn-block" autocomplete="off">
                        Set Unit/Ward
                    </button>
                </div>

            </div>

            <br>

            <div class="row">
                <div class="col-md-1 col-md-offset-9">        
                    <button type="button" id="btnAddProvider" onclick="btnAddProviderClickHandler()" class="btn btn-success btn-block btn-sm">
                        Add Provider
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
                <h4 class="modal-title" id="myModalLabel"><b>    &nbsp; Add New Provider</b></h4>
            </div>
            <div class="modal-body">
                <form method="post" id="addNewProviderForm" action="ProviderManagement?action=addNewProvider" class="form-horizontal" role="form">

                    <div class="form-group form-group-sm">
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
                        <div class="col-sm-offset-2 col-sm-2">
                            <button type="submit" class="btn btn-flat btn-primary btn-sm" >Submit</button>
                        </div>

                        <div class="col-sm-offset-1">
                            <button type="reset" name="reset" class="btn btn-flat btn-primary btn-sm" >Reset</button>
                        </div>

                    </div>
                </form>

            </div>
        </div>
    </div>
</div>


<!------------------------------------------------------------------------------ Set Unit Ward Modal ------------------------------------------------------------------------------>  
<div class="modal fade" id="modalSetUnitWard" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header label-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel"><b>    &nbsp; Set Unit/Ward</b></h4>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
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

<!------------------------------------------------------------------------------   Assisgn Modal ------------------------------------------------------------------------------> 
<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header label-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel"><b>    &nbsp; Assign Area</b></h4>
            </div>

            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
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


<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>