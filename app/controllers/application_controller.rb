class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: -> { controller_name == 'sessions' && action_name == 'create' }
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user

  private

  def set_user
    cookies[:userid] = (current_user.id if user_signed_in?)  || 'guest'
    cookies[:usertown] = (current_user.profile.addr_town if user_signed_in?)  || 'Breda'
  end


  protected

  def configure_permitted_parameters

    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit( :email, :password, :password_confirmation, :heart, profile_attributes: [ :first_name, :surname, :avatar, :date_of_birth, :addr_street, :addr_street, :postcode, :addr_town, :gender, :fav_color, :phone, :size ] )
    end

  end

end
