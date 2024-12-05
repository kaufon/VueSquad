class SquadsUsers < ApplicationRecord
  belongs_to :user
  belongs_to :squad
  validates :user_id, uniqueness: { scope: :squad_id, message: "User already in squad" }
end
