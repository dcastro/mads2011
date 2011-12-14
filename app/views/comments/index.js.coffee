<% @comments = comments if defined? comments %>

$ ->
	$("div#comments").replaceWith '''

		<div id="comments">
			<%= render partial: "comments/comment", collection: @comments %>
		</div>

	'''
