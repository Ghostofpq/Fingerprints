class RenameColumnDescToContent < ActiveRecord::Migration
  def change
    rename_column "microposts", :desc, :content
  end
end
