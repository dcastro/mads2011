# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("#project_github_username").keyup ->
    username = $(this).val()
    
    if username == ""
      $("#github_username").text("<username>")
    else
      $("#github_username").text(username)


  $("#project_github_repo").keyup ->
    repo = $(this).val()
    
    if repo == ""
      $("#github_repo").text("<repo>")
    else
      $("#github_repo").text(repo)