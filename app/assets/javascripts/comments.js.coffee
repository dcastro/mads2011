# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

clear_selected = () ->
  $(".step").removeClass("selected")
  $("h5.scenario_head").removeClass("selected")
  
show_feature_comments = () ->
  $.ajax
    url: "/comments/index?commentable_id=" + $("#feature").data('featureid') + "&commentable_type=Feature",
    dataType: 'script'
  

$ ->
  $("div#feature_comments").click ->
    clear_selected()
    show_feature_comments()
 
  $("span.scenario_comments").click (e) ->
    clear_selected()
    $(this).parents("h5.scenario_head").addClass("selected")
    $.ajax
      url: "/comments/index?commentable_id=" + $(this).data('commentable_id') + "&commentable_type=" + $(this).data('commentable_type'),
      dataType: 'script'
    e.stopPropagation()

  $(".step").click ->
    clear_selected()
    $(this).addClass("selected")



  $(".scenario_body").hide()

  
  $(".scenario_head").toggle ->
    $(this).next(".scenario_body").slideDown(100);
  , ->
    $(this).next(".scenario_body").slideUp(300);
    if $(this).next(".scenario_body").find(".step").hasClass("selected")
      clear_selected()
      show_feature_comments()
    