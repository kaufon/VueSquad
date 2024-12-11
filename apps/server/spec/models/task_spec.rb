require "rails_helper"

RSpec.describe Task, type: :model do
  describe "callback" do
    it "should assign id after creation" do
      task = build(:task)
      expect(task.id).to(be_nil)
      task.save
      expect(task.id).to(be_present)
    end
  end

  describe "validations" do
    it "validate name presence" do
      task = build(:task, name: nil)
      expect(task).to_not(be_valid)
    end
  end
end
