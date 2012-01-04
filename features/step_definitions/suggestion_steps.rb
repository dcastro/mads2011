Given /^the following suggestion data:$/ do |table|
  @sug_data = table
end

Given /^the following suggestion steps:$/ do |table|
  @sug_steps =  table
end

When /^I open and fill in the suggestions form$/ do 
  
  #abre o formulario
  page.driver.browser.execute_script %Q{ $('#open_suggestion').trigger("mouseenter").click(); }
  sleep 1
  
  #preenche o nome e a descricao  
  @sug_data.rows_hash.each do |name, value|
    step %{I fill in "#{name}" with "#{value}"}
  end
  
  
  #adiciona os steps necessarios
  (@sug_steps.hashes.length - 2).times do
    page.driver.browser.execute_script %Q{ $('div.new_step:last-child span.add_step').trigger("mouseenter").click(); }
  end
  
  @sug_steps.hashes.each_with_index do |step_data, index|
    #no ambito de cada step
    with_scope("step no. " + (index + 1).to_s) do
      
      #preenche os campos keyword e nome
      step %{I select "#{ step_data["keyword"] }" from "keyword[]"}
      step %{I fill in "name_" with "#{ step_data["name"] }"}
      
      #se existirem rows, cria a tabela e adiciona as rows necessarias
      rows = step_data["rows & cells"].split /\s*&\s*/
      
      if not rows.empty?
        #step %{I send [alt, t] to "input#name_"}
        page.driver.browser.execute_script %Q{ $('.new_step:nth-child(#{(index + 1).to_s}) span.table_button').trigger("mouseenter").click(); }

        (rows.length - 2).times do
          #step %{I send [alt, s] to "input#name_"}
          page.driver.browser.execute_script %Q{ $('.new_step:nth-child(#{(index + 1).to_s}) table.step_table tr:nth-last-child(2) .table_controls .arrow_down').trigger("mouseenter").click(); }
          
        end
      end
      
      #preenche as cells da tabela
      rows.each_with_index do |row, row_index|
          row.split( /\s*,\s*/ ).each_with_index do |cell, cell_index|
            step %{I send '#{cell}' to "tr:nth-child(#{row_index + 1}) td:nth-child(#{ cell_index + 1 }) input"}
          end
      end
      
    end
  end
  
end


Then /^I should see the new suggestion$/ do
  
  page.driver.browser.execute_script %Q{ $('h5').trigger("mouseenter").click(); }
  
  @sug_data.rows_hash.each do |name, value|
    step %{I should see "#{value}"}
  end
  
  @sug_steps.hashes.each_with_index do |step_data, index|
    
    step %{I should see "#{ step_data["keyword"]  }"}
    step %{I should see "#{ step_data["name"]     }"}
  
    step_data["rows & cells"].split(/\s*&\s*/).each do |row|
      row.split( /\s*,\s*/ ).each do |cell|
        step %{I should see "#{cell}"}
      end
    end
  end
end


Given /^the following suggestion belongs to the feature "([^"]*)":$/ do |name, table|
  
  @suggestion = Feature.find_by_name(name).suggestion_scenarios.create! table.rows_hash
  @suggestion.user = @user
  @suggestion.save!
  
end

When /^I delete this suggestion$/ do
  
  page.driver.browser.execute_script %Q{ $('h5:contains("#{ @suggestion.name }") .thrash_can').trigger("mouseenter").click(); }
  
end

Then /^I should no longer see this suggestion$/ do
  
  step %{I should not see "#{@suggestion.name}"}
  
end

