class Sub < ActiveRecord::Base
  belongs_to :moderator, class_name: "User", foreign_key: :moderator_id
  has_many :comments, through: :posts, source: :comments
  has_many :post_subs, inverse_of: :post
  has_many :posts, through: :post_subs, source: :post
  
  validates :name, :moderator_id, presence: true
end
