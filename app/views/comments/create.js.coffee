
#clean the form
$("#new_comment_form textarea").val(""); $("")

#append new comment
$("div#comments").append '<%= render @comment %>'
