xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  
  xml.channel{
    
    xml.title("Snuffler")
    xml.description("Snuffed up stuff feed")
    xml.language('en-us')
    
      for item in @items
        xml.item do
          xml.title(item.name)
          xml.description(image_tag(item.photo.url(:thumb)) << '<br/>' << item.blurber)
          xml.author("Snuffler")               
          xml.pubDate(item.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))          
          xml.link url_for :only_path => false, :controller => 'items', :action => 'show', :id => item.id
          xml.guid url_for :only_path => false, :controller => 'items', :action => 'show', :id => item.id  
        end
      end
  }
  
}
