<%-- 
    Document   : ReportSubmission
    Created on : Feb 28, 2018, 11:53:41 AM
    Author     : Helal | m.helal.k@gmail.com
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<style>
    /*    #tableContent { display: none; }*/
    tr {
        max-height: 15px !important;
        height: 15px !important;
    }
    #data-table{
        font-size: 15px;
    }
    .nav-tabs-custom>.nav-tabs>li.active {
        border-top-color: #F39C12;
    }

    #slogan{
        border: 1px solid #000000;
        text-align: center;
        padding: 2px;
        margin-top: 45px;
        word-wrap: break-word;
    }
    #page{
        margin-top: -55px;
    }
    #logo{
        margin-top: 10px;
        margin-left: 5px;
        width:50px;
        height:50px;
    }
    .mis_table th, .mis_table td{ 
        border: 1px solid #000;
        padding: 5px;
    }

    tr.bg-warning{ background: rgba(243, 156, 18, .3) !important; }
</style>
<script>
    $(function () {


        ////"{93175,93176}" "{35708,36100}"
        var config = {
            url: 'FreeFloatingHousehold?action=getHouseholds',
            data: {
                zillaid: 93,
                providerid: 93175
            },
            type: 'POST'
        };
        var $table = $('#list-household').Select(config, {
            option: function (o, i) {}
        }).on('Select', function (e, data) {
            var options = {
                data: data,
                dom: "<'row'<'col-sm-6'i><'col-sm-6'f>><'row'<'col-sm-12'tr>><'row'<'col-sm-5'i><'col-sm-7'p>>",
                bDestroy: true,
                //info: false,
                //paging: false,
                createdRow: function (row, data, dataIndex) {
                    var wards = data.wards || [], units = data.units || [];
                    var autoFix = wards.length === 1 && units.length === 1;
                    !autoFix && $(row).addClass('bg-warning');
                },
                columns: [
                    {data: function (r) {
                            return [r.hhno + ', ' + r.villagenameeng + ', ' + r.mouzanameeng, r.unionnameeng + ', ' + r.upazilanameeng, r.zillanameeng].join('<br>');
                        }, title: 'Address'},
                    {data: function (r) {
                            return $.map(r.members, function (o, i) {
                                return o.nameeng;
                            }).join('<br>');
                        }, title: 'Members'},
                    {data: function (r) {
                            var wards = r.wards || [], units = r.units || [], html = '';
                            //if (wards.length && units.length) {
                            var autoFix = wards.length === 1 && units.length === 1;
                            //var row = table.row($(this).parents('tr'));
                            //var node = row.node();
                            var _wards = $.app.Select(wards, {text: function (i, o) {
                                    return $.app.wards[o][1];
                                }, placeholder: wards.length > 1 ? 'Ward?' : null});
                            _wards = '<select name="ward" class="form-control">' + _wards + '</select>';
                            var _units = $.app.Select(units, {text: function (i, o) {
                                    return $.app.units[o][1];
                                }, placeholder: units.length > 1 ? 'Unit?' : null});
                            _units = '<select name="unit" class="form-control">' + _units + '</select>';
                            var keys = 'zillaid,upazilaid,unionid,mouzaid,villageid,hhno'.split(',');
                            var href = 'FreeFloatingHousehold?action=setHousehold&' + $.param($.app.pluck(r, keys));
                            var klass = autoFix ? '' : 'hidden';
                            var _link = '<button class="btn btn-flat btn-primary ' + klass + '" href="' + href + '">Fix</button>';
                            html = _wards + _units + _link;
                            var box = $('<div/>', {'class': '-box-catchment', html: html});
                            html = box.prop('outerHTML');
                            //}
                            return html;
                        }, title: 'Ward/Unit'}
                ]
            };
            $(e.target).DataTable(options);
        })
                .on('change', 'select', function (e, data) {
                    var $parent = $(e.target).parent(), $btn = $parent.find('.btn');
                    var data = $.app.pairs($parent.find('select'));
                    var autoFix = data.ward && data.unit;
                    var fn = autoFix ? 'removeClass' : 'addClass', klass = 'hidden';
                    $btn[fn](klass).addClass('btn-warning');
                })
                .on('click', '.btn', function (e, data) {
                    var $btn = $(e.target), $parent = $btn.parent();
                    var data = $.app.pairs($parent.find('select'));
                    var href = $btn.attr('href');
                    var table = $table.DataTable();
                    var row = table.row($(this).parents('tr'));
                    var node = row.node();
                    //console.log(href,data,row,node);
                    row.remove().draw();
                    //setHousehold(href,data);
                    return false;
                });
    });

</script>

<!-- Content Header (Page header) -->
<section class="content-header">

    <h1>Free Floating Household </h1>
    <div class="hidden">
        <input id="providerid" value="${param.providerid}"/>
        <input id="zillaid" value="${param.zillaid}"/>
    </div>
</section>
<!-- Main content -->
<section class="content">
    <div class="row" id="tableContent">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <!-- table -->
                    <div class="box-body">
                        <table class="table table-bordered table-striped table-hover" id="list-household">
                        </table>
                    </div>
                </div>
            </div>
        </div>
</section>
<!-------- Start Report Modal -----------> 
<!-------- End Report Modal ----------->  
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>