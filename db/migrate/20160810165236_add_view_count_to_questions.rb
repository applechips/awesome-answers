class AddViewCountToQuestions < ActiveRecord::Migration[5.0]
  def change
    # add_column is a migration method that takes 3 arguments
    # 1. Table name: 
    add_column :questions,:view_count, :integer
  end
end
