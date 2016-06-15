module ApplicationHelper

  def current_user
    @user = 
     if user && user["errors"]
      nil
     else
      user['data']
     end
  end

  def user
    ServerApi.new.get_user(id: session[:user_id])
  rescue
    nil
  end

  def can_manage_items
    return false if current_user["can-manage"].blank?
    current_user["can-manage"]
  end
end
