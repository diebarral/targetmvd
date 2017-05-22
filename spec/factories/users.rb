FactoryGirl.define do
  factory :user do
    sequence(:name, 100) { |n| "Factory User #{n}"}
    gender 'Male'
    sequence(:email, 100) { |n| "factorygirl#{n}@fg.com" }
    password 'abc123'
    password_confirmation 'abc123'
  end
end
