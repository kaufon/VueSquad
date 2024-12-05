class ChangeSquadColumnName < ActiveRecord::Migration[8.0]
  def change
    rename_column :squads,:owner_id_id,:owner_id
  end
end
