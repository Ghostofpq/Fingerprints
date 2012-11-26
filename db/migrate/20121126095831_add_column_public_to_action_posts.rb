class AddColumnPublicToActionPosts < ActiveRecord::Migration
  def change
    add_column "action_posts", :public, :boolean, default: false
  end
end
