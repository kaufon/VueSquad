class CreateJoinTableUsersSquads < ActiveRecord::Migration[8.0]
  def change
    create_join_table(:users, :squads) do |t|
      t.index([ :user_id, :squad_id ])
      t.index([ :squad_id, :user_id ])
    end
  end
end
