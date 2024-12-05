class ApplicationController < ActionController::API
  include Pagination
  include JwtWebToken
  before_action :authenticate_request
  private
  def authenticate_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    if header.nil?
      render(json: { Error: "Acesso nao autorizado", status: :unauthorized }, status: :unauthorized)
    else

      decoded = jwt_decode(header)

      @current_user = User.find(decoded[:id])
    end
  end
end
