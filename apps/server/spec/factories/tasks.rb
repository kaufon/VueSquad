FactoryBot.define do
  factory(:task) do
    name { "Task do joao" }
    squad
    association(:creator, factory: :user)
    status { 0 }
    size { nil }
    priority { nil }
  end
end
