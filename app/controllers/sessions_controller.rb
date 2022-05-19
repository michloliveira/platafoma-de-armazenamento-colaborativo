class SessionsController < Devise::SessionsController
  def create
    user = User.find_by_email(sign_in_params[:email])
    if user && user.valid_password?(sign_in_params[:password])
      sign_in user

      redirect_to arquivos_path, jwt_user: user.generate_jwt
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity # lançar erro 
    end
  end


  def delete 
    sign_out user
    render json: { message: "You are logged out" }
  end
end