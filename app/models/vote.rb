class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  
  validates :votable_id, :votable_type, presence: true
  validates :value, presence: true, inclusion: { in: [-1, 1] }
  
end
