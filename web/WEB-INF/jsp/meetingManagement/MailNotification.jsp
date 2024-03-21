<%-- 
    Document   : MailNotification
    Created on : Aug 26, 2020, 11:01:35 AM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/HeaderSeparator.jspf" %>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<style>
    h1{
        color: #305A8A;
    }
    .u-dev{
        padding-bottom: 105px;  
    }
    h1 {
        font-family: SolaimanLipi;
        font-size: 35px;
    }
</style>
<script>
</script>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 id="pageTitle">
        <span id="title">Meeting Notice</span>
    </h1>
</section>
<!-- Main content -->
<section class="content">
    <div class="row" id="areaPanel">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                </div>
                <div class="box-body">
                    <div class="u-dev">
                        <center>
                            <c:choose>
                                <c:when test="${success}" >
                                    <h1 style="color:#007296" class="bold"><i class="fa fa-check-circle-o" aria-hidden="true"></i>&nbsp; ইমেইলটি সফলভাবে প্রেরণ করা হয়েছে</h1>
                                </c:when>
                                <c:otherwise>
                                    <h1 style="color:#E40230" class="bold"><i class="fa fa-exclamation-circle" aria-hidden="true"></i>&nbsp; ইমেল প্রেরণ ব্যর্থ হয়েছে</h1>
                                </c:otherwise>
                            </c:choose>
                            <img src="resources/images/send_mail.jpg" width="400" height="400" alt=""/>
                        </center>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
