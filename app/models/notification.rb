class Notification < ApplicationRecord
    after_create_commit { NotificationRelayJob.perform_later self }
end
