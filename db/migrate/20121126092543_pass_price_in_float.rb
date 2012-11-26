class PassPriceInFloat < ActiveRecord::Migration
  def up
    change_table "action_posts" do |t|
      t.change(:price, :decimal, :precision => 8, :scale => 2)
    end

    
  end

  def down
  end
end
