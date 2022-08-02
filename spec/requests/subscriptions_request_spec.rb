require 'rails_helper'

RSpec.describe Subscription, type: :request do
  let!(:user1) { Customer.create(first_name: 'tea', last_name: 'lover', email: 'sample.email.com', address: '123 tea st, Denver, CO 80123') }

  describe 'happy path' do
    it 'creates a new description' do
      params = {
        "customer_id": user1.id,
        "subscription_type": 0
      }
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
      post '/subscriptions', headers: headers, params: JSON.generate(params)
      result = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(result).to be_a(Hash)
      expect(result[:type]).to eq('subscription')
      expect(result[:attributes][:title]).to eq('QTea')
      expect(result[:attributes][:price]).to eq(14.99)
      expect(result[:attributes][:frequency]).to eq('monthly')
      expect(result[:attributes][:status]).to eq('active')
      expect(result[:attributes][:customer_id]).to eq(user1.id)
      expect(result[:relationships]).to have_key(:tea)
      expect(result[:relationships][:tea][:data].count).to eq(1)

    end
  end
end
