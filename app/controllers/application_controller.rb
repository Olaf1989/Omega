class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login
  def not_authenticated
    redirect_to login_path, alert: "Log eerst in"
  end

  rescue_from CanCan::AccessDenied do |exception|
  render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => true
  ## to avoid deprecation warnings with Rails 3.2.x (and incidentally using Ruby 1.9.3 hash syntax)
  ## this render call should be:
  # render file: "#{Rails.root}/public/403", formats: [:html], status: 403, layout: false
end
end
