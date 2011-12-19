$ ->
  $("div#sidebar").fadeOut 'fast', ->
    $("div#sidebar").replaceWith '''
      <div id="sidebar">
          <%= render(file: "comments/index.html.erb").html_safe %>
          <%= render(file: "comments/form.html.erb").html_safe %>
      </div>
    '''

    
    $("div#sidebar").hide()
    $("div#sidebar").fadeIn('fast')