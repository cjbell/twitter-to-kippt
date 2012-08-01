class ChangeTwitterIdToStringOnUsers < ActiveRecord::Migration
  def up
    change_column :users, :last_tweet_id, :string
  end

  def down
  end
end