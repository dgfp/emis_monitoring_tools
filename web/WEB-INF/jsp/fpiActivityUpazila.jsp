<%-- 
    Document   : fpiActivityUpazila
    Created on : Jan 8, 2017, 12:20:43 PM
    Author     : Helal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/header.jspf" %>
<script src="resources/js/jspdf.min.js"></script>
<link href="resources/css/style.css" rel="stylesheet" type="text/css"/>
<style>
    #loading {
        position: absolute;
        top: 0;
        left: 0;
        width: 90%;
        height: 100%;
        margin-left: 251px;
        margin-top: 50px;
        z-index: 1000;
        background-color: black;
        opacity: .5;
    }

    .ajax-loader {
        position: absolute;
        left: 50%;
        top: 46%;
        margin-left: -82px; 
        margin-top: -42px; 
        display: block;
    }
</style>

<script>
    $(document).ready(function () {
        //Load FPI List-------------------------------------------------------------
        $.get("providerJsonProvider?pId=10", function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#division');
            selectTag.find('option').remove();

            if(returnedData.length!==1){
                $('<option>').val("").text('All').appendTo(selectTag);
            }

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].id;
                var name = returnedData[i].divisioneng;
                $('<option>').val(id).text(name).appendTo(selectTag);
            }
        });
        
    });
</script>

<div id="page-wrapper">

    <div class="container-fluid">

        <div class="row">
            <div class="col-lg-12">
                <h3>FPI Monthly Activity</h3>
                <input type="hidden" id="pprsSD" value="25/12/2014">
            </div>
        </div>

        <div class="well well-sm">
            <div class="row">
                
                <!--Division-->
                <div class="col-md-2">
                    <label for="division">Select Provider</label>
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
