class Target < ApplicationRecord
  belongs_to :user
  has_one :topic

end
