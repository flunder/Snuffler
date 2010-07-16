class UsersController < ApplicationController
  
  before_filter :check_administrator_role,
                :only => [:destroy]
  before_filter :getThumbnailSize
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id]) 
    
    if logged_in? && current_user.id == @user.id 
      @itsmyAccount = true
    end   
    
    # Added items
    @items = @user.items.find(:all, :order => 'id DESC').paginate(:per_page => 100, :page => params[:page])
    
    # Favoured items
    @collectionArray = Array.new() 
    @collectionItemIDs = Collection.find(:all, :conditions => "user_id = '#{@user.id}'") 
    
    @collectionItemIDs.each do |collectionItem|
  	  @collectionArray.push(Item.find_by_id(collectionItem.item_id))
    end
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
