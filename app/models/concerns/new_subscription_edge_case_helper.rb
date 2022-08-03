module NewSubscriptionEdgeCaseHelper
  def new_edge_case_response
    if new_missing_params
      return render json: ErrorSerializer.format_error(new_error_messages[:new_missing_params]), status: 400
    elsif new_empty_params
      return render json: ErrorSerializer.format_error(new_error_messages[:new_empty_params]), status: 400 
    elsif new_invalid_customer_id
      return render json: ErrorSerializer.format_error(new_error_messages[:new_invalid_customer_id]), status: 400 
    elsif new_invalid_subscription_type
      return render json: ErrorSerializer.format_error(new_error_messages[:new_invalid_subscription_type]), status: 400 
    end
  end

  def new_edge_case_conditions
    new_missing_params || new_empty_params || new_invalid_customer_id || new_invalid_subscription_type
  end

  def new_missing_params
    !params.has_key?(:customer_id) || !params.has_key?(:subscription_type)
  end

  def new_empty_params
    params.values.include?('') || params.values.include?(nil)
  end


  def new_invalid_customer_id
    !Customer.pluck(:id).include?(params[:customer_id])
  end

  def new_invalid_subscription_type
    ![0,1,2].include?(params[:subscription_type])
  end

  def new_error_messages
   {  new_missing_params: 'Both customer_id and subscription_type parameters are required',
      new_empty_params: 'Parameters cannot be empty',
      new_invalid_subscription_type: 'subscription_type must be 0(QTea), 1(plenTea), or 2(thirsTea)',
      new_invalid_customer_id: 'Invalid customer_id'
    }
  end
end