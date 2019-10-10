# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(".form_vehicule").on "change", ->
    $.ajax
      url: "/deplacements/new"
      type: "GET"
      dataType: "script"
      data:
        taux_km: $(this).attr("data-taux-km")

