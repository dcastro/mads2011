popupStatus = 0;
vtable = -1


#centering popup
centerPopup = () -> 
  #request data for centering
  windowWidth = document.documentElement.clientWidth;
  windowHeight = document.documentElement.clientHeight;
  popupHeight = $("#popupHotkeys").height();
  popupWidth = $("#popupHotkeys").width();
  
  #centering
  $("#popupHotkeys").css({
    "position": "absolute",
    "top": windowHeight/2-popupHeight/2,
    "left": windowWidth/2-popupWidth/2
  });
  #only need force for IE6
  
  $("#backgroundPopup").css({
    "height": windowHeight
  });
  
loadPopup = () ->
  if (popupStatus==0)
    centerPopup()
    
    $("#backgroundPopup").css({
      "opacity": "0.7"
    });
    
    $("#backgroundPopup").fadeIn("slow");
    
    $("#popupHotkeys").fadeIn("slow");
    
    popupStatus = 1;
  


#disabling popup with jQuery magic!
disablePopup = () ->
  #disables popup only if it is enabled
  if(popupStatus==1)
    $("#backgroundPopup").fadeOut("slow");
    $("#popupHotkeys").fadeOut("slow");
    popupStatus = 0;
  


disablePopupHotkey = () ->
  if(popupStatus == 1)
    disablePopup()
    
helpHotkey = () ->
  if ! $("#new_suggestion").is(":visible")
    return
    
  if popupStatus == 1
    disablePopup()
  else
    loadPopup()
    

