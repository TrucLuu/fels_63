class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy

  scope :total_word, ->(category, user){where("category_id = ?", category.id).
    where("user_id = ?", user.id).sum("correct_total")}
  scope :order_desc, ->{order created_at: :DESC}
  scope :lesson_learned, ->user{where("user_id = ?", user.id)}
  scope :follow_learned, ->user{where("user_id IN (
    SELECT followed_id FROM relationships WHERE follower_id = #{user.id}) OR user_id = ?", user.id)}
end
