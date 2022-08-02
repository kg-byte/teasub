class TeaFacade
	def self.QTea_selection(subscription_id)
		data = get_tea.sample
		Tea.create(title: data[:name], 
					description: data[:description], 
					temperature: data[:temperature], 
					brew_time: data[:brew_time], 
					subscription_id: subscription_id)
	end

	def self.plenTea_selection(subscription_id)
		data = get_tea.shuffle[0..1]
		data.map do |datum|
			Tea.create(title: datum[:name], 
					description: datum[:description], 
					temperature: datum[:temperature], 
					brew_time: datum[:brew_time], 
					subscription_id: subscription_id)
		end

	end

	# self.thirsTea_selection(subscription_id)


	# end

	def self.get_tea
		data ||= TeaService.get_tea
	end
end