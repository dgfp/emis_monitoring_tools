<%-- 
    Document   : downloadChecker
    Created on : July 9, 2017, 3:44:09 PM
    Author     : Helal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>eMIS</title>
        <link rel="stylesheet" media="screen" href="">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="resources/logo/rhis_favicon.png">
        <link href="resources/TemplateCSS/_all-skins.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/TemplateCSS/bootstrap.min.css" rel="stylesheet" type="text/css"/>

        <link href="resources/css/AdminLTE.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/style.css" rel="stylesheet" type="text/css"/>
        <script src="https://use.fontawesome.com/a4e256df38.js"></script>

        <script src="resources/jquery/jquery.min.js"></script>
        <script src="resources/TemplateJs/toastr.js" type="text/javascript"></script>
        <link href="resources/TemplateCSS/toastr.css" rel="stylesheet" type="text/css"/>
        <script src="resources/js/moment.min.js" type="text/javascript"></script>
        <script src="resources/js/$.app.js" type="text/javascript"></script>
        <!-- 
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        -->
        <style>
            .title{
                display: none;
            }
            .time{
                display: none;
            }

            #snackbar {
                visibility: hidden;
                min-width: 250px;
                margin-left: -125px;
                background-color: #0b5084;
                color: #fff;
                text-align: center;
                font-weight: bold;
                padding: 16px;
                position: fixed;
                z-index: 1;
                left: 50%;
                bottom: 30px;
                font-size: 17px;
            }
            .nav-pillsright{
                margin-bottom: -20px!important;
                margin-top: -15px!important;
            }
            element.style {
                margin-bottom: -33px!important;
            }
            #snackbar.show {
                visibility: visible;
                -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
                animation: fadein 0.5s, fadeout 0.5s 2.5s;
            }

            @-webkit-keyframes fadein {
                from {bottom: 0; opacity: 0;} 
                to {bottom: 30px; opacity: 1;}
            }

            @keyframes fadein {
                from {bottom: 0; opacity: 0;}
                to {bottom: 30px; opacity: 1;}
            }

            @-webkit-keyframes fadeout {
                from {bottom: 30px; opacity: 1;} 
                to {bottom: 0; opacity: 0;}
            }

            @keyframes fadeout {
                from {bottom: 30px; opacity: 1;}
                to {bottom: 0; opacity: 0;}
            }
            .right{
                text-align: right!important;
            }
            .left{
                text-align: left!important;
            }
            #response{
                margin-top: 60px!important;
            }
            .borderless td, .borderless th {
                border-color: #e2e0e0!important;
                box-shadow: 5px 5px 15px #e2e0e0;

            }
            element.style {
                margin-bottom: -22px!important;
            }
            @media print {
                /*                table{
                                    font-family: SolaimanLipi;
                                    font-size: 12px;
                                    margin-top: -11px;
                                }
                                th, td {
                                    padding: 1px;
                                    padding-left: 5px;
                                }*/
                .box-header, .main-footer, .print-hide{
                    display: none !important;
                }
                table{
                    font-size: 15px;
                }
                .box.box-warning {
                    border-top-color: #fff!important;

                }
                .title{
                    display: block;
                    text-align: center;
                    margin-top: -50px!important;
                }
                .comparison{
                    color: #000!important;
                }
                .time{
                    display: block;
                }

            }
        </style>
        <script>
            $(function () {
                $('.time').text("Printed at " + getNow());
                var $table = $('table'),
                        $info = $table.filter('#provider-info'),
                        $comparison = $table.filter('#provider-comparison'),
                        $legend = $table.filter('#provider-legend'),
                        $btn = $("button"),
                        $response = $('#response'),
                        param = {},
                        columnDefs = [
                            ["Record Time", "modifydate", null],
                            ["Household", "household", [2, 3]],
                            ["SES", "ses", [2, 3]],
                            ["Member", "member", [2, 3]],
                            ["Clientmap", "clientmap", [2, 3]],
                            ["Eligible Couple", "elco", 3],
                            ["Elco Visit", "elcovisit", 3],
                            ["Immunization History", "immunizationhistory", 3],
                            ["Pregnant Women", "pregwomen", [2, 3]],
                            ["Pregnant Refer", "pregrefer", [2, 3]],
                            ["ANC Service", "ancservice", [2, 3]],
                            ["Preg Danger Sign", "pregdangersign", [2, 3]],
                            ["Delivery", "delivery", [2, 3]],
                            ["Birth", "newborn", [2, 3]],
                            ["PNC Service Child", "pncservicechild", [2, 3]],
                            ["PNC Service Mother", "pncservicemother", [2, 3]],
                            ["Death", "death", [2, 3]],
                            ["Woman Injectable", "womaninjectable", 3],
                            ["Adolesent", "adolescent", 3],
                            ["Adolescent Problem", "adolescentproblem", 3],
                            ["Under 5 Child", "under5child", [2, 3]],
                            ["Under 5 Child Advice", "under5childadvice", [2, 3]],
                            ["Under 5 Child Problem", "under5childproblem", [2, 3]],
                            ["Mother Nutrition", "mothernutrition", 3],
                            ["Child Nutrition", "childnutrition", 3],
                            ["Migration Out", "migrationout", [2, 3]],
                            ["Vaccine Cause", "vaccinecause", 2],
                            ["Epi Master", "epimaster", 2],
                            ["Epi Master Woman", "epimasterwoman", 2],
                            ["Epi Scheduler", "epischedulerupdate", 2],
                            ["Session Master", "sessionmasterupdate", 2],
                            ["Session Master Woman", "sessionmasterwomanupdate", 2],
                            ["Work Plan Master", "workplanmaster", null],
                            ["Work Plan Detail", "workplandetail", null],
                            ["ANC Service", "ancservicefpi", [10, 11, 12]],
                            ["Household", "householdfpi", [10]],
                            ["Delivery", "deliveryfpi", [10, 11, 12]],
                            ["Eligible Couple", "elcofpi", [10]],
                            ["ELCO Visit", "elcovisitfpi", [10]],
                            ["Member", "memberfpi", [10]],
                            ["Newborn", "newbornfpi", [10, 11, 12]],
                            ["PNC Service Child", "pncservicechildfpi", [10, 11, 12]],
                            ["PNC Service Mother", "pncservicemotherfpi", [10, 11, 12]],
                            ["Pregnant Women", "pregwomenfpi", [10, 11, 12]],
                            ["SES", "sesfpi", [10]],
                            ["Monitoring", "fpimonitoring", [10]]
                        ],
                        getParam = function () {
                            return $.app.pairs('.box-tools :input');
                        },
                        doAuto = function () {
                            param.providerid && $btn.click();
                        },
                        snackbar = function (message, type, timeout) {
                            type = "error";
                            timeout = 5000;
                            //$("#snackbar").html(message).addClass("show").delay(timeout).queue('fx', function() { $(this).removeClass('show');});
                            $.toast(message, type)();
                        };

                param = getParam();
                setTimeout(doAuto, 100);
                $response.prepend('<b id="emis">eMIS</b>');

                $btn.click(function () {
                    $info.find('tbody').empty();
                    param = getParam();
                    if (!param.providerid) {
                        snackbar("Please enter provider id");
                    } else if (param.providerid.length > 6 || param.providerid.length < 5) {
                        $table.find('thead').hide();
                        snackbar("Invalid provider id");

                    } else {
                        $response.empty();
                        $response.prepend('<div style="margin-top:-40px!important"><img src="resources/images/ani.gif" alt=""/></div>');
                        $table.hide();
                        $.ajax({
                            url: "downloadChecker",
                            data: param,
                            type: 'POST',
                            success: function (result) {
                                result = JSON.parse(result);
                                result.data = result.data ? JSON.parse(result.data) : [];
                                console.log('result', result);
                                var json = result.data;
                                console.log(json);
                                $table.find('thead').show();
                                //setTable(json);
                                setTimeout(function () {
                                    setTable(json);
                                }, 1000);

                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                snackbar("Request can't be processed");
                            }
                        });//Ajax end
                    }


                });


                function setTable(json) {
                    console.log(json);
                    $response.empty();
                    if (json.length === 0) {
                        snackbar("No data found");
                    } else {

                        var srv = tmp = json[0] || {}, tab = json[1] || {};
                        var idx = parseInt(srv.server_tab, 10) - 1;


                        var thead = '<tr class="bg-default">'
                                + '<th>ID# <b>' + srv.providerid + '</b></th>'
                                + '<th><b>' + srv.provider_name + ' (' + srv.typename + ') ' + '</b></th>'
                                + '<th>Call: <b><a href="tel:+88' + srv.mobileno + '">' + srv.mobileno + '</a></b></th>'
                                + '</tr>';
                        var tbody = '<tr>'
                                + '<td>Zilla: <b>' + srv.zillanameeng + '</b></td>'
                                + '<td>Upazila: <b>' + srv.upazilanameeng + '</b></td>'
                                + '<td>Union: <b>' + srv.unionnameeng + '</b></td>'
                                + '</tr>';

                        $info.html(thead + tbody);
                        var provtype = tab.provtype || srv.provtype;

                        if (idx) {
                            console.log('srv', srv, 'tab', tab);
                            srv = tab;
                            tab = tmp;
                            console.log('srv', srv, 'tab', tab);
                        }

                        var html = "";
                        var cmpKlass = function (cmpVal) {
                            return cmpVal < 0 ? "bg-red" : (cmpVal > 0 ? "bg-yellow" : "bg-green");
                        }
                        $.each(columnDefs, function (i, col) {
                            if ($.isArray(col[2]) ? ~$.inArray(provtype, col[2]) : (provtype == col[2] || !col[2])) {
                                var key = col[1];
                                console.log(key,provtype);
                                var isDate = key == 'modifydate';
                                var srvVal = (srv[key] || 0), tabVal = (tab[key] || 0), cmpVal = 0;
                                if (isDate) {
                                    console.log(i, key, srvVal, tabVal);
                                    srvVal = new Date(srvVal);
                                    tabVal = new Date(tabVal);
                                }
                                cmpVal = (+srvVal) - (+tabVal);
                                var klass = cmpKlass(cmpVal);
                                if (isDate) {
                                    cmpVal = moment(srvVal).diff(tabVal, 'days'); //.format("m[m] s[s]");
                                    cmpVal += ' day' + (cmpVal > 1 ? 's' : '');
                                    srvVal = moment(srvVal).format('lll');
                                    tabVal = moment(tabVal).format('lll');
                                }
                                //klass+=" right";
                                html += '<tr><td>' + col[0] + '</td><td class="right">' + srvVal + '</td><td class="right">' + tabVal + '</td><td  class="' + klass + ' right comparison">' + cmpVal + '</td></tr>';
                            }
                        });

                        $comparison.find('tbody').html(html);
                        $table.slideDown("slow");
                    }
                }





                $("#exportCSV").click(function (event) {
                    var outputFile = "eMIS_Sync_Checker-" + $("input[name=providerid]").val() + "-" + getNow();
                    outputFile = outputFile.replace('.xls', '') + '.xls';
                    exportTableToCSV.apply(this, [$('#provider-comparison'), outputFile]); //function call from TemplateHeader
                });

            });
        </script>
    </head>
    <body class="skin-blue fixed sidebar-mini">
        <header class="main-header">
            <!-- Logo -->
            <a href="ProviderDB_STATUS" class="logo hidden-xs">
                <span class="logo-mini"><b>e</b>MIS</span>
                <span class="logo-lg"><img src="resources/logo/logo2.png" width="90" height="42" alt=""></span>
            </a>
            <!-- Header Navbar: style can be found in header.less -->
            <nav class="navbar navbar-static-top">
                <!-- Sidebar toggle button-->
                <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                </a>
                <!-- Navbar Right Menu -->

            </nav>
        </header>
    </div>
    <div style="padding-top:60px">
        <div class="container">
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <div class="box box-warning">
                        <div class="box-header with-border">
                            <h3 class="box-title text-muted"><b class="text-yellow">e</b><b class="text-blue">MIS</b> <span class="hidden-xs">Sync Checker</span></h3>
                            <div class="box-tools">
                                <div class="input-group input-group-sm pull-right" style="width: 200px;">
                                    <input type="text" name="providerid" value="${param.providerid}" class="form-control pull-right" placeholder="Provider ID" title="Provider ID" style="width: 150px;">

                                    <div class="input-group-btn">
                                        <button type="submit" class="btn btn-default"><i class="fa fa-search"></i></button>
                                    </div>
                                </div>
                                <div class="input-group input-group-sm pull-right" style="width: 82px;">
                                    <div class="input-group-btn">
                                        <span class="btn btn-primary">Type</span>
                                    </div>
                                    <input type="text" name="provtype" value="${param.provtype}" class="form-control" placeholder="Type"  title="Provider Type">
                                </div>
                                <div class="input-group input-group-sm pull-right" style="width: 82px;">
                                    <div class="input-group-btn">
                                        <span class="btn btn-primary">Zilla</span>
                                    </div>
                                    <input type="text" name="zillaid" value="${param.zillaid}" class="form-control" placeholder="Zilla ID"  title="Zilla ID">
                                </div>

                            </div>
                        </div>
                        <h1 class="title">eMIS Sync Checker</h1>
                        <div class="box-body table-responsive no-padding">
                            <table class="table table-hover" id="provider-info">
                                <thead></thead>
                                <tbody></tbody>
                                <tfoot></tfoot>
                            </table>
                        </div>
                    </div>
                    <table  class="table borderless" id="provider-legend" style="margin-bottom: -2px!important">
                        <thead>
                            <tr class="label-primary-">
                                <th class="bg-green text-center">0</th>
                                <th>No mismatch</th>
                                <th class="bg-yellow  text-center">+</th>
                                <th>Server > Tablet</th>
                                <th class="bg-red  text-center">-</th>
                                <th>Server < Tablet</th>
                            </tr>
                        </thead>
                    </table>
                    <div class="table-responsive">
                        <p class="clearfix" style="padding-top:10px">
                            <a class="btn btn-flat btn-default btn-xs bold pull-right print-hide" id="exportCSV"><i class="fa fa-file-excel-o" aria-hidden="true"></i>&nbsp;Excel</a>
                            <a class="btn btn-flat btn-default btn-xs bold pull-right print-hide" style="margin-right: 5px;" onclick="window.print();"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print / PDF</a>
                        </p>
                        <table  class="table table-bordered table-hover table-striped" id="provider-comparison">
                            <colgroup>
                                <col class="grey" />
                                <col class="red" span="3" />
                                <col class="blue" />
                            </colgroup>
                            <thead>
                                <tr class="bg-primary">
                                    <th class="left">Variable</th>
                                    <th class="right">Server</th> 
                                    <th class="right">Tab</th>
                                    <th class="right comparison">Comparison <br>(Server-Tab) </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <p class="pull-right time"></p>
                    </div>
                    <div class="text-center" id="response">   
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div id="snackbar"></div>
</body>
</html>

