class AuthenticationController < ApplicationController
  include ActionController::Cookies
  skip_before_action :authenticate_request, only: [ :login ]
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = jwt_encode(id: @user.id)
      render(json: { jwt: token }, status: :ok)
      cookies[:authorization] = { value: token, expires: 1.day.from_now, httponly: true }
    else
      render(json: { error: "Credencias Invalidas" }, status: :unauthorized)
    end
  end

  def logout
    cookies.delete(:authorization)
    render(json: { message: "Logged out sucessfully" })
  end
end
