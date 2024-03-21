$(function () {
    $.data = $.app.date();
    $.app.select.$year('select#year', range($.data.year, 2014, -1)).val($.data.year);
    $.app.select.$month('select#month').val($.data.month);
    $.app.hideNextMonths();
    //$.app.hideNextMonths(null,null,$.app.moveMonth(1)); // to allow next month
})