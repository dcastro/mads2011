Dir.glob('features/step_definitions/**/*.rb').each do |filename|
          
          file = File.open(filename)
          
          file.each do |line|
            match = line.match /^\s*(And|When|Given|Then)\s*\/(.*)\//  
            if ( match )
              
              #puts  filename.split('/').last + "\t\t" + match.to_a.last
              #puts "\n"
              
            end
            
          end
          
          
          
        end
        
  
  str = "I sendd"
  reg = "I send (.*) to (.*) \\d lol"

  while not reg.empty?
    if str.match Regexp.new(reg + '$')
      puts "****"
      p str
      p reg
      p str.match Regexp.new(reg)      
      puts "****"
      break
    end
    p reg
    
    case reg
      #acaba em ]
      when /.*[^\\]\]$/
        reg.chop! until reg.match /.*[^\\]\[$/
        reg.chop!
      
      #acaba em )    
      when /.*[^\\]\)$/
        reg.chop! until reg.match /.*[^\\]\($/
        reg.chop!
        
      #acaba em }
      when /.*[^\\]\}$/
        reg.chop! until reg.match /.*[^\\]\{$/
        reg.chop!
      
      #escaped chars, ex: \d
      when /.*[^\\](\\\S)$/
        reg.chomp! $1
        
      else reg.chop!
      
    end
    
    
    #reg = reg.split(' ')[0...-1].join(' ')
    #if reg != ""
    #  reg += '$'
    #end
  end
