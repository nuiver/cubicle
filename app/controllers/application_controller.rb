class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: -> { controller_name == 'sessions' && action_name == 'create' }
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters

    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit( :email, :password, :password_confirmation, profile_attributes: [ :first_name, :surname, :date_of_birth, :addr_street, :addr_street, :postcode, :addr_town, :gender, :fav_color, :phone, :size ] )
    end

  end

end
