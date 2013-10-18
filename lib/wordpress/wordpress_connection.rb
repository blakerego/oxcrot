module WordpressConnection
  
  extend ActiveSupport::Concern

  def self.site_url
    return "https://public-api.wordpress.com/rest/v1/sites/#{ENV['WORDPRESS_SITE_ID']}"
  end

  def self.initialize(path = "", expires_in=6.hours)
    Rails.cache.fetch("#{path}", :expires_in => expires_in) do
      connection = Faraday.new(:url => "#{WordpressConnection.site_url}#{path}") do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.headers['Content-Type'] = 'application/json'
      end
      response = connection.get
      JSON.parse(response.body)
    end
  end

  def self.posts(page=1, per_page=8)
    path = "/posts?page=#{page.to_s}&number=#{per_page}"
    WordpressConnection.initialize(path)
  end

  def self.get_post_by_slug(slug)
    path = "/posts/slug:#{slug}"
    WordpressConnection.initialize(path)
  end

  def self.get_post_by_id(post_id)
    path = "/posts/#{post_id}"
    WordpressConnection.initialize(path)
  end

  def self.get_previous_post(date, post_id)
    date = DateTime.parse(date).strftime('%F')
    path = "/posts?before=#{date}&order_by=date&order=DESC"
    posts_response = WordpressConnection.initialize(path)
    WordpressConnection.get_first_different_post(post_id, posts_response)
  end

  def self.get_next_post(date, post_id)
    date = DateTime.parse(date).strftime('%F')
    path = "/posts?after=#{date}&order_by=date&order=ASC"
    posts_response = WordpressConnection.initialize(path)
    WordpressConnection.get_first_different_post(post_id, posts_response)
  end

  def self.get_first_different_post(post_id,posts_response)
    return nil if posts_response['found'] <= 0 
    posts_response['posts'].each do |p|
      if p['ID'].to_s != post_id
        return p
      end
    end
    nil
  end

end
