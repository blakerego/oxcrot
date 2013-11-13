module FlickrConnection

  extend ActiveSupport::Concern
  extend FlickrJsonParser

  def self.site_url
    return "http://api.flickr.com/services"
  end

  def self.initialize(path = "", expires_in=6.hours)
    include FlickrJsonParser
    Rails.cache.fetch("#{path}", :expires_in => expires_in) do
      connection = Faraday.new(:url => "#{FlickrConnection.site_url}#{path}") do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.headers['Content-Type'] = 'application/json'
      end
      response = connection.get
      response.body
      FlickrConnection.parse(response.body)
    end
  end

  def self.feed(tags)    
    return nil if !tags.present?
    if tags.kind_of?(Array)
      tag_string = tags.join(",")
    else
      tag_string = tags
    end
    path = "/feeds/photos_public.gne?format=json&id=23824747@N07&tags=#{tag_string}"
    FlickrConnection.initialize(path)
  end

end