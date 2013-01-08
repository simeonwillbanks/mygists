window.MyGists =
  Fetch:
    alertClass: "alert"
    successClass: "alert-info"
    errorClass: "alert-error"
    successText: "Your gists have been fetched from GitHub!<br>
                 With each profile visit, My Gists fetches your
                 recently updated gists."
    errorText: "An error has occurred, and an administrator notified."
    button:  '<button class="close" data-dismiss="alert" type="button">&times;</button>'

    removeSpinner: ->
      @$("#gists-fetching-spinner").remove()

    tags: (path, $) ->
      @$ = $

      request = $.ajax(
        url: "#{path}/tags"
        type: "GET"
        dataType: "html"
        context: @
        success: (data, textStatus, jqXHR) ->
          @success(data)
        error: (jqXHR, textStatus) ->
          @error()
      )

    success: (html) ->
      @$notice = @$("#gists-fetching-alert")
      @$tags = @$("#tags")
      @removeSpinner()
      @$tags.html html
      @$notice.html @button + @successText if @$notice[0]

    error: ->
      @$notice = @$("#gists-fetching-alert")
      @$tags = @$("#tags")
      @removeSpinner()
      if @$notice[0]
        @$notice.removeClass(@successClass)
                .addClass(@errorClass)
                .html @button + @errorText
      else
        @$tags.html "<div class='#{@alertClass} #{@errorClass}'>
                      #{@button}
                      #{@errorText}
                    </div>"
