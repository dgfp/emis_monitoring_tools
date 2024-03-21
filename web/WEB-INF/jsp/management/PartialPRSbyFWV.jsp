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
</style>
<script>
    $(function () {

        $('#list-village').Select(
                {
                    url: './FreeFloatingHousehold?action=getVillage',
                    data: {zillaid: 69, providerid: 693066},
                    type: 'POST'
                },
                {
                    text: function (i, o) {
                        return o.villagename;
                    },
                    option: function (o, i) {
                        console.log(this, o, i);
                        var html =
                                '<div class="col-md-2 col-sm-3 col-xs-4">\
                                    <div class="box box-info">\
                                        <div class="box-header with-border">\
                                            <span class="box-title">' + o.text + '</span>\
                                           </div>\
                                         <div class="box-body"></div>\
                                    </div>\
                                </div>';
                        return html;
                    }
                }).on('Select', console.log);


    });

</script>

<!-- Content Header (Page header) -->
<section class="content-header">

    <h1>Free Floating Household </h1>
    <div><input id="providerid" value="${param.providerid}"/>
        <input id="zillaid" value="${param.zillaid}"/>
        <select id="villages"></select>
    </div>
</section>
<!-- Main content -->
<section class="content">
    <div class="row" id="tableContent">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <div class="row" id="list-village">


                    </div>
                    <!-- table -->
                    <div class="box-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped table-hover" id="data-table">
                                <thead class="data-table">
                                    <tr>
                                        <th>#</th>
                                        <th>Union</th>
                                        <!--                                    <th>Unit</th>-->
                                        <th>Provider</th>
                                        <th>&nbsp;&nbsp;&nbsp;Date&nbsp;&nbsp;&nbsp;</th>
                                        <th style="text-align: center">Status</th>
                                        <th style="text-align: center">&nbsp;&nbsp;&nbsp;Actions&nbsp;&nbsp;&nbsp;</th>
                                    </tr>
                                </thead>
                                <tbody id="tableBody">
                                </tbody>
                                <tfoot id="tableFooter">
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</section>
<!-------- Start Report Modal -----------> 
<!-------- End Report Modal ----------->  
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>