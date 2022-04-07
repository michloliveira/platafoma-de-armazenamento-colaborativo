class ApplicationController < ActionController::Base
  
    def render_jsonapi_response(resource)
      if resource.errors.empty?
        render jsonapi: resource
      else
        render json: { message: "Ocorreu um erro"}
      end
    end
  
  end