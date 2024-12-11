class TasksUser < ApplicationRecord
  belongs_to :user
  belongs_to :task
  validates :user_id, uniqueness: { scope: :task_id, message: "User already attributed to task" }
  validate :check_if_user_in_squad
  private
  def check_if_user_in_squad
    unless user.squads.include?(task.squad) || task.squad.owner_id == user.id
      errors.add(:user, "must be part of the task's squad")
    end
  end
end
