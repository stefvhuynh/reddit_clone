class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :author_id
  has_many :comments
  has_many :post_subs
  has_many :subs, through: :post_subs, source: :sub
  has_many :votes, as: :votable
  
  validates :title, :author_id, presence: true
  
  def comments_by_parent_id
    comments_by_parent_id = Hash.new { |hash, key| hash[key] = [] } 
    
    comments.includes(:commenter, :votes).each do |comment|
      comments_by_parent_id[comment.parent_comment_id] << comment
    end
    
    sort_comments_by_vote_score(comments_by_parent_id)
  end
  
  def sort_comments_by_vote_score(comments_hash)
    comments_hash.each do |parent_id, children|
      children.sort! do |comment1, comment2| 
        comment2.vote_score <=> comment1.vote_score 
      end
    end
  end
  
  def vote_score
    votes.inject(0) { |sum, vote| sum += vote.value }
  end
  
end