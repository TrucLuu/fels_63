class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :words, through: :results

  validates :category_id, presence: true
  validates :user_id, presence: true
  validate :validate_words

  scope :total_word, ->(category, user){where("category_id = ?", category.id).
    where("user_id = ?", user.id).sum("correct_total")}
  scope :order_desc, ->{order created_at: :DESC}
  scope :lesson_learned, ->user{where(user: user)}
  scope :follow_learned, ->user{where("user_id IN (
    SELECT followed_id FROM relationships WHERE follower_id = #{user.id}) OR user_id = ?", user.id)}

  accepts_nested_attributes_for :results, allow_destroy: true

  before_save :sum_correct
  after_create :set_words

  def validate_words
    if new_record? && category.words.not_learned(user).count < Settings.length.words
      errors.add :base, "Words is not enough"
    end
  end

  private
  def sum_correct
    self.correct_total = results.select do |result|
      result.answer == result.word.answers.find_by(correct: true)
    end.count
  end

  def set_words
    self.category.words.not_learned(self.user).sample(20).each do |word|
      self.results.create word_id: word.id
    end
  end
end

