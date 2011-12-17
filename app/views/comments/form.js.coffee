
  $("div#new_comment").replaceWith '''
        <div id="new_comment">
          <%= form_tag( comments_create_path, :id => 'new_comment_form' , :remote => true) do%>
              <%= hidden_field_tag 'commentable_type', @commentable[:type] %>
              <%= hidden_field_tag 'commentable_id', @commentable[:id] %>
              <%= text_area_tag 'content' %>
              <%= submit_tag 'Save' %>
          <% end %>
        </div>
  
  
  '''
