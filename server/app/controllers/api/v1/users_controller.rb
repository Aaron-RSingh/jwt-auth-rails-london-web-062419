class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
    def create
        @user = User.create(user_params)
        if @user.valid?
            render json: {user: UserSerializer.new(@user) }, status: :created
        else
            render json: {error: 'failed to create user'}, status: :not_acceptable
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :password, :bio, :avatar)
    end
end
