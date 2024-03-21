<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/templateHeader.jspf" %>
<script src="resources/TemplateJs/Chart.bundle.js" type="text/javascript"></script>
<style>
    #rightAlign{
        text-align: right;
    }
    
    #leftAlign{
        text-align: left;
    }
    
    canvas {
      -moz-user-select: none;
      -webkit-user-select: none;
      -ms-user-select: none;
    }
</style>
<script>
    var barChartData = {
      labels: ["Basail", "Mirzapur", "Tangail Sadar", "Modhupur", "Tangail Sadar", "Modhupur"],
      datasets: [{
        label: 'Have NID card',
        backgroundColor: "#aad700",
        yAxisID: "bar-y-axis",
        data: [
          30, 40, 48, 55, 48, 55
        ]
      }, {
        label: 'Never had',
        backgroundColor: "#ffe100",
        yAxisID: "bar-y-axis",
        data: [
          30, 40, 42, 35, 42, 35
        ]
      }, {
        label: 'Lost',
        backgroundColor: "#ef0000",
        yAxisID: "bar-y-axis",
        data: [
          12, 5, 2, 2, 2, 2
        ]
      }, {
        label: 'Cannot loacte',
        backgroundColor: "pink",
        yAxisID: "bar-y-axis",
        data: [
          5, 10, 5, 5, 5, 5
        ]
      }, {
        label: 'Kept in other place',
        backgroundColor: "green",
        yAxisID: "bar-y-axis",
        data: [
          2, 3, 2, 2, 2, 2
        ]
      }, {
        label: 'Not citizen',
        backgroundColor: "blue",
        yAxisID: "bar-y-axis",
        data: [
          21, 2, 1, 1, 1, 1
        ]
      }]
    };

    window.onload = function() {
      var ctx = document.getElementById("canvas").getContext("2d");
      window.myBar = new Chart(ctx, {
        type: 'bar',
        data: barChartData,
        options: {
          tooltips: {
            mode: 'label'
          },
          responsive: true,
          scales: {
            xAxes: [{
              stacked: true,
            }],
            yAxes: [{
              stacked: false,
              ticks: {
                beginAtZero: true,
                min: 0,
                max: 100
              }
            }, {
              id: "bar-y-axis",
              stacked: true,
              display: false, //optional
              ticks: {
                beginAtZero: true,
                min: 0,
                max: 100
              },
              type: 'linear'
            }]
          }
        }
      });
    };
  </script>
  
