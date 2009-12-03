class CollectionsController < ApplicationController
  
  def create
    
     @collection = Collection.find_or_create_by_item_id_and_user_id(params[:collection]) 
    
     #@collection = Collection.create(params[:collection]) 
     
     #@collection = Collection.create(:conditions => { :user_id => params[:user_id], :item_id => params[:item_id]}) 
     #membership = Membership.find(:first, :conditions => { :user_id => params[:membership][:user_id], :neighbourhood_id =>  params[:membership][:neighbourhood_id]})
    
     respond_to do |format|
       if @collection.save
         flash[:notice] = 'Added to favs!'
         format.html { redirect_to(root_url) }
         format.xml  { render :xml => @collection, :status => :created, :location => @collection }
       else
         flash[:notice] = 'Sorry, something happened!'
         #format.html { render :action => "new" }
         format.xml  { render :xml => @collection.errors, :status => :unprocessable_entity }
       end
     end
       
  end
  
end
