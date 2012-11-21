class AddPublicToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :public, :boolean,:default => false
  end
end
