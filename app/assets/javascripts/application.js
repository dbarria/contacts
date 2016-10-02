// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery.highlight
//= require bootstrap-toolkit.min
//= require_tree .

var currentContactSelected = false;

function homeAction(){
  $.ajax({
    url: "/contacts",
    method: "GET",
    dataType : 'script'
  })
}

function getParameterByName(name, url) {
  var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
   if (results==null){
      return null;
   }
   else{
      return results[1] || 0;
   }
}

$( document ).ready(function() {
  if(location.pathname == "/"){
    $.ajax({
      url: "/contacts",
      method: "GET",
      dataType : 'script'
    }).done(function(){
      if(location.hash != ""){
        $.ajax({
          url: location.hash.replace("#!",""),
          method: "GET",
          dataType : 'script'
        })
      }
    });
  }
  $( "#search-form").on('ajax:beforeSend', function(event, xhr, settings) {
    location.hash = "#!" + settings.url
    event.preventDefault();
    return false
  });

  if($("#query").val() == ""){
    var queryParam =  getParameterByName('query')
    if (queryParam){
      $("#query").val(queryParam)
    }
  }

});

$(window).on('hashchange',function()
{
    $.ajax({
      url: location.hash.replace("#!",""),
      method: "GET",
      dataType : 'script'
    })
});
