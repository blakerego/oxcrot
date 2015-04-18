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
    response = WordpressConnection.get_post_by_slug(slug)
    if (response.present?)
      @post = response
      @title = @post['title']
      post_id = @post['ID']
      @comments = Comment.comments_for_post_id(post_id)
      render "/posts/show"
    else
      render "static/#{slug}"
    end
  end
  
end