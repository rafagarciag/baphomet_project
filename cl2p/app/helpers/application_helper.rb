module ApplicationHelper

#The following three methods are for Devise sign up/sign in from anywhere in 8copy, not just on the views controlled by Devise
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
