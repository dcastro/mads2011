$ ->
  $("div#sidebar").replaceWith '''
    <div id="sidebar">
        <div id="comments"> </div>
  
        <div id="new_comment"> </div>
    </div>
  '''
<%= render(file: "comments/form.js.coffee").html_safe %>
<%= render(file: "comments/index.js.coffee").html_safe %>