<script>
    $(document).ready(function () {
        
        //Load District wise Area dropdown
        resetArea("District");
        
        //Initilization of data representer
        var tableHeader = $('#tableHeader');
        var tableBody = $('#tableBody');
        var tableFooter = $('#tableFooter');
        var dashboard = $('#dashboard');
        var chart = $('#chart');
        
        //NID Report District Wise=================================================
        $('#showDistrictPRS').click(function () {
            
            //reset all data presenter like Dashboard - chart - Table
            resetAllDataPresenter();
            
            //Get Parameter
            var divisionId = $("select#division1").val();
            var districtId = $("select#district1").val();
            var startDate = $("#startDate1").val();
            var endDate = $("#endDate1").val();
            
            //alert("Date:"+startDate);

            if( divisionId===""){
                toastr["error"]("<h4><b>Please select Division</b></h4>");
                
            }else if( districtId===""){
                toastr["error"]("<h4><b>Please select District</b></h4>");
                
            }else if( startDate===""){
                toastr["error"]("<h4><b>Please select Start Date</b></h4>");
                
            }else if( endDate===""){
                toastr["error"]("<h4><b>Please select End Date</b></h4>");
            }else {
                
                var btn = $(this).button('loading');
                Pace.track(function(){
                    $.ajax({
                        url: "NidPossessionStatus?action=showDistrictWise",
                        data: {
                            districtId: districtId,
                            startDate: startDate,
                            endDate: endDate
                        },
                        type: 'POST',
                        success: function (result) {
                            var json = JSON.parse(result);
                            if (json.length === 0) {
                                btn.button('reset');
                                toastr["error"]("<h4><b>No data found</b></h4>");
                            }else{
                                //<-Table-> NID Possession Status===================
                                
                                //For Data table header

                                var header="<tr>"
                                    +"<th>#</th>"
                                    +"<th>District</th>"
                                    +"<th>Registered</th>"
                                    +"<th>Eligible(18+)</th>"
                                    +"<th>Have NID</th>"
                                    +"<th>(%)</th>"
                                    +"<th>Don't Have</th>"
                                    +"<th>Missing</th>"
                                    +"<th>Not Found</th>"
                                    +"<th>Other Place</th>"
                                    +"<th>Not Citizen</th>"
                                +"</tr>";
                                tableHeader.append(header);

                                var registered_sum = 0, eligible_sum = 0, havenid_sum = 0,
                                        dont_have_sum = 0, missing_sum = 0, not_found_sum = 0, other_place_sum = 0, not_citizen_sum = 0;

                                for (var i = 0; i < json.length; i++) {

                                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                            + "<td id='leftAlign'>" + json[i].distname + "</td>"
                                            + "<td id='rightAlign'>" + json[i].registered + "</td>"
                                            + "<td id='rightAlign'>" + json[i].eligible + "</td>"
                                            + "<td id='rightAlign'>" + json[i].havenid + "</td>"
                                            + "<td id='rightAlign'>" + json[i].percent + "</td>"
                                            + "<td id='rightAlign'>" + json[i].dont_have + "</td>"
                                            + "<td id='rightAlign'><a href='viewNidMissing?districtId="+districtId+"&upazilaId="+json[i].upazilaid+"&unionId="+json[i].unionid+"&sDate="+getDateFormat(startDate)+"&eDate="+getDateFormat(endDate)+"' target='_blank'><b>" + json[i].missing + "</b></a></td>" //class='btn btn-primary btn-xs'
                                            + "<td id='rightAlign'>" + json[i].not_found + "</td>"
                                            + "<td id='rightAlign'>" + json[i].other_place + "</td>"
                                            + "<td id='rightAlign'><a href='viewNotACitizen?districtId="+districtId+"&upazilaId="+json[i].upazilaid+"&unionId="+json[i].unionid+"&sDate="+getDateFormat(startDate)+"&eDate="+getDateFormat(endDate)+"' target='_blank'><b>" + json[i].not_citizen + "</b></a></td></tr>";

                                    tableBody.append(parsedData);

                                    registered_sum += json[i].registered;
                                    eligible_sum += json[i].eligible;
                                    havenid_sum += json[i].havenid;
                                    dont_have_sum += json[i].dont_have;
                                    missing_sum += json[i].missing;
                                    not_found_sum += json[i].not_found;
                                    other_place_sum += json[i].other_place;
                                    not_citizen_sum += json[i].not_citizen;
                                }

                                if (registered_sum > 0 || eligible_sum > 0 || havenid_sum > 0
                                        || dont_have_sum > 0 || missing_sum > 0 || not_found_sum || not_found_sum > 0
                                        || other_place_sum > 0 || not_citizen_sum > 0
                                        ) {
                                    var footerData = "<tr> <td style='text-align:left' colspan='2'>Total</td>"
                                            + "<td id='rightAlign'>" + registered_sum + "</td>"
                                            + "<td id='rightAlign'>" + eligible_sum + "</td>"
                                            + "<td id='rightAlign'>" + havenid_sum + "</td>"
                                            + "<td id='rightAlign'>" + ((havenid_sum / registered_sum) * 100).toFixed(2) + "</td>"
                                            + "<td id='rightAlign'>" + dont_have_sum + "</td>"
                                            + "<td id='rightAlign'>" + missing_sum + "</td>"
                                            + "<td id='rightAlign'>" + not_found_sum + "</td>"
                                            + "<td id='rightAlign'>" + other_place_sum + "</td>"
                                            + "<td id='rightAlign'>" + not_citizen_sum + "</td></tr>";

                                    $('#tableFooter').append(footerData);
                                }
                                //End <-Table->=====================================


                                //<-Chart-> NID Possession Status===================
                                $("#chart").empty();
                                d3.select("svg").remove();

                                var data = [];

                                for (var i = 0; i < json.length; i++) {
                                    var obj = {
                                        unionnameeng: json[i].distname,
                                        eligibleNid: json[i].eligible,
                                        haveNid: json[i].havenid,
                                        noNid: json[i].dont_have
                                    };

                                    data.push(obj);
                                }

                                var margin = {top: 30, right: 10, bottom: 80, left: 40}
                                , width = parseInt(d3.select('#chart').style('width'), 10)
                                        , width = width - margin.left - margin.right
                                        , barHeight = 20
                                        , percent = d3.format('%');

                                var x0 = d3.scale.ordinal()
                                        .rangeRoundBands([10, width], .1);

                                var x1 = d3.scale.ordinal();


                                var y = d3.scale.linear()
                                        .range([height, 0]);

                                var color = d3.scale.category10();

                                var xAxis = d3.svg.axis()
                                        .scale(x0)
                                        .orient("bottom");

                                var yAxis = d3.svg.axis()
                                        .scale(y)
                                        .orient("left")
                                        .tickFormat(d3.format(".2s"));

                                var svg = d3.select("#chart").append("svg")
                                        .attr("width", width + margin.left + margin.right)
                                        .attr("height", height + margin.top + margin.bottom)
                                        .append("g")
                                        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

                                var groupNames = d3.keys(data[0]).filter(function (key) {
                                    return key !== "unionnameeng";
                                });

                                data.forEach(function (d) {
                                    d.groups = groupNames.map(function (name) {
                                        return {name: name, value: +d[name]};
                                    });
                                });


                                x0.domain(data.map(function (d) {
                                    return d.unionnameeng;
                                }));

                                x1.domain(groupNames).rangeRoundBands([0, x0.rangeBand()]);

                                y.domain([0, d3.max(data, function (d) {
                                        return d3.max(d.groups, function (d) {
                                            return d.value;
                                        });
                                    })]);


                                var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .style("z-index", "30001")
                                        .html(function (d) {
                                            var toolTipName = "";
                                            if (d.name === "eligibleNid") {
                                                toolTipName = "Eligible";
                                            } else if (d.name === "haveNid") {
                                                toolTipName = "Having";
                                            } else {
                                                toolTipName = "Don't Have";
                                            }
                                            return "<div style='background-color:black'><div style='color:white'>" + toolTipName + ":" + d.value + "</div></div>";
                                        });

                                svg.call(tip);

                                svg.append("g")
                                        .attr("class", "x axis")
                                        .attr("transform", "translate(0," + height + ")")
                                        .call(xAxis)
                                        .selectAll("text")
                                        .style("text-anchor", "end")
                                        .style("font-size", "9px")
                                        .style("font-weight", "600")
                                        .attr("dx", "-.8em")
                                        .attr("dy", ".15em")
                                        .attr("transform", "rotate(-65)");


                                svg.append("g")
                                        .attr("class", "y axis")
                                        .call(yAxis)
                                        .append("text")
                                        .attr("transform", "rotate(-90)")
                                        .attr("y", 10)
                                        .attr("dy", "0.71em")
                                        .style("text-anchor", "end")
                                        .style("font-size", "12px")
                                        .style("font-weight", "600")
                                        .text("Progress(%)");


                                var state = svg.selectAll(".state")
                                        .data(data)
                                        .enter().append("g")
                                        .attr("class", "g")
                                        .attr("transform", function (d) {
                                            return "translate(" + x0(d.unionnameeng) + ",0)";
                                        });


                                state.selectAll("rect")
                                        .data(function (d) {
                                            return d.groups;
                                        })
                                        .enter().append("rect")
                                        .attr("width", x1.rangeBand())
                                        .attr("x", function (d) {
                                            return x1(d.name);
                                        })
                                        .attr("y", function (d) {
                                            return y(d.value);
                                        })
                                        .attr("height", function (d) {
                                            return height - y(d.value);
                                        })
                                        .style("fill", function (d) {
                                            return color(d.name);
                                        })
                                        .on('mouseover', tip.show)
                                        .on('mouseout', tip.hide);

                                state.selectAll("text")
                                        .data(function (d) {
                                            return d.groups;
                                        })
                                        .enter()
                                        .append("text")
                                        .attr("class", "barstext")
                                        .attr("x", function (d) {
                                            return x1(d.name);
                                        })
                                        .attr("y", function (d) {
                                            return y(d.value + 2);
                                        })
                                        .style("font-size", "9px")
                                        .style("font-weight", "600")
                                        .text(function (d) {
                                            return d.value;
                                        });

                                var legend = svg.selectAll(".legend")
                                        .data(groupNames.slice().reverse())
                                        .enter().append("g")
                                        .attr("class", "legend")
                                        .attr("transform", function (d, i) {
                                            return "translate(0," + i * 20 + ")";
                                        });

                                legend.append("rect")
                                        .attr("x", width - 18)
                                        .attr("width", 18)
                                        .attr("height", 18)
                                        .style("fill", color);

                                legend.append("text")
                                        .attr("x", width - 24)
                                        .attr("y", 9)
                                        .attr("dy", ".35em")
                                        .style("text-anchor", "end")
                                        .text(function (d) {
                                            var legendText = "";
                                            if (d === "eligibleNid") {
                                                legendText = "Eligible for National ID Card";
                                            } else if (d === "haveNid"){
                                                legendText = "Having National ID Card";
                                            } else if(d ==="noNid"){
                                                legendText = "Don't Have National ID Card";
                                            }
                                            //alert(legendText);
                                            return legendText;
                                        });
                                //End <-Chart->=====================================               

                                btn.button('reset');
                                
                            }//end check it empty json or not
                                
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    }); //End Ajax request
                    
                }); //End Pace loading
                
            }//end validation else
        });
        //NID Report Upazila Wise=================================================
        $('#showUpazilaPRS').click(function () {
            
            //reset all data presenter like Dashboard - chart - Table
            resetAllDataPresenter();
            
            //Get Parameter
            var divisionId = $("select#division2").val();
            var districtId = $("select#district2").val();
            var upazilaId = $("select#upazila2").val();
            var startDate = $("#startDate2").val();
            var endDate = $("#endDate2").val();

            if( divisionId===""){
                toastr["error"]("<h4><b>Please select Division</b></h4>");
                
            }else if( districtId===""){
                toastr["error"]("<h4><b>Please select District</b></h4>");
                
            }else if( upazilaId===""){
                toastr["error"]("<h4><b>Please select Upazila</b></h4>");
                
            }else if( startDate===""){
                toastr["error"]("<h4><b>Please select Start Date</b></h4>");
                
            }else if( endDate===""){
                toastr["error"]("<h4><b>Please select End Date</b></h4>");
            }else {
                var btn = $(this).button('loading');
                Pace.track(function(){
                    $.ajax({
                        url: "NidPossessionStatus?action=showUpazilaWise",
                        data: {
                            districtId: districtId,
                            upazilaId: upazilaId,
                            startDate: startDate,
                            endDate: endDate
                        },
                        type: 'POST',
                        success: function (result) {
                            var json = JSON.parse(result);
                            if (json.length === 0) {
                                btn.button('reset');
                                toastr["error"]("<h4><b>No data found</b></h4>");
                            }else{
                                //<-Table-> NID Possession Status===================
                                
                                //For Data table header

                                var header="<tr>"
                                    +"<th>#</th>"
                                    +"<th>Upazila</th>"
                                    +"<th>Registered</th>"
                                    +"<th>Eligible(18+)</th>"
                                    +"<th>Have NID</th>"
                                    +"<th>(%)</th>"
                                    +"<th>Don't Have</th>"
                                    +"<th>Missing</th>"
                                    +"<th>Not Found</th>"
                                    +"<th>Other Place</th>"
                                    +"<th>Not Citizen</th>"
                                +"</tr>";
                                tableHeader.append(header);

                                var registered_sum = 0, eligible_sum = 0, havenid_sum = 0,
                                        dont_have_sum = 0, missing_sum = 0, not_found_sum = 0, other_place_sum = 0, not_citizen_sum = 0;

                                for (var i = 0; i < json.length; i++) {

                                    var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                            + "<td id='leftAlign'>" + json[i].upname + "</td>"
                                            + "<td id='rightAlign'>" + json[i].registered + "</td>"
                                            + "<td id='rightAlign'>" + json[i].eligible + "</td>"
                                            + "<td id='rightAlign'>" + json[i].havenid + "</td>"
                                            + "<td id='rightAlign'>" + json[i].percent + "</td>"
                                            + "<td id='rightAlign'>" + json[i].dont_have + "</td>"
                                            + "<td id='rightAlign'><a href='viewNidMissing?districtId="+districtId+"&upazilaId="+json[i].upazilaid+"&unionId="+json[i].unionid+"&sDate="+getDateFormat(startDate)+"&eDate="+getDateFormat(endDate)+"' target='_blank'><b>" + json[i].missing + "</b></a></td>" //class='btn btn-primary btn-xs'
                                            + "<td id='rightAlign'>" + json[i].not_found + "</td>"
                                            + "<td id='rightAlign'>" + json[i].other_place + "</td>"
                                            + "<td id='rightAlign'><a href='viewNotACitizen?districtId="+districtId+"&upazilaId="+json[i].upazilaid+"&unionId="+json[i].unionid+"&sDate="+getDateFormat(startDate)+"&eDate="+getDateFormat(endDate)+"' target='_blank'><b>" + json[i].not_citizen + "</b></a></td></tr>";

                                    tableBody.append(parsedData);

                                    registered_sum += json[i].registered;
                                    eligible_sum += json[i].eligible;
                                    havenid_sum += json[i].havenid;
                                    dont_have_sum += json[i].dont_have;
                                    missing_sum += json[i].missing;
                                    not_found_sum += json[i].not_found;
                                    other_place_sum += json[i].other_place;
                                    not_citizen_sum += json[i].not_citizen;
                                }

                                if (registered_sum > 0 || eligible_sum > 0 || havenid_sum > 0
                                        || dont_have_sum > 0 || missing_sum > 0 || not_found_sum || not_found_sum > 0
                                        || other_place_sum > 0 || not_citizen_sum > 0
                                        ) {
                                    var footerData = "<tr> <td style='text-align:left' colspan='2'>Total</td>"
                                            + "<td id='rightAlign'>" + registered_sum + "</td>"
                                            + "<td id='rightAlign'>" + eligible_sum + "</td>"
                                            + "<td id='rightAlign'>" + havenid_sum + "</td>"
                                            + "<td id='rightAlign'>" + ((havenid_sum / registered_sum) * 100).toFixed(2) + "</td>"
                                            + "<td id='rightAlign'>" + dont_have_sum + "</td>"
                                            + "<td id='rightAlign'>" + missing_sum + "</td>"
                                            + "<td id='rightAlign'>" + not_found_sum + "</td>"
                                            + "<td id='rightAlign'>" + other_place_sum + "</td>"
                                            + "<td id='rightAlign'>" + not_citizen_sum + "</td></tr>";

                                    $('#tableFooter').append(footerData);
                                }
                                //End <-Table->=====================================


                                //<-Chart-> NID Possession Status===================
                                $("#chart").empty();
                                d3.select("svg").remove();

                                var data = [];

                                for (var i = 0; i < json.length; i++) {
                                    var obj = {
                                        unionnameeng: json[i].upname,
                                        eligibleNid: json[i].eligible,
                                        haveNid: json[i].havenid,
                                        noNid: json[i].dont_have
                                    };

                                    data.push(obj);
                                }

                                var margin = {top: 30, right: 10, bottom: 80, left: 40}
                                , width = parseInt(d3.select('#chart').style('width'), 10)
                                        , width = width - margin.left - margin.right
                                        , barHeight = 20
                                        , percent = d3.format('%');

                                var x0 = d3.scale.ordinal()
                                        .rangeRoundBands([10, width], .1);

                                var x1 = d3.scale.ordinal();


                                var y = d3.scale.linear()
                                        .range([height, 0]);

                                var color = d3.scale.category10();

                                var xAxis = d3.svg.axis()
                                        .scale(x0)
                                        .orient("bottom");

                                var yAxis = d3.svg.axis()
                                        .scale(y)
                                        .orient("left")
                                        .tickFormat(d3.format(".2s"));

                                var svg = d3.select("#chart").append("svg")
                                        .attr("width", width + margin.left + margin.right)
                                        .attr("height", height + margin.top + margin.bottom)
                                        .append("g")
                                        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

                                var groupNames = d3.keys(data[0]).filter(function (key) {
                                    return key !== "unionnameeng";
                                });

                                data.forEach(function (d) {
                                    d.groups = groupNames.map(function (name) {
                                        return {name: name, value: +d[name]};
                                    });
                                });


                                x0.domain(data.map(function (d) {
                                    return d.unionnameeng;
                                }));

                                x1.domain(groupNames).rangeRoundBands([0, x0.rangeBand()]);

                                y.domain([0, d3.max(data, function (d) {
                                        return d3.max(d.groups, function (d) {
                                            return d.value;
                                        });
                                    })]);


                                var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .style("z-index", "30001")
                                        .html(function (d) {
                                            var toolTipName = "";
                                            if (d.name === "eligibleNid") {
                                                toolTipName = "Eligible";
                                            } else if (d.name === "haveNid") {
                                                toolTipName = "Having";
                                            } else {
                                                toolTipName = "Don't Have";
                                            }
                                            return "<div style='background-color:black'><div style='color:white'>" + toolTipName + ":" + d.value + "</div></div>";
                                        });

                                svg.call(tip);

                                svg.append("g")
                                        .attr("class", "x axis")
                                        .attr("transform", "translate(0," + height + ")")
                                        .call(xAxis)
                                        .selectAll("text")
                                        .style("text-anchor", "end")
                                        .style("font-size", "9px")
                                        .style("font-weight", "600")
                                        .attr("dx", "-.8em")
                                        .attr("dy", ".15em")
                                        .attr("transform", "rotate(-65)");


                                svg.append("g")
                                        .attr("class", "y axis")
                                        .call(yAxis)
                                        .append("text")
                                        .attr("transform", "rotate(-90)")
                                        .attr("y", 10)
                                        .attr("dy", "0.71em")
                                        .style("text-anchor", "end")
                                        .style("font-size", "12px")
                                        .style("font-weight", "600")
                                        .text("Progress(%)");


                                var state = svg.selectAll(".state")
                                        .data(data)
                                        .enter().append("g")
                                        .attr("class", "g")
                                        .attr("transform", function (d) {
                                            return "translate(" + x0(d.unionnameeng) + ",0)";
                                        });


                                state.selectAll("rect")
                                        .data(function (d) {
                                            return d.groups;
                                        })
                                        .enter().append("rect")
                                        .attr("width", x1.rangeBand())
                                        .attr("x", function (d) {
                                            return x1(d.name);
                                        })
                                        .attr("y", function (d) {
                                            return y(d.value);
                                        })
                                        .attr("height", function (d) {
                                            return height - y(d.value);
                                        })
                                        .style("fill", function (d) {
                                            return color(d.name);
                                        })
                                        .on('mouseover', tip.show)
                                        .on('mouseout', tip.hide);

                                state.selectAll("text")
                                        .data(function (d) {
                                            return d.groups;
                                        })
                                        .enter()
                                        .append("text")
                                        .attr("class", "barstext")
                                        .attr("x", function (d) {
                                            return x1(d.name);
                                        })
                                        .attr("y", function (d) {
                                            return y(d.value + 2);
                                        })
                                        .style("font-size", "9px")
                                        .style("font-weight", "600")
                                        .text(function (d) {
                                            return d.value;
                                        });

                                var legend = svg.selectAll(".legend")
                                        .data(groupNames.slice().reverse())
                                        .enter().append("g")
                                        .attr("class", "legend")
                                        .attr("transform", function (d, i) {
                                            return "translate(0," + i * 20 + ")";
                                        });

                                legend.append("rect")
                                        .attr("x", width - 18)
                                        .attr("width", 18)
                                        .attr("height", 18)
                                        .style("fill", color);

                                legend.append("text")
                                        .attr("x", width - 24)
                                        .attr("y", 9)
                                        .attr("dy", ".35em")
                                        .style("text-anchor", "end")
                                        .text(function (d) {
                                            var legendText = "";
                                            if (d === "eligibleNid") {
                                                legendText = "Eligible for National ID Card";
                                            } else if (d === "haveNid"){
                                                legendText = "Having National ID Card";
                                            } else if(d ==="noNid"){
                                                legendText = "Don't Have National ID Card";
                                            }
                                            //alert(legendText);
                                            return legendText;
                                        });
                                //End <-Chart->=====================================               

                                btn.button('reset');
                                
                            }//end check it empty json or not
                                
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    }); //End Ajax request
                    
                }); //End Pace loading
                
            }//end else
        }); //end show upazila wise

        
        
        //NID Report Union Wise=================================================
        $('#showUnionPRS').click(function () {
            
            //reset all data presenter like Dashboard - chart - Table
            resetAllDataPresenter();
            
            //Get Parameter
            var divisionId = $("select#division3").val();
            var districtId = $("select#district3").val();
            var upazilaId = $("select#upazila3").val();
            var unionId=$("select#union3").val();
            var startDate = $("#startDate3").val();
            var endDate = $("#endDate3").val();

            if( divisionId===""){
                toastr["error"]("<h4><b>Please select Division</b></h4>");
                
            }else if( districtId===""){
                toastr["error"]("<h4><b>Please select District</b></h4>");
                
            }else if( upazilaId===""){
                toastr["error"]("<h4><b>Please select Upazila</b></h4>");
                
            }else if( unionId===""){
                toastr["error"]("<h4><b>Please select Union</b></h4>");
                
            }else if( startDate===""){
                toastr["error"]("<h4><b>Please select Start Date</b></h4>");
                
            }else if( endDate===""){
                toastr["error"]("<h4><b>Please select End Date</b></h4>");
            }else {
                var btn = $(this).button('loading');
                Pace.track(function(){
                    $.ajax({
                        url: "NidPossessionStatus?action=showUnionWise",
                        data: {
                            districtId: districtId,
                            upazilaId: upazilaId,
                            unionId: unionId,
                            startDate: startDate,
                            endDate: endDate
                        },
                        type: 'POST',
                        success: function (result) {
                            var json = JSON.parse(result);
                            if (json.length === 0) {
                                btn.button('reset');
                                toastr["error"]("<h4><b>No data found</b></h4>");
                            }
                                //<-Table-> NID Possession Status===================
                                
                                //For Data table header
                                
                                var header="<tr>"
                                    +"<th>#</th>"
                                    +"<th>Union</th>"
                                    +"<th>Registered</th>"
                                    +"<th>Eligible(18+)</th>"
                                    +"<th>Have NID</th>"
                                    +"<th>(%)</th>"
                                    +"<th>Don't Have</th>"
                                    +"<th>Missing</th>"
                                    +"<th>Not Found</th>"
                                    +"<th>Other Place</th>"
                                    +"<th>Not Citizen</th>"
                                +"</tr>";
                                tableHeader.append(header);

                            var registered_sum = 0, eligible_sum = 0, havenid_sum = 0,
                                    dont_have_sum = 0, missing_sum = 0, not_found_sum = 0, other_place_sum = 0, not_citizen_sum = 0;

                            for (var i = 0; i < json.length; i++) {

                                var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                        + "<td id='leftAlign'>" + json[i].uname + "</td>"
                                        + "<td id='rightAlign'>" + json[i].registered + "</td>"
                                        + "<td id='rightAlign'>" + json[i].eligible + "</td>"
                                        + "<td id='rightAlign'>" + json[i].havenid + "</td>"
                                        + "<td id='rightAlign'>" + json[i].percent + "</td>"
                                        + "<td id='rightAlign'>" + json[i].dont_have + "</td>"
                                        + "<td id='rightAlign'><a href='viewNidMissing?districtId="+districtId+"&upazilaId="+json[i].upazilaid+"&unionId="+json[i].unionid+"&sDate="+getDateFormat(startDate)+"&eDate="+getDateFormat(endDate)+"' target='_blank'><b>" + json[i].missing + "</b></a></td>" //class='btn btn-primary btn-xs'
                                        + "<td id='rightAlign'>" + json[i].not_found + "</td>"
                                        + "<td id='rightAlign'>" + json[i].other_place + "</td>"
                                        + "<td id='rightAlign'><a href='viewNotACitizen?districtId="+districtId+"&upazilaId="+json[i].upazilaid+"&unionId="+json[i].unionid+"&sDate="+getDateFormat(startDate)+"&eDate="+getDateFormat(endDate)+"' target='_blank'><b>" + json[i].not_citizen + "</b></a></td></tr>";

                                tableBody.append(parsedData);

                                registered_sum += json[i].registered;
                                eligible_sum += json[i].eligible;
                                havenid_sum += json[i].havenid;
                                dont_have_sum += json[i].dont_have;
                                missing_sum += json[i].missing;
                                not_found_sum += json[i].not_found;
                                other_place_sum += json[i].other_place;
                                not_citizen_sum += json[i].not_citizen;
                            }

                            if (registered_sum > 0 || eligible_sum > 0 || havenid_sum > 0
                                    || dont_have_sum > 0 || missing_sum > 0 || not_found_sum || not_found_sum > 0
                                    || other_place_sum > 0 || not_citizen_sum > 0
                                    ) {
                                var footerData = "<tr> <td style='text-align:left' colspan='2'>Total</td>"
                                        + "<td id='rightAlign'>" + registered_sum + "</td>"
                                        + "<td id='rightAlign'>" + eligible_sum + "</td>"
                                        + "<td id='rightAlign'>" + havenid_sum + "</td>"
                                        + "<td id='rightAlign'>" + ((havenid_sum / registered_sum) * 100).toFixed(2) + "</td>"
                                        + "<td id='rightAlign'>" + dont_have_sum + "</td>"
                                        + "<td id='rightAlign'>" + missing_sum + "</td>"
                                        + "<td id='rightAlign'>" + not_found_sum + "</td>"
                                        + "<td id='rightAlign'>" + other_place_sum + "</td>"
                                        + "<td id='rightAlign'>" + not_citizen_sum + "</td></tr>";

                                $('#tableFooter').append(footerData);
                            }
                            //End <-Table->=====================================
                            
                            
                            //<-Chart-> NID Possession Status===================
                            $("#chart").empty();
                            d3.select("svg").remove();

                            var data = [];

                            for (var i = 0; i < json.length; i++) {
                                var obj = {
                                    unionnameeng: json[i].uname,
                                    eligibleNid: json[i].eligible,
                                    haveNid: json[i].havenid,
                                    noNid: json[i].dont_have
                                };

                                data.push(obj);
                            }

                            var margin = {top: 30, right: 10, bottom: 80, left: 40}
                            , width = parseInt(d3.select('#chart').style('width'), 10)
                                    , width = width - margin.left - margin.right
                                    , barHeight = 20
                                    , percent = d3.format('%');

                            var x0 = d3.scale.ordinal()
                                    .rangeRoundBands([10, width], .1);

                            var x1 = d3.scale.ordinal();


                            var y = d3.scale.linear()
                                    .range([height, 0]);

                            var color = d3.scale.category10();

                            var xAxis = d3.svg.axis()
                                    .scale(x0)
                                    .orient("bottom");

                            var yAxis = d3.svg.axis()
                                    .scale(y)
                                    .orient("left")
                                    .tickFormat(d3.format(".2s"));

                            var svg = d3.select("#chart").append("svg")
                                    .attr("width", width + margin.left + margin.right)
                                    .attr("height", height + margin.top + margin.bottom)
                                    .append("g")
                                    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

                            var groupNames = d3.keys(data[0]).filter(function (key) {
                                return key !== "unionnameeng";
                            });

                            data.forEach(function (d) {
                                d.groups = groupNames.map(function (name) {
                                    return {name: name, value: +d[name]};
                                });
                            });


                            x0.domain(data.map(function (d) {
                                return d.unionnameeng;
                            }));

                            x1.domain(groupNames).rangeRoundBands([0, x0.rangeBand()]);

                            y.domain([0, d3.max(data, function (d) {
                                    return d3.max(d.groups, function (d) {
                                        return d.value;
                                    });
                                })]);


                            var tip = d3.tip()
                                    .attr('class', 'd3-tip')
                                    .offset([-10, 0])
                                    .style("z-index", "30001")
                                    .html(function (d) {
                                        var toolTipName = "";
                                        if (d.name === "eligibleNid") {
                                            toolTipName = "Eligible";
                                        } else if (d.name === "haveNid") {
                                            toolTipName = "Having";
                                        } else {
                                            toolTipName = "Don't Have";
                                        }
                                        return "<div style='background-color:black'><div style='color:white'>" + toolTipName + ":" + d.value + "</div></div>";
                                    });

                            svg.call(tip);

                            svg.append("g")
                                    .attr("class", "x axis")
                                    .attr("transform", "translate(0," + height + ")")
                                    .call(xAxis)
                                    .selectAll("text")
                                    .style("text-anchor", "end")
                                    .style("font-size", "9px")
                                    .style("font-weight", "600")
                                    .attr("dx", "-.8em")
                                    .attr("dy", ".15em")
                                    .attr("transform", "rotate(-65)");


                            svg.append("g")
                                    .attr("class", "y axis")
                                    .call(yAxis)
                                    .append("text")
                                    .attr("transform", "rotate(-90)")
                                    .attr("y", 10)
                                    .attr("dy", "0.71em")
                                    .style("text-anchor", "end")
                                    .style("font-size", "12px")
                                    .style("font-weight", "600")
                                    .text("Progress(%)");


                            var state = svg.selectAll(".state")
                                    .data(data)
                                    .enter().append("g")
                                    .attr("class", "g")
                                    .attr("transform", function (d) {
                                        return "translate(" + x0(d.unionnameeng) + ",0)";
                                    });
                            
                            
                            state.selectAll("rect")
                                    .data(function (d) {
                                        return d.groups;
                                    })
                                    .enter().append("rect")
                                    .attr("width", x1.rangeBand())
                                    .attr("x", function (d) {
                                        return x1(d.name);
                                    })
                                    .attr("y", function (d) {
                                        return y(d.value);
                                    })
                                    .attr("height", function (d) {
                                        return height - y(d.value);
                                    })
                                    .style("fill", function (d) {
                                        return color(d.name);
                                    })
                                    .on('mouseover', tip.show)
                                    .on('mouseout', tip.hide);

                            state.selectAll("text")
                                    .data(function (d) {
                                        return d.groups;
                                    })
                                    .enter()
                                    .append("text")
                                    .attr("class", "barstext")
                                    .attr("x", function (d) {
                                        return x1(d.name);
                                    })
                                    .attr("y", function (d) {
                                        return y(d.value + 2);
                                    })
                                    .style("font-size", "9px")
                                    .style("font-weight", "600")
                                    .text(function (d) {
                                        return d.value;
                                    });

                            var legend = svg.selectAll(".legend")
                                    .data(groupNames.slice().reverse())
                                    .enter().append("g")
                                    .attr("class", "legend")
                                    .attr("transform", function (d, i) {
                                        return "translate(0," + i * 20 + ")";
                                    });

                            legend.append("rect")
                                    .attr("x", width - 18)
                                    .attr("width", 18)
                                    .attr("height", 18)
                                    .style("fill", color);

                            legend.append("text")
                                    .attr("x", width - 24)
                                    .attr("y", 9)
                                    .attr("dy", ".35em")
                                    .style("text-anchor", "end")
                                    .text(function (d) {
                                        var legendText = "";
                                        if (d === "eligibleNid") {
                                            legendText = "Eligible for National ID Card";
                                        } else if (d === "haveNid"){
                                            legendText = "Having National ID Card";
                                        } else if(d ==="noNid"){
                                            legendText = "Don't Have National ID Card";
                                        }
                                        //alert(legendText);
                                        return legendText;
                                    });
                            //End <-Chart->=====================================               

                            btn.button('reset');
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            btn.button('reset');
                            toastr["error"]("<h4><b>Request can't be processed</b></h4>");
                        }
                    }); //End Ajax request
                    
                }); //End Pace loading
                
            } //End Else

        }); //End Show Data button click
        
        
        function resetAllDataPresenter(){
            tableHeader.empty();
            tableBody.empty();
            tableFooter.empty();
            dashboard.empty();
            chart.empty();
        }
 
    });

    //Get date as YYYY-MM_DD
     Date.prototype.yyyymmdd = function() {
       var yyyy = this.getFullYear();
       var mm = this.getMonth() < 9 ? "0" + (this.getMonth() + 1) : (this.getMonth() + 1); // getMonth() is zero-based
       var dd  = this.getDate() < 10 ? "0" + this.getDate() : this.getDate();
       return "".concat(yyyy).concat("-"+mm+"-").concat(dd);
      };
      
      function  getDateFormat(date){
          
        var getDate=date.split('-');
         
        var day = getDate[0];
        var month = getDate[1];
        var year = getDate[2];
      
        return year+"-"+month+"-"+day;
      }
</script>

<!-- Content Header (Page header) -->
<section class="content-header">
<!--  <h1>Possession of National Identity Card<small>এই টুল ব্যবহার করে এন আইডি গ্রহণ করা হয়েছে কিনা তা পর্যালচনা করুন  </small></h1>-->
<h1>Possession of National Identity (NID) Card</h1>
</section>

<!-- Main content -->
<section class="content">
    <!------------------------------Load Area----------------------------------->
    <%@include file="/WEB-INF/jspf/prsArea.jspf" %>
                
 
                
    <!--Birth Data Chart-->
    <div class="box box-primary" id="graphView">
            <div class="box-header with-border">
                <h3 class="box-title">Graphical Presentation</h3>
                <div class="box-tools pull-right" style="margin-top: 0px;">
                    <button type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print</button>
                    <button type="button" class="btn btn-box-tool"><i class="fa fa-file-pdf-o" aria-hidden="true"></i>&nbsp;PDF</button>
                    <button id="openGraph" type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button id="closeGraph" type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                </div>
            </div>
        <div class="box-body">
            <div class="table-responsive" >
                  <div style="width: 100%">
                    <canvas id="canvas"></canvas>
                  </div>
                <div id="chart"></div>
                <br/>
            </div>
        </div>
    </div>
    <!--Demo-->
    <span id="dashboard"></span>
<!--    <span id="graphView"></span>-->


    <!--NID Data Table-->
    <div class="box box-primary">
            <div class="box-header with-border">
                <h3 class="box-title">Tabular Presentation</h3>
                <div class="box-tools pull-right" style="margin-top: 0px;">
                    <button type="button" class="btn btn-box-tool"><i class="fa fa-print" aria-hidden="true"></i>&nbsp;Print</button>
                    <button type="button" class="btn btn-box-tool"><i class="fa fa-file-pdf-o" aria-hidden="true"></i>&nbsp;PDF</button>
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                </div>
            </div>
        <div class="box-body">
                <!--Data Table-->               
                <div class="col-ld-12" id="">
                    <div class="table-responsive" >
                        <table class="table table-bordered table-striped" id="data-table">
                            <thead id="tableHeader" class="data-table">

                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                            <tfoot id="tableFooter" class="data-table">
                            </tfoot>
                        </table>
                        
                    </div>
                </div>
        </div>
    </div> 
</section>
<%@include file="/WEB-INF/jspf/templateFooter.jspf" %>

<script src="resources/js/prsDropDowns.js" type="text/javascript"></script>