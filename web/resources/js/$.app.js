//export csv
function exportTableToCSV($table, filename) {
    var $headers = $table.find('tr:has(th)')
            , $rows = $table.find('tr:has(td)')

            , tmpColDelim = String.fromCharCode(11) // vertical tab character
            , tmpRowDelim = String.fromCharCode(0) // null character

            // actual delimiter characters for CSV format
            , colDelim = '"\t"'
            , rowDelim = '"\r\n"';

    // Grab text from table into CSV formatted string
    var csv = '"';
    csv += formatRows($headers.map(grabRow));
    csv += rowDelim;
    csv += formatRows($rows.map(grabRow)) + '"';

    // Data URI
    var csvData = 'data:application/xls;charset=utf-8,' + encodeURIComponent(csv);

    // For IE (tested 10+)
    if (window.navigator.msSaveOrOpenBlob) {
        var blob = new Blob([decodeURIComponent(encodeURI(csv))], {
            type: "text/xls;charset=utf-8;"
        });
        navigator.msSaveBlob(blob, filename);
    } else {
        $(this)
                .attr({
                    'download': filename
                    , 'href': csvData
                            //,'target' : '_blank' //if you want it to open in a new window
                });
    }

    // Format the output so it has the appropriate delimiters
    function formatRows(rows) {
        return rows.get().join(tmpRowDelim)
                .split(tmpRowDelim).join(rowDelim)
                .split(tmpColDelim).join(colDelim);
    }
    // Grab and format a row from the table
    function grabRow(i, row) {
        var $row = $(row);
        //for some reason $cols = $row.find('td') || $row.find('th') won't work...
        var $cols = $row.find('td');
        if (!$cols.length)
            $cols = $row.find('th');

        return $cols.map(grabCol)
                .get().join(tmpColDelim);
    }
    // Grab and format a column from the table 
    function grabCol(j, col) {
        var $col = $(col),
                $text = $col.text();
        return $text.replace('"', '""'); // escape double quotes
    }
}
Date.prototype.addDays = function (days) {
    var dat = new Date(this.valueOf());
    dat.setDate(dat.getDate() + days);
    return dat;
}

//window
function finiteFilter(val) {
    return isFinite(val) && val || 0;
}

function  getNow() {
    var currentdate = new Date();
    return currentdate.getDate() + "/" + (currentdate.getMonth() + 1) + "/" + currentdate.getFullYear() + " " + currentdate.getHours() + ":" + currentdate.getMinutes() + ":" + currentdate.getSeconds();
}

function convertToUserDate(date) {
    var d = date.split("-");
    return d[2] + "/" + d[1] + "/" + d[0];
}

function selectText(id) {
    return $("#" + id + " option:selected").text().split('[')[0];
}

function convertTimeStamp(createdDate) {
    if (createdDate == null)
        return "";
    else
        createdDate = new Date(createdDate);
    var date = createdDate.toLocaleDateString(),
            time = createdDate.toLocaleTimeString();
    date = date.replace(/(\d+)\D(\d+)\D(\d+)/g, '$2/$1/$3');
    time = time.replace(/(.*)\D\d+/, '$1');
    return date + ' ' + time;
}

function parsingAs(d, t = '-', c = 'e2e') {

    if (d == "null" || d == null || d == undefined) {
        d = t;
    }

    if (c == 'e2b') {
        return e2b(d);
    } else {
        return d;
}
}

function getDayByDate(date) {
    var d = new Date(date);
    var weekday = new Array(7);
    weekday[0] = "রবিবার";
    weekday[1] = "সোমবার";
    weekday[2] = "মঙ্গলবার";
    weekday[3] = "বুধবার";
    weekday[4] = "বৃহস্পতিবার";
    weekday[5] = "শুক্রবার";
    weekday[6] = "শনিবার";
    return weekday[d.getDay()];
}

function range(start, stop, step) {
    if (stop == null) {
        stop = start || 0;
        start = 0;
    }
    if (!step) {
        step = stop < start ? -1 : 1;
    }
    var length = Math.max(Math.ceil((stop - start) / step), 0);
    var range = Array(length);

    for (var idx = 0; idx < length; idx++, start += step) {
        range[idx] = start;
    }
    return range;
}

