require 'rails_helper'

RSpec.describe Subscription, type: :request do
  let!(:user1) { Customer.create(first_name: 'tea', last_name: 'lover', email: 'sample.email.com', address: '123 tea st, Denver, CO 80123') }
  let!(:active_sub) { user1.subscriptions.create(title:0, price: 0, frequency: 0, status:0)}
  let!(:cancelled_sub) { user1.subscriptions.create(title:1, price: 1, frequency: 1, status:1)}
  let!(:headers) { {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }}
  describe 'happy path' do
    it 'gets all subscritions of a user regardless of status' do
      get "/customers/#{user1.id}/subscriptions", headers: headers

      result = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(result).to be_an(Array)
      expect(result.count).to eq(2)
      expect(result[0][:type]).to eq('subscription')
      expect(result[0][:attributes][:status]).to eq('active')
      expect(result[0][:attributes][:customer_id]).to eq(user1.id)
      expect(result[0][:type]).to eq('subscription')
      expect(result[0][:attributes][:customer_id]).to eq(user1.id)
    end

  end

  describe 'sad paths' do
    it 'cannot get customer subscription with invalid customer_id' do
      get "/customers/0/subscriptions", headers: headers

      expect(response.status).to eq(400)
      result = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(result[:error]).to eq('Customer must exist')
    end

  end
end
