class Message < ApplicationRecord
  belongs_to :match
  belongs_to :user

  scope :of_conversation, -> (match_id) { where(match_id: match_id) }
end
