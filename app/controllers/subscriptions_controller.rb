class SubscriptionsController < ApplicationController
	include NewSubscriptionEdgeCaseHelper
	include UpdateSubscriptionEdgeCaseHelper
	def create
		return new_edge_case_response if new_edge_case_conditions
		subscription = new_subscription(params[:customer_id], params[:subscription_type])
		add_tea(subscription.title, subscription.id)
		render json: SubscriptionSerializer.new(subscription)
	end

	def update
		return update_edge_case_response if update_edge_case_conditions
		subscription = Subscription.find(params[:subscription_id])
		update_subscription(subscription, params[:new_status])
		render json: SubscriptionSerializer.new(subscription)
	end

	private
	def new_subscription(customer_id, subscription_type)
		Subscription.create(customer_id: customer_id,
									title: subscription_type,
									price: subscription_type,
									frequency: subscription_type,
									status:0
									)
	end

	def update_subscription(subscription, new_status)
		if new_status == 'cancel'
			subscription.update(status: 1)
		elsif new_status == 'reactivate'
			subscription.update(status: 0)
		end
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
end