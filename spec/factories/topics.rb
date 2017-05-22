FactoryGirl.define do
  factory :topic do
    sequence(:name, 100) { |n| "Topic #{n}"}
  end
end
