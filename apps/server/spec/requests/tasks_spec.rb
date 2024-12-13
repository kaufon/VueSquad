require "rails_helper"

RSpec.describe "TasksController", type: :request do
  include(JwtWebToken)
  let!(:user) { create(:user) }
  let!(:squad) { create(:squad, owner: user) }
  let!(:token) { jwt_encode(id: user.id) }
  describe "GET /tasks" do
    it "works! (now write some real specs)" do
      get(tasks_path, headers: { Authorization: "Bearer #{token}" })
      expect(response).to(have_http_status(200))
    end

    it "should return only return 10 tasks" do
      create_list(:task, 15, squad: squad)
      get(tasks_path, headers: { Authorization: "Bearer #{token}" }, params: { squad_id: squad.id })
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to(eq(10))
    end
  end

end
