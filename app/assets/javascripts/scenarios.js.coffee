# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->


  $(".thrash_can").click ->
    $(this).prev("form.destroy_suggestion").submit()
    return false
    
  $("div.suggestion_options .run_suggestion").click ->
    $(this).prev("form.run_suggestion").submit()
    return false