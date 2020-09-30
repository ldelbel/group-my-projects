module ApplicationHelper
  def home?
    request.url == root_url
  end

  def profile?
    return false if current_user.nil?
    request.url == user_url(current_user)
  end

  def login_page?
    request.url == login_url
  end

  def signup_page?
    request.url == signup_url
  end

  def projects_page?
    request.url == projects_url
  end

  def project_page?(project)
    return false if project.nil?
    request.url == project_url(project.id)
  end


end
