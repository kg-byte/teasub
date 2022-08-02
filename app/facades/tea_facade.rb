class TeaFacade
	def self.QTea_selection(subscription_id)
		data = get_tea.sample
		Tea.create(title: data[:name], 
					description: data[:description], 
					temperature: data[:temperature], 
					brew_time: data[:brew_time], 
					subscription_id: subscription_id)
	end

	# self.plenTea_selection(subscription_id)


	# end

	# self.thirsTea_selection(subscription_id)


	# end

	def self.get_tea
		data ||= TeaService.get_tea
	end
end