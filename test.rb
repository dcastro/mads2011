Dir.glob('features/step_definitions/**/*.rb').each do |filename|
          
          file = File.open(filename)
          
          file.each do |line|
            match = line.match /^\s*(And|When|Given|Then)\s*\/(.*)\//  
            if ( match )
              
              puts  filename.split('/').last + "\t\t" + match.to_a.last
              puts "\n"
              
            end
            
          end
          
          
          
        end
