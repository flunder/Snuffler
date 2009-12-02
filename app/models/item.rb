require 'open-uri'

class Item < ActiveRecord::Base

  belongs_to :user

  # Paperclip
  has_attached_file :photo,
    :styles => {
      :thumb => "100x100#",
      :medium => "200x200#",
      :large =>   "700x700>" }
      
  attr_accessor :image_url
  attr_accessor :image_remote_url
  
  validates_presence_of :name
  
  #has_attached_file :image
  before_validation :download_remote_image, :if => :image_url_provided?
  validates_presence_of :image_remote_url, :if => :image_url_provided?, :message => 'is invalid or inaccessible'

  private

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
