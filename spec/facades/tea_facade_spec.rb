require 'rails_helper'


RSpec.describe 'TeaFacade' do 
  	let!(:user1) { Customer.create(first_name: 'tea', last_name: 'lover', email: 'sample.email.com', address: '123 tea st, Denver, CO 80123') }
	let!(:subscription) { Subscription.create(title: 0, price: 0, status: 0, frequency: 0, customer_id: user1.id)}
	
	it 'generates one tea for Qtea selection' do 
		result = TeaFacade.QTea_selection(subscription.id)
		expect(result).to be_a(Tea)
		expect(result.subscription_id).to eq(subscription.id)
	end


	it 'generates two tea for Qtea selection' do 
		result = TeaFacade.plenTea_selection(subscription.id)
		expect(result).to be_an(Array)
		expect(result).to be_an(Array)
		expect(result.count).to eq(2)
		expect(result[0].subscription_id).to eq(subscription.id)
	end

end