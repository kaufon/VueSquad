class User < ApplicationRecord
  before_create :assign_id
  has_and_belongs_to_many :squads
  has_and_belongs_to_many :tasks
  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  private
  def assign_id
    self.id = SecureRandom.uuid if self.id.blank?
  end
end
