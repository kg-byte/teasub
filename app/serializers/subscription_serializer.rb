class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :frequency, :status, :customer_id
  has_many :tea
end
