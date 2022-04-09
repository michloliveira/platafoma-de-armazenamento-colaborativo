class RegistrationsController < Devise::RegistrationsController


  def create
    build_resource(sign_up_params)
    resource.save
    sign_up(resource_name, resource) if resource.persisted?

    if resource['id'].nil? then 
      render json: { message: 'User not created.' }, status: 400
    else 
      render json: resource, status: 200
    end

  end
end