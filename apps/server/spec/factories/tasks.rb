FactoryBot.define do
  factory(:task) do
    name { Faker::Name.name }
    squad
    association(:creator, factory: :user)
    status { 0 }
    size { nil }
    priority { nil }
  end
end
