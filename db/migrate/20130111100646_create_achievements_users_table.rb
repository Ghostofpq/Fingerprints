class CreateAchievementsUsersTable < ActiveRecord::Migration
  def up
    create_table :achievements_users, :id => false do |t|
      t.references :achievement
      t.references :user
    end
    add_index :achievements_users, [:achievement_id, :user_id]
    add_index :achievements_users, [:user_id, :achievement_id]
  end

  def down
    drop_table :achievements_users
  end
end
