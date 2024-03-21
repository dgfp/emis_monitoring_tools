<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/js/appAndDBStatus.js"></script>
<!--<script src="https://rawgit.com/chartjs/chartjs-plugin-annotation/master/chartjs-plugin-annotation.js"></script>-->
<script src="resources/TemplateJs/chart/chartjs-plugin-annotation.js" type="text/javascript"></script>
<style>
    select#provtype option:nth-child(1), select#provtype option:nth-child(4) {
        background: #d9edf7;
        padding-top:10px;
    }
    /*table tr:nth-child(odd) th {
        border-color: activecaption;
    }
    table tr:nth-child(odd) td {
        border-color: activecaption;
    }
    table tr:nth-child(even) td {
        border-color: activecaption;
    }*/
    .modal-table-header{
        font-size: 18px;
    }
    .no-internet{
        color: #dd4b39;
        margin: 9px;
        font-size: 180%;
        font-weight: bold;
    }
    td.progress{ position: relative; z-index: 0}
    td.progress .bar{ content: ""; display: block; position: absolute; z-index: -1; left: 0; top:5px; bottom: 5px; width:0%; background: red; transition: all .2s .5s ease-in }
    td.progress .bar, .box-legend .fa{ opacity: .5;}
    #summary>tbody>tr td:first-child{ padding: 3px}
    #summary>tbody>tr td:not(:first-child){ text-align: right}
    #summary-upazila th{ cursor: pointer}
    #summary-upazila tr th:first-child,#summary-upazila tr td:first-child{ display: none}

    #summary th:nth-child(3), #summary td:nth-child(3),#summary-upazila th:nth-child(3), #summary-upazila td:nth-child(3),
    #summary th:nth-child(4), #summary td:nth-child(4),#summary-upazila th:nth-child(4), #summary-upazila td:nth-child(4),
    #summary th:nth-child(7), #summary td:nth-child(7),#summary-upazila th:nth-child(7), #summary-upazila td:nth-child(7){ display: none}
    /*    .area [class*="col"] { margin-bottom: 10px; }*/
    .box-body {
        padding: 10px!important;
        padding-bottom: 0px!important;
    }
    .label {
        border-radius: 11px!important;
    }
    .summary-notes{ display: none}
    .dataTables_info{
        padding:0px!important;
    }
    table.table-bordered thead th,
    table.table-bordered thead td {
        border-left-width: 1px;
        border-top-width: 1px;
    }
    .table-bordered {
        border: 2px solid #f4f4f4;
    }
    .content .row .box {
        margin-bottom: 0px;
   } /* Temporary*/
    [class*="col"] { margin-bottom: 10px; }/* Temporary*/
