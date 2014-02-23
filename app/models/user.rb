class User < ActiveRecord::Base

  # Relationships
  has_many :microposts, dependent: :destroy

  # Setup
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  has_secure_password

  # Callbacks
  before_create :create_remember_token
  before_save { self.email = email.downcase }

  # Validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  # Class methods
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  # Instance methods
  def feed
    # This is preliminary.  See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)
  end

  # Private methods
  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
