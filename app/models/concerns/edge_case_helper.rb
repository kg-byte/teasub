module EdgeCaseHelper
  def edge_case_response
    if missing_params
      return render json: ErrorSerializer.format_error(error_messages[:missing_params]), status: 400
    elsif empty_params
      return render json: ErrorSerializer.format_error(error_messages[:empty_params]), status: 400 
    elsif invalid_customer_id
      return render json: ErrorSerializer.format_error(error_messages[:invalid_customer_id]), status: 400 
    elsif invalid_subscription_type
      return render json: ErrorSerializer.format_error(error_messages[:invalid_subscription_type]), status: 400 
    end
  end

  def edge_case_conditions
    missing_params || empty_params || invalid_customer_id || invalid_subscription_type
  end

  def missing_params
    !params.has_key?(:customer_id) || !params.has_key?(:subscription_type)
  end

  def empty_params
    params.values.include?('') || params.values.include?(nil)
  end


  def invalid_customer_id
    !Customer.pluck(:id).include?(params[:customer_id])
  end

  def invalid_subscription_type
    ![0,1,2].include?(params[:subscription_type])
  end

  def error_messages
   {  missing_params: 'Both customer_id and subscription_type parameters are required',
      empty_params: 'Parameters cannot be empty',
      invalid_subscription_type: 'subscription_type must be 0(QTea), 1(plenTea), or 2(thirsTea)',
      invalid_customer_id: 'Invalid customer_id'
    }
  end
end