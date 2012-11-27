class ChangeDateToDatetime < ActiveRecord::Migration
  def up
    change_table "action_posts" do |t|
      t.change(:start_date, :datetime)
      t.change(:end_date, :datetime)
    end
  end

  def down
  end
end
