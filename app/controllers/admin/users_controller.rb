module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      @users = User.order(:created_at)
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update(admin_params)
        redirect_to admin_users_path, notice: "User updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path, notice: "User deleted successfully."
    end

    private

    def require_admin
      redirect_to root_path, alert: "Access denied." unless current_user.admin?
    end

    def admin_params
      params.require(:user).permit(:admin)
    end
  end
end

