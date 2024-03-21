/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 * NIBRAS AR RAKIB
 */
var UTIL = (function (k, w) {
    "use strict";
    // SEARCH FROM MENU
    var getWardByUnit = function (unit) {
        var unitWardMap = {
            '1': 1,
            '1CHA': 1,
            '1GA': 1,
            '1GHA': 1,
            '1KA': 1,
            '1KHA': 1,
            '1UMA': 1,
            '2': 2,
            '2CHA': 2,
            '2GA': 2,
            '2GHA': 2,
            '2KA': 2,
            '2KHA': 2,
            '2UMA': 2,
            '3': 3,
            '3CHA': 3,
            '3GA': 3,
            '3GHA': 3,
            '3KA': 3,
            '3KHA': 3,
            '3UMA': 3
        }
        return unitWardMap[unit];
    };
    var filterReset = function (wrapwords) {
        $.each(wrapwords, function (index, item) {
            $(item).closest("li").removeClass('hide');
            $(item).closest('li.level-0').removeClass('active');
        });
    };
    var setInitialState = function (selected) {
        selected.addClass('active');
        selected.closest('li.level-0').addClass('active');
    };
    var highlightText = function (text, substr, originalText) {
        var newText = text.replace(substr, "<b class='highlight'>" + substr + "</b>");
//        console.log(newText);
        return newText;
    };
    var unhighlightText = function (wordwrap) {
        $.each(wordwrap, function (index, item) {
            $(item).find('b.highlight').contents().unwrap();
        });
    };
    var filterInit = function (wrapwords, text) {
        var t = text.toLowerCase();
        $.each(wrapwords, function (index, item) {
            var el = $(item);
            var itemText = el.text().toLowerCase();
            var originalText = el.text();
            if (itemText.indexOf(t) > -1) {
                var str = itemText.substr(itemText.indexOf(t), text.length);
                var newText = highlightText(itemText, str, originalText);
                el.html(newText);
                el.closest('li.level-0').addClass('active');
                el.closest("li").removeClass('hide');
            } else {
                el.closest("li").addClass('hide');
            }
        });
    };
    var inputText = function (event) {
        var input = $(this);
        var val = input.val();
        var sidebar = $(event.data.sidebar);
        var selected = sidebar.find('li.active').not('.level-0');
        var wrapwords = sidebar.find('.wrapword').closest('li').not('.level-0').find('.wrapword');
        val ? filterInit(wrapwords, input.val()) : (filterReset(wrapwords), setInitialState(selected), unhighlightText(wrapwords));
    };
    // AJAX REQUEST eMIS
    var requestEmis = function (url, data, type) {
        var dfd = $.Deferred();
        console.log(data);
        var xhr = $.ajax({
            url: url,
            data: data || {},
            type: type || "POST",
            dataType: 'json'
        });
        xhr.done(function (response) {
            var r = response;

            var v = r instanceof Array ? "GET" : true;
            if (v) {
                dfd.resolve(r);
            } else {
                dfd.reject(r);
                alert(r.message);
            }
        }).fail(function (response) {
            alert("Request Failed" + " Response Status:-" + response.status + ", Status Text:-" + response.statusText);
        }).always(function (response) {
//            console.log("Always", response);
        });
        return dfd.promise();
    }
    //AJAX REQUEST
    var request = function (url, data, type) {
        var dfd = $.Deferred();
        var xhr = $.ajax({
            url: url,
            data: data || {},
            type: type || "POST"
        });
        xhr.done(function (response) {
            try {
                var r = JSON.parse(response);
                dfd.resolve(r);
            } catch (ex) {
                console.log(response);
                toastr["error"]("<h4><b>" + ex + "</b></h4>");
            }

//            var v = r instanceof Array ? "GET" : true;
//            if (v) {
//                dfd.resolve(r);
//            } else {
//                dfd.reject(r);
//                alert(r.message);
//            }
        }).fail(function (response) {
            alert("Request Failed" + " Response Status:-" + response.status + ", Status Text:-" + response.statusText);
        }).always(function (response) {
//            console.log("Always", response);
        });
        return dfd.promise();
    };
    //GET MODAL
    var generateModal = function () {

    };
    //GET DUPES FROM OBJ
    var getDupesUFPO = function (arr, k1, k2) {
        var dupes = {};
        var ids = [];
        for (var i = 0; i < arr.length; i++) {
            if (arr[i][k1] && arr[i][k2]) {
                var assign_type = +arr[i][k2];
                if (dupes.hasOwnProperty(arr[i][k1])) {

                    if (dupes[arr[i][k1]].includes(assign_type) && assign_type === 1) { // dupes[arr[i][k1]].includes(1) would be suffice
                        ids.push(arr[i][k1]);
                    }
                    dupes[arr[i][k1]].push(assign_type);
                } else {
                    dupes[arr[i][k1]] = [assign_type];
                }
            }
        }
        return $.unique(ids);
    };
    //Generate Assign Type Dropdown
    var getAssignTypeDropdownUFPO = function (d, eId) {
        var option = "<option class='bold' value='0' selected>-Select Assign Type-</option>";
        $.each([{id: 1, title: 'Main'}, {id: 2, title: 'Additional'}], function (i, o) {
            var selected = d["assign_type"] == o.id ? "selected" : "";
            option += "<option value='" + o.id + "' " + selected + ">" + o.title + "</option>";
        });
        return '<select class="form-control select2" id="assign_type_reporting_upazila" name="assign_type_reporting_upazila" data-rowname="assign_type" style="width: 100%;" tabindex="-1" aria-hidden="true">' + option + '</select>';
    };

    var getAssignTypeDropdown = function (d, eId) {
        var option = "<option class='bold' value='0' selected>-Select Assign Type-</option>";
        $.each([{id: 1, title: 'Main'}, {id: 2, title: 'Additional'}], function (i, o) {
            var selected = d["assign_type"] == o.id ? "selected" : "";
            option += "<option value='" + o.id + "' " + selected + ">" + o.title + "</option>";
        });
        return '<select class="form-control select2" id="assign_type" name="assign_type" data-rowname="assign_type" style="width: 100%;" tabindex="-1" aria-hidden="true">' + option + '</select>';
    };

    var getAssignTypeDropdownTable = function (d, className) {
        var option = "<option class='bold' value='0' selected>-Select Assign Type-</option>";
        $.each([{id: 1, title: 'Main'}, {id: 2, title: 'Additional'}], function (i, o) {
            var selected = d["assign_type"] == o.id ? "selected" : "";
            option += "<option value='" + o.id + "' " + selected + ">" + o.title + "</option>";
        });
        return '<select class="form-control select2 ' + className + '" data-rowname="assign_type" style="width: 100%;" tabindex="-1" aria-hidden="true">' + option + '</select>';
    };

    var unassignGenerateReasonType = function () {
        var option = "<option class='bold' value='' selected>-Reason for change-</option>";
        $.each([{id: 1, title: 'Transfer'}, {id: 2, title: 'Retirement'}, {id: 3, title: 'Leave'}, {id: 4, title: 'Promotion'}
            , {id: 5, title: 'Correction/ Unassign'}, {id: 6, title: 'Redistribute'}], function (i, o) {
            option += "<option value='" + o.id + "'>" + o.title + "</option>";
        });
        return '<select class="form-control select2" id="unassign_reason_type" name="unassign_reason_type" data-rowname="assign_type" style="width: 100%;" tabindex="-1" aria-hidden="true">' + option + '</select>';
    };

    var leaveType = function () {
        var option = "<option class='bold' value='' selected>-Reason for change-</option>";
        $.each([{id: 1, title: 'Earn Leave'}, {id: 2, title: 'Extra Ordinary Leave'}, {id: 3, title: 'Maternity leave'}
            , {id: 4, title: 'Study Leave'}, {id: 5, title: 'Study Leave, Average Pay'}, {id: 6, title: 'Study Leave, Half Average pay'}
            , {id: 7, title: 'Study Leave, Without Pay'}, {id: 8, title: 'Earn Leave, Average Pay'}, {id: 10, title: 'Earn  Leave, Half Average Pay'}
            , {id: 10, title: 'Rest & Recreation Leave'}, {id: 11, title: 'Special Disability Leave'}, {id: 12, title: 'Extra Ordinary Leave Without Pay'}
            , {id: 13, title: 'Ex Bangladesh Leave'}, {id: 14, title: 'Ex Bangladesh Leave, Average Pay'}, {id: 15, title: 'Ex Bangladesh Leave, Half Average Pay'}
            , {id: 16, title: 'Ex Bangladesh Leave Without Pay'}, {id: 17, title: 'Earn Leave Without Pay'}, {id: 18, title: 'Unauthorized'}]
                , function (i, o) {
                    option += "<option value='" + o.id + "'>" + o.title + "</option>";
                });
        return '<select class="form-control select2" id="leave_type" name="leave_type" style="width: 100%;" tabindex="-1" aria-hidden="true">' + option + '</select>';
    }

    var generateAllDistrict = function () {
        var dfd = $.Deferred();
        $.get('DistrictJsonDataProvider', function (response) {
            var j = JSON.parse(response);
            var option = "<option class='bold' value='' selected>-Select District-</option>";
            $.each(j, function (i, o) {
                option += "<option value='" + o.zillaid + "'>" + o.zillanameeng + "</option>";
            });
            var s = '<select class="form-control select2" id="district_all" name="district_all" style="width: 100%;" tabindex="-1" aria-hidden="true">' + option + '</select>';
            dfd.resolve(s);
        });
        return dfd.promise();
    };

    var generateUpazila = function (did) {
        var dfd = $.Deferred();
        console.log(did);
        $.get('UpazilaJsonProvider?districtId=' + did, function (response) {
            var j = JSON.parse(response);
            var option = "<option class='bold' value='' selected>-Select Upazila-</option>";
            $.each(j, function (i, o) {
                if (o.upazilaid != 999) {
                    option += "<option value='" + o.upazilaid + "'>" + o.upazilanameeng + "</option>";
                }
            });
            var s = option;
            dfd.resolve(s);
        });
        return dfd.promise();
    };

    var generateUnion = function (did, upazilaid) {
        var dfd = $.Deferred();
        $.get('UnionJsonProvider?zilaId=' + did + "&upazilaId=" + upazilaid, function (response) {
            var j = JSON.parse(response);
            var option = "<option class='bold' value='' selected>-Select Union-</option>";
            $.each(j, function (i, o) {
                if (o.unionid != 999) {
                    option += "<option value='" + o.unionid + "'>" + o.unionnameeng + "</option>";
                }
            });
            var s = option;
            dfd.resolve(s);
        });
        return dfd.promise();
    }

    var generateReportingUpazila = function (data, conditionArray, selectTag) {
        var select = $(selectTag);
        select.find('option').remove();
        $('<option>').val("").text('-Select Reporting Upazila-').appendTo(select);
        var $opts = [];
        for (var i = 0; i < data.length; i++) {
            var id = data[i].upazilaid;
            var name = data[i].upazilanameeng;
            $opts.push($('<option>').val(id).text(name + ' [' + id + ']'));
        }
        select.append($opts);
    };

    var generateReportingUnion = function (data, conditionArray, selectTag) {
        var select = $(selectTag);
        select.find('option').remove();
        $('<option>').val("").text('-Select Reporting Union-').appendTo(select);
        var $opts = [];
        for (var i = 0; i < data.length; i++) {
            var id = data[i].unionid;
            var name = data[i].unionnameeng;
            $opts.push($('<option>').val(id).text(name + ' [' + id + ']'));
        }
        select.append($opts);
    };

    var generateReportingUnionWithReportingUnionid = function (data, conditionArray, selectTag) {
        var select = $(selectTag);
        select.find('option').remove();
        $('<option>').val("").text('-Select Reporting Union-').appendTo(select);
        var $opts = [];
        for (var i = 0; i < data.length; i++) {
            var id = data[i].reporting_unionid;
            var name = data[i].unionnameeng;
            $opts.push($('<option>').val(id).text(name + ' [' + id + ']'));
        }
        select.append($opts);
    };

    var generateUnit = function (data, conditionArray, selectTag) {
        //console.log("mdata",data); console.log("conditionArray",conditionArray);
        //console.log("selectTag",selectTag);
        var select = $(selectTag);
        select.find('option').remove();
        $('<option>').val("").text('-Select Reporting Unit-').appendTo(select);
        var $opts = [];
        for (var i = 0; i < data.length; i++) {
            var id = data[i].ucode;
            var name = data[i].uname;
            $opts.push($('<option>').val(id).text(name + ' [' + id + ']'));
        }
        select.append($opts);
    };
    var getUnion = function (z, u, s, n, m) {
        if (!n) {
            console.error("No name provided");
            return false;
        }
        var multiple = "";
        if (m) {
            multiple = "multiple";
        }
        var dfd = $.Deferred();
        $.get('UnionJsonProvider', {
            zilaId: z, upazilaId: u
        }, function (response) {
            var options = "";
            var optionList = JSON.parse(response);
            $.each(optionList, function (i, o) {
                if (o.unionid != 999) {
                    options += "<option value='" + o.unionid + "'>" + o.unionnameeng + "</option>";
                }
            });
            var html = '<select id="multiple_union" name=' + n + ' class="form-control" ' + multiple + '="' + multiple + '">' + options + '</select>';
            dfd.resolve(html);
        });
        return dfd.promise();
    };

    var getVillage = function (z, u, un, s, n, m) {
        if (!n) {
            console.error("No name provided");
            return false;
        }
        var multiple = "";
        if (m) {
            multiple = "multiple";
        }
        var dfd = $.Deferred();
        $.post('village-json-provider-by-reporitng-union', {
            zillaId: z, upazilaId: u, unionId: un
        }, function (response) {
            var options = "";
            var optionList = JSON.parse(response);
            console.log("optionList", optionList);
            $.each(optionList, function (i, o) {
                options += "<option value='" + o.unionid + " " + o.mouzaid + " " + o.villageid + "'>" + o.villagename + "</option>";
            });
            var html = '<select id="villages" name=' + n + ' class="form-control" ' + multiple + '="' + multiple + '">' + options + '</select>';
            dfd.resolve(html);
        });
        return dfd.promise();
    };

    var containsAll = function (needles, haystack) {
        for (var i = 0; i < needles.length; i++) {
            if ($.inArray(needles[i], haystack) == -1)
                return false;
        }
        return true;
    };

    var clearNewUnion = function () {
        var ub = $('#unionname');
        var ue = $('#unionnameeng');
        var ubv = ub.val();
        var uev = ue.val();
        if (ubv || uev) {
            ub.val('');
            ue.val('');
        }
    };

    var validateGeneral = {
        validateUpazila: function (d) {
            var selector = d; //select#unit,select#provCode,
            return $(selector).isValidAll();
        }
    };

    var validateReportingGeo = {
        validateFPIForm: function (data, isNewUnion) {
            var d = data,
                    newUnion = newUnion;
            var empty = [];
            var msg = {

            };
            var fail = false;
            $.each(d, function (k, v) {
                if (!v || v == "0") {
                    empty.push(k);
                }
            });
            if (empty.length) {
                console.log(containsAll(['unionname', 'unionnameeng']), Object.keys(data), isNewUnion);
                if (containsAll(['unionname', 'unionnameeng'], Object.keys(data)) && isNewUnion) {
                    console.log("ERror for new union");
                    fail = true;
                } else {
                    var tmp = empty.filter(function (v) {
                        return v != "unionname" && v != "unionnameeng" && v != "request_from";
                    });
                    console.log(tmp)
                    if (tmp.length) {
                        fail = true;
                        console.log("Error for General");
                    }
                }
            }
            return fail;
        },
        validateFWAForm: function (data, formInput) {
            var validate = true;
            $.each(data, function (i, d) {
                if (!d.value) {
                    validate = false;
                    return false;
                }
            });
            console.log(data.length, formInput.length, validate);
            if (data.length < formInput.length || !validate) {
                validate = false;
                return validate;
            }
            return validate;

        },
        //INTEND TO USE WHEN DISABLE IS TRUE FOR FORM INPUT ELEMENT
        validateConditionalRenderingForm: function (data, formInput, skipName = "default") {
            var validate = true;
            $.each(data, function (i, d) {
                console.log(d);
                if (!d.value) {
                    if (d.name == skipName) {
                        validate = true;
                    } else {
                        validate = false;
                        return false;
                    }
                }
            });
            return validate;

        }
    };
//    FORM GET ALL ELEMENT VALUE
    var serializeAllArray = function (form) {
        var input = $(form + ' :input[name]');
        var finalOutput = [];
        input.each(function (index, item) {
            var $item = $(item);
            var value = $item.val();
            var name = $item.attr('name');
            if (Array.isArray(value)) {
                $.each(value, function (arrayIndex, arrayItem) {
                    var obj = {};
                    obj["name"] = name;
                    obj["value"] = arrayItem;
                    finalOutput.push(obj);
                });
            } else {
                var obj = {};
                obj["name"] = name;
                obj["value"] = value;
                finalOutput.push(obj);
            }
        });
        return finalOutput;
    };
//    jQuery DataTable
    var renderingTable = function (element, opt) {
        var $element = $(element);
        var options = opt;
        this.createDataTable = function () {
            console.log("table Created");
            if ($.fn.dataTable.isDataTable($element)) {
                var dt = $element.DataTable();
                dt.destroy();
                dt.clear();
                $element.empty();
//              dt.clear().rows.add(options.data).draw();
            }
            $element.DataTable(options);
        };
        this.getDataTable = function () {
            console.log("table Data");
            return $element.DataTable();
        };
    };

    var generateDropdownOpt = function (selectTag, data, label) {
        var $opts = [];
        $(selectTag).find('option').remove();
        for (var i = 0; i < data.length; i++) {
            var id = data[i]["id"];
            var name = data[i]["name"];
            $opts.push($('<option>').val(id).text(name + ' [' + id + ']'));
        }
        return $opts;
    };
    
    var renderDropdown = function (selectTag, data, defaultLabel) {
        var $opts = [];
        console.log(selectTag, $(selectTag));
        $(selectTag).find('option').remove();
        $opts.push($('<option>').val("").text(defaultLabel));
        for (var i = 0; i < data.length; i++) {
            var id = data[i]["id"];
            var name = data[i]["name"];
            $opts.push($('<option>').val(id).text(name));
        }
        $(selectTag).append($opts);
    };

    var recursiveGenerateOptionGroup = function (data, container, optGroup, options) {
        if (!Array.isArray(data))
            return;
        for (var item of data) {
            if (!item.children) {
//                optGroup.append("<option>" + item.label + "</option>");
                var opts = $("<option>").val(item.value + "," + item.parent).text(item.label).attr("parent", item.parent);
                optGroup.append(opts);
                container.append(optGroup);
                /* console.log("options", item); */
            } else {
                var optGroup = $("<optgroup>");
                optGroup.attr({value: item.value, label: item.label});
                container.append(optGroup);
                console.log("optgroup", optGroup.attr('label'), optGroup.attr('value'));
            }
            recursiveGenerateOptionGroup(item.children, container, optGroup, $("<option>"));
        }
    };
    
    var generateDivSpan = function(selector, number, data) {
        //USE TO GENERATE ROWSPAN IN DATATABLE
        for (var i = 0; i <= number; i++) {
            var d = data ? data[i] : ((i + 1) + "টি");
            if (i == number) {
                selector.append("<div class='text-center'>" + d + "</div>");
            } else {
                selector.append("<div class='div-span'>" + d + "</div>");
            }
        }
        selector.attr('class', 'rm-padd');
    };
    
    var generateDivSpanDT = function(selector, number, data, key) {
//        console.log(data);
        //USE TO GENERATE ROWSPAN IN DATATABLE - TRAINING REPORT
        for (var i = 0; i < data.length; i++) {
            var d = data[i][key];
            if (i == data.length-1) {
                selector.append("<div style='padding-left: 3px' class=''>" + d + "</div>");
            } else {
                selector.append("<div class='div-span'>" + d + "</div>");
            }
        }
        selector.attr('class', 'rm-padd');
    };

    return {inputText: inputText, request: request, requestEmis: requestEmis, getDupesUFPO: getDupesUFPO
        , getAssignTypeDropdown: getAssignTypeDropdown, getAssignTypeDropdownUFPO: getAssignTypeDropdownUFPO, getUnion: getUnion
        , generateReportingUnion: generateReportingUnion, generateReportingUpazila: generateReportingUpazila, generateUnit: generateUnit, getVillage: getVillage
        , clearNewUnion: clearNewUnion, validateReportingGeo: validateReportingGeo, validateGeneral: validateGeneral
        , serializeAllArray: serializeAllArray, renderingTable: renderingTable, getAssignTypeDropdownTable: getAssignTypeDropdownTable
        , unassignGenerateReasonType: unassignGenerateReasonType, leaveType: leaveType, generateAllDistrict: generateAllDistrict,
        getWardByUnit: getWardByUnit, generateUpazila: generateUpazila, generateUnion: generateUnion
        , generateReportingUnionWithReportingUnionid: generateReportingUnionWithReportingUnionid, generateDropdownOpt: generateDropdownOpt
        , recursiveGenerateOptionGroup: recursiveGenerateOptionGroup, generateDivSpanDT: generateDivSpanDT, renderDropdown: renderDropdown};
})(jQuery, window);