</style>
<script>
    var loadMap = tabLoad = function () {};
    function isValid(toast) {
        return $('#division,#zilla').isValid(toast);
    }


    function icon(key, val, type) {
        type = type || 'btn';
        var srOnly = function (v) {
            return '<i class=sr-only>' + v + '</i>';
        };
        var val = key == val ? ['info', 'fa-check', 'Y'] : ['default', 'fa-times', 'N'];
        var klass = [type, type + '-flat', type + '-' + val[0], type + '-sm'].join(" ")
        return  '<span class="' + klass + '"><i class="fa ' + val[1] + ' fa-lg" aria-hidden="true"></i>' + srOnly(val[2]) + '</span>';
    }
    function StatsStatus(contextUpazila, summary, legend) {
        this.$context = $(contextUpazila || "#summary-upazila");
        this.$summary = $(summary || "#summary");
        this.$legend = $(legend || ".box-legend");
        this.data = [];
        this.columns = [
            ["default not", "Upazila", "", undefined], //0: 
            ["success", "Active", "active", 1], //1: 
            ["danger", "Inactive", "active", 2], //2: 
            ["default", "Total", "", undefined], // 3: 
            ["warning", "Latest Version", "version_latest_active", true], //4: 
            ["info", "Previous Version", "version_previous_active", true], //5: 
//            ["warning", "DB Upload", "db_upload", 3], //4: 
//            ["info", "DB Download", "db_download", 4], //5: 
            ["success", "Sync", "db_sync", 5], //6: 
            //          ["danger", "Mismatch", "db_sync", 6] //  7: // resync=6 //mismatch=6
            ["danger", "Mismatch", function (d) {
                    return d.active == 1 && d.db_sync != 5
                }, true]
        ];
        this.rules = this.columns.reduce(function (p, n, i) {
            if (i > 3)
                p[i] = n.slice(2);
            return p;
        }, {});
        this.stats = {};
    }

    StatsStatus.prototype = {
        label: function (val) {
            return  "<span class='label label-flat label-" + val[0] + " label-sm'>" + val[1] + "</span>";
        },
        setStatus: function (key) {
            key = key || 2;
            var val = this.columns[key];
            //console.log(val);
            return this.label(val);
        },
        processData: function (data) {
            var self = this;
            data = data || [];
            var stats = data.reduce(function (p, n) {
                var fn = function (k, v) {
                    if (!v || (n[v[0]] == v[1]) || (v && $.isFunction(v[0]) && v[0](n))) {
                        p[k] = (p[k] || 0) + 1;
                    }
                };
                fn(n.active || 2);
                $.each(self.rules, fn);
                return p;
            }, {});
            var first = (data[0] || {});
            stats[0] = first.upazilanameeng + ' [' + first.upazilaid + ']';
            stats[3] = data.length;
            return stats;
        },
        getHead: function (columns) {
            columns = columns || this.columns;
            var str = $.map(columns, function (o, key) {
                return '<th class="text-center bg-' + o[0] + '" data-key="' + key + '">' + o[1] + '</th>';
            }).join('');
            return '<tr>' + str + '</tr>';
        },
        getRow: function (row) {
            var str = $.map(row, function (o, i) {
                var klass = i > 0 ? 'text-right' : 'text-center';
                return '<td class="' + klass + '">' + (row[i] || 0) + '</td>';
            }).join('');
            return '<tr>' + str + '</tr>';
        },
        getBody: function (data) {
            var stats = this.processData(data);
            console.log('getBody:', stats);
            var str = $.map(this.columns, function (o, i) {
                console.log("Get All: " + stats[i]);
                return '<td class=text-center>' + (stats[i] || 0) + '</td>';
            }).join('');
            var row = '<tr>' + str + '</tr>';
            //console.log(tr);
            row = this.progressBar(row, stats, 'A');
            return row;
        },
        reload: function (json) {},
        filter: function (json) {},
        details: function (json) {
            var self = this, klass = 'bg-aqua';
            this.$context
                    .find('tbody').html(this.getBody(json))
                    .end()
                    .find('thead').find('.' + klass).removeClass(klass);
            self.reload(json);
        },
        init: function () {
            var self = this;
            self.$context
                    .find('thead').html(self.getHead())
                    .end()
                    .find('tbody').html(self.getBody())
                    .end()
                    .on('click', 'th', function (e) {
                        var $target = $(e.target);
                        var key = $target.data('key');
                        var klass = 'bg-aqua th-active';
                        var columns = self.columns;
                        var val = columns[key];
                        $target.addClass(klass).siblings().removeClass(klass);
                        var json = self.data.filter(function (o, i) {
                            //console.log(o, val);
                            //return !~[0, 3].indexOf(key) ? o[val[2]] == val[3] : true;
                            var check = $.isFunction(val[2]) ? val[2](o) : o[val[2]];
                            return check == val[3];
                        });
                        self.filter(json);
                    });
            this.legend();
            return self;

        },
        toggleBlock: function (flag) {
            //flag = 0, 1, 2
            //flags={0:hide all,1: show data,2:show summary,3: show all];
            flag = +flag;
            var ctx = ['.row-details', '.row-summary'],
                    fun = ['addClass', 'removeClass'],
                    flags = [+!!(1 & flag), +!!(2 & flag)],
                    _call = function (i, o) {
                        var id = flags[i], fn = fun[id];
                        console.log(id, fn);
                        $(ctx[i])[fn]('hidden');
                    };
            $(ctx).each(_call);
            $.app.$emis[flag ? 'hide' : 'show']();
            return this;
        },
        fixHeader: function (table, enable) {
            enable = !!enable;
            if ($.fn.dataTable.isDataTable(table)) {
                var dt = $(table).DataTable();
                ///dt.fixedHeader.adjust();
                dt.fixedHeader.enable(enable);
            }
            return this;
        },
        percentile: function (numerator, denominator, p) {
            p = p || 0;
            var v = (numerator / denominator) * 100;
            return p ? +v.toFixed(p) : ~~v;
        },
        classes: [
            {value: 0, color: 'red', code: '#f2dede', status: "Poor"},
            {value: 70, color: 'yellow', code: '#fcf8e3', status: "Moderate"},
            {value: 90, color: 'green', code: '#dff0d8', status: "Satisfactory"}
        ],
        legend: function () {
            var classes = this.classes;
            var getValue = function (o) {
                return o.value + '%';
            };
            var html = $.map(classes, function (o, i) {
                var next = classes[i + 1], text = ['&gt=', getValue(o)];
                if ((next && getValue(next))) {
                    text.push(' &amp;&amp; ', '&lt', getValue(next));
                }
                var range = !i ? '&lt' + getValue(next) : text.join('');
                return '<i class="fa bg-' + o.color + '"><b class="invisible">---</b></i> ' + range;
            }).join('\n');
            this.$legend.html(html);
            return html;
        },
        classify: function (value) {
            var classes = this.classes,
                    d = classes[0],
                    i = classes.length,
                    item;
            if (!value)
                return d;
            for (; i--; ) {
                item = classes[i];
                if (value > item['value']) {
                    return item;
                }
            }
            return d;
        },
        progress: function (n, d, p) {
            if ($.isPlainObject(n)) {
                d = n[1], n = n[6];
            }
            var value = this.percentile(n, d, p);
            var item = this.classify(value);
            //console.log([n, '/', d, '=', value].join(''), item);
            //var text = value + '% (n=' + n + ')';
            var text = function (value) {
                return value + '% (n=' + (n || 0) + ')';
            };
            var bar = function (value) {
                return '<div class="bar" style="width:' + (value || 0) + '%"></div>';
            };
            return {
                value: value,
                text: text(value),
                bar: bar,
                code: item.code,
                background: 'linear-gradient(to right, ' + item.code + ' ' + value + '%, transparent 0)',
                className: 'bg-' + item.color
            };
        },
        progressBar: function (row, data, index) {
            //(index);
            var $row = $(row), $td = $row.find('td');
            var progress = this.progress(data);
            $td.eq(6).css('background', progress.background)
                    .addClass('progress')
                    .html(progress.text + progress.bar(0))
                    .find('.bar')
                    .addClass(progress.className)
                    .animate({width: progress.value + '%'});
            if (data[5] != data[6]) {
                //$td.eq(7).addClass('bg-danger');
            }
            //console.log('progressbar:',data);
            return $row;
        },
        summary: function (options) {
            var self = this;
            var $table = self.$summary;
            var $thead = $table.find('thead').empty();
            //var tbody = $table.find('tbody').empty();
            var $tfoot = $table.find('tfoot').empty();
            var defaults = {url: "ProviderDB_STATUS?action=showsummary", type: "POST"};
            var settings = $.extend({}, defaults, options || {});
            var xhr = $.ajax(settings);
            var columns = self.columns.slice(); //$.extend(self.columns, {0: ["success", "Upazila"]});
            var lastIndex = columns.length - 1;
            xhr.then(function (response) {
                var data = $.parseJSON(response);
                console.log(data);
                $.each(data, function (i, o) {
                    //o[lastIndex] = o[lastIndex - 2] - o[lastIndex - 1];
                    o[lastIndex] = o[1] - o[lastIndex - 1];

                });
                var calc = new Calc(data);
                var head = self.getHead(columns);
                //var body = $.map(data, self.getRow).join('');
                calc.sum[0] = 'Total';
                $.map(calc.sum, function (v, k) {
                    if (!self.columns[k]) {
                        delete calc.sum[k];
                    }
                });
                //
                var foot = $.map([calc.sum], self.getRow).join('');
                console.log('summary:', data, calc.sum);
                $thead.html(head);
                //$tbody.html(body);
                var headerOffset = $.app.$navbar.height();
                var options = {
                    data: data,
                    fixedHeader: {
                        header: true,
                        //,footer: true
                        headerOffset: headerOffset - 6
                    },
                    bDestroy: true,
                    searching: false,
                    paging: false,
                    info: false,
                    createdRow: function (row, data, dataIndex) {
                        //console.log('createdRow:', row, data, dataIndex)
                        self.progressBar(row, data, dataIndex);
                    },
                    rowCallback: function (r, d, i, idx) {
                        //console.log('fnRowCallback', this, r, d, i, idx);
                        //$('td', r).eq(0).html(idx + 1);
                    },
                    columnDefs: [{
                            targets: [0],
                            searchable: false,
                            data: function (row, type, val, meta) {
                                var options = {
                                    html: row[0] + ' [' + row.upazilaid + ']',
                                    "data-divid": row.divid,
                                    "data-zillaid": row.zillaid,
                                    "data-upazilaid": row.upazilaid,
                                    "class": 'btn btn-primary btn-flat btn-block btn-sm btn-data'
                                };
                                var $a = $('<button/>', options);
                                var a = $a.prop('outerHTML');
                                return a;
                            }
                        }]
                };
                try {
                    $table.DataTable(options);
                } catch (e) {
                    console.log('summary error:', e);
                } finally {
                    foot = self.progressBar(foot, calc.sum, 'F');
                    $tfoot.html(foot).addClass('bg-info');
                    self.fixHeader('#data-table', false).fixHeader('#summary', true);
                }

            }, console.log);
            return $table;
        }
    };</script>
