require "rails_helper"

RSpec.describe "TasksController", type: :request do
  include(JwtWebToken)
  let!(:user) { create(:user) }
  let!(:squad) { create(:squad, owner: user) }
  let!(:token) { jwt_encode(id: user.id) }
  describe "GET /tasks" do
    it "works! " do
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

  describe "POST /tasks" do
    let!(:task_request) do
      {
        name: "Task",
        squad_id: squad.id
      }
    end

    it "works!" do
      post(tasks_path, headers: { Authorization: "Bearer #{token}" }, params: task_request)
      expect(response).to(be_successful)
    end

    it "should create an task" do
      expect { post(tasks_path, headers: { Authorization: "Bearer #{token}" }, params: task_request) }.to(
        change(Task, :count).by(1)
      )
      expect(response).to(have_http_status(:ok))
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["creator_id"]).to(eql(user.id))
    end

    it "should not create task with params are invalid" do
      modified_request = task_request.merge(name: nil)
      expect { post(tasks_path, headers: { Authorization: "Bearer #{token}" }, params: modified_request) }.to(
        raise_error(StandardError)
      )
    end

    it "should not create if squad doesnt exist" do
      modified_request = task_request.merge(squad_id: "123")
      expect { post(tasks_path, headers: { Authorization: "Bearer #{token}" }, params: modified_request) }.to(
        raise_error(StandardError, "Squad must exist")
      )
    end

    it "should not create if user  doesnt belong to squad" do
      created_user = create(:user)
      created_token = jwt_encode(id: created_user.id)
      expect { post(tasks_path, headers: { Authorization: "Bearer #{created_token}" }, params: task_request) }.to(
        raise_error(StandardError, "User must be in squad")
      )
    end
  end

  describe "DELETE /tasks/id" do
    let(:task) { create(:task, squad: squad, creator: user) }
    it "works!" do
      delete(task_path(task.id), headers: { Authorization: "Bearer #{token}" })
    end

    it "should delete task" do
      delete(task_path(task.id), headers: { Authorization: "Bearer #{token}" })
      expect(Task.find_by(id: task.id)).to(be_nil)
    end

    it "should not delete unexisting task" do
      delete(task_path(123), headers: { Authorization: "Bearer #{token}" })
      expect(response).to_not(be_successful)
    end

    it "should no delete if not owner" do
      created_user = create(:user)
      created_token = jwt_encode(id: created_user.id)
      expect { delete(task_path(task.id), headers: { Authorization: "Bearer #{created_token}" }) }.to(
        raise_error(StandardError, "Incorrect Owner")
      )
    end
  end

  describe "PUT /tasks/id" do
    let(:task) { create(:task, squad: squad, creator: user) }
    it "work" do
      put(task_path(task.id), headers: { Authorization: "Bearer #{token}" }, params: { name: "banena" })
    end

    it "should update task" do
      put(task_path(task.id), headers: { Authorization: "Bearer #{token}" }, params: { name: "banena" })
      task.reload
      expect(task.name).to(eql("banena"))
    end

    it "should not update if user not in squad" do
      created_user = create(:user)
      created_token = jwt_encode(id: created_user.id)
      expect {
        put(task_path(task.id), headers: { Authorization: "Bearer #{created_token}" }, params: { name: "banena" })
      }
        .to(
          raise_error(StandardError, "User must be in squad")
        )
    end

    it "should not update unexting task" do
      put(task_path(123), headers: { Authorization: "Bearer #{token}" }, params: { name: "banena" })
      expect(response).to_not(be_successful)
    end
  end
end
