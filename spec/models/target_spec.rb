require 'rails_helper'

RSpec.describe Target, type: :model do

  let!(:user_a) { User.create({ name: 'user_a', password: 'abc123', email: 'user_a@gmail.com' }) }
  let!(:user_b) { User.create({ name: 'user_b', password: 'abc123', email: 'user_b@gmail.com' }) }
  let!(:user_c) { User.create({ name: 'user_c', password: 'abc123', email: 'user_c@gmail.com' }) }
  let!(:topic_a) { Topic.create({ name: 'topic_a' })}
  let!(:topic_b) { Topic.create({ name: 'topic_b' })}

  describe 'search for compatible targets' do

    context 'finds' do

      it 'one compatible target' do

        target_a = Target.create({ latitude: -34.8965967963032, longitude: -56.1826658248901, radius: 100, user: user_a, topic: topic_a })
        target_b = Target.create({ latitude: -34.8965967963032, longitude: -56.1826658248901, radius: 100, user: user_b, topic: topic_a })

        expect(Notification.count).to eq(2)
      end

      it 'several compatible targets' do

        target_a = Target.create({ latitude: -34.8965967963032, longitude: -56.1826658248901, radius: 100, user: user_a, topic: topic_a })
        target_b = Target.create({ latitude: -34.8965967963032, longitude: -56.1826658248901, radius: 100, user: user_b, topic: topic_a })
        target_c = Target.create({ latitude: -34.8965967963032, longitude: -56.1826658248901, radius: 100, user: user_c, topic: topic_a })

        # The final number of notification is going to be 6. This is because when the first target is created, there are no compatible targets, so 0 notifications. When the second one is
        # created, there is one compatible target, so 2 notifications are created. When the third target is created, there are other two compatibles with it, so it´s two notifications for
        # each match, which means 2*2 = 4 new notifications. 0 + 2 + 4 = 6.

        expect(Notification.count).to eq(6)
      end
    end

    context 'finds nothing' do

      it 'because they are not geographically close' do

        target_a = Target.create({ latitude: 34.8971599713077, longitude: 56.1814212799072, radius: 500, user: user_a, topic: topic_a })
        target_b = Target.create({ latitude: -34.8965967963032, longitude: -56.1826658248901, radius: 100, user: user_b, topic: topic_a })

        expect(Notification.count).to eq(0)
      end

      it 'because they have different topics' do

        target_a = Target.create({ latitude: -34.8971599713077, longitude: -56.1814212799072, radius: 500, user: user_a, topic: topic_a })
        target_b = Target.create({ latitude: -34.8965967963032, longitude: -56.1826658248901, radius: 100, user: user_b, topic: topic_b })

        expect(Notification.count).to eq(0)
      end

      it 'because they don´t belong to different users' do

        target_a = Target.create({ latitude: -34.8971599713077, longitude: -56.1814212799072, radius: 500, user: user_a, topic: topic_a })
        target_b = Target.create({ latitude: -34.8965967963032, longitude: -56.1826658248901, radius: 100, user: user_a, topic: topic_a })

        expect(Notification.count).to eq(0)
      end
    end
  end

  describe 'compatible targets found' do

    let!(:target) { Target.create({ latitude: -34.8971599713077, longitude: -56.1814212799072, radius: 500, user: user_a, topic: topic_a }) }
    let(:match) { FactoryGirl.create(:match, user_a: user_a, user_b: user_b, topic: topic_a) }
    let(:message) { 'Start a conversation now with ' }

    context 'when they belong to one new user' do

      it 'creates a notification' do

        owners_of_compatible_targets = 'user_a'
        message << 'user_a'

        dummy_notification = Notification.create({ message: message, recipient: user_a, match: match })
        test_notification = target.create_notification(owners_of_compatible_targets, user_a, match)

        expect(test_notification.message).to eq(dummy_notification.message)
        expect(test_notification.recipient).to eq(dummy_notification.recipient)
      end
    end
  end

  describe 'number of targets per user validation' do
    let(:user) { FactoryGirl.create(:user) }
    context 'inserting 10 or less targets' do

      it 'inserts 5 targets successfully' do
        expect{ FactoryGirl.create_list(:target, 5, user: user) }.to_not raise_error
      end
      it 'inserts 10 targets successfully' do
        expect{ FactoryGirl.create_list(:target, 10, user: user) }.to_not raise_error
      end
    end

    context 'inserting 11 or more targets' do
      it 'fails at validation when inserting 11 targets' do
        expect{ FactoryGirl.create_list(:target, 11, user: user) }.to raise_error(ActiveRecord::RecordInvalid)
      end
      it 'fails at validation when inserting 20 targets' do
        expect{ FactoryGirl.create_list(:target, 20, user: user) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
