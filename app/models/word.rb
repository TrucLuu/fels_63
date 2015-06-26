class Word < ActiveRecord::Base
  has_many :results, dependent: :destroy
  has_many :answers, dependent: :destroy
  belongs_to :category

  accepts_nested_attributes_for :answers,
                                reject_if: lambda {|a| a[:content].blank?},
                                allow_destroy: true
end
