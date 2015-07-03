class Word < ActiveRecord::Base
  has_many :results, dependent: :destroy
  has_many :answers, dependent: :destroy
  belongs_to :category

  accepts_nested_attributes_for :answers,
                                reject_if: lambda {|a| a[:content].blank?},
                                allow_destroy: true

  scope :search, ->content{where(Settings.setting.search, "#{content}%" ) if content.present?}
  scope :learned, ->user{where(Settings.setting.sql_learned, user.id)}
  scope :not_learned, ->user{where(Settings.setting.sql_not_learned, user.id)}
  scope :filter_category, ->category{where category: category if category.present?}
  scope :get_all, ->user{}
  scope :random_words, ->user {Word.not_learned(user).order("random()").limit(20)}

  def self.to_csv options = {}
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |word|
        csv << word.attributes.values_at(*column_names)
      end
    end
  end
end
