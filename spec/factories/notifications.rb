FactoryGirl.define do
  factory :notification do
    message 'Test'
    association :recipient, factory: :user
    association :match, factory: :match
    seen false
  end
end
