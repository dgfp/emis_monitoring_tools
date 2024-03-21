$(document).ready(function () {
    //Hide for Tab user
    if($('#userLevel').val()=='7'){
        $(".btn-remove").fadeOut('fast');
//        $(".navbar").fadeOut('fast');
//        $('.main-footer').fadeOut('fast');
        $('.pageTitle').fadeOut('fast');
//        $('.main-header').fadeOut('fast');
         
//        $('label').css({ 'margin-top': '8px' });
//        $('label').css({ 'margin-bottom': '-5px' });
        
//        $("#areaPanel").css({ 'margin-top': '-142px' }); 
        $(".secondRow").css({ 'margin-top': '-19px' });
        $('.logo').removeAttr("href");
    }
    
    if($('#isProvider').val()=='1'){
        $(".btn-remove").fadeOut('fast');
        $(".navbar").fadeOut('fast');
        $('.main-footer').fadeOut('fast');
        $('.pageTitle').fadeOut('fast');
        $('.main-header').fadeOut('fast');
         
        $('label').css({ 'margin-top': '8px' });
        $('label').css({ 'margin-bottom': '-5px' });
        
        $("#areaPanel").css({ 'margin-top': '-142px' }); 
        $(".secondRow").css({ 'margin-top': '-19px' });
        $('.logo').removeAttr("href");
    }
});

