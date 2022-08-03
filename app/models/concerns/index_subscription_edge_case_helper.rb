module IndexSubscriptionEdgeCaseHelper
  def index_edge_case_response
    if index_invalid_customer_id
      return render json: ErrorSerializer.format_error(index_error_messages[:index_invalid_customer_id]), status: 400 
    end
  end

  def index_edge_case_conditions
    index_invalid_customer_id 
  end

  
  def index_invalid_customer_id
    !Customer.pluck(:id).include?(params[:id].to_i)
  end


  def index_error_messages
   { 
      index_invalid_customer_id: 'Invalid customer_id'
    }
  end
end