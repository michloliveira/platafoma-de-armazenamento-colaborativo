class SessionsController < Devise::SessionsController
  def create
    user = User.find_by_email(sign_in_params[:email])
    if user && user.valid_password?(sign_in_params[:password])
      @current_user = user
      render json: { message: "You are logged in" }, status: :ok # mudar aqui para redirecionar para a página incial
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity # lançar erro 
    end
  end
end