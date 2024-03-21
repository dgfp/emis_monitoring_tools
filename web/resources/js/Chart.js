$(function () {
    $.chart = {
        canvas: {
            bar: '<canvas id="canvas" width="800" height="450"></canvas>',
            pie: '<div style="width: 100%" ><canvas id="canvas"></canvas></div>',
            stackedBar: '<div style="width: 100%" ><canvas id="canvas"></canvas></div>'
        },
        reportType: 0,

        //Variable declaration
        prsChartData: {
            area: [],
            population: [],
            household: []
        },
        hidChartData: {
            area: [],
            hidReceivedPartial: [],
            hidReceived: [],
            hidNotReceived: [],
            hidReceivedPop: []
        },
        BRID: {
            label: 'Possession of National Identity (NID) Card',
            denominator: 'registered',
            area: 'upname',
            data: [
                ['havenbrid', 'Have BRID card', '#126aba'],
                ['never_had', 'Never had', '#e55959'],
                ['lost', 'Lost', '#e5a51b'],
                ['cant_locate', 'Cannot locate', '#7ab2ef'],
                ['kept_in_other_place', 'Kept in other place', '#7f8184'],
                ['not_citizen', 'Not citizen', '#73b7ce']
            ]
        },
        NID: {
            label: 'Possession of National Identity (NID) Card',
            denominator: 'eligible',
            area: 'upname',
            data: [
                ['havenid', 'Have NID card', '#126aba'],
                ['dont_have', 'Never had', '#e55959'],
                ['missing', 'Lost', '#e5a51b'],
                ['not_found', 'Cannot locate', '#7ab2ef'],
                ['other_place', 'Kept in other place', '#7f8184'],
                ['not_citizen', 'Not citizen', '#73b7ce']
            ]
        },
        mobileChartDataBar: {
            area: [],
            haveMobilePhone: [],
            neverHad: []
        },

        //Set data to the variable
        setMobileChartDataBar: function (json) {
            console.log(json);

            console.log(this);

            this.mobileChartDataBar.area = [];
            this.mobileChartDataBar.haveMobilePhone = [];
            this.mobileChartDataBar.neverHad = [];

            var self = this;
            return $.each(json, function (i, o) {

                if (self.reportType == 1)
                    self.mobileChartDataBar.area.push(o.zillanameeng);
                else if (self.reportType == 2)
                    self.mobileChartDataBar.area.push(o.upazilanameeng);
                else if (self.reportType == 3)
                    self.mobileChartDataBar.area.push(o.unionnameeng);
                else if (self.reportType == 3)
                    self.mobileChartDataBar.area.push(o.unionnameeng);

                self.mobileChartDataBar.haveMobilePhone.push(parseFloat((o.have_mobile_no / o.number_of_total_household * 100).toFixed(2)));
                self.mobileChartDataBar.neverHad.push(parseFloat(((o.number_of_total_household - o.have_mobile_no) / o.number_of_total_household * 100).toFixed(2)));

            });
        },
        //Set data to the variable
        setPrsChartData: function (json) {

            this.prsChartData.area = [];
            this.prsChartData.population = [];
            this.prsChartData.household = [];
            var self = this;
            for (var i = 0; i < json.length; i++) {
                if (this.reportType == 1) {
                    this.prsChartData.area.push(json[i].zilanameeng);
                } else if (this.reportType == 2) {
                    this.prsChartData.area.push(json[i].upazilanameeng);
                } else if (this.reportType == 3) {
                    this.prsChartData.area.push(json[i].unionnameeng);
                }
                this.prsChartData.population.push(Math.round(json[i].progress_population));
                this.prsChartData.household.push(Math.round(json[i].progress_hh));
            }
//            return $.each(json, function (i, o) {
//                if (this.reportType == 1)
//                    self.prsChartData.area.push(o.zilanameeng);
//                else if (this.reportType == 2)
//                    self.prsChartData.area.push(o.upazilanameeng);
//                else if (this.reportType == 2)
//                    self.prsChartData.area.push(o.unionnameeng);
//                
//               // self.prsChartData.area.push(o.unionnameeng);
//                self.prsChartData.population.push(Math.round(o.progress_population));
//                self.prsChartData.household.push(Math.round(o.progress_hh));
//            });
        },
        setHIDChartData: function (json) {
            console.log(json)
            this.hidChartData.area = [];
            this.hidChartData.hidReceivedPartial = [];
            this.hidChartData.hidReceived = [];
            this.hidChartData.hidNotReceived = [];
            this.hidChartData.hidReceivedPop = [];

            var self = this;
            for (var i = 0; i < json.length; i++) {
                var row = json[i];
                if (this.reportType == 1) {
                    this.hidChartData.area.push(json[i].zillanameeng);
                } else if (this.reportType == 2) {
                    this.hidChartData.area.push(json[i].upazilanameeng);
                } else if (this.reportType == 3) {
                    this.hidChartData.area.push(json[i].unionnameeng);
                }
                this.hidChartData.hidReceivedPartial.push(Math.round((row.all_received * 100) / row.household));
                this.hidChartData.hidReceived.push(Math.round((row.partial_received * 100) / row.household));
                this.hidChartData.hidNotReceived.push(Math.round(((row.household - row.all_received - row.partial_received) * 100) / row.household));
                this.hidChartData.hidReceivedPop.push(Math.round(100 - ((row.population_received_hid * 100) / row.population)));
            }
        },

        //For NID & BRID both for pie and bar 
        getPIE: function (json, settings) {
            var denominator = settings.denominator, area = settings.area;
            var options = {
                labels: [],
                data: [],
                backgroundColor: [],
                area: []
            };
            $.each(json, function (i, o) {
                console.log("area", o);
                options.area.push(o[area]);
                $.each(settings.data, function (k, v) {
                    var numerator = v[0], label = v[1], color = v[2];
                    if (!i) {
                        options.labels.push(label);
                        options.backgroundColor.push(color);
                    }
                    //
                    options.data[k] = options.data[k] || [];
                    var val = ~~(o[numerator] / o[denominator] * 1e4) / 1e2;
                    options.data[k].push(val);
                });
            });
            return options;
        },

        //Render chart with data
        renderPrsBarChart: function (json, chart, type) { //For PRS Bar chart
            this.reportType = type;
            chart.html("");
            chart.html(this.canvas['bar']);
            this.setPrsChartData(json);
            new Chart(document.getElementById("canvas"), {
                type: 'bar',
                data: {
                    labels: this.prsChartData.area,
                    datasets: [
                        {
                            label: "Household",
                            backgroundColor: "#95CEFF",
                            data: this.prsChartData.household
                        }, {
                            label: "Population",
                            backgroundColor: "#434348",
                            data: this.prsChartData.population
                        }
                    ]
                },
                options: {
                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                    }
                },
            });
        },

        renderBar: function (chartId, chartData, chartLabel, chartColor, scaleLength) {
            
            //Prepare data
            //console.log(chartData);
            var chartContent = [], dataSet = [];
            $.each(chartData[0], function () {
                chartContent.push([]);
            });
            //console.log(chartContent);
            $.each(chartData, function (index, obj) {
                var x = 0;
                $.each(obj, function (i) {
                    chartContent[x].push(obj[i]);
                    x++;
                });
            });
            //console.log(chartContent);
            for (i = 0; i < chartContent.length - 1; i++) {
                dataSet.push({
                    label: chartLabel[i],
                    backgroundColor: chartColor[i],
                    data: chartContent[(i + 1)]
                });
            }
            //console.log(dataSet);
            //Draw chart
            chartId.html("");
            chartId.html(this.canvas['bar']);
            new Chart(document.getElementById("canvas"), {
                type: 'bar',
                data: {
                    labels: chartContent[0],
                    datasets: dataSet
                },
                options: {
                    tooltips: {
                        callbacks: {
                            label: function (t, d) {
                                var xLabel = d.datasets[t.datasetIndex].label;
                                var yLabel = t.yLabel;
                                return xLabel + ': ' + yLabel + ' %';
                            }
                        }
                    },
                    scales: {
                        xAxes: [{
                                ticks: {
                                    autoSkip: false
                                },
                                gridLines: {
                                    color: "rgba(0, 0, 0, 0)",
                                }
                            }],
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true,
                                    suggestedMax: scaleLength
                                },
                                gridLines: {
                                    color: "rgba(0, 0, 0, 0)",
                                },
                                scaleLabel: {
                                    display: true,
                                    labelString: 'Percentage'
                                }
                            }]
                    },
                    legend: {
                        position: 'bottom'
                    }
                },
            });
        },
        
        
        
        renderBirthDeathBar: function (chartId, chartData, chartLabel, chartColor, scaleLength) {
            
            //Prepare data
            //console.log(chartData);
            var chartContent = [], dataSet = [];
            $.each(chartData[0], function () {
                chartContent.push([]);
            });
            //console.log(chartContent);
            $.each(chartData, function (index, obj) {
                var x = 0;
                $.each(obj, function (i) {
                    chartContent[x].push(obj[i]);
                    x++;
                });
            });
            //console.log(chartContent);
            for (i = 0; i < chartContent.length - 1; i++) {
                dataSet.push({
                    label: chartLabel[i],
                    backgroundColor: chartColor[i],
                    data: chartContent[(i + 1)]
                });
            }
            //console.log(dataSet);
            //Draw chart
            chartId.html("");
            chartId.html(this.canvas['bar']);
            new Chart(document.getElementById("canvas"), {
                type: 'bar',
                data: {
                    labels: chartContent[0],
                    datasets: dataSet
                },
                options: {
                    tooltips: {
                        callbacks: {
                            label: function (t, d) {
                                var xLabel = d.datasets[t.datasetIndex].label;
                                var yLabel = t.yLabel;
                                return xLabel + ': ' + yLabel;
                            }
                        }
                    },
                    scales: {
                        xAxes: [{
                                ticks: {
                                    autoSkip: false
                                },
                                gridLines: {
                                    color: "rgba(0, 0, 0, 0)",
                                }
                            }],
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true,
                                    suggestedMax: scaleLength
                                },
                                gridLines: {
                                    color: "rgba(0, 0, 0, 0)",
                                },
                                scaleLabel: {
                                    display: true,
                                    labelString: ''
                                }
                            }]
                    },
                    legend: {
                        position: 'bottom'
                    }
                },
            });
        },
        
        
        
        renderAssetBarChart: function (chartId, chartData, chartLabel, chartColor) {
            $("#"+chartId).html("");
            $("#"+chartId).html('<canvas id="'+chartId+'_canvas" width="800" height="450"></canvas>');
            
            //Prepare data
            //console.log(chartData);
            var chartContent = [], dataSet = [];
            $.each(chartData[0], function () {
                chartContent.push([]);
            });
            //console.log(chartContent);
            $.each(chartData, function (index, obj) {
                var x = 0;
                $.each(obj, function (i) {
                    chartContent[x].push(obj[i]);
                    x++;
                });
            });
            //console.log(chartContent);
            for (i = 0; i < chartContent.length - 1; i++) {
                dataSet.push({
                    label: chartLabel[i],
                    backgroundColor: chartColor[i],
                    data: chartContent[(i + 1)]
                });
            }
         
            new Chart(document.getElementById(chartId+'_canvas'), {
                type: 'bar',
                data: {
                    labels: chartContent[0],
                    datasets: dataSet
                },
                options: {
                    tooltips: {
                        callbacks: {
                            label: function (t, d) {
                                var xLabel = d.datasets[t.datasetIndex].label;
                                var yLabel = t.yLabel;
                                return xLabel + ': ' + yLabel;
                            }
                        }
                    },
                    scales: {
                        xAxes: [{
                                ticks: {
                                    autoSkip: false
                                },
                                gridLines: {
                                    color: "rgba(0, 0, 0, 0)",
                                }
                            }],
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true,
                                    suggestedMax: -0
                                },
                                gridLines: {
                                    color: "rgba(0, 0, 0, 0)",
                                },
                            }]
                    },
                    legend: {
                        position: 'bottom'
                    }
                },
            });
        },

        //Mobile phone coverage
        renderMobileChart: function (json, chart, reportType, chartType) { //For mobile pie chart
            this.reportType = reportType;
            chart.html("");
            chart.html(this.canvas['pie']);
            this.setMobileChartDataBar(json);

            if (chartType == "pie") {
                new Chart(document.getElementById("canvas"), {
                    type: 'pie',
                    data: {
                        labels: ["With mobile no", "Without mobile no"], //this.mobileChartDataBar.area,
                        datasets: [{
                                label: "Mobile phone coverage",
                                backgroundColor: ['#7CB5EC', '#434348'],
                                data: [this.mobileChartDataBar.haveMobilePhone, this.mobileChartDataBar.neverHad]
                            }]
                    }
                });
            } else if (chartType == "bar") {

                var ctx = document.getElementById("canvas").getContext("2d");
                window.myBar = new Chart(ctx, {
                    type: 'bar',
                    exportEnabled: true,
                    data: {
                        labels: this.mobileChartDataBar.area,
                        datasets: [{
                                label: 'With mobile no',
                                backgroundColor: "#7CB5EC",
                                yAxisID: "bar-y-axis",
                                data: this.mobileChartDataBar.haveMobilePhone
                            }, {
                                label: 'Without mobile no',
                                backgroundColor: "#434348",
                                yAxisID: "bar-y-axis",
                                data: this.mobileChartDataBar.neverHad
                            }]
                    },
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
            }
        },

        //For BRID & NID pie chart
        renderPIE: function (json, chart, settings) {

            chart.append(this.canvas['pie']);
            var options = this.getPIE(json, settings);
            console.log('renderPIE', options);


            new Chart(document.getElementById("canvas"), {
                type: 'pie',
                data: {
                    labels: options.labels,
                    datasets: [{
                            label: options.label,
                            backgroundColor: options.backgroundColor,
                            data: options.data
                        }]
                }
            });
        },

        //BRID & NID Bar chart
        renderBAR: function (json, chart, settings) {
            chart.append(this.canvas['stackedBar']);
            var options = this.getPIE(json, settings);
            //  ['havenid', 'Have NID card', '#126aba'],
            options.datasets = $.map(settings.data, function (v, k) {
                return {
                    data: options.data[k],
                    label: v[1],
                    backgroundColor: v[2],
                    yAxisID: "bar-y-axis"
                };
            });

            //Map data by area
            var data = {
                labels: options.area,
                datasets: options.datasets
            };

            console.log('renderBAR', data);

            //Draw chart/Graph label line no-11375
            var ctx = document.getElementById("canvas").getContext("2d");
            window.myBar = new Chart(ctx, {
                type: 'bar',
                exportEnabled: true,
                data: data,
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
        },

        //For HID Chart
        renderHIDBarChart: function (json, chart, type) {
            this.reportType = type;
            chart.html("");
            chart.html(this.canvas['bar']);
            this.setHIDChartData(json);
            new Chart(document.getElementById("canvas"), {
                type: 'bar',
                data: {
                    labels: this.hidChartData.area,
                    datasets: [
                        {
                            label: "HHs received HIDs for all members",
                            backgroundColor: "green",
                            data: this.hidChartData.hidReceivedPartial
                        }, {
                            label: "HH received HIDs but not all members",
                            backgroundColor: "#FC9200",
                            data: this.hidChartData.hidReceived
                        }, {
                            label: "HH not received any HID yet",
                            backgroundColor: "#bc2020",
                            data: this.hidChartData.hidNotReceived
                        }, {
                            label: "Population not received HIDs",
                            backgroundColor: "#ff0000",
                            data: this.hidChartData.hidReceivedPop
                        }
                    ]
                },
                options: {
                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true,
                                    min: 0,
                                    max: 100
                                }
                            }]
                    }
                },
            });

        }

    };

    //Export chart event
    //<a href="#" id="exportImageChart" download="eligible_couple.png" target="_blank" class="btn btn-flat btn-default btn-xs bold"><i class="fa fa-file-image-o" aria-hidden="true"></i>&nbsp;Image</a>
    $("#exportImageChart").click(function () {
        var canvas = $("#canvas").get(0);
        var ctx = canvas.getContext('2d');
        ctx.globalCompositeOperation = 'destination-over';
        ctx.fillStyle = "#fff";
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        var dataURL = canvas.toDataURL('image/png');
        $("#exportImageChart").attr("href", dataURL);
        ctx.globalCompositeOperation = 'source-over';
    });
});

















































