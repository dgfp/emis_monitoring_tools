<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeaderELCO.jspf" %>
<script src="resources/js/area_dropdown_control_by_user_elco_dgfp.js"></script>
<script>
    $(function () {
        if ($.app.individualAceess.indexOf($.app.user.role) < 0 && $.app.user.username!="program_manager") {
            $(".individualBlock").hide();
            $("#aggregate").prop("checked", false);
            $('#villDiv').html("");
//            var viewBtnBlock = $('.viewBtnBlock').html();
//            $('.viewBtnBlock').empty();
//            $('.2nd-row').append(viewBtnBlock);
        }
    });
</script>
<style>
    #unitDiv, #villDiv, #_periodical, #_monthly, #_yearly, #viewTypeBlock, #dateBlock {
        display: none;
    }
    #printTable{
        display: none;
    }
    #tableView{
        display: none;
    }
    .box-body {
        padding: 10px 10px 0px 10px!important;
    }
    #areaDropDownPanel [class*="col"] { margin-bottom: 10px; }
    #radioDiv { margin-bottom: 0px!important; }
    span.td {
        border-top-color: #e0e0e0;
    }
    #rightAlign{
        text-align: right!important;
        vertical-align: middle;
    }
    #areaDropDownPanel .box {
        margin-bottom: 0px!important;
    }
    #tableFooter {
        background-color: #fff;
        font-weight: bold;
    }
    .label-progress{
        width: 100%;
        padding: 0.4em .7em .4em;
        font-weight: 700;
        line-height: 1.1;
        text-align: center;
        white-space: nowrap;
        border-radius: .25em;
    }

    .ui-widget-header {
        background: #3C8DBC!important;
    }   
    .ui-corner-all, .ui-corner-bottom, .ui-corner-left, .ui-corner-bl {
        border-radius: 0px!important;
    }
    .mtz-monthpicker{
        cursor: pointer!important;
    }
    .warp{
        padding: 2px 4px; 
        color: #fff;
        border-radius: 7px;
    }
    .type-active{
        background-color: #EC971F;
    }
    .type-inactive{
        background-color: #dbdbdb; 
        color: #6d6d6d;
    }
    .view-active{
        background-color: #31B0D5; 

    }
    .view-inactive{
        background-color: #dbdbdb; 
        color: #6d6d6d;
    }
    .viewTitle{
        margin-top: 0px!important;
        margin-bottom: 16px!important;
        text-align: center;
    }
    .viewTitle > .label-default {
        background-color: #efefef;
    }
    .monthPickerChoose{
        background-color: rgb(255, 255, 255)!important;
    }
</style>
<script>
    $(function () {
        $('#provtypeWise').on('change', function () {
            $('label[for=provtypeWise]').toggleClass('checked');
            $("#providerwise").val() == "0" ? $("#providerwise").val(1) : $("#providerwise").val(0);
        });
        $('input[type=radio][name=level]').change(function () {
            resetViewType();
            if (this.value == 'household') {
                setViewType(this.value);
            } else if (this.value == 'population') {
                setViewType(this.value);
            }
        });
        var $clickable = $('.clickable').on('click', function (e) {
            var $target = $(e.currentTarget);
            var index = $clickable.index($target)
            $clickable.removeClass('selected-color');
            $target.toggleClass('selected-color');
            if (index == 0) {
                $("#graphView").fadeOut(100);
                $("#tableView").fadeIn(100);
                $("table").fadeIn(100);
            } else if (index == 1) {
                $("#tableView").fadeOut(100);
                $("#graphView").fadeIn(100);
                $("table").fadeOut(100);
            } else {
            }
        });
        function resetViewType() {
            $("#household-data-table, #population-data-table").css("display", "none");
            $("#household, #population").next("span").removeClass("view-active").addClass("view-inactive");
            $("#dateBlock").slideDown();
        }
        function setViewType(selector) {
            $("#" + selector).next("span").removeClass("view-inactive").addClass("view-active");
            $("#_" + selector).fadeIn();
        }
    })
</script>
<style>
    #areaPanel [class*="col"] { margin-bottom: 10px; }
    #areaPanel .box {margin-bottom:5px}
    .info-box-md-container .info-box{ min-height: 56px}
    .info-box-md-container .info-box-icon{ width: 56px; height: 56px; line-height: 56px; font-size: 32px;}
    .info-box-md-container .info-box-content{ margin-left: 56px;}
    .box-body {
        padding: 10px!important;
        padding-bottom: 0px!important;
    }
    .label {
        border-radius: 11px!important;
    }
    label[for=provtypeWise]{ background: #e2e0e0;cursor: pointer;padding: 2px;}
    label.checked[for=provtypeWise]{ background: #e2e0e0;}
    #provtypeWise+#provtype{ display: none}
    #provtypeWise:checked+#provtype{ display: block}
    .selected-color{
        background-color: #0bb7dd;
        color: #fff;
    }
    #tableView, .prs-info{}
    #mapView, #graphView, #areaPanel{
        display: none;
    }
    .numeric_field{
        text-align: right;
    }
    .info-box-text{
        text-transform: capitalize;
    }
    #tableFooter {
        background-color: #fff;
    }
    table.table-bordered thead th,
    table.table-bordered thead td {
        border-left-width: 1px;
        border-top-width: 1px;
    }
    .table-bordered {
        border: 2px solid #f4f4f4;
    }
    .numeric_field{
        width: 12%!important;
        min-width: 12%!important;
    }
    .dataTables_filter > input{
        display: none;
        color: red;
    }
    .content-header h1 {
        color: #000!important;
    }
    #mapView, #graphView, #tableView, .prs-info, #areaPanel{
        display: none;
    }
