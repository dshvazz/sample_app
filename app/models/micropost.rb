class Micropost < ActiveRecord::Base

  # Relationships
  belongs_to :user

  default_scope -> { order('created_at DESC') }

  # Validations
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
end
