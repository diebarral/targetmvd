FactoryGirl.define do
  factory :match do
    association :user_a, factory: :user
    association :user_b, factory: :user
    topic
  end
end
