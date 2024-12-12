require "rails_helper"

RSpec.describe "UsersController", type: :request do
  include(JwtWebToken)
  describe "GET /users" do
    it "works! " do
      get(users_path)
      expect(response).to(have_http_status(200))
    end

    it "should only return 10 items" do
      get(users_path)
      expect(response.body.length).to(be < 10)
    end
  end

  describe "GET /users/id" do
    let!(:user) { create(:user) }
    let!(:token) { jwt_encode(id: user.id) }
    it "works" do
      get(user_path(user.id), headers: { Authorization: "Bearer #{token}" })
      expect(response).to(have_http_status(200))
    end

    it "returns the correct user" do
      get(user_path(user.id), headers: { Authorization: "Bearer #{token}" })
      expect(JSON.parse(response.body)["id"]).to(eql(user.id))
    end

    it "  should not return an  user" do
      get(user_path(123), headers: { Authorization: "Bearer #{token}" })
      expect(JSON.parse(response.body)).to(be_nil)
    end
  end
end
