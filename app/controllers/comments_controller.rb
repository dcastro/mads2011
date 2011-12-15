class CommentsController < ApplicationController
  def index
    @comments = Comment.all #Comment.where(commentable_type: params[:commentable_type],
                  #commentable_id: params[:commentable_id]
                  #)
                  
    respond_to do |format|
      format.html {  }
      format.js { @commentable = {type: params[:commentable_type], id: params[:commentable_id]} }
    end
  end

  def create
    Comment.new 
    render js: '$("#new_comment_form textarea").val("")'
  end

  def destroy
  end

end
