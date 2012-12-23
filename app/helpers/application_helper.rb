module ApplicationHelper
  def navigation_items
    {
      'profile'  => profile_path(current_user.profile),
      'help'     => help_path,
      'sign_out' => destroy_user_session_path
    }
  end
end
