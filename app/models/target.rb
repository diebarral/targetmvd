class Target < ApplicationRecord
  acts_as_mappable :default_units => :kms, :lat_column_name => :latitude, :lng_column_name => :longitude
  belongs_to :user
  belongs_to :topic

  scope :within_range, -> (origin, radius) { within(radius * 0.001, :units => :kms, :origin => origin) }
  scope :not_belonging_to, -> (user_id) { where.not(user_id: user_id) }
  scope :with_topic, -> (topic_id) { where(topic_id: topic_id) }

  after_commit :search_for_compatible_targets, on: [:create, :update]

  def search_for_compatible_targets

    origin = Geokit::LatLng.new(self.latitude, self.longitude)
    compatible_targets = Target.within_range(origin, self.radius).not_belonging_to(self.user_id).with_topic(self.topic_id)

    owners_of_compatible_targets = Array.new

    compatible_targets.each do |t|

      # TO DO: create Match object in database, after checking if it doesn´t exist already.
      # If it exists, a notification shouldn´t be sent.

      username = t.user.name

      if !owners_of_compatible_targets.include? username
        owners_of_compatible_targets.push(username)
        create_notification([self.user.name], t.user_id)
      end

    end

    if owners_of_compatible_targets.present?
      create_notification(owners_of_compatible_targets, self.user_id)
    end
  end

  def create_notification(owners_of_compatible_targets, recipient)

    message = 'Start a conversation now with '

    owners_of_compatible_targets.each_with_index do |username, i|
      if i == 0
          message << username
      elsif i < owners_of_compatible_targets.length - 1
          message << ', ' << username
      else
          message << ' and ' << username
      end
    end

    Notification.create({ message: message, recipient: recipient })
  end
end
