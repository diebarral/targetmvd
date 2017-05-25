class Message < ApplicationRecord
  belongs_to :match
  belongs_to :user, :class_name => 'User', :foreign_key => 'destinatary'

  scope :of_conversation, -> (match_id) { where(match_id: match_id) }

  after_create_commit { MessageRelayJob.perform_later self }
end