<script>

    $(function () {
        var config = {
            init: 1,
            divid: 30,
            zillaid: 93,
            upazilaid: '', //66,
            unionid: ''
        };
        var provTypes = $.app.getProvTypes(1);
        var $provType = $('select#provtype').Select(provTypes, {placeholder: null, value: 3}),
                //$division = $.app.select.$division('select#division'),
                $division = $('select#division'),
                $zilla = $('select#zilla'),
                $upazila = $('select#upazila'),
                $union = $('select#union'),
                $btn = $('#btn-summary'), //$("button#btn-data"),
                init = config.init;

        $provType.on('Select', function (e, data) {
            console.log(data);
            $.app.cache.provtype = data;
        });
        /*
         $division.change(function (e) {
         $zilla.Select();
         $upazila.Select();
         $union.Select();
         $division.val() && $.app.select.$zilla($zilla, $division.val());
         }).on('Select', function (e, data) {
         !init && $(this).val(config.divid).change(); // && $(this).prop('disabled', 1);
         $.app.cache.division = data;
         });
         $zilla.change(function (e) {
         $upazila.Select();
         $union.Select();
         $zilla.val() && $.app.select.$upazila($upazila, $zilla.val());
         //alert($zilla.val());
         }).on('Select', function (e, data) {
         !init && $(this).val(config.zillaid).change(); //&& $(this).prop('disabled', 1);
         $.app.cache.zilla = data;
         });
         $upazila.change(function (e) {
         $union.Select();
         $zilla.val() && $upazila.val() && $.app.select.$union($union, $zilla.val(), $upazila.val(), '', 'All');
         }).on('Select', function (e, data) {
         //!init && $(this).val(config.upazilaid).change();
         !init++ && $(this).val('') && $btn.click();
         $.app.cache.upazila = data;
         });
         $union.on('Select', function (e, data) {
         //!init++ && $(this).val(config.unionid) && $btn.click();
         $.app.cache.union = data;
         });
         */


        ////////////////////////////////
        //data table / statistics here//
        ////////////////////////////////
        var stats = new StatsStatus();
        stats.init();
        stats.reload = function (json) {
            this.data = json;
            render(json);
        };
        stats.filter = function (json) {
            render(json);
        };
        window.options = {
            data: [],
            fixedHeader: {
                header: true
            },
            dom: "<'row'<'col-sm-6'i><'col-sm-6'f>><'row'<'col-sm-12'tr>><'row'<'col-sm-5'i><'col-sm-7'p>>",
            bDestroy: true,
            //searching: false,
            paging: false,
            columnDefs: [
                {
                    //orderable: false,
                    //searchable: false,
                    targets: '_all',
                    defaultContent: '-'
                }
            ],
            rowCallback: function (r, d, i, idx) {
                //console.log('fnRowCallback', this, r, d, i, idx);
                $('td', r).eq(0).html(idx + 1);
            },
            columns: [
                {data: null},
                {data: function (row) {
                        var info = ['<b>' + row.provname + " - " + row.providerid + " - " + row.typename + '</b>', 'Mob: <a href="tel:+88' + row.mobileno + '">' + row.mobileno + '</a>, ' + row.upazilanameeng + ', ' + row.unionnameeng];
                        return info.join('<br>');
                    }},
//                {data: 'typename', className: 'vcenter'},
                {data: {
                        _: function (row) {
                            var info = [];
                            if (row.active == 1) {
                                console.log('login_time', row.login_time);
                                var login_ago = moment().subtract(row.last_login, 'days').fromNow();
                                login_ago = row.last_login == null ? '-' : (login_ago == "a few seconds ago" ? "Today" : login_ago);
                                //var login_ago = row.last_login == null ? '-' : (row.last_login == 0 ? 'Today' : (row.last_login == 1 ? row.last_login + ' day ago' : row.last_login + ' days ago'));
                                info.push(login_ago);
                                var btn_history = '<a class="btn btn-info btn-flat btn-xs btn-login_history bold" href="ProviderDB_STATUS?action=login_history&zillaid=' + row.zillaid + '&providerid=' + row.providerid + '" target="_blank"><i class="fa fa-clock-o fa-lg" aria-hidden="true"></i>&nbsp; Login history<a>';
                                if (row.last_login != null)
                                    info.push(btn_history);
                            }

                            return  info.join(' <br> ');
                        },
                        sort: function (row) {
                            return  row.active == 1 && row.last_login;
                        }
                    }, className: 'vcenter'},
                {data: function (row) {
                        if (row.active != 1)
                            return '';
                        var version_update = vu = row.version_update_dl || row.version_update;
                        var version_latest = vl = row.version_latest_dl || row.version_latest
                        var is_download = row.db_download == 4;
                        //var _dl=is_download?'':'_dl';
                        //var version_update=row['version_update'+_dl],version_latest=row['version_update'+_dl];
                        var is_latest = version_update == version_latest;
                        //console.log(row.providerid, 'version', vu, vl, version_update, version_latest, row.last_login, row.last_login_time);
                        if (!is_latest) {
                            //console.log('latest provider/apk',$.app.date(version_latest).version, $.app.date(version_update).version ,row);
                        }
                        var klass = is_latest ? (version_latest == null ? 'default' : 'success') : 'danger';
                        var html = [is_latest ? 'Updated' : 'Installed', stats.label([klass, version_update])];
                        var recommended = ['Recommended', stats.label(['warning', version_latest])];
                        var response = (is_latest ? html : html.concat(recommended));
                        //return wrap(response);
                        return response.join(' <br> ');
                    }, className: 'vcenter'},
//                Hide upload column - db - during migration.
//                {data: function (row) {
//                        return icon(row.db_upload, 3, 'label');
//                    }, className: 'vcenter'},
                {data: function (row) {
                        var href = "./downloadChecker?" + $.param({zillaid: row.zillaid, providerid: row.providerid, provtype: row.provtype});
                        var anchor = ' <a class="btn btn-warning btn-flat btn-xs bold" target="_blank" href="' + href + '"><i class="fa fa-check-square-o" aria-hidden="true"></i>&nbsp; Check</a>';
                        var html = [icon(row.db_download, 4, 'label'), row.db_download ? anchor : ""];
                        return html.join('');
                    }, className: 'vcenter'},
                {data: function (row) {
                        return row.db_sync && icon(row.db_sync, 5, 'label');
                    }, className: 'vcenter'},
                {data: function (row) {
                        return stats.setStatus(row.active);
                    }, className: 'vcenter'}
            ]
        };
        var $table = $('#data-table');
        function render(data) {
            options.data = data;
            options.destroy = true;
            if ($.table) {
                $.table.clear();
                $.table.rows.add(options.data);
                $.table.draw();
            } else {
                $.table = $table.DataTable(options);
            }
        }

        $('#btn-summary').click(function (e) {
            $.app.preventEvent(e);
            var $btn = $(this);
            $('select#upazila,select#union').val("");
            var data = $.app.pairs('select');
            console.log('summary/options', data);
            var options = {
                data: data,
                success: function (d) {
                    $btn.button('reset');
                    stats.toggleBlock(2);
                },
                error: function () {
                    $btn.button('reset');
                }
            };
            $btn.button('loading');
            stats.toggleBlock();
            stats.summary(options);
        });

        $('body').on('click', '#btn-data,.btn-data', function (e) {
            var $btn = $(e.target);
            var data = temp = $.app.pairs('select');
            if ($btn.is('.btn-data')) {
                data = $.extend({}, temp, $btn.data());
                //(temp.divid != data.divid && data.divid)
                data.divid && $division.val(data.divid).change();
                data.zillaid && $zilla.on('Select', function (e, _data) {
                    $(this).val(data.zillaid).change();
                });
                data.upazilaid && $upazila.on('Select', function (e, _data) {
                    $(this).val(data.upazilaid).change();
                });
            }


            if (!data.zillaid) {
                return $.toast("Please select zilla first", "error")();
            }

            console.log('details/options', data);
            var options = {
                url: "ProviderDB_STATUS?action=showdata",
                data: data,
                type: 'POST',
                success: function (result) {
                    var json = JSON.parse(result);
                    $.app.cache.providerdb = json;
                    $btn.button('reset');
                    if (!json.length) {
                        $.toast('No data found', 'error')();
                    }
                    stats.toggleBlock(1);
                    stats.details(json);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    stats.toggleBlock();
                    $btn.button('reset');
                    $.toast("Request can't be processed", 'error')();
                }
            };
            $btn.button('loading');
            stats.toggleBlock();
            Pace.track(function () {
                $.ajax(options);
            });
        });

        //Acess controll;
        var userDesignation = $('#userDesignation').val();
        var provtype = $('#provtype');
        var summaryBtn = $("#btn-summary");
        if (userDesignation == "FPI") {
            accessFP();
        }
        if (userDesignation == "UFPO") {
            accessFP();
            $('<option>').val("15").text('UFPO [15]').appendTo(provtype);
        }
        function accessFP() {
            summaryBtn.css("display", "none");
            provtype.find('option').remove();
            $('<option>').val("3").text('FWA [3]').appendTo(provtype);
            $('<option>').val("10").text('FPI [10]').appendTo(provtype);
        }

        //////////////////////////////////////
        $('body').on('click', '.btn-login_history', function (e) {
            var $it = $(e.currentTarget);
            var $modal_history = $('.modal-login_hostory');
            var $body_history = $modal_history.find('tbody');

            var url = $it.attr('href');
            var tr = $it.closest('tr');
            var dt = $it.closest('table').DataTable();
            var provider = dt.row(tr).data();
            var xhr = $.get(url);

            var html = '<tr><td colspan=3 class=text-center>Loading.....</td></tr>';
            var getRow = function (row, index, arr) {
                return  '<tr><td>' + (index + 1) + '</td><td>' + moment(row.login_time).format('lll') + '</td><td>' + row.day_diff + '</td><td>' + (row.day_lag == null ? '' : row.day_lag) + '</td></tr>';
            };

            $modal_history.modal('show');
            $modal_history.find('.modal-title span').html(provider.provname);
            xhr.done(function (response) {
                try {
                    response = $.parseJSON(response);
                } catch (e) {
                    response = [];
                }

                console.log('login_history', response);
                if (response && response.length) {
                    html = response.map(getRow);
                } else {
                    html = '<tr><td colspan=3>No data available</td></tr>';
                }

                $body_history.html(html);
                loginChart.destroy();
                loginChart = LoginChart('#loginChart', response);

            })
            return false;
        });
        var loginChart = LoginChart('#loginChart', []);
    });

    function LoginChart(selector, dataset) {
        var dom = document.querySelector(selector);
        dom.removeAttribute('height');
        dom.removeAttribute('weight');
        if (dataset.length <= 1) {
            dom.height = 0;
            return {destroy: function () { }}
        } else {
            dom.removeAttribute('height');
        }
        //:new Date(n.login_time).toISOString().split('T')[0]
        var _dataset = dataset.slice();
        _dataset.reverse();
        var dump = _dataset.reduce(function (p, n) {
            return {
                data: p.data.concat(n.day_lag || 0),
                sum: p.sum + n.day_lag,
                length: p.length + (n.day_lag ? 1 : 0),
                labels: p.labels.concat(moment(n.login_time).format('MMM DD, YYYY'))
            };
        },
                {
                    data: [],
                    sum: 0,
                    length: 0,
                    labels: []
                });

        var avg = ~~(dump.sum / dump.length * 10) / 10;


        var ctx = dom.getContext("2d");
        var config = {
            type: 'line',
            data: {
                labels: dump.labels,
                datasets: [{
                        //label: 'Gap',
                        label: 'Gap',
                        //display:false,
                        borderColor: 'grey',
                        pointBackgroundColor: '#00c0ef',
                        borderWidth: 1,
                        fill: false,
                        data: dump.data
                    }]
            },
            options: {
                responsive: true,
                title: {
                    display: true,
                    text: 'Login interval in days'
                },
                tooltips: {
                    mode: 'index',
                    intersect: true
                },
                legend: {
                    display: false
                },
                layout: {
                    padding: {
                        right: 10,
                        left: 10,
                        top: 10
                    }
                },
                scales: {
                    yAxes: [{
                            ticks: {
                                beginAtZero: true
                                        //,stepSize: 40          
                            }
                        }],
                    xAxes: [{
                            display: false,
                            ticks: {
                                autoSkip: true,
                                maxTicksLimit: 5
                            }
                        }]
                },
                annotation: {
                    annotations: [{
                            type: 'line',
                            mode: 'horizontal',
                            scaleID: 'y-axis-0',
                            value: avg,
                            borderColor: 'orange',
                            borderWidth: 2,
                            label: {
                                enabled: true,
                                content: ['AVG:', avg, 'day' + (avg > 1 ? 's' : '')].join(' ')
                            }
                        }]
                }
            }
        }

        var myChart = new Chart(ctx, config);
        return myChart;

    }
