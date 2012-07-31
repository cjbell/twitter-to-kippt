class AddLastSyncToUser < ActiveRecord::Migration
  def change
    add_column :users, :time_of_last_sync, :timestamp
  end
end
