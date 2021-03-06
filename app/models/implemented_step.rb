class ImplementedStep < ActiveRecord::Base
  belongs_to :project
  
  private
  def remove_parentheses(reg)
    reg.chop!
    until reg.match /.*[^\\]\($/

      if reg.match /.*[^\\]\)$/
        reg = remove_parentheses(reg)
      end
      
      reg.chop!
    end
    
    return reg    
  end
  
  def remove_square_brackets(reg)
    reg.chop!
    until reg.match /.*[^\\]\[$/

      if reg.match /.*[^\\]\]$/
        reg = remove_square_brackets(reg)
      end
      
      reg.chop!
    end
    
    return reg    
  end
  
  def remove_brackets(reg)
    reg.chop!
    until reg.match /.*[^\\]\{$/

      if reg.match /.*[^\\]\}$/
        reg = remove_brackets(reg)
      end
      
      reg.chop!
    end
    
    return reg    
  end
  
  
  public
  def match(string)
    
    return 1 if string.match self.name
    
    reg = String.new(self.name)
    
    while not reg.empty?
      if string.match /#{reg + '$'}/i #case insensitive partial match
        return 0
      end
      
      case reg
        #acaba em ]
        when /.*[^\\]\]$/
          reg = remove_square_brackets(reg)
          reg.chop!
        
        #acaba em )    
        when /.*[^\\]\)$/
          reg = remove_parentheses(reg)
          reg.chop!

          
        #acaba em }
        when /.*[^\\]\}$/
          reg = remove_brackets(reg)
          reg.chop!
        
        #escaped chars, ex: \d
        when /.*[^\\](\\\S)$/
          reg.chomp! $1
          
        else reg.chop!
        
      end #case
    end #while
    
    return false
  end #def match
  
end
