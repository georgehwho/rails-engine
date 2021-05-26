class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_search_error
    render json: { error: 'there is an issue lol', data: {} }, status: 400
  end
end
