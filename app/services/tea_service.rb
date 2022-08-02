class TeaService
	def self.get_tea
	  response = Faraday.get("https://tea-api-vic-lo.herokuapp.com/tea")
	  parsed = JSON.parse(response.body, symbolize_names: true)
	end
end