$ ->
  $("div#sidebar").append '''
        <div id="comments">
        </div>
  
        <div id="new_comment">
          <%= form_tag( comments_create_path, :id => 'new_comment_form', :method => :get , :remote => true) do%>
              <%= text_area_tag 'content' %>
              <%= submit_tag 'Save' %>
          <% end %>
        </div>
  
  
  '''
