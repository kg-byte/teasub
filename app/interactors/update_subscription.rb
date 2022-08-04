class UpdateSubscription
	include Interactor

	def call
		if valid_subscription_id
			subscription = Subscription.find(context.update_params[:subscription_id])
			result = update_subscription(subscription, context.update_params[:new_status])
			if !result.nil?
				context.subscription = subscription
			else
				context.fail!(error: 'Invalid new_status')
			end
		else 
			context.fail!(error: 'Invalid subscription_id')
		end
	end

	private
	def update_subscription(subscription, new_status)
		if new_status == 'cancel'
			subscription.update(status: 1)
		elsif new_status == 'reactivate'
			subscription.update(status: 0)
		else 
			nil 
		end
	end

	def valid_subscription_id
    	Subscription.pluck(:id).include?(context.update_params[:subscription_id])
	end
end