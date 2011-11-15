# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

show_errors = (error) ->
  $("#suggestion_errors span").text(error)
  $("#suggestion_errors").fadeTo(300, 1).delay(1000).fadeTo(300, 0)

$ ->
  $("div.new_steps").delegate ".add_step", "click", ->
    $("div.new_steps .steps").append '''
    
      <div class="new_step">
        <span class="remove_step">-</span>
        <select id="keyword_" name="keyword[]">
          <option>Given</option>
          <option>When</option>
          <option>And</option>
          <option>Then</option>
        </select>
        <input id="name_" name="name[]" placeholder="step description" size="45" type="text">
        <span class="table_button"><img alt="Table" height="17" src="/assets/table.png"></span>
        <span class="add_step">+</span>
      </div>
    
    '''
    $("#no_steps_error").hide()

  $("div.new_steps").delegate ".remove_step", "click", ->
    $(this).parent().remove()
    if $("div.new_steps .new_step").size() == 0
      $("#no_steps_error").effect("pulsate", { times:3 }, 200);



  #form validation
  $("#suggestion_errors").fadeTo 0, 0
  
  $(".new_suggestion_scenario").submit ->
    
    #validate name
    unless $("#suggestion_scenario_name").val()
      show_errors("Please choose a name for this suggestion.")
      return false
    
    #validate number of steps
    unless $(this).find(".new_step").length > 0
      show_errors("Please add at least one step.")
      return false
    
    #validate empty steps
    success = true
    $(".new_steps input").each ->
      
      unless $(this).val()
        show_errors("Please fill in all steps/tables or delete the empty ones.")
        success = false
        return false
    
    unless success
      return false
    
    return true



