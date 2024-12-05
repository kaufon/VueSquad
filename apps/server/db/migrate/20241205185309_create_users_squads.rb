class CreateUsersSquads < ActiveRecord::Migration[8.0]
  def change
    create_table :users_squads do |t|
      t.timestamps
    end
  end
end
