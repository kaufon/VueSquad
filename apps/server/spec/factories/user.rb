FactoryBot.define do
  factory(:user) do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { "123" }
    password_confirmation { "123" }
  end
end
