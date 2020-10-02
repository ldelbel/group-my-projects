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
end