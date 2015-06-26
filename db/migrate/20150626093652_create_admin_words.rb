class CreateAdminWords < ActiveRecord::Migration
  def change
    create_table :admin_words do |t|
      t.string :content
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
