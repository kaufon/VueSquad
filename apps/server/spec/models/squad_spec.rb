require "rails_helper"

RSpec.describe Squad, type: :model do
  describe "callbacks" do
    it "should assign id if id is nil" do
      squad = build(:squad)
      expect(squad.id).to(be_nil)
      squad.save
      expect(squad.id).to(be_present)
    end
  end

  describe "validations" do
    it "should validate name presence" do
      squad = build(:squad, name: nil)
      expect(squad).to_not(be_valid)
    end
  end
end
