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
    @post = WordpressConnection.get_post_by_id(post_id)
    @title = @post['title']
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

  def navigation_links

    post_id = params[:id]

    if params[:date].present?
      date = params[:date]
    else
      post = WordpressConnection.get_post_by_id(post_id)
      date = post['date']
    end

    @previous_post = WordpressConnection.get_previous_post(date, post_id)
    @next_post = WordpressConnection.get_next_post(date, post_id)
    
    if @previous_post.present?
      @previous_post_title = HTMLEntities.new.decode @previous_post['title']
      @previous_post_link = root_url + @previous_post['slug']
    end

    if @next_post.present?
      @next_post_title = HTMLEntities.new.decode @next_post['title']
      @next_post_link = root_url + @next_post['slug']
    end

    render :partial =>  'navigation_links', :layout => false
  end


  private

    def comment_params
      params.require(:comment).permit(:name, :email, :content, :post_id)
    end

end