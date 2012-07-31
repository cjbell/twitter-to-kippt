class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :twitter_uid
      t.string :twitter_username
      t.string :kippt_username
      t.string :twitter_token
      t.string :kippt_token
      t.integer :last_tweet_id

      t.timestamps
    end
  end
end
