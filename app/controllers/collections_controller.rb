class CollectionsController < ApplicationController
  
  def new
  end
  
  def create
     flash[:notice] = "Called create"
     redirect_to root_url
  end
  
end
