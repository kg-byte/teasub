module UpdateSubscriptionEdgeCaseHelper
  def update_edge_case_response
    if update_missing_params
      return render json: ErrorSerializer.format_error(update_error_messages[:update_missing_params]), status: 400
    elsif update_empty_params
      return render json: ErrorSerializer.format_error(update_error_messages[:update_empty_params]), status: 400 
    elsif invalid_subscription_id
      return render json: ErrorSerializer.format_error(update_error_messages[:invalid_subscription_id]), status: 400 
    elsif invalid_new_status
      return render json: ErrorSerializer.format_error(update_error_messages[:invalid_new_status]), status: 400 
    end
  end

  def update_edge_case_conditions
    update_missing_params || update_empty_params || invalid_subscription_id || invalid_new_status
  end

  def update_missing_params
    !params.has_key?(:subscription_id) || !params.has_key?(:new_status)
  end

  def update_empty_params
    params.values.include?('') || params.values.include?(nil)
  end


  def invalid_subscription_id
    !Subscription.pluck(:id).include?(params[:subscription_id])
  end

  def invalid_new_status
    !['cancel', 'reactivate'].include?(params[:new_status])
  end


  def update_error_messages
   {  update_missing_params: 'Both subscription_id and new_status parameters are required',
      update_empty_params: 'Parameters cannot be empty',
      invalid_subscription_id: 'Invalid subscription_id',
      invalid_new_status: 'new_status must be cancel or reactivate'
    }
  end
end