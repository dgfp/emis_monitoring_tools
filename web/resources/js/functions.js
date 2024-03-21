//show alert messsage
function getAlert(msg,type){
    setTimeout(closeAlert, 2000);
    return "<div class='alert alert-flat alert-"+type+" alert-dismissable'>"
            +"<a href='#' class='close' data-dismiss='alert' aria-label='close'>×</a>"
            +"<b>"+msg+"</b>"
        +"</div>";
}

function getFixedAlert(msg,type){
    return "<div class='alert alert-flat alert-"+type+" alert-dismissable'>"
            +"<a href='#' class='close' data-dismiss='alert' aria-label='close'>×</a>"
            +"<b>"+msg+"</b>"
        +"</div>";
}
    

//Alert Auto close function
 var closeAlert = function(){
                var alert = $('#alert');
        alert.empty();
};

//Ajax loading animation
function getLoading(){
    return  '<div id="loading">'
                +'<img src="resources/images/ajaxLoader.gif" alt="Load" class="ajax-loader" width="140px" height="140px" />'
            +'</div>';
}