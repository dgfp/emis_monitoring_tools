<%-- 
    Document   : Email
    Created on : Nov 5, 2018, 5:01:43 PM
    Author     : Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<link rel="stylesheet" href="https://adminlte.io/themes/AdminLTE/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.min.js"></script>
<style type="text/css">
    input { border: 1px solid black; margin-bottom: .5em;  }
    input.error { border: 1px solid red;margin-top: 0px!important; }
    label.error {
        color:red;
        font-weight: bold;
    }
    label.valid{
        content: "\f058";  /* this is your text. You can also use UTF-8 character codes as I do here */
        font-family: FontAwesome;
        float: right;
        display:block;
        width:16px;
        height:16px
    }
    .user-icon{
        font-size: 17px!important;
    }
</style>
<section class="content-header">
    <h1>Email</h1>
</section>

<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div id="viewStatus">
                <c:if test="${success == true}">
                    <div class="callout callout-success" style="margin-bottom: 1!important;padding: 12px!important;">
                        <p class="center bold">Email has been sent successfully</p>
                    </div>
                </c:if>
                <c:if test="${success == false}">
                    <div class="callout callout-danger" style="margin-bottom: 1!important;padding: 12px!important;">
                        <p class="center bold">Internal server error, email can't sent.</p>
                    </div>
                </c:if>
            </div>
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Compose New Email</h3>
                </div>
                <div class="box-body">
                    <form action="Email" method="post" id="mail">
                        <div class="form-group">
                            <input class="form-control" name="recipient" placeholder="To:">
                        </div>
                        <div class="form-group">
                            <input class="form-control" name="subject"  placeholder="Subject:">
                        </div>
                        <div class="form-group">
                            <textarea class="form-control" name="content" id="compose-textarea"  style="height: 300px">
                            </textarea>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary"><i class="fa fa-envelope-o"></i> Send</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<script src="https://adminlte.io/themes/AdminLTE/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"></script>
<script>
    $(function () {
        //Add text editor
        $("#compose-textarea").wysihtml5();
    });
    $("#mail").validate({
        rules: {
            recipient: {
                required: true,
                email: true
            }, subject: {
                required: true
            }, content: {
                required: true
            }
        },
        messages: {
            recipient: {
                required: "Write receiver mail here"
            }, subject: {
                required: "Write mail subject here"
            }, content: {
                required: "Write email body"
            }
        }
    });
</script>
