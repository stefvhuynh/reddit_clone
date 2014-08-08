class Sub < ActiveRecord::Base
  belongs_to :moderator, class_name: "User", foreign_key: :moderator_id
  has_many :posts
  has_many :comments, through: :posts, source: :comments
  
  validates :name, :moderator_id, presence: true
end
