# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
(($, viewport) ->
  $(document).ready ->
    #Responsividad para <SM
    if viewport.is('<sm') && location.hash.match(/#!\/contacts\/\d+/)
      $(".main").show();
      $(".sidebar").hide();
    #Envío de formulario de búsqueda
    $('#query').keyup ->
      $('#search-form').submit()
      return
    $("#reset").click ->
      $("#query").val("")
      $('#search-form').submit()
    #Responsividad para <SM
    $('body').on 'click', '.list-group a', ->
      if viewport.is('<sm')
        $(".sidebar").hide();
        $(".main").show() if !$(".main").is(":visible");
    #Responsividad para <SM
    $('body').on 'click', '.back', ->
      if viewport.is('<sm')
        $(".main").hide();
        $(".sidebar").show();
    #Se desactiva el seguimiento de links en pos de nuestro escuálido Router SPA
    $(document).on 'click', 'a', (e) ->
        e.preventDefault();
        location.hash = "#!" + $(this).attr('href')
    #Responsividad para <SM
    $(window).resize viewport.changed((->
      if viewport.is('>=sm')
        $(".sidebar").show() if !$(".sidebar").is(":visible");
        $(".main").show() if !$(".main").is(":visible");
      return
    ), 150)
    return
  return
) jQuery, ResponsiveBootstrapToolkit


#Se destacan los términos de búsqueda solo si calzan con el input del buscador
# TODO:
# En el caso de los números zip y phone que se encuentrar por FULLTEXT pero no
# corresponden con el input (buscas 232-3434 y por FULLTEXT encuentra 2323434)
# No se subraya.
# Soluciones
# 1) Destacar con algún regex muy feo
# 2) Implementar un Fulltext decente que acepte caracteres decentes y retorne los tokens encontrados para destacar en vista
$(document).ajaxComplete ->
  if $("#query").val() == ""
    $(".container-fluid .row").unhighlight();
  else
    $(".container-fluid .row").highlight($("#query").val().split(" "));
