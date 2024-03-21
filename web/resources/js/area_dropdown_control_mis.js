$(document).ready(function () {

    for (i = new Date().getFullYear(); i > 1900; i--)
    {
        $('#year').append($('<option />').val(i).html(i));
    }
    
    $.get("DistrictJsonDataProvider", function (response) {
        var returnedData = JSON.parse(response);
        var selectTag = $('#district');
        $('<option>').val("").text('------').appendTo(selectTag);
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].zillaid;
            var name = returnedData[i].zillanameeng;
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
            $('<option>').val("").text('----').appendTo(selectTag);

            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('----').appendTo(selectTagUnion);

            for (var i = 0; i < returnedData.length; i++) {
                var id = returnedData[i].upazilaid;
                var name = returnedData[i].upazilanameeng;
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
            $('<option>').val("").text('----').appendTo(selectTag);
        } else {
            $.get('UnionJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId
            }, function (response) {
                var returnedData = JSON.parse(response);
                selectTag.find('option').remove();
                $('<option>').val("").text('----').appendTo(selectTag);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].unionid;
                    var name = returnedData[i].unionnameeng;
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

        if (upazilaId === "") {
            selectTag.find('option').remove();
            $('<option>').val("").text('----').appendTo(selectTag);
        } else {
            $.get('VillageJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId, unionId: unionId
            }, function (response) {
                var returnedData = JSON.parse(response);
                selectTag.find('option').remove();
                $('<option>').val("").text('All').appendTo(selectTag);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].mouzaid + '' + returnedData[i].villageid;
                    var name = returnedData[i].villagenameeng;
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
    
    $("#provCode").change(function(){
        
        
    });

});