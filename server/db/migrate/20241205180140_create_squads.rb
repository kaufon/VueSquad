class CreateSquads < ActiveRecord::Migration[8.0]
  def change
    create_table(:squads) do |t|
      t.references(:owner_id, index: true, foreign_key: { to_table: :users })
      t.string(:name)

      t.timestamps
    end
  end
end
