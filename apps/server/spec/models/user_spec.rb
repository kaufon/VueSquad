require "rails_helper"

RSpec.describe User, type: :model do
  describe "callback" do
    it "should assign an id before creation if id is blank" do
      user = build(:user)
      user.save
      expect(user.id).to(be_present)
    end
  end

  describe "validations" do
    it "validate presence of emai" do
      user = build(:user, email: nil)
      user = expect(user).to_not(be_valid)
    end

    it "vaildates uniqueness of email" do
      user1 = create(:user, email: "joao123")
      user2 = build(:user, name: "pedroca", email: "joao123")
      expect(user2).to_not(be_valid)
    end

    it "validates name presence" do
      user = build(:user, name: nil)
      expect(user).to_not(be_valid)
    end

    it "validates name uniqueness" do
      user = create(:user)
      user2 = build(:user)
      expect(user2).to_not(be_valid)
    end

    it "validates password presence" do
      user = build(:user, password: nil)
      expect(user).to_not(be_valid)
    end

    it "validates password and password corfirmation to be euqal" do
      user = build(:user, password: "123", password_confirmation: "12345")
      expect(user).to_not(be_valid)
    end
  end
end
