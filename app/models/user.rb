class User < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower,
                       dependent: :destroy
  has_secure_password

  validates :name, presence: true, length: {maximum: Settings.length.short_maximum}
  validates :email, presence: true, length: {maximum: Settings.length.long_maximum},
                    format: {with: Settings.VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false},
                    if: "new_record?"
  validates :password, length: {minimum: Settings.length.minimum}, if: "password_set?"

  def password_set?
    new_record? || password.present?
  end

  def User.digest value
    cost = BCrypt::Engine.cost
    cost = ActiveModel::SecurePassword.min_cost if BCrypt::Engine::MIN_COST
    BCrypt::Password.create(value, cost: cost)
  end
end
