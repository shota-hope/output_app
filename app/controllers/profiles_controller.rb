class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]
  before_action :block_edit, only: :edit

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @profile.update(profile_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:image, :lastname, :firstname, :website, :intro).merge(user_id: current_user.id)
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def block_edit
    redirect_to root_path unless user_signed_in? && @profile.user.id == current_user.id
  end
end
