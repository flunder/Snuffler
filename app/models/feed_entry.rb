# works well with
# FeedEntry.update_from_feed("http://www.fatplanet.com.au/blog/?feed=rss2&cat=5")
# FeedEntry.update_from_feed("http://www.69submit.com/rss/softcore.xml")

require 'rubygems'
require 'scrapi'
require 'open-uri'

class FeedEntry < ActiveRecord::Base

  has_attached_file :photo, :styles => { :small => "150x150>" },
                    :url  => "/assets/products/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

  #validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  def self.update_from_feed(feed_url)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    
    feed.entries.each do |entry| 
      puts entry.url
      
      images = (Scraper.define do
        array :urls
        process "a", :urls => "@href" #sometimes "img", :urls => "@src" 
        result :urls
      end).scrape(open(entry.url).read)
 
      puts 'found images:'  
      puts images.size;
      
      images.each do |imagePath| 
        puts "path: #{imagePath}"
        puts "name: #{entry.url}"
        
        currentBaseUrl = entry.url[0..entry.url.rindex('/')]
        currentFullUrl = currentBaseUrl << imagePath
        
        unless exists? :url => imagePath
          puts 'some new ones!'
          # feedDB entry
          create(
            :url        => currentFullUrl
          )
          
          # item entry
          Item.create(
            :image_url        => currentFullUrl,
            :image_remote_url => currentFullUrl
          )        
          
          
        end
      end
      
    end
    
    puts '###done----------------!'

  end
  
end