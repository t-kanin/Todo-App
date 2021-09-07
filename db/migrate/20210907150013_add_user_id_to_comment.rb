class AddUserIdToComment < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :user_id, :int
    add_column :comments, :task_id, :int
  end
end
