class RenameActionToActivity < ActiveRecord::Migration
  def up
    rename_table :actions, :activities
  end

  def down
    rename_table :activities, :actions
  end
end
