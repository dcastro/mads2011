module CommentsHelper
=begin  
  def comments_title(commentable)
    case commentable[:type]
      when "Feature" then return "Feature comments"
      when "Scenario" then return ""
    end
  end
=end
end
