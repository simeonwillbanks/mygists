$ ->
  $("body.profile #tags").load "#{window.location.pathname}/tags", ->
    button = '<button class="close" data-dismiss="alert" type="button">&times;</button>'
    text = "Your gists have been fetched!"
    $("body.profile #gists-fetching").html button + text
