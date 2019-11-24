class Message < ApplicationRecord
  validates :content, presence: true
  validates :author, presence: true

end
