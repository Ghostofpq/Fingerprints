class CreateActionPosts < ActiveRecord::Migration
  def change
    create_table :action_posts do |t|
      t.integer :user_id
      t.integer :action_id

      t.date :start_date
      t.date :end_date

      t.string :comment
      t.string :place
      
      t.integer :score
      t.integer :price
      
      t.timestamps
    end
  end
end
