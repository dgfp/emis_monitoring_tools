<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/header.jspf" %>
<script src="resources/js/area_dropdown_controls.js"></script>

<script>

    $(document).ready(function () {

        $('#showdataButton').click(function () {

            var btn = $(this).button('loading');

            $.ajax({
                url: "elco_summary",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: $("select#union").val()

                },
                type: 'POST',
                success: function (result) {
                    var json = JSON.parse(result);
                    if (json.length === 0) {
                        btn.button('reset');
                        alert("No data found");
                    }

                    
                    var tableBody = $('#tableBody');
                    var tableFooter = $('#tableFooter');

                    tableBody.empty(); //first empty table before showing data
                    tableFooter.empty();


                    var totalhh_sum = 0, totalmember_sum = 0, elco_eligible_sum = 0,
                            elco_register_sum = 0, currentlypregnent_sum = 0;

                    for (var i = 0; i < json.length; i++) {

                        var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                + "<td>" + json[i].providerid + "</td>"
                                + "<td>" + json[i].providername + "</td>"
                                + "<td>" + json[i].totalhh + "</td>"
                                + "<td>" + json[i].totalmember + "</td>"
                                + "<td>" + json[i].elco_eligible + "</td>"
                                + "<td>" + (parseInt(json[i].elco_register) || 0) + "</td>"
                                + "<td>" + (parseInt(json[i].currentlypregnent) || 0) + "</td> </tr>";

                        tableBody.append(parsedData);

                        totalhh_sum += parseInt(json[i].totalhh);
                        totalmember_sum += parseInt(json[i].totalmember);
                        elco_eligible_sum += parseInt(json[i].elco_eligible);
                        elco_register_sum += (parseInt(json[i].elco_register) || 0);
                        currentlypregnent_sum += (parseInt(json[i].currentlypregnent) || 0);

                    }

                    var footerData = "<tr> <td style='text-align:left' colspan='3'>Total</td>"
                            + "<td>" + totalhh_sum + "</td>"
                            + "<td>" + totalmember_sum + "</td>"
                            + "<td>" + elco_eligible_sum + "</td>"
                            + "<td>" + elco_register_sum + "</td>"
                            + "<td>" + currentlypregnent_sum + "</td></tr>";

                    $('#tableFooter').append(footerData);
                    btn.button('reset');
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    btn.button('reset');
                    alert("Request can't be processed");
                }
            });
        });
    });
</script>

<div id="page-wrapper">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <h3>ELCO By Provider</h3>
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
                <div class="col-md-2">
                    <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-success btn-sm btn-block" autocomplete="off">
                        Show data
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
                            <th>Total Household</th>
                            <th>Total Member</th>
                            <th>ELCO (Eligible)</th>
                            <th>ELCO Registered</th>
                            <th>Currently Pregnant</th>
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

<%@include file="/WEB-INF/jspf/footer.jspf" %>

