class TagsController < ApplicationController

  def show
    @category = params['id']
    @posts = WordpressConnection.get_post_by_category(@category) if @category.present?
  end

end