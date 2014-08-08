class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :commenter, class_name: "User", foreign_key: :commenter_id
  
  belongs_to(
    :parent_comment, 
    class_name: "Comment", 
    foreign_key: :parent_comment_id
  )
  
  has_many(
    :child_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id
  )
  
  validates :content, :commenter_id, :post_id, presence: true
end
