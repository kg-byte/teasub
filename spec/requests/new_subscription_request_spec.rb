require 'rails_helper'

RSpec.describe Subscription, type: :request do
  let!(:user1) { Customer.create(first_name: 'tea', last_name: 'lover', email: 'sample.email.com', address: '123 tea st, Denver, CO 80123') }
  let!(:headers) { {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }}
  describe 'happy path' do
    it 'creates a new QTea subscription' do
      params = {
        "customer_id": user1.id,
        "subscription_type": 0
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

    it 'creates a new plenTea subscription' do
      params = {
        "customer_id": user1.id,
        "subscription_type": 1
      }
      post '/subscriptions', headers: headers, params: JSON.generate(params)
      expect(response).to be_successful
      result = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(result).to be_a(Hash)
      expect(result[:type]).to eq('subscription')
      expect(result[:attributes][:title]).to eq('plenTea')
      expect(result[:attributes][:price]).to eq(19.99)
      expect(result[:attributes][:frequency]).to eq('bi-weekly')
      expect(result[:attributes][:status]).to eq('active')
      expect(result[:attributes][:customer_id]).to eq(user1.id)
      expect(result[:relationships]).to have_key(:tea)
      expect(result[:relationships][:tea][:data].count).to eq(2)
    end

    it 'creates a new thirsTea subscription' do
      params = {
        "customer_id": user1.id,
        "subscription_type": 2
      }
      post '/subscriptions', headers: headers, params: JSON.generate(params)
      expect(response).to be_successful
      result = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(result).to be_a(Hash)
      expect(result[:type]).to eq('subscription')
      expect(result[:attributes][:title]).to eq('thirsTea')
      expect(result[:attributes][:price]).to eq(24.99)
      expect(result[:attributes][:frequency]).to eq('weekly')
      expect(result[:attributes][:status]).to eq('active')
      expect(result[:attributes][:customer_id]).to eq(user1.id)
      expect(result[:relationships]).to have_key(:tea)
      expect(result[:relationships][:tea][:data].count).to eq(4)
    end
  end

  describe 'sad paths' do
    it 'cannot create subscription with missing params' do
      params = {
        "customer_id": '',
        "subscription_type": 0
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
      post '/subscriptions', headers: headers, params: JSON.generate(params)
      
      expect(response.status).to eq(400)
      result = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(result[:error]).to eq('Invalid customer_id')
    end
  end
end
