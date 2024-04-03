<%-- 
    Document   : mne-expert-list
    Created on : Apr 3, 2024, 11:33:22 AM
    Author     : Abdul Mannan
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>

<style>
</style>
<script>
    $(function () {
        var options = {
            paging: false,
            searching: false,
            info: false,
            ordering: false,
            //order: [[0, "desc"]],
            columns: [
                {data: 'name', title: 'নাম'},
                {data: 'mobile', title: 'মোবাইল'},
                {data: 'zilla', title: 'জেলার দায়িত্ব প্রাপ্ত মনিটরিং এক্সপার্টগণ'},
                ],
            data: [
                {name: 'সোহরাব ভূইয়া', mobile: '01511-068559', zilla: 'বরগুনা,ফরিদপুর, গাইবান্ধা, গোপালগঞ্জ, লালমনিরহাট, নীলফামারী, রংপুর,শরীয়তপুর'},
                {name: 'মোশারফ হোসেন', mobile: '01916-458266', zilla: 'ব্রাহ্মণবাড়িয়া,হবিগঞ্জ,মানিকগঞ্জ, মৌলভীবাজার,পঞ্চগড, রাজশাহী,শেরপুর,সুনামগঞ্জ,সিলেট'},
                {name: 'মোহাম্মদ আহসান উল্লাহ', mobile: '01876-204321', zilla: 'বান্দরবান,ভোলা,কক্সবাজার,খাগড়াছড়ি,খুলনা,মাদারীপুর,রাঙ্গামাটি,'},
                {name: 'মোঃ এনামুল হক', mobile: '01896-310943', zilla: 'চাঁদপুর,চট্টগ্রাম,কুমিল্লা,কুষ্টিয়া,লক্ষ্মীপুর,নড়াইল,নোয়াখালী'},
                {name: 'মনির ভূইয়া', mobile: '01738-080576', zilla: 'দিনাজপুর,ঝিনাইদহ,কিশোরগঞ্জ,কুড়িগ্রাম,মেহেরপুর,নাটোর,ঠাকুরগাঁও'},
                {name: 'শিল্পী বর্মন', mobile: '01986-310939', zilla: 'বরিশাল,ঢাকা, ফেনী,ঝালকাটি,জয়পুরহাট, টাঙ্গাইল,চুয়াডাঙ্গা'}
            ]
        };
        var $dt = $('table#mne-expert-list');
        $dt.dt(options);
    });
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle">Monitoring Expert List</h1>
</section>
<!-- Main content -->
<section class="content">
    <div class="row" id="areaPanel">
        <div class="col-xs-12">
            <div class="box box-primary full-screen">
                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                   
                    <div class="col-xs-10 col-xs-offset-1">
                        <table id="mne-expert-list" class="table table-striped">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
