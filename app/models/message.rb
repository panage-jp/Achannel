class Message < ApplicationRecord
  validates :content, presence: true
  validates :author, presence: true
  validates :autho_id, presence: true

end
