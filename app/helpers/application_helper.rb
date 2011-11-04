module ApplicationHelper
  
  def current_pages?(*pages)
    pages.each do |p|
      return true if current_page?(p)
    end
    
    return false
  end
  
end
