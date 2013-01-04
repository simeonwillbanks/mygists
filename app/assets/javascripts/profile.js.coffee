$ ->
  $("body.profile #tags").load "#{window.location.pathname}/tags", ->
    $("#gists-fetching-spinner").remove()
    $info = $("#gists-fetching-info")
    if $info.is("div")
      button = '<button class="close" data-dismiss="alert" type="button">&times;</button>'
      text = "Your gists have been fetched from GitHub!<br>" +
             "With each profile visit, My Gists fetches your recently updated gists."
      $info.html button + text
