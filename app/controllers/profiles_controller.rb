class ProfilesController < ApplicationController
  before_action :find_profile, only: [ :edit, :update, :destroy]

  def show
    @profile = current_user.profile
  end

  def update
    if @profile.update(profile_params)
      redirect_to @profile
    else
      render 'edit'
    end
  end

  def destroy
    @profile.destroy
    redirect_to root_path
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :surname, :addr_street, :addr_number, :postcode, :addr_town, :gender, :date_of_birth, :avatar, :fav_color, :phone, :size)
  end

  def find_profile
    @profile = Profile.find(params[:id])
  end

end
