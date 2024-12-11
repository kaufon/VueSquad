class CorrectTypes < ActiveRecord::Migration[8.0]
  def change
    change_column :tasks,:description, :text
    change_column :tasks_users,:task_id,:string
    change_column :tasks_users,:user_id,:string
  end
end
