module Api 
  class ApiController < ActionController::API 
    include ActionController::MimeResponds
    include ActionController::HttpAuthentication::Basic
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :authenticate 

    def authenticate 
      unless authenticate_token
        basic_authentication
      end
    end

    def basic_authentication 
      authenticate_or_request_with_http_basic do |username, password|
       @current_user = User.where(username: username, password: password).first
      end
    end

    def authenticate_token 
      authenticate_with_http_token do |token, options| 
        @current_user = User.find_by_auth_token(token)
        @current_user.nil? ? false : true
      end
    end

    def render_unauthorized 
      render json: { error: "Bad credentials" }, status: 401
    end

  end
end 