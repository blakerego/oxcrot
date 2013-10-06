class PostsController < ApplicationController

  def index
    data = query_api("#{site_url}/posts")
    parsed = JSON.parse(data.body)
    @posts = parsed['posts']
  end

  def single_posts
    url = params['url']
    data = query_api(url)
  end

  def show
    @post = JSON.parse(query_api("#{site_url}/posts/#{params[:id]}").body)
  end

  def site_url
    return "https://public-api.wordpress.com/rest/v1/sites/#{ENV['WORDPRESS_SITE_ID']}"
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