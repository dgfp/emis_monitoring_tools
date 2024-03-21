$(function () {
    $.PRS = $.PRS || {
        divid: "#divid",
        zillaid: "#zillaid",
        upazilaid: "#upazilaid",
        unionid: "#unionid",
        area: null,
        viewType: null,
        tableHeader: $('#tableHeader'),
        tableBody: $('#tableBody'),
        tableFooter: $('#tableFooter'),
        dataTable: $('#data-table'),
        init: function () {
            //$.PRS.events.bindEvent();
            $("#areaPanel").slideDown("slow");
            $("#areaPanel").after($.app.getWatermark());
        },
        events: {
            bindEvent: function () {
//                    $.PRS.events.exportPrint();
//                    $.PRS.events.exportCSV();
//                    $.PRS.events.exportPrintChart();
            },
            viewData: function () {
                $(document).off('submit', '#showData').on('submit', '#showData', function (e) {
                    e.preventDefault();
                    $("#tableView").fadeOut(200);
                    $("#graphView").fadeOut(200);
                    $(".PRS-info").fadeOut(200);
                    $("#tableFooter").remove();
                    $(".colspan").attr('colspan', 3);
                    $(".PRSProgress").show();
                    var area = $.app.pairs('form');
                    if (area.divid == "") {
                        $.toast('Please select division', 'error')();
                        return false;
                    }
                    $.PRS.ajax.viewData(area);
                });
            },
            exportPrint: function () {
                $(document).off('click', '#exportPrint').on('click', '#exportPrint', function (e) {
                    $.PRS.dataTableLength = $('select[name=data-table_length]').val();
                    $($.PRS.dataTable).DataTable().page.len(-1).draw();
                    $.export.print($("#export").html(), $.PRS.title, $.PRS.getArea());
                });
            },
            exportCSV: function () {
                $(document).off('click', '#exportCSV').on('click', '#exportCSV', function (e) {
                    $.PRS.dataTableLength = $('select[name=data-table_length]').val();
                    $($.PRS.dataTable).DataTable().page.len(-1).draw();
                    $.export.excel($.PRS.dataTable);
                });
            },
            exportPrintChart: function () {
                $(document).off('click', '#exportPrintChart').on('click', '#exportPrintChart', function (e) {
                    $.export.printChart($.PRS.title, $.PRS.getArea());
                });
            }
        },
        ajax: {
        },
        viewLevel: {
            1: ["District", "zilanameeng", 1],
            2: ["Upazila", "upazilanameeng", 2],
            3: ["Union", "unionnameeng", 3],
            4: ["Union", "unionnameeng", 3]
        },
        getViewType: function (json, i) {
            if (json.zillaid == "0")
                return $.PRS.viewLevel[1][i];
            else if (json.upazilaid == "0")
                return $.PRS.viewLevel[2][i];
            else if (json.unionid == "0")
                return $.PRS.viewLevel[3][i];
            else
                return $.PRS.viewLevel[4][i];
        },
        progressHide: function () {
            $(".colspan").attr('colspan', 2);
            $(".PRSProgress").hide();
        },
        getArea: function () {
            var area = "Division: " + $("#divid option:selected").text();
            area += "&nbsp; District: " + $("#zillaid option:selected").text();
            area += "&nbsp; Upazila: " + $("#upazilaid option:selected").text();
            area += "&nbsp; Union: " + $("#unionid option:selected").text();
            area += "&nbsp; From: " + $("#startDate").val();
            area += "&nbsp; To: " + $("#endDate").val();
            return area;
        },
        setChartCanvasSize: function (jsonLen) {
            $('#chartCanvas').removeAttr('class').attr('class', '');
            if (jsonLen == 1 || jsonLen == 2 || jsonLen == 3 || jsonLen == 4)
                $('#chartCanvas').addClass("col-md-6 col-md-offset-3");
            else if (jsonLen == 5 || jsonLen == 6 || jsonLen == 7 || jsonLen == 8)
                $('#chartCanvas').addClass("col-md-8 col-md-offset-2");
            else
                $('#chartCanvas').addClass("col-md-12");
        },
        resetSwitchBtn: function (prsType) {
            $(".prs-info").find('.selected-color').removeClass('selected-color');
            switch (prsType) {
                case 'Progress of Population Registration':
                    $(".prs-info").find('.info-box:eq( 2 )').addClass("selected-color");
                    break;
                default:
                    $(".prs-info").find('.info-box').first().addClass("selected-color");
            }
        }
    };
    $.PRS.init();
});