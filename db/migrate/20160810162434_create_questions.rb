
# migrations are instructions to change the database structure and you must run rails db:migrate / rails db:rolback in order for these instructions to take effect
class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body

      # this will create 2 timestamp fields: created_at & updated_at
      t.timestamps
    end
  end
end
