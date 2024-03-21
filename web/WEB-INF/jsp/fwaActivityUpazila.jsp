<%-- 
    Document   : fwaActivityUpazila
    Created on : Jan 8, 2017, 12:21:38 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/header.jspf" %>
<script src="resources/js/jspdf.min.js"></script>
<link href="resources/css/style.css" rel="stylesheet" type="text/css"/>


<div id="page-wrapper">

    <div class="container-fluid">

        <div class="row">
            <div class="col-lg-12">
                <h3>FWA Monthly Activity</h3>
                <input type="hidden" id="pprsSD" value="25/12/2014">
            </div>
        </div>

        <div class="well well-sm">
            <div class="row">
                
                <!--Division-->
                <div class="col-md-2">
                    <label for="division">Select FWA</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="division" id="division">
                       <option value="">All</option>
                    </select>
                </div>

                <!--District-->
                <div class="col-md-1">
                    <label for="district">Month</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="district" id="district">
                        <option value="">All</option>
                    </select>
                </div>
                
                
                <!--District-->
                <div class="col-md-1">
                    <label for="district">Year</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="district" id="district">
                        <option value="">All</option>
                    </select>
                </div>

                <!--Show-->
                <div class="col-md-2">
                    <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-info btn-block btn-sm" autocomplete="off">
                        <i class="fa fa-street-view" aria-hidden="true"></i> View Activity
                    </button>
                </div>                             
            </div>
        </div> 
        
        <!--Alert message-->
        <div class="alertMsg" id="alert">
            
        </div>
        
        <!--Loading gif-->
        <div id="ajaxLoading">

        </div>


                            
        <!--Data Table-->               
        <div class="col-ld-12" id="upazilaTable">
            <div class="table-responsive" >
                <table class="table table-bordered">
                    <thead id="tableHeader">
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

<%@include file="/WEB-INF/jspf/pprs_footer.jspf" %>
