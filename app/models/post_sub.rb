class PostSub < ActiveRecord::Base
  belongs_to :post, inverse_of: :post_subs
  belongs_to :sub
  
  validates :post, :sub_id, presence: true
end
