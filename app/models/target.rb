class Target < ApplicationRecord
  acts_as_mappable :default_units => :kms, :lat_column_name => :latitude, :lng_column_name => :longitude
  belongs_to :user
  has_one :topic

  after_commit :search_for_compatible_targets, on: [:create, :update]

  private

  def search_for_compatible_targets

    origin = Geokit::LatLng.new(self.latitude, self.longitude)
    compatibleTargets = Target.within(self.radius * 0.001, :units => :kms, :origin => origin).all.select { |t| t.user_id != self.user_id && t.topic_id == self.topic_id }

    ownersOfCompatibleTargets = Array.new

    compatibleTargets.each do |t|

      # TO DO: create Match object in database, after checking if it doesn´t exist already.
      # If it exists, a notification shouldn´t be sent.

      username = t.user.name

      if not ownersOfCompatibleTargets.include? username
        ownersOfCompatibleTargets.push(username)
        create_notification([self.user.name], t.user_id)
      end

    end

    create_notification(ownersOfCompatibleTargets, self.user_id)

  end

  def create_notification(ownersOfCompatibleTargets, recipient)

    message = 'Start a conversation now with '

    ownersOfCompatibleTargets.each_with_index do |username, i|

      if i == 0
          message << username
      elsif i < ownersOfCompatibleTargets.length - 1
          message << ', ' << username
      else
          message << ' and ' << username
      end
    end

    Notification.create({ message: message, recipient: recipient })
  end
end
