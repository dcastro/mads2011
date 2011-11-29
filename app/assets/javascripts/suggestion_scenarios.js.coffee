# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

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
        <span class="table_button"><img alt="Table" height="17" src="/assets/table.jpg"></span>
        <span class="add_step">+</span>
      </div>
    
    '''
    $("#no_steps_error").hide()

  $("div.new_steps").delegate ".remove_step", "click", ->
    $(this).parent().remove()
    if $("div.new_steps .new_step").size() == 0
      $("#no_steps_error").effect("pulsate", { times:3 }, 200);




