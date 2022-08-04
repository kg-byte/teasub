class CreateSubscription
	include Interactor

	def call
		if valid_subscription_type 
			result = new_subscription(context.create_params[:customer_id], context.create_params[:subscription_type])
			if result.save
				add_tea(result.title, result.id)
				context.subscription = result
			else
				context.fail!(error: result.errors.full_messages.join(','))
			end
		else
			context.fail!(error: 'Invalid subscription_id')
		end
	end

	private
	def new_subscription(customer_id, subscription_type)
		Subscription.create(customer_id: customer_id,
									title: subscription_type,
									price: subscription_type,
									frequency: subscription_type,
									status:0)
	end

	def add_tea(subscription_type, subscription_id)
		if subscription_type == "QTea"
			TeaFacade.QTea_selection(subscription_id)
		elsif subscription_type == 'plenTea'
			TeaFacade.plenTea_selection(subscription_id)
		elsif subscription_type == 'thirsTea'
			TeaFacade.thirsTea_selection(subscription_id)
		end
	end

	def valid_subscription_type
		[0,1,2].include?(context.create_params[:subscription_type])
	end
end