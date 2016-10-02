# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
(($, viewport) ->
  $(document).ready ->
    if viewport.is('<sm') && location.hash.match(/#!\/contacts\/\d+/)
      $(".main").show();
      $(".sidebar").hide();
    $('#query').keyup ->
      $('#search-form').submit()
      return
    $('body').on 'click', '.list-group a', ->
      if viewport.is('<sm')
        $(".sidebar").hide();
        $(".main").show() if !$(".main").is(":visible");
    $('body').on 'click', '.back', ->
      if viewport.is('<sm')
        $(".main").hide();
        $(".sidebar").show();
    $(document).on 'click', 'a', (e) ->
        e.preventDefault();
        location.hash = "#!" + $(this).attr('href')
    $(window).resize viewport.changed((->
      if viewport.is('>=sm')
        $(".sidebar").show() if !$(".sidebar").is(":visible");
        $(".main").show() if !$(".main").is(":visible");
      return
    ), 150)
    return
  return
) jQuery, ResponsiveBootstrapToolkit



$(document).ajaxComplete ->
  if $("#query").val() == ""
    $(".container-fluid .row").unhighlight();
  else
    $(".container-fluid .row").highlight($("#query").val().split(" "));
