# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
(($, viewport) ->
  $(document).ready ->
    if viewport.is('<sm') && location.hash.match(/#!\/contacts\/\d+/)
      $(".main").show();
      $(".sidebar").hide();
    $('.loadmore').click ->
      loadMore();
      return
    $('#query').keyup ->
      $('#search-form').submit();
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

loadMore = ->
  button = $("#loadmore");
  $.ajax(
    url: $('.pagination .next a').attr('href')
    method: 'GET'
    dataType: 'script'
    beforeSend: ->
      button.button('loading');
      return
  ).done(->
    button.button('reset');
    return
  ).fail ->
    button.button('reset');
    return
  return

$(document).ajaxComplete ->
  if $("#query").val() == ""
    $(".container-fluid").unhighlight();
  else
    $(".container-fluid").highlight($("#query").val().split(" "));
