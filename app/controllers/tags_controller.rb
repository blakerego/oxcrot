class TagsController < ApplicationController

  def show
    @category = params['id']
    @posts = WordpressConnection.get_post_by_category(@category) if @category.present?
    @flickr_response = FlickrConnection.feed(@category)
    @flickr_items = @flickr_response['items']
  end

end