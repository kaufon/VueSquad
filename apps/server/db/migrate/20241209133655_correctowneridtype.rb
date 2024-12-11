class Correctowneridtype < ActiveRecord::Migration[8.0]
  def change
    change_column :squads, :owner_id, :string
  end
end
