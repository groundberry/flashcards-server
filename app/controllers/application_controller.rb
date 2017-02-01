class ApplicationController < ActionController::API
  def authenticate
    TokiToki.decode(params[:token])
  rescue
    head(:unauthorized)
  end
end
