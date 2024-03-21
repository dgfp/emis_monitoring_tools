/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * THIS FILE USED IN /loginUser - ADD USER (monitoring tools)
 */

$(function () {
    $('select#userLevel').change(function (event) {
        var type = $("select#userLevel").val();
        console.log(type);
        showHideGeo(type);
    });

    function showHideGeo(expression) {
        switch (expression) {
            case "0":
                $('.section-geo-report').addClass('hide');
                resetOptions(['#multiSelDivision', '#multiSelDistrict', 'multiSelReportingUpazila', 'multiSelReportingUnion']);
                destroyMultiselect(['#multiSelDivision', '#multiSelDistrict']);
                break;
            case "1":
                //CENTRAL
                $('.section-geo-report').addClass('hide');
//                resetOptions(['#multiSelDivision', '#multiSelDistrict', 'multiSelReportingUpazila', 'multiSelReportingUnion']);
                destroyMultiselect(['#multiSelDivision', '#multiSelDistrict']);
                break;
            case "2":
                //DIVISION
                $('.section-geo-report').removeClass('hide');
                $('#multiSelDivisionContainer').removeClass('hide');

                $('#multiSelDistrictContainer').addClass('hide');
                $('#multiSelUpazilaContainer').addClass('hide');
                $('#multiSelUnionContainer').addClass('hide');
                init();
//                resetOptions(['#multiSelDistrict', 'multiSelReportingUpazila', 'multiSelReportingUnion']);
                break;
            case "3":
                //DISTRICT
                $('.section-geo-report').removeClass('hide');
                $('#multiSelDivisionContainer').removeClass('hide');
                $('#multiSelDistrictContainer').removeClass('hide');

                $('#multiSelUpazilaContainer').addClass('hide');
                $('#multiSelUnionContainer').addClass('hide');
                
                generateGeoTree('district');
                break;
            case "4":
                //UPAZILA
                $('.section-geo-report').removeClass('hide');
                $('#multiSelDivisionContainer').removeClass('hide');
                $('#multiSelDistrictContainer').removeClass('hide');
                $('#multiSelUpazilaContainer').removeClass('hide');
                
                $('#multiSelUnionContainer').addClass('hide');
                break;
            case "5":
                //UNION
                $('.section-geo-report').removeClass('hide');
                $('#multiSelDivisionContainer').removeClass('hide');
                $('#multiSelDistrictContainer').removeClass('hide');
                $('#multiSelUpazilaContainer').removeClass('hide');
                $('#multiSelUnionContainer').removeClass('hide');
                break;
            case "7": //-- provider? whats the purpose?
                $('.section-geo-report').addClass('hide');
                break;
            default:
                $('.section-geo-report').addClass('hide');
        }
    }
    ;
    function init() {
        $('#multiSelDistrict').multiselect({buttonWidth: '100%'});
        $('#multiSelReportingUpazila').multiselect({buttonWidth: '100%'});
        
        $.ajax({
            url: "GeoJsonProviderServlet?action=getDivision",
            data: {data: null},
            type: "POST",
            dataType: 'json',
            success: function(data, textStatus, jqXHR){
                loadDivisionSuccess(data, textStatus, jqXHR, '#multiSelDivision');
            },
            error: ajaxFailure
        });
    }

    init();



    function loadDivisionSuccess(data, textStatus, jqXHR, selector) {
        var select = $(selector);
        select.empty();
        select.multiselect('destroy');
        var $opts = UTIL.generateDropdownOpt(selector, data, 'Please Select Division');
        select.append($opts);
//        select.multiselect('rebuild');
        select.multiselect({
            buttonWidth: '100%',
            includeSelectAllOption: true,
            maxHeight: 200,
            onSelectAll: function (options) {
                var optSelected = this.$select.val();
                loadDistrict(optSelected, '#multiSelDistrict');
            },
            onDeselectAll: function (options) {

            },
            onChange: function (option, checked, select) {
                var optSelected = this.$select.val();
                console.log(this, this.$select.closest('div.form-group').next().find('select'));
                loadDistrict(optSelected, '#multiSelDistrict');
            }
        });
    }
    ;

    function loadDistrict(divisions, selector) {
        if (!divisions) {
            return false;
        }
        var data = JSON.stringify({"divisions": divisions});
        $.ajax({
            url: "GeoJsonProviderServlet?action=getDistricts",
            data: {data: data},
            type: "POST",
            success: function(data, textStatus, jqXHR){
                console.log(data);
                loadDistrictSuccess(data, textStatus, jqXHR, selector);
            },
            error: ajaxFailure
        });
    }
    ;

    function loadDistrictSuccess(data, textStatus, jqXHR, selector) {
        data = JSON.parse(data);
        var select = $('#multiSelDistrict');
        select.multiselect('destroy');
        select.empty();
        var $opts = UTIL.recursiveGenerateOptionGroup(data, $('#multiSelDistrict'), $('<optgroup>'), $('<option>'));
//        select.append($opts);
        select.multiselect({
            buttonWidth: '100%',
            maxHeight: 200,
            includeSelectAllOption: true,
            enableClickableOptGroups: true,
            onSelectAll: function (options) {
                var optSelected = this.$select.val();
                var optSelectedParent = this.$select.attr('parent')
                loadUpazila({"upazilaId": optSelected, "zillaId": optSelectedParent});
            },
            onDeselectAll: function (options) {

            },
            onChange: function (option, checked, select) {
                var optSelected = this.$select.val();
                loadUpazila(optSelected);
            }
        });
//        resetMultiselect(select);
        select.multiselect('rebuild');
    }
    ;

    function loadUpazila(districts) {
        if (!districts) {
            return false;
        }
        var data = JSON.stringify(formatUpazilaData(districts));
        $.ajax({
            url: "GeoJsonProviderServlet?action=getReportingUpazila",
            data: {data: data},
            type: "POST",
            success: loadUpazilaSuccess,
            error: ajaxFailure
        });
    }
    ;

    function loadUpazilaSuccess(data, textStatus, jqXHR) {
        console.log(data);
    }
    ;

    function formatUpazilaData(values) {
        console.log(values);
        var results = [];
        for (var item of values) {
            var strSplit = item.split(",");
            var zillaId = strSplit[0];
            var parents = strSplit[1].split("-");
            var divisionId = parents[0];
            var obj = {
                "divisions": divisionId,
                "districts": zillaId
            };
            results.push(obj);
        }
        return results;

    }
    ;

    function destroyMultiselect(selectors) {
        $.each(selectors, function (index, value) {
            $(value).multiselect('destroy');
            $(value).empty();
            $(value).multiselect('rebuild');
        });
    }
    ;

    function resetMultiselect(selector) {
        selector.find('option:selected').each(function () {
            $(this).prop('selected', false);
        });
    }
    ;

    function resetOptions(selectors) {
        $.each(selectors, function (index, value) {
            $(value).find('option').remove();
            $('<option>').val("0").text('- Please select -').appendTo(value);
        });
    }
    ;

    function ajaxFailure(jqXHR, textStatus, errorThrown) {
        toastr["error"](errorThrown);
    }
    ;
    
    function generateGeoTree(type, selector){
        var selector = selector || '#multiSelDistrictTree';
        console.log($(selector));
    }
//    UTIL.request('GeoJsonProviderServlet?action=getDivision', {}, 'POST').then(function (resp) {
//        var select = $('#multiSelDivision');
//        var $opts = UTIL.generateDropdownOpt('#multiSelDivision', resp, 'Please Select Division');
//        select.append($opts);
////        select.multiselect('rebuild');
//        select.multiselect({
//            buttonWidth: '100%',
//            includeSelectAllOption: true,
//            onSelectAll: function (options) {
//                console.log(options);
//            },
//            onDeselectAll: function (options) {
//
//            },
//            onChange: function (option, checked, select) {
//                console.log(option, checked, select);
//            }
//        });
//    });
});