function Calc(data) {
    this.data = data || [];
    this.sum = this.Sum(data);
}
Calc.prototype = {
    Sum: function (data) {
        return data.reduce(function (p, n, i) {
            for (var k in n) {
                p[k] = (p[k] || 0) + (+finiteFilter(n[k]));
            }
            return p;
        }, {});
    },
    avg: function (k) {
        return +(this.sum[k] / this.data.length).toFixed(2);
    }
}
//Export as xls
function exls($table, filename) {
    var $headers = $table.find('tr:has(th)')
            , $rows = $table.find('tr:has(td)')

            , tmpColDelim = String.fromCharCode(11) // vertical tab character
            , tmpRowDelim = String.fromCharCode(0) // null character

            // actual delimiter characters for CSV format
            , colDelim = '"\t"'
            , rowDelim = '"\r\n"';

    // Grab text from table into CSV formatted string
    var csv = '"';
    csv += formatRows($headers.map(grabRow));
    csv += rowDelim;
    csv += formatRows($rows.map(grabRow)) + '"';

    // Data URI
    var csvData = 'data:application/xls;charset=utf-8,' + encodeURIComponent(csv);

    // For IE (tested 10+)
    if (window.navigator.msSaveOrOpenBlob) {
        var blob = new Blob([decodeURIComponent(encodeURI(csv))], {
            type: "text/xls;charset=utf-8;"
        });
        navigator.msSaveBlob(blob, filename);
    } else {
        $(this)
                .attr({
                    'download': filename
                    , 'href': csvData
                            //,'target' : '_blank' //if you want it to open in a new window
                });
    }

    // Format the output so it has the appropriate delimiters
    function formatRows(rows) {
        return rows.get().join(tmpRowDelim)
                .split(tmpRowDelim).join(rowDelim)
                .split(tmpColDelim).join(colDelim);
    }
    // Grab and format a row from the table
    function grabRow(i, row) {
        var $row = $(row);
        //for some reason $cols = $row.find('td') || $row.find('th') won't work...
        var $cols = $row.find('td');
        if (!$cols.length)
            $cols = $row.find('th');

        return $cols.map(grabCol)
                .get().join(tmpColDelim);
    }
    // Grab and format a column from the table 
    function grabCol(j, col) {
        var $col = $(col),
                $text = $col.text();
        return $text.replace('"', '""'); // escape double quotes
    }
}

//jquery
$(function () {
    //Populate Year and Month dropdown and set current year & month
    /*var date = new Date(), currentYear = date.getFullYear(), currentMonth = date.getMonth() + 1;
     for (var year = currentYear, strYear = ''; year > 2013; year--)
     strYear += '<option value=' + year + '>' + year + '</option>';
     $('#year').html(strYear);
     
     var strMonth = '';
     for (var month = 1; month <= 12; month++) {
     var m = new Date('2018-' + month + '-01').toLocaleString('us-en', {month: "long"});
     //console.log(m);
     strMonth += '<option value=' + month + '>' + m + '</option>';
     }
     $('#month').html(strMonth).val(currentMonth);*/
    //End Date month setting

    $.popup = function (url, title, w, h) {
        //window.location.href.split('/').slice(0,-1).concat('/login').join('');
        url = url || "", title = title || "", w = w || 400, h = h || 400;
        // Fixes dual-screen position                         Most browsers      Firefox
        var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
        var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;

        var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
        var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

        var left = ((width / 2) - (w / 2)) + dualScreenLeft;
        var top = ((height / 2) - (h / 2)) + dualScreenTop;
        var newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);

        // Puts focus on the newWindow
        if (window.focus) {
            newWindow.focus();
        }
        ;
        return newWindow;
    };

    $.isValid = function () {
        var selector = "select#division,select#district,select#upazila,select#union"; //select#unit,select#provCode,
        return $(selector).isValid();
    };

    $.isValidAll = function () {
        var selector = "select#division,select#district,select#upazila,select#union"; //select#unit,select#provCode,
        return $(selector).isValidAll();
    };

    $.unit =
            $.getUnitName = function (id, lang) {
                var units = $.app.units;
                var unit = units[id] || ['-', '-'];
                return unit[+lang];
            };

    $.unitJson = '{ "unit" : [' +
            '{ "ucode":"2", "unameeng":"1KA", "unameban":"১ক"},' +
            '{ "ucode":"3", "unameeng":"1KHA", "unameban":"১খ"},' +
            '{ "ucode":"4", "unameeng":"1GA", "unameban":"১গ"},' +
            '{ "ucode":"6", "unameeng":"2KA", "unameban":"২ক"},' +
            '{ "ucode":"7", "unameeng":"2KHA", "unameban":"২খ"},' +
            '{ "ucode":"8", "unameeng":"2GA", "unameban":"২গ"},' +
            '{ "ucode":"10", "unameeng":"3KA", "unameban":"৩ক"},' +
            '{ "ucode":"11", "unameeng":"3KHA", "unameban":"৩খ"},' +
            '{ "ucode":"12", "unameeng":"3GA", "unameban":"৩গ"}]}';

    $.toast = function (message, type) {
        return function (response) {
            message = response || message;
            toastr[type]("<h4><b>" + message + "</b></h4>");
        };
    };

    $.fn.isValidAll = function (toast) {
        var toast = toast == undefined ? true : toast;
        var valid = true;
        var itemToFill = [];
        var data = {};

        this.each(function (i, o) {
            var val = +$(o).val();
            if (!val) {
                // In replace of isValid
                itemToFill.push(o.id);
                valid = false;
            } else {
                data[o.id + 'id'] = val;
            }
        });
        data = valid ? data : valid;

        if (!valid) {
            toast && $.toast("Please select  " + itemToFill.join(", "), 'error')();
        }
        return data;
    }

    $.fn.isValid = function (toast) {
        var toast = toast == undefined ? true : toast;
        var valid = true;
        var data = {};
        this.each(function (i, o) {
            var val = +$(o).val();
            if (!val) {
                toast && $.toast("Please select  " + o.id, 'error')();
                return valid = false;
            } else {
                data[o.id + 'id'] = val;
            }
        });
        data = valid ? data : valid;
        return data;
    };

    var converterText = function (response) {

        try {
            $.parseJSON(response);
            return response;
        } catch (e) {

            if (response) {
                if ($(response).find('form[name=loginForm]').length) {
                    $.toast('Session time out. <br>Please login first', 'error')();

                    var $p = $.app.$loginPopup.trigger('focus');
                    setTimeout(function () {
                        $p.trigger('click');
                    }, 100);
                }
            } else {
                $.toast('No data found', 'error')();
            }

            //$('.box-body').next('.overlay').remove();
            throw new Error("Invalid JSON response");
        } finally {

        }
    };
    $.ajaxSetup({
        converters: {"text html": converterText},
        beforeSend: function () {
            //Pace.track(function () {});
            //window.Pace && Pace.restart();
            $('<div class="overlay"><i class="fa fa-cog fa-spin fa-3x fa-fw" aria-hidden="true" style="font-size:55px;color:#3c8dbc"></i></div>').insertAfter(".box-body");
            //console.log('ajax: beforeSend');
        },
        complete: function () {
            $('.box-body').next('.overlay').remove();
            //console.log('ajax: complete');
        },
        success: function () {
            $('.box-body').next('.overlay').remove();
            //console.log('ajax: success');
        },
        error: function () {
            $('.box-body').next('.overlay').remove();
            //console.log('ajax: error');
        }
    });


    $.fn.dataTable && $.extend($.fn.dataTable.defaults, {responsive: true, autoWidth: true});

});



