class User < ActiveRecord::Base
  has_many :subs, foreign_key: :moderator_id
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :commenter_id
  
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
    
  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    (user && user.is_password?(password)) ? user : nil
  end
  
  attr_reader :password
  after_initialize :ensure_session_token
  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    save!
    self.session_token
  end

  private
  
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

end
