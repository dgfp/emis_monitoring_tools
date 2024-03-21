$(document).ready(function () {

    getYear();
    
    $.get("DistrictJsonDataProvider", function (response) {
        var returnedData = JSON.parse(response);
        var selectTag = $('#district');
        $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTag);
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
            
            var selectTagVillage = $('#village');
            selectTagVillage.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagVillage);
            
            var selectTagWard = $('#ward');
            selectTagWard.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagWard);
            
            var selectTagSubblock = $('#subblock');
            selectTagSubblock.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagSubblock);
            
            
            var selectTagYear = $('#year');
            selectTagYear.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagYear);
            
            var selectTagNameOfEPICenter = $('#nameOfEPICenter');
            selectTagNameOfEPICenter.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagNameOfEPICenter);

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
        
        
        //Reset all dropdown after select upazila
            var selectTagUnion = $('#union');
            selectTagUnion.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagUnion);
            
            var selectTagVillage = $('#village');
            selectTagVillage.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagVillage);
            
            var selectTagWard = $('#ward');
            selectTagWard.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagWard);
            
            var selectTagSubblock = $('#subblock');
            selectTagSubblock.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagSubblock);
            
            
            var selectTagYear = $('#year');
            selectTagYear.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagYear);
            
            var selectTagNameOfEPICenter = $('#nameOfEPICenter');
            selectTagNameOfEPICenter.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagNameOfEPICenter);

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

        var selectTag = $('#subblock');
        var selectTag1 = $('#ward');

        var selectTagVillage = $('#village');
        selectTagVillage.find('option').remove();
        $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagVillage);

        var selectTagWard = $('#ward');
        selectTagWard.find('option').remove();
        $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagWard);

        var selectTagSubblock = $('#subblock');
        selectTagSubblock.find('option').remove();
        $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagSubblock);


        var selectTagYear = $('#year');
        selectTagYear.find('option').remove();
        $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagYear);

        var selectTagNameOfEPICenter = $('#nameOfEPICenter');
        selectTagNameOfEPICenter.find('option').remove();
        $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagNameOfEPICenter);

        if (upazilaId === "") {
            selectTag.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTag);
        } else {
            $.get('HABlockJsonDataProvider',  function (response) {
                var returnedData = JSON.parse(response);
                selectTag.find('option').remove();
                $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTag);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].bcode;
                    var name = returnedData[i].bnameban;
                    $('<option>').val(id).text(name).appendTo(selectTag);
                }
            });
            
             $.get('HAWardJsonDataProviderBangla',  function (response) {
                var returnedData = JSON.parse(response);
                selectTag1.find('option').remove();
                $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTag1);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].id;
                     var name = returnedData[i].name;
                     console.log(id+" - "+name);
                    $('<option>').val(id).text(name).appendTo(selectTag1);
                }
            });
            
        }
    });
    
    $('#ward').change(function (event) {
            var selectTagSubblock = $('#subblock');
            selectTagSubblock.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagSubblock);
            
            var selectTagYear = $('#year');
            selectTagYear.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagYear);
            
            var selectTagNameOfEPICenter = $('#nameOfEPICenter');
            selectTagNameOfEPICenter.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagNameOfEPICenter);
            
            $.get('HABlockJsonDataProvider',  function (response) {
                var returnedData = JSON.parse(response);
                selectTagSubblock.find('option').remove();
                $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagSubblock);
                for (var i = 0; i < returnedData.length; i++) {
                    var id = returnedData[i].bcode;
                    var name = returnedData[i].bnameban;
                    $('<option>').val(id).text(name).appendTo(selectTagSubblock);
                }
            });
            
            getYear();
        
        
    });
    

     $('#subblock').change(function (event) {
            
            var selectTagYear = $('#year');
            selectTagYear.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagYear);
            
            var selectTagNameOfEPICenter = $('#nameOfEPICenter');
            selectTagNameOfEPICenter.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagNameOfEPICenter);

            getYear();

       });
       
       
        $('#year').change(function (event) {
            var selectTagNameOfEPICenter = $('#nameOfEPICenter');
            selectTagNameOfEPICenter.find('option').remove();
            $('<option>').val("").text('-সিলেক্ট করুন-').appendTo(selectTagNameOfEPICenter);
            
            $.get('EPIScheduleJsonProvider', {
                district: $("select#district").val(), upazila: $("select#upazila").val(), union: $("select#union").val(), ward:$("select#ward").val(), subblock:$("select#subblock").val(), year:$("select#year").val()
            }, function (response) {
                var returnedData = JSON.parse(response);
                for (var i = 0; i < returnedData.length; i++) {
                    //var id = returnedData[i].schedulerid;
                    var name = returnedData[i].vaccinedate+" "+returnedData[i].centername+"";
                    var id = returnedData[i].vaccinedate+"~"+returnedData[i].centername+"";
                    $('<option>').val(id).text(name).appendTo(selectTagNameOfEPICenter);
                }
            });
        });
            

});


      



    

    
    function getYear(){
        for (i = new Date().getFullYear(); i > 2000; i--)
        {
            $('#year').append($('<option />').val(i).html(i));
        }
    }
    
             