</style>
<script>
    var areaText = "";
    var p = "";
    var a = [];
    function convertToCustomDateFormat(dateString) {
        var parts = dateString.split("-");
        var year = parts[0];
        var month = parts[1];
        var date = parts[2];
        return date + "/" + month + "/" + year;
    }
    $(document).ready(function () {
        $("#areaDropDownPanel").slideDown("slow");

        $("#startYear").change(function () {
            $('#endYear').find('option').remove();
            $('<option>').val("").text('- Select year -').appendTo('#endYear');
            for (i = new Date().getFullYear(); i >= this.value; i--)
            {
                $('#endYear').append($('<option />').val(i).html(i));
            }
        });

        $('input[type=radio][name=reportType]').change(function () {
            if (this.value == "aggregate") {
                $("#aggregate").next("span").removeClass("type-inactive").addClass("type-active");
                $("#individual").next("span").removeClass("type-active").addClass("type-inactive");
                $("#viewTypeBlock").slideDown();
                $("#dateBlock").fadeOut();
                $("#atPoint, #periodical, #monthly, #yearly").next("span").removeClass("view-active").addClass("view-inactive");
                $("#atPoint, #periodical, #monthly, #yearly").prop("checked", false);
            } else {
                $("#individual").next("span").removeClass("type-inactive").addClass("type-active");
                $("#aggregate").next("span").removeClass("type-active").addClass("type-inactive");
                $("#viewTypeBlock").slideUp();
                $("#dateBlock").fadeIn();
                $("#_atPoint").fadeIn();
                $("#_periodical, #_monthly, #_yearly").fadeOut();
            }

        });
        $('input[type=radio][name=viewType]').change(function () {
            resetViewType();
            if (this.value == 'atPoint') {
                setViewType(this.value);
            } else if (this.value == 'periodical') {
                setViewType(this.value);
            } else if (this.value == 'monthly') {
                setViewType(this.value);
            } else if (this.value == 'yearly') {
                $('#startYear, #endYear').find('option').remove();
                $('<option>').val("").text('- Select year -').appendTo('#startYear, #endYear');
                for (i = new Date().getFullYear(); i > 2014; i--)
                {
                    $('#startYear, #endYear').append($('<option />').val(i).html(i));
                }
                setViewType(this.value);
            }
        });

        var elco = {
            tableHeader: $('#tableHeader'),
            tableBody: $('#tableBody'),
            tableFooter: $('#tableFooter'),
            tableHeaderP: $('#tableHeaderP'),
            tableBodyP: $('#tableBodyP'),
            tableFooterP: $('#tableFooterP'),
            init: function () {
            },
            resetTable: function () {
                elco.tableHeader.empty();
                elco.tableBody.empty();
                elco.tableFooter.empty();
                elco.tableHeaderP.empty();
                elco.tableBodyP.empty();
                elco.tableFooterP.empty();
            }
        };
        elco.init();

        $('#showdataButton').click(function () {
            $("#table-col").removeClass().addClass("col-md-12");
            $("#tableView, #graphView, .prs-info").fadeOut();

            var regExp = /(\d{1,2})\/(\d{1,2})\/(\d{2,4})/; //for date compare
            var endDate = $("#periodicalEndDate").val();
            var date = endDate.substring(0, 2);
            var month = endDate.substring(3, 5);
            var year = endDate.substring(6, 10);
            endDate = new Date(year, month - 1, date);
            var chartId = $("#chart"), area = "", chartData = [], chartLabel = [], chartDataObj = {}; // Chart variable declaration
            var areaHeader = "", providerHeader = "", reportTitle = "";

            var data = $.app.pairs('form');
            //Validations
            if (data.district === "") {
                toast("error", "Please select district");
                return;
            } else if (data.upazila === "") {
                toast("error", "Please select upazila");
                return;
            } else if (data.reportType == undefined) {
                toast("error", "Please select report type");
                return;
            } else if (data.viewType == undefined && data.reportType != "individual") {
                toast("error", "Please select view type");
                return;
            }
            //At point
            if (data.viewType == "atPoint" && data.endDate == "") {
                toast("error", "Please select date");
                return;
            }
            //Monthly
            if (data.viewType == "monthly" && data.startMonthYear == "") {
                toast("error", "Please select month");
                return;
            } else if (data.viewType == "monthly" && data.endMonthYear == "") {
                toast("error", "Please select month");
                return;
            } else if (data.viewType == "monthly" && !monthChecker(data)) {
                toast("error", "Start month should be smaller than end month");
                return;
            }
            //Yearly
            if (data.viewType == "yearly" && data.startYear == "") {
                toast("error", "Please select year");
                return;
            } else if (data.viewType == "yearly" && data.endYear == "") {
                toast("error", "Please select year");
                return;
            } else if (data.viewType == "yearly" && data.startYear > data.endYear) {
                toast("error", "Start year should be smaller than end year");
                return;
            }
            //Periodic
            if (data.viewType == "periodical" && data.periodicalStartDate == "") {
                toast("error", "Please select date");
                return;
            } else if (data.viewType == "periodical" && data.periodicalEndDate == "") {
                toast("error", "Please select date");
                return;
            } else if (data.viewType == "periodical" && (parseInt(data.endDate.replace(regExp, "$3$2$1")) > parseInt(data.periodicalEndDate.replace(regExp, "$3$2$1")))) {
                toast("error", "Start date should be smaller than end date");
                return;
            } else if (data.viewType == "periodical" && (endDate > new Date())) {
                toast("error", "End date should not greater than todays date");
                return;
            }
            elco.resetTable();
            legendVisibility(data.viewType);

            //Individual
            if (data.reportType === "individual") {
                $("#progress-legend").css("display", "none");
                data.viewType = "atPoint";
                $.ajax({
                    url: "eligible-couple?action=aggregate",
                    data: {
                        data: JSON.stringify(data)
                    },
                    type: 'POST',
                    success: function (json) {
                        json = JSON.parse(json);
                        console.log(json);
                        if (json.length === 0) {
                            toast("error", "No data found");
                            return;
                        }
                        setPrintTitle();
                        resetView(chartId, "none"); // Chart view btn display none
                        var parsedHeader = "<tr>"
                                + "<th style='vertical-align: top;width:10px!important;'>#</th>"
                                + "<th style='vertical-align: top;'>Village</th>"
                                + "<th style='vertical-align: top;width:48px!important;'>Elco no.</th>"
                                + "<th style='vertical-align: top;'>ELCO</th>"
                                + "<th style='vertical-align: top;width:10px!important;'>Age</th>"
                                + "<th style='vertical-align: top;'>Husband</th>"
                                + "<th style='vertical-align: top;'>Mobile no.</th>"
                                + "<th style='vertical-align: top;width:95px!important;'>Current status</th>"
                                + "<th style='vertical-align: top;width:90px!important;'>Last visit date</th>"
                                + "</tr>";
                        elco.tableHeader.append(parsedHeader);
                        elco.tableHeaderP.append(parsedHeader);

                        var table = $('#data-table').DataTable();
                        table.destroy();
                        elco.tableBody.empty();
                        for (var i = 0; i < json.length; i++) {
                            var vDate = json[i].vdate.split("-");
                            vDate = vDate[2] + "/" + vDate[1] + "/" + vDate[0];
                            var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                    + "<td style='vertical-align: top;'>" + json[i].village + "</td>"
                                    + "<td style='vertical-align: top;'>" + ((json[i].elcono === "null") ? "-" : json[i].elcono) + "</td>"
                                    + "<td style='vertical-align: top;' class='area'>" + json[i].elconame + "</td>"
                                    + "<td style='vertical-align: top;' >" + ((json[i].age === "null") ? "-" : json[i].age) + "</td>"
                                    + "<td style='vertical-align: top;' class='area'>" + ((json[i].husband === "null") ? "-" : json[i].husband) + "</td>"
                                    + "<td style='vertical-align: top;'>" + ((json[i].mobileno === "null") ? "-" : "0" + json[i].mobileno) + "</td>"
                                    + "<td style='vertical-align: top;' class='area'>" + ((json[i].evname === "null") ? "-" : json[i].evname) + "</td>"
                                    + "<td style='vertical-align: top;'>" + ((json[i].vdate === "null") ? "-" : vDate) + "</td>";
                            elco.tableBody.append(parsedData);
                            elco.tableBodyP.append(parsedData);
                        }
                        $("#data-table").DataTable($.app.dtOptions());
                        reportTitle = "Detail list of registered eligible couples in the selected FWA unit on " + data.endDate;//Set report title
                        $('.viewTitle > .label-default').text(reportTitle);
                    },
                    error: function () {
                        toast("error", "Request can't be processed");
                    }
                });

            } else if (data.reportType === "aggregate") {
                $.ajax({
                    url: "eligible-couple?action=aggregate",
                    data: {
                        data: JSON.stringify(data)
                    },
                    type: 'POST',
                    success: function (json) {
                        json = JSON.parse(json);
                        console.log(json);
                        if (json.length === 0) {
                            toast("error", "No data found");
                            return;
                        }
                        setPrintTitle();
                        resetView(chartId, "block"); // Chart view btn display block
                        var parsedHeader = "";

//==================================================at a point
                        if (data.viewType == 'atPoint' || data.reportType == "individual") {

                            if ($("select#upazila").val() == '0') {
                                areaHeader = "Upazila";
                            } else if ($("select#union").val() == '0') {
                                areaHeader = "Union";
                            } else if ($("select#unit").val() == '0' || $("select#village").val() == '0') {
                                areaHeader = "Unit", providerHeader = "<th style='vertical-align: top;'>Provider&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>";
                            }
                            parsedHeader = "<tr>"
                                    + "<th style='vertical-align: top;'>#</th>"
                                    + "<th style='vertical-align: top;'>" + areaHeader + "</th>"
                                    + "" + providerHeader
                                    + "<th style='vertical-align: top;'>Registered population</th>"
                                    + "<th style='vertical-align: top;'>Estimated ELCO</th>"
                                    + "<th style='vertical-align: top;'>Registered ELCO</th>"
                                    + "<th style='vertical-align: top;'>Coverage (%)</th>"
                                    + "</tr>";
                            elco.tableHeader.append(parsedHeader);
                            elco.tableHeaderP.append(parsedHeader);

                            var table = $('#data-table').DataTable();
                            table.destroy();
                            elco.tableBody.empty();
                            var colspan = 2;
                            if ($("select#upazila").val() == '0') {
                                colspan = 2, area = "upazilanameeng";
                                for (var i = 0; i < json.length; i++) {
                                    var parsedData = "<tr id='centerAlign'><td>" + (i + 1) + "</td>"
                                            + "<td id='centerAlign' class='area'>" + json[i].upazilanameeng + "</td>"
                                            + "<td id='centerAlign'>" + finiteFilter(json[i].registered_population) + "</td>"
                                            + "<td id='centerAlign'>" + (parseInt(json[i].estimated_elco) || 0) + "</td>"
                                            + "<td id='centerAlign'>" + (parseInt(json[i].registered_elco) || 0) + "</td>"
                                            + "<td id='centerAlign'>" + getProgrerss(json[i]) + " </td> </tr>";
                                    elco.tableBody.append(parsedData);
                                    elco.tableBodyP.append(parsedData);
                                }
                            } else if ($("select#union").val() == '0') {
                                colspan = 2, area = "unionnameeng";
                                for (var i = 0; i < json.length; i++) {
                                    var parsedData = "<tr id='centerAlign'><td>" + (i + 1) + "</td>"
                                            + "<td id='centerAlign' class='area'>" + json[i].unionnameeng + "</td>"
                                            + "<td id='centerAlign'>" + finiteFilter(json[i].registered_population) + "</td>"
                                            + "<td id='centerAlign'>" + (parseInt(json[i].estimated_elco) || 0) + "</td>"
                                            + "<td id='centerAlign'>" + (parseInt(json[i].registered_elco) || 0) + "</td>"
                                            + "<td id='centerAlign'>" + getProgrerss(json[i]) + " </td> </tr>";
                                    elco.tableBody.append(parsedData);
                                    elco.tableBodyP.append(parsedData);
                                }
                            } else if ($("select#unit").val() == '0' || $("select#village").val() == '0') {
                                colspan = 3, area = "uname"
                                for (var i = 0; i < json.length; i++) {
                                    var provname = (json[i].providerid === 5) ? "NGO" : "<b>" + json[i].provname + "</b>";
                                    var parsedData = "<tr id='centerAlign'><td>" + (i + 1) + "</td>"
                                            + "<td id='centerAlign' class='center area'>" + json[i].uname + "<br/>" + $.app.getAssignType(json[i].assign_type, 1) + "</td>"
                                            + "<td class='area'>ID: " + json[i].providerid + " - " + provname + "<br/>Mob: " + ((json[i].providermobile === "null") ? "-" : "0" + json[i].providermobile) + "</td>"
                                            + "<td id='centerAlign'>" + finiteFilter(json[i].registered_population) + "</td>"
                                            + "<td id='centerAlign'>" + (parseInt(json[i].estimated_elco) || 0) + "</td>"
                                            + "<td id='centerAlign'>" + (parseInt(json[i].registered_elco) || 0) + "</td>"
                                            + "<td id='centerAlign'>" + getProgrerss(json[i]) + " </td> </tr>";
                                    elco.tableBody.append(parsedData);
                                    elco.tableBodyP.append(parsedData);
                                }
                            }
                            var cal = new Calc(json);
                            var footerData = "<tr> <td style='text-align:left' colspan='" + colspan + "'>" + getTotalText() + " Total</td>"
                                    + "<td id='centerAlign'>" + cal.sum.registered_population + "</td>"
                                    + "<td id='centerAlign'>" + cal.sum.estimated_elco + "</td>"
                                    + "<td id='centerAlign'>" + cal.sum.registered_elco + "</td>"
                                    + "<td id='centerAlign'>" + getProgrerss(cal.sum) + " </td>";
                            elco.tableFooter.append(footerData);
                            elco.tableFooterP.append(footerData);

                            //DataTable
                            $("#data-table").DataTable($.app.dtOptions());
                            //Chart render
                            $.each(json, function (index, value) {
                                chartData.push({area: value[area] + " ( n=" + (parseInt(value.estimated_elco) || 0) + " )", progress: getProgrerss_(value)});
                            });
                            chartData.push({area: getTotalText() + " Total ( n=" + cal.sum.estimated_elco + " )", progress: getProgrerss_(cal.sum)}); // Total bar
                            $.chart.renderBar(chartId, chartData, ['Progress'], chartColor[data.viewType], 0);
                            //Report title
                            reportTitle = viewTitle[data.viewType] + " " + data.endDate;
                            
                            
//================================periodical
                        } else if (data.viewType == 'periodical') {
                            resetView(chartId, "none");
                            $("#table-col").removeClass().addClass("col-md-8 col-md-offset-2");
                            //Make header
                            parsedHeader = "<tr>"
                                    + "<th style='vertical-align: top;'>#</th>";
                            if ($("select#upazila").val() == '0') {
                                parsedHeader += "<th style='vertical-align: top;'>Upazila</th>";
                            } else if ($("select#union").val() == '0') {
                                parsedHeader += "<th style='vertical-align: top;'>Union</th>";
                            } else if ($("select#unit").val() == '0' || $("select#village").val() == '0') {
                                parsedHeader += "<th style='vertical-align: top;'>Unit</th>"
                                        + "<th style='vertical-align: top;'>Provider</th>";
                            }
                            parsedHeader += "<th style='vertical-align: top;'>Registered ELCO (NEW)</th>"
                                    + "</tr>";

                            elco.tableHeader.append(parsedHeader);
                            elco.tableHeaderP.append(parsedHeader);
                            var table = $('#data-table').DataTable();
                            table.destroy();
                            elco.tableBody.empty();
                            var colspan = 2;

                            if ($("select#upazila").val() == '0') {
                                colspan = 2
                                $.each(json, function (k, v) {
                                    var parsedData = "<tr id='centerAlign'><td>" + (k + 1) + "</td>"
                                            + "<td id='centerAlign' class='area'>" + v.upazilanameeng + "</td>"
                                            + "<td id='centerAlign'>" + (parseInt(v.registered_elco) || 0) + "</td>"
                                            + "</tr>";
                                    elco.tableBody.append(parsedData);
                                    elco.tableBodyP.append(parsedData);
                                });
                            } else if ($("select#union").val() == '0') {
                                colspan = 2
                                $.each(json, function (k, v) {
                                    var parsedData = "<tr id='centerAlign'><td>" + (k + 1) + "</td>"
                                            + "<td id='centerAlign' class='area'>" + v.unionnameeng + "</td>"
                                            + "<td id='centerAlign'>" + (parseInt(v.registered_elco) || 0) + "</td>"
                                            + "</tr>";
                                    elco.tableBody.append(parsedData);
                                    elco.tableBodyP.append(parsedData);
                                });
                            } else if ($("select#unit").val() == '0' || $("select#village").val() == '0') {
                                colspan = 3
                                $.each(json, function (k, v) {
                                    var provname = (v.providerid === 5) ? "NGO" : "<b>" + v.provname + "</b>";
                                    var parsedData = "<tr id='centerAlign'><td>" + (k + 1) + "</td>"
                                            + "<td id='centerAlign' class='center area'>" + v.uname + "<br/>" + $.app.getAssignType(v.assign_type, 1) + "</td>"
                                            + "<td class='area'>ID: " + v.providerid + " - " + provname + "<br/>Mob: " + ((v.providermobile === "null") ? "-" : "0" + v.providermobile) + "</td>"
                                            + "<td id='centerAlign'>" + (parseInt(v.registered_elco) || 0) + "</td>"
                                            + "</tr>";
                                    elco.tableBody.append(parsedData);
                                    elco.tableBodyP.append(parsedData);
                                });
                            }
                            var cal = new Calc(json);
                            var footerData = "<tr> <td style='text-align:left' colspan='" + colspan + "'>" + getTotalText() + " Total</td>"
                                    + "<td id='centerAlign'>" + cal.sum.registered_elco + "</td>"
                                    + "</tr>";
                            elco.tableFooter.append(footerData);
                            elco.tableFooterP.append(footerData);
                            //DataTable
                            $("#data-table").DataTable($.app.dtOptions());
                            //Report title
                            reportTitle = viewTitle[data.viewType] + " " + data.periodicalStartDate + " and " + data.periodicalEndDate;



//================================monthly
                        } else if (data.viewType == 'monthly') {
                            //$('.viewTitle > .label-default').text(viewTitle[data.viewType]);
                            var months = getUnique(json, 'months', 'years');
                            if (months.length < 5)
                                $("#table-col").removeClass().addClass("col-md-8 col-md-offset-2");
                            var count = 0;
                            //Make header
                            parsedHeader = "<tr>"
                                    + "<th style='vertical-align: top;'>#</th>";
                            if ($("select#upazila").val() == '0') {
                                areaHeader = "Upazila";
                                parsedHeader += "<th style='vertical-align: top;'>Upazila</th>";
                            } else if ($("select#union").val() == '0') {
                                areaHeader = "Union";
                                parsedHeader += "<th style='vertical-align: top;'>Union</th>";
                            } else if ($("select#unit").val() == '0' || $("select#village").val() == '0') {
                                areaHeader = "Unit";
                                parsedHeader += "<th style='vertical-align: top;'>Unit</th>"
                                        + "<th style='vertical-align: top;'>Provider</th>";
                            }
                            //make month Head dynamically
                            $.each(months, function (i, v) {
                                var head = $.app.monthShort[v.months] + " " + (v.years).toString().substring(2, 4)
                                parsedHeader += "<th style='vertical-align: top;'>" + head + "</th>";
                                chartLabel.push(head);
                            });
                            parsedHeader += "</tr>";
                            elco.tableHeader.append(parsedHeader);
                            elco.tableHeaderP.append(parsedHeader);

                            //Render table body here
                            var table = $('#data-table').DataTable();
                            table.destroy();
                            elco.tableBody.empty();
                            var colspan = 2;
                            if ($("select#upazila").val() == '0') {
                                $.each(getDistinct(json, 'upazilanameeng'), function (i, v) {
                                    chartDataObj = {};
                                    chartDataObj['area'] = v;
                                    var parsedData = "<tr><td>" + (i + 1) + "</td><td>" + v + "</td>";
                                    $.each(months, function (index, value) {
                                        count = json.filter(obj => obj.upazilanameeng == v && obj.months == value.months && obj.years == value.years)[0];
                                        count = getProgrerss_(count.length == 0 ? 0 : count);
                                        parsedData += "<td style='font-weight: normal!important;'>" + count + "</td>";
                                        chartDataObj["month_" + index] = count;
                                    });
                                    parsedHeader += "</tr>";
                                    elco.tableBody.append(parsedData);
                                    elco.tableBodyP.append(parsedData);
                                    chartData.push(chartDataObj);
                                });
                            } else if ($("select#union").val() == '0') {
                                $.each(getDistinct(json, 'reporting_union_name'), function (i, v) {
                                    chartDataObj = {};
                                    chartDataObj['area'] = v;
                                    var parsedData = "<tr><td>" + (i + 1) + "</td><td>" + v + "</td>";
                                    $.each(months, function (index, value) {
                                        count = json.filter(obj => obj.reporting_union_name == v && obj.months == value.months && obj.years == value.years)[0];
                                        count = getProgrerss_(count.length == 0 ? 0 : count);
                                        parsedData += "<td style='font-weight: normal!important;'>" + count + "</td>";
                                        chartDataObj["month_" + index] = count;
                                    });

                                    parsedHeader += "</tr>";
                                    elco.tableBody.append(parsedData);
                                    elco.tableBodyP.append(parsedData);
                                    chartData.push(chartDataObj);
                                });
                            } else if ($("select#unit").val() == '0' || $("select#village").val() == '0') {
                                colspan = 3;
                                $.each(getDistinct(json, 'uname'), function (i, v) {
                                    chartDataObj = {};
                                    chartDataObj['area'] = v;
                                    var obj = json.filter(obj => obj.uname == v)[0];
                                    var provname = (obj.providerid === 5) ? "NGO" : "<b>" + obj.provname + "</b>";
                                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                            + "<td id='centerAlign' class='center area'>" + v + "<br/>" + $.app.getAssignType(obj.assign_type, 1) + "</td>"
                                            + "<td class='area'>ID: " + obj.providerid + " - " + provname + "<br/>Mob: " + ((obj.providermobile === "null") ? "-" : "0" + obj.providermobile) + "</td>";
                                    $.each(months, function (index, value) {
                                        count = json.filter(obj => obj.uname == v && obj.months == value.months && obj.years == value.years)[0];
                                        count = getProgrerss_(count.length == 0 ? 0 : count);
                                        parsedData += "<td style='font-weight: normal!important;'>" + count + "</td>";
                                        chartDataObj["month_" + index] = count;
                                    });
                                    parsedHeader += "</tr>";
                                    elco.tableBody.append(parsedData);
                                    elco.tableBodyP.append(parsedData);
                                    chartData.push(chartDataObj);
                                });
                            }

                            //Footer
                            chartDataObj = {};
                            chartDataObj['area'] = getTotalText() + " Total";
                            var footerData = "<tr> <td style='text-align:left' colspan='" + colspan + "'>" + getTotalText() + " Total</td>";
                            $.each(months, function (index, value) {
                                var cal = new Calc(json.filter(obj => obj.months == value.months && obj.years == value.years));
                                footerData += "<td>" + getProgrerss_(cal.sum) + "</td>"
                                chartDataObj["month_" + index] = getProgrerss_(cal.sum);
                            });
                            chartData.push(chartDataObj);
                            elco.tableFooter.append(footerData);
                            elco.tableFooterP.append(footerData);

                            //DataTable
                            $("#data-table").DataTable($.app.dtOptions());
                            //Chart render
                            $.chart.renderBar(chartId, chartData, chartLabel, chartColor[data.viewType], 0);
                            //Report title
                            reportTitle = viewTitle[data.viewType] + " " + data.startMonthYear + " and " + data.endMonthYear;



//================================Yearly
                        } else if (data.viewType == 'yearly') {
                            //$('.viewTitle > .label-default').text(viewTitle[data.viewType]);
                            var years = getDistinct(json, 'years');
                            if (years.length < 5)
                                $("#table-col").removeClass().addClass("col-md-8 col-md-offset-2");
                            var count = 0;

                            //Render table header here
                            parsedHeader += "<tr><th style='vertical-align: top;' rowspan='2'>#</th>";
                            if ($("select#upazila").val() == '0') {
                                areaHeader = "Upazila";
                                parsedHeader += "<th style='vertical-align: top;' rowspan='2'>Upazila</th>";
                            } else if ($("select#union").val() == '0') {
                                areaHeader = "Union";
                                parsedHeader += "<th style='vertical-align: top;' rowspan='2'>Union</th>";
                            } else if ($("select#unit").val() == '0' || $("select#village").val() == '0') {
                                areaHeader = "Unit";
                                parsedHeader += "<th style='vertical-align: top;' rowspan='2'>Unit</th>"
                                        + "<th style='vertical-align: top;' rowspan='2'>Provider</th>";
                            }
                            parsedHeader += '<td style="vertical-align: top;text-align:center;font-weight:bold;" colspan="' + years.length + '">Year</td>'
                                    + '</tr><tr>';
                            //make year column dynamically
                            $.each(years, function (index, value) {
                                parsedHeader += "<th style='vertical-align: top;'>" + value + "</th>";
                                chartLabel.push(value);
                            });
                            parsedHeader += "</tr>";

                            elco.tableHeader.append(parsedHeader);
                            elco.tableHeaderP.append(parsedHeader);
                            var table = $('#data-table').DataTable();
                            table.destroy();
                            elco.tableBody.empty();

                            //Render table body here
                            var colspan = 2;
                            if ($("select#upazila").val() == '0') {
                                $.each(getDistinct(json, 'upazilanameeng'), function (i, v) {
                                    chartDataObj = {};
                                    chartDataObj['area'] = v;
                                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                            + "<td>" + v + "</td>";
                                    $.each(years, function (index, value) {
                                        count = json.filter(obj => obj.upazilanameeng == v && obj.years == value).length == 0 ? 0 : json.filter(obj => obj.upazilanameeng == v && obj.years == value)[0];
                                        //count = getProgrerss_(json.filter(obj => obj.reporting_union_name == v && obj.years == value).length == 0 ? 0 : json.filter(obj => obj.reporting_union_name == v && obj.years == value)[0]);
                                        //parsedData += "<th style='font-weight: normal!important;'>" + getProgrerss_(count) + " - " + count.registered_elco + "</th>";
                                        parsedData += "<td style='font-weight: normal!important;'>" + getProgrerss_(count) + "</td>";
                                        chartDataObj["year_" + index] = getProgrerss_(count);
                                    });
                                    parsedHeader += "</tr>";
                                    elco.tableBody.append(parsedData);
                                    elco.tableBodyP.append(parsedData);
                                    chartData.push(chartDataObj);
                                });

                            } else if ($("select#union").val() == '0') {
                                $.each(getDistinct(json, 'reporting_union_name'), function (i, v) {
                                    chartDataObj = {};
                                    chartDataObj['area'] = v;
                                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                            + "<td>" + v + "</td>";
                                    $.each(years, function (index, value) {
                                        count = json.filter(obj => obj.reporting_union_name == v && obj.years == value).length == 0 ? 0 : json.filter(obj => obj.reporting_union_name == v && obj.years == value)[0];
                                        //count = getProgrerss_(json.filter(obj => obj.reporting_union_name == v && obj.years == value).length == 0 ? 0 : json.filter(obj => obj.reporting_union_name == v && obj.years == value)[0]);
                                        //parsedData += "<th style='font-weight: normal!important;'>" + getProgrerss_(count) + " - " + count.registered_elco + "</th>";
                                        parsedData += "<td style='font-weight: normal!important;'>" + getProgrerss_(count) + "</td>";
                                        chartDataObj["year_" + index] = getProgrerss_(count);
                                    });
                                    parsedHeader += "</tr>";
                                    elco.tableBody.append(parsedData);
                                    elco.tableBodyP.append(parsedData);
                                    chartData.push(chartDataObj);
                                });
                            } else if ($("select#unit").val() == '0' || $("select#village").val() == '0') {
                                colspan = 3;
                                $.each(getDistinct(json, 'uname'), function (i, v) {
                                    chartDataObj = {};
                                    chartDataObj['area'] = v;
                                    var obj = json.filter(obj => obj.uname == v)[0];
                                    var provname = (obj.providerid === 5) ? "NGO" : "<b>" + obj.provname + "</b>";
                                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                            + "<td id='centerAlign' class='center area'>" + v + "<br/>" + $.app.getAssignType(obj.assign_type, 1) + "</td>"
                                            + "<td class='area'>ID: " + obj.providerid + " - " + provname + "<br/>Mob: " + ((obj.providermobile === "null") ? "-" : "0" + obj.providermobile) + "</td>";

                                    $.each(years, function (index, value) {
                                        count = json.filter(obj => obj.uname == v && obj.years == value).length == 0 ? 0 : json.filter(obj => obj.uname == v && obj.years == value)[0];
                                        //count = getProgrerss_(json.filter(obj => obj.reporting_union_name == v && obj.years == value).length == 0 ? 0 : json.filter(obj => obj.reporting_union_name == v && obj.years == value)[0]);
                                        //parsedData += "<th style='font-weight: normal!important;'>" + getProgrerss_(count) + " - " + count.registered_elco + "</th>";
                                        parsedData += "<td style='font-weight: normal!important;'>" + getProgrerss_(count) + "</td>";
                                        chartDataObj["year_" + index] = getProgrerss_(count);
                                    });
                                    parsedHeader += "</tr>";
                                    elco.tableBody.append(parsedData);
                                    elco.tableBodyP.append(parsedData);
                                    chartData.push(chartDataObj);
                                });
                            }

                            //Footer
                            chartDataObj = {};
                            chartDataObj['area'] = getTotalText() + " Total";
                            var footerData = "<tr> <td style='text-align:left' colspan='" + colspan + "'>" + getTotalText() + " Total</td>";
                            $.each(getDistinct(json, 'years'), function (index, value) {
                                var cal = new Calc(json.filter(obj => obj.years == value));
                                footerData += "<td>" + getProgrerss_(cal.sum) + "</td>"
                                chartDataObj["year_" + index] = getProgrerss_(cal.sum);
                            });
                            chartData.push(chartDataObj);
                            elco.tableFooter.append(footerData);
                            elco.tableFooterP.append(footerData);
                            //DataTable
                            $("#data-table").DataTable($.app.dtOptions());
                            //Chart Rendering
                            $.chart.renderBar(chartId, chartData, chartLabel, chartColor[data.viewType], 0);
                            //Report title
                            reportTitle = viewTitle[data.viewType] + " " + data.startYear + " and " + data.endYear;
                        }

                        //Set report title
                        $('.viewTitle > .label-default').text(reportTitle);

                    },
                    error: function () {
                        toast("error", "Request can't be processed");
                    }
                });
            }
            
        });
        //Functions
        var viewTitle = {
            atPoint: 'Percentage of registered eligible couples on',
            monthly: 'Percentage of registered eligible couples against registered population between',
            yearly: 'Percentage of registered eligible couples between',
            periodical: 'Percentage of eligible couples registered between',
            undefined: 'Detail list of registered eligible couples in the selected FWA unit on' //Individual
        };
//        var viewTitle = {
////            atPoint: 'Percentage of estimated eligible couple registered up to a point of time',
//            atPoint: 'Percentage of registered eligible couples on a specific date',
////            monthly: 'Percentage of estimated eligible couple registered up to the selected month/s',
//            monthly: 'Percentage of registered eligible couples against registered population (selected months)',
////            yearly: 'Percentage of estimated eligible couple registered up to the selected year/s',
//            yearly: 'Percentage of registered eligible couples on selected year/s',
////            periodical: 'Number of new eligible couple registered in the selected period ',
//            periodical: 'Percentage of eligible couples registered between',
////            individual: 'List of registered active eligible couple up to a point of time'
//            undefined: 'Detail list of registered eligible couples in the selected FWA unit on a certain date' //Individual
//        };
        var chartColor = {
            atPoint: ['#95CEFF'],
            //monthly: ['#8189BA', '#4D4888', '#AD312B', '#EB667B', '#7CBA67', '#2D933D', '#FED26D', '#F58629', '#347672', '#53B4A9', '#B52980', '#DC83AF'],
            //monthly: ['#FED869', '#F78D1F', '#28BEBC', '#0D8181', '#F16582', '#BB2026', '#7090C9', '#3853A4', '#DC84B7', '#B61C8C', '#75C36F', '#13A24A'],
            monthly: ['#EF3E69', '#F78D1F', '#FFC02D', '#49C1C0', '#5A86C5', '#0D8181', '#F16582', '#B1B5BE', '#7E69AE', '#9BCCED', '#DC84B7', '#B61C8C'],
            //yearly: ['#FED26D', '#F58629', '#AD312B', '#EB667B', '#7CBA67', '#2D933D', '#347672', '#53B4A9', '#8189BA', '#4D4888']
            yearly: ['#EF3E68', '#F78D1F', '#FEC230', '#49C1C0', '#5A86C5', '#0D8181', '#7E69AE', '#F16582', '#B1B5BE', '#444349']
        }
        function getProgrerss_(json) {
            var progress = ((parseInt(json.registered_elco) || 0) / (parseInt(json.estimated_elco) || 0)) * 100;
            return Math.round(finiteFilter(progress));
        }
        function getProgrerss(json) {
            var progress = ((parseInt(json.registered_elco) || 0) / (parseInt(json.estimated_elco) || 0)) * 100;
            progress = Math.round(finiteFilter(progress));
            var colorObj = {
                darkgreen: "#00A65A",
                green: "#00e26d",
                yellow: "#FFFF00",
                orange: "#FFA500",
                red: "#ff3d3d"
            }
            if (progress > 95) {
                return progress_(colorObj.darkgreen, progress);
            } else if (progress >= 90) {
                return progress_(colorObj.green, progress);
            } else if (progress >= 80) {
                return progress_(colorObj.yellow, progress);
            } else if (progress >= 70) {
                return progress_(colorObj.orange, progress);
            } else if (progress < 70) {
                return progress_(colorObj.red, progress);
            }
        }
        function progress_(color, title) {
            return "<div class='label-progress' style='background-color:" + color + ";'>" + title + "</div>";
        }
        function toast(type, message) {
            toastr[type]("<h4><b>" + message + "</b></h4>");
        }
        function resetViewType() {
            $("#_atPoint, #_periodical, #_monthly, #_yearly").css("display", "none");
            $("#atPoint, #periodical, #monthly, #yearly").next("span").removeClass("view-active").addClass("view-inactive");
            $("#dateBlock").slideDown();
        }
        function setViewType(selector) {
            $("#" + selector).next("span").removeClass("view-inactive").addClass("view-active");
            $("#_" + selector).fadeIn();
        }
        function getDistinct(array, sub) {
            return array.map(item => item[sub]).filter((value, index, self) => self.indexOf(value) === index);
        }
        function getUnique(array, prop1, prop2) {
            return array.filter(function (a) {
                var key = a[prop1] + '|' + a[prop2];
                if (!this[key]) {
                    this[key] = true;
                    return true;
                }
            }, Object.create(null));
        }
        function monthChecker(data) {
            var startMonth = data.startMonthYear.split("/");
            var endMonth = data.endMonthYear.split("/");
            startMonth = new Date(startMonth[1], (+startMonth[0] - 1));
            endMonth = new Date(endMonth[1], (+endMonth[0] - 1));
            if (startMonth > endMonth) {
                return false;
            } else {
                return true;
            }
        }
        function legendVisibility(viewType) {
            if (viewType == "atPoint") {
                $("#progress-legend").css("display", "block");
            } else {
                $("#progress-legend").css("display", "none");
            }
        }
        function resetView(chartId, chartBtnDisplay) {
            $("#transparentTextForBlank").css("display", "none");
            $('#btn-table').children('.clickable').addClass('selected-color');
            $('#btn-chart').children('.clickable').removeClass('selected-color');
            $('#btn-table').children('.clickable').click();
            $("#tableView").slideDown("slow");
            $(".prs-info").slideDown("slow");
            chartId.html("");
            $('#btn-chart').css("display", chartBtnDisplay);
        }
        function setPrintTitle() {
            var division = " Division: <b style='color:#3C8DBC'>" + $("#division option:selected").text() + "</b>";
            var district = " District: <b style='color:#3C8DBC'>" + $("#district option:selected").text() + "</b>";
            var upazila = "Upazila: <b style='color:#3C8DBC'>" + $("#upazila option:selected").text() + "</b>";
            var union = "Union: <b style='color:#3C8DBC'>" + $("#union option:selected").text() + "</b>";
            var unit = "Unit: <b style='color:#3C8DBC'>" + $("#unit option:selected").text() + "</b>";
            var village = "Village: <b style='color:#3C8DBC'>" + $("#village option:selected").text() + "</b>";
            //var sDate = "From: <b style='color:#3C8DBC'>" + $("#startDate").val() + "</b>";
            //var eDate = "To: <b style='color:#3C8DBC'>" + $("#endDate").val() + "</b>";
            areaText = division + ',&nbsp;&nbsp;' + district + ',&nbsp;&nbsp;' + upazila + ',&nbsp;&nbsp;' + union + '&nbsp;&nbsp;' + unit + '&nbsp;&nbsp;' + village; //+ '&nbsp;&nbsp;' + sDate + '&nbsp;&nbsp;' + eDate;

        }
        function getTotalText() {
            if ($("select#upazila").val() == '0') {
                return "District";
            } else if ($("select#union").val() == '0') {
                return "Upazila";
            } else if ($("select#unit").val() == '0') {
                return "Union";
            } else if ($("select#village").val() == '0') {
                return "Unit";
            }
        }
    });
