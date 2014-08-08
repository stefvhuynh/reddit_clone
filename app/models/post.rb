class Post < ActiveRecord::Base
  belongs_to :sub
  belongs_to :author, class_name: "User", foreign_key: :author_id
  has_many :comments
  
  has_many(
    :top_level_comments,
    lambda { where(parent_comment_id: nil) },
    class_name: "Comment"
  )
  
  validates :title, :sub_id, :author_id, presence: true
end
