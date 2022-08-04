class SubscriptionsController < ApplicationController

	def create
		result = CreateSubscription.call(create_params: params)
		if result.success?
			render json: SubscriptionSerializer.new(result.subscription), status: :created
		else
			render json: ErrorSerializer.format_error(result.error), status: 400
		end
	end

	def update
		result = UpdateSubscription.call(update_params: params)
		if result.success?
			render json: SubscriptionSerializer.new(result.subscription), status: 200 
		else
			render json: ErrorSerializer.format_error(result.error), status: 400
		end
	end

	def index
		if valid_customer_id
			render json: SubscriptionSerializer.new(Customer.find(params[:id]).subscriptions)
		else
			render json: ErrorSerializer.format_error('Customer must exist'), status: 400
		end
	end

	private
	def valid_customer_id
		Customer.pluck(:id).include?(params[:id].to_i)
	end
end