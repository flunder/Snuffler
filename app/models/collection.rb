class Collection < ActiveRecord::Base
   belongs_to :user
   has_many :items
   
   def self.find_or_create opts
     first(:conditions => opts) || create(opts)
   end
   
end
