#remove the selected comment
$('.comment[data-comment_id=\"<%= params[:id] %>\"]').slideUp(100);

#decrease comment counter
counter = $("#<%= @commentable[:type] + @commentable[:id] %>")
counter.html( ((Number) counter.html()) - 1)
