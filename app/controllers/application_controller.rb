class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def site_url
    return "https://public-api.wordpress.com/rest/v1/sites/#{ENV['WORDPRESS_SITE_ID']}"
  end

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

  def render_title
    if defined?(@title)
      return @title
    else
      return "Happily Adrift"
    end
  end
  helper_method :render_title


end
