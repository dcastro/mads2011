# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("div.new_steps").delegate ".add_step", "click", ->
      $("div.new_steps tbody").append '''
      
          <tr class="new_step">
            <td> <span class="remove_step">-</span> </td>
            <td><input id="keyword_" name="keyword[]" placeholder="keyword" size="10" type="text"></td>
            <td><input id="name_" name="name[]" placeholder="step description" size="50" type="text"></td>
            <td><span class="add_step">+</span></td>
          </tr>
      
      '''
