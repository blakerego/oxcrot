class PostsController < ApplicationController

  def index
    if params[:page].present?
      @page = params[:page].to_i
    else
      @page = 1
    end
    @next_page = @page + 1
    per_page = 8

    data = query_api_via_get("#{site_url}/posts?page=#{@page.to_s}&number=#{per_page}")
    parsed = JSON.parse(data.body)

    @posts = parsed['posts']

    if request.xhr?
      render :partial => 'posts_preview', :layout => false, :locals => {:posts => @posts}
    end
  end

  def show
    require 'digest/md5' #needed for comments
    post_id = params[:id]
    @post = JSON.parse(query_api_via_get("#{site_url}/posts/#{post_id}").body)
    @comments = Comment.comments_for_post_id(post_id)
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