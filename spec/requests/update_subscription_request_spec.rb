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
    it 'cancels a subscription' do
      params = {
        "subscription_id": active_sub.id,
        "new_status": 'cancel'
      }
      put '/subscriptions', headers: headers, params: JSON.generate(params)

      result = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(result).to be_a(Hash)
      expect(result[:type]).to eq('subscription')
      expect(result[:attributes][:title]).to eq('QTea')
      expect(result[:attributes][:price]).to eq(14.99)
      expect(result[:attributes][:frequency]).to eq('monthly')
      expect(result[:attributes][:status]).to eq('cancelled')
      expect(result[:attributes][:customer_id]).to eq(user1.id)
    end

    it 'reactivates a subscription' do
      params = {
        "subscription_id": cancelled_sub.id,
        "new_status": 'reactivate'
      }
      put '/subscriptions', headers: headers, params: JSON.generate(params)
   
      result = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(result).to be_a(Hash)
      expect(result[:type]).to eq('subscription')
      expect(result[:attributes][:title]).to eq('plenTea')
      expect(result[:attributes][:price]).to eq(19.99)
      expect(result[:attributes][:frequency]).to eq('bi-weekly')
      expect(result[:attributes][:status]).to eq('active')
      expect(result[:attributes][:customer_id]).to eq(user1.id)
    end

  end

  describe 'sad paths' do
    it 'cannot cancel/reactivate a subscription with missing params' do
      params = {
        "subscription_type": 0
      }
      put '/subscriptions', headers: headers, params: JSON.generate(params)

      expect(response.status).to eq(400)
      result = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(result[:error]).to eq('Both subscription_id and new_status parameters are required')
    end

    it 'cannot cancel/reactivate subscription with empty params' do
      params = {
        "subscription_id": '',
        "new_status": 0
      }
      put '/subscriptions', headers: headers, params: JSON.generate(params)
      
      expect(response.status).to eq(400)
      result = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(result[:error]).to eq('Parameters cannot be empty')
    end

    it 'cannot cancel/reactivate subscription with invalid subscription_id' do
      params = {
        "subscription_id": 0,
        "new_status": 'cancel'
      }
      put '/subscriptions', headers: headers, params: JSON.generate(params)
      
      expect(response.status).to eq(400)
      result = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(result[:error]).to eq('Invalid subscription_id')
    end

    it 'cannot cancel/reactivate subscription with invalid new_status' do
      params = {
        "subscription_id": active_sub.id,
        "new_status": 0
      }
      put '/subscriptions', headers: headers, params: JSON.generate(params)
      
      expect(response.status).to eq(400)
      result = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(result[:error]).to eq('new_status must be cancel or reactivate')
    end

  end
end
