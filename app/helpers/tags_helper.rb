module TagsHelper
  def page_title
    super([current_tag.name, current_user.profile.username])
  end
end
