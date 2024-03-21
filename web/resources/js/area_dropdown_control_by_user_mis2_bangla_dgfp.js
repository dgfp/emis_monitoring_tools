$(document).ready(function () {

    for (i = new Date().getFullYear(); i > 2014; i--)
    {
        $('#year').append($('<option />').val(i).html(e2b(i)));
    }

    //-----------------------------Load Area By AJAX----------------------------
    //Load Division----------------------------------------------------------------
    $.get("DivisionJsonProviderByUserDGFP", function (response) {
        var userLevel = $('#userLevel').val();

        var returnedData = JSON.parse(response);
        var selectTag = $('#division');
        selectTag.find('option').remove();
        //returnedData.length!=1 && 

        if (userLevel === '1') {
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);
        }
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].id;
            var name = returnedData[i].division;
            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
        }

        if (userLevel === '2') {
            //Division level
            loadDistrict();

        } else if (userLevel === '3') {
            //DIstrict level
            loadDistrict();
            loadUpazila();

        } else if (userLevel === '4') {
            //Upazila level
            loadDistrict();
            loadUpazila();
            loadUnion();

        } else if (userLevel === '5') {
            //Union level
            loadDistrict();
            loadUpazila();
            loadUnion();
            loadProvider();


        } else if (userLevel === '6') {
            //May be village level
            loadDistrict();
            loadUpazila();
            loadUnion();

        } else if (userLevel === '7') {
            loadDistrictFromTab();
            console.log("Ready For District");
        }


    });

    //--------------------------------Change Event------------------------------

    //Load district from division------------------------------------------------
    $('#division').change(function (event) {

        var divisionId = $("select#division").val();

        if (divisionId === "" || divisionId === '0') {
            var selectTag = $('#district');
            selectTag.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);

            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUpazila);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnion);

            var selectTagProvider = $('#provCode');
            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);

        }

        $.get('DistrictJsonProviderDGFP', {
            divisionId: divisionId
        }, function (response) {

            var returnedData = JSON.parse(response);

            var selectTag = $('#district');
            selectTag.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট জেলা -').appendTo(selectTag);

            var selectTagUpazila = $('#upazila');
            selectTagUpazila.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUpazila);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnion);

            var selectTagProvider = $('#provCode');
            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].zillaid;
                var name = returnedData[i].zillaname;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });
    });

    //Load Upazila from district------------------------------------------------
    $('#district').change(function (event) {

        var districtId = $("select#district").val();
        var selectTag = $('#upazila');
        var selectTagUnion = $('#union');
        var selectTagUnit = $('#unit');
        var selectTagProvider = $('#provCode');

        if (districtId === "" || districtId === '0') {

            selectTag.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);


            selectTagUnion.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnion);

            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);

        } else {

            $.get('UpazilaJsonProviderDGFP', {
                districtId: districtId
            }, function (response) {

                var returnedData = JSON.parse(response);

                selectTag.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট উপজেলা -').appendTo(selectTag);


                selectTagUnion.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnion);

                selectTagProvider.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);

                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].upazilaid;
                    var name = returnedData[i].upazilaname;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
        }
    });


    //Laod Union from upazila---------------------------------------------------
    $('#upazila').change(function (event) {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();

        var selectTag = $('#union');
        var selectTagUnit = $('#unit');
        var selectTagProvider = $('#provCode');

        if (upazilaId === "" || upazilaId === '0') {
            selectTag.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);

            selectTagProvider.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);


        } else {
            $.get('UnionJsonProviderTest', {
                upazilaId: upazilaId, zilaId: zilaId
            }, function (response) {
                var returnedData = JSON.parse(response);


                selectTag.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট ইউনিয়ন -').appendTo(selectTag);

                selectTagProvider.find('option').remove();
                $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagProvider);


                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].unionid;
                    var name = returnedData[i].unionname;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
        }
    });


    //Load village from Union---------------------------------------------------
    $('#union').change(function (event) {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();
        var selectTag = $('#provCode');
        //var selectTagUnit = $('#unit');

        if (unionId === "" || unionId === '0') {
            selectTag.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);

//            selectTagUnit.find('option').remove();
//            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTagUnit);

        } else {
            $.get('ProviderJsonProviderByUnion_mis2_dgfp', {
                upazilaId: $('select#upazila').val(), zilaId: $('select#district').val(), unionId: $('select#union').val()
            }, function (response) {
                selectTag.find('option').remove();
                var json = JSON.parse(response);
                for (var i = 0; i < json.length; i++) {
                    var id = json[i].providerid;
                    var name = json[i].provname;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });

//            $.ajax({
//                url: "FWAUnitJsonDataProviderForElco",
//                data: {
//                    districtId: zilaId,
//                    upazilaId: upazilaId,
//                    unionId: unionId
//                },
//                type: 'POST',
//                success: function (response) {
//                    selectTag.find('option').remove();
//                    $.get('ProviderJsonProviderByUnion_mis2', {
//                        upazilaId: $('select#upazila').val(), zilaId: $('select#district').val(), unionId: $('select#union').val()
//                    }, function (response) {
//
//                        var json = JSON.parse(response);
//                        for (var i = 0; i < json.length; i++) {
//                            var id = json[i].providerid;
//                            var name = json[i].provname;
//                            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
//                        }
//                    });
//
//                }
//            });

        }//end else
    });


    /* $('#unit').change(function (event) {
     //alert("Change unit: "+$("select#unit").val());
     
     var unitId = $("select#unit").val();
     var selectTag = $('#provCode');
     var selectTagUnit = $('#unit');
     
     if (unitId === "" || unitId ==='0') {
     selectTag.find('option').remove();
     $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);
     }else{
     
     var selectTag = $('#provCode');
     selectTag.find('option').remove();
     $.get('ProviderJsonProviderByUnit', {
     upazilaId: $('select#upazila').val(), zilaId: $('select#district').val(), unionId: $('select#union').val(),unitId:unitId
     }, function (response) {
     
     var json = JSON.parse(response);
     for (var i = 0; i < json.length; i++) {
     var id = json[i].providerid ;
     var name = json[i].provname;
     $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
     }                
     });
     }
     
     });*/



    //Load District
    function loadDistrict() {
        $.get("DistrictJsonProviderByUser", function (response) {

            var returnedData = JSON.parse(response);
            var selectTag = $('#district');
            selectTag.find('option').remove();

            if (returnedData.length > 1 || $('#userLevel').val() == "2") {
                $('<option>').val("").text('- সিলেক্ট জেলা -').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].zillaid;
                var name = returnedData[i].zillaname; //ZILLANAMEENG
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });

    }
    //Load District
    function loadDistrictFromTab() {
        $.get("DistrictJsonProviderByUser", function (response) {

            var returnedData = JSON.parse(response);
            var selectTag = $('#district');
            selectTag.find('option').remove();

            if (returnedData.length > 1 || $('#userLevel').val() == "2") {
                $('<option>').val("").text('- সিলেক্ট জেলা -').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].zillaid;
                var name = returnedData[i].zillaname; //ZILLANAMEENG
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
            console.log("Ready For Upazila");
            loadUpazilaFromTab();
        });

    }

    //Load Upazila
    function loadUpazila() {
        $.get("UpazilaJsonProviderByUserDGFP", function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#upazila');
            selectTag.find('option').remove();

            if (returnedData.length > 1) {
                $('<option>').val("").text('- সিলেক্ট উপজেলা -').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].upazilaid;
                var name = returnedData[i].upazilaname; //UPAZILANAMEENG
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });
    }

    //Load loadUpazilaFromTab
    function loadUpazilaFromTab() {
        $.get("UpazilaJsonProviderByUserDGFP", function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#upazila');
            selectTag.find('option').remove();

            if (returnedData.length > 1) {
                $('<option>').val("").text('- সিলেক্ট উপজেলা -').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].upazilaid;
                var name = returnedData[i].upazilaname; //UPAZILANAMEENG
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
            console.log("Ready For Union");
            loadUnionFromTab();
        });
    }

    //Load Union UnionJsonProviderByUser_mis2
    function loadUnion() {
        $.get("UnionJsonProviderByUserTest", function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#union');
            selectTag.find('option').remove();

            if (returnedData.length > 1) {
                $('<option>').val("").text('- সিলেক্ট ইউনিয়ন -').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].unionid;
                var name = returnedData[i].unionname;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
            console.log("Ready For Provider");
            loadProvider();
        });
    }

    //Load loadUnionFromTab
    function loadUnionFromTab() {
        $.get("UnionJsonProviderByUserTest", function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#union');
            selectTag.find('option').remove();

            if (returnedData.length > 1) {
                $('<option>').val("").text('- সিলেক্ট ইউনিয়ন -').appendTo(selectTag);
            }
            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].unionid;
                var name = returnedData[i].unionname;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
            console.log("Ready For Provider");
            loadProviderFromTab();
        });
    }

    //Load Provider
    function loadProvider() {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();
        var selectTag = $('#provCode');
        //var selectTagUnit = $('#unit');

        if (unionId === "" || unionId === '0') {
            selectTag.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);
        } else {

            selectTag.find('option').remove();
            $.get('ProviderJsonProviderByUnion_mis2_dgfp', {
                upazilaId: $('select#upazila').val(), zilaId: $('select#district').val(), unionId: $('select#union').val()
            }, function (response) {

                var json = JSON.parse(response);
                for (var i = 0; i < json.length; i++) {
                    var id = json[i].providerid;
                    var name = json[i].provname;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });


//            $.ajax({
//                url: "ProviderJsonProviderByUnion_mis2_dgfp",
//                data: {
//                    districtId: zilaId,
//                    upazilaId: upazilaId,
//                    unionId: unionId
//                },
//                type: 'POST',
//                success: function (response) {
//
//                    selectTag.find('option').remove();
//                    $.get('ProviderJsonProviderByUnion_mis2', {
//                        upazilaId: $('select#upazila').val(), zilaId: $('select#district').val(), unionId: $('select#union').val()
//                    }, function (response) {
//
//                        var json = JSON.parse(response);
//                        for (var i = 0; i < json.length; i++) {
//                            var id = json[i].providerid;
//                            var name = json[i].provname;
//                            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
//                        }
//                    });
//                }
//            });



        }//end else
    }

    //Load Provider from Tab
    function loadProviderFromTab() {
        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();
        var selectTag = $('#provCode');
        //var selectTagUnit = $('#unit');

        if (unionId === "" || unionId === '0') {
            selectTag.find('option').remove();
            $('<option>').val("").text('- সিলেক্ট করুন -').appendTo(selectTag);
        } else {
            selectTag.find('option').remove();
            $.get('ProviderJsonProviderByUnion_mis2_dgfp', {
                upazilaId: $('select#upazila').val(), zilaId: $('select#district').val(), unionId: $('select#union').val()
            }, function (response) {
                console.log("Success:   " + response);
                var json = JSON.parse(response);

                for (var i = 0; i < json.length; i++) {
                    var id = json[i].providerid;
                    var name = json[i].provname;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });

//            $.ajax({
//                url: "FWAUnitJsonDataProviderForElco",
//                data: {
//                    districtId: zilaId,
//                    upazilaId: upazilaId,
//                    unionId: unionId
//                },
//                type: 'POST',
//                success: function (response) {
//
//
//                    selectTag.find('option').remove();
//                    $.get('ProviderJsonProviderByUnion_mis2', {
//                        upazilaId: $('select#upazila').val(), zilaId: $('select#district').val(), unionId: $('select#union').val()
//                    }, function (response) {
//                        console.log("Success:   " + response);
//                        var json = JSON.parse(response);
//
//                        for (var i = 0; i < json.length; i++) {
//                            var id = json[i].providerid;
//                            var name = json[i].provname;
//                            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
//                        }
//                    });
//
//                }
//            });




        }//end else
    }















//    function loadProvider(){
//        
//
//        $.get('ProviderJsonProviderByUnit', {
//            upazilaId: $('select#upazila').val(), zilaId: $('select#district').val(), unionId: $('select#union').val(),unitId:$("select#unit").val()
//        }, function (response) {
//            var json = JSON.parse(response);
//            
//            var selectTag = $('#provCode');
//            selectTag.find('option').remove();
//            if(json.length>1){
//                $('<option>').val("").text('- সিলেক্ট প্রোভাইডার -').appendTo(selectTag);
//            }
//            for (var i = 0; i < json.length; i++) {
//                var id = json[i].providerid ;
//                var name = json[i].provname;
//                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
//            }                
//        });
//   
//    }


});