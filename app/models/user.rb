class User < ApplicationRecord
  has_many :targets
  has_many :matches
  has_many :messages, :through => :matches

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


end