$(function () {
    $.fn.dt = function (options) {
        return this.each(function (i, o) {
            if ($.fn.dataTable.isDataTable(o)) {
                var dt = $(o).DataTable();
                dt.destroy();
                dt.clear();
                $(o).empty();
//              dt.clear().rows.add(options.data).draw();
            }
            $(o).DataTable(options);
        });
    }

    $.fn.dtAsset = function (options, id) {

//        var type = {
//            tablet_stock_status: '<tfoot align="right"><tr><th></th><th></th><th></th><th></th></tr></tfoot>',
//            tablet_functionality_status: '<tfoot align="right"><tr><th></th><th></th><th></th><th></th><th></th><th></th></tr></tfoot>',
//            projected_purchase_need: '<tfoot align="right"><tr><th></th><th></th><th></th><th></th></tr></tfoot>',
//            number_of_tablets_lost: '<tfoot align="right"><tr><th></th><th></th><th></th><th></th></tr></tfoot>'
//        }

        return this.each(function (i, o) {
            if ($.fn.dataTable.isDataTable(o)) {
                var dt = $(o).DataTable();
                dt.destroy();
                dt.clear();
                $(o).empty();
                //$('#' + id).append(type[id]);
//              dt.clear().rows.add(options.data).draw();
            }
            $(o).DataTable(options);
        });
    }

    function Select(data, settings) {
        //data=[ {id: 10, text: ' Helal'}, {id: 10, text: ' Rahen'} ]; 
        //attrs={id:'id',text:'text'} id & text=>keys for mapping option, value=>selected option id, placeholder=> text of first element
        var defaults = {
            tag: 'option',
            id: 'id',
            text: 'text',
            value: '',
            placeholder: '- select -',
        };

        data = data || [];
        settings = $.extend({}, defaults, settings || {});

        var Option = function (item, index) { // item = {id: 10, text: ' Helal'}
            //console.log(index, item);
            var attr = {value: (item.id != undefined ? item.id : ''), selected: (item.selected ? 'selected' : ''), html: item.text};
            var html = '<option class=opt-' + attr.value + ' value="' + attr.value + '" ' + attr.selected + ' >' + attr.html + '</option>';
            //var $tag = $('<' + tag + '/>', attr);
            //$tag = $.isFunction(row) ? row.call($tag, index, item) : $tag;
            //var html = $tag.prop('outerHTML');
            return html;
        };

        var tag = settings.tag,
                id = settings.id, //fn:(i,o)?
                text = settings.text, //fn:(i,o)?
                value = settings.value,
                Option = settings.option && $.isFunction(settings.option) ? settings.option : Option, //fn:(o,i)?
                row = settings.row, //fn:(i,o)?
                placeholder = settings.placeholder;
        //console.log(settings);

        var Format = function (item, index) {
            //console.log(item,index);
            return  item.text + (item.id && (item.id != item.text) ? ' [' + item.id + ']' : '');
        };

        var options = [];
        $.each(data, function (index, item) {
            var _id = $.isFunction(id) ? id.call(item, index, item) : (item[id] || item);
            var _text = $.isFunction(text) ? text.call(item, index, item) : (item[text] || item);
            if (!$.isFunction(text)) {
                _text = Format({id: _id, text: _text}, index);
            }
            var _selected = (!!value && _id == value);
            _selected && console.log('_selected', _selected, value);
            var _option = Option({id: _id, text: _text, selected: _selected}, index);
            options.push(_option);
        });
        if (placeholder != null) {
            //options.length > 1 && options.unshift(Option({text: placeholder}));
            options.length && options.unshift(Option({text: placeholder}));
        }
        return options.join('\n');
    }

    $.fn.Select = function () {
        var args = [].slice.call(arguments);
        args[0] = args[0] || [];
        //console.log.apply(console,args);
        var getTag = function (o) {
            var isSelect = $(o).is('select');
            return $(o).is('select') ? 'option' : ($(o).is('ol,ul') ? 'li' : ($(o).is('table,thead,tbody,tfoot') ? 'tr' : 'div'));
        };
        var init = function (o, data, args, trigger) {
            var isSelect = $(o).is('select');
            var tag = getTag(o);
            var override = {tag: tag};
            (!isSelect) && (override.placeholder = null);
            args[1] = $.extend({}, args[1] || {}, override);
            //console.log('list/args', args);
            var html = Select.apply(o, args);
            $(o).html(html);
            console.log("o, html, data",o, html, data);
            trigger && $(o).trigger('Select', [data]);
            return $(o);
        };
        return this.each(function (i, o) {

            if ($.type(args[0]) === 'array') {
                var data = args[0];
                return init(o, data, args, false);
            } else {
                args[0] = $.type(args[0]) === 'string' ? {url: args[0]} : args[0];
                $.extend({ catch : true}, args[0]);
                var xhr = $.ajax.call($, args[0]);
                xhr.done(function (response) {
                    console.log('>>', ++$.fn.Select.called, '>>', $(o).attr('id'), $.type(response));
                    var data = $.type(response) == 'array' ? response : $.parseJSON(response) || [];
                    args[0] = data;
                    init(o, data, args, true);
                });
            }
        });
    };

    $.fn.Select.called = 0;












    $.app = {
        version: '1.1.0',
        getVersion: function (version) {
            version = ((arguments.length ? version : this.version) || '').toString();
            return $.extend([0, 0, 0], (version || '').match(/\d+/g)).join('.');
        },
        hasVersion: function (version) {
            version = ((arguments.length ? version : this.version) || '').toString();
            return /^(\d+)(\.\d+)?(\.\d+)?$/.test(version);
        },
        isV8MIS: function (year, month) {
            year = year || 2019, month = month || 1;
            return new Date([year, month, 1].join('-')) < new Date([2019, 1, 1].join('-'));
        },
        getVersionMIS: function (year, month) {
            return this.isV8MIS(year, month) ? 8 : 9;
        },
        percentage: function (n, d, p) {
            var r = (100 * n / (d || undefined)) || 0, p = p || 0;
            return +r.toFixed(p);
        },
        hideNextMonths: function (yearID, monthID, myDate) {
            var now = this.dateObject(myDate),
                    currYear = now.getFullYear(),
                    currMonth = now.getMonth();
            var $month = $(yearID || '#month'), $year = $(yearID || '#year');
            var klass = 'current';
            $month.find('option').removeClass(klass).eq(currMonth).addClass(klass);
            $year.off('change.cm').on('change.cm', function () {
                var year = +$(this).val();
                if (year == currYear) {
                    $month.find('option').eq(currMonth).addClass(klass);
                } else {
                    $month.find('option').eq(currMonth).removeClass(klass);
                }
            });
        },
        filterDisabed: function (state) {
            var rect = $([]);
            this.$sidenav.children('li.treeview').map(function (i, li) {
                var ul = $(li).children('ul'), _li = ul.children('li'), a = _li.children('a.disabled');
                //console.log(li);
                rect = rect.add(_li.length === a.length ? $(li) : a);
            });

            if (state != undefined) {
                var fn = state ? 'show' : 'hide';
                rect[fn]();
            }


            var hostname = window.location.hostname;
            this.$sidenav.find('li.treeview a[href!="#"]').each(function (i, o) {
                var _hostname = $('<a>').prop('href', o.href).prop('hostname');
                if (_hostname !== hostname) {
                    $(o).attr('target', '_blank');
                }

            });

            return rect.addClass('xdisabled');
        },
        pluck: function (o, k) {
            var r = {}, k = k instanceof Array ? k : [k], i = k.length;
            while (i--) {
                var _k = k[i];
                if (_k in o) {
                    r[_k] = o[_k];
                }
            }
            return r;
        },
        exclude: function (o, k) {
            var r = {}, k = k instanceof Array ? k : [k];
            for (var _k in o) {
                if (!~k.indexOf(_k)) {
                    r[_k] = o[_k];
                }
            }
            return r;
        },
        init: function () {
            var self = this;
            this.$navbar = $('nav.navbar.navbar-static-top');
            this.$emis = $("#transparentTextForBlank");
            this.$sidebar = $('.main-sidebar');
            this.$sidenav = this.$sidebar.find('.sidebar-menu');
            this.filterDisabed(0);
            this.$loginPopup = $('<a class="hidden"/>', {id: 'popup-login', html: 'login', href: '#'}).appendTo(document.body).on('click', function (e) {
                //self.preventEvent(e);
                $.popup('./login', 'Login');
            });
        },
        config: {},
        cache: {
            division: [],
            zilla: [],
            upazila: [],
            union: [],
            provtype: [],
            providerdb: []
        },
        wards: {
            1: ["Ward 1", "ওয়ার্ড ১"],
            2: ["Ward 2", "ওয়ার্ড ২"],
            3: ["Ward 3", "ওয়ার্ড ৩"]
        },
        units: {
//            1: ["1", "১"],
//            2: ["1KA", "১ক"],
//            3: ["1KHA", "১খ"],
//            4: ["1GA", "১গ"],
//            5: ["2", "২"],
//            6: ["2KA", "২ক"],
//            7: ["2KHA", "২খ"],
//            8: ["2GA", "২গ"],
//            9: ["3", "৩"],
//            10: ["3KA", "৩ক"],
//            11: ["3KHA", "৩খ"],
//            12: ["3GA", "৩গ"]
            1: ["1", "১"],
            2: ["1KA", "১ক"],
            3: ["1KHA", "১খ"],
            4: ["1GA", "১গ"],
            5: ["2", "২"],
            6: ["2KA", "২ক"],
            7: ["2KHA", "২খ"],
            8: ["2GA", "২গ"],
            9: ["3", "৩"],
            10: ["3KA", "৩ক"],
            11: ["3KHA", "৩খ"],
            12: ["3GA", "৩গ"],
            13: ["3GHA", "৩ঘ"],
            14: ["3UMA", "৩ঙ"],
            15: ["3CHA", "৩চ"],
            16: ["1GHA", "১ঘ"],
            17: ["1UMA", "১ঙ"],
            18: ["1CHA", "১চ"],
            19: ["2GHA", "২ঘ"],
            20: ["2UMA", "২ঙ"],
            21: ["2CHA", "২চ"],
            22: ["4", "৪"],
            23: ["4KA", "৪ক"],
            24: ["4KHA", "৪খ"],
            25: ["4GA", "৪গ"],
            26: ["5", "৫"],
            27: ["5KA", "৫ক"],
            28: ["5KHA", "৫খ"],
            29: ["6", "৬"],
            30: ["6KA", "৬ক"],
            31: ["6KHA", "৬খ"],
            32: ["7", "৭"],
            33: ["7KA", "৭ক"],
            34: ["7KHA", "৭খ"],
            35: ["8", "৮"],
            36: ["8KA", "৮ক"],
            37: ["8KHA", "৮খ"],
            38: ["9", "৯"],
            39: ["9KA", "৯ক"],
            40: ["9KHA", "৯খ"],
            41: ["10", "১০"],
            42: ["10KA", "১০ক"],
            43: ["10KHA", "১০খ"],
            44: ["11", "১১"],
            45: ["11KA", "১১ক"],
            46: ["11KHA", "১১খ"],
            47: ["12", "১২"],
            48: ["12KA", "১২ক"],
            49: ["12KHA", "১২খ"],
            50: ["13", "১৩"],
            51: ["13KA", "১৩ক"],
            52: ["13KHA", "১৩খ"],
            53: ["14", "১৪"],
            54: ["14KA", "১৪ক"],
            55: ["14KHA", "১৪খ"],
            56: ["15", "১৫"],
            57: ["15KA", "১৫ক"],
            58: ["15KHA", "১৫খ"],
            59: ["16", "১৬"],
            60: ["16KA", "১৬ক"],
            61: ["16KHA", "১৬খ"],
            62: ["17", "১৭"],
            63: ["17KA", "১৭ক"],
            64: ["17KHA", "১৭খ"],
            65: ["18", "১৮"],
            66: ["18KA", "১৮ক"],
            67: ["18KHA", "১৮খ"],
            68: ["19", "১৯"],
            69: ["19KA", "১৯ক"],
            70: ["19KHA", "১৯খ"],
            71: ["20", "২০"],
            72: ["20KA", "২০ক"],
            73: ["20KHA", "২০খ"],
            74: ["21", "২১"],
            75: ["21KA", "২১ক"],
            76: ["21KHA", "২১খ"],
            77: ["22", "২২"],
            78: ["22KA", "২২ক"],
            79: ["22KHA", "২২খ"],
            80: ["23", "২৩"],
            81: ["23KA", "২৩ক"],
            82: ["23KHA", "২৩খ"],
            83: ["24", "২৪"],
            84: ["24KA", "২৪ক"],
            85: ["24KHA", "২৪খ"],
            86: ["25", "২৫"],
            87: ["25KA", "২৫ক"],
            88: ["25KHA", "২৫খ"],
            89: ["26", "২৬"],
            90: ["26KA", "২৬ক"],
            91: ["26KHA", "২৬খ"],
            92: ["27", "২৭"],
            93: ["27KA", "২৭ক"],
            94: ["27KHA", "২৭খ"],
            95: ["CLUSTER1", "ক্লাস্টার১"],
            96: ["CLUSTER2", "ক্লাস্টার২"],
            97: ["CLUSTER3", "ক্লাস্টার৩"],
            98: ["CLUSTER4", "ক্লাস্টার৪"]
        },
        getUnit: function (id, lang) {
            var units = this.units;
            var unit = units[id] || ['-', '-'];
            return unit[+lang];
        },
        getUnits: function (units) { //console.log("units",units);
            return $.map(units || this.units, function (o, i) {
                return {ucode: i, unameeng: o[0], unameban: o[1]};
            });
        },
        provTypes: {
            //'2,3':"Service providors",
//            2: "HA",
            3: "FWA",
            //'10,11,12,15,16':"Supervisors",
            10: "FPI",
//            11: "AHI",
//            12: "HI",
            15: "UFPO",
//            16: "UHFPO"
        },
        provderTypeFull: {
            2: "স্বাস্থ্য সহকারী",
            3: "পরিবার কল্যাণ সহকারী",
            10: "পরিবার পরিকল্পনা পরিদর্শক",
            11: "সহকারী স্বাস্থ্য পরিদর্শক",
            12: "স্বাস্থ্য পরিদর্শক",
            15: "উপজেলা পরিবার পরিকল্পনা কর্মকর্তা",
            16: "উপজেলা স্বাস্থ্য ও পরিবার পরিকল্পনা কর্মকর্তা"
        },
        monthBangla: {
            1: "জানুয়ারি",
            2: "ফেব্রুয়ারি",
            3: "মার্চ",
            4: "এপ্রিল",
            5: "মে",
            6: "জুন",
            7: "জুলাই",
            8: "অগাস্ট",
            9: "সেপ্টেম্বর",
            10: "অক্টোবর",
            11: "নভেম্বর",
            12: "ডিসেম্বর"
        },
        monthShort: {
            1: 'Jan',
            2: 'Feb',
            3: 'Mar',
            4: 'Apr',
            5: 'May',
            6: 'Jun',
            7: 'Jul',
            8: 'Aug',
            9: 'Sept',
            10: 'Oct',
            11: 'Nov',
            12: 'Dec'
        },
        getProvTypes: function (all) {
            var p = $.map(this.provTypes, function (text, id) {
                return {id: id, text: text};
            });
            if (all) {
                p.splice(0, 0, {id: '3', text: 'Service Providers'});
                p.splice(3, 0, {id: '10,15', text: 'Supervisors'});
            }
            return p;
        },
        months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
        date: function (xdate) {
            var d = xdate ? new Date(xdate) : new Date();
            var date = d.toLocaleDateString();
            var time = d.toLocaleTimeString();
            var dayDiff = +((new Date() - d) / (24 * 60 * 60 * 1000)).toFixed(2);
            var year = d.getFullYear();
            var month = d.getMonth();
            var day = d.getDate();
            date = date.replace(/(\d+)\D(\d+)\D(\d+)/g, '$2/$1/$3');
            time = time.replace(/(.*)\D\d+/, '$1');
            var version = ('0' + day).slice(-2) + ('0' + month).slice(-2) + year;
            var lastDay = new Date(year, month + 1, 0).getDate();
            var firstDate = "01/" + (month + 1) + "/" + year, lastDate = lastDay + "/" + (month + 1) + "/" + year;

            return {
                year: year,
                month: month + 1,
                day: day,
                //date: String(day).padStart(2, '0') + '/' + String(month+1).padStart(2, '0') + '/' + year,
                date: date,
                version: version,
                time: time,
                datetime: date + '  ' + time,
                datetimeHuman: day + '  ' + $.app.months[month] + ', ' + year + '  ' + time,
                dateHuman: day + '  ' + $.app.months[month] + ', ' + year,
                dayDiff: dayDiff,
                lastDay: lastDay,
                firstDate: firstDate,
                lastDate: lastDate,
                fullDate: new Date(d),
                added: function (n) {
                    if (n == null) {
                        return "";
                    }
                    return day + '/' + month + '/' + (year + parseInt(n));
                },
                fullAdded: function (n) {
                    if (n == null) {
                        return "";
                    }
                    return new Date((year + parseInt(n)), (month - 1), day);
                }
            }
        },
        ajax: function (options) {
            var defaults = {};
            options = $.extend({}, defaults, options || {});
            var xhr = $.ajax(options);
            return xhr;
        },
        preventEvent: function (e) {
            e.preventDefault();
            e.stopPropagation();
        },
        Select: Select,
        select: {
            $ward: function (context, value, placeholder) {
                return $(context).Select([1, 2, 3], {placeholder: placeholder, value: value});
            },
            $unit: function (context, value, placeholder) {
                return $(context).Select($.app.getUnits(), {id: 'ucode', text: 'unameeng', placeholder: placeholder, value: value});
            },
            $providerType: function (context, districtId, value, placeholder) {
                return $(context).Select("providerTypeJsonProvider?districtId=" + (districtId || 93), {id: 'provtype', text: 'typename', placeholder: placeholder, value: value});
            },
            $providerTypeByProvider: function (context, districtId, value, placeholder) {
                return $(context).Select("providertype?districtId=" + (districtId || 0), {id: 'provtype', text: 'typename', placeholder: placeholder, value: value});
            },
            $apkType: function (context, value) {
                //var text=function(){ return  this.text +'-'+ (this.id==2 || this.id==3? 'Provider':' Supervisory') +' module'; };
                return $(context).Select("apkJsonProvider?action=type", {value: value, placeholder: "Select type", text: function () {
                        return this.text;
                    }});
            },
            $division: function (context, value) {
                return $(context).Select("DivisionJsonDataProvider", {text: 'divisioneng', value: value, placeholder: '--Select division--'});
            },
            $zilla: function (context, divisionid, value) {
                return $(context).Select("DistrictJsonDataProvider?division=" + (divisionid || 0), {id: 'zillaid', text: 'zillanameeng', value: value, placeholder: '--Select district--'});
            },
            $upazila: function (context, districtId, value, placeholder) {
                return $(context).Select("UpazilaJsonProvider?districtId=" + (districtId || 0), {id: 'upazilaid', text: 'upazilanameeng', value: value, placeholder: placeholder || '--Select upazila--'});
            },
            $union: function (context, districtId, upazilaId, value, placeholder) {
                //console.log('before: $union/placeholder', placeholder);
                placeholder = (placeholder === null ? null : placeholder || '--Select union--');
                //console.log('after: $union/placeholder', placeholder);
                return $(context).Select({url: "UnionJsonProvider", data: {zilaId: (districtId || 0), upazilaId: (upazilaId || 0)}}, {id: 'unionid', text: 'unionnameeng', value: value, placeholder: placeholder});
            },
            $year: function (context, data, placeholder) { //data=range(s,e,i)
                placeholder = placeholder || null;
                return $(context).Select(data, {placeholder: null, id: function (index) {
                        return +this;
                    }});
            },
            $month: function (context, placeholder, value) {
                placeholder = placeholder || null;
                return $(context).Select($.app.months, {value: (value || 1), placeholder: null, id: function (i) {
                        return i + 1;
                    }, text: function () {
                        return this;
                    }});
            }
        },
        pairs: function (context) {
            var serializeArray = context;
            if (!$.isArray(context)) {
                var $input = $(context);
                var $disabled = $input.filter(':disabled').prop('disabled', 0);
                serializeArray = $input.serializeArray();
                $disabled.prop('disabled', 1);
            }
            return serializeArray.reduce(function (p, n) {
                p[n.name] = n.value;
                return p;
            }, {});
        },
        status: {
//            submitted: '<span class="label label-success"><b><i class="fa fa-check-circle" aria-hidden="true"></i>&nbsp;&nbsp;রিপোর্ট জমা দেয়া হয়েছে</b></span>',
//            notSubmitted: '<span class="label label-danger"><b><i class="fa fa-minus-circle" aria-hidden="true"></i>&nbsp;&nbsp;রিপোর্ট জমা দেয়া হয়নি</b></span>',
//            pending: '<span class="label label-warning"><b><i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;&nbsp;রিপোর্ট অনুমোদন  প্রক্রিয়াধীন রয়েছে</b></span>'
            submitted: '<span class="label label-success"><b>রিপোর্ট জমা দেয়া হয়েছে</b></span>',
            notSubmitted: '<span class="label label-danger"><b>রিপোর্ট জমা দেয়া হয়নি</b></span>',
            pending: '<span class="label label-warning"><b>রিপোর্ট অনুমোদন  প্রক্রিয়াধীন রয়েছে</b></span>',
            revised: '<span class="label label-warning"><b>রিপোর্টটি সংশোধন প্রক্রিয়ায় রয়েছে</b></span>'
        },
        workplanStatus: {
            submitted: '<div class="callout callout-success" style="margin-bottom: 0!important;"><h3><center><b>অনুমোদিত</b></center></h3></div>',
            notSubmitted: '<div class="callout callout-danger" style="margin-bottom: 0!important;"><h3><center><b>অনুমোদিত না</b></center></h3></div>',
            pending: '<div class="callout callout-warning" style="margin-bottom: 0!important;"><h3><center><b>অপেক্ষাধীন রয়েছে</b></center></h3></div>'
        },

        areaSlideDown: function () {
            $("#areaDropDownPanel").slideDown("slow");
        },
        submissionStatus: function (type) {
            var html = this.status[type];
            $('#submitStatus').html(html);
        },
        submissionModal: function (fn) {
            var $o = $("#modal-report-submit");
            return $o.modal(fn);
        },
        conversationModal: function (fn) {
            var $o = $("#modal-report-response");
            return $o.modal(fn);
        },
        submissionButton: function (fn, key, val) { //show or hide;
            var $o = $("#submitDataButton");
            return fn ? $o[fn](key, val) : $o;
        },
        getCurrentPreviousDate: function (currMonth, year) {
            var preMonth = Number(currMonth) - 1;
            var preYear = year;
            if (preMonth.toString().length == 1)
                preMonth = "0" + preMonth;

            if (currMonth == "01") {
                preMonth = "12";
                preYear = Number(preYear) - 1;
            }
            var current = new Date(year, currMonth, 1);
            var previous = new Date(preYear, preMonth, 1);
            var currLastDay = new Date(current.getFullYear(), current.getMonth(), 0);
            var preLastDay = new Date(previous.getFullYear(), previous.getMonth(), 0);

            if (currMonth.toString().length == 1)
                currMonth = "0" + currMonth;
            return year + "-" + currMonth + "-" + "01" + "~" + year + "-" + currMonth + "-" + currLastDay.getDate() + "~" + preYear + "-" + preMonth + "-" + "01" + "~" + preYear + "-" + preMonth + "-" + preLastDay.getDate();
        },
        removeWatermark: function () {
            $('#transparentTextForBlank').css("display", "none");
        },
        getWatermark: function () {
            return '<section class="content-header" id="transparentTextForBlank" style="display: block;">\
                        <center class="emis_hologram">eMIS</center>\
                    </section>';
        },
        overrideDataTableBtn: function () {
            $(".dt-button").css("font-weight", "bold");
            $(".dt-button").addClass("btn btn-flat btn-default btn-sm").removeClass("dt-button");
            $(".buttons-page-length").removeClass("buttons-collection");
        },
        slogan: "ছেলে হোক, মেয়ে হোক,<br/>দু’টি সন্তানই যথেষ্ট",
        dgfpSlogan: {
            v8: "ছেলে হোক, মেয়ে হোক,<br/>দু’টি সন্তানই যথেষ্ট",
            v9: "দুটি সন্তানের বেশি নয়<br/>একটি হলে ভাল হয়"
        },
        getDate: {
            day: String(new Date().getDate()),
            month: String(new Date().getMonth() + 1),
            year: new Date().getFullYear()
        },
        dateObject: function (date) {
            return date ? new Date(date) : new Date();
        },
        today: function (sep, date) {
            var d = this.dateObject(date).toISOString().substring(0, 10);
            if (sep) {
                d = d.split('-');
                d = {day: d[2], month: d[1], year: d[0]};
            }
            return date;
        },
        moveMonth: function (monthInterval, date) {
            monthInterval = monthInterval || 0;
            var d = this.dateObject(date);
            var p = new Date(d.setMonth(d.getMonth() + monthInterval));
            return p;
        },
        isoDate: function (val) {
            return val.replace(/(\d+)\/(\d+)\/(\d+)/, '$3-$2-$1');

        },
        individualAceess: [
            'Super admin',
            'Admin',
            'Monitoring & Evaluation',
            'Upazila level (DGFP)',
            'Upazila level (DGFP) admin',
            'Union level (DGFP)',
            'SMPNS'
        ],
        supportTicketAceess: [
            'Super admin',
            'Admin',
            'Monitoring & Evaluation',
            'District level (DGFP)',
            'Upazila level (DGFP)',
            'Union level (DGFP)'
        ],
        user: {
            username: $("#userid").val(),
            role: $("#userRole").val(),
            userlevel: $("#userLevel").val(),
            designation: $("#designation").val()
        },
        getAssignType: function (assignType, type) {
            var misType = {
                1: "unit",
                2: "union",
                4: "upazila"
            };
            var assign_type = (assignType === 1) ? "Main " + misType[type] : "Additional " + misType[type];
            var klass = (assignType === 1) ? "label-success" : "label-warning";
            return "<span class='badge " + klass + "'>" + assign_type + "</span>";
        },
        mis1PageColor: function (assignType) {
            if (assignType == "1") {
                $('.mis-form-1').attr('style', 'background: #6AA9F2 !important;');
                $('.mis-template .table-responsive').attr('style', 'border: 1px solid #6AA9F2;');

            } else if (assignType == "2") {
                $('.mis-form-1').attr('style', 'background: #fce8e5 !important;');
                $('.mis-template .table-responsive').attr('style', 'border: 1px solid #fce8e5;');
            }
        },
        isFloat: function (n) {
            if(typeof n != 'number'){
                return 0;
            }
            if (((typeof n === 'number') && (n % 1 !== 0))) {
                return n
            } else {
                return n.toFixed(1)
            }
        },
        dataTablePageLength: 20,
        dataTableOptions: function (data, columns) {
            return {
                rowCallback: function (r, d, i, idx) {
                    $('td', r).eq(0).html(idx + 1);
                },
                lengthMenu: [
                    [10, 20, 50, 100, -1],
                    ['10', '20', '50', '100', 'All']
                ],
                pageLength: this.dataTablePageLength,
                processing: true,
                data: data,
                columns: columns
            };
        },
        dtOptions: function (data, columns) {
            return {
                lengthMenu: [
                    [10, 20, 50, 100, -1],
                    ['10', '20', '50', '100', 'All']
                ],
                pageLength: this.dataTablePageLength
            };
        },
        monthChecker: function (data) {
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
    };
    $.app.init();
});
