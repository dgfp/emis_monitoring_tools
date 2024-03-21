$(function () {
    $.RS = {
        status: {
            submitted: '<div class="callout callout-success" style="margin-bottom: 0!important;"><h3 class="center bold">রিপোর্ট জমা দেয়া হয়েছে</h3></div>',
            notSubmitted: '<div class="callout callout-danger" style="margin-bottom: 0!important;"><h3 class="center bold">রিপোর্ট জমা দেয়া হয়নি</h3></div>',
            pending: '<div class="callout callout-warning" style="margin-bottom: 0!important;"><h3 class="center bold">রিপোর্টটি অনুমোদন  প্রক্রিয়াধীন রয়েছে</h3></div>',
            revised: '<div class="callout callout-warning" style="margin-bottom: 0!important;"><h3 class="center bold">রিপোর্টটি সংশোধন প্রক্রিয়ায় রয়েছে</h3></div>',
            rePending: '<div class="callout callout-warning" style="margin-bottom: 0!important;"><h3 class="center bold">রিপোর্টটি পুনঃ অনুমোদন  প্রক্রিয়াধীন রয়েছে</h3></div>'
        },
        submissionStatus: function (type) {
            var html = this.status[type];
            $('#viewStatus').html(html);
        },
        submissionModal: function (fn) {
            var $o = $("#modal-report-submit");
            return fn ? $o.modal(fn) : $o;
        },
        conversationModal: function (fn) {
            var $o = $("#modal-report-response");
            return fn ? $o.modal(fn) : $o;
        },
        submissionButton: function (fn, key, val) { //show or hide;
            var $o = $("#submitDataButton");
            return fn ? $o[fn](key, val) : $o;
        },
        providerAction: function (fn, key, val) {
            return "";
        },
        providerInit: function () {
            var modal = this.conversationModal();
            //modal.find(".overlay, select").hide();
            modal.find('.overlay').next().find('select').hide();
        },
        init: function () {
            if (/mis-form-1/.test(location.href) || /MIS_2/.test(location.href) || /mis1-9/.test(location.href) || /mis2-9/.test(location.href) || /MIS_4/.test(location.href)) {
                $('.input-group-return', '#form-report-response').addClass('hidden');
                var modal = this.conversationModal();
                $('.input-group-approve', '#form-report-response').find('button').html('<b><i class="fa fa-paper-plane" aria-hidden="true"></i> Submit</b>');
            }
        },
        reviewJson: null,
        submissionId: 0
    }
    $.RS.init();

    $.loadReviewDataByProvider = function () {
        console.log("$.loadReviewDataByProvider-JSON", json);
        
        var id = json.submissionId;
        if (id == 0 || id == undefined)
            id = $.RS.submissionId

//        $.ajax({
//            url: "ReportSubmissionController?action=ReviewDataByReportSubmissionId",
//            data: {
//                submissionId: id, //json.submissionId == 0 ? $.RS.submissionId : json.submissionId, //Access global json
//                modrep: json.modrep,
//                divisionId: $("select#division").val(),
//                districtId: $("select#district").val(),
//                upazilaId: $("select#upazila").val(),
//                unionId: $("select#union").val() == undefined ? '1' : $("select#union").val(),
//                fwaUnit: $("select#unit").val() == undefined ? '1' : $("select#unit").val(),
//                provCode: $("select#provCode").val() == undefined ? '1' : $("select#provCode").val(),
//                month: $("select#month").val(),
//                year: $("#year").val(),
//            },
//            type: 'POST'
//        }).done(renderProviderReview);
$.ajax({
            url: "ReportSubmissionController?action=ReviewDataByReportSubmissionId",
            data: {
                submissionId: id, //json.submissionId == 0 ? $.RS.submissionId : json.submissionId, //Access global json
                modrep: json.modrep,
                divisionId: $("select#division").val(),
                districtId: $("select#district").val(),
                upazilaId: $("select#upazila").val(),
                unionId: $("select#union").val() == undefined ? '1' : $("select#union").val(),
                fwaUnit: $("select#unit").val() == undefined ? '1' : $("select#unit").val(),
                provCode: $("select#provCode").val() == undefined ? '1' : $("select#provCode").val(),
                month: $("select#month").val(),
                year: $("#year").val(),
            },
            type: 'POST',
            success: renderProviderReview,
            error: function(jqXHR, textStatus, errorThrown){
                $.toast(jqXHR.status +" "+ jqXHR.statusText + ' Please contact with administrator.', "error")();
            }
        });
    };

    function renderProviderReview(data) {
        console.log("renderProviderReview", data);
        var dd = $.parseJSON(data);
        var d = $.parseJSON(dd.data);
        var lmisData = $.parseJSON(dd.lmisData);
        var currentMonthLmis = $.parseJSON(dd.currentMonthLMIS);
        console.log(lmisData);
        console.log(currentMonthLmis);
        $.RS.reviewJson = d;
        console.log(d);

        //Set modal title
        $('#responseViewTitle').html($('#title').text() + " Submission");

        $.data.currentReview = d;
        var covsersation = "";
        for (var i = 0, submission_from = 0, j = 0; i < d.length; i++) {
            var nameAlign = "pull-left", dateAlign = "pull-right", titleAlign = "", isSuper = 0;
            if (submission_from != d[i].submission_from) {
                ++j;
            }
            if (j & 1) {
                nameAlign = "pull-right", dateAlign = "pull-left", titleAlign = "right", isSuper = 1;
            }
            var notes = d[i].notes == "" || d[i].notes == null ? '&nbsp;' : d[i].notes;
            covsersation += '<div class="direct-chat-msg ' + titleAlign + '">'
                    + '<div class="direct-chat-info clearfix">'
                    + '<span class="direct-chat-name ' + nameAlign + '">' + d[i].provname + '</span>'
                    + '<span class="direct-chat-timestamp ' + dateAlign + '">' + $.app.date(d[i].systementrydate).datetimeHuman + '</span>'
                    + '</div>'
                    + '<span class="direct-chat-img">' + (isSuper ? 'S' : 'P') + '</span>'
                    + '<div class="direct-chat-text"><span class="pill-right">'
                    + (isSuper ? '<a class="btn btn-flat btn-default btn-xs action-view" data-index="' + i + '" ><b>View</b></a></span> ' : '')
                    + notes + '</div>'
                    + '</div>';
            submission_from = d[i].submission_from;
        }

        //Fill lmis distribution Data
        $.each(lmisData, function (k, v) {
            $('input[name="distribution_sukhi"]').val(v.r_pill_sukhi);
            $('input[name="distribution_apon"]').val(v.r_pill_apan);
            $('input[name="distribution_condom"]').val(v.r_condom_nirapod);
            $('input[name="distribution_inject_vayal"]').val(v.r_injectable_vial);
            $('input[name="distribution_inject_syringe"]').val(v.r_injectable_syringe);
            $('input[name="distribution_ecp"]').val(v.r_ecp);

            $('input[name="distribution_misoprostol"]').val(v.r_misoprostol == null ? 0 : v.r_misoprostol);
            $('input[name="distribution_chlorhexidine"]').val(v.r_chlorhexidine_71 == null ? 0 : v.r_chlorhexidine_71);
            $('input[name="distribution_mnp"]').val(v.r_mnp == null ? 0 : v.r_mnp);
            $('input[name="distribution_iron"]').val(v.r_iron_folic_acid == null ? 0 : v.r_iron_folic_acid);
        });
         
        $.each(currentMonthLmis, function (k, v) {
            //Fill lmis previous balance
            $('input[name="openingbalance_sukhi"]').val(v.closingbalance_sukhi).trigger('input');
            $('input[name="openingbalance_apon"]').val(v.closingbalance_apon).trigger('input');
            $('input[name="openingbalance_condom"]').val(v.closingbalance_condom).trigger('input');
            $('input[name="openingbalance_inject_vayal"]').val(v.closingbalance_inject_vayal).trigger('input');
            $('input[name="openingbalance_inject_syringe"]').val(v.closingbalance_inject_syringe).trigger('input');
            $('input[name="openingbalance_ecp"]').val(v.closingbalance_ecp).trigger('input');
            $('input[name="openingbalance_misoprostol"]').val(v.closingbalance_misoprostol).trigger('input');
            $('input[name="openingbalance_chlorhexidine"]').val(v.closingbalance_chlorhexidine).trigger('input');
            $('input[name="openingbalance_mnp"]').val(v.closingbalance_mnp).trigger('input');
            $('input[name="openingbalance_iron"]').val(v.closingbalance_iron).trigger('input');
            //Fill lmis received current month
            $('input[name="receiveqty_sukhi"]').val(v.receiveqty_sukhi).trigger('input');
            $('input[name="receiveqty_apon"]').val(v.receiveqty_apon).trigger('input');
            $('input[name="receiveqty_condom"]').val(v.receiveqty_condom).trigger('input');
            $('input[name="receiveqty_inject_vayal"]').val(v.receiveqty_inject_vayal).trigger('input');
            $('input[name="receiveqty_inject_syringe"]').val(v.receiveqty_inject_syringe).trigger('input');
            $('input[name="receiveqty_ecp"]').val(v.receiveqty_ecp).trigger('input');
            $('input[name="receiveqty_misoprostol"]').val(v.receiveqty_misoprostol).trigger('input');
            $('input[name="receiveqty_chlorhexidine"]').val(v.receiveqty_chlorhexidine).trigger('input');
            $('input[name="receiveqty_mnp"]').val(v.receiveqty_mnp).trigger('input');
            $('input[name="receiveqty_iron"]').val(v.receiveqty_iron).trigger('input');
            //Fill lmis adjustment plus
            $('input[name="adjustment_plus_sukhi"]').val(v.adjustment_plus_sukhi).trigger('input');
            $('input[name="adjustment_plus_apon"]').val(v.adjustment_plus_apon).trigger('input');
            $('input[name="adjustment_plus_condom"]').val(v.adjustment_plus_condom).trigger('input');
            $('input[name="adjustment_plus_inject_vayal"]').val(v.adjustment_plus_inject_vayal).trigger('input');
            $('input[name="adjustment_plus_inject_syringe"]').val(v.adjustment_plus_inject_syringe).trigger('input');
            $('input[name="adjustment_plus_ecp"]').val(v.adjustment_plus_ecp).trigger('input');
            $('input[name="adjustment_plus_misoprostol"]').val(v.adjustment_plus_misoprostol).trigger('input');
            $('input[name="adjustment_plus_chlorhexidine"]').val(v.adjustment_plus_chlorhexidine).trigger('input');
            $('input[name="adjustment_plus_mnp"]').val(v.adjustment_plus_mnp).trigger('input');
            $('input[name="adjustment_plus_iron"]').val(v.adjustment_plus_iron).trigger('input');
             //Fill lmis adjustment minus
            $('input[name="adjustment_minus_sukhi"]').val(v.adjustment_minus_sukhi).trigger('input');
            $('input[name="adjustment_minus_apon"]').val(v.adjustment_minus_apon).trigger('input');
            $('input[name="adjustment_minus_condom"]').val(v.adjustment_minus_condom).trigger('input');
            $('input[name="adjustment_minus_inject_vayal"]').val(v.adjustment_minus_inject_vayal).trigger('input');
            $('input[name="adjustment_minus_inject_syringe"]').val(v.adjustment_minus_inject_syringe).trigger('input');
            $('input[name="adjustment_minus_ecp"]').val(v.adjustment_minus_ecp).trigger('input');
            $('input[name="adjustment_minus_misoprostol"]').val(v.adjustment_minus_misoprostol).trigger('input');
            $('input[name="adjustment_minus_chlorhexidine"]').val(v.adjustment_minus_chlorhexidine).trigger('input');
            $('input[name="adjustment_minus_mnp"]').val(v.adjustment_minus_mnp).trigger('input');
            $('input[name="adjustment_minus_iron"]').val(v.adjustment_minus_iron).trigger('input');
        });

        //Set MIS 1 manual entry entry data
        if ($('#form-report-response').find(".mis1-manual").length > 0) {
            $.each(json.MIS[0], function (k, v) {
                if (k.substring(0, 2) == "r_")
                    k = k.substring(2);
                v == "null" ? v = 0 : v = v;
                v == null ? v = 0 : v = v;
                $('input[name="' + k + '"]').val(v);
            });

            var d = json.MIS[0];
            console.log(d);
            $("#month_no").text($("#month option:selected").text());
            $("#year_no").text($("#year option:selected").text());
            $("#r_unit_name").text(getData(d.r_unit_name));
            $("#r_ward_name").text(e2b(getData(d.r_ward_name)));
            $("#r_un_name").text(getData(d.r_un_name));
            $("#r_upz_name").text(getData(d.r_upz_name));
            $("#r_dist_name").text(getData(d.r_dist_name));

            //---
            if (d.r_unit_capable_elco_tot == undefined || d.r_unit_capable_elco_tot == null)
                d.r_unit_capable_elco_tot = d.unit_capable_elco_tot;

            if (d.r_unit_all_total_tot == undefined || d.r_unit_all_total_tot == null)
                d.r_unit_all_total_tot = d.unit_all_total_tot;


            $(".mis1-margin-bottom #r_unit_capable_elco_tot").text(d.r_unit_capable_elco_tot);
            $(".mis1-margin-bottom #r_unit_all_total_tot").text(d.r_unit_all_total_tot);
            $(".mis1-margin-bottom #r_car").text($.app.percentage(d.r_unit_all_total_tot, d.r_unit_capable_elco_tot, 2));

//            temp1[0].unit_capable_elco_tot
//            temp1[0].unit_all_total_tot
//            r_unit_all_total_tot
//            r_unit_capable_elco_tot

            //Car portion
        }

        //console.log(submission_from, $.data.currentSubmission.submission_from);
        $('.direct-chat-messages').html(covsersation);
        //var method = !(i & 1) ? 'show' : 'hide';
        var method = 'addClass';
        if ($.data.currentReview.length > 0) {
            method = $.data.currentReview[$.data.currentReview.length - 1].status == 0 || $.data.currentReview[$.data.currentReview.length - 1].status == 1 || $.data.currentReview[$.data.currentReview.length - 1].status == 3 ? 'removeClass' : 'addClass';
        }
        
        //var method = $.data.currentReview[$.data.currentReview.length-1].status == 0 || $.data.currentReview[$.data.currentReview.length-1].status==1 || $.data.currentReview[$.data.currentReview.length-1].status == 3 ? 'removeClass' : 'addClass';
        //var method = 'removeClass';
        $('#modal-report-response').modal('show', d).find('.overlay')[method]('hidden');
    }

    function getData(d) {
        if (d == null)
            return '-';
        else
            return " " + d;
    }
});