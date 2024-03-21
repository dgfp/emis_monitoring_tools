<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/header.jspf" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">

            <table border=1>
                <thead>
                    <tr>
                        <th>Name</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${Employees}" var="Employee">
                        <tr>
                            <td><c:out value="${Employee.villagenameeng}" /></td>
                           
                         </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/jspf/footer.jspf" %>
