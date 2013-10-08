class Comment < ActiveRecord::Base

  def self.comments_for_post_id(post_id)
    Comment.where(:post_id => post_id).order('created_at DESC')
  end

end
