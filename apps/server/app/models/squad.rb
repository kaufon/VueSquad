class Squad < ApplicationRecord
  before_create :assign_id
  belongs_to :owner, class_name: "User"
  has_many :tasks
  has_and_belongs_to_many :users

  validates :name, presence: true
  private
  def assign_id
    self.id = SecureRandom.uuid if self.id.blank?
  end
end
