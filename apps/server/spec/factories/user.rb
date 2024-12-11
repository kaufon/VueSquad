FactoryBot.define do
  factory(:user) do
    name { "Joao" }
    sequence(:email) { |n| "joao+#{n}@gmail.com" }
    password { "123" }
    password_confirmation { "123" }
  end
end
