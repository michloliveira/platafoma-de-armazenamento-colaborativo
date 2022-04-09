class SessionsController < Devise::SessionsController

  private
  
  def respond_with(resource, _opts = {})
    render json: { message: 'You are logged in.' }, status: :ok
  end

  def respond_to_on_destroy
    head :no_content
  end

end
