class CreateActionPosts < ActiveRecord::Migration
  def change
    create_table :action_posts do |t|

      t.timestamps
    end
  end
end
