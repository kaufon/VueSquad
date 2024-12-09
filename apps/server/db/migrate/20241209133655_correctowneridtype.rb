class Correctowneridtype < ActiveRecord::Migration[8.0]
  def change
    rename_column :squads, :owner_id_id, :owner_id

    # Change the column type to string
    change_column :squads, :owner_id, :string
  end
end
