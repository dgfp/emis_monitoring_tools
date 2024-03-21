<%-- 
    Document   : Analytics
    Created on : Oct 24, 2018, 5:01:43 PM
    Author     : Rangan & Helal
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="http://maps.google.com/maps/api/js?v=3&sensor=false&key=AIzaSyD3ssv9HM8anYnyOKff9qoIt3yf-Uu09hw"></script>
<script src="resources/js/AssetManagement.js" type="text/javascript"></script>
<style>
    .form-group {
        margin-bottom: 0px!important;
    }
    #userComboLevel{
        font-size: 16px;
        font-weight: bold;
    }
    .none{
        display: none;
    }
    #viewUserDetails{
        font-size: 18px;
        margin-right: 30px!important;
    }
    .form-control {
        display: inline!important;
    }
    .form-group-sm .form-control {
        border-radius: 0px; 
        height: 31px;
    }
    [class*="col"] { margin-bottom: 10px; }
</style>
<section class="content-header">
    <h1>Web login status</h1>
</section>
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary full-screen">
                <div class="box-header with-border">
                    <div class="form-group form-group-sm">
                        <!--                        <select class="form-control select2 select2-hidden-accessible" style="width: 30%;margin-right: 30px!important;" tabindex="-1" aria-hidden="true" id="userList">
                                                    <option selected="selected">Loading...</option>
                                                </select>&nbsp;&nbsp;&nbsp;-->
                        <!--                        <a class="btn btn-info btn-xs btn-flat none" id="viewUserDetails"><b><i class="fa fa-user-circle-o" aria-hidden="true"></i></b></a>
                                                <input type="text" class="input form-control input-sm datePickerChoose" style="width: 10%;" placeholder="dd/mm/yyyy" name="startDate" id="startDate" readonly="readonly" style="background-color: rgb(255, 255, 255);"> to
                                                <input type="text" class="input form-control input-sm datePickerChoose"  style="width: 10%;" placeholder="dd/mm/yyyy" name="endDate" id="endDate" readonly="readonly" style="background-color: rgb(255, 255, 255);">-->
                    </div>
                    <div class="box-tools pull-right">
                        <!--                        <button type="button" class="btn btn-box-tool none" id="reloadData"><i class="fa fa-refresh" aria-hidden="true"></i></button>-->
                        <button type="button" class="btn btn-box-tool" id="panel-fullscreen"><i class="fa fa-expand" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <form action="Analytics" method="post" id="filterUser">
                        <div class="row">
                            <div class="col-md-1 col-xs-2">
                                <label for="division">Division</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="divid" id="divid"> </select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="zilla">District</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="zillaid" id="zillaid"> 
                                    <option value="0">All</option>
                                </select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="upazilaid">Upazila</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="upazilaid" id="upazilaid">
                                    <option value="0">All</option>
                                </select>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="unionid">Union</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="unionid" id="unionid">
                                    <option value="0">All</option>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-1 col-xs-2">
                                <label for="roleid">User role</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="roleid" id="roleid">
                                    <option value="0">All</option>
                                </select>
                            </div>

                            <div class="col-md-1  col-xs-2">
                            </div>
                            <div class="col-md-2  col-xs-4">
                                <button type="submit" class="btn btn-flat btn-primary btn-sm btn-block bold" autocomplete="off" >
                                    <i class="fa fa-area-chart" aria-hidden="true"></i>&nbsp; Show user
                                </button>
                            </div>

                            <div class="col-md-1 col-xs-2">
                                <label for="">User</label>
                            </div>
                            <div class="col-md-2 col-xs-4">
                                <select class="form-control select2 select2-hidden-accessible" style="width: 100%;" tabindex="-1" aria-hidden="true" name="userList" id="userList"> 
                                    <option value="0">All</option>
                                </select>
                            </div>
                        </div>
                    </form><br/>

                    <div class="box-body table-responsive- no-padding">
                        <table class="table table-hover table-striped" id="data-table">
                            <thead class="data-tablea">
                                <tr>
                                    <th>User IP</th>
                                    <th>Session started</th>
                                    <th>Session ended</th>
                                    <th>Session duration</th>
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
<script>
    $(function () {
        $.Analytics = $.Analytics || {
            sampleVariable: null,
            data: null,
            init: function () {
                $.Analytics.events.bindEvent();
                $.Analytics.ajax.userLoader();
                $(".full-screen").after($.app.getWatermark());
                $('[data-toggle="tooltip"]').tooltip();
            },
            clear: function () {
                $('#data-table').DataTable().destroy();
                $('#tableBody').empty();
                $("#reloadData").show();
                $("#viewUserDetails").show();
                $.app.removeWatermark();
            },
            events: {
                bindEvent: function () {
                    $.Analytics.events.userLogLoaderByUser();
                    $.Analytics.events.viewVisitedpages();
                    $.Analytics.events.userLogDetails();
                    $.Analytics.events.viewUserDetails();
                    $.Analytics.events.reloadData();
                    $.Analytics.events.filterUser();
                },
                userLogLoaderByUser: function () {
                    $(document).off('change', '#userList').on('change', '#userList', function (e) {
                        $.Analytics.showData();
                    });
                },
                viewVisitedpages: function () {
                    $(document).off('click', '.viewVisitedpages').on('click', '.viewVisitedpages', function (e) {
                        $.Analytics.ajax.viewVisitedpages($(this).data("info"));
                    });
                },
                userLogDetails: function () {
                    $(document).off('click', '.userLogDetails').on('click', '.userLogDetails', function (e) {
                        $.Analytics.ajax.userLogDetails($(this).data("info"));
                    });
                },
                viewUserDetails: function () {
                    $(document).off('click', '#viewUserDetails').on('click', '#viewUserDetails', function (e) {
                        toastr['warning']("Under development");
                    });
                },
                reloadData: function () {
                    $(document).off('click', '#reloadData').on('click', '#reloadData', function (e) {
                        $.Analytics.showData();
                    });
                },
                filterUser: function () {
                    $(document).off('submit', '#filterUser').on('submit', '#filterUser', function (e) {
                        e.preventDefault();
                        var area = $.app.pairs('#filterUser');
                        console.log(area);
                        var filteredJson = $.Analytics.data; //, jsonUser = $.Analytics.data;

                        if (area.divid != 0) {
                            filteredJson = filteredJson.filter(obj => obj.divid == area.divid);
                        }
                        if (area.zillaid != 0) {
                            filteredJson = filteredJson.filter(obj => obj.zillaid == area.zillaid);
                        }
                        if (area.upazilaid != 0) {
                            filteredJson = filteredJson.filter(obj => obj.upazilaid == area.upazilaid);
                        }
                        if (area.unionid != 0) {
                            filteredJson = filteredJson.filter(obj => obj.unionid == area.unionid);
                        }
                        if (area.roleid != 0) {
                            filteredJson = filteredJson.filter(obj => obj.roleid == area.roleid);
                        }
                        console.log(filteredJson);
                        $('select#userList').Select(filteredJson, {placeholder: '- Select User -', id: function () {
                                return this.userid
                            }, text: function () {
                                return this.name
                            }});
                    });
                }
            },
            showData: function () {
                $.Analytics.clear();
                $.Analytics.ajax.userLogLoaderByUser($('#userList').val());
            },
            ajax: {
                userLoader: function () {
                    $.ajax({
                        url: "Analytics?action=getUserList",
                        type: "POST",
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response.data);
                            if (response.success == true) {

                                $.Analytics.data = response.data;
                                $('select#userList').Select(response.data, {placeholder: '- Select User -', id: function () {
                                        return this.userid
                                    }, text: function () {
                                        return this.name
                                    }});
                                var userRole = response.role;
                                var roleid = $('select#roleid');
                                roleid.find('option').remove();
                                $('<option>').val("0").text('All').appendTo(roleid);

                                for (var i = 0; i < userRole.length; i++) {
                                    var id = userRole[i].roleid;
                                    var name = userRole[i].rolename;
                                    $('<option>').val(id).text(name).appendTo(roleid);
                                }
                            } else {
                                toastr['error']("Error occured while user load");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                },
                userLogLoaderByUser: function (userId) {
                    $.ajax({
                        url: "Analytics?action=getUserLogByUser&userId=" + userId,
                        type: "POST",
                        success: function (response) {
                            response = JSON.parse(response);
                            console.log(response);
                            if (response.success === true) {
                                $('#data-table').dataTable({
                                    processing: true,
                                    data: response.data,
                                    order: [[1, 'desc']],
                                    columns: [
                                        {data: "user_ip"},
                                        {data: {
                                                _: function (d) {
                                                    return $.app.date(d.session_start).datetime;
                                                },
                                                sort: 'session_start'

                                            }},
                                        {data: function (d) {
                                                return $.app.date(d.session_end).datetime;
                                            }},
                                        {data: 'session_duration'},
//                                        {data: function (d) {
//                                                var json = JSON.stringify({"name": d.name, "userid": d.userid, "user_ip": d.user_ip, "session_id": d.session_id});
//                                                return "<a class='btn btn-flat btn-primary btn-xs viewVisitedpages' id='viewVisitedpages' data-info='" + json + "'><b>Pages</b></a> <a class='btn btn-flat btn-primary btn-xs userLogDetails' id='userLogDetails' data-info='" + json + "'><b>Details</b></a>";
//                                            }}
                                    ]
                                });
                            } else {
                                toastr['error']("Error occured while login status load");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                },
                userLogDetails: function (json) {
                    var ip = "http://ip-api.com/json/203.190.255.35?fields=16515071";
                    var url = "http://ip-api.com/json/" + json.user_ip + "?fields=16515071";
                    console.log(url);
                    $.ajax({
                        url: url,
                        type: "GET",
                        success: function (response) {
                            if (response.status == "success") {
                                response.flag = "https://www.countryflags.io/" + response.countryCode.toLowerCase() + "/flat/64.png";
                                console.log(response);

                                $("#ip").html(json.user_ip);
                                $("#country").html(response.country + "&nbsp; <img src='" + response.flag + "' width='30' height='30'>");
                                $("#city").html(response.city);
                                $("#regionName").html(response.regionName);
                                $("#district").html(response.district);
                                $("#continent").html(response.continent);
                                $("#zip").html(response.zip);
                                $("#timezone").html(response.timezone);
                                $("#org").html(response.org);
                                $("#isp").html(response.isp);
                                $("#as").html(response.as);
                                $("#asname").html(response.asname);



                                //Map
//                                var mapProp = {
//                                    center: new google.maps.LatLng(response.lat, response.lon),
//                                    zoom: 5,
//                                };
//                                var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
//                                google.maps.event.addListener(map, 'click', function (event) {
//                                    alert(event.latLng.lat() + ", " + event.latLng.lng());
//                                });
                                var uluru = {lat: response.lat, lng: response.lon};
                                // The map, centered at Uluru
                                var map = new google.maps.Map(
                                        document.getElementById('googleMap'), {zoom: 15, center: uluru});
                                // The marker, positioned at Uluru
                                var marker = new google.maps.Marker({position: uluru, map: map});



                                $("#name").html("(" + json.name + ")");
                                $('#userLogDetailsModal').modal('show');
                            } else {
                                toastr['warning']("<b>" + response.message + "</b>");
                            }
                        }, error: function (error) {
                            toastr['error'](error);
                        }
                    });
                },
                viewVisitedpages: function (json) {
                    toastr['warning']("Under development");
                    console.log(json);
                }
            }//ajax end
        };
        $.Analytics.init();
    });
</script>
<div id="userLogDetailsModal" class="modal fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><b><i class="fa fa-times" aria-hidden="true"></i></b></button>
                <h4 class="modal-title">User login details <span id="name" class="bold"></span></h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-10 col-md-offset-1" style="margin-bottom: 15px;">
                        <div id="googleMap" style="width:100%;height:400px;"></div>
                    </div>
                    <div class="col-md-10 col-md-offset-1">
                        <div class="table-responsive fixed" >
                            <table class="table table-striped table-hover" id="data-table">
                                <tbody id="tableBody">
                                    <tr>
                                        <td style="width: 50%;text-align: right">User IP :</td>
                                        <td style="width: 50%"><b id="ip"></b></td>
                                    </tr>               
                                    <tr>
                                        <td class="pull-right">Country :</td>
                                        <td><b id="country"></b></td>
                                    </tr>                        
                                    <tr>
                                        <td class="pull-right">City :</td>
                                        <td><b id="city"></b></td>
                                    </tr>                     
                                    <tr>
                                        <td class="pull-right" data-toggle="tooltip" title="Region/state">Region name :</td>
                                        <td><b id="regionName"></b></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-right">District :</td>
                                        <td><b id="district"></b></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-right" data-toggle="tooltip" title="Continent name">Continent :</td>
                                        <td><b id="continent"></b></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-right">Zip code :</td>
                                        <td><b id="zip"></b></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-right">Timezone :</td>
                                        <td><b id="timezone"></b></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-right">Organization :</td>
                                        <td><b id="org"></b></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-right" data-toggle="tooltip" title="Internet Service Provider name">ISP :</td>
                                        <td><b id="isp"></b></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-right" data-toggle="tooltip" title="AS number and organization, separated by space (RIR). Empty for IP blocks not being announced in BGP tables.">AS :</td>
                                        <td><b id="as"></b></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-right" data-toggle="tooltip" title="AS name (RIR). Empty for IP blocks not being announced in BGP tables.">AS name :</td>
                                        <td><b id="asname"></b></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-flat btn-default" data-dismiss="modal">&nbsp;&nbsp;&nbsp;<b>Close&nbsp;&nbsp;&nbsp;<br></b></button>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>