</script>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>App and DB status </h1>
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
                <div class="box-body area">
                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <label for="division">Division</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" tabindex="-1" aria-hidden="true" name="divid" id="division"> </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="zilla">District</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" tabindex="-1" aria-hidden="true" name="zillaid" id="zilla"> 
                                <option value="">- Select District -</option>
                            </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="upazila">Upazila</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" tabindex="-1" aria-hidden="true"" name="upazilaid" id="upazila">
                                <option value="">- Select Upazila -</option>
                            </select>
                        </div>

                        <div class="col-md-1 col-xs-2">
                            <label for="union">Union</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" tabindex="-1" aria-hidden="true" name="unionid" id="union">
                                <option value="">- Select Union -</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <label for="union">Provider </label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control select2 select2-hidden-accessible" tabindex="-1" aria-hidden="true" name="provtype" id="provtype" required>
                                <option value="">- Select Type -</option>
                            </select>
                        </div>
                        <div class="col-md-2 col-xs-3 col-md-offset-1">        
                            <button type="button" id="btn-summary" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                <i class="fa fa-table" aria-hidden="true"></i>&nbsp; Summary
                            </button>
                        </div>
                        <div class="col-md-2 col-xs-3 col-md-offset-1">        
                            <button type="button" id="btn-data" data-loading-text="<i class='fa fa-spinner fa-pulse'></i> Loading"  class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                <i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; Show data
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--Transparent Text For Blank Space-->
    <section class="content-header" id="transparentTextForBlank" style="display: block;">
        <center class="emis_hologram">eMIS</center>
    </section>
    <!--summary-->
    <div class="row row-summary hidden">
        <div class="col-md-12">
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">Summary</h3> 
                    <div class="summary-notes"><small class="text-muted">
                            Completed (%) = Sync/Active *100; 
                            if sync reaches at at least 90% comparing tab data to server data of corresponding provider based on certain variables otherwise it's considered as mismatch <br> Completed (%) =  <span class="box-legend"> </span>;  
                            <!--                            Mismatch = Download - Sync -->
                            Mismatch = Active - Sync
                        </small></div>
                </div>
                <!-- /.box-header -->
                <div class="box-body" style="padding-bottom:0">
                    <div class="table-responsive-" style="margin-bottom:0">
                        <table class="table table-bordered table-striped table-hover" id="summary" style="margin-bottom:0">
                            <thead></thead>
                            <tbody></tbody>
                            <tfoot></tfoot>
                        </table>
                    </div>
                    <br>
                </div>
            </div>
        </div>
    </div>
    <!--Table body-->
    <div class="row row-details hidden" id="tableContent">
        <div class="col-xs-12">
            <div class="box box-primary full-screen">
                <div class="box-header with-border">
                    <div class="box-tools pull-right">
                        <div class="box-tools pull-right" style="margin-top: -10px;">
                            <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                        </div>
                    </div>
                </div>
                <div class="box-body">
                    <div class="table-responsive-">
                        <table class="table table-bordered table-hover bold" style="margin-bottom:12px;" id="summary-upazila">
                            <thead></thead>
                            <tbody></tbody>
                        </table>
                    </div>
                    <div class="table-responsive-" style="margin-bottom:0">
                        <table class="table table-bordered table-striped table-hover" id="data-table" style="width:100%">
                            <thead>
                                <tr>
                                    <th rowspan="2">#</th>
                                    <th rowspan="2">Provider</th>
                                    <!--                                    <th rowspan="2">Type </th>-->
                                    <th rowspan="2">Last login</th>
                                    <th rowspan="2">Version</th>
                                    <th rowspan="1" colspan="2" class="text-center">Database</th>
                                    <th rowspan="2">Provider Status</th>
                                </tr>
                                <tr>
                                    <!--<th rowspan="1" colspan="1" class="">Upload</th>-->
                                    <th rowspan="1" colspan="1">Download</th>
                                    <th rowspan="1" colspan="1">Sync Status</th>
                                </tr>
                            </thead>

                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>
</section>
<div class="modal fade modal-login_hostory" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header label-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Login history <span class="label label-info"></span></</h4>
            </div>
            <div class="modal-body">
                <div style="border: 1px solid #aaa" >
                    <canvas id="loginChart"></canvas>
                </div>
                <div class="table-responsive text-center mb0">
                    <table class="table table-hover table-striped table-counter mb0">
                        <thead>
                            <tr>
                                <th class="text-center">#</th>                                    
                                <th class="text-center">Time</th>
                                <th class="text-center">Ago</th>
                                <th class="text-center">Gap</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>

                            </tr>
                        </tbody>

                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
