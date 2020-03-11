class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token, :only => [:create, :login]
    before_action :check_if_current_api_user, :except => [:create, :login]

    def create
        @user = User.new(user_params)
        if @user.save
            update_auth_token(@user)
            render json: { auth_token: @user.auth_token, message: "User created" }, status: :ok
        else
            render json: { error: @user.errors }, status: :unauthorized
        end
    end

    def login
        @user = User.find_by_email(params.require(:email))
        if @user.present?
            if @user &&  @user.authenticate(params[:password])
                update_auth_token(@user)
                render json: { auth_token: @user.auth_token, message: "Successfully Login" }, status: :ok
            else
                render json: {status: false, message: "Invalid email or password."}, status: :unauthorized
            end
        else
          render json: {status: false, message: "User not present"}, status: :unauthorized
        end
      end


    private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def update_auth_token(user)
        user.update_attributes!(auth_token: SecureRandom.urlsafe_base64)
    end
end
