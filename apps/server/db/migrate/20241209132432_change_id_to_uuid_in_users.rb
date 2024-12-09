class ChangeIdToUuidInUsers < ActiveRecord::Migration[8.0]
  def change
    # Create a new table with UUIDs (string type for id)
    create_table(:users_new, id: :string) do |t|
      t.string(:name)
      t.string(:email)
      t.string(:password_digest)
      t.timestamps
    end

    # Copy data from the old table to the new table
    execute(
      <<-SQL
      INSERT INTO users_new (id, name, email, password_digest, created_at, updated_at)
      SELECT id, name, email, password_digest, created_at, updated_at FROM users;
      SQL
    )

    # Drop the old table
    drop_table(:users)

    # Rename the new table to the original name
    rename_table(:users_new, :users)
  end
end
