class Target < ApplicationRecord

  acts_as_mappable :default_units => :kms, :lat_column_name => :latitude, :lng_column_name => :longitude

  belongs_to :user
  belongs_to :topic

  validate :max_targets

  scope :within_range, -> (origin, radius) { within(radius * 0.001, :units => :kms, :origin => origin) }
  scope :not_belonging_to, -> (user_id) { where.not(user_id: user_id) }
  scope :belonging_to, -> (user_id) { where(user_id: user_id) }
  scope :with_topic, -> (topic_id) { where(topic_id: topic_id) }


  after_commit :search_for_compatible_targets, on: [:create, :update]

  def search_for_compatible_targets
    origin = Geokit::LatLng.new(self.latitude, self.longitude)

    # Looks in the database for compatible targets
    compatible_targets = Target.within_range(origin, self.radius).not_belonging_to(self.user_id).with_topic(self.topic_id)

    owners_of_compatible_targets = Array.new

    compatible_targets.each do |t|

      # Checks if already exist a match between two users with a certain topic.
      if !Match.between(t.user_id, self.user_id).about(self.topic_id).any?
        username = t.user.name

        # Creates match
        new_match = Match.create({ user_a_id: self.user_id, user_b_id: t.user_id, topic_id: self.topic_id })

        # Checks if a notification to that user was already sent.
        if !owners_of_compatible_targets.include? username
          owners_of_compatible_targets.push(username)
          create_notification(self.user.name, t.user_id, new_match)
          create_notification(username, self.user_id, new_match)
        end
      end
    end
  end

  def create_notification(username, recipient, match)
    message = 'Start a conversation now with ' + username
    Notification.create({ message: message, recipient: recipient, match: match })
  end

  def max_targets
    count_user_targets = Target.belonging_to(self.user_id).count
    errors.add(:targets, "You can have at most 10 active targets.") if count_user_targets >= 10
  end

end
