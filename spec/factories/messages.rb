FactoryGirl.define do
  factory :message do
    text 'Message text'
    read false
    association :destinatary, factory: :user
    association :match, factory: :match
  end
end
