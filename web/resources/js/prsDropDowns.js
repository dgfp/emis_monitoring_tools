// Prs load Division Data
function resetArea(prsType){
    var userLevel = $('#userLevel').val();
    
    //reset all data presenter like Dashboard - chart - Table
    resetAllDataPresenter();
    type=prsType;
    $('#transparentTextForBlank').show();
    $('#presentationType,#tableView,#tableView,#graphView,#mapView,#area').hide();
//    document.getElementById('transparentTextForBlank').style.display = "block";
//    document.getElementById('presentationType').style.display = "none";
//    document.getElementById('tableView').style.display = "none";
//    document.getElementById('graphView').style.display = "none";
//    document.getElementById('mapView').style.display = "none";
//    document.getElementById('area').style.display = "none";
    //document.getElementById('area').innerHTML="";
    
//    if(prsType==="Provider"){
//        document.getElementById('graphView').style.display = "none";
//    }else{
//        //document.getElementById('graphView').style.display = "block";
//    }

    $.get("DivisionJsonProviderByUser", function (response) {

        var returnedData = JSON.parse(response);
        var selectTag1 = $('#division1');
        var selectTag2 = $('#division2');
        var selectTag3 = $('#division3');
        var selectTag5 = $('#division5');
        selectTag1.find('option').remove();
        selectTag2.find('option').remove();
        selectTag3.find('option').remove();
        selectTag5.find('option').remove();
        if(userLevel==='1'){
            $('<option>').val("").text('- Select Division -').appendTo(selectTag1);
            $('<option>').val("").text('- Select Division -').appendTo(selectTag2);               
            $('<option>').val("").text('- Select Division -').appendTo(selectTag3);
            $('<option>').val("").text('- Select Division -').appendTo(selectTag5);
        }     
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].id;
            var name = returnedData[i].divisioneng;
            $('<option>').val(id).text(name).appendTo(selectTag1);
            $('<option>').val(id).text(name).appendTo(selectTag2);
            $('<option>').val(id).text(name).appendTo(selectTag3);
            $('<option>').val(id).text(name).appendTo(selectTag5);
        }

        if(userLevel==='2'){
            loadDistrict(prsType);
            
        }else if(userLevel==='3'){
            loadDistrict(prsType);
            loadUpazila(prsType);
            
        }else if(userLevel==='4'){
            loadDistrict(prsType);
            loadUpazila(prsType);
            loadUnion(prsType);
            
        }else if(userLevel==='5' || userLevel==='7'){
            loadDistrict(prsType);
            loadUpazila(prsType);
            loadUnion(prsType);
            
        }else if(userLevel==='6'){
            loadDistrict(prsType);
            loadUpazila(prsType);
            loadUnion(prsType);
        }
    });
 }
 
 
