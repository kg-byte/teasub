class SubscriptionsController < ApplicationController
	def create
		subscription = Subscription.create(customer_id: params[:customer_id],
							title: params[:subscription_type],
							price: params[:subscription_type],
							frequency: params[:subscription_type],
							status:0
							)
		add_tea(subscription.title, subscription.id)
		render json: SubscriptionSerializer.new(subscription)
	end

	def update
	end

	def index
	end

	private
	def add_tea(subscription_type, subscription_id)
		if subscription_type == "QTea"
			TeaFacade.QTea_selection(subscription_id)
		elsif subscription_type == 'plenTea'
			TeaFacade.plenTea_selection(subscription_id)
		elsif subscription_type == 'thirsTea'
			TeaFacade.thirsTea_selection(subscription_id)
		end
	end
end