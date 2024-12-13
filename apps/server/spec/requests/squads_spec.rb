require "rails_helper"

RSpec.describe "SquadsController", type: :request do
  include(JwtWebToken)
  let!(:user) { create(:user) }
  let!(:token) { jwt_encode(id: user.id) }
  describe "GET /squads" do
    it "works!" do
      get(squads_path)
      expect(response).to(have_http_status(200))
    end

    it "should only return 10 items" do
      create_list(:squad, 15)
      get(squads_path)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to(eq(10))
    end
  end

  describe "POST /squads" do
    let!(:squad_request) do
      { name: "Squadzin de cria" }
    end

    it "works!" do
      post(squads_path, headers: { Authorization: "Bearer #{token}" }, params: squad_request)
      expect(response).to(be_successful)
    end

    it "should create an squad with its request" do
      expect { post(squads_path, headers: { Authorization: "Bearer #{token}" }, params: squad_request) }.to(
        change(Squad, :count).by(1)
      )
      expect(response).to(have_http_status(:created))
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["name"]).to(eql("Squadzin de cria"))
    end

    it "should throw an error with request is invalid" do
      modified_request = squad_request.merge(name: nil)
      post(squads_path, headers: { Authorization: "Bearer #{token}" }, params: modified_request)
      expect(response).to_not(be_successful)
    end

    it "should not allow to create wihout token" do
      post(squads_path, params: squad_request)
      expect(response).to(have_http_status(:unauthorized))
    end
  end

  describe "PUT /squads/id" do
    let!(:squad) { create(:squad, owner: user) }
    it "works!" do
      put(squad_path(squad.id), headers: { Authorization: "Bearer #{token}" })
      expect(response).to(be_successful)
    end

    it "should change squad name" do
      put(squad_path(squad.id), headers: { Authorization: "Bearer #{token}" }, params: { name: "Ola squad" })
      expect(response).to(be_successful)
      squad.reload
      expect(squad.name).to(eql("Ola squad"))
    end

    it "should not change of unexisting squad" do
      put(squad_path(123), headers: { Authorization: "Bearer #{token}" }, params: { name: "Ola" })
      expect(response).to(have_http_status(:not_found))
    end

    it "should not allow to change squad if user is not owner" do
      squad = create(:squad, owner: create(:user))
      expect { put(squad_path(squad.id), headers: { Authorization: "Bearer #{token}" }, params: { name: "Ola" }) }.to(
        raise_error(StandardError)
      )
    end
  end

  describe "POST /squads/add" do
    let(:squad) { create(:squad, owner: user) }
    let!(:created_user) { create(:user) }
    let(:create_token) { jwt_encode(id: created_user.id) }
    let(:add_request) do
      { squad_id: squad.id, user_id: created_user.id }
    end

    it "works!" do
      post(add_squads_path, headers: { Authorization: "Bearer #{token}" }, params: add_request)
    end

    it "should add user to squad" do
      post(add_squads_path, headers: { Authorization: "Bearer #{token}" }, params: add_request)
      expect(squad.users).to(include(created_user))
    end

    it "should not allow to add user if not owner" do
      expect { post(add_squads_path, headers: { Authorization: "Bearer #{create_token}" }, params: add_request) }.to(
        raise_error(StandardError, "Incorrect Owner")
      )
    end

    it "should no add to unexisting squad" do
      modified_request = add_request.merge(squad_id: "123")
      expect {
        post(add_squads_path, headers: { Authorization: "Bearer #{token}" }, params: modified_request)
      }
        .to(raise_error(StandardError, "Squad not Found"))
    end

    it "shoud no add if user not exist" do
      modified_request = add_request.merge(user_id: "123")

      expect {
        post(add_squads_path, headers: { Authorization: "Bearer #{token}" }, params: modified_request)
      }
        .to(raise_error(StandardError, "User must exist"))
    end
  end

  describe "DELETE squads/remove" do
    let!(:squad) { create(:squad, owner: user) }
    let!(:created_user) { create(:user) }
    let!(:create_token) { jwt_encode(id: created_user.id) }
    let!(:request) do
      { squad_id: squad.id, user_id: created_user.id }
    end

    before do
      post(add_squads_path, headers: { Authorization: "Bearer #{token}" }, params: request)
    end

    it "works" do
      delete(remove_from_squad_path, headers: { Authorization: "Bearer #{token}" }, params: request)
    end

    it "should remove user from squad" do
      expect(squad.users).to(include(created_user))
      delete(remove_from_squad_path, headers: { Authorization: "Bearer #{token}" }, params: request)
      expect(squad.users).to_not(include(created_user))
    end

    it "should not not remove user if squad doesnt exist" do
      modified_request = request.merge(squad_id: "123")
      expect { delete(remove_from_squad_path, headers: { Authorization: "Bearer #{token}", params: modified_request }) }
        .to(
          raise_error(StandardError, "Squad not Found")
        )
    end

    it "should not not remove user if Incorrect owner  " do
      expect { delete(remove_from_squad_path, headers: { Authorization: "Bearer #{create_token}" }, params: request) }
        .to(
          raise_error(StandardError, "Incorrect Owner")
        )
    end

    it "should not remove user if user doesnt exist" do
      modified_request = request.merge(user_id: "123")
      expect { delete(remove_from_squad_path, headers: { Authorization: "Bearer #{token}" }, params: modified_request) }
        .to(raise_error(StandardError, "User not Found"))
    end

    it "should not remove user if not in squad" do
      new_user = create(:user)
      modified_request = request.merge(user_id: new_user.id)
      expect { delete(remove_from_squad_path, headers: { Authorization: "Bearer #{token}" }, params: modified_request) }
        .to(raise_error(StandardError, "User not in Squad"))
    end
  end

  describe "DELETE /squads/id" do
    let!(:squad) { create(:squad, owner: user) }
    it "works!" do
      delete(squad_path(squad.id), headers: { Authorization: "Bearer #{token}" })
      expect(response).to(be_successful)
    end

    it "should delete squad" do
      delete(squad_path(squad.id), headers: { Authorization: "Bearer #{token}" })
      expect(Squad.find_by(id: squad.id)).to(be_nil)
    end

    it "should not delete if doest exist" do
      expect { delete(squad_path(123), headers: { Authorization: "Bearer #{token}" }) }.to(
        raise_error(StandardError, "Squad not found")
      )
    end

    it "should not delte if not owner" do
      created_user = create(:user)
      created_token = jwt_encode(id: created_user.id)
      expect { delete(squad_path(squad.id), headers: { Authorization: "Bearer #{created_token}" }) }.to(
        raise_error(StandardError, "Incorrect Owner")
      )
    end
  end
end
