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
      expect(response).to be_successful
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

  describe 'sad path' do
    it 'cannot create subscription with missing params' do
      params = {
        "customer_id": '',
        "subscription_type": 0
      }
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
      post '/subscriptions', headers: headers, params: JSON.generate(params)

      expect(response.status).to eq(400)
      result = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(result[:error]).to eq('Parameters cannot be empty')
    end

    it 'cannot create subscription with empty params' do
      params = {
        "subscription_type": 0
      }
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
      post '/subscriptions', headers: headers, params: JSON.generate(params)
      
      expect(response.status).to eq(400)
      result = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(result[:error]).to eq('Both customer_id and subscription_type parameters are required')
    end

    it 'cannot create subscription with invalid subscription_type' do
      params = {
        "customer_id": user1.id,
        "subscription_type": 4
      }
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
      post '/subscriptions', headers: headers, params: JSON.generate(params)
      
      expect(response.status).to eq(400)
      result = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(result[:error]).to eq('subscription_type must be 0(QTea), 1(plenTea), or 2(thirsTea)')
    end

    it 'cannot create subscription with invalid customer_id' do
      params = {
        "customer_id": 0,
        "subscription_type": 2
      }
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
      post '/subscriptions', headers: headers, params: JSON.generate(params)
      
      expect(response.status).to eq(400)
      result = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(result[:error]).to eq('Invalid customer_id')
    end
  end
end
