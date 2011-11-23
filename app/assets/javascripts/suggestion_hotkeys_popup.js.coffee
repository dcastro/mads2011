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
  $("div.new_steps tbody").append '''
  
      <tr class="new_step">
        <td> <span class="remove_step">-</span> </td>
        <td><input id="keyword_" name="keyword[]" placeholder="keyword" size="10" type="text"></td>
        <td><input id="name_" name="name[]" placeholder="step description" size="50" type="text"></td>
        <td><span class="add_step">+</span></td>
      </tr>
  
  '''
  $("#no_steps_error").hide()

removeStep = () ->
     $("tbody tr:last-child").remove()
     if $("div.new_steps tbody > tr").size() == 0
        $("#no_steps_error").effect("pulsate", { times:3 }, 200);

$ ->
    $("div#new_suggestion").append '''
        <div id="popupHotkeys">
          <a id="popupHotkeysClose">x</a>
          <h1>Hotkeys</h1>
          <p>
              <p><span class="hotkey">Alt + S:</span> New Step </p>
              <p><span class="hotkey">Alt + X:</span> Remove Last Step </p>                
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
    
    $(document).bind('keyup', 'Alt+s', newStep )

    $(document).bind('keyup', 'Alt+x', removeStep )

      