//Chart Div setup
function getBarChart() {
    return  '<div style="width: 100%">'
            + '<div id="container" style="min-width: 80%; height:550px;margin: 0 auto"></div>'
            + '</div>';
}
function getPiChart() {
    return  '<div style="width: 100%">'
            + '<div id="container" style="min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto"></div>'
            + '</div>';
}
function getFullStackChart() {
    return  '<div style="width: 100%" >'
            + '<canvas id="canvas"></canvas>'
            + '</div>';
}




//Make chart
function  makeFullStackMobileCoverage(area, HaveMobileNo, DontHaveMobileNo) {
//Arrange data for graph/chart
    var data = [{
            label: 'With mobile no',
            backgroundColor: "#7CB5EC",
            yAxisID: "bar-y-axis",
            data: HaveMobileNo
        }, {
            label: 'Without mobile no',
            backgroundColor: "#434348",
            yAxisID: "bar-y-axis",
            data: DontHaveMobileNo
        }];
    //Map data by area
    var barChartData = {
        labels: area,
        datasets: [{
                label: 'With mobile no',
                backgroundColor: "#7CB5EC",
                yAxisID: "bar-y-axis",
                data: HaveMobileNo
            }, {
                label: 'Without mobile no',
                backgroundColor: "#434348",
                yAxisID: "bar-y-axis",
                data: DontHaveMobileNo
            }]
    };
    //Draw chart/Graph label line no-11375
    var ctx = document.getElementById("canvas").getContext("2d");
    window.myBar = new Chart(ctx, {
        type: 'bar',
        exportEnabled: true,
        data: {
            labels: area,
            datasets: [{
                    label: 'With mobile no',
                    backgroundColor: "#7CB5EC",
                    yAxisID: "bar-y-axis",
                    data: HaveMobileNo
                }, {
                    label: 'Without mobile no',
                    backgroundColor: "#434348",
                    yAxisID: "bar-y-axis",
                    data: DontHaveMobileNo
                }]
        },
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
}



















function makePiMobileCoverage(HaveMobileNo, DontHaveMobileNo) {

    Highcharts.chart('container', {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        exporting: {
            enabled: false
        },
        title: {
            text: ''
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
        },
        colors: ['#7CB5EC', '#434348'],
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: {
                        fontSize: '13px',
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || '#1086A3'
                    }
                }
            }
        },
        series: [{
                name: 'Percentage',
                colorByPoint: true,
                data: [{
                        name: 'With mobile no',
                        y: HaveMobileNo[0]
                    }, {
                        name: 'Without mobile no',
                        y: DontHaveMobileNo[0]
                    }]
            }]
    });


}

//
//
//                    tooltips: {
//                        callbacks: {
//                            label: function (t, d) {
//                                var xLabel = d.datasets[t.datasetIndex].label;
//                                var yLabel = t.yLabel;
//                                // if line chart
//                                if (t.datasetIndex === 0)
//                                    return xLabel + ': ' + yLabel + ' unit(s)';
//                                // if bar chart
//                                else if (t.datasetIndex === 1)
//                                    return xLabel + ': $' + yLabel.toFixed(2);
//                            }
//                        }
//                    },