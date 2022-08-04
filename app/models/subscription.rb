class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :tea, dependent: :destroy
  
  validates_presence_of :status, :title, :price, :frequency
  enum status: {"active" => 0, "cancelled" => 1}
  enum title: {"QTea" => 0, "plenTea" => 1, "thirsTea" => 2}
  enum price: {14.99 => 0, 19.99 => 1,  24.99 => 2}
  enum frequency: {"monthly" => 0, "bi-weekly" => 1, "weekly" => 2}

end
