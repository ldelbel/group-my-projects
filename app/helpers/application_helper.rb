module ApplicationHelper
  def home?
    request.url == root_url
  end

  def profile?
    request.url == user_url(current_user)
  end

  def login_page?
    request.url == login_url
  end

  def signup_page?
    request.url == signup_url
  end

end
