class AddColumnsToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :name, :string
    add_column :lessons, :content, :string
    add_column :lessons, :image, :string
  end
end
