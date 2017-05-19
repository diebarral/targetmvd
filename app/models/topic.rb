class Topic < ApplicationRecord
  has_many :targets
  has_many :matches
end
