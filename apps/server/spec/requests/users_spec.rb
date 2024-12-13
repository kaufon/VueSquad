require "rails_helper"

RSpec.describe "UsersController", type: :request do
  include(JwtWebToken)
  describe "GET /users" do
    it "works! " do
      get(users_path)
      expect(response).to(be_successful)
    end

    it "should only return 10 items" do
      create_list(:user, 15)
      get(users_path)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to(eq(10))
    end
  end

  describe "GET /users/id" do
    let!(:user) { create(:user) }
    let!(:token) { jwt_encode(id: user.id) }
    it "works" do
      get(user_path(user.id), headers: { Authorization: "Bearer #{token}" })
      expect(response).to(be_successful)
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

  describe "POST /users" do
    let!(:user_request) do
      {
        name: "John Doe",
        email: "prisma@gmail.com",
        password: "123",
        password_confirmation: "123"
      }
    end

    it "works" do
      post(
        users_path,
        params: user_request
      )
      expect(response).to(be_successful)
    end

    it "should create an user with its request" do
      expect { post(users_path, params: user_request) }.to(change(User, :count).by(1))
      expect(JSON.parse(response.body)["name"]).to(eql("John Doe"))
      expect(JSON.parse(response.body)["email"]).to(eql("prisma@gmail.com"))
      expect(JSON.parse(response.body)).to(have_key("password_digest"))
    end

    it "should throw an error if request are not present" do
      modified_request = user_request.merge(name: nil)
      post(users_path, params: modified_request)
      expect(response).to_not(be_successful)
      modified_request = user_request.merge(email: nil)
      post(users_path, params: modified_request)
      expect(response).to_not(be_successful)
      modified_request = user_request.merge(password: nil)
      post(users_path, params: modified_request)
      expect(response).to_not(be_successful)
    end

    it "should throw an error if password and password_confirmation are different" do
      modified_request = user_request.merge(password: "123", password_confirmation: "12344")
      post(users_path, params: modified_request)
      expect(response).to_not(be_successful)
    end
  end

  describe "PUT to /users/id" do
    let!(:user) { create(:user) }
    let!(:token) { jwt_encode(id: user.id) }
    it "works!" do
      put(user_path(user.id), headers: { Authorization: "Bearer #{token}" })
      expect(response).to(be_successful)
    end

    it "should update  user" do
      put(user_path(user.id), headers: { Authorization: "Bearer #{token}" }, params: { name: "Joiajoia" })
      expect(response).to(be_successful)
      user.reload
      expect(user.name).to(eql("Joiajoia"))
    end

    it "should NOT update user" do
      put(user_path(123456), headers: { Authorization: "Bearer #{token}" }, params: { name: "Joiajoia" })
      expect(response).to(have_http_status(:not_found))
    end
  end

  describe "DELETE to /users/id" do
    let!(:user) { create(:user) }
    let!(:token) { jwt_encode(id: user.id) }
    it "works!" do
      delete(user_path(user.id), headers: { Authorization: "Bearer #{token}" })
      expect(response).to(be_successful)
    end

    it "should delete and user" do
      delete(user_path(user.id), headers: { Authorization: "Bearer #{token}" })
      expect(User.find_by(id: user.id)).to(be_nil)
    end

    it "should NOT delete user" do
      delete(user_path(123), headers: { Authorization: "Bearer #{token}" })
      expect(response).to(have_http_status(:not_found))
    end
  end
end
