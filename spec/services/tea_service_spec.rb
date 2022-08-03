require 'rails_helper'

RSpec.describe TeaService do
    it 'gets data for tea api' do
      results = TeaService.get_tea

      expect(results).to be_an Array
      expect(results.count).to eq(12)
      expect(results[0][:name]).to eq("green")
      expect(results[0][:description]).to eq("Rich in antioxidants and reduces inflammation.")
      expect(results[0][:temperature]).to eq(80)
      expect(results[0][:brew_time]).to eq(2)
    end
end