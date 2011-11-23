popupStatus = 0;

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
      <span class="add_step">+</span>
    </div>
  
  '''
  $("#no_steps_error").hide()

removeStep = () ->
     $(".new_steps .new_step:last-child").remove()
     if $("div.new_steps .new_step").size() == 0
        $("#no_steps_error").effect("pulsate", { times:3 }, 200);


createTable = () ->
    step = $(".new_steps :focus").parent()
    
    #proibe a existencia de mais que uma tabela
    table = step.find('table')
    if(table.size() > 0)
      table.remove()
      return
    
    step_index = $(".new_step").index(step)
    
    step.append '''
    
          <table class="step_table">
            <tr>
              <td> <input id="row_" name="row[''' + step_index + '''][1][]" size="10" type="text"></td>
              <td> <input id="row_" name="row[''' + step_index + '''][1][]" size="10" type="text"></td>
            </tr>
            <tr>
              <td> <input id="row_" name="row[''' + step_index + '''][2][]" size="10" type="text"></td>
              <td> <input id="row_" name="row[''' + step_index + '''][2][]" size="10" type="text"></td>
            </tr>
          </table>              
    '''
    
    
tableActions = (e) ->
  console.log e.which
  
  switch e.which
    when 87 #Alt + w -> remove row
      alert 'w'
    when 65 #Alt + a -> remove column
      alert 'a'
    when 83 #Alt + s -> add row
      console.log(this)
      addRow($(this))
    when 68 #Alt + d -> add column
      alert 'd'
  
  event.preventDefault()
  
addRow = (table) ->
  table.find('input').val('lool')

$ ->
    $("div#new_suggestion").append '''
        <div id="popupHotkeys">
          <a id="popupHotkeysClose">x</a>
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
    #$(".new_steps .new_step > input").bind('keyup', 'Alt+t', createTable)
    $(document).delegate ".new_steps .new_step > input", 'keyup', 'Alt+t', createTable
    
    $(document).delegate ".new_steps .new_step table", 'keydown', 'Alt+w Alt+a Alt+s Alt+d', tableActions
      

