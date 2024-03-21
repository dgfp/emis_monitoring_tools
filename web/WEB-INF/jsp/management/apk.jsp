<%-- 
    Document   : upload
    Created on : Apr 3, 2018, 6:19:02 PM
    Author     : Rahen
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<section class="content-header">
    <h1> APK release manager
 <small></small></h1>
</section>

<section class="content">

    <div class="row">
        <div class="col-md-12">
            <DIV class="box box-primary">
                <div class="box-header with-border">
                    <div class="box-tools pull-right" style="margin-top: -10px;">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                </div>

                <form   class="box-body" method="POST" enctype="multipart/form-data" action="apk-upload" id="fileupload">
                    <div class="row form-group">
                        <label for="appType" class="col-md-1 col-xs-2">Type </label>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control" name="provtype" id="appType" required>
                                <option value="">Type</option>
                            </select>
                        </div>
                        <label for="appVersion" class="col-md-1 col-xs-2">Version </label>
                        <div class="col-md-2 col-xs-4">
                            <input type="text" class="form-control" name="version" id="appVersion" required placeholder="0.0.0" autocomplete="off">
                        </div>

                        <div class="visible-xs clearfix margin-bottom"></div>
                        
                        <label for="systemupdatedt" class="col-md-1 col-xs-2" style="line-height: 1em">Release date</label>
                        <div class="col-md-2 col-xs-4">
                            <input type="text" class="form-control" name="systemupdatedt" id="systemupdatedt" required placeholder="ddmmyy" autocomplete="off">
                        </div>

                        <div class="col-md-3  col-xs-6 form-group"> <input type="text" class="form-control" name="description" placeholder="description" autocomplete="off"></div>
                    </div>

                    <div class="row form-group">
                        <label for="district" class="col-md-1 col-xs-2">District</label>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control" name="zillaid" id="district">
                                <option value="">District</option>
                            </select>
                        </div>
                        <label for="upazila"  class="col-md-1 col-xs-2">Upazila</label>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control" name="upazilaid" id="upazila">
                                <option value="">Upazila</option>
                            </select>
                        </div>

                        <div class="visible-xs clearfix margin-bottom"></div>

                        <div class="col-md-1 col-xs-2">
                            <label for="union">Union</label>
                        </div>
                        <div class="col-md-2 col-xs-4">
                            <select class="form-control" name="unionid" id="union">
                                <option value="">Union</option>
                            </select>
                        </div>
                        <div class="col-md-3 col-xs-6">
                            <div class="btn btn-primary file-proxy"><i class="fa fa-upload"></i> Add</div>
                            <input  type="file" class="form-control" name="file" id="appFile" required>
                        </div>
                        <input type="submit" class="hidden">
                    </div>
                    <div class="col-md-12 margin-bottom-none progress"> <div class="progress-bar" style="width:0%"></div> </div>
                </form>
            </div>

            <div class="box box-primary">
                <!-- table -->
                <div class="box-body">
                    <div class="table-responsive1">
                        <table class="table table-bordered table-striped table-hover" id="data-table" width="100%">
                            <thead class="data-table">
                                <tr>
                                    <th></th>
                                    <th>Type</th>
                                    <th>Version</th>
                                    <th >Size</th>
                                    <th >Version</th>
                                    <th>Release date</th>
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
</div>
</section>

<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
<%@include file="/WEB-INF/jspf/apk.jspf" %>

