$ ->
  project_id = $("#feature").data("projectid")
  
  $(document).delegate 'div.new_step > input[name="name[]"]', 'focusin', ->
  
    $(this).autocomplete(
      source: (request, response) ->
        
        
        query = "string=" + request.term + "&project_id=" + project_id
        
        $.ajax
          url: "/implemented_steps/match",
          data: query,
          dataType: "json",
          type: "GET",
          success: response
      
      , minLength: 1,
      delay: 100
         
         
      ).data("autocomplete")._renderItem = (ul, item) ->
        if item.match == 0
          html = "<li></li>"
        else
          html = "<li class='matched_step'></li>"
        return $(html).data("item.autocomplete", item).append( item.name ).appendTo(ul)
        
        