newStep = () ->
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
      <span class="sort_handle"><img alt="Cursor_hand" height="15" src="/assets/cursor_hand.png"></span>
      <span class="add_step">+</span>
    </div>
  
  '''
  
  $("#no_steps_error").hide()

removeStep = () ->
     $(".new_steps .new_step:last-child").remove()
     if $("div.new_steps .new_step").size() == 0
        $("#no_steps_error").effect("pulsate", { times:3 }, 200);


createTable = () ->
    step = $(this).parent()
    
    #proibe a existencia de mais que uma tabela
    table = step.find('div.step_table_container')
    if(table.size() > 0)
      vtable = -1
      table.hide 'fast', ->
        $(this).remove()
      return
    
    step_index = $(".new_step").index(step)
    
    step.append '''
      <div class="step_table_container">
          <table class="step_table" data-step="''' + step_index + '''">
            <tbody>
              <tr data-index=1>
                <td> <input id="row_" name="row[''' + step_index + '''][1][]" size="10" type="text"></td>
                <td> <input id="row_" name="row[''' + step_index + '''][1][]" size="10" type="text"></td>
                <td class="table_controls">
                  <span class="arrow_up"> <img src="/assets/arrow_up.png"/> </span>
                  <span class="arrow_down"> <img src="/assets/arrow_down.png"/> </span>
                </td>
              </tr>
              <tr data-index=2>
                <td> <input id="row_" name="row[''' + step_index + '''][2][]" size="10" type="text"></td>
                <td> <input id="row_" name="row[''' + step_index + '''][2][]" size="10" type="text"></td>
                <td class="table_controls">
                  <span class="arrow_up"> <img src="/assets/arrow_up.png"/> </span>
                  <span class="arrow_down"> <img src="/assets/arrow_down.png"/> </span>
                </td>
              </tr>
              
              <tr class="table_vert_controls">
                <td>
                  <span class="arrow_left"> <img src="/assets/arrow_left.png"/> </span>
                  <span class="arrow_right"> <img src="/assets/arrow_right.png"/> </span>
                </td>
                <td>
                  <span class="arrow_left"> <img src="/assets/arrow_left.png"/> </span>
                  <span class="arrow_right"> <img src="/assets/arrow_right.png"/> </span>
                </td>
              </tr>
              
            </tbody>

          </table>    
        </div>       
    '''
    
    vtable = step.find("table.step_table")
    vtable.show('fast')
  
tableActions = (e) ->
  console.log e.which
  
  if vtable == -1
    return
  
  switch e.which
    when 87 #Alt + w -> remove row
      console.log(this)
      removeRow(vtable)
    when 65 #Alt + a -> remove column
      console.log(this)
      removeColumn(vtable)
    when 83 #Alt + s -> add row
      console.log(this)
      addRow(vtable)
    when 68 #Alt + d -> add column
      console.log(this)
      addColumn(vtable)
  
  event.preventDefault()
  
addRow = (table) ->
  index = table.data('step')
  n_rows = table.find('tr:not(.table_vert_controls)').length
  n_cells = table.find('tr:not(.table_vert_controls) > td:not(.table_controls)').length / n_rows
    
  #inicializa a linha e respectivas cells
  new_row = "<tr data-index=" + (n_rows + 1) + ">"
  for num in [1..n_cells]
    new_row += '<td> <input id="row_" name="row[' + index + '][' + (n_rows + 1) + '][]" size="10" type="text"></td>'
    
  #adiciona os controls
  new_row += '''
      <td class="table_controls">
          <span class="arrow_up"> <img src="/assets/arrow_up.png"/> </span>
          <span class="arrow_down"> <img src="/assets/arrow_down.png"/> </span>
      </td>
  '''
  new_row += "</tr>"
  
  #adiciona depois da penúltima linha
  table.find("tr:not(.table_vert_controls)").last().after new_row
  
  
addColumn = (table) ->
  index = table.data('step')
  
  #adiciona cell a cada linha da tabela
  table.find('tr:not(.table_vert_controls)').each ->
    new_cell = '<td> <input id="row_" name="row[' + index + '][' + $(this).data('index') + '][]" size="10" type="text"></td>'
    $(this).find("td:not(.table_controls)").last().after new_cell

  #adiciona controls
  $("tr.table_vert_controls").append '''
      <td>
        <span class="arrow_left"> <img src="/assets/arrow_left.png"/> </span>
        <span class="arrow_right"> <img src="/assets/arrow_right.png"/> </span>
      </td>
  '''
    
    
removeRow = (table) ->
  return if table.find('tr:not(.table_vert_controls)').length == 1
  table.find('tr:not(.table_vert_controls)').last().remove()
  
  
removeColumn = (table) ->
  return if table.find('tr').first().find('td:not(.table_controls)').length == 1
  
  table.find('tr').each ->
    $(this).find("td:not(.table_controls)").last().remove()
  
toggleDialog = () ->
  disablePopup()
  $("#new_suggestion").toggle("slide", { direction: "left" }, 200)

$ ->
    #prepara o menu help
    $("div#new_suggestion").parent().append '''
        <div id="popupHotkeys">
          <a id="popupHotkeysClose"><img alt="Close_icon" height="15" src="/assets/close_icon.png"></a>
          <h1>Hotkeys</h1>
          <p>
              <p><span class="hotkey">Alt + N:</span> New Step </p>
              <p><span class="hotkey">Alt + X:</span> Remove Last Step </p>  
              <p><span class="hotkey">Alt + T:</span> Add/Remove Table </p>
              <p><span class="hotkey">Alt + C:</span> Create Suggestion</p>                
              <br/>
              <p>Tables</p>
                <p><span class="hotkey">Alt + W:</span> Remove Row</p>  
                <p><span class="hotkey">Alt + A:</span> Remove Column</p>  
                <p><span class="hotkey">Alt + S:</span> Add Row</p>  
                <p><span class="hotkey">Alt + D:</span> Add Column</p>  
              <br/>
              <p><span class="hotkey">Alt + H:</span> Brings up this dialog </p>
              <p><span class="hotkey">Esc:</span> Closes this dialog </p>
          </p>
        </div>
        <div id="backgroundPopup"></div>
    '''
  
  
    $("#hotkeys").click ->
      #centering with css
      centerPopup()
      #load popup
      loadPopup()
      
      
    #CLOSING POPUP
    #Click the x event!
    $("#popupHotkeysClose").click ->
      disablePopup()

    #Click out event!
    $("#backgroundPopup").click ->
      disablePopup()
      
    #close with esc key
    $(document).bind('keydown', 'esc', disablePopupHotkey );
    
    #open/close with Alt + H
    $(document).bind('keyup', 'Alt+h', helpHotkey );
    
    $(document).bind('keyup', 'Alt+n', newStep )

    $(document).bind('keyup', 'Alt+x', removeStep )
    
    #aplicada apenas aos inputs directamente descendente do step
    #exlcui inputs da tabela -> previne tabelas dentro de tabelas
    $(document).delegate ".new_steps .new_step > input", 'keyup', 'Alt+t', createTable
    
    
    #$(document).delegate ".new_steps .new_step table", 'keydown', 'Alt+w Alt+a Alt+s Alt+d', tableActions
    $(document).bind('keydown', 'Alt+w Alt+a Alt+s Alt+d', tableActions)
    
    $(document).delegate ".new_steps .new_step table.step_table", "focus", ->
      vtable = $(this)
    
    #controlos manuais das tabelas
    $(document).delegate ".arrow_right", "click", ->
      table = $(this).parents("table")
      addColumn(table = $(this).parents("table"))
      
    $(document).delegate ".arrow_left", "click", ->
      table = $(this).parents("table")
      removeColumn(table = $(this).parents("table"))
      
    $(document).delegate ".arrow_up", "click", ->
      table = $(this).parents("table")
      removeRow(table = $(this).parents("table"))
      
    $(document).delegate ".arrow_down", "click", ->
      table = $(this).parents("table")
      addRow(table = $(this).parents("table"))
      
    $(document).delegate ".table_button", "click", createTable


    #toggle suggestion dialog
    $(document).bind 'keydown', 'Alt+p', ->
      toggleDialog()
      
    $("#close_suggestion, #open_suggestion").click ->
      toggleDialog()




