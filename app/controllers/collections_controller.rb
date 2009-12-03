class CollectionsController < ApplicationController
  
  def create
    
     @collection = Collection.create(params[:collection]) 
    
     respond_to do |format|
       if @collection.save
         flash[:notice] = 'Item added!'
         format.html { redirect_to(items_url) }
         format.xml  { render :xml => @collection, :status => :created, :location => @collection }

       else
         format.html { render :action => "new" }
         format.xml  { render :xml => @collection.errors, :status => :unprocessable_entity }

       end
     end
       
  end
  
end
