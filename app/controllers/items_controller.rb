class ItemsController < ApplicationController
  
  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]
  before_filter :getThumbnailSize
  
  def index
      #experimental limit for later to stop loading all items at once
      
      @headline = "";
      
      @items = Item.all(
          :include => :user, 
          :order => 'id DESC').paginate(:per_page => 6, :page => params[:page])
    
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
    @items = Item.find_tagged_with(params[:id]).paginate(:per_page => 50, :page => params[:page])
    render :action => 'index'
  end

  def tag_cloud
    @tags = Post.tag_counts_on(:tags)
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
  
  def test
  
  #enable me first!  
    
=begin
    require 'faker'
    
    items = []
    1000.times do 
      items.push [Faker::Name.first_name, Faker::Lorem.paragraph(sentence_count = 3)]
    end
    
    items.each do |item|
      Item.create(
        :name => item[0],
        :photo_file_name => "Bikeshed_London.png",
        :photo_content_type => "image/png",
        :photo_file_size => "3111967",
        :blurber => item[1],
        :from => "www.bikeshd.co.uk",
        :user_id => "2"   
      ) 
    end
    
    @result = items;
=end
  end  
    
  
end
