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
    request.path == projects_path
  end

  def project_page?(project)
    return false if project.nil? || project.id.nil?

    request.url == project_url(project.id)
  end

  def new_project_page?
    request.url == new_project_url
  end

  def groups_page?
    request.url == groups_url
  end

  def group_page?(group)
    return false if group.nil? || group.id.nil?

    request.url == group_url(group.id)
  end

  def new_group_page?
    request.url == new_group_url
  end

  def edit_group_page?(group)
    return false if group.nil? || group.id.nil?

    request.url == edit_group_url(group.id)
  end

  def edit_user_page?(user)
    return false if user.nil? || user.id.nil?

    request.url == edit_user_url(user.id)
  end

  def image_url_swap(project)
    if project.groups.empty? || project.groups.first.icon.nil?
      asset_path('no-group.png')
    else
      rails_blob_url(project.groups.first.icon)
    end
  end

  def image_url_swap_g(group)
    if group.nil?
      asset_path('no-group.png')
    else
      rails_blob_url(group.icon)
    end
  end

  def avatar_url_swap(user)
    if !user.avatar.attached?
      asset_path('avatar.jpg')
    else
      rails_blob_url(user.avatar)
    end
  end

  def opacity_def(user)
    if !user.avatar.attached?
      '75%'
    else
      '100%'
    end
  end

  def navbar_back_arrow
    if logged_in?
      if project_page?(@project) || new_project_page?
        link_to(projects_url) do
          "<i class='fas fa-arrow-left white'></i>".html_safe
        end.html_safe
      elsif group_page?(@group) || new_group_page? || edit_group_page?(@group)
        link_to(groups_url) do
          "<i class='fas fa-arrow-left white'></i>".html_safe
        end.html_safe
      else
        link_to(user_path(current_user)) do
          "<i class='fas fa-arrow-left white'></i>".html_safe
        end.html_safe
      end
    else
      link_to(root_url) do
        "<i class='fas fa-arrow-left white'></i>".html_safe
      end.html_safe
    end
  end

  def navbar_title
    case
    when login_page?
      "<h4>LOGIN</h4>".html_safe
    when signup_page?
     "<h3>REGISTER</h3>".html_safe
    when projects_page?
      "<h4>PROJECTS</h4>".html_safe
    when project_page?(@project)
      "<h4>#{@project.name}</h4>".html_safe
    when new_project_page?
      "<h4>NEW PROJECT</h4>".html_safe
    when groups_page?
      "<h4>GROUPS</h4>".html_safe
    when group_page?(@group)
     "<h4>#{@group.name} Projects</h4>".html_safe
    when new_group_page?
      "<h4>NEW GROUP</h4>".html_safe
    when edit_group_page?(@group)
      "<h4>EDIT GROUP</h4>".html_safe
    when edit_user_page?(@user)
      "<h4>EDIT USER</h4>".html_safe
    end
  end

  def navbar_submit
    submit_tag("Log in", form: 'login-form').html_safe if login_page?
    submit_tag("Next", form: 'signup-form').html_safe if signup_page?
    submit_tag("Edit", form: 'signup-form').html_safe if edit_user_page?(@user)
  end
end