class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  
  private
  def current_ability
    @current_ability ||= Ability.new(current_usuario)
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => "No cuenta con los privilegios necesarios para realizar esta acción."
  end
  
end
