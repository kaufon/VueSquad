FactoryBot.define do
  factory(:task) do
    name { "Task do joao" }
    squad
    association(:creator, factory: :user)
    status { 1 }
    size { 1 }
    priority { 1 }
  end
end
