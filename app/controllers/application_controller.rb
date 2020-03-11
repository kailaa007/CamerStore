class ApplicationController < ActionController::Base

    def check_if_current_api_user
        unless current_api_user
        render json: {status: false, message: 'Auth not available or already logout.' }, status: 401
        end
    end

    def current_api_user
        return @current_user if @current_user
        if auth_token = request.headers['Authorization']
        @current_user = User.where(auth_token: auth_token).first
        end
    end
end
