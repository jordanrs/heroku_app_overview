$('document').ready(function(){
  var clicked_apps = [];
  $('.accordion-toggle').click(function(e){
    
    var app_name = $(this).data('app_name');
    
    if ($.inArray(app_name, clicked_apps) == -1){
      get_data(app_name)
      clicked_apps.push(app_name)
    } 
  })
  
})

var get_data = function(app_name){
  $.get('/app_info/' + app_name, function(r){
    $('#' + app_name +'_other_data').html(r)
  }); 
}