# This module is included in your application controller which makes
# several methods available to all controllers and views. Here's a
# common example you might add to your application layout file.
# 
#   <% if logged_in? %>
#     Welcome <%=h current_user.username %>! Not you?
#     <%= link_to "Log out", logout_path %>
#   <% else %>
#     <%= link_to "Sign up", signup_path %> or
#     <%= link_to "log in", login_path %>.
#   <% end %>
# 
# You can also restrict unregistered users from accessing a controller using
# a before filter. For example.
# 
#   before_filter :login_required, :except => [:index, :show]
module Authentication
  def self.included(controller)
    controller.send :helper_method, :current_user, :logged_in?, :redirect_to_target_or_default
    controller.filter_parameter_logging :password
  end
  
  def current_user
    # quick check if the user that is logged in really exist!?
    if User.exists?(session[:user_id]) 
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end
  
  def logged_in?
    current_user
  end
  
  def login_required
    unless logged_in?
      flash[:error] = "Please sign in first."
      store_target_location
      redirect_to login_url
    end
  end
  
  def redirect_to_target_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def check_role(role)
    unless logged_in? && @current_user.has_role?(role)
      flash[:error] = "You do not have the permission to do that."
      store_target_location
      redirect_to login_url
    end
  end

  def check_administrator_role
    check_role('Admin')
  end
  
  def check_owner(item)
    if item.user.id != current_user.id
      redirect_to root_url
      flash[:notice] = 'Hey, you didnt snuffle that.'
    end
  end
  
  private
  
  def store_target_location
    session[:return_to] = request.request_uri
  end

end
