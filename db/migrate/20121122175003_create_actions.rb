class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :name
      t.string :category
      t.string :pic_path
      
      t.timestamps
    end
  end
end
