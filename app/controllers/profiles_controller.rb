# class ProfilesController < ApplicationController
#   before_action :authenticate_user!

#   def edit
#     @user = current_user
#   end

#   def update
#     @user = current_user
#     if @user.update(profile_params)
#       redirect_to root_path, notice: "Profile updated successfully."
#     else
#       render :edit, status: :unprocessable_entity
#     end
#   end

#   private

#   def profile_params
#     params.require(:user).permit(:name, :bio)
#   end
# end

# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :authenticate_user!  # If using Devise or authentication

  def edit
    @user = current_user
  end

  def update
    if current_user.update(profile_params)
      redirect_to edit_profile_path, notice: "Profile updated successfully."
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :bio, :avatar)
  end
end
