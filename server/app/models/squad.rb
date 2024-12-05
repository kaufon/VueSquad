class Squad < ApplicationRecord
  belongs_to :owner, class_name: "User", optional: true
  has_and_belongs_to_many :users, class_name: "User", join_table: "squads_users"

  validates :name, presence: true
end
