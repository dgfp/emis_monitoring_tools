var district=null;

$(document).ready(function () {
    
    var jsonVillage=null;

    for (i = new Date().getFullYear(); i > 1900; i--)
    {
        $('#year').append($('<option />').val(i).html(i));
    }
    
    $.get("DistrictJsonDataProvider", function (response) {
        var returnedData = JSON.parse(response);
        district=returnedData;
        var selectTag = $('#district');
        $('<option>').val("").text('- Select District -').appendTo(selectTag);
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].zillaid;
            var name = returnedData[i].zillanameeng;
            $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
        }
    });

    $('#district').change(function (event) {
                document.getElementById('villDiv').style.display = "none";
                $(".overall").attr('disabled', true);
                $(".overall").attr('checked', false);
                $(".providerWise").prop("checked", true);
                
        

        var districtId = $("select#district").val();
        
        var selectTag = $('#upazila');
        var selectTagUnion = $('#union');
        var selectTagUnit = $('#unit');
        var selectTagVillage = $('#village');
        
        if (districtId === "") {
                            
                selectTag.find('option').remove();
                $('<option>').val("").text('- Select Upazila -').appendTo(selectTag);

                
                selectTagUnion.find('option').remove();
                $('<option>').val("").text('- Select Unit-').appendTo(selectTagUnion);

                selectTagUnit.find('option').remove();
                $('<option>').val("").text('- Select Unit-').appendTo(selectTagUnit);

                
                selectTagVillage.find('option').remove();
                $('<option>').val("").text('- Select Village-').appendTo(selectTagVillage);
                          
        }else{
            
            $.get('UpazilaJsonProvider', {
                districtId: districtId
            }, function (response) {
                var returnedData = JSON.parse(response);


                
                selectTag.find('option').remove();
                $('<option>').val("").text('All').appendTo(selectTag);

                
                selectTagUnion.find('option').remove();
                $('<option>').val("").text('- Select Unit-').appendTo(selectTagUnion);

                selectTagUnit.find('option').remove();
                $('<option>').val("").text('- Select Unit-').appendTo(selectTagUnit);

                
                selectTagVillage.find('option').remove();
                $('<option>').val("").text('- Select Village-').appendTo(selectTagVillage);

                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].upazilaid;
                    var name = returnedData[i].upazilanameeng;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
            
            
        }
        
        





    });

    $('#upazila').change(function (event) {
        
            document.getElementById('villDiv').style.display = "none";
            $(".overall").attr('disabled', true);
            $(".overall").attr('checked', false);
            $(".providerWise").prop("checked", true);

        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        
        var selectTag = $('#union');
        var selectTagUnit = $('#unit');
        var selectTagVillage = $('#village');

        if (upazilaId === "") {
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTag);
            
            selectTagUnit.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagUnit);
            
            selectTagVillage.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagVillage);
  
            
        } else {
            $.get('UnionJsonProvider', {
                upazilaId: upazilaId, zilaId: zilaId
            }, function (response) {
                var returnedData = JSON.parse(response);
                
                
                selectTag.find('option').remove();
                $('<option>').val("").text('All').appendTo(selectTag);

                selectTagUnit.find('option').remove();
                $('<option>').val("").text('- Selec Unit-').appendTo(selectTagUnit);

                selectTagVillage.find('option').remove();
                $('<option>').val("").text('- Select Village-').appendTo(selectTagVillage);
                
                
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].unionid;
                    var name = returnedData[i].unionnameeng;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }
            });
        }
    });


    $('#union').change(function (event) {
        
        document.getElementById('villDiv').style.display = "none";
        $(".overall").attr('disabled', true);
        $(".overall").attr('checked', false);
        $(".providerWise").prop("checked", true);
        
        var upazilaId = $("select#upazila").val();
        var zilaId = $("select#district").val();
        var unionId = $("select#union").val();
        var selectTag = $('#village');
        var selectTagUnit = $('#unit');

        if (unionId === "") {
            selectTag.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTag);
            
            selectTagUnit.find('option').remove();
            $('<option>').val("").text('- Select -').appendTo(selectTagUnit);

        } else {
            

            
//            $.ajax({
//                url: "ProviderJsonData",
//                data: {
//                    districtId: $("select#district").val(),
//                    upazilaId: $("select#upazila").val(),
//                    unionId: $("select#union").val()
//                },
//                type: 'POST',
//                success: function (response) {
//                    
//                    var selectTag = $('#provCode');
//
//                    var returnedData = JSON.parse(response);
//                    selectTag.find('option').remove();
//                    $('<option>').val("").text('All').appendTo(selectTag);
//                    for (var i = 0; i < returnedData.length; i++) {
//                        var id = returnedData[i].provcode;
//                        var name = returnedData[i].provname;
//                        $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
//                    }
//                }
//            });

            //get Unit
                $.ajax({
                url: "FWAUnitJsonDataProviderForElco",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: $("select#union").val()
                },
                type: 'POST',
                success: function (response) {
                    
                    var selectTag = $('#unit');

                    var returnedData = JSON.parse(response);
                    selectTag.find('option').remove();
                    $('<option>').val("").text('All').appendTo(selectTag);
                    for (var i = 0; i < returnedData.length; i++) {
                        var id = returnedData[i].ucode;
                        var name = returnedData[i].uname;
                        $('<option>').val(id).text(name + ' [' + returnedData[i].ucode + ']').appendTo(selectTag);
                    }
                }
            });  
            
            
        }//end else
    });
    
    $('#unit').change(function (event) {

        var unitId = $("select#unit").val();
        var selectTag = $('#village');
        var selectTagUnit = $('#unit');

        if (unitId === "") {
            document.getElementById('villDiv').style.display = "none";
            $(".overall").attr('disabled', true);
            $(".overall").attr('checked', false);
            $(".providerWise").prop("checked", true);
       

        }else{
            document.getElementById('villDiv').style.display = "block";
            
            var selectTag = $('#village');
            selectTag.find('option').remove();
            $('<option>').val("").text('All').appendTo(selectTag);
            $.get('VillageJsonProviderByUnit', {
                upazilaId: $('select#upazila').val(), zilaId: $('select#district').val(), unionId: $('select#union').val(),unitId:unitId
            }, function (response) {
                
                var jsonVillage = JSON.parse(response);
                for (var i = 0; i < jsonVillage.length; i++) {
                    var id = jsonVillage[i].mouzaid + '' + jsonVillage[i].villageid;
                    var name = jsonVillage[i].villagenameeng;
                    $('<option>').val(id).text(name + ' [' + id + ']').appendTo(selectTag);
                }                
            });
            $("#radioDiv").find("input").removeAttr("disabled");
        }

    });


});