# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  $("div#feature_comments").click ->
    $.ajax
      url: "/comments/index?commentable_id=" + $("#feature").data('featureid') + "&commentable_type=Feature",
      dataType: 'script'
 
  $("span.scenario_comments").click (e) ->
    $.ajax
      url: "/comments/index?commentable_id=" + $(this).data('commentable_id') + "&commentable_type=" + $(this).data('commentable_type'),
      dataType: 'script'
    e.stopPropagation()
