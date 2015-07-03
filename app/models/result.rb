class Result < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :answer

  scope :not_answered, ->{where(answer: nil)}
  scope :answered, ->{where.not(answer: nil)}
  scope :right_answers, ->{includes(:answer).where.not(answers: {correct: false, correct: nil})}
  scope :final, ->user: user, category: nil do
    return unless category
    lessons = category.lessons.lesson_learned(user)
    where(lesson: lessons).includes(:word, :answer)
  end

  def update_answer answer_id: nil
    answer = Answer.find_by id: answer_id
    return unless answer && self.update_attributes(answer: answer)
    self.next_result
  end

  def next_result
    results = self.lesson.results.not_answered
    if results.present?
      results.first
    else
      self.lesson.update_attributes active: false
      nil
    end
  end
end
