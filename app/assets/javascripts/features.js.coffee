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
              Click on any given scenario to expand it and see its description.
          </p>
          <p>    
              You can navigate through this feature, its scenarios and their steps' comments by clicking on the <img alt="Comments_bubbles" height="20" src="/assets/comments_bubbles.png"/>s
              or by clicking on the step itself.
          </p>
          <p>
              Click on <img alt="Thought_bubble" height="20" src="/assets/thought_bubble.png"> to let the development team know of a scenario that you find suitable for this feature.
          </p>
          <p>
              You can Run or Delete a suggestion by opening the tools menu <img alt="Options" height="20" src="/assets/options.png"/>
          </p>
          
          
          <div> 
            Steps Markup:
            
            <ul>
              <li><span class="passed">Green:</span> OK!</li>
              <li><span class="failed">Red:</span> Failed..</li>
              <li><span class="undefined">Yellow:</span> Undefined step.</li>
              <li><span class="skipped">Blue:</span> Cucumber skipped this step.</li>
            </ul>
          </div>
          <div>
            Scenarios Markup:
            <ul>
              <li><span class="completed markup">Green:</span> Awesome!</li>
              <li><span class="incomplete markup">Red:</span> Something's wrong</li>
              <li><span class="suggestion markup">Grey:</span> This scenario was suggested by a member.</li>
            </ul>
            
          </div>
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
