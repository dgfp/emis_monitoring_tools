<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/header.jspf" %>
<script src="resources/js/area_dropdown_controls.js"></script>

<script>

    $(document).ready(function () {

        $('#showdataButton').click(function () {
            var btn = $(this).button('loading');
            $.ajax({url: "UploadStatus",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: $("select#union").val(),
                    startDate: $('#startDate').val(),
                    endDate: $('#endDate').val(),
                    byWho: $("select#byWho").val()
                },
                type: 'POST',
                success: function (result) {

                    var json = JSON.parse(result);

                    if (json.length === 0) {
                        btn.button('reset');
                        alert("No data found");
                    }
                    var tableType = $("select#byWho").val();
                    var tableBody = $('#tableBody');
                    var tableFooter = $('#tableFooter');

                    tableBody.empty(); //first empty table before showing data
                    tableFooter.empty();

                    if (tableType === 'union') {
                        var totalhh_sum = 0, totalmember_sum = 0;

                        for (var i = 0; i < json.length; i++) {

                            var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                    + "<td>" + json[i].dname + "</td>"
                                    + "<td>" + json[i].upname + "</td>"
                                    + "<td>" + json[i].uname + "</td>"
                                    + "<td>" + json[i].totalhh + "</td>"
                                    + "<td>" + json[i].totalmember + "</td></tr>";
                            tableBody.append(parsedData);

                            totalhh_sum += parseInt(json[i].totalhh);
                            totalmember_sum += parseInt(json[i].totalmember);
                        }

                        if (totalhh_sum > 0 && totalmember_sum > 0) {
                            var footerData = "<tr> <td style='text-align:left' colspan='4'>Total</td>"
                                    + "<td>" + totalhh_sum + "</td>"
                                    + "<td>" + totalmember_sum + "</td></tr>";
                            tableFooter.append(footerData);
                        }


                    } else if (tableType === 'provider') {

                        var totalhh_sum = 0, totalmem_sum = 0;

                        for (var i = 0; i < json.length; i++) {

                            var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                    + "<td>" + json[i].provcode + "</td>"
                                    + "<td>" + json[i].provname + "</td>"
                                    + "<td>" + json[i].typename + "</td>"
                                    + "<td>" + json[i].totalhh + "</td>"
                                    + "<td>" + json[i].totalmem + "</td>";
                            tableBody.append(parsedData);

                            totalhh_sum += parseInt(json[i].totalhh);
                            totalmem_sum += parseInt(json[i].totalmem);

                        }

                        if (totalhh_sum > 0 && totalmem_sum > 0) {
                            var footerData = "<tr> <td style='text-align:left' colspan='4'>Total</td>"
                                    + "<td>" + totalhh_sum + "</td>"
                                    + "<td>" + totalmem_sum + "</td></tr>";
                            tableFooter.append(footerData);
                        }


                    }

                    btn.button('reset');
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    btn.button('reset');
                    alert("Request can't be processed");
                }
            });
        });

        /******************START of makeTable()*******************/
        function makeTable(tableName) {

            var tableHead = $('#tableHead');
            var tableBody = $('#tableBody');
            var tableFooter = $('#tableFooter');

            tableHead.empty(); //delete existing table header
            tableBody.empty(); //also delete existing table row's data 
            tableFooter.empty();


            if (tableName === 'provider') {
                tableHead.append(
                        "<tr><th>#</th>"
                        + "<th>Provider ID</th>"
                        + "<th>Provider Name</th>"
                        + "<th>Designation</th>"
                        + "<th>Total Household</th>"
                        + "<th>Total Member</th></tr>");
            } else if (tableName === 'union') {
                tableHead.append(
                        "<tr><th>#</th>"
                        + "<th>District</th>"
                        + "<th>Upazila</th>"
                        + "<th>Union</th>"
                        + "<th>Total Household</th>"
                        + "<th>Total Member</th></tr>");
            }
        }

        /******************END of makeTable()*******************/
        var changeTable = function () {
            var tableName = $("select#byWho").val();
            makeTable(tableName);
        };

        changeTable();

        $('#byWho').on("change", changeTable);
        //$("input[type=radio]").on("click", changeTable);

    });

</script>

<div id="page-wrapper">

    <div class="container-fluid">

        <div class="row">
            <div class="col-lg-12">
                <h3>Data Upload Status</h3>
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
                    <select class="form-control input-sm" name="upazila" id="upazila">
                        <option value="">All</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="union">Union</label>
                </div>

                <div class="col-md-2">
                    <select class="form-control input-sm" name="union" id="union">
                        <option value="">All</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="byWho">By</label>
                </div>

                <div class="col-md-2">
                    <select class="form-control input-sm" name="byWho" id="byWho">
                        <option value="provider">Provider</option>
                        <option value="union">Union</option>
                    </select>
                </div>

            </div>

            <br/>

            <div class="row">
                <div id="datepicker-container">

                    <div class="input-daterange input-group" id="datepicker">

                        <div class="col-md-1">
                            <label for="startDate">From</label>
                        </div>

                        <div class="col-md-2">
                            <input type="text" class="input form-control input-sm" placeholder="dd/mm/yyyy" name="startDate" id="startDate"/>
                        </div>

                        <div class="col-md-1">
                            <label for="endDate">To</label>
                        </div>

                        <div class="col-md-2">
                            <input type="text" class="input form-control input-sm" placeholder="dd/mm/yyyy" name="endDate" id="endDate" />
                        </div>


                        <div class="col-md-2 col-md-offset-1">
                            <!--            <div class="col-md-2 col-md-offset-1">-->
                            <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-sm btn-success btn-block" autocomplete="off">
                                Show data
                            </button>
                        </div>

                    </div>
                </div>
            </div>
        </div> 

        <div class="col-ld-12">
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead id="tableHead">
                    </thead>
                    <tbody id="tableBody">
                    </tbody>
                    <tfoot id="tableFooter">
                    </tfoot>
                </table>
            </div>
        </div>

        <!-- /.row -->
    </div>
    <!-- /.container-fluid -->
</div>

<%@include file="/WEB-INF/jspf/footer.jspf" %>
