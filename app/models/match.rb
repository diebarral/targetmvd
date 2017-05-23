class Match < ApplicationRecord
    belongs_to :topic
    belongs_to :user_a, :class_name => 'User', :foreign_key => 'user_a_id'
    belongs_to :user_b, :class_name => 'User', :foreign_key => 'user_b_id'

    scope :for_user, -> (user_id) { where(user_a_id: user_id).or(where(user_b_id: user_id)) }
end
