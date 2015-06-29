class Lesson < ActiveRecord::Base
  before_save :sum_correct

  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :words, through: :results

  validates :category_id, presence: true
  validates :user_id, presence: true

  scope :total_word, ->(category, user){where("category_id = ?", category.id).
    where("user_id = ?", user.id).sum("correct_total")}
  scope :order_desc, ->{order created_at: :DESC}
  scope :lesson_learned, ->user{where("user_id = ?", user.id)}
  scope :follow_learned, ->user{where("user_id IN (
    SELECT followed_id FROM relationships WHERE follower_id = #{user.id}) OR user_id = ?", user.id)}

  accepts_nested_attributes_for :results, allow_destroy: true

  private
  def add_words_to_lesson
    Word.random(user: user).each do |word|
      results.create word: word
    end
  end

  def sum_correct
    self.correct_total = results.select do |result|
      result.answer == result.word.answers.find_by(correct: true)
    end.count
  end
end

