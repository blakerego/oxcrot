class Comment < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :content, presence: true
  def self.comments_for_post_id(post_id)
    Comment.where(:post_id => post_id).order('created_at DESC')
  end

end
