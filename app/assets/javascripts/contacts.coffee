# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  Turbolinks.enableProgressBar(true)
$(document).on 'page:change', ->

  $('.contactsTable').on 'click', 'tr', ->
    Turbolinks.visit $(this).find('.btn-primary').attr('href')
    return
  $('body').on 'submit', '#search-form', (e)->
      e.preventDefault();
      e.stopPropagation();
      query = $(this).find('input#query').val()
      Turbolinks.visit $(this).attr('action') + "?query=" +  $(this).find('input#query').val() if query != ''
      return
  $(".contactsTable").highlight($("#query").val().split(" "));
