class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy

  scope :total_word, ->(category,user){where("category_id = ?", category.id).
    where("user_id = ?",user.id).sum("correct_total")}
end
