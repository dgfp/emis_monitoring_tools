$(document).ready(function () {

    for (i = new Date().getFullYear(); i > 1900; i--)
    {
        $('#year').append($('<option />').val(i).html(i));
    }
    
    $.get("DistrictJsonDataProvider", function (response) {
        var returnedData = JSON.parse(response);
        var selectTag = $('#district');
        $('<option>').val(id).text('-সিলেক্ট করুন-').appendTo(selectTag);
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].zillaid;
            var name = returnedData[i].zillaname;
            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
        }
    });

    $('#district').change(function (event) {

        var districtId = $("select#district").val();
        $.get('UpazilaJsonProvider', {
            districtId: districtId
        }, function (response) {
            var returnedData = JSON.parse(response);
            var selectTag = $('#upazila');
            selectTag.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTag);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagUnion);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].upazilaid;
                var name = returnedData[i].upazilaname;
                $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
            }
        });





    });

    $('#upazila').change(function (event) {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var selectTag = $('#union');

        if (upazilaId === "") {
            selectTag.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTag);
        } else {
            $.get('UnionJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId
            }, function (response) {
                var returnedData = JSON.parse(response);
                selectTag.find('option').remove();
                $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTag);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].unionid;
                    var name = returnedData[i].unionname;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
        }
    });


    $('#union').change(function (event) {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();

        var selectTag = $('#village');
  
        if (unionId === "") {
            selectTag.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTag);
        } else {
            
            //Village json provider by union id
            $.get('VillageJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId, unionId: unionId
            }, function (response) {
                var returnedData = JSON.parse(response);
                selectTag.find('option').remove();
                $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTag);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].mouzaid + '' + returnedData[i].villageid;
                    var name = returnedData[i].villagename;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
            
            //Mouza json provider by union id
            $.get('MouzaJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId, unionId: unionId
            }, function (response) {
                var returnedData = JSON.parse(response);
                
                var selectTag = $('#mouza');
                selectTag.find('option').remove();
                $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTag);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].mouzaid;
                    var name = returnedData[i].mouzaname;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });

            $.ajax({
                url: "ProviderJsonData",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: $("select#union").val()
                },
                type: 'POST',
                success: function (response) {
                    //alert("Hi");
                    var selectTag = $('#provCode');

                    var returnedData = JSON.parse(response);
                    selectTag.find('option').remove();
                   // $('<option>').val("").text('All').appendTo(selectTag);
                    for (var i = 0; i < returnedData.length; i++) {
                        var id = returnedData[i].provcode;
                        var name = returnedData[i].provname;
                        $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                    }

                }
            });
        }
    });
    
    
    //Mouza change event for load village by muza id
    $('#mouza').change(function (event) {

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();
        var mouzaId = $("select#mouza").val();
        
        var selectTag = $('#villageByMouza');
        

        if (mouzaId === "") {
            selectTag.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTag);
        } else {
            $.get('VillageJsonProviderByMouza', {
                upazilaId: upazilaId, zilaId: zilaId, unionId: unionId, mouzaId:mouzaId
            }, function (response) {
                var returnedData = JSON.parse(response);
                selectTag.find('option').remove();
                $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTag);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].villageid;
                    var name = returnedData[i].villagename;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
        }
    });
    
    
    //provider chnage event
    $("#provCode").change(function(){
        
        
    });
    
    //Add static ward----------------------------------------------------------------
    $('#union').change(function (event) {
      var ward = $('#ward');
      ward.find('option').remove();
      $('<option>').val("0").text('সবগুলো').appendTo(ward);
      $('<option>').val("1").text('ওয়ার্ড ১').appendTo(ward);
      $('<option>').val("2").text('ওয়ার্ড ২').appendTo(ward);
      $('<option>').val("3").text('ওয়ার্ড ৩').appendTo(ward);

 });

});