$(document).ready(function () {
    
        //Area collapse button toggle FOR show location
        $("#collapseArea").click(function(){
            $("#area").toggle();
        });

//---------------Laod District for all prs district dropdown---------------------------------------------
    //District load For ==District== Wise PRS type
    $('#division1').change(function (event) {
       var divisionId = $("select#division1").val();
       var selectTag = $('#district1');
       //Get District with default parameter
       getDistrict(divisionId,selectTag,"%","All");
    });
    
    //District load For ==Upazila== Wise PRS type
    $('#division2').change(function (event) {
       //load District by Division
       var divisionId = $("select#division2").val();
       var selectTag = $('#district2');
       
        //Get District with default parameter
       getDistrict(divisionId,selectTag,"","- Select District -");
       
       //Refresh child dropdown
        var selectUpazila = $('#upazila2');
        selectUpazila.find('option').remove();
        $('<option>').val("").text('- Select Upazila -').appendTo(selectUpazila);
    });
    
    //District load For ==Union== Wise PRS type
    $('#division3').change(function (event) {
       //load District by Division
       var divisionId = $("select#division3").val();
       var selectTag = $('#district3');
        //Get District with default parameter
       getDistrict(divisionId,selectTag,"","- Select District -");
       
       //Refresh child dropdown
        var selectUpazila = $('#upazila3');
        selectUpazila.find('option').remove();
        $('<option>').val("").text('- Select Upazila -').appendTo(selectUpazila);

        var selectUnion = $('#union3');
        selectUnion.find('option').remove();
        $('<option>').val("").text('- Select Union -').appendTo(selectUnion);
    });
    
    //District load For ==Provider== Wise PRS type
    $('#division5').change(function (event) {
       //load District by Division
       var divisionId = $("select#division5").val();
       var selectTag = $('#district5');
        //Get District with default parameter
       getDistrict(divisionId,selectTag,"","- Select District -");
       
       //Refresh child dropdown
        var selectUpazila = $('#upazila5');
        selectUpazila.find('option').remove();
        $('<option>').val("").text('- Select Upazila -').appendTo(selectUpazila);

        var selectUnion = $('#union5');
        selectUnion.find('option').remove();
        $('<option>').val("").text('- Select Union -').appendTo(selectUnion);
    });
//-----------------End District for all prs district dropdown------------------------------------------

//---------------Laod Upazila for all prs Upazila dropdown---------------------------------------------
    $('#district2').change(function (event) {
        var districtId = $("select#district2").val();
        var selectTag = $('#upazila2');
        //Get Upazila with default parameter
        getUpazila(districtId,selectTag,"%","All");
    });
    
    $('#district3').change(function (event) {
        var districtId = $("select#district3").val();
        var selectTag = $('#upazila3');
        //Get Upazila with default parameter
        getUpazila(districtId,selectTag,"","- Select Upazila -");
        
        //Refresh child dropdown
        var selectUnion= $('#union3');
        selectUnion.find('option').remove();
        $('<option>').val("").text('- Select Union -').appendTo(selectUnion);
    });
    
    $('#district5').change(function (event) {
        var districtId = $("select#district5").val();
        var selectTag = $('#upazila5');
        //Get Upazila with default parameter
        getUpazila(districtId,selectTag,"","- Select Upazila -");
        
        //Refresh child dropdown
        var selectUnion= $('#union5');
        selectUnion.find('option').remove();
        $('<option>').val("").text('- Select Union -').appendTo(selectUnion);
    });
//-----------------End Upazila loding for all prs Upazila dropdown------------------------------------------


//---------------Laod Union for all prs Uion dropdown---------------------------------------------
    $('#upazila3').change(function (event) {
        var districtId = $("select#district3").val();
        var upazilaId = $("select#upazila3").val();
        var selectTag = $('#union3');
        getUnion(districtId,upazilaId,selectTag,"%","All");
    });
    
    $('#upazila5').change(function (event) {
        var districtId = $("select#district5").val();
        var upazilaId = $("select#upazila5").val();
        var selectTag = $('#union5');
        getUnion(districtId,upazilaId,selectTag,"%","All");

    });
    
//-----------------End Union loding for all prs Union dropdown------------------------------------------

});
/////////////////////////////////////////////////END JQuery Part//////////////////////////////////////////////

//Get Distirct by district dropdown
function getDistrict(divisionId,selectTag,defaultValue,defaultText){
    
    $.get('DistrictJsonProvider', {
       divisionId: divisionId
    }, function (response) {

       var returnedData = JSON.parse(response);

       selectTag.find('option').remove();
       $('<option>').val(defaultValue).text(defaultText).appendTo(selectTag);

       for (var i = 0; i < returnedData.length; i++) {
           var id = returnedData[i].zillaid;
           var name = returnedData[i].zillanameeng;
           $('<option>').val(id).text(name).appendTo(selectTag);
       }
    });
}

//Get Upazilla by district dropdown
function getUpazila(districtId,selectTag,defaultValue,defaultText){
    
    $.get('UpazilaJsonProvider', {
        districtId: districtId
    }, function (response) {

        var returnedData = JSON.parse(response);

        selectTag.find('option').remove();
        $('<option>').val(defaultValue).text(defaultText).appendTo(selectTag);

        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].upazilaid;
            var name = returnedData[i].upazilanameeng;
            $('<option>').val(id).text(name).appendTo(selectTag);
        }
    });
}

//Get Union by Upazilla dropdown
function getUnion(zilaId,upazilaId,selectTag,defaultValue,defaultText){
    
    $.get('UnionJsonProvider', {
        upazilaId: upazilaId, zilaId: zilaId
    },function (response) {
        
        var returnedData = JSON.parse(response);
        
        selectTag.find('option').remove();
        $('<option>').val(defaultValue).text(defaultText).appendTo(selectTag);

        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].unionid;
            var name = returnedData[i].unionnameeng;
            $('<option>').val(id).text(name).appendTo(selectTag);
        }
    });
}

