class RenameAssociationTables < ActiveRecord::Migration
  def up
    drop_table :achievements_actions
    create_table :achievements_activities, :id => false do |t|
      t.references :achievement
      t.references :activity
    end
    add_index :achievements_activities, [:achievement_id, :activity_id]
    add_index :achievements_activities, [:activity_id, :achievement_id]
    rename_column :action_posts, :action_id, :activity_id
    
  end

  def down
    drop_table :achievements_activities
    create_table :achievements_actions, :id => false do |t|
      t.references :achievement
      t.references :action
    end
    add_index :achievements_actions, [:achievement_id, :action_id]
    add_index :achievements_actions, [:action_id, :achievement_id]
    rename_column :action_posts, :activity_id, :action_id  
  end
end
