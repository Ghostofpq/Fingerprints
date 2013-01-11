class CreateAchievementsActionsTable < ActiveRecord::Migration
  def up
    create_table :achievements_actions, :id => false do |t|
      t.references :achievement
      t.references :action
    end
    add_index :achievements_actions, [:achievement_id, :action_id]
    add_index :achievements_actions, [:action_id, :achievement_id]
  end

  def down
    drop_table :achievements_actions
  end
end
