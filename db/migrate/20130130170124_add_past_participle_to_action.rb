class AddPastParticipleToAction < ActiveRecord::Migration
  def change
    add_column :actions, :past_participle, :string
  end
end
