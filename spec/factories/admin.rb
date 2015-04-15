FactoryGirl.define do
  factory :admin do
    email { Faker::Internet.email }
    password "password"
    username "admin"
#   confirmed_at Date.today
  end
end
