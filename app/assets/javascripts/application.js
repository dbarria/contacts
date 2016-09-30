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
//TODO comportamiento para recarga de página con page>1
function searchContactsAction(url){
  $.ajax({
    url: url,
    method: "GET",
    dataType : 'script'
  })
}
function showContactAction(url){
  $.ajax({
    url: url,
    method: "GET",
    dataType : 'script'
  })
}

$( document ).ready(function() {
  console.log("asdasdasdas")
  if(location.hash !== "" && location.hash.includes("#!")){
    url = location.hash.replace("#!","");
    url_parts = url.split("/");
    //ROOT URL
    if(url_parts[1] == ""){
      return;
    }
    //Contacts controller
    if(url_parts[1]=="contacts"){
      //Search action
      if(url_parts[1].includes("search")){
        searchContactsAction(url);
      //Show action
      }else{
        console.log("here?")
        showContactAction(url);
      }
    }

  }
});

$(window).on('hashchange',function()
{
  var hash = location.hash;
  console.log(hash);
});


$( document ).ajaxComplete(function( event, xhr, settings ) {
  url = settings.url
  console.log(url);
  location.hash = "#!" + url.replace(base_url,"");

});
