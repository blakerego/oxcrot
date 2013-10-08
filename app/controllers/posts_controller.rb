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
    require 'digest/md5' #needed for comments
    post_id = params[:id]
    @post = JSON.parse(query_api_via_get("#{site_url}/posts/#{post_id}").body)
    @comments = Comment.comments_for_post_id(post_id)
  end

  def site_url
    return "https://public-api.wordpress.com/rest/v1/sites/#{ENV['WORDPRESS_SITE_ID']}"
  end

  def comment
    comment = Comment.new(comment_params)
    if (comment.save)
      render :partial => '/comments/comment', :layout => false, :locals => {:comment => comment}
    else
      render :json => comemnt.errors
    end
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

    def comment_params
      params.require(:comment).permit(:name, :email, :content, :post_id)
    end

end