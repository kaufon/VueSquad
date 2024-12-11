class CreateTask < ActiveRecord::Migration[8.0]
  def up
    create_table(:tasks, id: :string) do |t|
      t.references(:squads, type: :string, null: false, foreign_key: true)
      t.references(:creator, type: :string, index: true, foreign_key: { to_table: :users })
      t.date(:deadline)
      t.string(:name)
      t.string(:description)
      t.integer(:size)
      t.integer(:status)
      t.timestamps
    end
  end

  def down
    drop_table(:tasks)
  end
end
