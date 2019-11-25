class Room < ApplicationRecord
  validates :title, presence: true
  validates :password, presence: true
  has_many :messages

  attr_reader :first_message
  attr_reader :author
end
