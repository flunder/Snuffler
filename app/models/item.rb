require 'open-uri'

class Item < ActiveRecord::Base

  belongs_to :user
  acts_as_taggable_on :tags
    
  # Paperclip
  has_attached_file :photo,
    :styles => {
      :thumb =>  ["100x100#", :png],
      :medium => ["200x200#", :png],
      :large =>  ["700x700>", :png]},
    :path => ":rails_root/public/images/items/:id/:style/:basename.:extension",
    :url  => "/images/items/:id/:style/:basename.:extension",
    :default_url => "/images/empty.gif"      
      
  attr_accessor :image_url
  attr_accessor :image_remote_url
  
  validates_presence_of :name
  before_create :dblcheck_file_name
  
  #has_attached_file :image
  before_validation :download_remote_image, :if => :image_url_provided?
  validates_presence_of :image_remote_url, :if => :image_url_provided?, :message => 'is invalid or inaccessible'

  private
  
    def dblcheck_file_name
      #some fallback mechanism to fix the nofilename issue
      if photo_file_name.nil?
        self.photo.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex(16)}.png")
      end
    end

    def image_url_provided?
      !self.image_url.blank?
    end

    def download_remote_image
      self.photo = do_download_remote_image
      self.image_remote_url = image_url
    end

    def do_download_remote_image
      io = open(URI.parse(image_url))
      def io.original_filename; base_uri.path.split('/').last; end
      io.original_filename.blank? ? nil : io
    rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  end

end
