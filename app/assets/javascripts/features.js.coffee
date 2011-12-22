# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
helpStatus = 0;

centerPopupHelp = () -> 
  #request data for centering
  windowWidth = document.documentElement.clientWidth;
  windowHeight = document.documentElement.clientHeight;
  popupHeight = $("#popupHelp").height();
  popupWidth = $("#popupHelp").width();
  
  #centering
  $("#popupHelp").css({
    "position": "absolute",
    "top": windowHeight/2-popupHeight/2,
    "left": windowWidth/2-popupWidth/2
  });
  #only need force for IE6
  
  $("#backgroundPopupHelp").css({
    "height": windowHeight
  });



loadPopupHelp = () ->
  if (helpStatus==0)
    centerPopupHelp()
    
    $("#backgroundPopupHelp").css({
      "opacity": "0.7"
    });
    
    $("#backgroundPopupHelp").fadeIn("slow");
    
    $("#popupHelp").fadeIn("slow");
    
    helpStatus = 1;

#disabling popup with jQuery magic!
disablePopupHelp = () ->
  #disables popup only if it is enabled
  if(helpStatus==1)
    $("#backgroundPopupHelp").fadeOut("slow");
    $("#popupHelp").fadeOut("slow");
    helpStatus = 0;

$ ->
  $("span#feature_options").append '''
        <div id="popupHelp">
          <a id="popupHelpClose"><img alt="Close_icon" height="15" src="/assets/close_icon.png"></a>
          <h1>Help</h1>
          <p>
              trololol
          </p>
        </div>
        <div id="backgroundPopupHelp"></div>
  
  
  
  '''
  
  #Open help menu
  $("div#open_help").click ->
    centerPopupHelp()
    loadPopupHelp()
    
  #Click close button
  $("#popupHelpClose").click ->
    disablePopupHelp()

  #Click out event
  $("#backgroundPopupHelp").click ->
    disablePopupHelp()
