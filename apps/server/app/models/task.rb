class Task < ApplicationRecord
  enum :status, { todo: 0, inProgress: 1, done: 2 }
  enum :size, { XS: 0, S: 1, M: 2, L: 3, XL: 4 }, prefix: true, allow_nil: true
  enum :priority, { LOW: 0, MEDIUM: 1, HIGH: 2 }, prefix: true, allow_nil: true
  before_create :assign_id
  belongs_to :creator, class_name: "User"
  belongs_to :squad
  has_and_belongs_to_many :users
  validates :name, presence: true
  private
  def assign_id
    self.id = SecureRandom.uuid if self.id.blank?
  end
end
