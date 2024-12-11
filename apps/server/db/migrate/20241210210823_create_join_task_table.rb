class CreateJoinTaskTable < ActiveRecord::Migration[8.0]
  def up
    create_join_table(:users, :tasks) do |t|
      t.index([ :user_id, :task_id ])
      t.index([ :task_id, :user_id ])
    end
  end

  def down
    drop_table(:tasks_users)
  end
end
