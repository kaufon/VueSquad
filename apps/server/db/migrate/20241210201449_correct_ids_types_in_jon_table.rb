class CorrectIdsTypesInJonTable < ActiveRecord::Migration[8.0]
  def change
    change_column(:squads_users, :user_id, :string)
    change_column(:squads_users, :squad_id, :string)
    drop_table(:users_squads)
  end
end
