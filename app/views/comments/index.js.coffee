<% @comments = comments if defined? comments %>
<% @commentable = commentable if defined? commentable %>

$ ->
	$("div#comments").replaceWith '''

		<div id="comments">
		  <h4 id="comments_title"><%= @commentable[:type] %> Comments</h4>
			<%= render partial: "comments/comment", collection: @comments %>
		</div>

	'''
