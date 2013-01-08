module ApplicationHelper
  def navigation_items
    {
      profile:  profile_path(current_user.profile),
      help:     help_path,
      sign_out: destroy_user_session_path
    }
  end

  def page_title(pages = [])
    pages = [pages] unless pages.is_a?(Array)

    (pages + ["My Gists"]).join(" | ")
  end

  def render_fetching_info?
    flash[:from_omniauth_callback] == true
  end

  def github
    GitHub
  end
end
