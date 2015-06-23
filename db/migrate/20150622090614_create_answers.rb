class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.boolean :correct
      t.string :content
      t.references :word

      t.timestamps null: false
    end
  end
end
