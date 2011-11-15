Given /^the following suggestion data:$/ do |table|

  @sug_data = table
end

Given /^the following suggestion steps:$/ do |table|
  @sug_steps =  table
end

Then /^lol$/ do
  sleep 8
end

When /^I AJAX click2 on "([^"]*)"/ do |link_text|
  # page.evaluate_script %Q{ $('.ui-menu-item a:contains("#{link_text}")').trigger("mouseenter").click(); }
  page.driver.browser.execute_script %Q{ $('div:contains("#{link_text}")').trigger("mouseenter").click(); }
end

When /^I send ([^"]*)$/ do |keys|
  step %{I send #{keys} to "body"}
  sleep 1
end

When /^I open and fill in the suggestions form$/ do 
  
  #abre o formulario
  step %{I send [alt, p] to "body"}
  sleep 1
  
  #preenche o nome e a descricao  
  @sug_data.rows_hash.each do |name, value|
    step %{I fill in "#{name}" with "#{value}"}
  end
  
  
  #adiciona os steps necessarios
  (@sug_steps.hashes.length - 2).times do
    step %{I send [alt, n] to "body"}
  end
  
  @sug_steps.hashes.each_with_index do |step_data, index|
    with_scope("step no. " + (index + 1).to_s) do
      
      #preenche os campos keyword e nome
      step %{I select "#{ step_data["keyword"] }" from "keyword[]"}
      step %{I fill in "name_" with "#{ step_data["name"] }"}
      
      #se existirem rows, cria a tabela e adiciona as rows necessarias
      rows = step_data["rows & cells"].split /\s*&\s*/
      
      if not rows.empty?
        step %{I send [alt, t] to "input#name_"}

        (rows.length - 2).times do
          step %{I send [alt, s] to "input#name_"}
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