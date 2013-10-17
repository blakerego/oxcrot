class PostsController < ApplicationController

  def index
    if params[:page].present?
      @page = params[:page].to_i
    else
      @page = 1
    end
    @next_page = @page + 1
    per_page = 8

    parsed = WordpressConnection.posts(@page, per_page)

    @posts = parsed['posts']

    if request.xhr?
      render :partial => 'posts_preview', :layout => false, :locals => {:posts => @posts}
    end
  end

  def show
    require 'digest/md5' #needed for comments
    post_id = params[:id]
    @post = JSON.parse(query_api_via_get("#{site_url}/posts/#{post_id}").body)
    @title = @post['title']
    @comments = Comment.comments_for_post_id(post_id)

    date = @post['date']
    previous_data = JSON.parse(query_api_via_get("#{site_url}/posts?before=#{date}").body)
    next_data = JSON.parse( query_api_via_get("#{site_url}/posts?after=#{date}").body )
    if previous_data['found'] > 0
      @previous_post_link = root_url + previous_data['posts'].first['slug']
    end

    if next_data['found'] > 0 
      @next_post_link = root_url + next_data['posts'].first['slug']
    end

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

    def comment_params
      params.require(:comment).permit(:name, :email, :content, :post_id)
    end

end