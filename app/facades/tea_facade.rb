class TeaFacade
	def self.QTea_selection(subscription_id)
		data = [get_tea.sample]
		generate_tea(subscription_id, data)
	end

	def self.plenTea_selection(subscription_id)
		data = get_tea.shuffle[0..1]
		generate_tea(subscription_id, data)
	end

	def self.thirsTea_selection(subscription_id)
		data = get_tea.shuffle[0..3]
		generate_tea(subscription_id, data)
	end


	def self.get_tea
		data ||= TeaService.get_tea
	end

	def self.generate_tea(subscription_id, data)
		data.map do |datum|
			Tea.create(title: datum[:name], 
					description: datum[:description], 
					temperature: datum[:temperature], 
					brew_time: datum[:brew_time], 
					subscription_id: subscription_id)
		end
	end
end