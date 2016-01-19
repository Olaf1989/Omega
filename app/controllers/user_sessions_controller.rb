class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(:home, notice: 'Succesvol ingelogd.')
    else
      flash.now[:notice] = 'Inloggen mislukt.'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:home, notice: 'Uitgelogd.')
  end
end
