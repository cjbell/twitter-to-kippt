class AddListIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :kippt_list_id, :string
  end
end
