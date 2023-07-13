class ApplicationController < ActionController::API
    #include JWTSessions::RailsAuthorization
    #rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

    before_action :configure_permitted_parameters, if: :devise_controller?
    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
    end

    private
    def not_authorized
      render json: { error: 'Not authorized' }, status: :unauthorized
    end
    
end
