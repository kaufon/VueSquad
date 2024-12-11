FactoryBot.define do
  factory(:squad) do
    name { "Squad do joao" }
    association(:owner, factory: :user)
  end
end
