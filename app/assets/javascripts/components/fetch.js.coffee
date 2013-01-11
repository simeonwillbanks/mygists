# Public: MyGists is the global application namespace.
window.MyGists =

  # Public: Uses jQuery AJAX to get tags for a specific profile.
  #
  # Examples
  #
  #   MyGists.Fetch.tags(window.location.pathname, $)
  Fetch:

    # Public: Bootstrap CSS class for an alert div.
    alertClass: "alert"

    # Public: Bootstrap CSS class for an alert div with a successful alert.
    successClass: "alert-info"

    # Public: Bootstrap CSS class for an alert div with an error alert.
    errorClass: "alert-error"

    # Public: Success text alerting user tags have been fetched.
    successText: "Your gists have been fetched from GitHub!<br>
                 With each profile visit, My Gists fetches your
                 recently updated gists."

    # Public: Error text alerting user something went wrong when fetching tags.
    errorText: "An error has occurred, and an administrator notified."

    # Public: Bootstrap button HTML for dismissing an alert.
    button:  '<button class="close" data-dismiss="alert" type="button">&times;</button>'

    # Public: Removes AJAX spinner from the DOM.
    #
    # Returns nothing.
    removeSpinner: ->
      @$("#gists-fetching-spinner").remove()

    # Public: Gets tags for a given profile via jQuery AJAX.
    #
    # path - The String path of profile whose tags need fetching.
    # $    - The jQuery object.
    #
    # Examples
    #
    #   MyGists.Fetch.tags(window.location.pathname, $)
    #
    # Returns nothing.
    tags: (path, $) ->
      @$ = $

      @$.ajax(
        url: "#{path}/tags"
        type: "GET"
        dataType: "html"
        context: @
        success: (data, textStatus, jqXHR) ->
          @success(data)
        error: (jqXHR, textStatus) ->
          @error()
      )

    # Public: On AJAX success, this method is invoked. It performs these tasks:
    #         1. Removes AJAX spinner from the DOM.
    #         2. Injects fetched tags HTML into the DOM.
    #         3. Provides user with a successful alert.
    #
    # html - The String tags HTML returned from AJAX get request.
    #
    # Returns nothing.
    success: (html) ->
      @$notice = @$("#gists-fetching-alert")
      @$tags = @$("#tags")

      @removeSpinner()

      @$tags.html html

      @$notice.html @button + @successText if @$notice[0]

    # Public: On AJAX error, this method is invoked. It performs these tasks:
    #         1. Removes AJAX spinner from the DOM.
    #         2. Alerts the user of the error. If the original alert div is
    #            present in the DOM, reuse it. If the original alert div is
    #            gone, create a new div and inject it into the DOM.
    #
    # Returns nothing.
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
