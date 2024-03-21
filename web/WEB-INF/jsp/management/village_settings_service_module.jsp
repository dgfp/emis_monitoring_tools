<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<!--<script src="resources/js/area_dropdown_controls.js"></script>-->
<link href="resources/css/centerModal.css" rel="stylesheet" type="text/css"/>
<script src="resources/js/area_dropdown_control_by_user_Catchment_area_management.js"></script>
<style>
    .close{
        font-weight: bold;
    }
    .content .row .box {
        margin-bottom: 0px;
    }
    [class*="col"] { margin-bottom: 10px; }
    #tableContent{
        display: none;
    }
    .box-body {
        padding-bottom: 0px!important;
    }
    .dropdown-menu{
        height: 300px;
        overflow: scroll;
    }
</style>
<link rel="stylesheet" href="https://www.jquery-az.com/boots/css/bootstrap-multiselect/bootstrap-multiselect.css" type="text/css">
<script>
    function  clearData() {
        $('input[name=mouzaid]').val("");
        $('input[name=villageid]').val("");
        $('input[name=mouzaname]').val("");
        $('input[name=mouzanameeng]').val("");
        $('input[name=villagename]').val("");
        $('input[name=villagenameeng]').val("");
    }

    function btnAddVillageClickHandler() {
        if (!$.isValid())
            return;
        clearData();
        $("#modalAddVillage").modal('show');
    }

    function btnAddMouzaClickHandler() {
        if (!$.isValid())
            return;
        clearData();
        $("#modalAddMouza").modal('show');
    }

    var jsonVillage = [];
    //---------------------------------------------------------------------------------------Edit User ------------------------------------------------------------------------
    function  editVillageHandler(i) {
        if (!$.isValid())
            return;
        var data = jsonVillage[i] || {};
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
            var xhr = $.ajax({url: "village-settings?action=deleteVillage", data: postData, type: 'POST'});
            xhr.then(function (result) {
                btn.button('reset');
                var i = +result;
                var data = [['error', "Somthing went wrong"], ['success', "Village delete sucessfully"]];
                toastr[data[i][0]]("<h4><b>" + data[i][1] + "</b></h4>");
                $('#deleteVillage').modal('hide');
                $('#btnShowVillages').trigger('click');
            }, console.log);
        });
    }


    $(function () {
        var populatedUnionTable = null;
        var rowUnion = null;
        var rowUnit = null;
        $('#btnShowVillages').click(function () {
            $("#tableContent").hide();
            $("#data-table-union-row").addClass("hide");
            $("#data-table-unit-row").addClass("hide");
            $("#transparentTextForBlank").show();


            if (!$.isValid())
                return;
            var btn = $(this).button('loading');
            $('#modalSetUnitWardTableBody').empty();
            $.ajax({
                url: "village-settings?action=showVillage",
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
                                + "<td> [" + json[i].villageid + "] " + json[i].villagenameeng + "</td>"
                                + "<td> <a class='btn btn-flat btn-warning btn-xs bold' onclick='editVillageHandler(" + i + ")'><i class='fa fa-pencil' aria-hidden='true'></i> Update</a>   <a class='btn btn-flat btn-danger btn-xs bold' onclick='deleteVillageHandler(" + i + ")'><i class='fa fa-trash' aria-hidden='true'></i> Delete</a></td></tr>";
                        $('#modalSetUnitWardTableBody').append(parsedData);
                    }
                    btn.button('reset');
                    $("#transparentTextForBlank").hide();
                    $("#tableContent").fadeIn();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    btn.button('reset');
                    alert("Error while fetching data");
                }
            });
        });


        //Add Village Submit
        $("#modalAddVillageForm").submit(function (e) {

            e.preventDefault();
            var postData = $(this).serializeArray();
            var formURL = $(this).attr("action");

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
                    var data = [['error', "Already  exists"], ['success', "Village Added"]];
                    toastr[data[i][0]]("<h4><b>" + data[i][1] + "</b></h4>");
                    $('.modal').modal('hide');
                    $('#btnShowVillages').trigger('click');
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
            var formURL = $(this).attr("action");

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


        //modalMouzaForm
        $("#modalMouzaForm").submit(function (e) {
            e.preventDefault();

            var postData = $(this).serializeArray();
            var formURL = $(this).attr("action");

            postData.push({name: 'districtid', value: $("select#district").val()});
            postData.push({name: 'upazilaid', value: $("select#upazila").val()});
            postData.push({name: 'unionid', value: $("select#union").val()});
            var btn = $(this).button('loading');
            $.ajax({
                url: formURL,
                type: "POST",
                data: postData,
                success: function (result) {
                    var i = +result;
                    btn.button('reset');
                    var data = [['error', "Already  exists"], ['success', "Mouza added"]];
                    toastr[data[i][0]]("<h4><b>" + data[i][1] + "</b></h4>");
                    $('.modal').modal('hide');
                    //$('#btnShowVillages').trigger('click');
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr["error"]("<h4><b>Error while adding mouza</b></h4>");
                }
            });

        });

//        ADD, VIEW UNION 

        function showAddUnionModal(d) {
            if (!UTIL.validateGeneral.validateUpazila("select#division,select#district,select#upazila"))
                return false;
            $("#modalAddUnion").modal({'show': true});
        }

        function generateUnions(e) {

            var zillaid = $("select#district").val();
            var upazilaid = $("select#upazila").val();
            var selectTag = $("#reporting_union_id");
            var unions = $('#multi-select-demo');
            $.get('UnionJsonProvider', {
                upazilaId: upazilaid, zilaId: zillaid
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

        function submitUnion() {
            var f = $('#reportingunionfpi');
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
            var data = $.app.pairs('#reportingunionfpi');
            var mUnion = $("#multiple_union").val();
            data.unionids = mUnion ? $("#multiple_union").val().toString() : null;
            delete data['multi-select-union'];
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
                });
            }
        }
        ;

        var isNewUnion = false;

        $("#reporting_union_id").change(function () {
            UTIL.clearNewUnion();
            if (this.value == "99") {
                isNewUnion = true;
                $(".display").fadeIn();
            } else {
                isNewUnion = false;
                $(".display").fadeOut();
            }
        });


        function renderUnionTable(data) {
            var columns = [
                {data: "zillanameeng", title: 'District'},
                {data: "upazilanameeng", title: 'Upazila'},
                {data: "unionnameeng", title: 'Union name (ENG)'},
                {data: "unionname", title: 'Union name (BAN)'},
                {data: function (d) {
                        return '<a class="btn btn-flat btn-warning btn-xs bold"><i class="fa fa-pencil" aria-hidden="true"></i> Update</a>';
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


        function viewUnion() {
            if (!UTIL.validateGeneral.validateUpazila("select#division,select#district,select#upazila"))
                return;
            $("#data-table-union-row").removeClass("hide");
            $("#data-table-unit-row").addClass("hide");
//            $("#data-table-union-row").style({
//                display: "block"
//            });
            $("#tableContent").hide();
            $("#transparentTextForBlank").hide();
            var zillaid = $("select#district").val();
            var upazilaid = $("select#upazila").val();
            var data = JSON.stringify({"zillaid": zillaid, "upazilaid": upazilaid});
            UTIL.request("report-geo-info?action=getReportingUnion", {data: data}, "POST").then(function (resp) {
                renderUnionTable(resp["reporting_union"]);
            });
        }
        //View Union
        $('#btnShowUnion').on('click', viewUnion);
        $("#modalAddUnion").on('show.bs.modal', generateUnions);
        $("#modalAddUnion").on('hide.bs.modal', function () {
            rowUnion = null;
            $("#request_from").val("");
        });
        $("#btnShowAddUnionModal").on('click', showAddUnionModal);
        $("#submitButtonUnion").on('click', submitUnion);
        $("#data-table-union tbody").on('click', 'a', function () {
            var tr = $(this).closest('tr');
            rowUnion = populatedUnionTable.row(tr).data();
            showAddUnionModal();
        });

//        REPORTING UNIT - ADD/VIEW
        function showAddReportingUnitModal(d) {
            if (!$.isValid())
                return false;
            var r = generateReportingUnit();
            var hasData = !(d instanceof $.Event)

            r.then(function (resp) {
                if (resp == "success") {
                    $("#modalAddReportingUnit").modal({'show': true});
                    if (hasData) {
                        rowUnit = d;
                        console.log(rowUnit);
                        $("#submitButtonReportingUnit").addClass('hide');
                        $("#updateButtonReportingUnit").removeClass('hide');
                        $('#reporting_union_id_for_unit').val(d["unionid"]);
                        $('#reportingunitfwa #unit').val(d["unit"]);

                        $('#reporting_union_id_for_unit').attr('disabled', 'disabled');

                        $('#reportingunitfwa #unit').attr('disabled', 'disabled');
                        console.log(d);
                        var villageIds = d["villageid"].split(",");
                        var vMultiSelect = $.map(villageIds, function (item) {
                            return item;
                        });
                        console.log(vMultiSelect);
                        generateVillage(vMultiSelect);
                    } else if (!hasData) {
                        rowUnit = null;
                        $("#submitButtonReportingUnit").removeClass('hide');
                        $("#updateButtonReportingUnit").addClass('hide');

                        $('#reporting_union_id_for_unit').removeAttr('disabled');
                        $('#reportingunitfwa #unit').removeAttr('disabled');
                    }
                }
            });
        }
        ;

        function generateReportingUnit() {
            var dfd = $.Deferred();
            var zillaid = $("select#district").val();
            var upazilaid = $("select#upazila").val();
            var unionid = $("select#union").val();
            $.when(UTIL.request("UnionJsonProviderTest", {upazilaId: upazilaid, zilaId: zillaid}, "GET")
                    , UTIL.request("all-unit-josn-provider", "", "POST")).done(function (r1, r2) {
                UTIL.generateReportingUnion(r1, "", "#reporting_union_id_for_unit");
                UTIL.generateUnit(r2, "", "#reportingunitfwa #unit");
                dfd.resolve("success");
            }, function (error) {
                dfd.reject("Failure");
            });
            return dfd.promise();
//            UTIL.request("UnionJsonProviderTest", {upazilaId: upazilaid, zilaId: zillaid}, "GET").then(function (resp) {
//                UTIL.generateReportingUnion(resp, "", "#reporting_union_id_for_unit");
//            });
//            UTIL.request("all-unit-josn-provider", "", "POST").then(function (resp) {
//                UTIL.generateUnit(resp, "", "#reportingunitfwa #unit");
//            });
        }
        ;

        function generateVillage(d) {
            var zillaid = $("select#district").val();
            var upazilaid = $("select#upazila").val();
            var unionid = $("select#reporting_union_id_for_unit").val();
            UTIL.getVillage(zillaid, upazilaid, unionid, "", 'multi-select-village', true).then(function (response) {
//                $('#multi-select-village-container').html(response);
//                $('#multi-select-village-container>select').multiselect();

                var elementContainer = $('#multi-select-village-container');
                var elementSelect = $('#multi-select-village-container>select');
                elementContainer.html(response);
                $('#multi-select-village-container>select').multiselect();
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

        function submitReportingUnit() {
            var form = $('#reportingunitfwa');
            var data = UTIL.serializeAllArray('#reportingunitfwa');//form.serializeArray();
            var formInput = $('#reportingunitfwa :input[name]');
            var zillaid = $("select#district").val();
            var upazilaid = $("select#upazila").val();
            var validate = UTIL.validateReportingGeo.validateFWAForm(data, formInput);
            if (validate) {
//                UTIL.request("report-geo-info?action=getFPIAssignment", {})
                var payload = $.app.pairs('#reportingunitfwa');
                var villageList = $('#reportingunitfwa #multi-select-village-container select option:selected');
                var villageListArr = [];
                $.each(villageList, function (i, e) {
                    var v = $(e).attr('value');
                    villageListArr.push(v);
                });
                payload["reporting_unionid"] = payload["reporting_union_id_for_unit"];
                delete payload['multi-select-village'];
                delete payload["reporting_union_id_for_unit"];
                payload["zillaid"] = zillaid;
                payload["upazilaid"] = upazilaid;
                payload['villages'] = villageListArr;
                payload["dboperationstatus"] = 0;
                console.log(payload);
                var p = JSON.stringify(payload);
                UTIL.request("report-geo-info?action=setUnitDetails", {data: p}, "POST").then(function (response) {
                    alert(response.message);
                });
            } else {
                alert("Fill up all field");
            }
        }
        ;

        function updateReportingUnit() {
            console.log(rowUnit);
            var data = UTIL.serializeAllArray('#reportingunitfwa');
            var formInput = $('#reportingunitfwa :input[name]');
            var validate = UTIL.validateReportingGeo.validateFWAForm(data, formInput);
            if (validate) {
                var villageList = $('#reportingunitfwa #multi-select-village-container select option:selected');
                var villageListArr = [];
                $.each(villageList, function (i, e) {
                    var v = $(e).attr('value');
                    villageListArr.push(v);
                });
                rowUnit["villages"] = villageListArr;
                rowUnit["dboperationstatus"] = 1;
                var payload = JSON.stringify(rowUnit)
                UTIL.request("report-geo-info?action=setUnitDetails", {data: payload}, "POST").then(function (response) {
                    alert(response.message);
                });
            } else {
                alert("Fill up all field");
            }
        }
        ;

        function renderUnitDetailsTable(data) {

            var columns = [
                {data: "zillanameeng", title: 'District'},
                {data: "upazilanameeng", title: 'Upazila'},
                {data: "unionnameeng", title: 'Union name (ENG)'},
                {data: "fwaunitlabel", title: 'Unit'},
                {data: "mouzaid", title: 'Mouza'},
                {data: "villagename", title: 'Village Name'},
                {data: function (d) {
                        return '<a class="btn-unit-update btn btn-flat btn-warning btn-xs bold"><i class="fa fa-pencil" aria-hidden="true"></i> Update</a>';
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
                "bRetrieve": true
            };
            var rt = new UTIL.renderingTable('#data-table-unit', options);
            rt.createDataTable();
            console.log(rt);
            $("#transparentTextForBlank").hide();
//            $('#data-table-unit').dt(options);
        }
        ;

        function viewReportingUnitTable() {
            if (!UTIL.validateGeneral.validateUpazila("select#division,select#district,select#upazila"))
                return;
            $("#data-table-union-row").addClass("hide");
            $("#tableContent").hide();
            $("#transparentTextForBlank").hide();

            UTIL.request("report-geo-info?action=getUnitDetails", "", "POST").then(function (resp) {
                $("#data-table-unit-row").removeClass('hide');
                renderUnitDetailsTable(resp["unit_details"]);
            })
        }
        ;

        $('#btnShowAddReportingUnitModal').on('click', showAddReportingUnitModal);
//        $("#modalAddReportingUnit").on("show.bs.modal", {'eventCustom': "HHH"}, function (event) {
//            console.log($(this), event, $(event["relatedTarget"]));
//            generateReportingUnit();
//        });
        $("#submitButtonReportingUnit").on("click", submitReportingUnit);
        $("#updateButtonReportingUnit").on("click", updateReportingUnit);
        $("#btnShowReportingUnit").on("click", viewReportingUnitTable);
        //GENERATE VILLAGE BASED ON REPORTING UNION ID
        $('#reporting_union_id_for_unit').on('change', generateVillage);
        $(document).on('click', '#data-table-unit tbody a', function () {
            console.log(this);
            var rt = new UTIL.renderingTable('#data-table-unit');
            var dt = rt.getDataTable();
            var tr = $(this).closest('tr');
            var rows = dt.row(tr).data();
            showAddReportingUnitModal(rows);
        });
    });



</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        Catchment area management
    </h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <div class="row">
        <div class="col-md-12">
            <div class="box box-primary">
                <!--                <div class="box-header with-border">
                                    <div class="box-tools pull-right" style="margin-top: -10px;">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                        </button>
                                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                                    </div>
                                </div>-->
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <label for="division">Division</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" tabindex="-1" aria-hidden="true" name="division" id="division">
                                <option selected="selected">- Select Division -</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-xs-2">
                            <label for="district">District</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" tabindex="-1" aria-hidden="true" name="district" id="district">
                                <option value="">- Select district -</option>
                            </select>
                        </div>

                        <div class="col-md-1  col-xs-2">
                            <label for="upazila">Upazila</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" tabindex="-1" aria-hidden="true" name="upazila" id="upazila">
                                <option value="">- Select upazila -</option>
                            </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="union">Union</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" tabindex="-1" aria-hidden="true" name="union" id="union">
                                <option value="">- Select union -</option>
                            </select>
                        </div>

                        <!--                                                <div class="col-md-2 col-xs-4">
                                                                            <button type="button" id="btnShowVillages" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-sm btn-block" autocomplete="off">
                                                                                <b><i class="fa fa-home"></i> View Villages</b>
                                                                            </button>
                                                                        </div>-->
                    </div>
                    <div class="row">
<!--                        <div class="col-md-2 col-md-offset-1 col-xs-4 col-xs-offset-2">
                            <button type="button" id="btnShowUnion" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off">
                                <i class="fa fa-home"></i> &nbsp;View union
                            </button>
                        </div>
                        <div class="col-md-2 col-md-offset-1 col-xs-4 col-xs-offset-2">
                            <button type="button" id="btnShowReportingUnit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off">
                                <i class="fa fa-home"></i> &nbsp;View unit
                            </button>
                        </div>-->
                        <div class="col-md-2 col-md-offset-1 col-xs-4 col-xs-offset-2">
                            <button type="button" id="btnShowVillages" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off">
                                <i class="fa fa-home"></i> &nbsp;View village
                            </button>
                        </div>
                    </div>
                    <div class="row">

<!--                        <div class="col-md-2 col-md-offset-1 col-xs-4 col-xs-offset-2">
                            <button type="button" id="btnShowAddUnionModal" class="btn btn-flat btn-success btn-block btn-sm">
                                <b><i class="fa fa-home"></i> &nbsp;Add  Union</b>
                            </button>
                        </div>
                        <div class="col-md-2 col-md-offset-1 col-xs-4 col-xs-offset-2">
                            <button type="button" id="btnShowAddReportingUnitModal" class="btn btn-flat btn-success btn-block btn-sm">
                                <b><i class="fa fa-home"></i> &nbsp;Add  Unit</b>
                            </button>
                        </div>-->
                        <div class="col-md-2 col-md-offset-1 col-xs-4 col-xs-offset-2">
                            <button type="button" id="btnAddVillage" onclick="btnAddVillageClickHandler()" class="btn btn-flat btn-success btn-block btn-sm">
                                <b><i class="fa fa-home"></i> &nbsp;Add  village</b>
                            </button>
                        </div>

                        <div class="col-md-2 col-md-offset-1 col-xs-4 col-xs-offset-8">
                            <button type="button" id="btnAddMouza" onclick="btnAddMouzaClickHandler()" class="btn btn-flat btn-success btn-block btn-sm">
                                <b><i class="fa fa-home"></i> &nbsp;Add  mouza</b>
                            </button>
                        </div>

                    </div>
                    <!--                    <div class="row">
                                            <div class="col-md-1 col-xs-2">
                                            </div>
                                            <div class="col-md-2 col-xs-4">
                                            </div>
                                            <div class="col-md-1 col-xs-2">
                                            </div>
                                            <div class="col-md-2 col-xs-4">
                                            </div>
                                            <div class="col-md-1 col-xs-2">
                                            </div>
                    
                                            <div class="col-md-2 col-md-offset-7">
                                                <button type="button" id="btnAddVillage" onclick="btnAddVillageClickHandler()" class="btn btn-flat btn-primary btn-block btn-sm">
                                                    <b><i class="fa fa-home"></i> Add  Village</b>
                                                </button>
                                            </div>
                    
                                            <div class="col-md-2 col-xs-4">
                                                <button type="button" id="btnAddMouza" onclick="btnAddMouzaClickHandler()" class="btn btn-flat btn-primary btn-block btn-sm">
                                                    <b><i class="fa fa-home"></i> Add  Mouza</b>
                                                </button>
                                            </div>
                                        </div>-->


                </div>
            </div>
        </div>
    </div>
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
                <!-- table -->
                <div class="box-body">
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
                            <tbody id="modalSetUnitWardTableBody">
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
    <div class="row hide" id="data-table-union-row">
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
                    <h3>Reporting Union List (DGFP)</h3>
                    <div class="table-responsive- no-padding">
                        <table id="data-table-union" class="table table-bordered table-striped">
                            <thead id="tableHeader">
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

    <!--------------------------------------------------------------Unit Table------------------------------------------------------------------>
    <div class="row hide" id="data-table-unit-row">
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
                    <h3>Reporting Unit List (DGFP)</h3>
                    <div class="table-responsive- no-padding">
                        <table id="data-table-unit" class="table table-bordered table-striped">
                            <thead id="tableHeader">
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
<!--------------------------------------------------------------Add Union------------------------------------------------------------------>
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
                            <form role="form" id="reportingunionfpi">
                                <div class="row setup-content" id="step-reporting-union">
                                    <div class="col-md-12">
                                        <h3 class="center">Reporting Union (FPI)</h3>
                                        <div class="row">
                                            <div class="col-md-4 col-xs-4">
                                                <label>Reporting union</label>
                                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="reporting_union_id" id="reporting_union_id" >
                                                    <option value="">- Select Union -</option>
                                                </select>
                                            </div>

                                            <div class="col-md-4 col-xs-4 display">
                                                <label>Union name (English)</label>
                                                <input type="text" name="unionnameeng" id="unionnameeng" class="form-control">
                                            </div>
                                            <div class="col-md-4 col-xs-4 display">
                                                <label>Union name (Bangla)</label>
                                                <input type="text" name="unionname" id="unionname" class="form-control">
                                            </div>
                                            <div class="col-md-4 col-xs-4">
                                                <label>Union (BBS)</label>
                                                <div id="multi-select-union-container">
                                                    <select class="form-control" id="multi-select-union1" multiple="multiple" name="unionids">
                                                    </select>
                                                </div>
                                            </div>
                                        </div><br/>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="col-md-4 col-xs-4">
                    <label>&nbsp;</label>
                    <button type="button" id="submitButtonUnion" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-success btn-block btn-sm bold" autocomplete="off">
                        <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Add Union
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<!--------------------------------------------------------------Add Unit------------------------------------------------------------------>
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
                            <form role="form" id="reportingunitfwa">

                                <h3 class="center">Reporting Unit (FWA)</h3>
                                <div class="row">
                                    <div class="col-md-4 col-xs-4">
                                        <label>Reporting union</label>
                                        <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="reporting_union_id_for_unit" id="reporting_union_id_for_unit" >
                                            <option value="">- Select Union -</option>
                                        </select>
                                    </div>

                                    <div class="col-md-4 col-xs-4">
                                        <label>Reporting unit</label>
                                        <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="unit" id="unit" >
                                            <option value="">- Select Unit -</option>
                                            <option value="">Unit 1</option>
                                            <option value="">Unit 2</option>
                                            <option value="">Unit 3</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 col-xs-4">
                                        <label>Villages</label>
                                        <div id="multi-select-village-container">
                                            <select class="form-control" id="multi-select-village" multiple="multiple" name="villages">
                                                <option value="13">Village 1</option>
                                                <option value="15">Village 2</option>
                                                <option value="23">Village 3</option>
                                                <option value="31">Village 4</option>
                                                <option value="34">Village 5</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <br/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="col-md-4 col-xs-4">
                    <label>&nbsp;</label>
                    <button type="button" id="submitButtonReportingUnit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-success btn-block btn-sm bold hide" autocomplete="off">
                        <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Add Unit
                    </button>
                    <button type="button" id="updateButtonReportingUnit" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-success btn-block btn-sm bold hide" autocomplete="off">
                        <i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp; Update Unit
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!--------------------------------------------------------------Add Village------------------------------------------------------------------>
<div class="modal fade" id="modalAddVillage" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="post" id="modalAddVillageForm" action="village-settings?action=addVillage" class="form-horizontal" role="form">
                <div class="modal-header">
                    <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                    <h4 class="modal-title bold" id="myModalLabel">Add new village</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-4" for="mouzaid">Mouza ID: </label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control check-pos-num" name="mouzaid" placeholder="মৌজার আইডী লিখুন" required>
                        </div>
                    </div>

                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-4" for="villageid">Village ID: </label>
                        <div class="col-sm-5">          
                            <input type="text" class="form-control check-pos-num" name="villageid" placeholder="গ্রামের আইডী লিখুন" required>
                        </div>
                    </div>

                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-4" for="villagename">Village name (Bangla): </label>
                        <div class="col-sm-5">          
                            <input type="text" class="form-control" name="villagename" placeholder="গ্রামের নাম বাংলায় লিখুন" required>
                        </div>
                    </div>

                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-4" for="villagenameeng">Village name (English): </label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control check-name" name="villagenameeng" placeholder="গ্রামের নাম ইংরেজিতে লিখুন" required>
                        </div>
                    </div>

                    <!--                    <div class="form-group form-group-sm">
                                            <div class="col-sm-offset-4 col-sm-2">
                                                <button type="submit" class="btn btn-primary btn-sm btn-flat" >Submit</button>
                                            </div>
                    
                                            <div class="col-sm-offset-1">
                                                <button type="reset" name="reset" class="btn btn-primary btn-sm btn-flat">Reset</button>
                                            </div>
                                        </div>-->

                </div>
                <div class="modal-footer">
                    <button type="reset" name="reset" class="btn btn-flat btn-default btn-md bold">Reset</button>
                    <button type="submit" class="btn btn-flat btn-success btn-md bold">Submit</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-----------------------------------------------edit village----------------------------------------->
<div class="modal fade" id="modalEditVillage" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <form method="post" id="modalEditVillageForm" action="village-settings?action=editVillage" class="form-horizontal" role="form">
                <div class="modal-header">
                    <button type="button" class="close bold" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                    <h4 class="modal-title bold">Update village/ mouza</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group form-group-sm">
                        <label class="col-sm-2" for="mouzaid">Mouza id:</label>
                        <div class="col-sm-10">          
                            <input type="text" class="form-control" name="mouzaid" placeholder="মৌজার আইডী লিখুন" required readonly>
                        </div>
                    </div>
                    <div class="form-group form-group-sm">

                        <label class="control-label col-sm-2" for="mouzaname">মৌজার নাম:</label>
                        <div class="col-sm-4">          
                            <input type="text" class="form-control" name="mouzaname" placeholder="মৌজার নাম বাংলায় লিখুন" required>
                        </div>
                        <label class="control-label col-sm-2" for="mouzaameeng">Mouza name:</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control check-name" name="mouzanameeng" placeholder="মৌজার নাম ইংরেজিতে লিখুন" required>
                        </div>
                    </div>
                    <hr/>
                    <div class="form-group form-group-sm">
                        <label class="col-sm-2" for="villageid">Village ID:</label>
                        <div class="col-sm-10">          
                            <input type="text" class="form-control" name="villageid" placeholder="গ্রামের আইডী লিখুন" required readonly>
                        </div>
                    </div>
                    <div class="form-group form-group-sm">

                        <label class="control-label col-sm-2" for="villagename">গ্রামের নাম:</label>
                        <div class="col-sm-4">          
                            <input type="text" class="form-control" name="villagename" placeholder="গ্রামের নাম বাংলায় লিখুন" required>
                        </div>
                        <label class="control-label col-sm-2" for="villagenameeng">Village name:</label>
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
                    <button type="button" class="btn btn-flat btn-default btn-md bold" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-flat btn-warning btn-md bold">Update</button>
                </div>
            </form>
        </div>
    </div>
</div>


<!---------------------------------------------------------------------------------------------------Add Mouza------------------------------------------------------------->
<div class="modal fade" id="modalAddMouza" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="post" id="modalMouzaForm" action="village-settings?action=addMouza" class="form-horizontal" role="form">
                <div class="modal-header">
                    <button type="button" class="close bold" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></button>
                    <h4 class="modal-title bold" id="myModalLabel">Add new mouza</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-4" for="mouzaid">Mouza ID: </label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control check-pos-num" name="mouzaid" placeholder="মৌজার আইডী লিখুন" required>
                        </div>
                    </div>

                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-4" for="mouzaname">Mouza name (Bangla): </label>
                        <div class="col-sm-5">          
                            <input type="text" class="form-control" name="mouzaname" placeholder="মৌজার নাম বাংলায় লিখুন" required>
                        </div>
                    </div>

                    <div class="form-group form-group-sm">
                        <label class="control-label col-sm-4" for="mouzanameeng">Mouza name (English): </label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control check-name" name="mouzanameeng" placeholder="মৌজার নাম ইংরেজিতে লিখুন" required>
                        </div>
                    </div>

                    <!--                    <div class="form-group form-group-sm">
                                            <div class="col-sm-offset-4 col-sm-2">
                                                <button type="submit" class="btn btn-primary btn-sm btn-flat" >Submit</button>
                                            </div>
                    
                                            <div class="col-sm-offset-1">
                                                <button type="reset" name="reset" class="btn btn-primary btn-sm btn-flat">Reset</button>
                                            </div>
                                        </div>-->
                </div>
                <div class="modal-footer">
                    <button type="reset" name="reset" class="btn btn-flat btn-default btn-md bold">Reset</button>
                    <button type="submit" class="btn btn-flat btn-success btn-md bold">Submit</button>
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
                <h4 class="modal-title bold">Confirm deletion</h4>
            </div>

            <div class="modal-body">
                <h4 class="center bold"><i class="fa fa-question-circle" aria-hidden="true"></i>&nbsp; Are you sure you want to delete ?</h4>
                <p id="deleteVillageName" style="font-size: 16px;text-align: center"></p>
                <!--                <button type="button" id="btnConfirm-deleteVillage" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger">Confirm</button>&nbsp;&nbsp;-->
                <!--                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">Cancel</button>-->
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-flat btn-default bold" data-dismiss="modal">Cancel</button>
                <button type="button" id="btnConfirm-deleteVillage" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Processing" class="btn btn-flat btn-danger bold">Confirm</button>&nbsp;&nbsp;
            </div>
        </div>
    </div>
</div>
</div>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script type="text/javascript" src="https://www.jquery-az.com/boots/js/bootstrap-multiselect/bootstrap-multiselect.js"></script>