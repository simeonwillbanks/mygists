module ProfileHelper
  def page_title
    super(current_user.profile.username)
  end
end
