# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
(($, viewport) ->
  $(document).ready ->
    infiniteScroll ".sidebar"
    infiniteScroll document
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
    $(window).resize viewport.changed((->
      if viewport.is('>=sm')
        $(".sidebar").show() if !$(".sidebar").is(":visible");
        $(".main").show() if !$(".main").is(":visible");
      return
    ), 150)
    return
  return
) jQuery, ResponsiveBootstrapToolkit

infiniteScroll = (observer) ->
  if $('#infinite-scrolling').size() > 0
    $(observer).on 'scroll', ->
      more_contacts_url = $('.pagination .next a').attr('href')
      if more_contacts_url && $(observer).scrollTop() > $(observer).height() - $(window).height() - 60
        # $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />')
        $.getScript more_contacts_url
        return
      return
$(document).ajaxComplete ->
  $(".container-fluid").highlight($("#query").val().split(" "));