//reset all Data Representer
function resetAllDataPresenter(){
    document.getElementById("tableHeader").innerHTML = "";
    document.getElementById("tableBody").innerHTML = "";
    document.getElementById("tableFooter").innerHTML = "";
    document.getElementById("dashboard").innerHTML = "";
    document.getElementById("chart").innerHTML = "";
}


//Load District
function loadDistrict(prsType){
    
    $.get("DistrictJsonProviderByUser", function (response) {

        var returnedData = JSON.parse(response);
        var selectTag1 = $('#district1');
        var selectTag2 = $('#district2');
        var selectTag3 = $('#district3');
        var selectTag5 = $('#district5');
        selectTag1.find('option').remove();
        selectTag2.find('option').remove();
        selectTag3.find('option').remove();
        selectTag5.find('option').remove();

        if(returnedData.length>1 || $('#userLevel').val()=="2"){
            $('<option>').val("%").text('All').appendTo(selectTag1);
            $('<option>').val("").text('- Select District -').appendTo(selectTag2);
            $('<option>').val("").text('- Select District -').appendTo(selectTag3);
            $('<option>').val("").text('- Select District -').appendTo(selectTag5);
        }
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].zillaid;
            var name = returnedData[i].zillanameeng; //ZILLANAMEENG
            $('<option>').val(id).text(name).appendTo(selectTag1);
            $('<option>').val(id).text(name).appendTo(selectTag2);
            $('<option>').val(id).text(name).appendTo(selectTag3);
            $('<option>').val(id).text(name).appendTo(selectTag5);
        }
    });

}

//Load Upazila
function loadUpazila(){
    $.get("UpazilaJsonProviderByUser", function (response) {
        var returnedData = JSON.parse(response);
//        var selectTag1 = $('#upazila1');
        var selectTag2 = $('#upazila2');
        var selectTag3 = $('#upazila3');
        var selectTag5 = $('#upazila5');
//        selectTag1.find('option').remove();
        selectTag2.find('option').remove();
        selectTag3.find('option').remove();
        selectTag5.find('option').remove();

        if(returnedData.length>1){
//            $('<option>').val("%").text('All').appendTo(selectTag1);
            $('<option>').val("%").text('All').appendTo(selectTag2);
            $('<option>').val("").text('- Select Upazila -').appendTo(selectTag3);
            $('<option>').val("").text('- Select Upazila -').appendTo(selectTag5);
        }
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].upazilaid;
            var name = returnedData[i].upazilanameeng; //UPAZILANAMEENG
//            $('<option>').val(id).text(name).appendTo(selectTag1);
            $('<option>').val(id).text(name).appendTo(selectTag2);
            $('<option>').val(id).text(name).appendTo(selectTag3);
            $('<option>').val(id).text(name).appendTo(selectTag5);
        }
    });
}

//Load Union
function loadUnion(){
    
    $.get("UnionJsonProviderByUser", function (response) {
        
        
        
        var returnedData = JSON.parse(response);
        console.log(returnedData);
//        var selectTag1 = $('#union1');
//        var selectTag2 = $('#union2');
        var selectTag3 = $('#union3');
        var selectTag5 = $('#union5');
//        selectTag1.find('option').remove();
//        selectTag2.find('option').remove();
        selectTag3.find('option').remove();
        selectTag5.find('option').remove();
    
        if(returnedData.length>1){
//            $('<option>').val("%").text('All').appendTo(selectTag1);
//            $('<option>').val("%").text('All').appendTo(selectTag2);
            $('<option>').val("%").text('All').appendTo(selectTag3);
            $('<option>').val("%").text('All').appendTo(selectTag5);
        }
        for (var i = 0; i < returnedData.length; i++) {
            var id = returnedData[i].unionid;
            var name = returnedData[i].unionnameeng;
//            $('<option>').val(id).text(name).appendTo(selectTag1);
//            $('<option>').val(id).text(name).appendTo(selectTag2);
            $('<option>').val(id).text(name).appendTo(selectTag3);
            $('<option>').val(id).text(name).appendTo(selectTag5);
        }
    });

}
