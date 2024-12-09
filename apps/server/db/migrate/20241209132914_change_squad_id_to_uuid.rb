class ChangeSquadIdToUuid < ActiveRecord::Migration[8.0]
  def change
    create_table(:squads_new, id: :string) do |t|
      t.string(:name)
      t.references(:owner, index: true, foreign_key: { to_table: :users })
      t.timestamps
    end

    drop_table(:squads)
    rename_table(:squads_new, :squads)
  end
end