</script>
<section class="content-header"> 
    <h1>Eligible couple registration status<small></small></h1>
</section>
<section class="content">
    <div class="row" id="areaDropDownPanel">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-body">
                    <form role="form" id="reportingunionfpi">
                        <input type="hidden" value="${userLevel}" id="userLevel">
                        <div class="row">
                            <div class="col-md-1 col-xs-2">
                                <label for="district">Division</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="division" id="division"> 
                                    <option value="">- Select Division -</option>
                                </select>
                            </div>
                            <div class="col-md-1 col-xs-2">
                                <label for="district">District</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="district" id="district">
                                    <option value="">- Select District -</option>
                                </select>
                            </div>
                            <div class="col-md-1 col-xs-2">
                                <label for="upazila">Upazila</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="upazila" id="upazila" >
                                    <option value="">- Select Upazila -</option>
                                </select>
                            </div>
                            <div class="col-md-1 col-xs-2">
                                <label for="union">Union</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="union" id="union" >
                                    <option value="">- Select Union -</option>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <span id="unitDiv">
                                <div class="col-md-1 col-xs-2">
                                    <label for="unit">Unit</label>
                                </div>
                                <div class="col-md-2 col-xs-4">
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="unit" id="unit" >
                                        <option value="">- select Unit -</option>
                                    </select>
                                </div>
                            </span>
                            <span id="villDiv">
                                <div class="col-md-1 col-xs-2">
                                    <label for="village">Village</label>
                                </div>
                                <div class="col-md-2 col-xs-4">
                                    <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="village" id="village" >
                                        <option value="">- select Village -</option>
                                    </select>
                                </div>
                            </span>
                        </div>

                        <div class="row">
                            <div class="col-md-1 col-xs-2">
                                <label for="reportType">Level</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <label><input type="radio" class="aggregate" id="aggregate" name="reportType" value="aggregate"> <span class="type-inactive  warp">Aggregate</span></label>
                            </div>
                            <div class="col-md-2 col-xs-4 individualBlock">
                                <label><input type="radio" class="individual" id="individual" name="reportType" value="individual" disabled="true"> <span class="type-inactive warp">Individual</span></label>
                            </div>
                        </div>

                        <div class="row" id="viewTypeBlock">
                            <div class="col-md-1 col-xs-12">
                                <label for="viewType">Type</label>
                            </div>
                            <div class="col-md-2 col-xs-6">
                                <label><input type="radio" id="atPoint" name="viewType" value="atPoint"> <span class="view-inactive warp">Progress on a date</span></label>
                            </div>
                            <div class="col-md-2 col-xs-6">
                                <label><input type="radio" id="monthly" name="viewType" value="monthly"> <span class="view-inactive warp">Monthly progress</span></label>
                            </div>
                            <div class="col-md-2 col-xs-6">
                                <label><input type="radio" id="yearly" name="viewType" value="yearly"> <span class="view-inactive warp">Yearly progress</span></label>
                            </div>
                            <div class="col-md-4 col-xs-6">
                                <label><input type="radio" id="periodical" name="viewType" value="periodical"> <span class="view-inactive warp">Periodic performance</span></label>
                            </div>
                        </div>

                        <div class="row" id="dateBlock">
                            <div class="col-md-1 col-xs-2">
                                <label for="one" id="">Date</label>
                            </div>
                            <span id="_atPoint">
                                <input type="hidden" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="startDate" id="startDate" />
                                <div class="col-md-1 col-xs-1">
                                    <label for="one" id="">On</label>
                                </div>
                                <div class="col-md-2 col-xs-3">
                                    <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="endDate" id="endDate" />
                                </div>
                            </span>

                            <span id="_periodical">
                                <div class="col-md-1 col-xs-1">
                                    <label for="one" id="">From</label>
                                </div>
                                <div class="col-md-2 col-xs-3">
                                    <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="periodicalStartDate" id="periodicalStartDate" />
                                </div>
                                <div class="col-md-1 col-xs-1">
                                    <label for="one" id="">To</label>
                                </div>
                                <div class="col-md-2 col-xs-3">
                                    <input type="text" class="input form-control input-sm datePickerChoose" placeholder="dd/mm/yyyy" name="periodicalEndDate" id="periodicalEndDate" />
                                </div>
                            </span>

                            <span id="_monthly">
                                <div class="col-md-1 col-xs-1">
                                    <label for="one" id="">From</label>
                                </div>
                                <div class="col-md-2 col-xs-3">
                                    <input type="text" class="form-control input-sm mtz-monthpicker-widgetcontainer monthPickerChoose" placeholder="mm/yyyy" name="startMonthYear" id="startMonthYear">
                                </div>
                                <div class="col-md-1 col-xs-1">
                                    <label for="one" id="">To</label>
                                </div>
                                <div class="col-md-2 col-xs-3">
                                    <input type="text" class="form-control input-sm mtz-monthpicker-widgetcontainer monthPickerChoose" placeholder="mm/yyyy" name="endMonthYear" id="endMonthYear">
                                </div>
                            </span>

                            <span id="_yearly">
                                <div class="col-md-1 col-xs-1">
                                    <label for="one" id="">From</label>
                                </div>
                                <div class="col-md-2 col-xs-3">
                                    <select class="form-control input-sm" name="startYear" id="startYear">
                                        <option value="">- select Year -</option>
                                    </select>
                                </div>
                                <div class="col-md-1 col-xs-1">
                                    <label for="one" id="">To</label>
                                </div>
                                <div class="col-md-2 col-xs-3">
                                    <select class="form-control input-sm" name="endYear" id="endYear">
                                        <option value="">- select Year -</option>
                                    </select>
                                </div>
                            </span>
                        </div>

                        <div class="row">
                            <span class="viewBtnBlock">
                                <div class="col-md-1 col-xs-2 btn-label col-md-offset-4 col-xs-offset-2">
                                    <label for="one" id=""></label>
                                </div>
                                <div class="col-md-2 col-xs-4">
                                    <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-flat btn-primary btn-block btn-sm bold" autocomplete="off">
                                        <i class="fa fa-bar-chart" aria-hidden="true"></i>&nbsp; Show Data
                                    </button>
                                </div>
                            </span>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row info-box-md-container prs-info">
        <div class="col-md-6">
            <div class="row">
                <div class="col-md-6 col-xs-6" id="btn-table">
                    <div class="info-box bg-white selected-color clickable">
                        <span class="info-box-icon bg-aqua"><i class="fa fa-table"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text"><h4></h4></span>
                            <span class="info-box-number center">Table</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-xs-6" id="btn-chart">
                    <div class="info-box bg-white clickable">
                        <span class="info-box-icon bg-aqua"><i class="fa fa-pie-chart"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text"><h4></h4></span>
                            <span class="info-box-number center">Chart</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--Transparent Text For Blank Space-->        
    <!--    <section class="content-header" id="transparentTextForBlank" style="display: block;">
            <center class="emis_hologram">eMIS</center>
        </section>-->

    <!--Elco Data Table-->
    <div class="box box-primary full-screen" id="tableView">
        <div class="box-header with-border" style="padding: 0px;">
            <p class="box-title bold" style="font-size: 15px;padding: 2px;padding-left: 5px;"></p>
            <div class="box-tools pull-right" style="margin-top: -10px;">
                <button type="button" class="btn btn-flat btn-default btn-xs bold" id="exportPrint"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print - PDF</button>
                <a href="#" id="exportCSV" role="button" class="btn btn-flat btn-default btn-xs bold" style="width:80px;"><i class="fa fa-file-excel-o" aria-hidden="true"></i>&nbsp;Excel</a>
                <!--                <a href="#" id="exportText" role="button" class="btn btn-flat btn-default btn-xs bold" style="width:80px;"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Text</a>-->
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body">
            <div class="row">
                <div class="col-md-12 table-responsive">
                    <h2 class="viewTitle"><span class="label label-default"></span></h2>
                </div>
                <div class="col-md-12" id="table-col">
                    <div class="table-responsive fixed" >
                        <table id="data-table" class="table table-bordered table-striped table-hover">
                            <thead id="tableHeader" class="data-table">
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter">
                            </tfoot>
                        </table>
                    </div>
                </div>
                <div class="col-md-8 col-md-offset-2" id="progress-legend">
                    <table class="table borderless" style="margin-bottom: -2px; display: table;">
                        <thead>
                            <tr class="label-primary-">
                                <th class="text-center" style="background-color: #00A65A; width: 5%;height: 5%"></th>
                                <th> 100 - 96 </th>
                                <th class="text-center" style="background-color: #00e26d; width: 5%;height: 5%"></th>
                                <th> 95 - 90 </th>
                                <th class="text-center" style="background-color: #FFFF00; width: 5%;height: 5%"></th>
                                <th> 89 - 80 </th>
                                <th class="text-center" style="background-color: #FFA500; width: 5%;height: 5%"></th>
                                <th> 79 - 70 </th>
                                <th class="text-center" style="background-color: #ff3d3d; width: 5%;height: 5%"></th>
                                <th> 69 - 0 </th>
                            </tr>
                        </thead>
                    </table><br/>
                </div>
            </div>
        </div> 
        <!--For Print -->
        <div class="box-body"  id="printTable">
            <div id="dvData" align="center">
                <table class="table table-bordered table-striped table-hover">
                    <thead id="tableHeaderP" style="text-align: left">
                    </thead>
                    <tbody id="tableBodyP">
                    </tbody>
                    <tfoot id="tableFooterP">
                    </tfoot>
                </table>
            </div>
        </div>  
    </div>
    <div class="box box-primary full-screen" id="graphView">
        <div class="box-header with-border" style="padding: 0px;">
            <p class="box-title bold" style="font-size: 15px;padding: 2px;padding-left: 5px;"></p>
            <div class="box-tools pull-right" style="margin-top: -10px;">
                <button type="button" class="btn btn-flat btn-default btn-xs bold" id="exportPrintChart"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print - PDF</button>
                <a href="#" id="exportImageChart" download="eligible_couple.png" target="_blank" class="btn btn-flat btn-default btn-xs bold"><i class="fa fa-file-image-o" aria-hidden="true"></i>&nbsp;Image</a>
                <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="box-body" id="printChart">
            <div class="row">
                <div class="col-md-12 table-responsive">
                    <h2 class="viewTitle"><span class="label label-default"></span></h2>
                </div>
                <div class="col-md-10 col-md-offset-1" id="chartCanvas">
                    <div id="chart"></div>
                </div>
            </div><br/>
        </div>
    </div>
