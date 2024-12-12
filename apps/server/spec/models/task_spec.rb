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

  describe "enums" do
    it "validate status enum" do
      task = build(:task)
      expect(task.status).to(eql("todo"))
      task = build(:task, status: 1)
      expect(task.status).to(eql("inProgress"))
      task = build(:task, status: 2)
      expect(task.status).to(eql("done"))
    end

    it "validate size enum" do
      task = build(:task)
      expect(task.size).to(be_nil)
      task = build(:task, size: 0)
      expect(task.size).to(eql("XS"))
      task = build(:task, size: 1)
      expect(task.size).to(eql("S"))
      task = build(:task, size: 2)
      expect(task.size).to(eql("M"))
      task = build(:task, size: 3)
      expect(task.size).to(eql("L"))
      task = build(:task, size: 4)
      expect(task.size).to(eql("XL"))
    end

    it "validate priority enum" do
      task = build(:task)
      expect(task.priority).to(be_nil)
      task = build(:task, priority: 0)
      expect(task.priority).to(eql("LOW"))
      task = build(:task, priority: 1)
      expect(task.priority).to(eql("MEDIUM"))
      task = build(:task, priority: 2)
      expect(task.priority).to(eql("HIGH"))
    end
  end
end
