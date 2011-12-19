
#clean the form
$("#new_comment_form textarea").val("")

#append new comment
$("div#comments").append '<%= render @comment %>'

#increase comment counter
counter = $("#<%= @commentable[:type] + @commentable[:id] %>")
counter.html( ((Number) counter.html()) + 1)