</section>
<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/themes/smoothness/jquery-ui.css">
<link href="resources/datepicker/MonthPicker.min.css" rel="stylesheet" type="text/css" />
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script src = "https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src="https://cdn.rawgit.com/digitalBush/jquery.maskedinput/1.4.1/dist/jquery.maskedinput.min.js"></script>
<script src="resources/datepicker/MonthPicker.min.js"></script>
<script>
    $(document).ready(function () {
        $(".select2").tooltip({
            content: '.'
        });
        $('#startMonthYear, #endMonthYear').MonthPicker({
            MaxMonth: 0,
            MinMonth: -11,
            Button: false
        });
    });
</script>
<style>
    .ui-tooltip {
        padding: 0px!important;
        position: absolute;
        z-index: 9999;
        max-width: 0px!important;
        -webkit-box-shadow: 0 0 0px #aaa!important;
        box-shadow: 0 0 0px #aaa!important;
        border: none;
        color: #fff;
    }
</style>
<script>
    $(document).ready(function () {
        $('#exportPrint').click(function () {
            var contents = $("#printTable").html();
            var frame1 = $('<iframe />');
            frame1[0].name = "frame1";
            frame1.css({"position": "absolute", "top": "-1000000px"});
            $("body").append(frame1);
            var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
            frameDoc.document.open();
            //Create a new HTML document.
            frameDoc.document.write('<html><head><title>eMIS Initiative</title>');

            frameDoc.document.write('</head><body>');
            //Append the external CSS file. //border-collapse: collapse;
            frameDoc.document.write('<style>table, th, td{border:1px solid black; border-collapse: collapse;padding:10px;}th{vertical-align: text-center} th td{text-align:left;} .area{text-align: left !important;}</style>');
            //Append the DIV contents.
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center!important;"><center>Eligible couple registration status</center></h3>');
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center!important;"><center>'+$('.viewTitle > .label').html()+'</center></h3>');
            frameDoc.document.write('<h5 style="color:black;text-align:center!important;"><center>' + areaText + '</center></h5>');
            frameDoc.document.write(contents);
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 500);
        });
        $('#exportPrintChart').click(function () {
            var dataUrl = document.getElementById('canvas').toDataURL(); //attempt to save base64 string to server using this var  
            var frame1 = $('<iframe />');
            frame1[0].name = "frame1";
            frame1.css({"position": "absolute", "top": "-1000000px"});
            $("body").append(frame1);
            var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
            frameDoc.document.open();
            //Create a new HTML document.
            frameDoc.document.write('<html><head><title>eMIS Initiative</title>');

            frameDoc.document.write('</head><body>');
            //Append the external CSS file. //border-collapse: collapse;
            frameDoc.document.write('<style>table, th, td{border:1px solid black; border-collapse: collapse;padding:10px;}th{vertical-align: text-center} td{text-align:right;}</style>');
            //Append the DIV contents.
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center"><center>Eligible couple registration status</center></h3>');
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center!important;"><center>'+$('.viewTitle > .label').html()+'</center></h3>');
            frameDoc.document.write('<h5 style="color:black;text-align:center"><center>' + areaText + '</center></h5>');
            frameDoc.document.write('<span style="text-align:center;"><center><img src="' + dataUrl + '"></span></center>');
            //frameDoc.document.write('</div>');
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 500);
        });
        $("#exportText").click(function (event) {
            var outputFile = "eMIS_eligible_couple_registration_status";
            outputFile = outputFile.replace('.txt', '') + '.txt';
            exportTableToText.apply(this, [$('#dvData > table'), outputFile]); //function call from TemplateHeader
        });
        $("#exportCSV").click(function (event) {
            var outputFile = "eMIS_eligible_couple_registration_status";
            outputFile = outputFile.replace('.csv', '') + '.csv';
            exportTableToCSV.apply(this, [$('#dvData > table'), outputFile]); //function call from TemplateHeader
        });
    });
</script>