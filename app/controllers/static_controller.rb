class StaticController < ApplicationController

  def known_pages
    return ['about', 'contact', 'resources']
  end

  def pages
    slug = params[:slug]

    if known_pages.include?(slug)
      render "static/#{slug}"
    else
      get_post_from_slug(slug)
    end
  end

  def get_post_from_slug(slug)
    url = "#{site_url}/posts/slug:#{slug}"
    response = query_api_via_get(url)
    if (response.present?)
      @post = JSON.parse(query_api_via_get(url).body)
      @title = @post['title']
      post_id = ['ID']
      @comments = Comment.comments_for_post_id(post_id)
      render "/posts/show"
    else
      render "static/#{slug}"
    end
  end
  
end