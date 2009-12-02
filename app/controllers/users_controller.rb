class UsersController < ApplicationController
  
  before_filter :check_administrator_role,
                :only => [:destroy]
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id]) 
    @items = @user.items.find(:all, :order => 'id DESC').paginate(:per_page => 100, :page => params[:page])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
end
