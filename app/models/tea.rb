class Tea < ApplicationRecord
  belongs_to :subscription
  validates_presence_of :title, :description, :temperature, :brew_time
end
