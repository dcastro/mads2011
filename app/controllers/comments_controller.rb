class CommentsController < ApplicationController
  def index
    @comments = Comment.where(commentable_type: params[:commentable_type],
                  commentable_id: params[:commentable_id]
                  )
                  
    @commentable = {type: params[:commentable_type], id: params[:commentable_id]}
    
    respond_to do |format|
      format.html {  }
      format.js { render file: "comments/comments.js.coffee" }
    end
  end

  def create
    @comment = Comment.new content: params[:content],
                          user: current_user,
                          commentable_id: params[:commentable_id],
                          commentable_type: params[:commentable_type]
    unless @comment.save
      render js: 'alert("An error occurred while saving your comment.")'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.user.id == session[:id]
      comment.destroy
      render js: "$('.comment[data-comment_id=\"#{ params[:id] }\"]').slideUp(100);"
    else
      render js: "alert('This comment was not made by you.');"
    end
  end

end
