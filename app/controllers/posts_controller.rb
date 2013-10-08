class PostsController < ApplicationController

  def index
    data = query_api_via_get("#{site_url}/posts")
    parsed = JSON.parse(data.body)
    @posts = parsed['posts']
  end

  def single_posts
    url = params['url']
    data = query_api_via_get(url)
  end

  def show
    @post = JSON.parse(query_api_via_get("#{site_url}/posts/#{params[:id]}").body)
  end

  def site_url
    return "https://public-api.wordpress.com/rest/v1/sites/#{ENV['WORDPRESS_SITE_ID']}"
  end

  def comment
    comment_params = {:content => params['comment']['text']}
    url = "#{site_url}/posts/#{params[:id]}/replies/new"
    response = query_api_via_post(url, comment_params)
    # binding.pry
    render :json => response.body
  end


  private
    def query_api_via_get(url, expires_in=6.hours)
      Rails.cache.fetch("#{url}", :expires_in => expires_in) do
        begin
          require 'net/http'
          uri = URI.parse(URI.encode(url.strip))
          result = Net::HTTP.get_response(uri)        
        rescue Exception => e
          ""
        end
      end
    end

    def query_api_via_post(url, options)
      begin
        require 'net/http'
        uri = URI.parse(URI.encode(url.strip))
        result = Net::HTTP.post_form(uri, options)        
      rescue Exception => e
        ""
      end      
    end

end