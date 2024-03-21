<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/header.jspf" %>
<script src="resources/js/area_dropdown_controls.js"></script>
<style>
    #rightAlign{
        text-align: right;
    }
    
    #leftAlign{
        text-align: left;
    }
</style>
<script>
    $(document).ready(function () {

        $('#showdataButton').click(function () {

            var btn = $(this).button('loading');

            $.ajax({
                url: "ProviderActivity",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: $("select#union").val(),
                    designation:$("select#designation").val(),
                    startDate: $("#startDate").val(),
                    endDate: $("#endDate").val()
                },
                type: 'POST',
                success: function (result) {
                    var json = JSON.parse(result);
                    if (json.length === 0) {
                        btn.button('reset');
                        alert("No data found");
                    }

                    var tableBody = $('#tableBody');
                    tableBody.empty(); //first empty table before showing data
                    $('#tableFooter').empty();

                    var totalworkdays_sum = 0;
                    var totalhousehold_sum = 0;
                    var totalmember_sum = 0;

                    for (var i = 0; i < json.length; i++) {

                        var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                + "<td>" + json[i].upazilanameeng + "</td>"
                                + "<td>" + json[i].unionnameeng + "</td>"
                                + "<td>" + json[i].provname + " [" + json[i].provcode + "]</td>"
//                                + "<td>" + json[i].typename + "</td>"
                                + "<td></td>"
                                + "<td>" + json[i].startdate + "</td>"
                                + "<td>" + json[i].enddate + "</td>"
                                + "<td class='number-field'>" + json[i].totalworkdays + "</td>"
                                + "<td class='number-field'>" + json[i].totalhousehold + "</td>"
                                + "<td class='number-field'>" + json[i].totalmember + "</td></tr>";

                        tableBody.append(parsedData);

                        totalworkdays_sum += parseInt(json[i].totalworkdays);
                        totalhousehold_sum += parseInt(json[i].totalhousehold);
                        totalmember_sum += parseInt(json[i].totalmember);

                    }

                    if (totalworkdays_sum > 0 || totalhousehold_sum > 0 || totalmember_sum > 0) {
                        var footerData = "<tr> <td style='text-align:left' colspan='7'>Total</td> <td class='number-field'>" + totalworkdays_sum + "</td>"
                                + "<td class='number-field'>" + totalhousehold_sum + "</td>"
                                + "<td class='number-field'>" + totalmember_sum + "</td></tr>";
                        $('#tableFooter').append(footerData);
                    }


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
                <h3>Performance of Family Welfare Assistant</h3>
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
                    <label for="designation">Designation</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="designation" id="designation">
                        <option value="">All</option>
                        <option value="2">HA</option>
                        <option value="3">FWA</option>
                    </select>
                </div>


            </div>

            <br/>

            <div class="row">
                        
                        <div class="col-md-1">
                            <label for="startDate" id="startDateLbl">From</label>
                        </div>
                         <div class="col-md-2">
                            <input type="text" class="input form-control input-sm datepicker" placeholder="dd/mm/yyyy" name="startDate" id="startDate" />
                        </div>

                        <div class="col-md-1">
                            <label for="endDate" id="endDateLbl">To</label>
                        </div>
                        <div class="col-md-2">
                            <input type="text" class="input form-control input-sm datepicker" placeholder="dd/mm/yyyy" name="endDate" id="endDate" />
                        </div>

<!--                        <div class="col-md-1">
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
                        </div>-->


                        <div class="col-md-2 col-md-offset-1">
                            <!--            <div class="col-md-2 col-md-offset-1">-->
                            <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-success btn-block btn-sm" autocomplete="off">
                                Show data
                            </button>
                        </div>

            </div>
        </div> 

        <div class="col-ld-12">
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Upazila</th>
                            <th>Union</th>
                            <th>Provider name[Code]</th>
<!--                            <th>Designation</th>-->
                            <th>Unit</th>
                            <th>Start date</th>
                            <th>End date</th>
                            <th>Total days worked</th>
                            <th>Total household registered</th>
                            <th>Total member registered</th>
                        </tr>
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
<script>

    $('.datepicker').datepicker({
        format: 'dd/mm/yyyy',
        todayBtn: "linked",
        clearBtn: true,
        autoclose: true,
        startDate : new Date('12-25-2014')
    });
</script>
<%@include file="/WEB-INF/jspf/footer.jspf" %>
