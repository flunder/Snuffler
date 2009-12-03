class ItemsController < ApplicationController
  
  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]
  
  def index
      #experimental limit for later to stop loading all items at once
      @items = Item.find(:all, :order => 'id DESC', :limit => 50).paginate(:per_page => 50, :page => params[:page])
    
      if request.xhr?
         sleep(3) 
         render :partial => @items
      else 
        respond_to do |format|
          format.html 
          format.rss 
          format.xml { render :xml => @item }
        end
      end
   end
  

  def show
    @item = Item.find(params[:id])

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
        format.html { redirect_to(items_url) }
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
end
