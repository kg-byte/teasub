class SubscriptionsController < ApplicationController
	include NewSubscriptionEdgeCaseHelper
	include UpdateSubscriptionEdgeCaseHelper
	def create
		return new_edge_case_response if new_edge_case_conditions
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
		return update_edge_case_response if update_edge_case_conditions
		subscription = Subscription.find(params[:subscription_id])
		if params[:new_status] == 'cancel'
			subscription.update(status: 1)
		elsif params[:new_status] == 'reactivate'
			subscription.update(status: 0)
		end
		render json: SubscriptionSerializer.new(subscription)
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