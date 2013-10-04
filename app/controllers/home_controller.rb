class HomeController < ApplicationController

  def index
    data = query_api("https://public-api.wordpress.com/rest/v1/sites/#{ENV['WORDPRESS_SITE_ID']}/posts")
    parsed = JSON.parse(data.body)
    @posts = parsed['posts']
  end


  def query_api(url)
    Rails.cache.fetch("#{url}", :expires_in => 6.hours) do
      begin
        require 'net/http'
        uri = URI.parse(URI.encode(url.strip))
        result = Net::HTTP.get_response(uri)        
      rescue Exception => e
        ""
      end
    end
  end

end