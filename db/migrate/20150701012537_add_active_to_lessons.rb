class AddActiveToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :active, :boolean
  end
end
