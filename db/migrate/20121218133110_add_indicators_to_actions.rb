class AddIndicatorsToActions < ActiveRecord::Migration
  def change
    add_column :actions, :has_price, :boolean,default: false
    add_column :actions, :has_place, :boolean,default: false
    add_column :actions, :has_score, :boolean,default: false
    add_column :actions, :has_comment, :boolean,default: false
    add_column :actions, :has_duration, :boolean,default: false
  end
end
