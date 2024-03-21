$(function () {

    $.MIS = $.MIS || {
        init: function () {
            $.MIS.events.bindEvent();
        },
        events: {
            bindEvent: function () {
                $.MIS.events.viewMIS1();
            },
            viewMIS1: function () {
                $(document).off('click', '.mis1-view').on('click', '.mis1-view', function (e) {
                });
            }
        },
        ajax: {
        },
        renderMIS1: function (data) {
            //var data = JSON.parse(data);
            //submissionDate = data.modifydate.split(" ")[0]
            submissionDate = data.modifydate.split(" ")[0];
            data = JSON.parse(data.data);
            var pairs = Template.pairs();
            var version = Template.getVersion(pairs.year, pairs.month);
            Template.reset(version);

            var json = data.MIS, mis = data.MIS, lmis = data.LMIS;//, submissionDate = data.submissionDate;
            //Top area part
            function setHeaderArea(row) {
                var d = {r_unit_name: 'aaa', r_ward_name: 'bbbb', r_un_name: 'ccc', r_upz_name: 'ddd', r_dist_name: 'eee'};
                if (row) {
                    d = row;
                }
                $("#unitValue").html("&nbsp;<b>" + d.r_unit_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                $("#wardValue").html("&nbsp;<b>" + d.r_ward_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                $("#unionValue").html("&nbsp;<b>" + d.r_un_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                $("#upazilaValue").html("&nbsp;<b>" + d.r_upz_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                $("#districtValue").html("&nbsp;<b>" + d.r_dist_name + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                $("#yearValue").html("<b>" + convertE2B($("#year :selected").text()) + "&nbsp;&nbsp;&nbsp;&nbsp;</b>");
                $("#monthValue").html("<b>" + $("#month :selected").text() + "</b>");
            }
            setHeaderArea(json[0]);
            if (submissionDate === undefined) {
                submissionDate = "........................................";
            } else {
                submissionDate = e2b(convertToUserDate(submissionDate));
            }
            $("#submissionDate").html("&nbsp;&nbsp;<b>" + submissionDate + "</b>");
            //Data rendering into table
            var $tables = $('table', Template.context);

            //Data rendering into table
            var mis_data = mis[0] || {};
            if (!mis_data.r_car && mis_data.r_unit_capable_elco_tot) {
                var r_car = 0;
                //console.log('recalculating>> r_car', r_car);
                r_car = $.app.percentage(mis_data.r_unit_all_total_tot, mis_data.r_unit_capable_elco_tot, 2);
                //console.log('recalculated>> r_car', r_car);
                mis_data.r_car = r_car;
            }
            var NA = [], SKIP = ['r_car', 'r_unit_all_total_tot', 'r_unit_capable_elco_tot'];
            $.each(mis_data, function (k, v) {
                var _k = '[id$=' + k.replace(/^(r|v)_/, '') + ']', _v = Template.reportValue(v, ~SKIP.indexOf(k));
                var $k = $tables.find(_k);
                if ($k.length) {
                    $k.html(_v);
                } else {
                    NA.push(_k);
                    //console.log('mis', k, $k.length, _v);
                }
            });

            console.log("Missing variables (NA):", NA);
            //LMIS
            var $stockvacuum = {
                1: 'ক',
                2: 'খ',
                3: 'গ',
                4: 'ঘ'
            }
            $.each(lmis, function (k, v) {
                $row = e2b(finiteFilter(v));
                if (k.split("_")[0] == "stockvacuum")
                    $row = $stockvacuum[v];
                $('.mis_table').find('#' + k).html($row);
            });
        }
    };
    $.MIS.init();
});