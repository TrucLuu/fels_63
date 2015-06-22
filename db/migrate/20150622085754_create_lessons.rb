class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :correct_total
      t.references :user
      t.references :category

      t.timestamps null: false
    end
  end
end
