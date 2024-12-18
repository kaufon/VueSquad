class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [ :login ]
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = jwt_encode(id: @user.id)
      render(json: { jwt: token }, status: :ok)
    else
      render(json: { errorMessage: "Invalid credentials" }, status: :unauthorized)
    end
  end

  def logout
    render(json: { message: "Logged out sucessfully" })
  end
end
