<%-- 
    Document   : meeting-status
    Created on : May 8, 2022, 10:37:12 AM
    Author     : nar_r
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>

<script src="resources/js/area_dropdown_control_global_1.js"></script>
<script>
    $(function () {
        $("#areaDropDownPanel").slideDown("slow");
        FormDropDownInit.init([{id: 'division', name: 'division', label:'Division'}, {id: 'district', name: 'district', label:'District'}, {id: 'upazila', name: 'upazila', label:'Upazila'}], 
        [{id: 'meeting_month', 'name': 'meeting_month', label:'Meeting Month'}, {id: 'meeting_year', 'name': 'meeting_year', label:'Meeting Year'}]
                , {id: 'meeting-status-dropdown'});
    });
</script>
<section class="content-header">
    <h1> Meeting Status 
        <small>This page is under construction</small>
    </h1>
</section>
<section class="content">
    <%@include file="/WEB-INF/jspf/area_dropdown_control_global.jspf" %>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>