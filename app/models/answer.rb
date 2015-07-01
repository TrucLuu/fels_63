class Answer < ActiveRecord::Base
  belongs_to :word
  has_many :results, dependent: :destroy

  scope :result_answer, ->lesson{where("id IN (select answer_id from results where lesson_id = ?)",lesson.id)}
end
