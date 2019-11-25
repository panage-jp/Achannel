class Message < ApplicationRecord
  validates :content, presence: true
  validates :author, presence: true
  validates :autho_id, presence: true
  validates :password, presence: true

  belongs_to :room

end
