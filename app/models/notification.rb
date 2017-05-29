class Notification < ApplicationRecord
    belongs_to :match

    after_create_commit { NotificationRelayJob.perform_later self }
end
