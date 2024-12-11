class CorrectCreatorName < ActiveRecord::Migration[8.0]
  def change
    rename_column(:tasks, :creator_id, :creator_id_id)
    rename_column(:tasks, :creator_id_id, :creator_id)
  end
end
