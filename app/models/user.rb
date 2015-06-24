class User < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  before_save {self.email = email.downcase}

  validates :name, presence: true, length: {maximum: Settings.setting.maximum_length_name}
  validates :email, presence: true, length: {maximum: Settings.setting.maximum_length_email},
                    format: {with: Settings.setting.VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.setting.minimum_length_password}

  has_secure_password
end
