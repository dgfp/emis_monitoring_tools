/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 * NIBRAS AR RAKIB
 */
var REPORTING_STATUS = (function ($, w) {
    'use strict';
    console.log("REPORTING_STATUS");
    var init = function (config) {
//        console.log(config);
        return generateTemplate(config, config.isPreTwoMonth);
    };
    var generateTemplate = function (config) {
        var boxes = numberOfBox(config.isPreTwoMonth);
        var boxTypes = getBoxType();
        var tpl = "";
        boxes.forEach(function (v, i) {
            var o = putBoxValue(boxTypes[v], v, config);

            tpl += getTemplate(boxTypes[v]);
        });
        return tpl;
    };
    var putBoxValue = function (o, v, d) {
        var t = v;
        switch (t) {
            case 1:
                o['value'] = d.data[0].total_unit;
                o['type'] = o['type'] + " " + d.text;
                if (o.hasOwnProperty('leftText') && o.hasOwnProperty('rightText')) {
                    o['leftTextValue'] = d.data[0].main;
                    o['rightTextValue'] = d.data[0].additional;
                }
                break;
            case 2:
                o['value'] = d.data[0].waiting;
                o['type'] = o['type'];
                break;
            case 3:
                o['value'] = d.data[0].approved;
                o['type'] = o['type'];
                break;
            case 4:
                o['value'] = d.data[0].not_submitted;
                o['type'] = o['type'];
                if (o.hasOwnProperty('leftText') && o.hasOwnProperty('rightText')) {
                    o['leftTextValue'] = d.data[0].notsubmitted_main;
                    o['rightTextValue'] = d.data[0].notsubmitted_additional;
                }
                break;
            case 5:
                o['value'] = d.data[0].submitted;
                o['type'] = o['type'];
                if (o.hasOwnProperty('leftText') && o.hasOwnProperty('rightText')) {
                    o['leftTextValue'] = d.data[0].submitted_main;
                    o['rightTextValue'] = d.data[0].submitted_additional;
                }
                break;
        }
        return o;
    };
    var getBoxType = function () {
        var boxType = {
            1: {
                type: 'Reporting',
                typeValue:'0',
                bgColor: 'bg-blue',
                bgColorLight: '#007fc9',
                leftText: 'Main',
                rightText: 'Vacant',
                value: 'N/A',
                leftTextValue: '&nbsp',
                rightTextValue: '&nbsp'
            },
            2: {
                type: 'Waiting',
                typeValue:'1',
                bgColor: 'bg-aqua',
                bgColorLight: '',
                leftText: '&nbsp',
                rightText: '&nbsp',
                value: 'N/A',
                leftTextValue: '&nbsp',
                rightTextValue: '&nbsp'
            },
            3: {
                type: 'Approved',
                typeValue:'2',
                bgColor: 'bg-green',
                bgColorLight: '',
                leftText: '&nbsp',
                rightText: '&nbsp',
                value: 'N/A',
                leftTextValue: '&nbsp',
                rightTextValue: '&nbsp'
            },
            4: {
                type: 'Not submitted',
                typeValue:'3',
                bgColor: 'bg-red',
                bgColorLight: '#ef5847',
                leftText: 'Main',
                rightText: 'Additional',
                value: 'N/A',
                leftTextValue: '&nbsp',
                rightTextValue: '&nbsp'
            },
            5: {
                type: 'Submitted',
                typeValue:'4',
                bgColor: 'bg-yellow',
                bgColorLight: '#ffaa2b',
                leftText: 'Main',
                rightText: 'Additional',
                value: 'N/A',
                leftTextValue: '&nbsp',
                rightTextValue: '&nbsp'
            }
        };
        return boxType;
    };
    var numberOfBox = function (p) {
        if (p) {
            return [1, 5, 3, 2];
        } else {
            return [1, 5, 3, 2, 4];
        }
    };
    var getTemplate = function (d) {
        return '<div class="col-v-center col-lg-2 col-xs-12' + '">\
                           <div class="small-box ' + d.bgColor + '">\
                             <div class="inner">\
                               <h3>' + (d.value) + '</h3>\
                               <p class="bold">' + d.type + '</p>\
                             </div>\
                             <div class="inner">\
                               <div class="row">\
                                    <div class="col-md-6 mb-0">\
                                        <div class="breakdown" style="background-color:' + d.bgColorLight + '">\
                                            <h3>' + d.leftTextValue + '</h3>\
                                            <p>' + d.leftText + '</p>\
                                        </div>\
                                    </div>\
                                    <div class="col-md-6 mb-0">\
                                        <div class="breakdown" style="background-color:' + d.bgColorLight + '">\
                                            <h3>' + d.rightTextValue + '</h3>\
                                            <p>' + d.rightText + '</p>\
                                        </div>\
                                    </div>\
                                </div>\
                             </div>\
                                <a href="#" id='+ d.typeValue + ' class="small-box-footer">View details <i class="fa fa-arrow-circle-right"></i></a>\
                           </div>\
                         </div>';
    };
    return {init: init}
}(jQuery, window));