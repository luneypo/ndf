# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("select#deplacement_vehicule_id").change ->
    $.ajax
    url: "/deplacements/getvehicule"
    type: "GET"
    dataType: "script"
    data:
      vehicule_id: $("#deplacement_vehicule_id option:selected").val()

  $('.submitexportbtn').prop('disabled',true)
  $(":checkbox").click ->
    $('.submitexportbtn').prop('disabled',false)
