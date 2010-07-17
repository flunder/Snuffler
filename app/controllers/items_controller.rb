class ItemsController < ApplicationController
  
  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy] #required for certain items?
  before_filter :getThumbnailSize
  
  def index
      #experimental limit for later to stop loading all items at once
      
      @headline = "";
      
      @items = Item.all(
          :include => :user, 
          :order => 'id DESC',
          :conditions => { :private => 0 }
      ).paginate(:per_page => 6, :page => params[:page])
    
      if request.xhr?
         sleep(1) 
         render :partial => @items
      else 
        respond_to do |format|
          format.html 
          format.rss 
          format.xml { render :xml => @item }
        end
      end
   end

  def tag
    @headline = "Tag: #{params[:id]}"
    @items = Item.tagged_with(params[:id]).paginate(:per_page => 50, :page => params[:page])
    render :action => 'index'
  end

  def tag_cloud
    @tags = Post.tag_counts_on(:tags)
  end
  

  def show
    @item = Item.find(params[:id])
    @prevItem = Item.find(:last, :conditions =>  ["id < #{@item.id} and private == 0"])
    @nextItem = Item.find(:first, :conditions =>  ["id > #{@item.id} and private == 0"])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @item }
    end
  end

  def new
    @item = Item.new
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @item }
    end
  end

  def edit
    @item = Item.find(params[:id])
    check_owner(@item)
  end

  def create
    @item = current_user.items.create(params[:item]) 

    respond_to do |format|
      if @item.save
        # add: redirect_to photos_path
        flash[:notice] = 'Item was successfully created.'
        format.html { redirect_to(items_url) }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @item = Item.find(params[:id])
    check_owner(@item)

    respond_to do |format|
      if @item.update_attributes(params[:item])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(request.request_uri) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    check_owner(@item)

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end
  
  def getnextitem 
    
    if request.xhr?       
      
      @item = Item.all(:limit => 1)
      itemHTML = 'x'
      
      respond_to do |format| 
        format.js { render(:partial => 'js/nextitem', :collection => @item) } 
      end      
    end

  end  
    
  
end
